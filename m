Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9573C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B385820652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547229625;
	bh=Dojx5WGvXhCr4UeimgiiRNc/ms109JHwiwNNS1KimJ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fPQzYJPwyXUTxf93uKFHY0VYSdhE7pi1AK8m1sA2kZZksSWwVzyVHkn0cGdVINLkk
	 t6Jclud7BI+SS5X6/dIQWf2cxcv5olBVQWcPM8+9ihefksp3cjlIqwJLvrkOyWX2Yj
	 GSBMbZflK1QDfi+CHDPcXSJOl30x54bpCAMEzJF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389524AbfAKSAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732120AbfAKSAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:00:03 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547229602;
        bh=Dojx5WGvXhCr4UeimgiiRNc/ms109JHwiwNNS1KimJ0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L/zwB3G16lhxH3QEK7Tml1fW1mpU8i0Et6mxG1WkFK0EJ6xcmEjoB7GP1VeKTG/Jk
         pVNiE33HYxDXjzXGb4VsnHGTo9vW+DMoqYn+LeooLwRmqWqpR+CJFH9Z131N38AOkN
         /ND0b3QFHnW6svO/ZuBdJ6QPoFtHUR68cJQNrF78=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190111074418.GA62414@gmail.com>
References: <20190111074418.GA62414@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190111074418.GA62414@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 4e72ee8872279a70ebe973172133b98e8acbf54e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40a31da414c39e3cd8c4137c1ceedf59b7ffd4ce
Message-Id: <154722960292.6916.4519770879322650010.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 18:00:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jan 2019 08:44:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40a31da414c39e3cd8c4137c1ceedf59b7ffd4ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
