Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F84D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546279503;
	bh=i8LdjCcW30C0vLG6w8cp7uWVTEOQNYXNN9U9h3Wspts=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gtSW2u/eVitZN9SMxrmH2ib7+8NDU/K9LSTjF/nhMlMb84FzGxxAQdJCsHhp9ikvt
	 sqa7acSGAqorfvCjqyY1xyFaKiaSpvXzf56kQGmZPKcQWA23beexXFF4ogPaitnRWW
	 k7RY08FmEeVqKMy+rPHh5k/kFIONXdTnWdfxLlfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeLaSFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:05:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeLaSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:05:02 -0500
Subject: Re: [GIT PULL] f2fs-for-4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546279501;
        bh=i8LdjCcW30C0vLG6w8cp7uWVTEOQNYXNN9U9h3Wspts=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HtZh8CIJIWp/RFj3hgIEKk0GzfDL6gb+QA1n33s8wS2eO3HO4UFODhnXD+AUdZ0+o
         sZb+CAVFf/LapZYYG7wcVKtO4Qw75qgXUNxUiNlOdlEyovyaMNBUsKIrK6cRDzFcZu
         UgZaLQ+WDibcx6sWcOImBneuWC/QLsktKSpVc0sA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228212850.GA49768@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181228212850.GA49768@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228212850.GA49768@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-4.21
X-PR-Tracked-Commit-Id: 64beba0558fce7b59e9a8a7afd77290e82a22163
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ab97aea85cca43a6aedc90e0d1feba91eebe1ad
Message-Id: <20181231180501.27307.99106.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 31 Dec 2018 18:05:01 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 13:28:50 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ab97aea85cca43a6aedc90e0d1feba91eebe1ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
