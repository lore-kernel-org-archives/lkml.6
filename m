Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DCDC10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E6A21A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550368220;
	bh=RK+UpLYnr/xdGO486fNO+x050oLgui6So4WcvMRNcw0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hJvDXgVjMQ8bpaP6uApTdz6psHCDNlPQsfNcPBuwQm8tHIiLooI3rLYfC6KA9PWER
	 eytr7vatGMDwXvyozJxsh7UuGa8HLQRu/FXVBmZEeMLLC0yj0JZFNTlI0ckC9eixHj
	 SXC7fBNF/NfcyEDFgi2Lh8z50ayNXGt2+4hOUpKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfBQBuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 20:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730763AbfBQBuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 20:50:04 -0500
Subject: Re: [GIT PULL] auxdisplay for v5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550368203;
        bh=RK+UpLYnr/xdGO486fNO+x050oLgui6So4WcvMRNcw0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CBwqxvYfhsiSKuCewLUtUB6pYPB11yK7bKSmPJXjvWJO0E2XQwkVuerSynFXzI12v
         U961VaoMn68I15NHDoiCXmCk1F+FlnPqmpKsPqes3jK2UqooV67eWioNBeXq6ZlKeR
         1NtAa4yVFzJSHG6Di5HXZmjtreFkcyi6mSgUYoFo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190215192226.GA24834@gmail.com>
References: <20190215192226.GA24834@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190215192226.GA24834@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/auxdisplay-for-linus-v5.0-rc7
X-PR-Tracked-Commit-Id: 69ef9bc54715fb1cb7786ada15774e469e822209
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a7dcde4a661ccad2b641e873b15ce26bf302c4e
Message-Id: <155036820377.25738.12438086556703409245.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 01:50:03 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Feb 2019 20:22:26 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a7dcde4a661ccad2b641e873b15ce26bf302c4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
