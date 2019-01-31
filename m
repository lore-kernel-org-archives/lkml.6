Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E27FC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320DE218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548963015;
	bh=P2CKffarzBuaNCKQxwaJUdy+fP5mJ71SI6gHv5kIAlQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YgewrrvPVrHsnIQZqvpoivn/bC2br4+aAwUjDDgi7deNgBOVOtQuB/UEO8BD6JE1b
	 +E91s/JeuoU9Fjb7GWNB6CC5eeYlAITC5rNRYXUJ5eqsVxjuP2QS4fvZmBDMFM/K55
	 LBtpf15pFWNeH9w3m4XAkryygE225zlGPNT8HGNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfAaTaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbfAaTaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:30:06 -0500
Subject: Re: [GIT PULL] Kselftest update for Linux 5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548963005;
        bh=P2CKffarzBuaNCKQxwaJUdy+fP5mJ71SI6gHv5kIAlQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ubqE1u6KjiM2m1aq75W/AkGkT50FWWi59CETPvBH6nKGAWhrrnpI6yoqxbm5c5Mis
         HCsYyTBvJc9YPNQ1xkff95mRE5fCUyh9fn4HkRgkmpjRAy6hhL4prJ/3cqF1dQ/Zi/
         uSO+q9oZaIcYEee7IV1pQwh95qNZckyj2IoHR7ZU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <861aa0ec-3f5e-27aa-8cfb-d7f2d3fdb24b@kernel.org>
References: <861aa0ec-3f5e-27aa-8cfb-d7f2d3fdb24b@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <861aa0ec-3f5e-27aa-8cfb-d7f2d3fdb24b@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.0-rc5
X-PR-Tracked-Commit-Id: 7d4e591bc051d3382c45caaa2530969fb42ed23d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f789567142c0cd1ffd6c28c56eed40cb36495ca
Message-Id: <154896300579.28776.22792124579750379.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Jan 2019 19:30:05 +0000
To:     shuah <shuah@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Jan 2019 11:35:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f789567142c0cd1ffd6c28c56eed40cb36495ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
