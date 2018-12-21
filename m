Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D78C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B5121927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545431403;
	bh=TIghhGi5bGDaB0toorvqkDSzd6qpuuJXaQvnXT5GbxA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e4OimvSSxOovQvVYPK9ODcwIHkJX/x58GneAokBIh9cOLqxg3rEPyXIFbogl2QK5g
	 dmQ67nkpvUDsRUE8cahtYFwlrfp7aukI2EW2dscWrjKNAcwlcdwCYPD440+rMuxg9D
	 WPJrrp1v1O4UMRdM9T3hc075x+pzH0u2ZwYSVP+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392168AbeLUWaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388819AbeLUWaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:30:02 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545431401;
        bh=TIghhGi5bGDaB0toorvqkDSzd6qpuuJXaQvnXT5GbxA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oogmHoeCLFVVB0PIYwvdgC2CxNnB8mV/rWxFcMtJe7+Ctxysfc/zJvEo4fA7Ogebv
         /BlyvkM6Ye7DaKjTEXOakj0GfKMmod/ENDkaoHitbAtjwc5wrBvWc8M1RVpqBUeLt8
         UI0QckwR967qJx14kNGfTsGm6bqGRt3tdkwElyYA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221.124225.1063250530021518943.davem@davemloft.net>
References: <20181221.124225.1063250530021518943.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221.124225.1063250530021518943.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master
X-PR-Tracked-Commit-Id: d667044f49513d55fcfefe4fa8f8d96091782901
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87935eee57705e9b6df506c5df8b92d6a0b77a51
Message-Id: <20181221223001.32045.27853.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 21 Dec 2018 22:30:01 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 12:42:25 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87935eee57705e9b6df506c5df8b92d6a0b77a51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
