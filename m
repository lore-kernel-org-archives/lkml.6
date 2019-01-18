Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAB3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B1D20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547787909;
	bh=B8eTbCFHml/iVer3kQe1T773ueCfrcTsUjzVoVT37ag=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DQi17GfsCVCeiG0x9viS8rgFGIAoR1gjP3pluh4HIc9q8BoRZH8oNcGuE3SZ5IlIP
	 w547AnDAxhdsL97F2kVX1eW+vKtxjPp9VrRdCfJwjn9VGTqtIeNtIlN6hFOknq7ZVm
	 /icbEkpk52EsW1PVFznL4P9AO+uFWHItTv38/G04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfARFFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbfARFFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:05:02 -0500
Subject: Re: [GIT PULL] LED fix for 5.0-rc3.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547787902;
        bh=B8eTbCFHml/iVer3kQe1T773ueCfrcTsUjzVoVT37ag=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z6L3tVJQNhq/bw30QaBf/hZPClRVGrozp8r+cg7r/NugYGpg8XyKXBS9dI46dx05V
         LVfq9EB5iHZ31RpUo8KPJ8DaPlO6AM8IzMAi6hhF577mZk6s4ky/b2CeZSSUk8jcf5
         QYJ9R1hbxqHWpzQNveWAfo2GY6q6HHR7a9T59kPI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190117214352.23045-1-jacek.anaszewski@gmail.com>
References: <20190117214352.23045-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190117214352.23045-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
 tags/led-fix-for-5.0-rc3
X-PR-Tracked-Commit-Id: 248b57015f35c94d4eae2fdd8c6febf5cd703900
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2451f3717c538795fc9fade46916683ebf7ea959
Message-Id: <154778790228.10702.5331263532394901114.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 05:05:02 +0000
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        kjlu@umn.edu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Jan 2019 22:43:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/led-fix-for-5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2451f3717c538795fc9fade46916683ebf7ea959

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
