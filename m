Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF35FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E534E2070C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809506;
	bh=BkUtZAY3pO7BqPhc0O2H2Fbj6dZhchRSS6NLtlA1/jE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=G/Ukk5V0/oU9W2PVYxhKGm2XZRhhA//O6Fg/sU9u0m4ejxxVUNPAglFbU9m0UlCCs
	 CIrsRTX4I0djEvTdF4TN4DMpA1E+ChUlcpcD7pqIGPNlI5BnPNJzGw6CMph+qgRBzN
	 vPjeLL2ULoKrfRGiBKK9WPYzP/t9mau3cX+0V/IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeLNRpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbeLNRpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:45:02 -0500
Subject: Re: [GIT PULL] arm64 fixes for 4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809503;
        bh=BkUtZAY3pO7BqPhc0O2H2Fbj6dZhchRSS6NLtlA1/jE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sIkFHJaRAQoNGzkWjdzfhAgzJOiob3DwTRWLvlqoQu+LbXSGLojC4yVk7QsLlQL5k
         qG447cqayb3SsY+sknsOO2ovEPSGHBuwYqqsZAqwAQeAVsscZmO2PUDSsS1Dusa/QR
         zDSZP94sSuOMFWcO3XBaGyzEIfaT/ewRi/NpaFb8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181214172115.GA46313@arrakis.emea.arm.com>
References: <20181214172115.GA46313@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181214172115.GA46313@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3238c359acee4ab57f15abb5a82b8ab38a661ee7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb6cf9f8cb9dfacf6679f9d6c72aaf568a027edf
Message-Id: <20181214174502.32554.20235.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 14 Dec 2018 17:45:02 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Dec 2018 17:21:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb6cf9f8cb9dfacf6679f9d6c72aaf568a027edf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
