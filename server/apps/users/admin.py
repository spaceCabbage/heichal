from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin, GroupAdmin as BaseGroupAdmin
from django.contrib.auth.models import Group

from .models import User


@admin.register(User)
class UserAdmin(BaseUserAdmin):
    list_display = (
        "username",
        "hebrew_name",
        "status",
        "shevet",
        "is_cohengadol",
        "is_staff",
        "is_active",
    )
    list_filter = (
        "status",
        "shevet",
        "is_cohengadol",
        "is_staff",
        "is_active",
        "date_joined",
    )
    search_fields = ("username", "hebrew_name", "first_name", "last_name", "email")

    # Override fieldsets to replace superuser with cohengadol
    fieldsets = (
        (None, {"fields": ("username", "password")}),
        ("Personal info", {"fields": ("first_name", "last_name", "email")}),
        (
            "Permissions",
            {
                "fields": (
                    "is_active",
                    "is_staff",
                    "is_cohengadol",
                    "groups",
                    "user_permissions",
                )
            },
        ),
        ("Important dates", {"fields": ("last_login", "date_joined")}),
        (
            "Heichal Information",
            {"fields": ("hebrew_name", "status", "shevet", "phone")},
        ),
    )

    add_fieldsets = BaseUserAdmin.add_fieldsets + (
        (
            "Heichal Information",
            {"fields": ("hebrew_name", "status", "shevet", "is_cohengadol", "phone")},
        ),
    )

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        # Customize field labels
        if "is_cohengadol" in form.base_fields:
            form.base_fields["is_cohengadol"].label = "Cohen Gadol status"
            form.base_fields["is_cohengadol"].help_text = (
                "Designates that this user has all permissions without explicitly assigning them."
            )
        return form


admin.site.unregister(Group)


class GroupAdmin(BaseGroupAdmin):
    pass

Group._meta.app_label = 'users'
admin.site.register(Group, GroupAdmin)
