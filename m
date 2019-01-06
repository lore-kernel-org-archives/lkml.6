Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC04C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D52222A9
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742437;
	bh=2gszZ8ttkz6ZLc39JRPFFRK88quGU8JhW0YLmiqPamI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NhJlNzpW6KixllnLY6WLHovLR+82m4jOqe4ZHeIpOLTDWDuq3ItgmZcS+OtgSKstW
	 1V4QvMfHj4Kea6wwMBd2v0RUS5O8/XH93wOg+mw+vtxPzwWi4sLaKLp9RjME5MkV2x
	 kAgnRjeSMZRpp/xZEjXfS7PMO52oLQ3wHGtUtoMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfAFCkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfAFCkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:05 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742405;
        bh=2gszZ8ttkz6ZLc39JRPFFRK88quGU8JhW0YLmiqPamI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1ee3PmSn/EGE7uq8WoqfI6RAfRYrncinktVeX2RyT0tSi/xiCRTG59BAopwW3PqNO
         GH7gO5ccpNcEU/PPC2PrDAc/BshDQsxlndYEwija4mf+0SZjPYpOO2/q24ZBfBR1Bz
         FH4ajNzF0pPKBYl5Tdy2w4nBmGvDpG/1DY5IQNiQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104050001.GA26256@ziepe.ca>
References: <20190104050001.GA26256@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104050001.GA26256@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 9c6260de505b63638dd86fcc33849b17f6146d94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3954e1d0310e30e743431b58918825c4d4fe8812
Message-Id: <20190106024005.13237.95467.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:05 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 05:00:10 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3954e1d0310e30e743431b58918825c4d4fe8812

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
