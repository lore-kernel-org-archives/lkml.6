Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B19C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24CA217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548205805;
	bh=76eOJnM0BGvPdZb2ExZhHYObV3tK85fef0rUMWzl3y0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YXsB5S5TOty2zB2iXpITnqAwakwJFugeMLgXEViTNlmGI6jJ0fvuafBnryWYAVFdl
	 jd134FBz+sNeQN0cEvY8r1kIU3UsG9pm4ZT2xb0PoEoYz+7VppqAKVIqcY0QyDk9im
	 aHsOjCWc8jcEOj5j9BR3w0HXY/QnRWBhPbciVE/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfAWBKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfAWBKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:10:04 -0500
Subject: Re: [GIT PULL] clk fixes for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548205803;
        bh=76eOJnM0BGvPdZb2ExZhHYObV3tK85fef0rUMWzl3y0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NzqdK37PI0/i0grvIwGIcL1B/hT7qAiVYDbO0v+n8c2pkAyz3D4iah7Y6cd/0PALE
         rze4h/BqSCOFgwJJYlsaSnmcbv9wMEW6Y/mX8ipaq2wGVI6/y6UJkMyCpQ3h/7ae8m
         YLcQT3ezYUPhZOO2mdPwC/BZzXtxyq8d7s4dLmTY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190122223729.95720-1-sboyd@kernel.org>
References: <20190122223729.95720-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190122223729.95720-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: b488517b28a47d16b228ce8dcf07f5cb8e5b3dc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b0d4be6b4880c7199d41afe4d9a3f20f47fd9bb
Message-Id: <154820580349.10150.7503518216170035889.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Jan 2019 01:10:03 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Jan 2019 14:37:29 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b0d4be6b4880c7199d41afe4d9a3f20f47fd9bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
