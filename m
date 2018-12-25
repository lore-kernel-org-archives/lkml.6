Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C724C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09362218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780019;
	bh=RRizArheYyN4DQae3wbXmRLo/d9cat97NkmafeWx4fc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KMvs0i4qtwFBu6hLCTyX27EUvuPzpOqv7ndolLKLjt2l+NMQ8vXxDVgD4kRSw77Xk
	 +T5SLWhbKdDAGkzVo4Q2BRLZpU3r4izTd2FdoS1PqIfXwIqqNEW7Msg4RCiI7Qr6n5
	 e9ShhpqfalmzFYno/3kaQXRxgXZ+IoSYRt0Q/kPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeLYXUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbeLYXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:08 -0500
Subject: Re: [GIT PULL] regmap updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780008;
        bh=RRizArheYyN4DQae3wbXmRLo/d9cat97NkmafeWx4fc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d9GLTFx90QyUDYTKjfWb/dWjpX14kV3jQ0Hd71LQEzIHMQslQjxL+wNvV9vMWMyOq
         vw72lAGEWbDgIieOFYjnYASbrkW4YKCukQ8i0uJ0fCGvR9SAVTecYIg65M1rRxGEEb
         k8ICouDyStn/EqqI3UH3IinpzW6AayEw+ARtKLQ8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224191532.GC1846@sirena.org.uk>
References: <20181224191532.GC1846@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224191532.GC1846@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v4.21
X-PR-Tracked-Commit-Id: 58331d618bd9ced88a21a9b68c7743b84c2f4803
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1669432b3555954124ffd987a6ff2308344c88f
Message-Id: <20181225232008.23808.82183.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 19:15:32 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1669432b3555954124ffd987a6ff2308344c88f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
