Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA3C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D8D20869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546047008;
	bh=wuxtA3F6PyKWK7Nqh0ou4MnKmjLR0SsIihVSJL9dUII=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AooMMkBXr1Misu02hPvqwHK+kDot7gsii+txws4lis5HDzuhLSuiG1XvnPYqWPxm9
	 pXnVojSsyxJa6SmMr13QFD+VO/KFKKSV2pTvDNc0N0MieIm5VHwP2Th2rwf+2ok4LM
	 CyzYBcEmW+vb2EpF/gtpOsmZx+NMQicOjOae+3/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeL2BaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbeL2BaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:30:04 -0500
Subject: Re: [GIT PULL] MMC updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546047003;
        bh=wuxtA3F6PyKWK7Nqh0ou4MnKmjLR0SsIihVSJL9dUII=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dNI2w6cVltAfvWMIZ5J9u7GYD5qhZbeEXrwiGH5pmAGNE132exnstot/rqx+yIZL7
         b1OziJdp3njHJmLFY2b8YLYiuc994BkrhG9Waev697spNirXVBcbEh7kJBLG0EZTSF
         MmZvySYpyA/9eoJxgdXB89zspMxADC6r4S91fHVQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181227143152.11176-1-ulf.hansson@linaro.org>
References: <20181227143152.11176-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181227143152.11176-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.21
X-PR-Tracked-Commit-Id: 5215b2e952f3f94d74cac1a59494eb8ac647e216
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00d59fde8532b2d42e80909d2e58678755e04da9
Message-Id: <20181229013003.17208.93922.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 01:30:03 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Dec 2018 15:31:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00d59fde8532b2d42e80909d2e58678755e04da9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
