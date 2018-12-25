Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45EDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B146121726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780141;
	bh=owtxcIYtU7AVaIWmdr3AD7QiZr3VK0Q8koo53hN1tP8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hC0BxcVK9rrsn7/STabFdsSMMkm5vqGXHAS0yYG/Z6fR0kPO5XkNzWzhkyqL06kOU
	 J9ckdbgGjekq0zWbe07kCqBCXiOW1An7n7lrl08KNnV8tt443yy1MNre+cFY7c6yQz
	 aflKjUebCKA3ZkRbyWO+lL7aNdtdjriACNsI42Jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeLYXWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbeLYXUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:03 -0500
Subject: Re: [git pull] drm for 4.21-rc1 (for the merge window).
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780002;
        bh=owtxcIYtU7AVaIWmdr3AD7QiZr3VK0Q8koo53hN1tP8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H1bW8nfOuLMlNsy5xFlgp0aNRc7Y1WRuqz6+f4fPUrcYb2Z58VRlo2JnxTYuUPmUO
         kXJY5VYtt8XlIKUeYbbLB8wpNYyA39PpAQJGZ/+ESGPUYclcNJnr2dttpC/sAkvNvK
         ke/rQB45XZxkrHrScw3b2/J8zvMzQtDIFf/mw30g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzYVESdJ7tpsJCPCdkiwoF98OScEosN10Kp_hUHb0c4hQ@mail.gmail.com>
References: <CAPM=9tzYVESdJ7tpsJCPCdkiwoF98OScEosN10Kp_hUHb0c4hQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzYVESdJ7tpsJCPCdkiwoF98OScEosN10Kp_hUHb0c4hQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2018-12-14
X-PR-Tracked-Commit-Id: 2a3c83f5fe0770d13bbb71b23674886ff4111f44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4971f090aa7f6ce5daa094ce4334f6618f93a7eb
Message-Id: <20181225232002.23808.16384.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Dec 2018 13:20:36 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4971f090aa7f6ce5daa094ce4334f6618f93a7eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
