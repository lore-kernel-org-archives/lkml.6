Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELu/WdEkOj+rzO068sEJTGFtQPujFWummtyx6wqsTUTqK7FzZ/HlLFzgA5YB8+rr83MZ8Iu9
ARC-Seal: i=1; a=rsa-sha256; t=1520454602; cv=none;
        d=google.com; s=arc-20160816;
        b=NQkK0oZuwUsaM39kSmFAKy2XUGAdt2tKZZ2bxF/vbwZ87/VsCK1jyeWPz4Kfa5b+U6
         a5mL7iD4pjwxT+MCvz6pvW2fhKMb1IOt8FzyqpxNU9MWrjIS4kJG5Qad389lXlnr3ho2
         qVDgB+JsCqXK/ofWpK7ia04VeebRldI7IGI1JWj774ywP406xsxAALvnh1ylJRH+gZQT
         mi65xoTyeYTYYwlDfdbmEPG30sTPxlwP9dFCrcrgYhV0iqt5oW9cxlYtWGHZzzv/9TMB
         VlWMSDTM3NT/hb8aUovsla/tEyMgIIP2EwKA0azFRzY2U6ePgIwJrFudBut1O/j5tO6x
         GqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=ziL0IB54xcIm0my6F/5xMyjI7iNegtoBiTZvc8V7zZo=;
        b=ROU/myppU5GPARkPA9cLdy2AzipQA1n9jkk6V+naRqKUd6EXj42cFoajEyzc9QtGyt
         EqvW2dc9PoC31shZLj56o/DpvEZRUL2dZTGhRXg6mVAELc/ESITNK4mePF3SHmksn1fu
         caLxz/ZzTRXXkenxd6T/X6xUsBpkeIFSuIQxg7cqDneBdKuX2eG4NUGbvJgSq7/KeU0T
         7cH37r9eAFWk7fgI465rBlTXfq8Zvg9H1sQ7jupwbhTHVcq2iHujwtrSlb3bKjaK9bKM
         LrJ+uLPhYw6N/S64vHXe5L4b4WdbgMV3qqsIhlZdKvIOhzzvlbrzWL1DkTTF9Ghk7ZlH
         p9dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD2A2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:29:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 daniel.baluta@gmail.com
Subject: Re: [PATCH 01/11] Staging: iio: accel: Prefer alphabetical sequence
 of header files
Message-ID: <20180307202957.4fa33eb0@archlinux>
In-Reply-To: <1520236170-14668-2-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
	<1520236170-14668-2-git-send-email-himanshujha199640@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594083187913405658?=
X-GMAIL-MSGID: =?utf-8?q?1594312205104787009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  5 Mar 2018 13:19:20 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Arrange header files in alphabetical sequence to improve readability.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
One general comment - when naming a patch it will form the description
in the git short log or on the various web interfaces etc. It's 
really useful to actually say which driver it is.

I've fixed that up by adding adis16201: in the appropriate place.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16201.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 2ebd275..0f6a204 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -7,13 +7,13 @@
>   */
>  
>  #include <linux/delay.h>
> -#include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
> -#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
