Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E68218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780098;
	bh=cwiS4h+DEyiImbm6flGDfxLr9hepGnd48Mvp+CDziJE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IufV9kw1tkPF/gYn2Ytt8fciBMTbCGYw91LC08pzucpSvTrL1dFjcp66Wl90nbugK
	 gmPdJPsFamz5Zkx7f6wTcGQ752mIwo1rW/8zMR6e03q85I9j/ZeWdbXfURcHB8RgOk
	 ouqmocBEHPYoc6zKS8ZmJ7QrCHPL3GbvruvVvtLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeLYXVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:21:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeLYXUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:05 -0500
Subject: Re: [GIT PULL] EDAC pile for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780005;
        bh=cwiS4h+DEyiImbm6flGDfxLr9hepGnd48Mvp+CDziJE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uagSMQoTXYEWtgfh8vlfU8ZSFYG5JfrjTtoyAd6ZbNIor2TntplAB19gVDuvrLc7l
         lFciSyYNj7B9y0i5jRrFsboXJXxxVkSMC2qB/cLrlJvUTh8aLLIUGMk6+nCT6CIggf
         XWHczX5d+i9iu7KTVp5ePXeTpJFpuSbdCuaNR9XA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220201137.GD24975@zn.tnic>
References: <20181220201137.GD24975@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220201137.GD24975@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git
 tags/edac_for_4.21
X-PR-Tracked-Commit-Id: 75dfa87035f9a2659dd0c48af6b4d9899e79cdc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b271b2127e6654a72dc1685f0825fe1cc2f36939
Message-Id: <20181225232005.23808.6585.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 21:11:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b271b2127e6654a72dc1685f0825fe1cc2f36939

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
