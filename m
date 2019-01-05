Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948FCC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596EC2232C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546719615;
	bh=aYrHD8LnV3A4aVNdm/OHwy5qY3SSpulcmuRj10PJyiI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=beNBtrWSv6XCbLwp22nssf7u+i4xPFZLzdhU4pw5OFlMJIFJxgWB9f3o8FCXxJePU
	 fAejcIqfjKqsiCyKSvLsXYCsynR501xfVA+I925Ge4C1xxl9FPoCoDb0hCF/tBKFis
	 8BJMpYJPlDLOYRnVCOS7/U3uDeMr4cI/iqQC7cyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfAEUUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfAEUUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:20:04 -0500
Subject: Re: [GIT PULL] csky patches for the 4.21 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546719603;
        bh=aYrHD8LnV3A4aVNdm/OHwy5qY3SSpulcmuRj10PJyiI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JB9vdAiXYTanWSnKLhmPiGjYK1TrfPf4NLK2o4g0aGcndWO67acALRqWZo+4FeOc7
         6YmVTmXl9V0XChGyJ5V3lIK/xc0L5NoGLNX7nZ9pV9kGBsAfhi+WT40LYRHueNLJpK
         k3twpmz4VzWAL+1vK6swk26/O/03xO9fklfop7oc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1546507560-2486-1-git-send-email-guoren@kernel.org>
References: <1546507560-2486-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1546507560-2486-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: f50fd2d8524c15b08da9e7e9d84752f0f1be7172
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ee3b3f4a5eb523ef27675ac2fcd2269b9d68767
Message-Id: <20190105202003.12651.28539.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 20:20:03 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  3 Jan 2019 17:26:00 +0800:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ee3b3f4a5eb523ef27675ac2fcd2269b9d68767

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
