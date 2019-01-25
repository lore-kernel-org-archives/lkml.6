Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27588C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC59620844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458431;
	bh=FeP4DBmh6KaJK01lZq5l/dsAd9z0gUTSVFigUQkec7U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mrVBPg5PHo9cybiID8FvB93xlQbr+NHsq2eNx1JBO8+MkswHoAHLuUWqLIOfPBX+r
	 XHQjbTXqYJd6CPcWIU9FiqbHLFELuZBygGcbMnsTvjFteHv+AmcFLwkclXALPBAaia
	 /pOV/N4lAYVCRSahzUfY7BvNWvl5eiTKkK3Ter7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfAYXUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:20:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfAYXUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:20:05 -0500
Subject: Re: [GIT PULL] Staging driver fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458405;
        bh=FeP4DBmh6KaJK01lZq5l/dsAd9z0gUTSVFigUQkec7U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B7z7Jji/EoMntjaEiFenv2eXgpbPfJiF5qt0o77yx+tza1pDroz2kGPbJ9WM7i8zT
         nQWaXjhV7x4uCV9mlw9GF0zb1yEKDxrPCqkPfG+y1uKrL76NLY2300Cspm7kd5cCFu
         M+Mne3y0SC15jrQD7+6YVcqHQOwJtF/em5OZk+FM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190125122259.GA7652@kroah.com>
References: <20190125122259.GA7652@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190125122259.GA7652@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.0-rc4
X-PR-Tracked-Commit-Id: 31eb79db420a3f94c4c45a8c0a05cd30e333f981
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96f18cb89ffa4bc6dafa447c9493449809fbb318
Message-Id: <154845840519.30665.10974165396641962091.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jan 2019 23:20:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 13:22:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96f18cb89ffa4bc6dafa447c9493449809fbb318

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
