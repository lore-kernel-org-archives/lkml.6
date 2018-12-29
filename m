Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE609C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D306218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061730;
	bh=U3Js1FdTSKXcc5k1NjvrHBYhJyrQqQPUm7ZSjl+nBPI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=up/Ma0HxpxL8CCvLxm2T3+928EURmNQSzdUx7rEa0n8GRnVHfxvm3QRUrHf2QrOcg
	 DA7Qy0iSBCtULg/GPmiqUZzPbiDgYijqo3tP6I6zY8Rxf+6ScYBaDFp5Fo4sCf5yNC
	 80QZZsmpkld3GqRG3FTPGBLhowqWF2m7pg9vDGM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeL2Ff3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbeL2FfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:09 -0500
Subject: Re: [GIT PULL] Char/Misc driver patches for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061708;
        bh=U3Js1FdTSKXcc5k1NjvrHBYhJyrQqQPUm7ZSjl+nBPI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IspU9jwScc/Z/7bN44wd2UUnWBYD8mVOmlTS1yv6MCBuc8pR/wZ/M4bvEm9UvDfV8
         gw1lI6/GXnoFKU4kAr+Xb5c8uLKyJKhP+EBhaG7p59Pxm7cfSCxYNqfSHN0tOfK3ML
         WUZTT/40O09OJ3s918CDfY6dF++h/41Z+ZZSe3vE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228153653.GA23909@kroah.com>
References: <20181228153653.GA23909@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228153653.GA23909@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-4.21-rc1
X-PR-Tracked-Commit-Id: fbc4904c287778ddb74bf6060ac9dec51992fc53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 457fa3469a65a524be04412f5cd497fa3b11c9fd
Message-Id: <20181229053508.9301.49243.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 16:36:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/457fa3469a65a524be04412f5cd497fa3b11c9fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
