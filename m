Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D5620675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547573704;
	bh=Sez8PVEc/MvpXWvdep8TI8i4ByHahb0Vg8wU4RL5AuQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C9qQgS09F5+LMwM2J+oj2322mTCO/CgvhlMCO/vFq92FSCYA10XA5rG4QSh8XVXBJ
	 RXliURmodLSkyKL2e+a/2xYszACoXAjesEAAXlWXmJty2QoWNpo93A4G90QJyJKZJ6
	 du2prmYpr42y5qYm9d/uDmZxdK9CzxuCbKJSN21k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfAORfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfAORfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:35:02 -0500
Subject: Re: [GIT PULL] tracing/kprobes: Fix NULL pointer dereference in
 trace_kprobe_create()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547573701;
        bh=Sez8PVEc/MvpXWvdep8TI8i4ByHahb0Vg8wU4RL5AuQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YZ7YQhsjksWqUzMlhAYY/9WyB+YAqdMYs5zpclpTrQOFpRuktTf9FqosceMlzsFL4
         JQaNn6qSbCeuxwf+g/mI2rPRyDF8/+KxOLk1XdE4EsBFy4GpzqTVN/elkcCDrsl7Fh
         zJxSlCTTyWykD4c2e5nRHC9WVWg+Iyi+W1z8Ok8s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190115114138.25c74488@gandalf.local.home>
References: <20190115114138.25c74488@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190115114138.25c74488@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.0-rc1
X-PR-Tracked-Commit-Id: 8b05a3a7503c2a982c9c462eae96cfbd59506783
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7939f8beecf1cfb10d255be65bfbd3793fae82a1
Message-Id: <154757370188.4472.5048180263813066289.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Jan 2019 17:35:01 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Jan 2019 11:41:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7939f8beecf1cfb10d255be65bfbd3793fae82a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
