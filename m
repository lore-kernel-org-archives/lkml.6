Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A5FC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D65A20856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfBBRI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:08:58 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46584 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBBRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:08:58 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1C6F39E757C;
        Sat,  2 Feb 2019 17:08:55 +0000 (GMT)
Date:   Sat, 2 Feb 2019 17:08:52 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sps30: remove printk format specifier
Message-ID: <20190202170844.6b8eca21@archlinux>
In-Reply-To: <20190202090003.23225-1-tduszyns@gmail.com>
References: <20190202090003.23225-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Feb 2019 10:00:03 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> pr_fmt is used by printk wrappers. There are not any in the driver
> code so remove the format specifier.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to mostly ignore it.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/sps30.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index 376fac41ecb5..e03a28a67146 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -7,8 +7,6 @@
>   * I2C slave address: 0x69
>   */
> 
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <asm/unaligned.h>
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
> --
> 2.20.1
> 

