Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD79C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A721925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550250609;
	bh=CzbGNSAj92JO8OwJxvQbzTDylckZ1ToC4yjiDwwK89c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wHvj5r1tZ8aWQQBlOr0XrNKe/NJSXBRHCi85ejWYVFzS6kaRvBPGosPBZhS4l6FiL
	 AnVPeArKdUOle6gdqzazUqu0Bcnl8mrHC8/WteXTqfmufiH+LVaBwQdMYqRtrzCTho
	 bOHWApD/kMSvn7bhACZpHThW/B7BN9bouaqJx5cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfBORKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbfBORKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:10:04 -0500
Subject: Re: [git pull] drm fixes for 5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550250604;
        bh=CzbGNSAj92JO8OwJxvQbzTDylckZ1ToC4yjiDwwK89c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uL+MNadVR2IPPRO3YvEMn/Z/yAKNhMC91kNfzv+MZ5bmrHJIc9HcZNpBhybRuYjMY
         xRw8v4fXrqWmU4gA3L31egVAhXwQ5nrgWJpaNuzsH5u1/rexmV2Phv97QjwA3TZXY1
         cnGuUGhSlFRwpuVMW30jb1W6P+sllWCaOJ+AGV3Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txPE7gVooSFCyOt0cvGOJnHaq7xF28YydC17vDCemGB4w@mail.gmail.com>
References: <CAPM=9txPE7gVooSFCyOt0cvGOJnHaq7xF28YydC17vDCemGB4w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txPE7gVooSFCyOt0cvGOJnHaq7xF28YydC17vDCemGB4w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-02-15-1
X-PR-Tracked-Commit-Id: 69ef943dbc14b21987c79f8399ffea08f9a1b446
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 545aabcbdcec6c88faa3dfde506ad1931d119f52
Message-Id: <155025060411.11780.2965811560438439564.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Feb 2019 17:10:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Feb 2019 13:17:43 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-02-15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/545aabcbdcec6c88faa3dfde506ad1931d119f52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
