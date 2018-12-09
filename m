Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D0AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5754E2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544399105;
	bh=WCYCYw3c/NdrllWiBV7nS2dKJl0DWhYuMvKKVc+BbWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BDNowNKKw8fDn/NFWrQu85MQKyLVxIFXBsYPe82Q19lfJn/5Bt+wy6mqfF8W1aXyC
	 9MphBhKb/8vtwDxGyLX1cmVieMW4BEb8kR9IIwUo8cqMBK7aLmBVqd52+f8fHryFGs
	 vQ+WrzC5dMWzZ9jdYgG1u2BpleSYVRLXXSERoWp0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5754E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeLIXpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 18:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbeLIXpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 18:45:02 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544399102;
        bh=WCYCYw3c/NdrllWiBV7nS2dKJl0DWhYuMvKKVc+BbWo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w2iV71PbHflZ+cpEVSG0dg32SZZx1vY+ZKiQKNg0Uhl4VuJB/Ct46XjZ7STgUMwk4
         Nq01HALT4pW4+7Vw+l5CyezQN71KR/AqhzGfXE6sCpMfty+KIOjCIQmf+y+aDaXdEF
         lXMWXlkc8u6L2mtOtYIyEfoubj3gKTxFdYglejNs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181209220655.GA105704@gmail.com>
References: <20181209220655.GA105704@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181209220655.GA105704@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: ac3e233d29f7f77f28243af0132057d378d3ea58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8586ca8a214471e4573d76356aabe890bfecdc8a
Message-Id: <20181209234502.29575.83281.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 23:45:02 +0000
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

The pull request you sent on Sun, 9 Dec 2018 23:06:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8586ca8a214471e4573d76356aabe890bfecdc8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
