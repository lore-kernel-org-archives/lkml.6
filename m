Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27566C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACFF218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061733;
	bh=Nr/B1Sa4dg2sAUlvMfLgZ79O1HiW7B1SGeoN8JZSH3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zgH7LA4MX3S9kYlByQebKDnAlM+057vx2ZTKYpiHZN4QKZ5Rci94hq0aNDdqYTWcz
	 p4mzv1av3TSQ52TsH3CTL2+qGeQ5xSnvOBaxgDAXouplqsytzHnKyQOINkhu2CTYN7
	 8t0KubULMz+NBNsO6J1NKFJgYI4ylfSEGdNuh8k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbeL2Ffb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbeL2FfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:09 -0500
Subject: Re: [GIT PULL] Driver core patches for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061708;
        bh=Nr/B1Sa4dg2sAUlvMfLgZ79O1HiW7B1SGeoN8JZSH3Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tCirSj29K0TLXD8jW6lQXkhGHKPyrXwNeExJCUgHkDpNtnVNm7ri+7rK8yu5RlQF5
         Bo8oMFqxPj5W8iovxy0BS06GrmLbtcIDjsjNura3TKWOqmlPifdKFCWZ5f81R1G/63
         tGGdv1CFHY3h15rjS1ttv2BFS4Ot2sY5NFGkI23s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228153609.GA23789@kroah.com>
References: <20181228153609.GA23789@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228153609.GA23789@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-4.21-rc1
X-PR-Tracked-Commit-Id: 16df1456aa858a86f398dbc7d27649eb6662b0cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b07039b79c9ea64c1eacda1e01d645082e4a0d5d
Message-Id: <20181229053508.9301.42578.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 16:36:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b07039b79c9ea64c1eacda1e01d645082e4a0d5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
