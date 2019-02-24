Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1408C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 18:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7902B20661
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551032104;
	bh=Zab2yeJHU/ekKw9iUykSmewI5wgHDIeIfirD3pptjLU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D7X2ZL/6grNtKKK6uVKj2VYMFa7miW7ETahLxAIZ1PosR6oEmn1UoGN5ttWrWju0v
	 in763Pe0PPoLVnP8DG9XalU9x18r61hint2U4rVUAgEGZKfzdYefRxrHPvMetyztbd
	 LjB1L+EA+y3RYx/1Rar/ri/NH421h5ZZ3DovZjwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfBXSPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 13:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfBXSPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 13:15:02 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551032102;
        bh=Zab2yeJHU/ekKw9iUykSmewI5wgHDIeIfirD3pptjLU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FXUI/HYOD54JEZmbk2G2Xf70a5LUFA9PH6+qrL+ztZw25wNBxtpmxSV6KCGJH3NAg
         CyHHYrmzCIbcO7y/PAeKIPB0DTzVgMfWh/WBI+v3VdwLW3Z/BBMn4LATQKU0iq6Pgp
         mY27MtzpDJkXDSL9YvxkVILlP0kq38sV//aZy3LQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190223.185710.866316846403242352.davem@davemloft.net>
References: <20190223.185710.866316846403242352.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190223.185710.866316846403242352.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 4c8e0459b585e2a7b367545be3e102737f1e489f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4eb1e1852df60d61e04a6b580a0490460c9e31b
Message-Id: <155103210219.9905.15434112149947947632.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Feb 2019 18:15:02 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Feb 2019 18:57:10 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4eb1e1852df60d61e04a6b580a0490460c9e31b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
