Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D478DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B8020658
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B8020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJLO5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 10:57:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41782 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeJLO5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 10:57:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7532C207BB; Fri, 12 Oct 2018 09:25:56 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2A66B206A2;
        Fri, 12 Oct 2018 09:25:56 +0200 (CEST)
Date:   Fri, 12 Oct 2018 09:25:55 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Brian Norris <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] mtd: Fix for 4.19-rc8
Message-ID: <20181012092555.7e92d996@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here is a PR containing a fix for a bug introduced in 4.19-rc1.

Regards,

Boris

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-4.19-rc8

for you to fetch changes up to f0fe77f601c3d6a821198f88f7adb0a05b8fe03e:

  lib/bch: fix possible stack overrun (2018-10-12 09:17:46 +0200)

----------------------------------------------------------------
* Fix a stack overflow in lib/bch.c

----------------------------------------------------------------
Arnd Bergmann (1):
      lib/bch: fix possible stack overrun

 lib/Makefile |  1 -
 lib/bch.c    | 17 +++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)


-- 
Boris Brezillon, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
