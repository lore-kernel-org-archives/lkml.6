Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA7BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA72320879
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484704;
	bh=RLbHI34J0YgLbn374kaeXeNUOrzyupgNKBFNndfVyN8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j6RaewiMvyaY7aRMlukleqg6eXxxWOw+g3YgGkc56+nsuaDGeCsIY8FNmFGPo5kCH
	 VgH5Vn6fTzwbEUR6GOpA5Ze9gZbqMvxTRlYK7PipvADy/jbe/NDzsAU3u/EUMwNwpi
	 02U3Jdb1fdN0l74hgNAQ8/S+BMyQ+XccWoYPXhq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfACDFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfACDFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:03 -0500
Subject: Re: [GIT PULL] Mailbox changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484702;
        bh=RLbHI34J0YgLbn374kaeXeNUOrzyupgNKBFNndfVyN8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=omLfQ9RwQHlK8BCgMuqH5EWgLXxp0nBlqn+hE+MrXhTUK0jMmpH2qqTGBl1sTTDr/
         E/6cX1uYWD5Tik84XD217W1Uesexrt29DDxvdA/EUmYpZZ5SMz7rAu29+xsM3Kh1gm
         3ZvhpRkbLsyMEa5XVAaajOoqRGGO/1lwIN3+eUOo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY1ZO8pCuN4o3ja-Lyr0G6CVSUJfotcJcEmfJ9MHEAneSA@mail.gmail.com>
References: <CABb+yY1ZO8pCuN4o3ja-Lyr0G6CVSUJfotcJcEmfJ9MHEAneSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY1ZO8pCuN4o3ja-Lyr0G6CVSUJfotcJcEmfJ9MHEAneSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v4.21
X-PR-Tracked-Commit-Id: d69e11648e486ee0f21cb246f687b083f0d4e124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35ddb06a467538434b4139fbf5c02a2ef073162a
Message-Id: <20190103030502.10885.28248.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:02 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Jan 2019 23:34:36 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35ddb06a467538434b4139fbf5c02a2ef073162a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
