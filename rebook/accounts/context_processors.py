from os import getenv


def site_vars(request):
    return {
        "app_name": getenv("APP_NAME"),
        "app_url": f"{getenv('APP_SCHEME')}://{getenv('APP_URL')}:{getenv('APP_PORT')}",
        "app_version": getenv("APP_VERSION"),
    }
