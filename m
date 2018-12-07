Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55AAC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A44320672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544207704;
	bh=6dMJ/HrSAJHZbXiwRWI5qFC5VRGMAYCXbejyloop4rQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JbOx6dLfCO5Ug41mdVGR4jZnESa7jDfG9KBzYyJbOpR/Jyg/C6QyMbeEu5++nuMmQ
	 JWgzuWPySgWtxhV+dusjbguWc/GF5yaa9aeQz6g0hFzr9Xvg4q1x+OJNR27SRc0POA
	 77F/S1bCqjVmIYh+4glkHaAjSDOH4t6aFr0n+f+M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A44320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeLGSfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeLGSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:35:02 -0500
Subject: Re: [git pull] drm fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544207701;
        bh=6dMJ/HrSAJHZbXiwRWI5qFC5VRGMAYCXbejyloop4rQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GcWjkqml19LN/+CCeNsRfXLI1qOsejHksAKicE4Z1y9TPgGaD9QxTrryKTKBmK2n2
         cQ3cUOefR8HNJk806JbdZCnUyczg5eL6mNuONTffBdMz2wAuh0Q4w0AozqWjhmNLNw
         SjV9YPvcl/Il5kym7wT6nN5Uayqt3nJz2fa+l2uw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txWWa2v25-XOU88w99EOS1VdSyLT834HaG0izSX6RQJ_g@mail.gmail.com>
References: <CAPM=9txWWa2v25-XOU88w99EOS1VdSyLT834HaG0izSX6RQJ_g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txWWa2v25-XOU88w99EOS1VdSyLT834HaG0izSX6RQJ_g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2018-12-07
X-PR-Tracked-Commit-Id: e594a5e349ddbfdaca1951bb3f8d72f3f1660d73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d387ac13ad12194a62d268a6b7a0633ef832f6bd
Message-Id: <20181207183501.15805.66720.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 07 Dec 2018 18:35:01 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Dec 2018 11:37:08 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-12-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d387ac13ad12194a62d268a6b7a0633ef832f6bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
