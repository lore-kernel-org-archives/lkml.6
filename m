Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDE8C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610A520850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547834722;
	bh=aZU4xQjIiZ61NSXL3KZHvyEE/y9LVGgYrkrj9GG0YZo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l0orWz8Zr7EwfpmDL0bxwawyo5ReDvEM6UzWjxtGVXlrTxFzlaWkQgq7UXMs3Ygl7
	 b6es5/R1sWJCCHBeNiFpBQi/cHhzjpC+uIjlOl5b4tm/oei5P3b1b6ywCPRfvovzC5
	 FyCfswOkwEqheWrmXNZTads6bs90TuPvy5stpptg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfARSFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbfARSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:05:04 -0500
Subject: Re: [GIT PULL] fbdev fixes for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547834703;
        bh=aZU4xQjIiZ61NSXL3KZHvyEE/y9LVGgYrkrj9GG0YZo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vMlln4pUlIKBXGOKPIPKURR5cCEu5necedfRyztaN6SevlE7L7A6u1X+ZfydlbkqI
         xGBOypIBk7Ej/6pf9sfcIcCzMdG6GlZPMD0BWyy9s3Rk/nDjuxPxBult3ZYVz5wrss
         gJ20Io8LNkY0Y38kLlfUxD1HubzfQ+yFOrfllYxk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2bb72d22-590c-958f-1dd1-fe44f264091b@samsung.com>
References: <CGME20190118123845eucas1p25b20e2175991a620437c338a0001f03a@eucas1p2.samsung.com>
 <2bb72d22-590c-958f-1dd1-fe44f264091b@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2bb72d22-590c-958f-1dd1-fe44f264091b@samsung.com>
X-PR-Tracked-Remote: https://github.com/bzolnier/linux.git tags/fbdev-v5.0-rc3
X-PR-Tracked-Commit-Id: 890d14d2d4b57ff5a149309da3ed36c8a529987f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a8cbf2a02784efc02f7093000010e20c4ebc9ea
Message-Id: <154783470366.23992.7424098240864824163.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 18:05:03 +0000
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 13:38:44 +0100:

> https://github.com/bzolnier/linux.git tags/fbdev-v5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a8cbf2a02784efc02f7093000010e20c4ebc9ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
