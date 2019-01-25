Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2950C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815E5218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548379505;
	bh=LTRSXxIB1xlLqmY4jPZou4FeJmgrirOn2DuDu8bGrJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ax13htVktvCexm1OYDtFayc2xdaHrsorbfJHtxgdNNOVdv/QcPzb1wOndsb0jOjxP
	 ceNW0LWEgBBI57VG5fEHIpWAtGk8li5molxXawpZQfJu49HU3m1wKbQsz6nDy3EUA+
	 emgNP8VP0eDdadXiMHGM2onA4gEgcpbTurdmDxPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfAYBZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfAYBZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:25:03 -0500
Subject: Re: [git pull] drm fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548379502;
        bh=LTRSXxIB1xlLqmY4jPZou4FeJmgrirOn2DuDu8bGrJI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r4C6EftVUgUd5AqeVB1FDCB1ns2kMStyEhPZXsE3rQP1fpDw6PIb2Fx/G2Cx3v0MR
         W4MSwsj0nrIxZcXKCulDFFh9ZPg2MRTChEMPuhu+aRGEfm5RmI9E/zOwuzpZMWuElf
         LrdznZfLK9YaOAtwmAQ9Qoqd+By8+4EXieyNNC68=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzmQ+y1tN5FgM=wzutCt37nNKD4kf7P-RWGF6f+skGCOQ@mail.gmail.com>
References: <CAPM=9tzmQ+y1tN5FgM=wzutCt37nNKD4kf7P-RWGF6f+skGCOQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzmQ+y1tN5FgM=wzutCt37nNKD4kf7P-RWGF6f+skGCOQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-01-25-1
X-PR-Tracked-Commit-Id: f0e7ce1eef5854584dfb59b3824a67edee37580f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d73aba1115cf40630cc8b4b7aed049ed8117b458
Message-Id: <154837950279.17316.4133091445436340435.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jan 2019 01:25:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 07:54:37 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-25-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d73aba1115cf40630cc8b4b7aed049ed8117b458

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
