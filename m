Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65914C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3960F217D9
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549823408;
	bh=OTpexVj0y5JiZxDlpLDqFcIdgQ1dfd8VK7vsDUZlFxo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IbMquPlNe7oXhzno9zeqy5r4ZC51FNxoq+hI5yyWfo+Vmfkde0h3y0xFUDf+s4mEg
	 F9gkB2XxsJkcrSFqnQDnvfTpivtDctbGfgmpPUfxCDCAl0nDl3pCWPwJuQPUFz+OIm
	 3H3cv36picELgXGNcgFvcMyrY85ztEanD+LUI08Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBJSaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfBJSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:30:04 -0500
Subject: Re: [GIT PULL] IRQ fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549823404;
        bh=OTpexVj0y5JiZxDlpLDqFcIdgQ1dfd8VK7vsDUZlFxo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L992YAK3EM0UoRxl7GPuy56LtU6/rqMKmr+4DtMLw02v3rWuwqnvydSR/ioi7FT2L
         hkUu6+gvz10t6nx3o6izyL9P56n8WiNhqMbMoLkvRFmmfx4iQilhrVEIlNbAMxJqZl
         NdzPomSfAHucyMdXW+EgxQ3Wy6wh2J9adHs0K+gM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190210090857.GA35003@gmail.com>
References: <20190210090857.GA35003@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190210090857.GA35003@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 8087f407364d50d5c3ac8e39365548351e2859f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73a4c52184141943146ebbf07de4dca27141f21c
Message-Id: <154982340406.26501.9759512520243390827.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Feb 2019 18:30:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Feb 2019 10:08:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73a4c52184141943146ebbf07de4dca27141f21c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
