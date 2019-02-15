Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39BDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B279F21925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550250611;
	bh=EBF9XUYZAfbyiyqYSnVy/41DMxRkZEl7ZkzWswxbieY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2O+i/EUJJz/h5azouTVcK+GG2kts6Q7BuO9kLkm5/z1YDYK8z06dS3vW8VplgmLcl
	 NryDZwBPvjkAsCYosThq5kvvoI1YSAF/djxgbPO1l5gOGmbx14ISI59DPKArGV1Vpu
	 DPf6jsSI5cX3YH2Kn7CFnO0HBAKle0FwfNJiHWZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfBORKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfBORKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:10:05 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550250604;
        bh=EBF9XUYZAfbyiyqYSnVy/41DMxRkZEl7ZkzWswxbieY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L2LouZFb3gi4EA1fIbj+EUTp3o9M7QBK8U3jfo36ldisQtu5p+ugg5Hu+LYXDS0jy
         jRlE61UiUWx1cRdJ9JRIP9CSvVgK8A2QsV+Wh3Li/keTl09RKViVMaZf5FqCrddShi
         9KwETUlitUw8K1Q6Z16XaFXiWwZF8VNpqiCCmk7c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190215094901.27471-1-ulf.hansson@linaro.org>
References: <20190215094901.27471-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190215094901.27471-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc5
X-PR-Tracked-Commit-Id: 83e418a805d880a8b18add07f94d19b2a5a80307
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfeae3379836fd0609488e73f4df260af4af2672
Message-Id: <155025060437.11780.448719780961677107.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Feb 2019 17:10:04 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Feb 2019 10:49:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfeae3379836fd0609488e73f4df260af4af2672

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
