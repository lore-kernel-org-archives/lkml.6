Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8204FC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F84F20700
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550886304;
	bh=rxkZc0ovQAg51BIpQUuVRfdGY+qqDmDjRiuhy9Q48wE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kA+0OThGGN7K1GCcCPsIjzlub2u4xjiaOovI0MgVFLaf7HpY52lPjsODsXEifFwaN
	 qXXPGXzueap0RPRHjCfgShbXF+bdVuWXGHqcXqtQMF0IkCD6fC9Mw1LOBB25WGwMmF
	 kSaQWs45hgGg2+h84XkfPMdvcwv5b24fClx2eq4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfBWBpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWBpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:45:02 -0500
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550886302;
        bh=rxkZc0ovQAg51BIpQUuVRfdGY+qqDmDjRiuhy9Q48wE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eNF8qwjZtXm2fSg0H4xttdikRlQHU/bGJ1b8IwR9webpXDxzskB4sXnk0WjhMOCl2
         D2eEIDtnw/z0H7e70/hSnNxHwEBvxJENH7ASLqRH3LX7LDpn7AOM8jv9/2kOFP930V
         a2RswZT7RM6a5CiZXInlsH7BQdgoo4hQWr9HIe44=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190222081725.GA10558@ls3530.dellerweb.de>
References: <20190222081725.GA10558@ls3530.dellerweb.de>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190222081725.GA10558@ls3530.dellerweb.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.0-1
X-PR-Tracked-Commit-Id: 71d73a0b43c2b101a960c624290c8a053d174cac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8456e98e18f35f4d4376e8ff3110a3342f81ce9b
Message-Id: <155088630206.27298.4462659079709861790.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Feb 2019 01:45:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Feb 2019 09:17:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8456e98e18f35f4d4376e8ff3110a3342f81ce9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
