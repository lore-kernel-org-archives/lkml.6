Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8747C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE5F21721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548095703;
	bh=TwxWJ31J3ew1JlpR1KkJb09NHvDVPAeYZTfAsZt6Cb8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1jmu0EhUn55Q1PVSXcfB7I/kIu1AWiog/WnLT6tjEh1dRh9eNQ0iPWwAZc3JVMEf4
	 2Cj33TX4DZA4kNV49KXXdJTXDruVdbd5sB29kAcXumRWYCtogcic+E5u0Q0v4Mg8eC
	 6G7YA/o5Gkx3BaXnYnlPswJ50j6cbU4cZPfwL5k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfAUSfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfAUSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:35:02 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.0-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548095702;
        bh=TwxWJ31J3ew1JlpR1KkJb09NHvDVPAeYZTfAsZt6Cb8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DAHncaw5DP9ACv3/7wDHAh1YDAsKWzj7ap7NgmY+UxBe2t45LFL2Zc9DPWUmhpLx3
         IbzCaSDDEmPL1tL5JI8xLPATWUmZEB/VOY9wz6+5JWaOK0d4Yff5rFIthJiNo7FSgU
         BIYRzPIAV5/5XzOxbBBLs8/CsUWt/PyMwIldnsQE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190121094536.si5x3wltlllsxcod@8bytes.org>
References: <20190121094536.si5x3wltlllsxcod@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190121094536.si5x3wltlllsxcod@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.0-rc3
X-PR-Tracked-Commit-Id: e8e683ae9a736407a20135df7809090a446db707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52e60b754438f34d23348698534e9ca63cd751d7
Message-Id: <154809570198.8142.17981951725375784933.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Jan 2019 18:35:01 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Jan 2019 10:45:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52e60b754438f34d23348698534e9ca63cd751d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
