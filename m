Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51008C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC48218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546456219;
	bh=lDpZp/BYGQ38YPWhaBOjGY8oKLrvBNO2VNdbvbcJPYU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OMiph6CbgYrJgvo+e3sKVFr7SKm7Jaba7lOEsYjrhnqyJ2VV/Ji4gbrXV9fGmUiKJ
	 7Zz2LKj1X3jWeYWR2Ag19XLSNYKLrweT/tT7E+aEINlyxi/h7XW4IaZbR3T+Q+2oW2
	 PWdBJ6WxsvGC2bt+erxK52ewXbuVAEnHPiBtMEu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfABTKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfABTKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:10:04 -0500
Subject: Re: [GIT PULL] security: Smack changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546456204;
        bh=lDpZp/BYGQ38YPWhaBOjGY8oKLrvBNO2VNdbvbcJPYU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mmQM7WtfkYK7BW/+tHd69qi4FPD3TH6K0nNJugagxvSOUfnD1xKYf7yFwGKoS+gMJ
         tSD9cCUKXdvZAUaRJZGn1Meqgi5Fzyq4KWr3QrZJCOK5Hn05uimREqWRHbSWYMZGMs
         3RQg1SP5uVDvsus0myTEP4zZg8zwohVYDi8RWdAQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1812311515150.1435@namei.org>
References: <alpine.LRH.2.21.1812311515150.1435@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1812311515150.1435@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-smack
X-PR-Tracked-Commit-Id: 20bb4cb4fb9fb994d757932abc4404cf0f0f56cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19f2e267a5d0d26282a64f8f788c482852c95324
Message-Id: <20190102191004.32204.54269.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 19:10:04 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 15:16:25 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19f2e267a5d0d26282a64f8f788c482852c95324

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
