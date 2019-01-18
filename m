Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD5EC5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8568208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547840406;
	bh=CrtGl7HHSqAfAcfySHBzmXeGqHNtlyWOmRoVwd8brKo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YQVsapsuktmMuY1QMi1px2e1q2ncEMyPaSnD5ViC2ClS327+7RK1+mqkAB1QM3XK4
	 UW91ORnPKCEuB7mKH/p2NxIBQaCdK4rvnVrprwvojgin85nc/GdPYCGTYgimacFPzI
	 T1UH+zdC4yFHPTn0jxHrPyOa/wIbCTX7P9xeVONo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfARTkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729343AbfARTkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:40:03 -0500
Subject: Re: [GIT PULL] i3c: Fixes for 5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547840402;
        bh=CrtGl7HHSqAfAcfySHBzmXeGqHNtlyWOmRoVwd8brKo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EslJwjJX5drb1+s++zMy4hX7ldie4s12SjL3WXvzAKsqpGss9sOv8s1VrsXJ4zjg2
         9pUU9LlkIJOD5cEEjurZHDuDEVf2jtuyD5WfQkL5yGviyZYy0AnKpqYQ7qtfGgsBWc
         gXZ88sXa5HchGYxm03CYOtnxegO3qLVzSL1YZiHY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190118135716.5cb2cc64@bbrezillon>
References: <20190118135716.5cb2cc64@bbrezillon>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190118135716.5cb2cc64@bbrezillon>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
 tags/i3c/fixes-for-5.0-rc3
X-PR-Tracked-Commit-Id: f29fd331aa055fbeb5a496b4af937b7952111b6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b4fe58db67947b0c7195405ecb041a991580693
Message-Id: <154784040247.4383.17402044016165110690.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 19:40:02 +0000
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 13:57:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b4fe58db67947b0c7195405ecb041a991580693

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
