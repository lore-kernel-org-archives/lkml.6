Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DE8C43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862FD222AA
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742415;
	bh=h1pmRzBf9GE6lrtDx+pmsipds6Tcgbqmu9Z/C5LAz48=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HqMG+bLfCDwGg6lh2hsAYWPs9vkpq3B8urM9N4YRSwKTfZUEi4peeCvlQ2XPGh5WG
	 rCOC5kxHDWryFCvUyCS+yIz6iM5rkBC28YgTbmBbNiaJU1LCSfptF59BwaHSynmMa0
	 rUGSCTFzMrb9erGTF3AyZM4Ukw9QrDy+74K59Tg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfAFCkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfAFCkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:07 -0500
Subject: Re: [git pull] drm next fixes for rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742406;
        bh=h1pmRzBf9GE6lrtDx+pmsipds6Tcgbqmu9Z/C5LAz48=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EzpmqBj25hrer3lX7O8OKWLXTl2sm4RLFLu+k+2/CrJbKcwTCe3Aa6hKKhezICGfb
         G8hrA1j/emIJLRCuuBszQuWbhoy9lPY9VDAF6ZJEk3johWGSHhy4Kq/4Es8XQP6OLB
         JXrXo8vSmCCXE8MhKDtohuMOIyWi7W3PN4BGuHAU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzFx67xnMMYmrw1z1BTRmKsc+wjjXt_C+FuWNz4dMoV9A@mail.gmail.com>
References: <CAPM=9tzFx67xnMMYmrw1z1BTRmKsc+wjjXt_C+FuWNz4dMoV9A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzFx67xnMMYmrw1z1BTRmKsc+wjjXt_C+FuWNz4dMoV9A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-01-05
X-PR-Tracked-Commit-Id: 9ddf32a8df9e342371aaf9233d59739a356231e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fe4e2d5cd931ad2ff99d61cfdd5c6dc0c3ec60b
Message-Id: <20190106024006.13237.71644.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Jan 2019 05:10:22 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-01-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fe4e2d5cd931ad2ff99d61cfdd5c6dc0c3ec60b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
