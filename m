Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85799C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E492084C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548609926;
	bh=KInEwGIQPLfHiKHcIAQh1waE7lMUxZFh5rhtErNwnB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e87JN877MhaSfrBgBQmPgZRVp2jGziZsGueqFmN4UMVGtnGQ+NPEknx4zNCZgSst4
	 o3VS9tENfmCpvSqeerw2qXXUycuOci06Ix9F34H2ZUoSQM4G/bLJ1k2N/tDosM4djV
	 q+CijqLp7e3TuQSpFQBWWT1BlFwYRM5YCem/hCnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfA0RZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfA0RZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:25:04 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548609903;
        bh=KInEwGIQPLfHiKHcIAQh1waE7lMUxZFh5rhtErNwnB4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=muBL3qu40pnabsgT4umV5F20uGfNrH92H1ZIBlZuQCCElHvm0ipeO+EQKiFAdz3Ao
         BeAaybN5ElCPLcmLBQ0m7VNc0O74Mh1BiLyEn+XZiCllOBukV0Sr1wCT2nwN1A5WdH
         LrZTzM0Q6kolLOLQ8xDvnUtNswsIIDBlsz61h08w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190125.162151.302539235913379257.davem@davemloft.net>
References: <20190125.162151.302539235913379257.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190125.162151.302539235913379257.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 master
X-PR-Tracked-Commit-Id: abfd04f738c2625f63e04c8fc7cadb3b7a70d580
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 037222ad3f43a45c3a601dabf893efc9264ff5a0
Message-Id: <154860990370.19009.9587778268301493956.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 17:25:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 16:21:51 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/037222ad3f43a45c3a601dabf893efc9264ff5a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
