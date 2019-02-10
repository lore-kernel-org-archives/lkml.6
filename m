Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB92BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFD520873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549824305;
	bh=cKGj6M4VOunsgjnt9kqQESz8y5FWILkPxpqGgJFzFZw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EDItmPKBwnUDxIe1ShkX8PJiO6Uv1+ZAdTdfinqCgAIxkONHgqORCT8EEo6CSthfP
	 t6r26WYNCnEeUfXO6Kb5VZj/dZ1Kxd3MALcLlwcXfjWUT8jwu9B965BOokMrI3PyPb
	 HQlsd2SddbAy84z4hHE5eYtCY9j3SZV7vLqFuHMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBJSpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfBJSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:45:03 -0500
Subject: Re: [GIT PULL] dmaengine fixes for v5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549824303;
        bh=cKGj6M4VOunsgjnt9kqQESz8y5FWILkPxpqGgJFzFZw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VjmCDWxT9zuTPYxWymcypqTdvq+8Xs1wTsudXK8FkfwvH3zwSwf8UXnAbk6ZmR/0E
         HXQ+e01fa+8WdKF2C1RO6ZohiX++hYxGoyMjmuo2mjYlkL5p9gZs+FX/+CQ0VLxajj
         ojZjjRvXA5aI1fM54FhYf3VQXqCbbLO5CUw1ZXFk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190210151722.GM4296@vkoul-mobl>
References: <20190210151722.GM4296@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190210151722.GM4296@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.0-rc6
X-PR-Tracked-Commit-Id: 6454368a804c4955ccd116236037536f81e5b1f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68d94a8424352d723e4991de4745ce6795b23069
Message-Id: <154982430304.5227.2428190352495582336.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Feb 2019 18:45:03 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Feb 2019 20:47:22 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68d94a8424352d723e4991de4745ce6795b23069

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
