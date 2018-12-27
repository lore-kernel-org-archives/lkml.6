Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459AEC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166092190B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545878706;
	bh=5HvW6Wwgglc0ZGA3JzDbBJx/mlMAaPl+nPcmqqpz2cs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Kh28ZdBX4w5rvs/b70iSChnO1T2Iaz2AFaRTj4tIuJH2xfY0OhEy/MssUbQWf0Cn+
	 hyHRzmt9yPDtwjjtPenACXPJB4f44utv2jYjEBfsv6ac8RtD9A0iaJ54oAeqE3XArZ
	 CrV7dKcvCIXYPqviaReCE6Ma9D2QmNZe+ldg0y08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeL0CpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbeL0CpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:45:04 -0500
Subject: Re: [GIT PULL] x86/fpu changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545878704;
        bh=5HvW6Wwgglc0ZGA3JzDbBJx/mlMAaPl+nPcmqqpz2cs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tAnkot03okewnn+70A/isZxD3ddW/SLSqDaG1wJEMajTi44KfozmYT4pM8xC155qu
         CSww0HGD/5ZYmz2WvTmb4jDtislN+yh1463mCe9s2o7GKXIftLu+4Ko+0dAQwJ93Im
         vp9PvVOFxd3R9mCpyAvmZzp8yY1K6S2rGAx67AKw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224230710.GA125684@gmail.com>
References: <20181224230710.GA125684@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224230710.GA125684@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus
X-PR-Tracked-Commit-Id: 12209993e98c5fa1855c467f22a24e3d5b8be205
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6e867a6ae13bc02cd01c535764e5b051d26cf28
Message-Id: <20181227024504.3706.18989.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 02:45:04 +0000
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

The pull request you sent on Tue, 25 Dec 2018 00:07:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6e867a6ae13bc02cd01c535764e5b051d26cf28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
