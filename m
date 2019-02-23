Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A34C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C299D20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550950513;
	bh=LxBMdGTiijydGiTxgv7/1XZuUi8L62J5AQTNzBFEUgA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=y67ixv83A/QqkDoUoH5eS2wxpo4gB0ijrpL2zAOo33A5EXDCEw71mkzf4Rfp1L4VX
	 +87gaGK3DmeLmIl1l4ZdqF35FTlMPEK7dFkbfnedg4yBQk4f++Sg2ODNXMnsiblyFk
	 DZtmDOmtMH+HNFGNa6k23pDp+qQVgYUjJn9ENxDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfBWTfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 14:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbfBWTfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 14:35:04 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.0-6 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550950503;
        bh=LxBMdGTiijydGiTxgv7/1XZuUi8L62J5AQTNzBFEUgA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W04B/8Iymeo43jUngwrcDhYygpub/j2RXSrOgXpiwm+MzuiFOa1F0WYcvNrkgiN5y
         IZ/5x7rBRP43WyJSYm6118ChcDiJjSMvsKSWyVmKoy8+IPBE/J9ixe7+iFeO5kCL6W
         rPE6ZJudlqoTxBVwbzs7yIHAsV38au4Y5H6YUs7M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ftsellk0.fsf@concordia.ellerman.id.au>
References: <87ftsellk0.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ftsellk0.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.0-6
X-PR-Tracked-Commit-Id: 8f5b27347e88b171c755562f0090ce40e514fc00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e60b5f79bd7529e76b13cf1e85823abbd0e33634
Message-Id: <155095050377.13236.4782111457791576621.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Feb 2019 19:35:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Feb 2019 23:46:23 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.0-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e60b5f79bd7529e76b13cf1e85823abbd0e33634

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
