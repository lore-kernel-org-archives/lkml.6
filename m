Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CE0C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA9C217D9
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549823405;
	bh=7IuBHLWCUYtUj0/Kgxk+H281+YBt0DR1G/X/dBwGAEM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TUBaX1gU5hLlEVCyJfsXLXdrUuHm2Q1EFWCWi0BrxR8zQwaBp4aNce5QQJ2zYhbTZ
	 yBtK1S4A3sTijt7lU/pf9siJMmAwDLi8r5w19orbakY4mN0lAYZWF8Jc83iK1PHF9a
	 jeeHrAupnqj+bqc0funH2ZnRkYoPR71/HiyHKkzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfBJSaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfBJSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:30:03 -0500
Subject: Re: [GIT PULL] locking fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549823403;
        bh=7IuBHLWCUYtUj0/Kgxk+H281+YBt0DR1G/X/dBwGAEM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zQEr0lOsKN/clv88LCzzrrI+JL+agLewtOpmlkEhmelKwvNz/o9dEyvn+V7+K2a8f
         Inn+k8efrDZz60/3G091xO59psNlGl13nOf4l4hpDN9s465V1yVOmd+X8hHMjIV50m
         y+xVQ1n4mBh0qUuDTgkMgu82bzOpJhZWz8plXh7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190210085331.GA55723@gmail.com>
References: <20190210085331.GA55723@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190210085331.GA55723@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: 1a1fb985f2e2b85ec0d3dc2e519ee48389ec2434
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2a6aae99f5fa2f1e7e400bd2f17c1d42c50312a
Message-Id: <154982340318.26501.1766879151794050013.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Feb 2019 18:30:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Feb 2019 09:53:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2a6aae99f5fa2f1e7e400bd2f17c1d42c50312a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
