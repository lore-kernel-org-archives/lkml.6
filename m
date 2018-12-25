Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F38C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68A321726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780078;
	bh=qfpzcrBBgxa07hzzzinr8D3Ysmrroopfh7mGMmJXtbs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n43tgp3012YM+/O2reuouGirYUZEdUyGXzF/W5WzSz/UMcH+j0/MD5cqSGojJdxTz
	 FiTCZsueGA556bq0dac/PtzQl6ew4IBAyq745FtNQo73Yfx1Ig+9LI1Z6bc+vqrLXa
	 tq7EKX2Uwru9kpKAwbsPbhJ5mZB74AvuPoASUR+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeLYXVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbeLYXUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:06 -0500
Subject: Re: [GIT PULL] Power management updates for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780005;
        bh=qfpzcrBBgxa07hzzzinr8D3Ysmrroopfh7mGMmJXtbs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ka6DC286Rb1pKEJOqXkw2jd9nj3dTLPM8yku1XRGu19b+MCu6YHqUhmNlPQWUdbRU
         DrfHzUgwRWbZSBkfFO4fw6ovou2qamk0dr18aZ2ghYw45J2JrK3xiwE+pEr9FHqs/d
         DA9QdpU+J9vVJTBk3z+CdnmoI05rewGlbxE36NWo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hYQDnPiS=QJ=O2ZjuAJO5RhzS6QPjUa4J92bY6Q++1Hw@mail.gmail.com>
References: <CAJZ5v0hYQDnPiS=QJ=O2ZjuAJO5RhzS6QPjUa4J92bY6Q++1Hw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hYQDnPiS=QJ=O2ZjuAJO5RhzS6QPjUa4J92bY6Q++1Hw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-4.21-rc1
X-PR-Tracked-Commit-Id: a465d38fa3dce6a0dc2d5814cb3aa7b0d2982c6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e2af254ef130e37d9fb3cb1bc9bfbf6ea184b4a
Message-Id: <20181225232005.23808.89680.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 12:06:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e2af254ef130e37d9fb3cb1bc9bfbf6ea184b4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
