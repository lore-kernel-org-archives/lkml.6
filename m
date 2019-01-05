Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68AAC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835BD2133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546727538;
	bh=BM4S7Y1+zFn4EU71Xaj2YruXzHbQubg6+5uXAfuXPqg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XuG8Dq9rxkMVFn3Z7DBR8f2nGAUe36SRDpEpNGvW/j/zFd286cohda0cHHj/XBpzV
	 W3B9x79KBpuCjvmKwlCXNuvVuWRDc5+nC42hqUZ8L+xUkT3wu0l3NnmUlDuuq3eeY0
	 SuncGXooGffWWii1YVWiMTmlJuh5eItZvxDqRiwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfAEWcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfAEWcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:32:15 -0500
Subject: Re: [GIT PULL][PATCH] sh: ftrace: Fix missing parenthesis in WARN_ON()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546726503;
        bh=BM4S7Y1+zFn4EU71Xaj2YruXzHbQubg6+5uXAfuXPqg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZT2QKFpKhU4ZwE7la81tDWHcIYHPungW2CqtJeuFskEbdHsFY2zjDECRs54WVKhVM
         k5YtKWJm4eW+bzh/JyqD/Bywa1NsFhg7yqFkitr9/GZCHiuy+Ga1UQ92YgZhB/Ml1d
         XGwkvRsxeRSa6mDt8VndRhDD8pfdJ5H4PWE/5IsQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190103221857.3458296b@vmware.local.home>
References: <20190103221857.3458296b@vmware.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190103221857.3458296b@vmware.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v4.21-1
X-PR-Tracked-Commit-Id: dc56367cb5dbf9d593e4b12373489df9a7edb72c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a67012412e5a820c44239af9712a1a6037b33fd4
Message-Id: <20190105221503.6651.47214.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 22:15:03 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        kbuild test robot <lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Jan 2019 22:18:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a67012412e5a820c44239af9712a1a6037b33fd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
