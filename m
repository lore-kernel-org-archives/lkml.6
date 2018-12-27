Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BA6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB6621908
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545878705;
	bh=dNGTNQsbHjIPO7AOWFqgr0n7+UXu9k4scSHbJJri9qc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tBV3LHWNy7dK85OS6iri1M7qMRcsioFEEBZWxOWO8uB4V4/p32URq226rsq6eT9wf
	 DZPy3KGUqZZ8Ika9Eu4M0uz13shjek9+GQGmTA3nOeGSkDchiqbg4Wd7aMuySxa9Zf
	 d5uFftQo1zAgNKEGAD8lAO3wyzuIhlN/QDq+p7G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeL0CpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbeL0CpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:45:03 -0500
Subject: Re: [GIT PULL] x86/build changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545878703;
        bh=dNGTNQsbHjIPO7AOWFqgr0n7+UXu9k4scSHbJJri9qc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vpGTrsNEI7J3XbQ/TdcBR9kZgBDF5U0Rc4iBdYcvgzRq5tyu4KKBU5YfdX2KxOMc9
         bZ35dKRMgUgVVZZPVt5LNK+yQLcVkwSnoFfdTZs+tZC1jufjwpRGlWPA6h3MaOQrIE
         JdSA9TmOHYwJYpfEhVMmRJfitg2LMOjXfRX3eryA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224225831.GA36544@gmail.com>
References: <20181224225831.GA36544@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224225831.GA36544@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus
X-PR-Tracked-Commit-Id: e4f752dda0de351efd198f438b68e743029da68a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e54df001ac9262e3b78b34b87390fcb54677a0d
Message-Id: <20181227024503.3706.24620.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 02:45:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 23:58:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e54df001ac9262e3b78b34b87390fcb54677a0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
