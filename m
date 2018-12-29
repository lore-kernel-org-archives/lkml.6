Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA817C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCDF21902
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061750;
	bh=9AP9EGBxEh0YSh6YkAn3wttTLP+Hi8VTLHsl3VSrTog=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=roeV2DoYwgpCbda2D6O7oW/hNdbAgqakztwMX4C1I9z14gsmi1fqRs7m2X38kKbi2
	 T1tJ+E50Nu/1qYtqLxZ571cIB8WSVQJYc18Z28GeoDijT/W5XUqzhizIrScR0dd6+G
	 568MQ/+DhYkmBiwl3G4mOg1hu6exkifz4McQEAeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbeL2Fft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbeL2FfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:08 -0500
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061708;
        bh=9AP9EGBxEh0YSh6YkAn3wttTLP+Hi8VTLHsl3VSrTog=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZtDSu4BnuyrgXwbR7SXOXNqPctPUNHogd50HMKB1G09IClwYH8ETjFLzn5t/xFlMw
         clOtGlrNZ8we7SfBfaLCxikVoA1VDw4hqVWndwV9FcRiEEupZSCtnQOK8R+2HCXSme
         mAM3hSSkok/7ysdfKADVNXUJeOTz8cCe1LtNC1X4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228153531.GA23672@kroah.com>
References: <20181228153531.GA23672@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228153531.GA23672@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-4.21-rc1
X-PR-Tracked-Commit-Id: 215852f4b8bbf7a8d6a534dfb367bb0f1a2d5011
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02061181d3a9ccfe15ef6bc15fa56283acc47620
Message-Id: <20181229053508.9301.45914.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 16:35:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02061181d3a9ccfe15ef6bc15fa56283acc47620

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
