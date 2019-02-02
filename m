Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5805BC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AA42084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549069214;
	bh=E1tpuaGLRuWvFVCDKaouumYjHMgjRMM7ZA8RSABnWhs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JxynZIg0Pt//xN4O1cV9yg5enWL/aXpb5aXYX2ss6+FoU+4Z2U+pA2bcBJEhi3dSh
	 UZ8oGYdj2EKIiN42OzptW0M+2e+gkQHRh1fpItdcWsJPfSSzLcULoXLsWpkW15HlwK
	 N3AMRX6kdlJPneDtLxzt9KNWcnaGK2spqQhUBGck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfBBBAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfBBBAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:00:04 -0500
Subject: Re: [GIT PULL] arm64: fixes for -rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549069203;
        bh=E1tpuaGLRuWvFVCDKaouumYjHMgjRMM7ZA8RSABnWhs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VKJ7w9dNGLrs8pHrLI1QVy6DZxiukD2mCe0wdg4nowgXXYtuI1q6HygA77Vzra6cw
         oqUPvPKLZ0ZGJ4vtco6uoBPnNCwNumRHsrJbzoeDp956r/98FZ7NQD5pCV+ShCq0MS
         hnWNkSmjTwBTNZnMEYZwMV27lnK16v5BBssmwILM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190201175141.GB14567@fuggles.cambridge.arm.com>
References: <20190201175141.GB14567@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190201175141.GB14567@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: f7daa9c8fd191724b9ab9580a7be55cd1a67d799
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b050fe42d8ad1a2219201ba6d773e5b0eff1a29
Message-Id: <154906920394.30832.16750683981191565683.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Feb 2019 01:00:03 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Feb 2019 17:51:41 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b050fe42d8ad1a2219201ba6d773e5b0eff1a29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
