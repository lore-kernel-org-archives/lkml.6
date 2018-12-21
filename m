Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF2A21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545431409;
	bh=dUpA8W0RFyRM6osRGHzDpaI/+O7hiJqklL0bnjqQ4h4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YEtlOb4HahVRGjyRFq0VeqIEhU3+3aatr4SQMswkN3OkVXoODuL5DvvQ4wIbXZR8P
	 Jqdhju6nDoM0BiCYRXe6S5Uut2K4n7jIWCn4N8fVddYxCXi7/NuJ7Srj+pd9V/eogM
	 kPjceNcLZcz71s2+/VK0P1q+RIbv+GySE6nxVhW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392181AbeLUWaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388822AbeLUWaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:30:02 -0500
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545431402;
        bh=dUpA8W0RFyRM6osRGHzDpaI/+O7hiJqklL0bnjqQ4h4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uXd1jIq3I/dfTSK/oshvD+gL9A3QwwJNmI0ZeFkgIXBAmiIAFfkcqOJKJqGH3psgO
         /pGw8u20VlvTDIeQkjj4/Eum5gYTzHo4Zc56byb1xO0d+J4FORMFyEw8AAiz+kdttw
         1VFTuor3tVJjGcjGBtgpE/m1ihgvbJlz6jYBQhcY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221.124243.1852216989215465396.davem@davemloft.net>
References: <20181221.124243.1852216989215465396.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221.124243.1852216989215465396.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
X-PR-Tracked-Commit-Id: d430aff8cd0c57502d873909c184e3b5753f8b88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cafab50eea327e0d198cc9579a60440fc959756
Message-Id: <20181221223002.32045.42857.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 21 Dec 2018 22:30:02 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 12:42:43 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cafab50eea327e0d198cc9579a60440fc959756

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
