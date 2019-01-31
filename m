Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70ECC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D318218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548934318;
	bh=CFNbtJd+HTIcAODO15KHtEXEDRLG5gvGDaSJGKxRtQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=2PV0tz7dgXWjGU0cJqiS+qKeHErIFg2zTOpCSdVVkv9QmzCRBEmMiwf+gfv1ybcaN
	 Snb+/NegdcPIZ6ubBng2r5gf4akAM58ljwM2oaiL1dJDooOQu0M1FAfpeP39BvzpGa
	 ZX4WDHssP53loTsp05rV06wXz0rYVuLcR4AXflqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfAaLb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfAaLb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:31:56 -0500
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E921218AF;
        Thu, 31 Jan 2019 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548934316;
        bh=CFNbtJd+HTIcAODO15KHtEXEDRLG5gvGDaSJGKxRtQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=swMG2U+eYiKpOIJ5IIzZfqxj/JckfF3BCKo3CE9zmVtrVxh2t8AaO/dO3vTbcCrdU
         zN1Kk5gkojHtnjlW2yKPrLLbG8rY1k1KwYa2IuSr4CvgjO6j0pPdLTu+ic42C1ku/7
         gsWkjLTCKbMX5x4U9w78aPqg7FuUvFLcurpn1zWg=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: mtd: nand: fix kernel-doc warnings
Date:   Thu, 31 Jan 2019 12:31:47 +0100
Message-Id: <20190131113147.18826-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b79bbbfec3a0b70f7f5c460ba58458baa499332e
In-Reply-To: <21d5edd7-1335-2731-6d53-5b15d053462c@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 02:21:42 UTC, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings in drivers/mtd/nand/raw:
> 
> ../drivers/mtd/nand/raw/nand_base.c:420: warning: Function parameter or member 'chip' not described in 'nand_fill_oob'
> ../drivers/mtd/nand/raw/nand_bbt.c:173: warning: Function parameter or member 'this' not described in 'read_bbt'
> ../drivers/mtd/nand/raw/nand_bbt.c:173: warning: Excess function parameter 'chip' description in 'read_bbt'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org

Applied to http://git.infradead.org/linux-mtd.git mtd/fixes, thanks.

Boris
