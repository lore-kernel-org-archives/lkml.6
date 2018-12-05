Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC2DC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DBB20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544034013;
	bh=YZuB4X4pg3XR4cgXKGPILuQ3GPe/QP3/xGeem/N4Vhs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FiM25cattDWHv05JlDvpPy/alyFeAQcen0d7CI/G+l4ofxfovNgiyPj6PLDgZ+p/U
	 n7FM8xYzEddEH/vhW4g1gXsybBwgWip6oLrWB4abkeb5AMNdGUS0aFF/33C0iAJ2/6
	 LQn29+iNvnVraGCAsD2Vdybiokt/wf8JZlw3PJeY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DBB20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeLESUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLESUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:20:03 -0500
Subject: Re: [GIT PULL] Power management fix for v4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544034003;
        bh=YZuB4X4pg3XR4cgXKGPILuQ3GPe/QP3/xGeem/N4Vhs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jbK0PDBwuiroH/KQxttdEs5TtxHUqSxcl6+P/XlHysr6ZP7z0eW6C5TEatSTX/uUZ
         QWilOieFZqj39c9cXdOa0TcZCjFyOwoDA7caQV+mSN1eJkY/Kq0Gh1f8ddsOZcmmrA
         EVAe0OGBZRt6QZyOCdePmAU6Fp2tGqnRl8/SRpK0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jCSFiK1mij3ChgxCs04kpFxPjr+u=WKNCFYeY5mUWv4w@mail.gmail.com>
References: <CAJZ5v0jCSFiK1mij3ChgxCs04kpFxPjr+u=WKNCFYeY5mUWv4w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jCSFiK1mij3ChgxCs04kpFxPjr+u=WKNCFYeY5mUWv4w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-4.20-rc6
X-PR-Tracked-Commit-Id: a72173ecfc6774cf2d55de9fb29421ce69e3428c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91dd51f6e7ce7f1eba5d7b583790e134367d0fbb
Message-Id: <20181205182003.5826.30703.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 05 Dec 2018 18:20:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Dec 2018 12:53:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91dd51f6e7ce7f1eba5d7b583790e134367d0fbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
