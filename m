Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05521908
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545878709;
	bh=+qtcOrkd5sZVDyEB715GuID8ULR9VyieF+PYdGejKsM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kZHPzZYwDDwH0x0O4bP2QE4yQle35KhJ4Yb5kag+bJt/4OJtK5mvdvXIWA6NQwHJ6
	 WTFkQYYZgw0KdOluI3yUoCV78iTsuC+IZp9dVAdJ0jegPnjSbhbCNMdC5wxmJuH+a0
	 /LRBXQJTbUHo8c6zbsA/ZsN1l4iRI/imcaiBe4Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeL0CpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbeL0CpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:45:05 -0500
Subject: Re: [GIT PULL] x86/mm changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545878704;
        bh=+qtcOrkd5sZVDyEB715GuID8ULR9VyieF+PYdGejKsM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0ePcEULy8P9KLQFBIIHhvLgcu6m/9/Etmn3ZPDeHvFBGUIFEeKtrtWQQuKJpTd+Fh
         UTSHSeucs0AfRjirXCq2cx3BB/Y3vDJUkKBpn+ISFnXjh+9OF0uYrBSO9tzNFPAlEb
         TX8XPLyS/dLRR3fUXjb9cxbTVfyiiSX6cs8zA/LE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224231106.GA27438@gmail.com>
References: <20181224231106.GA27438@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224231106.GA27438@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus
X-PR-Tracked-Commit-Id: 6848ac7ca39a226ede5df7af0efcc4ef0611e99c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e57d9f638af9673f38d9f09de66fa0a28303127d
Message-Id: <20181227024504.3706.24069.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 02:45:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Dec 2018 00:11:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e57d9f638af9673f38d9f09de66fa0a28303127d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
