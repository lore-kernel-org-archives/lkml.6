Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB96DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9B320663
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9B320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLAIKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbeLAIKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:10:36 -0500
Subject: Re: [GIT PULL] mtd: Fixes for 4.20-rc5
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4964D2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181130105829.0bbefe10@bbrezillon>
References: <20181130105829.0bbefe10@bbrezillon>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181130105829.0bbefe10@bbrezillon>
X-PR-Tracked-Remote: git://git.infradead.org/linux-mtd.git
 tags/mtd/fixes-for-4.20-rc5
X-PR-Tracked-Commit-Id: 40b412897ccb4b98b2cfb2a0aaabed58dd9e2086
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da59f180d529fc78591e71acf2c67114b8eff10d
Message-Id: <20181130210003.10596.30491.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 30 Nov 2018 21:00:03 +0000
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Vasut <marex@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Nov 2018 10:58:29 +0100:

> git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-4.20-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da59f180d529fc78591e71acf2c67114b8eff10d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
