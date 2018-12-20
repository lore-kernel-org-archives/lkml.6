Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF9AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03DA206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545322222;
	bh=OOq4FD+RylZxMpUVkchmgr1w2UwnstSARmI6WGaZ8zg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gh/j0kGha0G9SG/tJAMwZ70zzYVq2EH57Gm7NXkDNW74trEp/nOvmfJ3shWcBFX8X
	 6UMFrEoFfHq/NG3VhEPjTV0qXYYxgIk51EWh4Y88bErurmA5rWzM8aKGnLgFXU0qSi
	 xuAn83myMfSWMtIvLZDFurJE5tNnwbq9Xaq2Vc6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbeLTQKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730898AbeLTQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:02 -0500
Subject: Re: [GIT PULL] MMC fixes for v4.20-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545322201;
        bh=OOq4FD+RylZxMpUVkchmgr1w2UwnstSARmI6WGaZ8zg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tG9ZLN5levb2H6SqIoLyC3iUZPF6ZX1qk/39AH4Nkx4iWP2BIVIBad6As61tjRAWu
         rlVm44mCTXwkWLNQFMsfvJlwCXpKPihRw4SbZWaESt4iR0WQcsDEnHmMOaK/btytJu
         5iKpGEL3Ginzcumqci+6MDiQFT6i/OIJfWk3cM5U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220095832.7375-1-ulf.hansson@linaro.org>
References: <20181220095832.7375-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220095832.7375-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc7
X-PR-Tracked-Commit-Id: e3ae3401aa19432ee4943eb0bbc2ec704d07d793
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d31aeb78c6827db17f447f0504fc35afcbb188c2
Message-Id: <20181220161001.12746.64695.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 16:10:01 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 10:58:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d31aeb78c6827db17f447f0504fc35afcbb188c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
