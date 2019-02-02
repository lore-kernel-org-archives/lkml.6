Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE516C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07F2217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549103213;
	bh=CSFPEoqgLpPspj9VReDSbukqAd5xXlrrcx0An4U78SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xnPFBQK2+RHLcDM2y4W4/mMJkZyzt+lxTEQ1nEjlYiweddQtQTCr/Lg7LxhHIUemr
	 Jut7pSRrBncwQjb5s4tzAiPTx9//8G/sYjdQHRZ5kia64Y/8FCzE4z0CNxqzGLv6pn
	 t4rvTY33MaCXGHxFZ5ueo/LsF3pSrX1GJvSzmRh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfBBK0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfBBK0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:26:52 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6933217D6;
        Sat,  2 Feb 2019 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549103211;
        bh=CSFPEoqgLpPspj9VReDSbukqAd5xXlrrcx0An4U78SI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v96qMVdVWHGqSI7oD5+1EqmqfG3L8n17dco7HBin8vas3cQybvDKMtyaXctkNBV2Y
         PURCvkZqxCJo5ELQDSG5A0zJhWvhD/bkwF75lx+I0IBnihVlUAdMlrJr9Ni8/5G25v
         SvxFPrQVxZOQ26lr1pdZ5bATP8Oj6lv8zYRHKgkc=
Date:   Sat, 2 Feb 2019 10:26:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luciana da Costa Marques <lucianadacostamarques@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] iio:accel:adxl345: Change alignment to match
 paranthesis
Message-ID: <20190202102646.23c4aae1@archlinux>
In-Reply-To: <20190131190701.9637-1-lucianadacostamarques@gmail.com>
References: <20190131190701.9637-1-lucianadacostamarques@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 17:07:01 -0200
Luciana da Costa Marques <lucianadacostamarques@gmail.com> wrote:

> From: luciana <lucianadacostamarques@gmail.com>
> 
> Align broken line to match upper line parenthesis. Solves the
> checkpatch.pl's message:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: luciana <lucianadacostamarques@gmail.com>
Full name please, see examples in 
Documentation/process/submitting-patches.rst

> ---
>  drivers/iio/accel/adxl345_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 780f87f72338..f03ed00685ea 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -150,8 +150,8 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int adxl345_write_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int val, int val2, long mask)
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
>  {
>  	struct adxl345_data *data = iio_priv(indio_dev);
>  	s64 n;

