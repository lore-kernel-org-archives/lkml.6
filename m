Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232CFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E510B21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545420610;
	bh=ktu6ycnTW/gF0kQeREaWgg/NuLDMJTJ5z1Mj4fYRMQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ot0gLcNJnaweuu8o8GToEz09V8vZuL90rdnlOHQ5l+Uv1/k7hj6PKc/oYKDH20Otp
	 Wt2AuFR88C6H6aNLMzuezfAgoRDTn2YvDzE+QkPoWVxUYLFNugpnEZBu4W/2X5exXQ
	 /xNzcynG9linasJm1mLiLGC3aGvDzSQDfakOIV54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404581AbeLUTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:30:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404541AbeLUTaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:30:03 -0500
Subject: Re: [GIT PULL] futex fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545420603;
        bh=ktu6ycnTW/gF0kQeREaWgg/NuLDMJTJ5z1Mj4fYRMQE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iZSmgtj3xhfWRijk5c68JpuIcBtZQlMXykoqRHIBY+fgKCXR0fJRixI9wDL56XP+0
         BxXHrfE/EyHxky2Ye2uXKQ1i9jFm2H2dxL+738h9UKX/1iFBNDukCSMKKyAgPVBDDp
         VG46m0a09V0BnCgKlvt+uq/NBjLuyH1vAYowJFpg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221123015.GA66918@gmail.com>
References: <20181221123015.GA66918@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221123015.GA66918@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: da791a667536bf8322042e38ca85d55a78d3c273
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5fa080d4ceaa8fec0fb28e27c7447caf4b4d22b
Message-Id: <20181221193003.15695.75464.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 21 Dec 2018 19:30:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 13:30:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5fa080d4ceaa8fec0fb28e27c7447caf4b4d22b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
