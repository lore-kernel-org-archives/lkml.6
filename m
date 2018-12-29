Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6738C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9192F21919
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061827;
	bh=7iixA7j4UJcF3FUD80YoIrz7XSZGDRfoA8v2VEgMIJc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wsFf9H9LjjAV8DJ1dGHTddvIbwmB5EkIP276U4hxqt4MuFMY2XRDlWcV8YCP9Wc7J
	 TzwT8SXCKI5jJO8ZDVqwU8G415tue5cZPXgq3SjVMdq9K1jsFbyGGSGWYMrTiFxrUC
	 3pcyI1gkfLvAl9J2s6AvsiU0SzqpavDCnHoDSu1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbeL2FhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:37:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeL2FfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:05 -0500
Subject: Re: [GIT PULL] hwmon updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061704;
        bh=7iixA7j4UJcF3FUD80YoIrz7XSZGDRfoA8v2VEgMIJc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wqzQBxpzi5twAB/GeVw6N2U2GxjAa4GylfrhW0UinIrQn5gjLEt1SlV9sh1xDxR47
         +j+Mpow8HqvbM725BUfDi5KURH4kKkwJ454Yd+2VzGB/Fck8/rlJRGxN0Q2gweCL7l
         DF6BT01qy8kshlxNLcPFFsoB6ERaU6OwsZYEWON0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1545603149-15559-1-git-send-email-linux@roeck-us.net>
References: <1545603149-15559-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1545603149-15559-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v4.21
X-PR-Tracked-Commit-Id: 9aa3aa15f4c2f74f47afd6c5db4b420fadf3f315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8754040378e4ff70b3bb96b1dabac62da5dfb870
Message-Id: <20181229053504.9301.28033.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 14:12:29 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8754040378e4ff70b3bb96b1dabac62da5dfb870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
