Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B47C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5042086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547789706;
	bh=jt5BNuxrPein+JGVid5xOjx3NxNsYWPSFPc8JagCDKw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n+GQVXWJo1TLnFSa0bxpjGQXOzSI/SDP3ClrFRYsw0nkZOFKZL+gBlRVyJdzktcJV
	 i6ezNbCU/gLkuUuGZxs+0U5Ofrn0JP41aKF2Cg5D+305/Vxq9MsfF8+xn8IUrMm/eR
	 sjBgPKgeucm8SKuiKKPOHU3zjTK8fAsVGnUBWamw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfARFfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfARFfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:35:02 -0500
Subject: Re: [git pull] drm fixes for 5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547789701;
        bh=jt5BNuxrPein+JGVid5xOjx3NxNsYWPSFPc8JagCDKw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hO/Nwp8Dq6GnB2tPF/GI5YMMxlYkF8zrbeU2tSBfsYPsD1xuMSZPGsnovC/cHwEuI
         vzu3gXsRx0duD4EZdwUUU9SR/BwXQdCCJruVIGAIT1Tl4A5A1NnAHOKBeyuP8lAaXB
         JarTbuymmU3Yey1G/9PuokwehzSxYfC35M+9LoSY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twXwFGmN8fK-iNyFR6T_k64qB5OdNFP3fzKSSWKou1BcA@mail.gmail.com>
References: <CAPM=9twXwFGmN8fK-iNyFR6T_k64qB5OdNFP3fzKSSWKou1BcA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twXwFGmN8fK-iNyFR6T_k64qB5OdNFP3fzKSSWKou1BcA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-01-18
X-PR-Tracked-Commit-Id: df0219b4f9576c72b618db5edf7bb75c14829dbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1092a94fcbcde03a8c2cc554f305af48c95d5d58
Message-Id: <154778970179.389.5087309572560960495.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 05:35:01 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 10:43:13 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1092a94fcbcde03a8c2cc554f305af48c95d5d58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
