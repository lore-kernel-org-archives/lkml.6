Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84CC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87C020663
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87C020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeLAIKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAIKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:10:36 -0500
Subject: Re: [GIT PULL] perf fixes
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E8521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181130062507.GA77228@gmail.com>
References: <20181130062507.GA77228@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181130062507.GA77228@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 09d3f015d1e1b4fee7e9bbdcf54201d239393391
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1b3cf6d943800059adc262c4d839524c529db2d
Message-Id: <20181130210002.10596.88360.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 30 Nov 2018 21:00:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Nov 2018 07:25:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1b3cf6d943800059adc262c4d839524c529db2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
