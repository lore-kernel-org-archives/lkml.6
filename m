Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9DF20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547714105;
	bh=S8sU3WonOz7UVOUX68Tbu5GytoTC+GbkX/g2tckfAbQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U9qcSHn/dwRQ9VpzMm1bXESmbzL7OIiy3K4yyJ148XGtf5ASKxkJJ2yj9EwU/bUJ2
	 cZo3riHgrKD+i1Iia5vxwA6PjnvC0zO3A+hm/Rj7AU/lrLVKh6JCO3rV8t0uLIqsvy
	 RHL7EKHdDOWehy66P3mjp/sYXrwSq+QsRFy8KYHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfAQIfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfAQIfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:35:02 -0500
Subject: Re: [GIT PULL] Security subsystem fixes for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547714102;
        bh=S8sU3WonOz7UVOUX68Tbu5GytoTC+GbkX/g2tckfAbQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ppHVdnGDya59ByHH4YUQCnvPc2vJB9uoY5AnaapFaf/IXeGgGRGBeyfINQ6nq+jFO
         t4w/KK85qXPZt9DXouWWakVL02EpBgIF9TqhCrE54ienQ+uSe94lSon6O+Yr9Okhfp
         ljn0EVtN6gsQUfO7+JQzxyH1pbaaBkmvcGU40+lg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1901171437560.28339@namei.org>
References: <alpine.LRH.2.21.1901171437560.28339@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1901171437560.28339@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 fixes-v5.0-rc2
X-PR-Tracked-Commit-Id: a5795fd38ee8194451ba3f281f075301a3696ce2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fbfee7c80ded94278f109aae4063741c323294a
Message-Id: <154771410207.32649.15344082153613065266.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Jan 2019 08:35:02 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Jan 2019 14:40:22 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fbfee7c80ded94278f109aae4063741c323294a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
