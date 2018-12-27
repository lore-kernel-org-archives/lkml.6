Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C04C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A2221919
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545878707;
	bh=Nu7I17klzzdXnWPPPUi6kT5zTjRGAy8OpT/K0Tc5c1M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dWtWdXMpa+VBDtWaFfTg9KoZVpKCEpHUciAIUqr4fd5JcIcuR2MrT/HwhNDT/zFMZ
	 sLqmk9GfP+IAiTqlDg9UrsXTpNeqMPPXHgOyrP2/zSexRi6QXbTc1qJ4edHGZYP+u5
	 lapEc1yyMn3zx45daY/5TSL9C51MMmkrykJCPNz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeL0CpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbeL0CpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:45:05 -0500
Subject: Re: [GIT PULL] x86/platform change for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545878704;
        bh=Nu7I17klzzdXnWPPPUi6kT5zTjRGAy8OpT/K0Tc5c1M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fGoiW4/Y3pUdqnrNwq8bio5b65DDRJzTPkhRXh+QTNXIuDb0wls6JIJywbL7uUpj7
         pJgXwZeJ3XFIE5N3mrFMy7Pmb2oXx1VTDIk4+zDTj8ToeFMu9OMYS7FSLcFEw7Ya7X
         AIZAe0gaMTf32J8iEYs1TgpkYl79lwyBvmxAY2FE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224231247.GA67865@gmail.com>
References: <20181224231247.GA67865@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224231247.GA67865@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-for-linus
X-PR-Tracked-Commit-Id: c04e55388a4f2184e37827a1d2e733cded52d653
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc2fd5f0f1aa85925be2322275ee2dc5ac3acdf4
Message-Id: <20181227024504.3706.56812.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 02:45:04 +0000
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

The pull request you sent on Tue, 25 Dec 2018 00:12:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc2fd5f0f1aa85925be2322275ee2dc5ac3acdf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
