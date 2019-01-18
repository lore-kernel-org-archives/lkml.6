Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E7C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8006208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547834705;
	bh=fHOwnrrIPPn/J4qyr0GmwzaBz/YLGruZcE/UOt89HtE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ns+Jsfkq21xUtQOgx2HXwovclm7qNgcd5U5zcFJQfQySzoYtpmI/sQ0t4ljTPNcZ3
	 Zo5UsDpJFvrw4fs2T99LdxsuVDCXFkVUouJL9LO05T5vu4p+EjX1wGLACNvXxcyYvy
	 /c2GOFefBUQ0EYARr9cgolacaCue6yZ6Avj7M7Cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfARSFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfARSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:05:02 -0500
Subject: Re: [git pull] drm nouveau TU102 hw support
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547834702;
        bh=fHOwnrrIPPn/J4qyr0GmwzaBz/YLGruZcE/UOt89HtE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kptyIS1ErFEeJoThTrB5x1rfCPwLDPyaGwaiVx41i/AaJLRoAT8LsEaL2y2HjT2v0
         xuE1ziDCg5xivdJE7bDU6Hwrlwr3tDRvSYXYpIMDY0Rs2w2d+2G4NQrm3RsfZR1BCL
         xGOpSruyTM7BRIRe9mTx1q9RF7hV8nKFsVfE/lL4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty7U8D_stQeAtxgEzS_eeR0VKnZKBzGDNJwaotcr_7KCg@mail.gmail.com>
References: <CAPM=9ty7U8D_stQeAtxgEzS_eeR0VKnZKBzGDNJwaotcr_7KCg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty7U8D_stQeAtxgEzS_eeR0VKnZKBzGDNJwaotcr_7KCg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-01-18-1
X-PR-Tracked-Commit-Id: 9420151d88ca35cd7f857774d90bfdca505a2cc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3653ebdf89315a3a683f03b8b181942e452d603
Message-Id: <154783470215.23992.1401324214436756064.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 18:05:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 15:44:48 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3653ebdf89315a3a683f03b8b181942e452d603

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
