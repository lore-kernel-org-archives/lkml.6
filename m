Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3304BC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029A320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545852050;
	bh=ZtAhmonkLxb4lJQFHEIw/LlSSQs4adWMScCTrwpNNN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=crBACXKNwPtRbC9NVBCbY6p9UBgnmmJFPo9y5UD316CJy7ObhI1OJ3o+WqZ1pQMR/
	 Mn7vx3BezBrH3MEdRZXX8km8I2vb/TG26Ia0xIi1sxxJGzWaWlqf4r9J3Yqn9cUu5g
	 0vL14lh+ALPa2W02UphVJpcig9qe5oJOaUrUeyl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeLZTUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbeLZTUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:20:04 -0500
Subject: Re: [GIT PULL] parisc architecture updates for kernel v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545852003;
        bh=ZtAhmonkLxb4lJQFHEIw/LlSSQs4adWMScCTrwpNNN0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QDZ3ZsUimGycHwBe5USBdEzbSC4pXKzZofL13K+3bshCmTGlDVqU6DTkzoHKmkVD+
         cRK12tBwda1EPmQ1oCD6f42C/brgoapquOjAATRf2iDAGCdsE1BwTouhXr823CPEIh
         BalPFv+VR9oaMeJj023FAZSmKP2aKyoYk1Td4e5Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181226164942.GA19410@ls3530.dellerweb.de>
References: <20181226164942.GA19410@ls3530.dellerweb.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181226164942.GA19410@ls3530.dellerweb.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-4.21-1
X-PR-Tracked-Commit-Id: 930e12992ed32a71048e4bf7abc8939eabcad0d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5f2bd479f58f171a16a9a4f3b4e748ab3057c0f
Message-Id: <20181226192003.20075.30435.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 19:20:03 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Firoz Khan <firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Dec 2018 17:49:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5f2bd479f58f171a16a9a4f3b4e748ab3057c0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
