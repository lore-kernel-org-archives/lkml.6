Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366E9C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A2B2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544399104;
	bh=2bVA5audS+MXtAUnEYd8lb9Cvu9kp1PRGTwXA4/rE4c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WnyNLHdPXzl50KZ1n7W3NFj4Mgusjjr01Jnp/VbcwUhXcYBonfajKrW4RaqsAEUIr
	 tr1RAp+SMKhhguKy7Lp6CENoyCBlywFPC8HIsI2tDBZFwyHc0zHmq9E//hNMfu3nP1
	 oNi5uOVGIrge+wR5i1Pdy4WrWtPzwVqQxrmUMvik=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A2B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeLIXpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 18:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLIXpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 18:45:02 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544399101;
        bh=2bVA5audS+MXtAUnEYd8lb9Cvu9kp1PRGTwXA4/rE4c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XGiICgurIL0GeugeuvfoEudWzUrvRuDvDx7+xn8JP2bMlNkOcszF36ISqygEpnZmX
         5DL2itLlLLoDxTEN3xO0t7rMYtGPBXTw4VWXkYSGjYzmKjItxGYpCyFu4aDxt2YIb1
         qIeSLZSp3Ybg/nrs+sJyGeTn+W3T6AV+jMQBC1GE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181209.125154.1052371448735185456.davem@davemloft.net>
References: <20181209.125154.1052371448735185456.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181209.125154.1052371448735185456.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master
X-PR-Tracked-Commit-Id: 35cc3cefc4de90001c9137e2d01dd9d06b11acfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d48f782e4fb20dc7ec935ca0ca41ae31e4a69362
Message-Id: <20181209234501.29575.43986.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 23:45:01 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Dec 2018 12:51:54 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d48f782e4fb20dc7ec935ca0ca41ae31e4a69362

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
