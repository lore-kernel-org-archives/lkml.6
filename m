Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC8AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2752218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780037;
	bh=i7BQDDVPrlKeyXVcQUIGYOFACCIryCE5bz6fTGGEQ9c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=njO4YvibuUdCrT8QsnShe9wDxuGCQMNDV1tFDpX3ub3iCcx2w6eQXabkEiUoQ+8iX
	 i+mhIRrAvmFdrWbmW4nhm7lXdNKnJGUTN/1IaaSSA02gFK6untAWWkY+GwNiHB/cAl
	 2409oRSCfmAprxZkyfxhhltgHJ98tX4E46+ZytTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeLYXUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeLYXUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:07 -0500
Subject: Re: [GIT PULL] regulator updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780007;
        bh=i7BQDDVPrlKeyXVcQUIGYOFACCIryCE5bz6fTGGEQ9c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vy3gKDObrViURijMcmR0rsu6kaM7Zib3Ob7UqhbzylmAZtIN3lVNispZs1wHgmHJL
         cyhM3qOquYVj79trt81dzDCg4dWIRwAmAp/Xz7LROe4pQPDi33zoG1BeqzPtqZ6aGJ
         LYyle6PUsF1BWkzI1VqqUnWOc0DlaQmDMVK7mFUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224185848.GA1846@sirena.org.uk>
References: <20181224185848.GA1846@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224185848.GA1846@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v4.21
X-PR-Tracked-Commit-Id: c3b5725965228014215de553eed3492dbd80a4bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79f20778fb228ae372cd7602745382fd4543ef31
Message-Id: <20181225232007.23808.26334.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 18:58:48 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79f20778fb228ae372cd7602745382fd4543ef31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
