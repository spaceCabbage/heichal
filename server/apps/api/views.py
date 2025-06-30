import logging

from django.db import connection
from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

logger = logging.getLogger(__name__)


@extend_schema(
    tags=["System"],
    summary="Health Check",
)
@api_view(["GET"])
@permission_classes([AllowAny])
def health_check(request):
    """
    Health check endpoint that verifies:
    - API is responding
    - Database connectivity
    - Basic system status
    """
    health_status = {
        "status": "healthy",
        "timestamp": None,
        "checks": {"database": "unknown", "api": "healthy"},
    }

    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")
            cursor.fetchone()
        health_status["checks"]["database"] = "healthy"
        logger.info("Health check: Database connection successful")
    except Exception as e:
        health_status["status"] = "unhealthy"
        health_status["checks"]["database"] = f"unhealthy: {str(e)}"
        logger.error(f"Health check: Database connection failed: {str(e)}")

    from django.utils import timezone

    health_status["timestamp"] = timezone.now().isoformat()
    status_code = (
        status.HTTP_200_OK
        if health_status["status"] == "healthy"
        else status.HTTP_503_SERVICE_UNAVAILABLE
    )
    return Response(health_status, status=status_code)


@extend_schema(
    tags=["System"],
    summary="API Info",
    description="Basic API information endpoint",
)
@api_view(["GET"])
@permission_classes([AllowAny])
def api_info(request):
    from django.conf import settings

    return Response(
        {
            "name": "Temple Management API",
            "version": "1.0.0",
            "environment": getattr(settings, "ENVIRONMENT", "unknown"),
            "debug": settings.DEBUG,
            "description": "API for managing Third Temple operations",
        }
    )
