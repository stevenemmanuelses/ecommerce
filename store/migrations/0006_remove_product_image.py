from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('store', '0005_return_request'),
    ]

    operations = [
        migrations.AddField(
            model_name='product',
            name='image',
            field=models.ImageField(blank=True, null=True, upload_to='product_images/'),
        ),
    ]
