Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10C2C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751EB218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548546306;
	bh=3dV3kKogh0OzNOl3CXrt4i8GzFbwxMpyqE1kMI3yMsc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Iquv2s1Zrnoos/mf7BPvD9fPOc1JelNLHuR6hzpe9vHYl2RwgYLqcf1BETfjj/628
	 sb+k3AxPrRPDRv2tcfUAMpHRO+tNAZYlMJE/wyQHajAuF/DVWsfRrDi5X8ak7KtXmz
	 lQ5EAKQ/QofHeBFGrwqH/tZ/djuEgwip5BccUKyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfAZXpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 18:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfAZXpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 18:45:04 -0500
Subject: Re: [GIT PULL] VFIO fixes for v5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548546303;
        bh=3dV3kKogh0OzNOl3CXrt4i8GzFbwxMpyqE1kMI3yMsc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oBYH++5dD2OtRRCji+nTlDoWAowgr5Xlfhd+zAisUrF4oWphwMYwNDwIwMQwW4bUT
         4H9haaVvx5xWllkg0XBKCjhp5XbplSFT4eflh985MOLalkwYOIad87eBO0Qt99rJvg
         XYoVcMTojdInKM1uNJXv9WGeJAHBOe4JD1Kcd/po=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190125141724.4e5c446b@x1.home>
References: <20190125141724.4e5c446b@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190125141724.4e5c446b@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.0-rc4
X-PR-Tracked-Commit-Id: 9a71ac7e15a723e90fc40388b4b92eefaabf747c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2580acb2a1b12f93f8259ff2053cec455d1d22a7
Message-Id: <154854630358.17010.8019481705438354881.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Jan 2019 23:45:03 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 14:17:24 -0700:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2580acb2a1b12f93f8259ff2053cec455d1d22a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
