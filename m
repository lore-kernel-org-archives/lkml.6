Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597A9C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2957121929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549730394;
	bh=sCFj2tI/me8T7cBNogJDK1UPZufdOoQMe8Kb/sZiJyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=It31nkYVXeKUhbDVl/6y+We6Ve0EUMkv4vUG0jZ9pyjOiM3fC2r7X8V6z40X1xhe0
	 NyE8e5Yn2NrO3LIKf0ku3lRjRsaAebzNAu89V4Ng/pL/1m2BgR6Msr1HxWijrlQmFO
	 aiV5tZT09tpA8fkXT6N5BgN3g2yNcF7mUmj4NlVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBIQjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:39:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfBIQjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:39:51 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE34C217D8;
        Sat,  9 Feb 2019 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549730390;
        bh=sCFj2tI/me8T7cBNogJDK1UPZufdOoQMe8Kb/sZiJyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jEuBF6dt3nVIhudntcklZCnzgcIFBloRlCWZTv3Y3FBXnnjaEP/BdFjMTy8hLTibn
         pV67vmyIqkPMDgKyzN+gpc3tVZlPBwfI++BohaMBeqa8FCTQOT1pxfc4dN7F1jOo2o
         Nv391MkN5BpiQjMjveeUg4rVoNRg7vWkbYoxW0wc=
Date:   Sat, 9 Feb 2019 16:39:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luciana da Costa Marques <lucianadacostamarques@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] iio:accel:adxl345: Change alignment to match
 paranthesis
Message-ID: <20190209163931.2005248a@archlinux>
In-Reply-To: <20190209122542.4872-1-lucianadacostamarques@gmail.com>
References: <20190209122542.4872-1-lucianadacostamarques@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 10:25:42 -0200
Luciana da Costa Marques <lucianadacostamarques@gmail.com> wrote:

> Align broken line to match upper line parenthesis. Solves the
> checkpatch.pl's message:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Luciana da Costa Marques <lucianadacostamarques@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing
because there are other things in that branch that need checking by
the autobuilders.

Thanks,

Jonathan

> ---
>  changes in v2:
>  - add full name to commit author
> 
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

