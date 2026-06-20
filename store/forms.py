import json
from pathlib import Path

from django import forms
from django.contrib.auth import get_user_model
from django.contrib.auth.forms import UserCreationForm
from .models import Product, Category, UserProfile

User = get_user_model()

REGION_DATA_PATH = Path(__file__).resolve().parents[1] / 'static' / 'data' / 'indonesia_regions.json'
with open(REGION_DATA_PATH, encoding='utf-8') as f:
    _INDONESIA_REGION_DATA = json.load(f)

PROVINCE_CHOICES = [('', 'Pilih Provinsi')]
REGENCY_CHOICES = {}
for key in sorted(_INDONESIA_REGION_DATA, key=int):
    for province_name, regencies in _INDONESIA_REGION_DATA[key].items():
        PROVINCE_CHOICES.append((province_name, province_name))
        REGENCY_CHOICES[province_name] = [(reg, reg) for reg in regencies]

class CustomUserCreationForm(UserCreationForm):
    email = forms.EmailField(required=True, label='Email')
    phone_number = forms.CharField(required=True, max_length=20, label='Nomor Telepon')
    address_line = forms.CharField(
        required=True,
        widget=forms.Textarea(attrs={'rows': 3}),
        label='Alamat Lengkap'
    )
    province = forms.ChoiceField(choices=PROVINCE_CHOICES, label='Provinsi', required=True)
    regency = forms.ChoiceField(choices=[('', 'Pilih Kabupaten/Kota')], label='Kabupaten/Kota', required=True)
    postal_code = forms.CharField(required=False, max_length=20, label='Kode Pos')

    class Meta(UserCreationForm.Meta):
        model = User
        fields = (
            'username',
            'email',
            'password1',
            'password2',
            'phone_number',
            'address_line',
            'province',
            'regency',
            'postal_code',
        )

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        province = self.data.get('province') if self.data else self.initial.get('province')
        if province in REGENCY_CHOICES:
            self.fields['regency'].choices = [('', 'Pilih Kabupaten/Kota')] + REGENCY_CHOICES[province]
        else:
            self.fields['regency'].choices = [('', 'Pilih Kabupaten/Kota')]

    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data['email']
        if commit:
            user.save()
            UserProfile.objects.create(
                user=user,
                phone_number=self.cleaned_data['phone_number'],
                address_line=self.cleaned_data['address_line'],
                province=self.cleaned_data.get('province', ''),
                regency=self.cleaned_data.get('regency', ''),
                postal_code=self.cleaned_data.get('postal_code', ''),
            )
        return user


class CheckoutAddressForm(forms.ModelForm):
    province = forms.ChoiceField(choices=PROVINCE_CHOICES, label='Provinsi', required=True)
    regency = forms.ChoiceField(choices=[('', 'Pilih Kabupaten/Kota')], label='Kabupaten/Kota', required=True)

    class Meta:
        model = UserProfile
        fields = ['phone_number', 'address_line', 'province', 'regency', 'postal_code']
        widgets = {
            'address_line': forms.Textarea(attrs={'rows': 3}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        province = self.data.get('province') if self.data else self.initial.get('province')
        if province in REGENCY_CHOICES:
            self.fields['regency'].choices = [('', 'Pilih Kabupaten/Kota')] + REGENCY_CHOICES[province]
        else:
            self.fields['regency'].choices = [('', 'Pilih Kabupaten/Kota')]


class AccountProfileForm(forms.ModelForm):
    email = forms.EmailField(required=True, label='Email')

    class Meta:
        model = UserProfile
        fields = ['phone_number', 'address_line', 'province', 'regency', 'postal_code']
        widgets = {
            'address_line': forms.Textarea(attrs={'rows': 3}),
        }

    def __init__(self, *args, user=None, **kwargs):
        self.user = user
        super().__init__(*args, **kwargs)
        if self.user is not None:
            self.fields['email'].initial = self.user.email
        province = self.data.get('province') if self.data else self.initial.get('province')
        if province in REGENCY_CHOICES:
            self.fields['regency'].choices = [('', 'Pilih Kabupaten/Kota')] + REGENCY_CHOICES[province]
        else:
            self.fields['regency'].choices = [('', 'Pilih Kabupaten/Kota')]

    def save(self, commit=True):
        profile = super().save(commit=False)
        if self.user is not None:
            self.user.email = self.cleaned_data['email']
            if commit:
                self.user.save()
        profile.user = self.user
        if commit:
            profile.save()
        return profile


class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = ['category', 'name', 'slug', 'description', 'price', 'stock', 'image', 'image_url']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4}),
        }
