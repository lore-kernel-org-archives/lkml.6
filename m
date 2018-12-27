Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07522C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC3221902
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545878703;
	bh=JPWreOIfEczowgkZ3TcKSjcyMs13rJgen3Unb+HkmUM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=glTEk214SXHPyx0ku1qvxWSB0f5dHWOX2SG9YzjBSOxUErEMX834gPfP1thyiIF/M
	 AlDns2cEc7FDQUyMjcWZTQ7SWWoNfVbNJiWrILvD942qty36cHU69JCNXJQ5tF2HvK
	 n5HKhwkxoUfR0XwMuB0uA0196GjCBi8cSw+EHD+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeL0CpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbeL0CpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:45:02 -0500
Subject: Re: [GIT PULL] x86/asm changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545878701;
        bh=JPWreOIfEczowgkZ3TcKSjcyMs13rJgen3Unb+HkmUM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QUGXIjEqA3KmYbTmxIG8KmYq0uvm57wDmXAoRp7vHlgjBNHF2A4cjT4LNOKSXgXo9
         Scz9+DLGQjS5nCL2BZrS8aoayteTupOpsmqD4oqG28j7t8HvQY/XZNmvkxCd1mXkTB
         a07dhkFH0JAscsFYnZwUo9wJ3dhFAV8u1xsXH0X4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224225347.GA124901@gmail.com>
References: <20181224225347.GA124901@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224225347.GA124901@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus
X-PR-Tracked-Commit-Id: 29434801e7e9c6d05fbea4533b3c0bd6be612f62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38fabca18fc4c832ea95e2d14fb1ecde8b7dcc56
Message-Id: <20181227024501.3706.49859.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 02:45:01 +0000
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

The pull request you sent on Mon, 24 Dec 2018 23:53:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38fabca18fc4c832ea95e2d14fb1ecde8b7dcc56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
