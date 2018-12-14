Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC71C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A404E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809514;
	bh=0V8s78Kh5lMCgumXaVfvzxPsStZzjFcDaEdwlIMoCLc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LAyiVQhx7Erv8m4ySwbDmYSwzgURECO61zv/LTk+0Njns6LB3AawxWyy3aEbQ9JUS
	 6tE7fGrcsSaNdRBR6v3vERCymlDczaxcWjBLhOjAj9M/jgufeEgvFgstPi6wIt3KGF
	 c8oTKWZK++Cackce/MITB+OZeXI/Ik/V/m9avHwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbeLNRpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbeLNRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:45:01 -0500
Subject: Re: [git pull] drm fixes for 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809501;
        bh=0V8s78Kh5lMCgumXaVfvzxPsStZzjFcDaEdwlIMoCLc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2Y6XDrxXDbIUvwW0BgYdwsjTFVpt1z9+u8F7UOE9MWyFNO8u/rV6IcAjC3stExwwx
         i7COl5PstO15vPnewixBtEeHbBRZq0xJICfSSLcQy//R75/forCEEsKfGtCGHIQsbf
         P9kZzUfxXKWwI30DPJBcspPSA6sBZv8IkK8axRtM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx+7roxu+Ws70OWaYjV7V8FgHmqb=HN4LO0S5GgccJgTw@mail.gmail.com>
References: <CAPM=9tx+7roxu+Ws70OWaYjV7V8FgHmqb=HN4LO0S5GgccJgTw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx+7roxu+Ws70OWaYjV7V8FgHmqb=HN4LO0S5GgccJgTw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2018-12-14
X-PR-Tracked-Commit-Id: 1df07a7f2244947c888dc35bba2b237f714afc56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92de1de51e99910ff0b45b340c95994573a1ad23
Message-Id: <20181214174501.32554.16063.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 14 Dec 2018 17:45:01 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Dec 2018 11:54:15 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92de1de51e99910ff0b45b340c95994573a1ad23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
