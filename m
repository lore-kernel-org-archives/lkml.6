Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BCFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49312080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546389314;
	bh=Vz2vQsXbLx1yrhsDGFMPF/f6aPQ9Wiv70ZjcmBdsSa8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ppcRvMCKNr4HH9c3WhHsqO51aTT3bNeeIh+WevGtbg5Cuj4bsO1UWifgVJ5uGgnt/
	 HuLS9ciaWU82nVIFtXcy2AsjE3KPysWWkbzOtbP5LAsd1hiq9CRCuAjBsMaIFTgIdq
	 4O9GQZH7QViACYbGtOaIIloPzU0rhuqCUn8C4m+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfABAfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfABAfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:35:04 -0500
Subject: Re: [git pull] IOMMU Updates for Linux v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546389303;
        bh=Vz2vQsXbLx1yrhsDGFMPF/f6aPQ9Wiv70ZjcmBdsSa8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q2tJtW/DvgX5yDembyzjnUGY5uGWk8VhtCbwfQ2BBRhFKGvBTXPVdXWcCun55j0Mj
         lNSgYVt0WhNTa+sOVKUZUnpKi5AssLmPBCXL+XdWfn+bxXyS+/wIabFXgxj74Ni6b8
         pnFob5AvXtQZMJ9V2HaIWwgRnmEaV4tyGfNu4kWo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231163654.ckgwt2jbxq4g5hl4@8bytes.org>
References: <20181231163654.ckgwt2jbxq4g5hl4@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231163654.ckgwt2jbxq4g5hl4@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v4.21
X-PR-Tracked-Commit-Id: 03ebe48e235f17d70f34890d34d8153b8a84c02e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e143b90e4d45cca3dc53760d3cfab988bc74571
Message-Id: <20190102003503.1457.90896.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 00:35:03 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 17:36:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e143b90e4d45cca3dc53760d3cfab988bc74571

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
