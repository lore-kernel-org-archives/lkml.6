Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24560C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E866521741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545322233;
	bh=FWDn5OtTGv9KhVjs1Wg/eQc232POebTmvuegdEYWlGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PsbPZYvF+hvJIc3YVNsAjBTWZcT5daZwOcK4skTOILUZSPOsPsFlhhB7hchZjidKT
	 57bzLUQqQbHK5KCnU/Rcrf4htZWjghcumxPkt61qpVafYdYG2YkxG9L8Dac3ITMcLl
	 TeQPhtVeefWJCkRbv0IpUSavaq0VNkRKcH0Gnfro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeLTQKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730526AbeLTQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:02 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545322201;
        bh=FWDn5OtTGv9KhVjs1Wg/eQc232POebTmvuegdEYWlGc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HuodyqV2e2hlnOW7DSdYZtDK/SMZXS0v6HaqFfGDKLquFu+1xDhda6un5ijdxHbCD
         9R+VlTPn2DKkH9LtcXbbrqjCfQGtU6ZVlU1lMJMM6XQZF5I3JuKoe1faNzldpc4pBo
         2mW++XcrufVZHXu6Hf3D42cH17tQZtvaPRyW9TjE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181219.210340.1767864830502887465.davem@davemloft.net>
References: <20181219.210340.1767864830502887465.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181219.210340.1767864830502887465.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 master
X-PR-Tracked-Commit-Id: d84e7bc0595a7e146ad0ddb80b240cea77825245
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 519be6995c31005ae3bad5421e09ef99d4eb0b82
Message-Id: <20181220161001.12746.61483.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 16:10:01 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Dec 2018 21:03:40 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/519be6995c31005ae3bad5421e09ef99d4eb0b82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
