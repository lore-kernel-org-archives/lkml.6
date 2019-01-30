Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D53821473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548871857;
	bh=xSRGEsjNzHosnCzt5aj9ij0PwFBRMRiYv/EF9uNBnzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kalF5vs1EEvixO/QqStrBlEOYchqH37lsuJ9wJzTUJT8hX6J7Ns6BIwVZ1Jx6hk0X
	 OhNW8LHk3Ao7+OavIdCVEHoVtA+STaii0TwdNSLtD/XdGHdf/Gw5GbIfOy5pJl9C35
	 m88eIYtUKDL5cYV0W/XU6tAY8H5VIYHMj7UFVTsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfA3SKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:10:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfA3SKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:10:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E6720869;
        Wed, 30 Jan 2019 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548871854;
        bh=xSRGEsjNzHosnCzt5aj9ij0PwFBRMRiYv/EF9uNBnzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwgKRO7x0+mFaMjSlkQk/KQZx1+3Vy2AZg3Fz1I9dEZgFJGQHfydLeAq0oJ3n8n85
         PQKUggh8DZdeyIkjB9qIP8DlNOn4wrBfyudq8SOP6tvqYH+FjgVTlqIQpr6rzQ4Suz
         YZs9xXeLn7J6fIRJ9NxhvAyXttXRK4vOh9yEga5o=
Date:   Wed, 30 Jan 2019 19:10:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SandeshKa07 <kas.sandesh@gmail.com>
Cc:     osdevtc@gmail.com, eklikeroomys@gmail.com, omer.efrat@tandemg.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:wlan-ng:cfg80211.c Fixed line more than 80
 characters.
Message-ID: <20190130181052.GA15760@kroah.com>
References: <20190130174538.9189-1-kas.sandesh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130174538.9189-1-kas.sandesh@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:45:38PM +0100, SandeshKa07 wrote:
> From: Sandesh Kenjana Ashok <kas.sandesh@gmail.com>
> 
> Lines over 80 characters are adjusted according to standards
> 
> Signed-off-by: Sandesh Kenjana Ashok <kas.sandesh@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index e5d7def1f366..7687f619ee34 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -373,7 +373,8 @@ static int prism2_scan(struct wiphy *wiphy,
>  			msg2.beaconperiod.data,
>  			ie_buf,
>  			ie_len,
> -			(msg2.signal.data - 65536) * 100, /* Conversion to signed type */
> +			/*Conversion to signed type*/

Please put ' ' in there correctly.

Also, use scripts/get_maintainer.pl to get the right mailing list to
send this to.

thanks,

greg k-h
