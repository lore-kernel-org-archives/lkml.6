Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DCDC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C8C20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C8C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeLAGtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:49:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37971 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLAGtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:49:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 061FE20757; Fri, 30 Nov 2018 20:39:18 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id C13AD20726;
        Fri, 30 Nov 2018 20:39:07 +0100 (CET)
Date:   Fri, 30 Nov 2018 20:39:06 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org (open list:MEMORY TECHNOLOGY DEVICES
        (MTD))
Subject: Re: [PATCH RFC 09/15] mtd: replace **** with a hug
Message-ID: <20181130203906.1af0d88d@bbrezillon>
In-Reply-To: <20181130192737.15053-10-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
        <20181130192737.15053-10-jarkko.sakkinen@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 11:27:18 -0800
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> In order to comply with the CoC, replace **** with a hug.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/mtd/mtd_blkdevs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index b0d44f9214b0..bdf68678fccc 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -565,7 +565,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>  	int ret;
>  
>  	/* Register the notifier if/when the first device type is
> -	   registered, to prevent the link/init ordering from fucking
> +	   registered, to prevent the link/init ordering from hugging
>  	   us over. */

Please rephrase the comment instead of this replacement.

>  	if (!blktrans_notifier.list.next)
>  		register_mtd_user(&blktrans_notifier);

