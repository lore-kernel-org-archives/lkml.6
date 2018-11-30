Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7F7C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A292081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A292081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeK3Uqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:46:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47554 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeK3Uqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:46:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7489420745; Fri, 30 Nov 2018 10:37:48 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1ED2020741;
        Fri, 30 Nov 2018 10:37:48 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtd: nand: Fix memory allocation in nanddev_bbt_init()
Date:   Fri, 30 Nov 2018 10:37:48 +0100
Message-Id: <20181130093748.5475-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 40b412897ccb4b98b2cfb2a0aaabed58dd9e2086
In-Reply-To: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 07:44:52 UTC, Schrempf Frieder wrote:
> Fix the size of the buffer allocated to store the in-memory BBT.
> This bug was previously hidden by a different bug, that was fixed in
> d098093ba06e.
> 
> Fixes: 9c3736a3de21 ("mtd: nand: Add core infrastructure to deal with NAND devices")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to http://git.infradead.org/linux-mtd.git master, thanks.

Boris
