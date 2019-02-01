Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC84CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4BC218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549046124;
	bh=sEMKE25EspsUNC4K4Yy1xzRcSPx828L9E8EmgNBO6mQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kH8Ryb/gl2sq8vaOG+MzKzBcOguvgWF4fDvUEed2rml8IA9PPFk7tEZQxtq91nnUQ
	 PtFn3OALXquVyHGrE+tpw+ATXYqqGUly0F2D/5GUPgjZPcM/tSJbSId3SJaplCICB8
	 0RfvdcWId5RXf8vtFZxcLQ8dG0OYRAI3om0asXzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfBASfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbfBASfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:35:04 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549046103;
        bh=sEMKE25EspsUNC4K4Yy1xzRcSPx828L9E8EmgNBO6mQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nnZxPHUJ7JM5IIzM/202VpK1mFz+X0RINIkY3EyUsWjDZ0ppQAxyHLCJHOG/EMh9x
         V2FXfRuUixD0mR4m3FRtVUeDC+uiNSEzdGkITJktazBGy8SCbJbwW/Np1Op3c/mE3O
         Hn38a6CQjf+vt8DkMojUZXcIn5rRWcvY8qAaxrFA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gSNtDedxn=zfxCN93srU3BidOH2Uuon8WK9CvM_01oqg@mail.gmail.com>
References: <CAJZ5v0gSNtDedxn=zfxCN93srU3BidOH2Uuon8WK9CvM_01oqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gSNtDedxn=zfxCN93srU3BidOH2Uuon8WK9CvM_01oqg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.0-rc5
X-PR-Tracked-Commit-Id: cbffab6825731f1baac7a950f6b7dd9239f55594
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3325254ca14c4b859d75be757518dc2c0ebe298f
Message-Id: <154904610386.32661.16816763214254837094.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Feb 2019 18:35:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Feb 2019 11:39:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3325254ca14c4b859d75be757518dc2c0ebe298f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
