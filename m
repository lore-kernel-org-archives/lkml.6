Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B4C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DB821872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547239210;
	bh=B+yduUUIwCD7tw2+nNifrvAkOnqhEsYI9yy1qrk/zpM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y7+wpgP63MhSLzb/kSEc2hAj3PmDsOTI4DS/Txv1+fm4wu0g5zkCrvhG5ja+jXhXR
	 06RXzyw9CBEBF0es32ysv/NKYONMr3MZl4KQE135v4CiBugbc+vNM+M8idGJHwN7en
	 d2EauhvUggvW86fGqUJBu+UJDWtHpQWJDY2bdnc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfAKUkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfAKUkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:40:02 -0500
Subject: Re: [PULL REQUEST] i2c for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547239201;
        bh=B+yduUUIwCD7tw2+nNifrvAkOnqhEsYI9yy1qrk/zpM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ur6w1erJmj3FrzQTi6k9bUhF0LiBt1yzwANA3p3h5FWecdshmM3/6JJ7P8v7N0Lb7
         DnBXRHgphmgdi675pc4Vuuudu1U61FL9akNUR5O6gLBV9rL06gOiMiBdVGd+b3FUA+
         wdaTxpxd2ThBiWTPDJwWEgH+/vfrf7Rjr+uqVajQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190111185648.GA9214@kunai>
References: <20190111185648.GA9214@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190111185648.GA9214@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: b67d4530cdade7ebfafa2c6b46f2a0dad3e41bcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b3c31c8d4dda4d70f3f24a165f3be99499e0328
Message-Id: <154723920176.6200.4730029465296064601.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 20:40:01 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jan 2019 19:56:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b3c31c8d4dda4d70f3f24a165f3be99499e0328

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
