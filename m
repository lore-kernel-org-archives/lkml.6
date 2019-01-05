Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11309C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F5A222CF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546725603;
	bh=2YYjk52qndLTECYcacFYUiFDcTxczmu2FMDQzG2oQxw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=beEAR7qVl/3FEcc8yf3Wa3UX+/xclZxjuxvTSZdUoGOdGQlSJfxLxiGRZ5u2B7xg3
	 YoNaJph/I50CNXcC8ShUOZKFOXD/fROO9LOgHdBZmjv8NOfIJueG/I6FySicxxFHcK
	 wL/oTcWY2PYTB1bYHjyBfKjrsCSjdpKD/Yif+HtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfAEWAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfAEWAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:00:02 -0500
Subject: Re: [git pull] vfs.git mount.part1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546725602;
        bh=2YYjk52qndLTECYcacFYUiFDcTxczmu2FMDQzG2oQxw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MShm8ga8UhMe6ppga6okz8kiIvQVoBLf1kVU5dEKi5Hwam1VF9qAk4I+mrOdUnCGm
         /eGvudXmSziz/E7w66SNcTiWc+unA4ml+ZELHf6FXKvU3BnGELqTcgJ9Af2VkJ7TcR
         vkQFGq5tjDgKsNXKWq27JCXk38diJQw8pCbEJmSE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104192648.GO2217@ZenIV.linux.org.uk>
References: <20190104192648.GO2217@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104192648.GO2217@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git mount.part1
X-PR-Tracked-Commit-Id: 718c43038f287e843c2f63d946977de90014cb11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 505b050fdf42097883b2d37b8e796e1f11dbef50
Message-Id: <20190105220001.27008.20791.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 22:00:01 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 19:26:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git mount.part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/505b050fdf42097883b2d37b8e796e1f11dbef50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
