Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32B0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9215221924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550422217;
	bh=zKsw6IHJR08WUQG2WDRrqN6N6VzzjFm6Tj0J+KuPT5s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N6aRjbLHh/Vo5d2JDw5CDEBTZpLWtH6l6I0+eIHT8L+wFyr/wUqR8pq8uwP3md2Yd
	 67q1Cg+JNC5qdd/X48JYZt79wdZxrsywzAIRx+GQX7mco/QHmSp3YfA0Ev19UGnnuk
	 jUZa4+Jy2frEbPTkjOf+9AadcSD7YaQ5n2LVXWhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfBQQuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfBQQuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:50:05 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550422205;
        bh=zKsw6IHJR08WUQG2WDRrqN6N6VzzjFm6Tj0J+KuPT5s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SoN30BLUF6JIuiP13ntbdE1xXJ5KRFafdbrRvuxq+wdrk99m8OD725LplrjP1Z6Yv
         SKy/P7oLjFe2h7ADIKtlq5+m/Jop8CU5OKGIfCW47L4yzOAjK58Kk6lyJVkSuXMhsi
         wQnrWotXMTO8I1ueGBZdoq2UBBANJfCht9cmJJNk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190217101908.GA68624@gmail.com>
References: <20190217101908.GA68624@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190217101908.GA68624@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: f331e766c4be33f4338574f3c9f7f77e98ab4571
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d33316d520501f24fef180ea5b860ecb9e64506
Message-Id: <155042220541.16506.3261777464390328895.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 16:50:05 +0000
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

The pull request you sent on Sun, 17 Feb 2019 11:19:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d33316d520501f24fef180ea5b860ecb9e64506

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
