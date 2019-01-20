Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9980C26660
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BF22133F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548009608;
	bh=aE/+ehsAxgu7+SyXYd2O/ZcPzSo33JripmKtCmzzZIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gwFocZKVX6o2tKdBtPNXoSD4Yu13Cu0wbiqauuq6JuvCmLBhevAwqTm9y/UabZHwD
	 URtUDJh1+wg979jtD5bsAn9cL5byt10RWBGXohXSY8IE99DaA7wejHyaqASTr7B3kE
	 c2NmypMS4777ewaRbM9PSinmXm9WWezRm0752Yy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfATSkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbfATSkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:40:02 -0500
Subject: Re: [GIT PULL] compiler-attributes for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548009601;
        bh=aE/+ehsAxgu7+SyXYd2O/ZcPzSo33JripmKtCmzzZIM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z9EvzX2LyLCpMtaZ9iHuqNZwH10UES4BIhdQhMX0pxmMstngV017dgw3uX0Ritchn
         xuytcsPnt+r+zlZZN8kDtHRnINcLvj+lDnx0rvr3jNy44tz/jE+7dK2Mqgr6zl0qoq
         JzxMGEgiKYV5iJYtalPDBN5q78Ue+gRt/nhTPaC0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190120153417.GA29879@gmail.com>
References: <20190120153417.GA29879@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190120153417.GA29879@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/compiler-attributes-for-linus-v5.0-rc3
X-PR-Tracked-Commit-Id: 3e2ffd655cc6a694608d997738989ff5572a8266
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 315a6d850a8290919c499cfbed08737f6164c7bd
Message-Id: <154800960162.15983.2046713238990753081.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Jan 2019 18:40:01 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jan 2019 16:34:17 +0100:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/315a6d850a8290919c499cfbed08737f6164c7bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
