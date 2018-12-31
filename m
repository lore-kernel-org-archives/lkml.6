Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E11C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A531F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546279505;
	bh=AQ/k8fS0BF+xG9YnhzZAWiIyzx2qBG3SkYejZ91gOow=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tUEHwqsrfpkYsQk5dPMlvyOKS+un3iw1g74Vvpb6hGim8OL4uYh+ud9776MGj1IAV
	 arCly6O0n0PWe6439ZrZccucgdj0YzAZPYgtgzvEtK7ItcCEnasStjHIsHgVFshD6p
	 RTidfl/8rw6WL6S4uBv2Zl56NJ7+UEUO0mqyMDK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeLaSFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbeLaSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:05:03 -0500
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546279503;
        bh=AQ/k8fS0BF+xG9YnhzZAWiIyzx2qBG3SkYejZ91gOow=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sZASunPCIjxqgIjxF11rBDzjF9ztNaf9nnnf1A4P1euAS3qGz2si3MMcNEcug4tRL
         QCn7dW2xdAlaxp5iL26KoKtWCdNcWsW4ozES0Au52kc9Y/mNX+v7x4RBliDwUjt2Fm
         2mtxoHG/qhKph06DZtGV9w9CQQI5bNgkT4EIe8Hk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231145827.GA83750@gmail.com>
References: <20181231145827.GA83750@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231145827.GA83750@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: c40f7d74c741a907cfaeb73a7697081881c497d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3ed513bcf0097c0b8a1f1b4d791a8d0d8933b3b
Message-Id: <20181231180503.27307.52860.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 31 Dec 2018 18:05:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 15:58:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3ed513bcf0097c0b8a1f1b4d791a8d0d8933b3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
