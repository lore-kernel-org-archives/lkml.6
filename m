Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E625C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A02F20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A02F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbeKFIVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:21:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59113 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388116AbeKFIVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:21:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 971E8208C7; Mon,  5 Nov 2018 23:59:05 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5BE1620798;
        Mon,  5 Nov 2018 23:58:30 +0100 (CET)
Date:   Mon, 5 Nov 2018 23:58:30 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mtd: nand: drop kernel-doc notation for a deleted
 function parameter
Message-ID: <20181105235830.6105ebdf@bbrezillon>
In-Reply-To: <88c00c96-cfd2-4ff1-e753-8875501895df@infradead.org>
References: <88c00c96-cfd2-4ff1-e753-8875501895df@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2018 18:38:35 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Remove kernel-doc notation for a deleted function parameter to prevent
> a kernel-doc warning:
> 
> ../drivers/mtd/nand/raw/nand_base.c:603: warning: Excess function parameter 'mtd' description in 'panic_nand_wait'
> 
> Fixes: f1d46942e823 ("mtd: rawnand: Pass a nand_chip object to chip->waitfunc()")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>

Queued to the fixes branch.

Thanks,

Boris

> ---
> 
>  drivers/mtd/nand/raw/nand_base.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- lnx-420-rc1.orig/drivers/mtd/nand/raw/nand_base.c
> +++ lnx-420-rc1/drivers/mtd/nand/raw/nand_base.c
> @@ -590,7 +590,6 @@ retry:
>  
>  /**
>   * panic_nand_wait - [GENERIC] wait until the command is done
> - * @mtd: MTD device structure
>   * @chip: NAND chip structure
>   * @timeo: timeout
>   *
> 
> 

