Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427B6206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545322205;
	bh=vvh4HlIlesO6QIoqyU7044i8P0XybrKhZtD9nYIJkN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pOpSvf1Bez38hFVR2mFXjGRA2Yu/Cw4UOPUWlGNpN4f7pfIbOZIo4Mp86ThgBH6PR
	 7EIzZWh5BQQcfG+aM/sF1M8DuSVsLA3HnG6b7NPGLA/lEzFCeuT2mo7Add9l+/bkqK
	 HJYferpADld9tbx7dP91kEH72CkjA81Q2cxAwdIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeLTQKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730526AbeLTQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:02 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 4.20-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545322202;
        bh=vvh4HlIlesO6QIoqyU7044i8P0XybrKhZtD9nYIJkN0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yFcAd23nvJ/qVEHTCKqYgeXF1QYLeCK9XsvcIMWIQH7YOXQw/3YHlENwNzfXO65i2
         iSUTbk8HYIGSy0m0K70DoH2a26Czj34eIyC3hQ20geLGypZfgKxJzZBnq6kh9stLxu
         ChYCheFzO1MlaIH891Gf4MfkZy0VcllWg5GK2wz8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220123931.GA18376@kroah.com>
References: <20181220123931.GA18376@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220123931.GA18376@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-4.20-rc8
X-PR-Tracked-Commit-Id: 55449af1a17a4f32178b42d8ba4ee9477fe9a00c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 122b7e33804d928f8f53cf9d25762c40b8148a02
Message-Id: <20181220161002.12746.3533.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 16:10:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 13:39:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.20-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/122b7e33804d928f8f53cf9d25762c40b8148a02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
