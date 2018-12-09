Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB2C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AAF20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544399112;
	bh=uVNb9VviSUWO2/i4eZ5PyCKIKlMEkW0RCdPWIyAhbAc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TLFny/muBoBLEFkmXuX308ugtSoe+gYSfXkWercMdh58rJ8BSreDKnXsMqCcHt2HS
	 HrAV7TxjjyBWCyT4TFtGUBr4Upz1KcjHyq88vov4S9dL+2nriAflj3fUUYBJMQhK+p
	 KCyG9HrHcjLahqUJkizufBpmxzWLrvfXA1blfZy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AAF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeLIXpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 18:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbeLIXpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 18:45:02 -0500
Subject: Re: [GIT PULL] kprobes fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544399102;
        bh=uVNb9VviSUWO2/i4eZ5PyCKIKlMEkW0RCdPWIyAhbAc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=maSSrCe/BGvT5FdnTiH6NAyRkI9Ysbcod3nAwMtyxjia/8kYiMHRZOKduXZmRODK4
         BKeVZRl9V3/gY4mDTY7tSJD+AtpZJW+1rGAEtwMlCEEWdiXs1iw0RoeDh4dlmNZnVV
         HkZUpoFaaUewEk1BzhUFix1oBdeqzncZ8QcIROI0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181209220320.GA84693@gmail.com>
References: <20181209220320.GA84693@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181209220320.GA84693@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: a50480cb6d61d5c5fc13308479407b628b6bc1c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebbd30004d6cfa747723b3ac6ee1a97795f797ba
Message-Id: <20181209234502.29575.34537.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 23:45:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Dec 2018 23:03:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebbd30004d6cfa747723b3ac6ee1a97795f797ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
