Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC2CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173702087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548870309;
	bh=ovwVrhNK/0JYXcovke+s4NKv8M5Glt+886RpgAGnaFU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gLCHrfq6wRH5LvLdNsGhMPt0bH2wKiqOzHcsoij3Wq2cXq1e5tmtdZgCiK+dsXE5t
	 iNsf0MIhC8NTde8bIcmHJDkusY71PxktfjU91pVFVLxJLdkRafxgCLSHEi0BjnBa2W
	 qaOPVnKiGyKpRtjg7AYkxyusiqpaqG6CwotjvXpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfA3RpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732627AbfA3RpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:45:05 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548870304;
        bh=ovwVrhNK/0JYXcovke+s4NKv8M5Glt+886RpgAGnaFU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ea8cgmx3xSYBjT+iM1r6WIXvsJaXFGyrkvQdS984gwKdSmKSRR+VANXoIY4pLhBWw
         m4m/5FAIzl/4CtknAXHXEx9DxK80HUEeNKe+q8raD+lJQkzSjmcPeFFA1he65aGhHU
         MS6gS3FFITlSQaxL+uW6PQDqTpV5BgN6CzUpOQGo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190130150619.p36c4rzds3lhl4xp@8bytes.org>
References: <20190130150619.p36c4rzds3lhl4xp@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190130150619.p36c4rzds3lhl4xp@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.0-rc4
X-PR-Tracked-Commit-Id: 9825bd94e3a2baae1f4874767ae3a7d4c049720e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c0490ce902206f4685f812fa81304fd1adf4e35
Message-Id: <154887030493.3523.5886123467884017127.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jan 2019 17:45:04 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Jan 2019 16:06:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c0490ce902206f4685f812fa81304fd1adf4e35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
