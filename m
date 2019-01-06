Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E1C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163F0222CE
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742405;
	bh=5RA82h3OdbbsA0NIzAcZqKjMQE9IISDotwtp6V2HbQ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=crshU2JqUQRT19GSWFWajWe1vL484ScUhGk6IUUv/jTdvAcdTCRL0VSmAEvIv13tG
	 aHibBDno2cSFB5e8gW4fzGOCPG7WMRZ/PAWqfPPejZWWhB3KvMud3cSDAJj7CoLGRQ
	 5fOp4lmccqGuM/RYqklvtqJ7/jchVb0JY4VWUcNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfAFCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfAFCkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:03 -0500
Subject: Re: [GIT PULL] livepatching for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742403;
        bh=5RA82h3OdbbsA0NIzAcZqKjMQE9IISDotwtp6V2HbQ0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tQGEqqFKAhHXOLp2tVqAyVYBoM7pKUyX+qU65uwLQXg93Ucl5ZfvVy92pm7AF+IwL
         T40JHgZErFK5CtuapriXle8sskLPriQhV4LxRZoib1xx0piXbHx+rAZ7ophS6PvPw1
         ej6j78yb9iNHuYUtqHYj1m9rHAYFqLOXAaDr/2E4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1901031236310.14047@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901031236310.14047@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1901031236310.14047@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jikos/livepatching.git
 for-linus
X-PR-Tracked-Commit-Id: 5f30b2e823484ce6a79f2b59901b6351c15effa6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1686cc1a31f45a3fd090e5d0c6fce777422e13fa
Message-Id: <20190106024003.13237.6276.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:03 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Jan 2019 12:39:18 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/jikos/livepatching.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1686cc1a31f45a3fd090e5d0c6fce777422e13fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
