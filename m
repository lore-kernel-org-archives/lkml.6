Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCB9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5502B218FF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780004;
	bh=G1doRWMZHE6B0jzOXZnOBrM2KkK27d95xRSnWOX5xks=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cKGUaDDPnRmZz1WFYgRI+PPljrjyUqCBcJFiA9GgwA1L7pT3wMYq/nV3HZJfu8cnQ
	 n/8M6t1iLHQBbEVBcKeULVZ1d+2OgaAVu8OWiUW8ZO8+/0Zrf44jILQwWlD5GVAiVX
	 JUyPjDP4cUX15TdhQr7gbgkMo4XKooGePazcztKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLYXUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeLYXUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:02 -0500
Subject: Re: [GIT PULL] platform-drivers-x86 for 4.21-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780002;
        bh=G1doRWMZHE6B0jzOXZnOBrM2KkK27d95xRSnWOX5xks=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n0avnwr6sxiK3sqDnKdF362IMOdnUQoJ1RL7unAEJuIbqWiTV4TEOin+yZJNyV+pq
         kpf1Z4GPolLnpBujco8BpFEiCbuQouTRGZHC5HF2Ylno7y5II2w+rdv2UIzplM/P3w
         JPDYY8fbiQ6UAEazEhRBtCUOgd4P6u4W0tolwtyc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181212140225.GA3138@smile.fi.intel.com>
References: <20181212140225.GA3138@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181212140225.GA3138@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v4.21-1
X-PR-Tracked-Commit-Id: fb7255a923115188ac134bb562d1c44f4f3a413b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c76cd634eb5bfd497617ea224a54a03b545c8c4d
Message-Id: <20181225232002.23808.51717.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:02 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Dec 2018 16:02:25 +0200:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c76cd634eb5bfd497617ea224a54a03b545c8c4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
