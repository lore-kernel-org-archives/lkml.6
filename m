Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94810C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B3621726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780007;
	bh=9gwJPWXJ1BT6Lg1GVV8fLkZYGTLw8eazLYvzVeAVCc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1aS2fLtsLry9w0q/BmE0V1+iMRGvBjBHyi+6XfR7qjHbI+7tztUu35dLRvdxoEaXK
	 Vr3258oYaYz4s49qgk+Ml8Eym0GRuEQw+YR5GpsRFzHW523LAgU2z1in79HB2wB0xE
	 coLC+08yDTeyixmv/UFpTj8wNSwsXbpj0Yl8pZPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeLYXUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbeLYXUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:04 -0500
Subject: Re: [GIT PULL] sound updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780004;
        bh=9gwJPWXJ1BT6Lg1GVV8fLkZYGTLw8eazLYvzVeAVCc8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=etcMwLS2yVyjnPd513AZG8TrskE5MLSnLL8HTf0NQ2ZsuSHZbJGLMTCCtbvpBkSaD
         95aoo7dFxn5IM1QgkmBznV/kNYpaNr2VKYGEGYTz6c1hjqLKWc1kdXXDsi0fNeTZPP
         ND1CwzEcGfvlWtiCbU8MMaDe+DzzizpjYif/7xtk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hk1k48ayx.wl-tiwai@suse.de>
References: <s5hk1k48ayx.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hk1k48ayx.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-4.21-rc1
X-PR-Tracked-Commit-Id: d82b51c855a20eb456ac09f2f40ea98312373263
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e61e7b5c4de2bea534438bd7a008accd85492b0
Message-Id: <20181225232004.23808.16115.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 16:38:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e61e7b5c4de2bea534438bd7a008accd85492b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
