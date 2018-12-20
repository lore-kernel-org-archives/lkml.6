Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A5521906
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545346503;
	bh=eknhtPicGeuOhld2JH3A6/Q/Vt1bEF14XJiUJj22TIU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kUWV+6FBrgsPugRW6GJyIWk/gP8vW/GIdclVlXvcLu3zTEr6l8I2EO5yJirdkbQQX
	 9b5jNCPwr9NAzb+0y08ifCSEj2JBBKimbAwv2dP/2m2Lt+9Im/uIvg5G2/bjp8Pog1
	 L5lbsFKe/1hLa7gTRgiWKLrNP6P7p6IbSE+nYw9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390239AbeLTWzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbeLTWzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:55:02 -0500
Subject: Re: [PULL REQUEST] i2c for 4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545346501;
        bh=eknhtPicGeuOhld2JH3A6/Q/Vt1bEF14XJiUJj22TIU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UJrmyDE4ayXFDl7WvYITJj0mIOeLb5Xa55s/rxspZnkGCT11d6bjBr56YYtbQAe+m
         1fUOCqIRbazmx7B6AqcqJoCw272aHFv2mDPP5wv95ZS1x4imFXuH3Xe/rhcN8Xu2xr
         h2LEBYFPAKu7LD69P2AobykhAckH/U+/7FWpUNn4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220215705.2zccmtoiuc2v74hm@ninjato>
References: <20181220215705.2zccmtoiuc2v74hm@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220215705.2zccmtoiuc2v74hm@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 32774a8153b4c62e408297fba352248afb2e0143
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9097a058d49e049925d8da72db07fffcee24efa0
Message-Id: <20181220225501.11244.37251.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 22:55:01 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 22:57:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9097a058d49e049925d8da72db07fffcee24efa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
