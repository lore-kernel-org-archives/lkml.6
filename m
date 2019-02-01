Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFCA218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549046122;
	bh=fYdvMR5ASQVn+y+7yJIB8fixXzfBufxGTdHk5WDF9VA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=z+nVg7BGqlm9fLqzoHkOtL8bCZm2vqWVimhL3vJEbyyCSZ/7kZbhfdxr3Za7pKbEg
	 JVo1Ma5v8noruScn6587E6IcYzyjW8uxZcztI1UI7L81HPSo3cxDxWvhjfuO2RCFm7
	 2Yk3upmuywHI4FhHFy4YNtDtBPKH6p8SyAdAKR18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfBASfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfBASfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:35:03 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549046103;
        bh=fYdvMR5ASQVn+y+7yJIB8fixXzfBufxGTdHk5WDF9VA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CrIizkpo8G9sQ4OMvUgkQfsYIfc+4k+l1eABO8If12+u0sI6FwCMCCswCLki+0Fi2
         n/c6sVn9IqGZtoKBhYhMXn6goczg6RQaAR1G9e7d2kGN866RaIzik+q52ytdZxMeEU
         E//ThYpn1+RfbLsmzHJfznX2zmzi2yggo9iRFxcM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190201095954.18273-1-ulf.hansson@linaro.org>
References: <20190201095954.18273-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190201095954.18273-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc4
X-PR-Tracked-Commit-Id: 3751e008da0df4384031bd66a516c0292f915605
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cca2e06ae8325b5280491954b919e6d8d430b12d
Message-Id: <154904610349.32661.2751591799540747209.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Feb 2019 18:35:03 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  1 Feb 2019 10:59:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cca2e06ae8325b5280491954b919e6d8d430b12d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
