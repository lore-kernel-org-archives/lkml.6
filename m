Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6047C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9762081F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544298604;
	bh=M+04RDwVhQq46VVuBHn96pgK7U1Avo7csnruPDfNRgw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GkTuPKFTs213qE/pZ7zyZDyz+xJEhT4jp2WS46NWxe+Gk630fTHo9yXp+4EwL+vOy
	 G4mdkxCPaOdiezgKK7g2rWq6SBTerFHNftTX10B8cfDsETfIPmhz6NF2HQwpi/JwHy
	 yBRSoy4LKPPw7QXbwVDI7EXRR9e2ZumC36TyV6qY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9762081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLHTuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 14:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeLHTuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 14:50:02 -0500
Subject: Re: [GIT PULL] asm-generic: bugfix for asm/unistd.h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544298602;
        bh=M+04RDwVhQq46VVuBHn96pgK7U1Avo7csnruPDfNRgw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vFv6xjwRpkZHyh8EnFg6hpK9bidyG1RVsGutiBEVRN/Hi/CSqfFUHRhYL0rY/MqYw
         c7Butwo49K8lN2B4EDf5fmLCIwrrVC4xrt1IeGUqzQ7h004UNXK/dqiJ2xTsNrn6Qv
         dw4MZtksvXy1AL1miFmKa36d8mVYDhrhSp9f/O3U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a20S++xEHTYXXuipZ+YUZc0_EY2bj0JmaDwWdgWoLTROA@mail.gmail.com>
References: <CAK8P3a20S++xEHTYXXuipZ+YUZc0_EY2bj0JmaDwWdgWoLTROA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a20S++xEHTYXXuipZ+YUZc0_EY2bj0JmaDwWdgWoLTROA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 tags/asm-generic-4.20
X-PR-Tracked-Commit-Id: b7d624ab431227af376787148cd7d474088c03aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8214bdf7d3e69050221aad19ec28826ed6cb4934
Message-Id: <20181208195002.26881.79682.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 08 Dec 2018 19:50:02 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Dec 2018 17:01:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-4.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8214bdf7d3e69050221aad19ec28826ed6cb4934

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
