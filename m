Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A385206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550888116;
	bh=zQzux7vDHVUW2e3hjGDXINQFlyHH2ikFtLJ8iTv6VNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jA19uiqM7PFzBG6fnz0ItbbUut91dr6L/gdhSDdjMgteo/mh/uc5cZsAiaOJ0hERF
	 DvEuf3cQwm6yZF/tSvzHWVP/BfVr1ZFXS0nXGkjzmsZ8toN7sT7i3R5d90HeWbxPLx
	 PNPhUPJ3VvWWxYfU1lIaOHy3nNAHYHOA/Vca3NqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfBWCPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWCPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 21:15:02 -0500
Subject: Re: [GIT PULL] Power management fixes for final v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550888102;
        bh=zQzux7vDHVUW2e3hjGDXINQFlyHH2ikFtLJ8iTv6VNM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CnDh/z4XMZm1ChDkvXO1rpHFnWLJBchYa6AQKQLLb2AP28TuSFYlpaie2Sw74T7I5
         P2aj5F9WI/cBnjimwKrzWNGdDliz+nRu+iLgnLP9gTPpHchj9PdlzOqYfSv94ICu3g
         9/gPcOaPsg38V0wxcCh4N/VDoIphYcmFVxNRH3QE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i-UVM7BwRgC2cDf93RguVaYxXViLQOACHGPETEM9a7jg@mail.gmail.com>
References: <CAJZ5v0i-UVM7BwRgC2cDf93RguVaYxXViLQOACHGPETEM9a7jg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i-UVM7BwRgC2cDf93RguVaYxXViLQOACHGPETEM9a7jg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.0
X-PR-Tracked-Commit-Id: 5b317cbf2bcb85a1e96ce87717cb991ecab1dd4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef4edb3ed830cbbb443de9906b8cf16dc0653a74
Message-Id: <155088810194.21150.17241848992314103016.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Feb 2019 02:15:01 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Feb 2019 10:42:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef4edb3ed830cbbb443de9906b8cf16dc0653a74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
