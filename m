Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E081A218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865833;
	bh=wKpTVtpoaW+pKeBO1R0CnVL6fC9RlMl7VvpUxmpEbWU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HhNv0QQfkVNb04+mFd0xEGcJjjQHWLrEsArgGIy/k6GB1LXcPaDDkZy7Vc7vnDMWa
	 bg07IIYwhgTW+aHXvqwfloBV1/YfumhMe7oJ0bvzT6cJpVcjyKG6grmn2EjS6r1NjJ
	 5c0PkeshwECB4Cm+HliVxq84p9D7MhLL1+L6S8K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbeLZXKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbeLZXKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:10:03 -0500
Subject: Re: [GIT PULL] locking changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865802;
        bh=wKpTVtpoaW+pKeBO1R0CnVL6fC9RlMl7VvpUxmpEbWU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JSSLSjF5h5/UTs7CIpiP4nug2zTASZD0gW9z08h2+36rhsowkcS/feN2bJ2qk+PFl
         Qbb6ocsTIVCsOxutKbn/BCkzd5gsGvmk1zOwufN0IfPtJfDqwM5Rm7M+wwC4RmH4LP
         8FHkQt4Po7Ygn+MHJZ5h2LXKvJZlcigVtuf5K8bI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224222541.GA1945@gmail.com>
References: <20181224222541.GA1945@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224222541.GA1945@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-for-linus
X-PR-Tracked-Commit-Id: 80eb865768703c0f85a0603762742ae1dedf21f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1eefdec18eded41833401cfd64749643ff72e7da
Message-Id: <20181226231002.2587.24348.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 23:10:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 23:25:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1eefdec18eded41833401cfd64749643ff72e7da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
