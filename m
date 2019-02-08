Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20EFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29DD207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655117;
	bh=JtNrdwlGQr696O16eW30BH9uAr9OxHBXFfBrB+/3oLA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qYsp6uoZsb4ftAvPFYwa4q5czRG+A1O1Tlg7QubZqkYaD2tM7QAMOP4MmNgGdoNG1
	 mATQOT0ZI9545Hy8RmLXpr2Cuytxrd8/60NXzlyf3/5c+rV9/xhmBLRrG8rw3RvkZP
	 EX3HhZgJInYX/jryHGfo84UOcifQhpELaHJdb0t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfBHTpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfBHTpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:06 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655105;
        bh=JtNrdwlGQr696O16eW30BH9uAr9OxHBXFfBrB+/3oLA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DmsX8xtBMPCyvqilL1rrEm/xOmw36k5Hq2DoEDpun6AhF+UWlFScGUin4F1uqEpb0
         sw99LDp0NNaSzjqbwL4Np0KX60fyUdYdI+SvC35H2ap9INHr+DQwPEHPaUgIp0otaQ
         +BHmhtpeR+YV+eL+EUj8QABcxO05p9rIDzHoLTXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208083921.GA27053@kroah.com>
References: <20190208083921.GA27053@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208083921.GA27053@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.0-rc6
X-PR-Tracked-Commit-Id: 4bf13fdbc3567e571c20b415e4df70f564d54067
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 680905431b9de8c7224b15b76b1826a1481cfeaf
Message-Id: <154965510578.5511.11418654059577566923.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Feb 2019 19:45:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 09:39:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/680905431b9de8c7224b15b76b1826a1481cfeaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
