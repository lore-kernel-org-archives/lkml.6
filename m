Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B037C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF6B218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548963011;
	bh=upFhxqw8jK22SsA8To2KGHaQUayJzMDVDestFV/79S4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rbqF1CFFAGqCtQ9rRtJfNDAcVH8tcb1VpA6AC1kbbOAtHvs3QUadpqH3C7deR9YMI
	 YvbTAwigaXlBmG6Tr+u5bq0H5k4IcZhwM5yucQ7dt8/ujHmuzBvo8hb8e5YV8EGV2u
	 jbt//wgZYBYhzi0XejjUZuFQhJhU1nwB824X67zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfAaTaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfAaTaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:30:05 -0500
Subject: Re: [GIT PULL] sound fixes for 5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548963005;
        bh=upFhxqw8jK22SsA8To2KGHaQUayJzMDVDestFV/79S4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xhPsBZQ2XLJY0gklcamzIVw4VMUzlhq9V3cAT1baAhgamUXgK43LuTGzVBb7F3lT1
         akZ8hTQlpEdt9+Qdd8WVA3kK4r4IHKgtI9Gt8wR4EMAowiuEyvDioz4EnBtkDxK3Ox
         LeBtkJamkXM7A9HCdsJ7h6TtoeV+BhAMWme1rI7o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hpnsdawqb.wl-tiwai@suse.de>
References: <s5hpnsdawqb.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hpnsdawqb.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.0-rc5
X-PR-Tracked-Commit-Id: 693abe11aa6b27aed6eb8222162f8fb986325cef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83f4997a01e72844045a2bf1f348359a1acbfb19
Message-Id: <154896300516.28776.17145626171206660512.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Jan 2019 19:30:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Jan 2019 12:32:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83f4997a01e72844045a2bf1f348359a1acbfb19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
