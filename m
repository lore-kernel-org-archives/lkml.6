Return-Path: <tkjos@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524671899; cv=none;
        d=google.com; s=arc-20160816;
        b=GQyC1/47ac2JzTdDWb284sL+bxen+pEYLR3v69jpoX5AJYKl7Mr/twdZEw0TV/MrO3
         j89Nux1Qwjzc9x8QXyuvGp1HQoBwVASnZ7c+unfhIn6FQC9+7O+4NjT717BB5WfQyxea
         B5nLoNRu1LODBuIgPcBBEMSpocXOuumElWiQTaXTCCBrOTt8qnWw3KbzacNzF41YJiZl
         eON81vESKUihLw1LHCvw70y1ZPUvllItaIospplL6keyFsZxYLMx0S7Otg/lABps4Ks4
         MfvR10pj7PQttrSzycjSyC5Li7vwEz71k3jcp7EcbX2v39Z18uAcA+LCilmipcPqVq0H
         Tu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=KvvNDTsw0u6a4LVNxf39Jv1LsHNGokHBjHFRLCo7GgY=;
        b=LZlyB5BHodFdt95DheY86W6dCe4vfjAE0hvE7b1qE00jK0hW48BqWFdJG3WXfkYhvs
         fzpImJv+tqQVEnIM+A/ao+J2HBY+gYmkMWiZQd1PExx14iDzUWDIsdF0GsTYgtXQsbn6
         P1jt43YVpw+hA96DjuQq4ZZw+f9CCTzJTUmSL18HEPfIVUaxu9SBwnzh8MnUgAGusvj1
         J/a9H5SzHu8dJLUz2Zsz5N+q70+OmgOD9WRROdRfxCtl4BVMCveZIFpe3LZzsrOwtWbN
         4+MeXUp+UIU09t/W8px06ctuBgfSZy9pmCSHsmkHFpXWrFIVgJzzDYfMRT0qmcLKrbN0
         vblQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=varr/yYX;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=varr/yYX;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZpSH3xS0h3Q+cbNA9286ZzJSJzZ5hO6Mq7orPlwygE61eiyOBai/sIYQzvUqCLPXW6WqBCK+FxIBBfjGC/q/EU=
MIME-Version: 1.0
In-Reply-To: <1523366506-19832-5-git-send-email-geert+renesas@glider.be>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be> <1523366506-19832-5-git-send-email-geert+renesas@glider.be>
From: Todd Kjos <tkjos@android.com>
Date: Wed, 25 Apr 2018 08:58:18 -0700
Message-ID: <CAD0t5oNj5Rgj6tiuwVFegyJiOzV8jsV=OwHHa9USrQLjzLPCgQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: amba: Fix wrong indentation in driver_override_store()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>, Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567255608617?=
X-GMAIL-MSGID: =?utf-8?q?1598734361652555092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Todd Kjos <tkjos@android.com>

On Tue, Apr 10, 2018 at 6:21 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Indentation is one TAB and 7 spaces instead of 2 TABs.
>
> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/amba/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 4a3ac31c07d0ee49..842314a439fdd4eb 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -101,8 +101,8 @@ static ssize_t driver_override_store(struct device *_dev,
>         if (strlen(driver_override)) {
>                 dev->driver_override = driver_override;
>         } else {
> -              kfree(driver_override);
> -              dev->driver_override = NULL;
> +               kfree(driver_override);
> +               dev->driver_override = NULL;
>         }
>         device_unlock(_dev);
>
> --
> 2.7.4
>
