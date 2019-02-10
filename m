Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649DDC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3571E21B1A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549823411;
	bh=hSTu0IiRKh4799g1gCEw2DGIhNpxdeXzVh3nxiquVUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XZC1ooKcl9kQxOZthWJaiPhrjDBpD8wdCGwK3tsZC5oazIgFtHCWP55TUotl/GsQC
	 +Ke677YZSBoj5NXnnH2uAyozicrMsNHqbxkQekP1K8c2hLX3h7IFCQoXyOwQJqW+Ty
	 o7awclZSnvuvLaCXhBuZ0sGcKKTu/h2+Pp8dOmcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfBJSaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfBJSaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:30:05 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549823404;
        bh=hSTu0IiRKh4799g1gCEw2DGIhNpxdeXzVh3nxiquVUw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VgrpQz7Xq32A2QoQxERs/bMeoDjLIIL8LvwRNTynocmsmuOVN84qzWlCWE9SiW/01
         YSWRyy9JkTjyPd47M+CLoe8ehIzJBFM94l9xs8BHMy2+by0aOvEsYwQzRibZ8lOZYq
         JlqPoE3OkdSShWWaMDOWWakuv6diGtk39maEdLxk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190210091340.GA53627@gmail.com>
References: <20190210091340.GA53627@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190210091340.GA53627@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 20e55bc17dd01f13cec0eb17e76e9511b23963ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aadaa8061189a9e5d8a1327b328453d663e8cbc9
Message-Id: <154982340466.26501.17628363046678094247.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Feb 2019 18:30:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Feb 2019 10:13:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aadaa8061189a9e5d8a1327b328453d663e8cbc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
