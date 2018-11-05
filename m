Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFEBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7207120866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7207120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeKERic convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:38:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55363 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKERib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:38:31 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F1229207CF; Mon,  5 Nov 2018 09:20:00 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id AFDFC2072A;
        Mon,  5 Nov 2018 09:19:50 +0100 (CET)
Date:   Mon, 5 Nov 2018 09:19:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mtd: nand: drop kernel-doc notation for a deleted
 function parameter
Message-ID: <20181105091946.1bd5c854@xps13>
In-Reply-To: <88c00c96-cfd2-4ff1-e753-8875501895df@infradead.org>
References: <88c00c96-cfd2-4ff1-e753-8875501895df@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Subject prefix should be "mtd: rawnand:".

Randy Dunlap <rdunlap@infradead.org> wrote on Sun, 4 Nov 2018 18:38:35
-0800:

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
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
