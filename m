Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F88AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3502B206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809519;
	bh=Hv7iIBiYB+jkUfP+u9UuyrpzksifoED+x6Q/no9olNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GTGLEEBHaM+d1uQiJTQf82KLEm2V9C9GtVuugAn/Zgz4q8L7sBkgWJPYsnuZ9HGyO
	 0G1SaMYE9R22jGxlhKGCW560b22XwSqvS1jrGA6/aqa2VLpZJNclNxu1Di6P3mhPSt
	 8Olk5xSWqVnxu40dg/U2GzTGZH8E9h6jYx9bnTzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeLNRpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbeLNRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:45:01 -0500
Subject: Re: [GIT PULL] pin control fixes for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809502;
        bh=Hv7iIBiYB+jkUfP+u9UuyrpzksifoED+x6Q/no9olNs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rcH6RH+UrUZJem+4cFiissAtaQgh15FmxI4GlwZW3Yu5EdQTmEDain0Hi+UT5vGDd
         bDGXPs91rwJxrrh9DIytUiG+23hEMD0My0nacraliVn/eVh5lYT9HtgXbYWhAIjPV+
         roKLvoYvZ1rmk65oVjHncSwAYdJFLnD71N5jzIrQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZqeKmrMr7SsAzZHCLM+z4=eyz2XhjYFdhJJLaFDH84zQ@mail.gmail.com>
References: <CACRpkdZqeKmrMr7SsAzZHCLM+z4=eyz2XhjYFdhJJLaFDH84zQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZqeKmrMr7SsAzZHCLM+z4=eyz2XhjYFdhJJLaFDH84zQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v4.20-3
X-PR-Tracked-Commit-Id: 478b6767ad26ab86d9ecc341027dd09a87b1f997
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fb5f5d3738c3a3ed7a3a8685266bc88dc69fbbd
Message-Id: <20181214174502.32554.75348.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 14 Dec 2018 17:45:02 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Dec 2018 09:12:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v4.20-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fb5f5d3738c3a3ed7a3a8685266bc88dc69fbbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
