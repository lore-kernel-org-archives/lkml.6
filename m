Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B7AC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777CD20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544123105;
	bh=tNF26JZVKxiP6frLANwO8QwG9j+wFBXIG9mj6G9TBoU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LxQkxmLZLEgYuQ2c/DpBr8ZlHLLlb/lPiIl4Ye6WhzeKAvFWqWYuqr+VOsGaOj5Tl
	 WBjJaGp5N+r6MYo/Xful6p9pebg3i0O3qw4pLfEgSIa3CWp1f0HPV+yYBH+drqe7Hh
	 YgJCVn+Yb9n56XpER8+8OxfVbYc3mWnT2mfZ1L6I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777CD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLFTFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeLFTFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:05:03 -0500
Subject: Re: [GIT PULL] sound fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544123102;
        bh=tNF26JZVKxiP6frLANwO8QwG9j+wFBXIG9mj6G9TBoU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UPzXCFSAFX/rmHAGQee77bUKDnuzAOQYEIwDPalAqllB4Bs9aZD9uMorMJvi560ky
         6lK1UzLNdfu1oLHmRwnjOV9Kf6Qv5tbhIspCxRWTfWvd3EQ0cdrcUlolOxki0zrSPJ
         Nx/5/fEJQN0Ejso/9nE0y+QTVSh946C27z91Uml8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hsgzbrklq.wl-tiwai@suse.de>
References: <s5hsgzbrklq.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hsgzbrklq.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-4.20-rc6
X-PR-Tracked-Commit-Id: b72f936f6b325f4fde06b02e4b6ab682f6f2e73f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2acee31cce656cca9e81072c330c1322e1376155
Message-Id: <20181206190502.10356.82570.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 06 Dec 2018 19:05:02 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Dec 2018 11:54:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2acee31cce656cca9e81072c330c1322e1376155

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
