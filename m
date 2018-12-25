Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7350C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B415E218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780047;
	bh=4DhEcdeRKMw7B57jP9fm4dwMhrCGDP2nrcT9635Ilx0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CjPExC2WMWBUhUcJRiOm5qtj8Y6/DmdQ4FsW/4Jzs44W1qkpRGRusWV6AhpI8q7/p
	 CBvKFhmQNF4ANAi1EoMzTzwgy5OYQf9wO0chzgHhCUTB6ehY6JBb8FocrwxjDKBpuv
	 UHU4n6Gw+wQFJHiytZ9yHait8855YbwIOfuyn4/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeLYXUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeLYXUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:07 -0500
Subject: Re: [GIT PULL] pwm: Changes for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780007;
        bh=4DhEcdeRKMw7B57jP9fm4dwMhrCGDP2nrcT9635Ilx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lfetLR0o403XggksIoUIPhNoQOpAXCAspeqEQf1YGpthJa2a4aeuoBEHwrqg5Heiu
         mPbESYWj0ZE86OPtyL2xUSNSYS0mFwQ/frKmCLER5U+WBi0gqyW0K9QR/gcZoM7myH
         F3tiNX9Dz4weujUt6+BXXDB4BlMbe/97yB14JdDo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224111508.23847-1-thierry.reding@gmail.com>
References: <20181224111508.23847-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224111508.23847-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-4.21-rc1
X-PR-Tracked-Commit-Id: e94b815524f83536415d7d59cc1833ad05934d97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d923fd6dc133ee8d8fe800e4e4beb9175368b21b
Message-Id: <20181225232007.23808.15513.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:07 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 12:15:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d923fd6dc133ee8d8fe800e4e4beb9175368b21b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
