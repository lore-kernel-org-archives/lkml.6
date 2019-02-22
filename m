Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9716EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610C8206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550860805;
	bh=FxRx5bxmpmZGHF46ejO+YrSr550kTSxSVWRE1Uq9GrI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GtctDo36HD3kp9W/OTpsltR/B0C2KtUmFuykaMAr289N2HpmVctUOIo5NpGRUHLg/
	 7Wvj48yZPwI27TJSWQBVX7XT/+Il6QD+ffIDgBJsW8xuCOerqfLU9yFU3gvhyONG96
	 LLvdYmurnhwWnCDFeKnm0/fNd/kLK4zsTY8c3ERQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBVSkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfBVSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:40:03 -0500
Subject: Re: [GIT PULL] clk fixes for v5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550860802;
        bh=FxRx5bxmpmZGHF46ejO+YrSr550kTSxSVWRE1Uq9GrI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SWia94/g271nAlSAvKJJxqXUOYmroYgTYtMEG82drkBaCTlbvUCDHjeIxFDkjpKrL
         nJLm8eLPonxC1g7U34GT9fONuttJFABMN1D1dvk7ttGedNzk9Xqh817ssxcWJf592o
         UL+W3WcCg54bgzum4a+w7uGJpvH3b0sn1ncX4V10=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190221215721.3407-1-sboyd@kernel.org>
References: <20190221215721.3407-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190221215721.3407-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 65a91e2e597dea62a798a8b771edc44859037e7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3504f7a38233030def726fcfe692e786ab162df
Message-Id: <155086080285.14712.7165635314260878151.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Feb 2019 18:40:02 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Feb 2019 13:57:21 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3504f7a38233030def726fcfe692e786ab162df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
