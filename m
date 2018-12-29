Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDE2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E231321902
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061729;
	bh=Fnf6IQm5pLDPuORD/RxH5cFpIrGIKqfBd95XDTHeDGw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=txQEcXtw714AVqdms33cHYsElb21Z7eNdynnBsd0YNb5n/nuJ4eFlqfAjTPCEuKlr
	 +V1+CA4zfPKrC69WXObiStxfMuQOq5N7+n2pKfLiAw9K5mxWVEYtp8921at0GeiXp6
	 hPQ205TnPM5Yu5ixu0ed0RC/VqDQPG1e9iXqKmXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeL2FfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbeL2FfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:05 -0500
Subject: Re: [git pull] drm next leftovers for rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061704;
        bh=Fnf6IQm5pLDPuORD/RxH5cFpIrGIKqfBd95XDTHeDGw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d3cC0zesZli1hlohwXE2Uit+7YnyiBGqo/GPts9+xGTMosIQOEfkldYhkmToQIpmQ
         Bg1DE1JH3UKRsB7SJjZe5Y5AtHx0y+rAXwhbaL3bvNJUvq3hV3EQ2enFNJoB3/v85X
         kTtz7uFYi0HpQoQS/jxoqW/0qpMsgWDetJLYnJD0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyfyF0seDFRzycL0OBdquaj09BLU9Ft8datGhKaZfC2ow@mail.gmail.com>
References: <CAPM=9tyfyF0seDFRzycL0OBdquaj09BLU9Ft8datGhKaZfC2ow@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyfyF0seDFRzycL0OBdquaj09BLU9Ft8datGhKaZfC2ow@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2018-12-27
X-PR-Tracked-Commit-Id: 221b35fedee1b38b9cee99320f0c60263d229e14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e59fad9c9d1aeacdc96dfffd35f9e12ddc34dbf
Message-Id: <20181229053504.9301.94462.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Dec 2018 10:09:49 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-12-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e59fad9c9d1aeacdc96dfffd35f9e12ddc34dbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
