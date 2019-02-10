Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A5BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 04:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B934B20873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 04:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549772718;
	bh=QZdY96758MYTeMTMbyqYuZiLjS7QEqyCQ6Iin8bWa9Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CpVGKi3vRHI0qnYMs5Klcdfw+MTrwXYvkebJYkn2GxiMCXs6OJbMEGRg+CeKMIUZD
	 o1q9nOqkvNsX9OFb8Yqu02inVvJwze6+pi8mbsIEqj3kooElH7RPxpvKPx1bgevEhO
	 N3gp0lSmp36Z9Dl4XWhJ39e5km9poIz4t3dN4MlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBJEZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 23:25:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfBJEZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 23:25:16 -0500
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549772716;
        bh=QZdY96758MYTeMTMbyqYuZiLjS7QEqyCQ6Iin8bWa9Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y7m7J4yP1pI+yQMjsf9/hTzVJx1qnhPdkTgNHlExsWe0XySXZ3f8XHX3mNZUV0SvS
         wajxfHBDBFdYv1tij2pd3PvUbdqQCopON9Dvi9e6w/D3Rf3Rf3P8FCD6HC6J/OC2OE
         IDXHV73t4pWBGLKnJyL9DQIT80hltsmuyxuylIik=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190210041721.GA2805@localhost.localdomain>
References: <20190210041721.GA2805@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190210041721.GA2805@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 fixes
X-PR-Tracked-Commit-Id: a6d25f4c951b8b28f2eaec6f891ff834622532f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ad915f5ebf5b9e7ca98a7048d8f84a631fe388b
Message-Id: <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Feb 2019 04:25:16 +0000
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Feb 2019 20:17:23 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ad915f5ebf5b9e7ca98a7048d8f84a631fe388b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
