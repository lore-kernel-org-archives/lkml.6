Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5760AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F200207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655139;
	bh=2WkfC2SiLM4i6Fgwmp3JE1gA/kOoyt0FkSzqQNmiw/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AuuxOqDexOsXjEUhw1s6mOuqsjJuieWky4dWVtFne0yFWta+9o+8YJANJJUg702ga
	 ZNaMKXpWSCtuY3b35xmist8/hThxC6VPmYUKL+LfawAB6PUHFmzkAECAMWdUiKhze5
	 R9r0aRfCvEKD78LZZYRd7Gjqe+kAxwc3Mbmg+f6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfBHTph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfBHTpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:05 -0500
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655104;
        bh=2WkfC2SiLM4i6Fgwmp3JE1gA/kOoyt0FkSzqQNmiw/M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cO/kq9La11T9ZPult5CZqhlDtEcf+Wm7/vgmHg05FT976XtpRFnYeJAeI6ep5UiSp
         6uqCkIYeLu6Oks145+/IJR2rCqQ2XP0qS74GMnfnVWiKi5SKlfZTMMh8Luz5y4Fl4S
         CZRLqnDYceIq8VWW4cZHYNZiG1MGAnawLpdGR7e0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208083808.GA26882@kroah.com>
References: <20190208083808.GA26882@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208083808.GA26882@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc6
X-PR-Tracked-Commit-Id: fedb5760648a291e949f2380d383b5b2d2749b5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e22a15d1c4b36877934ab360aace41ddf8a6577c
Message-Id: <154965510468.5511.9347047918111665707.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Feb 2019 19:45:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 09:38:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e22a15d1c4b36877934ab360aace41ddf8a6577c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
