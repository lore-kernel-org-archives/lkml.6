Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC00C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3B4218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545789003;
	bh=PSS/U1ob9qJTQZualx0PlbLksBGiQyoYY71DNZVxVnc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NJE2I9pqsoCMV2X+I6r3BlOsLCoryon3Ynv9hhThnOBXEcDLu+wHaU06OJpZWdNWM
	 s0m//FV10W0UGJlaDES1mmXs5ftr7rKqyUGk9wJ6NljUoq/Ny8uOeofBcsj55z3fR0
	 NehTtJg1SKFzYicLNpBSMOIWUe7aLGA2CZ4Wbj+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLZBuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLZBuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:50:02 -0500
Subject: Re: [GIT PULL] arm64: updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545789001;
        bh=PSS/U1ob9qJTQZualx0PlbLksBGiQyoYY71DNZVxVnc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O67cjXUR5wTGd4Vem42g5Bv0wb2rA9tJu2v3obiS/pb5f5ziPueuPbsRk2KqjODmF
         0s88kAqJnNe+Dw8WX6+Xh6CYKoiZ3LC9AidtK2gP1Y6SFh3gIq0qzUGVPRlSkND9UU
         kLRLAlPTTOHDRo7IBZK5x/MzbZuUpkbQRPk8sIsc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
References: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-upstream
X-PR-Tracked-Commit-Id: 12f799c8c739518e12248bbd000eb0a246e8e5f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5694cecdb092656a822287a6691aa7ce668c8160
Message-Id: <20181226015001.16185.53789.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 01:50:01 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Dec 2018 16:14:13 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5694cecdb092656a822287a6691aa7ce668c8160

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
