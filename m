Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2711C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41E520651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547490604;
	bh=2el2XvlYiCDK3mSzRwDor+VZOx8ycyLCpEnI2UtuyzE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wdZKfJLZL7i/H46b0RGpuL+j0fFue35Nnxz7j1wmHJgTjFVNggChefSXiY+Y8XGkA
	 dEQYG/nXSWB60FcnpephxU0wI5jZTEZtEbaLxORLBfMXPs1C5t+rdOJD9rNJdwf/mI
	 3Q6sDJHOsk130CALL48Yzj2aJ/f4HGPTOY7st7NU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfANSaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfANSaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:30:02 -0500
Subject: Re: [GIT PULL] MFD for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547490602;
        bh=2el2XvlYiCDK3mSzRwDor+VZOx8ycyLCpEnI2UtuyzE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mZg2CmsArspP6bpEzfDtggeIX094lnDcYZikJBisvkVqRNIUfQKfDgYXUp83jP0MN
         lr2W7uEohZDRBVQjvhYWvTOoUzmHIPj923BnZ5cDB7ZSIbErvOIz6HlKhj3rUbQWJv
         FsamGsaurIrqlo1Jd5Zt+QiHKpe8k02N5C6t4kag=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190109072018.GB27286@dell>
References: <20190109072018.GB27286@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190109072018.GB27286@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-4.21
X-PR-Tracked-Commit-Id: 3f2d347e851ef4464dea49504cde85e5eef67b2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9deb9e1637761cc4e6df5104a34197ef0bae1358
Message-Id: <154749060218.22817.4601951682258390770.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Jan 2019 18:30:02 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Jan 2019 07:20:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9deb9e1637761cc4e6df5104a34197ef0bae1358

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
