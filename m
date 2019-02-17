Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7FDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB0921924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550422227;
	bh=HFzFFDzFLktJNLR08j7Ny2UuFKrPevqrfZSeFc+7KV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rXeIkhgI5dQnjmtMdtbErSTjTvW5EYD13UjuBuJWw+J1xHDnfMnMMTwVC9ZqpPZlE
	 PiDx8v656NUYKQqWbhlUVoSNExOagdQrzJmt1JO1i3yy5g4xenVBHL0mmVx9zaIS1T
	 F4zeCCkt7J3qBkG04dIFKoKP7xnYz09jA8Kh0i5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfBQQuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfBQQuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:50:05 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550422204;
        bh=HFzFFDzFLktJNLR08j7Ny2UuFKrPevqrfZSeFc+7KV0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kLa1MmOp2mnvFZyYBO0IbXB3RgIBT+jQGdSy2MhgLK9rf3qvUTw8g1gtI2bUeEGgK
         0Nn4FbCbJnxJMRK4HBwqJLHKD2kARPvPredHNtQuHzGKhb7RAan99OKoo9OEdkt6/a
         /QU05ispl+EYXHRDQzq2axu1EySjPREbSUuRqupQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190217101051.GA116360@gmail.com>
References: <20190217101051.GA116360@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190217101051.GA116360@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 528871b456026e6127d95b1b2bd8e3a003dc1614
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd6f29da695dbfe5a8ff84ebfdd2110d68e8f511
Message-Id: <155042220452.16506.15591930014891986114.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 16:50:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Feb 2019 11:10:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd6f29da695dbfe5a8ff84ebfdd2110d68e8f511

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
