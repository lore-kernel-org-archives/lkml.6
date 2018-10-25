Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F32C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4914420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4914420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJYPsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:48:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35698 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeJYPsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:48:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 500C1208AF; Thu, 25 Oct 2018 09:16:56 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id F3187208C7;
        Thu, 25 Oct 2018 09:16:55 +0200 (CEST)
Date:   Thu, 25 Oct 2018 09:16:53 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH] mtd: rawnand: Add all 1.8V AC chips have a broken
 GET_FEATURES(TIMINGS)
Message-ID: <20181025091653.113a3d6e@bbrezillon>
In-Reply-To: <1540449871-7224-1-git-send-email-masonccyang@mxic.com.tw>
References: <1540449871-7224-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Thu, 25 Oct 2018 14:44:30 +0800
masonccyang@mxic.com.tw wrote:

> From: Mason Yang <masonccyang@mxic.com.tw>
> 
> Hi Boris,
> I patched this for Macronix all 1.8V AC chips.
> Thanks for your review.

No need to add a cover letter when you only have patch.
 
> best regards,
> Mason
> 
> Mason Yang (1):
>   mtd: rawnand: Add All 1.8V AC chips have a broken
>     GET_FEATURES(TIMINGS)
> 
>  drivers/mtd/nand/raw/nand_macronix.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

