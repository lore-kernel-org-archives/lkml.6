Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E4C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3CF21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549672811;
	bh=OQgr8pXTboUxll4KhhK9RxDVH7zeX6EDGf3C377Ob3g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cAAKk3SB9kXwoSO+9v3fl31DGGuvEkSotB5CLsTr907mugf5Udvd0xVEh5xw3bToG
	 9Kml4Cw+fnR4ONxHsyuS+K38APut6NIymkS9O8wxqMjmXU9MDBpclSBfcrUs5rDZPl
	 pEH8CSplE60pqJTI/lITZixK/2ODVllaJbSXXnyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBIAkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfBIAkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:40:06 -0500
Subject: Re: [GIT PULL] arm64: fixes for -rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549672805;
        bh=OQgr8pXTboUxll4KhhK9RxDVH7zeX6EDGf3C377Ob3g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bXj4krCPIWWkrmyQQ/HaN17HLLiG/eOLyhyprQLHe/bq/h8SW7x1mHj3RNGtg89vH
         h0c/cItvBHrVBUUb0UmQuR27ZhJSC0d8IvIFze53glINsvLNIkJ7crd3oKY0M2Ev7O
         03jFMG7FejUizfbULfp2zZ1XdRkHrOY6LkC+tq8U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208173515.GC24375@fuggles.cambridge.arm.com>
References: <20190208173515.GC24375@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208173515.GC24375@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: ea5736805190e912903c27c9f17c7a4341a405e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bb513ed838c9eaae1704a3389eabc04e4cc0da5
Message-Id: <154967280573.26526.16679674853964822756.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 00:40:05 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 17:35:15 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bb513ed838c9eaae1704a3389eabc04e4cc0da5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
