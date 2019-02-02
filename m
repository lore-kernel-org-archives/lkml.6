Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E0C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC6B2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549133112;
	bh=nZJWFyxjxJHAToWM5G+2Fi+zV3+eLHz07zQdJ/YwOBE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KN7Lz6dcdprc6hWOnvBum1kC6w5mRO4vaboNZm5nNZ+hmsIMUkmdsupQQPCj88xrp
	 6xDaNoEWU79WWf+sfDh2D8H5MWK4U5qiVIDBQuv48hHrEmZTqp8x1bHkGcOT2xvqH6
	 Yx5n2SNgYogIEY7wU3MwKZlInDIfLR+bJRYK3jRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBBSpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 13:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfBBSpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 13:45:04 -0500
Subject: Re: [GIT PULL] Devicetree fix for 5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549133104;
        bh=nZJWFyxjxJHAToWM5G+2Fi+zV3+eLHz07zQdJ/YwOBE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b1c2Xe09ln4nU6kBws7i7dYdIzwYmKOo1bCwu/RVXINWkZRH9vudv1f2Ua8bsd7Ig
         PF3bPuBSnspYCi6fHixtDz9qUXu7lEFtctYzeHlwtBJW5+W9oEOwunuJi6130VfOaW
         ENGM5u4zd5csfILRRhJcO3uT+4vu+1+YH45K2pGs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqLPN1ko5nPSTh80EQa2Zz_LHvFFCw42XYBcv8VSa_cYvg@mail.gmail.com>
References: <CAL_JsqLPN1ko5nPSTh80EQa2Zz_LHvFFCw42XYBcv8VSa_cYvg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqLPN1ko5nPSTh80EQa2Zz_LHvFFCw42XYBcv8VSa_cYvg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.0-3
X-PR-Tracked-Commit-Id: 5fa98c2eda35fcd1a1d91a9785c390f54688240c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12491ed354d23c0ecbe02459bf4be58b8c772bc8
Message-Id: <154913310425.3857.14878049937437445302.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Feb 2019 18:45:04 +0000
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Feb 2019 11:10:06 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12491ed354d23c0ecbe02459bf4be58b8c772bc8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
