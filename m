Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8E921987
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8E921987
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeHHOmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:42:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41268 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:42:08 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AADD7CE7;
        Wed,  8 Aug 2018 12:22:40 +0000 (UTC)
Date:   Wed, 8 Aug 2018 14:22:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/15] staging: fbtft: Includes description to mutex
 and spinlock - Style
Message-ID: <20180808122237.GD20272@kroah.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
 <b7a7e9b7da96d73eddad4553ba1297d9823a61b1.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7a7e9b7da96d73eddad4553ba1297d9823a61b1.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:29:31PM -0300, Leonardo Brás wrote:
>  Includes description to mutex and spinlocks, as recommended by checkpatch.pl.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> index 6ee9ff320567..f771271d497a 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -203,7 +203,7 @@ struct fbtft_par {
>  	u8 *buf;
>  	u8 startbyte;
>  	struct fbtft_ops fbtftops;
> -	spinlock_t dirty_lock;
> +	spinlock_t dirty_lock; /*Protects dirty_lines_{start,end}*/

Why no spaces in your comment?

thanks,

greg k-h
