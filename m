Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E22BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E6D20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E6D20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934213AbeFRLpd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:45:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933381AbeFRLpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:45:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA1A1D0E;
        Mon, 18 Jun 2018 11:45:31 +0000 (UTC)
Date:   Mon, 18 Jun 2018 13:45:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Buddhabhatti <jay.buddhabhatti@softnautics.com>
Cc:     thomas.petazzoni@free-electrons.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Add missing blank line after function
 definition
Message-ID: <20180618114529.GA6421@kroah.com>
References: <1529321261-7727-1-git-send-email-jay.buddhabhatti@softnautics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529321261-7727-1-git-send-email-jay.buddhabhatti@softnautics.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:57:41PM +0530, Jay Buddhabhatti wrote:
> Reslove checkpatch warnings by adding missing blank line after
> function definition.
> 
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@softnautics.com>
> ---
>  drivers/staging/fbtft/fb_s6d1121.c | 1 +
>  drivers/staging/fbtft/fb_ssd1289.c | 1 +
>  drivers/staging/fbtft/fb_st7735r.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_s6d1121.c
> index b902442..b0c7a77 100644
> --- a/drivers/staging/fbtft/fb_s6d1121.c
> +++ b/drivers/staging/fbtft/fb_s6d1121.c
> @@ -154,6 +154,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
>  
>  	return 0;
>  }
> +
>  #undef CURVE
>  
>  static struct fbtft_display display = {

There already is a blank line here, no need to add another one.  Looks
like checkpatch.pl is being a bit too over-eager here, sorry.

thanks,

greg k-h
