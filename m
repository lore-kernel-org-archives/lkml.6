Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45287C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A26218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548349810;
	bh=K1vHj0cW9/39juy/5xmGM+gw/lizYnQyO7Phiakzuoo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=em40o6EOTwkERoB2nWF1K3Pq8LcDeM+eA7R9R7bi5eO/2ZiDfLyXJkfrurWJ4ubx9
	 nGAsgMACRTyU8XNRVQsXWhU7ToQ4oanfqnEI7jORX0PdzswSFIpBTr4PSSrrcyVD0v
	 onJsgDkuY7+x/fm8But3+ZG79hNzd4EgqoJq44hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfAXRKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfAXRKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:10:05 -0500
Subject: Re: [GIT PULL] sound fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548349804;
        bh=K1vHj0cW9/39juy/5xmGM+gw/lizYnQyO7Phiakzuoo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BfN2oBe0IUcwslkpYNrzmtl2fStQI9cExk4EMMRw8r7heomK7gOLHSpQ0LDwOydAp
         fTn/b49txNUxQXmv5ufAA6+uwbjcvF+GilPyZbTHNs+19q3no9CkQ01KAF8ZIGiB50
         45jN5nTvpYGvEdhg6AlXUJ7LA36KazPXA/nX0p8Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hfttibeqk.wl-tiwai@suse.de>
References: <s5hfttibeqk.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hfttibeqk.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.0-rc4
X-PR-Tracked-Commit-Id: 699390381a7bae2fab01a22f742a17235c44ed8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa7b98459f15bf45d0610c8acfa7929a8641864a
Message-Id: <154834980494.21465.17653685526468296269.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jan 2019 17:10:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Jan 2019 10:13:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa7b98459f15bf45d0610c8acfa7929a8641864a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
