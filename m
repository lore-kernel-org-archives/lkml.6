Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELsgA5ul+GXgrHCZu84MNXhep4GA9jEEZSFJQpM0wm7z1KyzKEW5oHEv/1X8gQOLw+rhPITA
ARC-Seal: i=1; a=rsa-sha256; t=1520091552; cv=none;
        d=google.com; s=arc-20160816;
        b=oDQr9bgTtap3eaHi44r33hKQS7KnXz8oW35zeWezabl0EovgRC3o/OhJX5AZZBy/J/
         Zanz7JuI7HqAJy6HoYbkbKNuLaES7NefMXD4zppNE9wPX+VfwgfGx+AiYm3hwl0Y5ASb
         TpzThrao+l5M2ScWOTQqj/Nkyc1IH742l6nnIO6fkRas59xFBjA9qoiL/qXu9uS+XJDU
         a/+GYL6kJnBs4fi6JpUSVk529ecS7QST+xVXqxsfM2pJCv36fH6rFE3LLKPz3ytzGDpi
         dndnTYb2McaMTNyqohL5qI46KtSX/RpBXyajrqUgUTAYuzsfLs/vLATcTevRZIIrXzNB
         ABlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=A+HeEsWf2yUKjnFyXqjZvlr44/uEJGN0RYVu30NJ674=;
        b=V8Z3yLXiYbbozRLdYQtUbxCAzPuyv0o8Iopowk1Z1dPugDAjLFiAbkaf3trURx/VeO
         SuQHTJQ0Cdlp4ChlqQHxLJX/4Ep1sHzaOit7xDe7mSaQjqO6GwQUyikwU4ZfyCHzDYyI
         GGxvvG8KYrLwZKr+ZZputF94+2SH+7oarc3CL88Dl4zfH+yNrBIwF3VTdaVf9Aae7mWM
         q879udTgiTsP9GYE1f7SiNK1ueYIlPo4YaWVyRFxIItntAJrL2LSa3kfKs4QodwUH+hF
         3zA4xn0MFasrlQP/g/0mF7UcQ0AbAC1A9bbMmkcfVYPU5J0S1zNnv5q2qVY/G+Ks+kOj
         +GPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7ADE2178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:39:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 daniel.baluta@gmail.com
Subject: Re: [PATCH 1/6] Staging: iio: adis16209: Arrange headers in
 alphabetical order
Message-ID: <20180303153907.5b0616c0@archlinux>
In-Reply-To: <ebfbecaba2151b9ec9f1369f42ad43cc7e9fe758.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
	<ebfbecaba2151b9ec9f1369f42ad43cc7e9fe758.1519995673.git.shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593832133026828279?=
X-GMAIL-MSGID: =?utf-8?q?1593931520242634948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri,  2 Mar 2018 18:49:23 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Arrange the headers in alphabetical order for cleanup
> purpose.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
(mostly to test other patches as I'd be really surprised if this one
broke anything :)

Jonathan

> ---
>  drivers/staging/iio/accel/adis16209.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 7fcef9a..58f604d 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -9,11 +9,11 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
