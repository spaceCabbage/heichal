from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    SHEVET_CHOICES = [
        ("reuven", "Reuven"),
        ("shimon", "Shimon"),
        ("levi", "Levi"),
        ("yehuda", "Yehuda"),
        ("yissachar", "Yissachar"),
        ("zevulun", "Zevulun"),
        ("dan", "Dan"),
        ("naftali", "Naftali"),
        ("gad", "Gad"),
        ("asher", "Asher"),
        ("yosef", "Yosef"),
        ("binyamin", "Binyamin"),
    ]

    STATUS_CHOICES = [
        ("cohen", "Cohen"),
        ("levi", "Levi"),
        ("yisrael", "Yisrael"),
    ]

    is_cohengadol = models.BooleanField(default=False, help_text="Cohen Gadol")
    status = models.CharField(
        max_length=10,
        choices=STATUS_CHOICES,
        default="yisrael",
        help_text="Cohen/Levi/Yisrael status",
    )
    shevet = models.CharField(
        max_length=20, choices=SHEVET_CHOICES, blank=True, help_text="Tribe"
    )
    hebrew_name = models.CharField(max_length=100, blank=True, help_text="Hebrew name")
    phone = models.CharField(max_length=20, blank=True)

    @property
    def is_superuser(self):
        """Override is_superuser to use is_cohengadol"""
        return self.is_cohengadol
    
    @is_superuser.setter
    def is_superuser(self, value):
        """Allow setting is_superuser to update is_cohengadol"""
        self.is_cohengadol = value

    def __str__(self):
        if self.hebrew_name:
            return f"{self.hebrew_name} ({self.username})"
        return self.username
