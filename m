Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4C4C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA54222AA
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742429;
	bh=fNYnyjg5c40XHa4tVmdR5x03MeQHko4ewEJxEVB4ZRo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QihI7AZG6zZBkh53R3ayKzReTBjvozuyvny9zmoxW4XbTMvGL9l4lTEoTVLTHymf3
	 /PIGBSjEd2B4fehjRshpay7XR7++gZNh916AZBnGdhw3IIycotcNtLGUOwVjT0SVms
	 zThmWiZ29Kfo+gzYs2+egPpRHLqUnQkaHHj9OVfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfAFCk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfAFCkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:06 -0500
Subject: Re: [GIT PULL] fbdev changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742406;
        bh=fNYnyjg5c40XHa4tVmdR5x03MeQHko4ewEJxEVB4ZRo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tR6mBqtmyYlt+8Ywec0C5D1ir4D7VTPIxblErguCnOn7Glb00No8TDRuigjUP7fNR
         WhbhvwE7o1gpq9RFW/sNOSsb+yCrWJMbmTvxguBCuLrfm/dWpXlzl1VLv2pNkxk9kM
         d6CIiAHLUFESDDAGf11suRl0+w1bbUG58eGbCXRg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8389e508-e1ac-dc96-9535-49fcfe3a404a@samsung.com>
References: <CGME20190104120907eucas1p1cde1273265b78d7dccbe26728b717602@eucas1p1.samsung.com>
 <8389e508-e1ac-dc96-9535-49fcfe3a404a@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8389e508-e1ac-dc96-9535-49fcfe3a404a@samsung.com>
X-PR-Tracked-Remote: https://github.com/bzolnier/linux.git tags/fbdev-v4.21
X-PR-Tracked-Commit-Id: 399382f8018204407174f0229b4087d40e1cdc82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8a6b1186b1a209647483c2ff81e0d59c43dbdd3
Message-Id: <20190106024006.13237.16077.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:06 +0000
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 13:09:05 +0100:

> https://github.com/bzolnier/linux.git tags/fbdev-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8a6b1186b1a209647483c2ff81e0d59c43dbdd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
