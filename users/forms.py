from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import get_user_model


class UserRegistrationForm(UserCreationForm):
    email = forms.EmailField(help_text='A valid email address, please', required=True)

    class Meta:
        model = get_user_model()
        fields = ['username', 'email', 'password1', 'password2']

    def save(self, commit=True):
        user = super(UserRegistrationForm, self).save(commit=False)
        user.email = self.cleaned_data['email']
        if commit:
            user.save()

        return user

from allauth.socialaccount.forms import SignupForm
from django import forms
from django.core.exceptions import ValidationError
from django.contrib.auth import get_user_model

User = get_user_model()

class CustomSocialSignupForm(SignupForm):
    username = forms.CharField(
        label="Username",
        max_length=150,
        required=True,
        help_text="Required. 150 characters or fewer. Letters, digits, and @/./+/-/_ only.",
    )
    email = forms.EmailField(
        label="Email",
        disabled=True,  # Make the email field read-only
        required=False,  # The email is already provided by the social provider
    )

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Pre-fill the email field with the email from the social provider
        if 'email' in self.sociallogin.account.extra_data:
            self.fields['email'].initial = self.sociallogin.account.extra_data['email']
        else:
            raise ValidationError("The social provider did not provide an email address. Please use a different signup method.")

    def clean_email(self):
        email = self.cleaned_data.get('email')
        if not email:
            raise ValidationError("Email is required.")
        return email

    def clean_username(self):
        username = self.cleaned_data['username']
        if User.objects.filter(username=username).exists():
            raise ValidationError("A user with that username already exists.")
        return username

    def save(self, request):
        user = super().save(request)
        user.username = self.cleaned_data['username']
        user.save()
        return user