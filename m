Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61115C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3207120818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549527020;
	bh=mzMP0GBEir18AplMFTjDAcK4kEnepxS+/a5onItr0DM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J56o2VXH2zK+LOnRvuScvyfr68RYF59IZXAG9Lz79JSQWzPLRdUufXjnUSUoNgfTB
	 m+c+Y8K8CI0UrT1UeUgzSNWvKIUVKfpVKMBAqc8AwCNsPBNcVFXrZLsX0nwCTTlKtu
	 v7Oovyd2iyAn1GaE8gp0PlJ/7rIadUf6EcoKdeDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBGIKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfBGIKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:10:05 -0500
Subject: Re: [GIT PULL] tracing: Small fixes to the uprobe code
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549527004;
        bh=mzMP0GBEir18AplMFTjDAcK4kEnepxS+/a5onItr0DM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=alCYyKZ5UGDIFodL3P6mSGzyF4JrFnswERTYQt1+8H45hG3qUMYGG/Ab1Rlk5FSOE
         l3JdIh3OcQHq3m5uOhbOuk6l9miMDsDPaM7fd2LN1B3AcGDsRuqNuivEI+8aagRdv5
         qdK9gIfp2AsdXufvwKU9XEK7slaohAKzREWMVeUA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190206114300.44ee1d49@gandalf.local.home>
References: <20190206114300.44ee1d49@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190206114300.44ee1d49@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.0-rc3
X-PR-Tracked-Commit-Id: 0722069a5374b904ec1a67f91249f90e1cfae259
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4879f11615d29d7b91cd5a4cfbff8e563ada991d
Message-Id: <154952700468.18479.13187318743963556574.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 08:10:04 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Feb 2019 11:43:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4879f11615d29d7b91cd5a4cfbff8e563ada991d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
