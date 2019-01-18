Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B31C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAF42087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547840420;
	bh=KZy/zG0uOTm6TVDLRIYveTUE+yKtyvGZ+Xbn1Rs8R8s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uvqgyoXowV+h/Yt7tn5Y/rDUBiD1cKN8ExPlq0gazzca2SYx+eZIWrVvDPOhcmsbU
	 DG4Se5iXX/Xd620rQFLV5LtI9KvNhaehkMbMw2W+xvp1Lyxer3dNWsmYPM2jStaSrm
	 nuyJS1WX+dOkDAuX9t2YuUCgq7+iS4n1OuqJ3vw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfARTkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbfARTkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:40:02 -0500
Subject: Re: [GIT PULL] Fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547840402;
        bh=KZy/zG0uOTm6TVDLRIYveTUE+yKtyvGZ+Xbn1Rs8R8s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2oBUTsmqE8yUw1LhagZ6MufRQjnP1z4Rqfyza1MquNQIrmKgJ1NyoggFVbEbCzbBS
         +WpIRAMjLmYezQKUIzdlf4o8lIbDbQxx5XR9vqydq23rJyVeaHK/B9puEbPi1zNmsZ
         np5Qrggbpu10AlPR6g3BOZkPdWU0sWzmRNhJahb4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190118124059.GA6260@sirena.org.uk>
References: <20190118124059.GA6260@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190118124059.GA6260@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-fix-v5.0-rc2
X-PR-Tracked-Commit-Id: 7151449fe7fa5962c6153355f9779d6be99e8e97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e4673b42e68c78e449f3f6bfe64ff615c90d0f0
Message-Id: <154784040216.4383.11819330178917326880.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 19:40:02 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 12:40:59 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e4673b42e68c78e449f3f6bfe64ff615c90d0f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
