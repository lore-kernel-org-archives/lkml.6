Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B3DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3DB21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545420614;
	bh=3w1uuC0IuS9yzJxUKgubI9vsqywcWFn4Qr2CuOTDi6I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gDIKZOOMx80zAqTEcKeqG65OWNevs3n0VcMwpWc2b4MJPgN5nv3N0tTqf39YYyQvU
	 YrtBBoAua0/kxFvK7H0DAAEG7EGHz85YyBhsxgG01Q5dppoS3RGFDxz4fnIMccMa1B
	 q/MX1ETC68BHN1AfnKY5Gxmzcr53Ps3uaq7VBUqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404593AbeLUTaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404544AbeLUTaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:30:04 -0500
Subject: Re: [GIT PULL] timer fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545420603;
        bh=3w1uuC0IuS9yzJxUKgubI9vsqywcWFn4Qr2CuOTDi6I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iagsj4en7K4ixQrjfnB0z6fgg4AMiQ463OqjTK66Vbyt7CX783+j0aK1XXR7ots7M
         GA9+nfxoeMd/jeo87ekUwBTi7e8lGL/VfykpAD5vkIDf35hngh663W+ukthMUebqo3
         TS2/hgT2rh7gBIOlYYTiDvnRBgPLawLRM9e6ClWU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221123453.GA102366@gmail.com>
References: <20181221123453.GA102366@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221123453.GA102366@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e572fa0e840154d33a69622af030dda551eee606
Message-Id: <20181221193003.15695.22091.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
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

The pull request you sent on Fri, 21 Dec 2018 13:34:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e572fa0e840154d33a69622af030dda551eee606

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
