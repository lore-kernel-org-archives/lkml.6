Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD1BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2C2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549823419;
	bh=ZxAA/y7QotOoNdg4T2BbRhCQo+ccujhKvTKaoWDK9hY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WMdf1Lsgzjr+7IBfxU/8h1PTnu7KhjIgY9pm5pJaSstnQthyD6q5o1sGz8SY+wYnZ
	 swZ9fokk69f05AHPVbfAKAecLUCodBk3fDXkKzg5kEp/cOP8yT9TtJjhfG+gIBIkww
	 y0iqUGjVZQvoNL2DHnDGI3hRQ3IV5Pb9X422sadw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfBJSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfBJSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:30:04 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549823403;
        bh=ZxAA/y7QotOoNdg4T2BbRhCQo+ccujhKvTKaoWDK9hY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eDxoywQ/qi9TR4qvqo13c5B48biJfJ2zUa2tvSR/bvemLd4qo5SNBuCsQKfveZQ18
         odBr32MyiYczFAA1QIY69Hw7i3FNFmFGQ31c6tXmGVaI0/V6Pjcapo44NVoAUFcH8V
         UELXojR+KT8ADFeTtSNzIBViWDpWm++Xvy7jCNf8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190210090109.GA114636@gmail.com>
References: <20190210090109.GA114636@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190210090109.GA114636@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 3bb2600657dac78580e5b8fecc202eaaff5d4ced
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 212146f0800e151bd61b98fb6fe4b8b6778a649a
Message-Id: <154982340347.26501.2658670493807851686.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Feb 2019 18:30:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Feb 2019 10:01:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/212146f0800e151bd61b98fb6fe4b8b6778a649a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
