Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EB4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BAC2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655107;
	bh=R/JjGQysgYW77P95MeYfiUWQlSJ5rLgNGa4Y7k1ubsk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bzb3ZF1WicbpDjZvFoefNLmFU4zdVL7TgouvzDYzpLP2g3sqWVdlntCKf5SZVlz8f
	 GRQlOx6CRPYuDy7TH7qk4/9gBz/xNog9OehXoa7lmxi3DNO4EDZSaJk7idTn5gU9hL
	 3imiBPOql1Rn/SRjlb+s2OH3PKudMFa0apjQ/xiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBHTpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfBHTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:04 -0500
Subject: Re: [git pull] drm fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655103;
        bh=R/JjGQysgYW77P95MeYfiUWQlSJ5rLgNGa4Y7k1ubsk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qli6vElu7Br6gns6//F1ISsRaw/EqfVXGzhJ5rkqf6Du4qoqN5uEE1xM/66ih0Twk
         OddNB1ECS4CO4yTDPd4WRXglEs7yNJBfttQCIOzibA8wyg1voFrdHLGt+DO76HW9EX
         VqEO7PhTkM1A5Bf6w/RnesTqmtxotwEwJUPgnIw0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyDqeLkmSOcru20dnmyRYp_ne7sjeP=4K-kmdc=VvRxdQ@mail.gmail.com>
References: <CAPM=9tyDqeLkmSOcru20dnmyRYp_ne7sjeP=4K-kmdc=VvRxdQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyDqeLkmSOcru20dnmyRYp_ne7sjeP=4K-kmdc=VvRxdQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-02-08
X-PR-Tracked-Commit-Id: dada163c5eab43adf2c7595bc6d562748e1eb69e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adcbc921d3dff0bf1657d4d31beee68f92f51538
Message-Id: <154965510391.5511.17505001647247460930.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Feb 2019 19:45:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 11:05:22 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-02-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adcbc921d3dff0bf1657d4d31beee68f92f51538

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
