Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB98C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BBD21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545420608;
	bh=KNGwk77R2kZ2fEyBz7PcJRBnl8OpKh4ujOvjyd3EUR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lAfndfloTcys6cHXtMs0CoWyue1NU+FfXPjs4MI4Wl2/6xEr663oJf7cR/TeOStnu
	 EceEKL972rG4XGMRKGVcPxh8WGZJ54MVT1jalEEZ5TAcLvyb2Nupxsjg8LNIleFsQA
	 d8O25Onod7xsBkkAPBCDlFGZ7ByAaOIpv/S3cTu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404569AbeLUTaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404540AbeLUTaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:30:03 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545420603;
        bh=KNGwk77R2kZ2fEyBz7PcJRBnl8OpKh4ujOvjyd3EUR8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J+Bv967uOqJ8NpE4ucPNkOCSiczj/tjL+huAZE5Jss2zO5mh1hqc5S3P4h0I19+Lr
         RYMExoZSrrYRXq1eYM5bae5bVb1lfi76xLrqwhK73cDMDvxmy5XZmwXwATJFJdGrkD
         bquR0x8+Ur+cFxhOIKwLQD+VRBtpynRiPmIydG0s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221122545.GA59955@gmail.com>
References: <20181221122545.GA59955@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221122545.GA59955@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 6ac389346e6964e1f6a1c675cebf8bd0912526a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70ad6368e878857db315788dab36817aa992c86a
Message-Id: <20181221193003.15695.56656.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 21 Dec 2018 19:30:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 13:25:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70ad6368e878857db315788dab36817aa992c86a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
