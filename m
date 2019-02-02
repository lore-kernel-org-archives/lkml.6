Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80331C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415992146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549101416;
	bh=dp5JIFpalqwSzZ5XNasiH4z5zbQeHCevCsT5Mu3Veys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e2pL5c1shLRW4y0pewBnWOkRjech6UcCs1ByPsZOHHVwJmHYjYnntFOy2Q0MPJZ4j
	 jyPTOpkWZST5qLFsZN6lsY0fyVO2okVE+P+58pOjDar7QGFYzY/GpJ6d4C4Ci3lpbJ
	 +4FhsuNu7tfEcMY1h48Qii5SDMlnFJJ2c5UdTRFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfBBJ4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfBBJ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:56:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D91204EC;
        Sat,  2 Feb 2019 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549101413;
        bh=dp5JIFpalqwSzZ5XNasiH4z5zbQeHCevCsT5Mu3Veys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XTzff7PYWCqoIlUTXKqlGOiQqgwbKuMmYR+lIFq88uKB+RahJGiZ+O4L5hSSZbepP
         eZ6Oj6ZE3IQA8xEjMDCdnMnm+OEYROKVRiTbnpjqLVLFeYkeyjYk0cmavdjpxD0Go9
         TgfnboObw8qR3pUQuk3oCpiGJqE52od6QiwYNu7I=
Date:   Sat, 2 Feb 2019 09:56:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Camylla Cantanheide <c.cantanheide@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Feulo <guifeulo@gmail.com>
Subject: Re: [PATCH] staging:iio:ad7152: align line to match open
 parenthesis
Message-ID: <20190202095647.489f6a36@archlinux>
In-Reply-To: <1548786660-11935-1-git-send-email-c.cantanheide@gmail.com>
References: <1548786660-11935-1-git-send-email-c.cantanheide@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 16:31:00 -0200
Camylla Cantanheide <c.cantanheide@gmail.com> wrote:

> From: Feulo <guifeulo@gmail.com>
> 
> Align broken line to match upper line parenthesis. Solves the
> checkpatch.pl's message
> 
> CHECK: Alignment should match open parenthesis.
> 
> Signed-off-by: Feulo <guifeulo@gmail.com>
For reference should be full name (though I'm obviously making
assumptions).

Also, this is very unlucky timing as I have a patch sent on 
Wednesday to drop this driver on the basis the part is going away
and we don't know of anyone who actually has hardware.
Given I'm going to apply that in a moment, adding this one would
just be noise.

Sorry.  This happens sometimes in the churn of the kernel!

Jonathan


> Signed-off-by: Camylla Cantanheide <c.cantanheide@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7152.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index 25f51db..e7f082f 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -362,7 +362,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
>  		/* Trigger a single read */
>  		regval |= AD7152_CONF_MODE_SINGLE_CONV;
>  		ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG,
> -				regval);
> +						regval);
>  		if (ret < 0)
>  			goto out;
>  

