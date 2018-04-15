Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4/FQS+Y8F8ivHf0hHlL4UGd7nOpuzsDRTpmH1wjPQMaX53ieWL6fsHG1/eWEoLbFyguLofE
ARC-Seal: i=1; a=rsa-sha256; t=1523804966; cv=none;
        d=google.com; s=arc-20160816;
        b=eUNe+qwPCrGAG132ziZrY/+viNaRUM2bfqfqZ/Z2mJma+mpImICXAX5AK3jopsWlkR
         LL4ciKOAf3vRfrwLlKbXwFOOb9PST+7IRa014xcnVPKjaschp4y4QaQh3cNaRdvOTu0o
         UbHpfiq7BfX/iSFy+UYIHDdPEEPxbVubvw9lCaleeXSgFBRE/HuNAU5gYw/1UMso/Y8h
         inBJ9jiFErV+pmDS6U6llWx2vf3fGijjdtFlqmHBg0krY4aYcIX0mm58KCFjr78TJFno
         +cIE3DzXNFRmXnGFcejFynWGqnTlsUnkj24xBWV2Xs+7CIxMzIVwHMzGysJiVJ5OCi1e
         p5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=QslRjaKdthbIK0yfzoOGrbJlrlicGff0Nt7Z3hoBtBc=;
        b=KZSA1wKw/4p2GDV+6S+KQ36nmrykt9SZJnRdVTikxdCnVX2ImXB5Ex9KHiGC4jaGO1
         HfYAjcXGr3mK0XHhiRH0CbhyLi6+WcLtKF1k3qszRq9iDoWjT3LRiZlkMbpgL/CRKuXc
         mVUhkJLJA9gBAsdWi8iZbgPW/KjrCESpX8XchPIjrZFk84yiYDtBKt3VWQL2GXvYlRpi
         GTXuP7Kcj7NyKs2YbDGWcvL7NQz2PAAGqASWV/bVnTNIs5he0A74RBkQ/5sFZO7AOjgF
         zIieiVkqkWYtb4zK4yCkHArPIJzdMEFMxwxVnewnB5rQMh88v6CtGDL4x7688d3M46j+
         mvtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF0920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:09:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] staging: iio: ad7746: Reorder includes
 alphabetically
Message-ID: <20180415160920.436ac606@archlinux>
In-Reply-To: <1523637411-8531-6-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-6-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649702624399109?=
X-GMAIL-MSGID: =?utf-8?q?1597825315935459023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:42 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index 82fac76..9ef476a 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -6,15 +6,15 @@
>   * Licensed under the GPL-2.
>   */
> =20
> -#include <linux/interrupt.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/i2c.h>
> -#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/sysfs.h>
> =20
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
