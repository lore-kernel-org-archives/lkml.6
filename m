Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6512CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E7B2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 14:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zDpiQ5DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E7B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeKZAzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeKZAzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 19:55:40 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B465A20868;
        Sun, 25 Nov 2018 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543154671;
        bh=RVD/86GY+zNguZkyJb0sOxBA2dnHC5mtlfY2ftQO/fM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zDpiQ5DPY50m5CKGnnR1TIMOO9wUGMR0YCvWT+o31qAyGQEmnrlGukl93BETewpiS
         KNnGAFQOQmGP1f9qrk04IIRqCUof4SPVe2E7HUyTPpNESJU73m6oampp+Ad62IS+Qr
         N595SfqUOSSWpGX+/3tgqBarxXgWD0QcstekfHNg=
Date:   Sun, 25 Nov 2018 14:04:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensor-hub: clean up indentation, remove
 extraneous tab
Message-ID: <20181125140427.3082dd3c@archlinux>
In-Reply-To: <20181118162757.26900-1-colin.king@canonical.com>
References: <20181118162757.26900-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018 16:27:57 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The statement is indented too much by one level, fix this by
> removing the extraneous tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied to the togreg branch of iio.git and pushed out as testing
because lots of other stuff in there needs build testing.

thanks,

Jonathan

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index ed3849d6fc6a..b2143d7b4ccb 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -336,7 +336,7 @@ static void adjust_exponent_nano(int *val0, int *val1, int scale0,
>  			scale1 = scale1 % pow_10(8 - i);
>  		}
>  		*val0 += res;
> -			*val1 = scale1 * pow_10(exp);
> +		*val1 = scale1 * pow_10(exp);
>  	} else if (exp < 0) {
>  		exp = abs(exp);
>  		if (exp > 9) {

