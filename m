Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B323C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD8320844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549672829;
	bh=0zx7RiQVZGaeH7CoI/662vsUfRPvr4D3J8UUMGiI4UI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=teaDbWEu3TpX3taP7ny1OHYGaqjScTMsMA60xcG68C2urLdQF/FhVQfg5oZ49KghJ
	 yw3xDIZRsXp314WMlQgKql+UVCoasqpgezXtU1FjaSdDSLWIS6YJJ6f9J0JoHaxacQ
	 P9SllxmnOAvBB4Y+WlzQ37z8FAZfSKe8IS98GM0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBIAkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfBIAkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:40:06 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549672805;
        bh=0zx7RiQVZGaeH7CoI/662vsUfRPvr4D3J8UUMGiI4UI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N9hIlH37xzCq2mmKhe4PYt0V7F7F8ZRiVi1SDvZhbinbwPXEKiBrEbhlwNCCQh3YG
         DATRd+rT3j/Yvw8A67aLnwg9sB0F5zQ5Vcrqh4r00VSNYQz0hVlNLoxuKGK5BHMAed
         D4/JxjR47YIiPWLHONTwHVdANTJ/hVLCNuER0st4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208164938.GA10077@8bytes.org>
References: <20190208164938.GA10077@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208164938.GA10077@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.0-rc5
X-PR-Tracked-Commit-Id: 8950dcd83ae7d62bdc2a60507949acebd85399f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e277fa0893936bb4ab8432828f5d422a9ed0a7f
Message-Id: <154967280547.26526.1169469655849049899.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 00:40:05 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 17:49:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e277fa0893936bb4ab8432828f5d422a9ed0a7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
