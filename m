Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EABC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA4121903
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061705;
	bh=UZCTfB5Hg9ktzGxWDm9LmiqABrpMVN5fkeZHaAjzhL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=t03IUqcWQ9s7p2iKzj2c+69p5M8pY+iK4XsEriF1xsnaIUXx+VvNFpLZTWTY1+MgE
	 +EvcurRyP//Q/1gU4+zM6Bw8tSvES5Y1rqwnfPS9/xGT2L43PoMTmpyvhJU2eJMKU7
	 xa7d+kuBgCE+JKIBHB+R+zkk4JypjyoOl/qxwoW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeL2FfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeL2FfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:04 -0500
Subject: Re: [GIT PULL] VFIO updates for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061703;
        bh=UZCTfB5Hg9ktzGxWDm9LmiqABrpMVN5fkeZHaAjzhL4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iyHjOc02Sy7ad3GeWe0zpEP8oBTgAxKg1i2dAVNZ6mFbHWi+IDZ4XKM/U7sZmS3Pu
         k5VkcDBV+igNZBMKIoGssyf3dqW+Y7bOzqAducObpEUorM8R8bmsdXEEMMCIPEh9yx
         mngp1kLHzTTueUi3yCd0euV4dIEPNP0DsQuR/NXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221093130.3c2fc1dc@x1.home>
References: <20181221093130.3c2fc1dc@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221093130.3c2fc1dc@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v4.21-rc1
X-PR-Tracked-Commit-Id: 8ba35b3a0046d6573c98f00461d9bd1b86250d35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1984f65c2fbc0d2b557d6e89ece9b39267e215c6
Message-Id: <20181229053503.9301.84374.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:03 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 09:31:30 -0700:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1984f65c2fbc0d2b557d6e89ece9b39267e215c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
