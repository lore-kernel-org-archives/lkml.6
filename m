Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx49qcxyP1dCfsyf3wDT54KrxFCT0udRQ5wLkipI8+USYD0MPJ+VjOjYzkFS9UYi9sMQY57pv
ARC-Seal: i=1; a=rsa-sha256; t=1522409768; cv=none;
        d=google.com; s=arc-20160816;
        b=hobAmX+Ar6cwxW5F3f0JZ21hl8wFJv2YGopqAksIrReSsAzdxQeKnhHRQSInDaMBLW
         9FKET6YJwIjFrj8aQPXAi23hyraOsJ6ytdxXqG399vGeIbvXPNh/VkgRc40loFVOY1Zz
         S8AQRKTfSyYqa9y1iKSkrstT43fwX5epXpLskNB++I0AYdY/4/aNVdsZv8I/IdVkf3eE
         cFpS/8LQeVI53DqPhREatHs138AElhPh8Qd42uKt7LVSnOJrdReHyOMbdXqNnyLOFrf5
         Rh18d2rf2tXZem9MEwRVsrAZl+WnNtp4qaa/nuN22bgfKobIzTXClVavi9IlKsRgqd3A
         Ujmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=FmNgnXsp/sm87ubwi6t5wshPvbuZgW36U/WTlzdv/AU=;
        b=0I44jTq8cMPep2LzLZzEUGfC5ME98cBgGGt1Ol/0nUUKAAhdc92KHQnbTjldr9UoKo
         /u4ixItq1OK9QuxejDlkFT4NRuKIJ3xmcPUotZjqFR2Im2gBBkMfvp3gw/umHVz4xuen
         Xr8d5bQPOxT8DTkgESvT6cMj+ofi0O+QREC+wggHFngjA35+3HwCt8qW/WkVePHAaYWk
         Z7nXeToOMIm1U5etNrTdRMyzs7UMAQiNGVrcescYJOBjuOITqRfOEt8FK1ziDg3v07vk
         N0U852bPoAEBRK4EfqMUkXAEoxwZh/MtW2jdd6+XVms9z8ZW5UYPCBhPMv5H4P5Kl+oU
         WBUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DE22175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 12:36:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v6 4/6] Staging: iio: adis16209: Remove unused headers
Message-ID: <20180330123602.0907c3d9@archlinux>
In-Reply-To: <52f7695224d2026d03fc5823a8a8c45ab48bbfe9.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
	<52f7695224d2026d03fc5823a8a8c45ab48bbfe9.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596263149708891544?=
X-GMAIL-MSGID: =?utf-8?q?1596362344839199290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 14:49:22 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Remove few unused header files since the adis core handles
> the sysfs and buffer support.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied,

Thanks,

Jonathan

> ---
> 
> Changes in v6
>   -Introduce this new patch in the series.
> 
>  drivers/staging/iio/accel/adis16209.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index ee7e87b..ed6d7c7 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -6,7 +6,6 @@
>   * Licensed under the GPL-2 or later.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -16,8 +15,6 @@
>  #include <linux/sysfs.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
>  #define ADIS16209_STARTUP_DELAY_MS	220
