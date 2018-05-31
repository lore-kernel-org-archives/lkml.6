Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeEaKfm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:35:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45177 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754452AbeEaKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:35:39 -0400
X-Google-Smtp-Source: ADUXVKIh/FNVla3CpPhhHJwcjETdPOEOcXtORX0WaRvTRrcYboIqO/QDvIvechWO92Zl03CvuDWvcSC2NnaeBuFiD5E=
MIME-Version: 1.0
In-Reply-To: <20180522212956.5433-1-jprvita@endlessm.com>
References: <20180522212956.5433-1-jprvita@endlessm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 13:35:38 +0300
Message-ID: <CAHp75VcorKkNiK+0m6cVsT2zccUMqSOibcod0BdobwT76YS4nw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wireless: Fix format specifier
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VAZlbo000994

On Wed, May 23, 2018 at 12:29 AM, João Paulo Rechi Vita
<jprvita@gmail.com> wrote:
> From: João Paulo Rechi Vita <jprvita@gmail.com>
>
> u64 should be printed with %llx instead of %x and cast to uint.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: João Paulo Rechi Vita <jprvita@gmail.com>
> ---
>  drivers/platform/x86/asus-wireless.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
> index f086469ea740..6afd011de9e5 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -72,7 +72,7 @@ static u64 asus_wireless_method(acpi_handle handle, const char *method,
>                 acpi_handle_err(handle,
>                                 "Failed to eval method %s, param %#x (%d)\n",
>                                 method, param, s);
> -       acpi_handle_debug(handle, "%s returned %#x\n", method, (uint) ret);
> +       acpi_handle_debug(handle, "%s returned %#llx\n", method, ret);
>         return ret;
>  }
>
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
