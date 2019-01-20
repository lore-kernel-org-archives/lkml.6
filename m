Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDAAC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 04:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841142087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 04:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547956804;
	bh=0NsXX9z3D0Ipytk+W6XcUHD/v1plWlIs7jL0YqB/B6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rqiMzg0q/xZdh4IsHwc7y0rJ3cePNLkXm0w1I06qqlLH9xW0NFOk1XgohG1AcGC8D
	 XMVzyUMLtCUTKanryMQ54eAj0aHKjD7VElfik7NgGfkpCHJymKVi/GpkLxpUnYAAzQ
	 3QwnAIiW67k/BuGgUvELeETrer30Bw3G9lUMWzQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfATEAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 23:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbfATEAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 23:00:02 -0500
Subject: Re: [GIT PULL] arm64: fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547956802;
        bh=0NsXX9z3D0Ipytk+W6XcUHD/v1plWlIs7jL0YqB/B6o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sy7GHFp8nispoSSmBtLjcxhFYkbqyTGB/SIFl6zmus7NKPpIg0CLDS5yWHORlRxRc
         gcSltjERYtKbR9L4sChDXpjJReEOXc+ZK5p6ZHjbslAYnUa3RLAJt21yGv3a6oSlgl
         sLDueaRsb24esoWdT4p9YHuHGatoZuVLV7iHyMVs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190120000420.GM26876@brain-police>
References: <20190120000420.GM26876@brain-police>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190120000420.GM26876@brain-police>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 7fa1e2e6afa7f4c9f46528e61de6a15d9e8dffd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0f3e768a89bbc72195023c3db1db45c40e5b70c
Message-Id: <154795680204.15924.5820126657535767382.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Jan 2019 04:00:02 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jan 2019 00:04:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0f3e768a89bbc72195023c3db1db45c40e5b70c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
