Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03903C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8448218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545878731;
	bh=9YdyoX3yMTC5b32xrJEtt42KWcPosb8O88L/rnrQVWA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pq+ptwKobfqYP8T7I48W5fS48Jr2jBUh1NFK0q7zDEfbH/zY8V94UG7uc2LvGk8lZ
	 at/BdJRfy5KrtWFNM61kAQWJXDmFfiVxzOqEqZxmEhXPdep5jQ5T27LYLOEHueyz+V
	 eUVOhUQsiDIbbyF0hkOv09e5MCcoiPpQpaPsnXYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeL0Cpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbeL0CpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:45:03 -0500
Subject: Re: [GIT PULL] x86/cleanups for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545878703;
        bh=9YdyoX3yMTC5b32xrJEtt42KWcPosb8O88L/rnrQVWA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g1QkR/lX0r/k2jcEus0teJK1SAFAl7huUUJjXLJi/UofvEG7YvXwMWGAk4fk/Rgwa
         k7g81u/T6KiTyuwGKQRDpetlhrcX44/m+uKHSngA1SoTaZ33FYb0ZF8IB+iVwj8fxu
         QX+LnssWMany2Sjuzd/GkzQFCqblFf1OToF6jC/A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224230033.GA65522@gmail.com>
References: <20181224230033.GA65522@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224230033.GA65522@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-for-linus
X-PR-Tracked-Commit-Id: 4b1bacab61aa252d15dde99cd0440a965bd863e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 312a466155108329c458049dc76a21ad56106960
Message-Id: <20181227024503.3706.1628.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 02:45:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Dec 2018 00:00:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/312a466155108329c458049dc76a21ad56106960

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
