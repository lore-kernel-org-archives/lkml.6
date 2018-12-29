Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91078C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D4621902
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061722;
	bh=Y47+vtUB8qWMVu6gAAZr5QAdnvQOYZicnQn8d5nbEBE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jNX3wDYSEN9OAFmuQDhvi+Y2/CGWPCwme0Hlnq0B76m7I5eH+RGZ0139uzYT9AJSd
	 4Gc41neh4ntvu7tX2E8WDBqNIZ/Zy/MrkPCgm9uPgfSVZ+4gt26Oteh/ixlGn34mBS
	 Keov2OVCovJ+59/ITwlyMQ2/JRU52ZkwHAuMvlSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeL2FfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbeL2FfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:06 -0500
Subject: Re: [GIT PULL] DeviceTree updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061705;
        bh=Y47+vtUB8qWMVu6gAAZr5QAdnvQOYZicnQn8d5nbEBE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xu+M5uERAPB/zYczN2Cr+Q9hMPFcBr2Icp+j+WNLMBoDIeWTMov2qK+ZHfPcJiTnk
         SNwsYisaa3hSQswdRec3a3HWhN7xsKyU3FaNuFguveFEaLYF1x0oqqms0qTF6IDfb4
         LRvtO5+3A1idhgbKx0ziW9KOwD9UZRTefcrwG9bs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqLeKebs8yL1y0XUjBKYQiqVtkgZ4+1Sfwxx1_rPtDwdUQ@mail.gmail.com>
References: <CAL_JsqLeKebs8yL1y0XUjBKYQiqVtkgZ4+1Sfwxx1_rPtDwdUQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqLeKebs8yL1y0XUjBKYQiqVtkgZ4+1Sfwxx1_rPtDwdUQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 devicetree-for-4.21
X-PR-Tracked-Commit-Id: 5801169a2ed20003f771acecf3ac00574cf10a38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 030672aea826adf3dee9100ee8ac303b62c8fe7f
Message-Id: <20181229053505.9301.85357.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:05 +0000
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Dec 2018 13:44:21 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git devicetree-for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/030672aea826adf3dee9100ee8ac303b62c8fe7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
