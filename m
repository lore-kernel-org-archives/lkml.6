Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409E3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894222080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544820006;
	bh=LXYfWegmrRC8ZZ/OXxduv1Ub7ta3/FOocSYbXkKdo40=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Tx9km/cqy8bzDNeS/1hjbJCjeT4rmt9M94n19b1vfN9AxCPTSALGbYXinPm4e4hOa
	 oZsmxtFCaoqm0cOkEYwbc2RNEQEal0RlE8ZeNK7+3ai53Xd3lxr/SRGeoqtnSGG8Fi
	 w3uJ0Q1qPqCIGCJslMTnCB+gzUULaPS4KBw/PdE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeLNUkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730714AbeLNUkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:40:02 -0500
Subject: Re: [GIT PULL] clk fixes for v4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544820001;
        bh=LXYfWegmrRC8ZZ/OXxduv1Ub7ta3/FOocSYbXkKdo40=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UDP0INMhTpHqQQjkIOXEYQ5JSpyVUc0c2SS5Q6hDWGtrlTGIEdV9sJ+cGrWhI0CJX
         6jSBxfuJT5f47QK2jIrU//B92xp8HK68RM5bdt+ZI4YTc6r0gxU/UZL9XrdPtS/fAF
         lHmmptW9isBSje1NRWJQWz7OZX8zC/uWChqisqM0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181214181921.99645-1-sboyd@kernel.org>
References: <20181214181921.99645-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181214181921.99645-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 8a034aad4892baf82f8c9082f969c5ebc1143a05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 743e3c8f19db951ce9d20e6accb290444f4737a4
Message-Id: <20181214204001.7612.82752.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 14 Dec 2018 20:40:01 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Dec 2018 10:19:21 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/743e3c8f19db951ce9d20e6accb290444f4737a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
