Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3E42089F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550167507;
	bh=LGtAmbozECQ4jYX6RlKIMxYHvvrurxVJybVnDE2fq6Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lhy11R7hN0na14BwjrTFmPPqzLXJm/kjp+Pgbcrs5aEjDgjQa/rlM4auDsioLmcGe
	 oxhPWPUpgeQLJMyZOoesBLcWjQxsBq/LryNpZ8gVJ7btRxn2Elj4u785eXmhQO2A92
	 qek6suSoBmZaBGIPpcwhnvkhyA5bwRtiE05tG3Yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406070AbfBNSFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729857AbfBNSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:05:03 -0500
Subject: Re: [GIT PULL] tracing: probeevent: Correctly update remaining space
 in dynamic area
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550167502;
        bh=LGtAmbozECQ4jYX6RlKIMxYHvvrurxVJybVnDE2fq6Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zBYeb9CSWVsO2t20cKSjf3z98xKT2ntuS3F7OPCLlDnsF34LiEI0Ekz4/upebxVPQ
         UMWCLbiA1mvzBgeVJrUufOJ7ctbTlEAgz4tIz7EymKvVTYsdRKM13ph6BWQL5dliUb
         NBpqiFKEMCIdWVu7a3gun5Qu6INT5BtYpJap50wE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190212210745.50878316@gandalf.local.home>
References: <20190212210745.50878316@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190212210745.50878316@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.0-rc4
X-PR-Tracked-Commit-Id: f6675872db57305fa957021efc788f9983ed3b67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6ea7bcf77831ee5741e903738a19c94715b15e9
Message-Id: <155016750242.30088.3776264645739164736.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Feb 2019 18:05:02 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Feb 2019 21:07:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6ea7bcf77831ee5741e903738a19c94715b15e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
