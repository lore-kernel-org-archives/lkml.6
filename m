Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B18C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B016120856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdCOj6Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B016120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeICBJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 21:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeICBI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 21:08:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1365620837;
        Sun,  2 Sep 2018 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535921517;
        bh=xcp8pgtWeLi7KyB1+ZLYwT7jhwTiPYpjVuT07om7xwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BdCOj6JziEihWH35XB4SsCXdiDBV71b7I8Jy31VW1kvdRcvdtKPxuCDkzTMaJ4TRw
         aCbA0RUYWJEqexB6qEjd6DSBEPg2DTovnwYWoQy2dE8g5E1MFCYMGyxaUveLWSO309
         CHZwMku5xDvMnMLhXkD+Y/qrOixQ0wn/t27xN1ys=
Date:   Sun, 2 Sep 2018 21:51:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: add entry for fxas21002c gyro
 driver
Message-ID: <20180902215153.6c02e121@archlinux>
In-Reply-To: <20180830211825.12202-4-afonsobordado@az8.co>
References: <20180830211825.12202-1-afonsobordado@az8.co>
        <20180830211825.12202-4-afonsobordado@az8.co>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 22:18:25 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> Add entry for fxas21002c gyroscope driver and add myself as
> maintainer of this driver.
> 
I'll take a final look at V3, once you have tidied up the
various review comments, but this looks nearly ready to
merge to me.

Thanks,

Jonathan

> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b7b24b145f0..faf5f41b1465 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5838,6 +5838,13 @@ L:	linuxppc-dev@lists.ozlabs.org
>  S:	Maintained
>  F:	drivers/usb/gadget/udc/fsl*
>  
> +FREESCALE FXAS21002C
> +M:	Afonso Bordado <afonsobordado@az8.co>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/gyro/fxas21002.c
> +F:	Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> +
>  FREEVXFS FILESYSTEM
>  M:	Christoph Hellwig <hch@infradead.org>
>  W:	ftp://ftp.openlinux.org/pub/people/hch/vxfs

