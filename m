Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C07C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD25B21902
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545852003;
	bh=DbmLy+XkjkErjdgeHCnykDUDMYlAYVHiB1CiSjHclhs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=F5yrwKV9/U7DkclER+5GBpOgHrYXjE779TgOsXIC8W5O9fz8B2yEJP50SNw9G8rqy
	 /GgL9HNDUePp+UdcxLq+a7LXwu5PtJbu0gQXHineEujHJUEMBkRrR1kUJEaclVp6T0
	 2KoWg2O7CNlltjX/NS+lkZS0dOv20ut1hzNijwQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeLZTUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbeLZTUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:20:02 -0500
Subject: Re: [git pull] m68k updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545852001;
        bh=DbmLy+XkjkErjdgeHCnykDUDMYlAYVHiB1CiSjHclhs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CEtXft6VSR38QnBpopbkWBMbQ8klriltqt44wdcnpc0SNNoT5rCF/kKiss1o5pM6I
         CNYVIuTchSr3gYfzMpOr2ddVlrPLTCQ7s0Rko8D78/tbCVq+RXWrofGRBH0cicuw9C
         O21o426+z/16+JyQdeJ5B3jbpLVYt1EIABYSS0oE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220151736.26607-1-geert@linux-m68k.org>
References: <20181220151736.26607-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220151736.26607-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v4.21-tag1
X-PR-Tracked-Commit-Id: 005e13a96c0ed1437cb7f113d5d0f07ad9590962
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0783bb42448a4f2a6bd405c890010a3950feada
Message-Id: <20181226192001.20075.23178.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 19:20:01 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 16:17:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v4.21-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0783bb42448a4f2a6bd405c890010a3950feada

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
