Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9EAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F82E20868
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546823704;
	bh=EXEA2E1KrB5rxsyizGRgkrp6ZR4bphx+xbjiP93dNV8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J8rrOK8hWyg6CyE/eEfICBGOeyRjAn3adRy0FUsW6dgcujGwq0lmVbG9SMNAwoXMT
	 tTWkFiOvswlm5ljEAVWq+wjsJb4Nb1ROu7z4w7c8CxaOVMDMgUpXqE2t+q4gYghYOG
	 LlZPlrpV2ZY+zAXYQYLAEQM90xzAT4HY7+8KOdZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfAGBPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 20:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfAGBPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 20:15:03 -0500
Subject: Re: [GIT PULL] perf tooling updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546823702;
        bh=EXEA2E1KrB5rxsyizGRgkrp6ZR4bphx+xbjiP93dNV8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rNVz3h6RX2OqnIKW/JqD7+SPk4b3PfLi5Rhw+Y6rt53ZMVdrXHGA9MPnYYvx/mYF5
         3IptoPttsiEaGp8crNbqgfXD9MOFEsnrPF1kk8CfuF0qTyswIuIdM52b2H1lVhxiRO
         TWuhY1JnwhcNW+aaCa5+qwH/mmaHpUpv0C0rGQY8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104120926.GA87843@gmail.com>
References: <20190104120926.GA87843@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104120926.GA87843@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 2573be22e5b6f24a0cabc97715c808c47e29eaaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac5eed2b41776b05cf03aac761d3bb5e64eea24c
Message-Id: <20190107011502.21485.89279.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 07 Jan 2019 01:15:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 13:09:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac5eed2b41776b05cf03aac761d3bb5e64eea24c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
