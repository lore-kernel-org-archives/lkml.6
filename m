Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C13C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3DD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547229605;
	bh=lICWm4PFvedG1WNK73zuwYFPRQtKJKH4htaGXI/sy6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JBuxxwup2oCQF2g42rIqpcItdFbAB7hdLu/0eip3FAk4A1ytuBXvUeA2YZbW0wmJo
	 AFTlAEmAGXQ3NgnnRj1REuIz4X0DQW6YzUhL20RdQ3K5gTBZkeA5W5hqEfqTaDcJGb
	 krLb6oTvcqL44imkd0CkhLGV1PbnoqOkQQu2YvSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbfAKSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbfAKSAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:00:03 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547229602;
        bh=lICWm4PFvedG1WNK73zuwYFPRQtKJKH4htaGXI/sy6o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FERYv5gA2YXUiElwFwxTwbtHacrYwkNy4Q46bK9p+rkPi63ZcDeoafKM/E1zR3jbl
         yz31qJNRMIgoiQLKUYz1TNhwv4oiVxLpCtWA455gzjmpJ3PDPHWEkrW09CKh66/gJg
         q4rvhXlRtyXtvCIzPlStQ6nK8Fk7lRD2KtKaVxBs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190111071454.GA26394@gmail.com>
References: <20190111071454.GA26394@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190111071454.GA26394@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: e4f358916d528d479c3c12bd2fd03f2d5a576380
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8af37f3f488e7adce2b5c6f6dfe8c83c2662e1f
Message-Id: <154722960275.6916.772450394735657392.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 18:00:02 +0000
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

The pull request you sent on Fri, 11 Jan 2019 08:14:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8af37f3f488e7adce2b5c6f6dfe8c83c2662e1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
