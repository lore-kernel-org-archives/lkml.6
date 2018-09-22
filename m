Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C219ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B552821567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yMy/7S8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B552821567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeIVPR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeIVPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:17:26 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AEE2154C;
        Sat, 22 Sep 2018 09:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537608272;
        bh=mKJrdJN0OBFy2WIG8tMsM+aBPcCRWPwWZIhO8L+sN3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yMy/7S8vwfPtfKQDqmS/+LwHZy/zdK2kaBRmkL1RqTlC8jkcTgbnJcof6DeqCJiMf
         UNkybYxWXUuQMpRQ1Y9mYGsjo1eXtwwvdd1efKMBu+U/S28MfjIvBVmt4Gl45X0LyO
         kV6qIEuJqsLs4TFwetPkY8tVsM64TdbtVPAW0VYM=
Date:   Sat, 22 Sep 2018 10:24:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        shubhrajyoti@ti.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Fixed a comment error.
Message-ID: <20180922102428.7c92ccaf@archlinux>
In-Reply-To: <20180920134946.9072-1-songqiang1304521@gmail.com>
References: <20180920134946.9072-1-songqiang1304521@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 21:49:46 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> Replace 'hcm5843' with 'hmc5843'.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore (because there will be other things
in there that they won't later today :)

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/hmc5843.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
> index 76a5d7484d8d..a75224cf99df 100644
> --- a/drivers/iio/magnetometer/hmc5843.h
> +++ b/drivers/iio/magnetometer/hmc5843.h
> @@ -31,7 +31,7 @@ enum hmc5843_ids {
>  };
>  
>  /**
> - * struct hcm5843_data	- device specific data
> + * struct hmc5843_data	- device specific data
>   * @dev:		actual device
>   * @lock:		update and read regmap data
>   * @regmap:		hardware access register maps

