Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBCCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6732195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545520204;
	bh=jFvx2f/qZI8r+EBWMJNyb+Bsc7sDL7i/HahAuMl1HLU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Zt/w2yxg99e8LEz4zew73TjjNWnA8jrx1h54gc1O/MDpM6oS3soA44q0MSCQ5rBl0
	 Dt4GdbA8v/zvEKLufcKns8AKRN+rqHTcm4EF4HykXZ/lTOX7sMSm2mkT9M1CzYvQMa
	 v/6fpV2PnwBEw8k7fN8mWONzgKOXCW+QAvXszifA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405070AbeLVXKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404344AbeLVXKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:10:02 -0500
Subject: Re: [GIT PULL] auxdisplay for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545520202;
        bh=jFvx2f/qZI8r+EBWMJNyb+Bsc7sDL7i/HahAuMl1HLU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OqRREGhVoclW6qE7jyU/07cHu7HxX8mmsTtxhtK7t1rg+JwfPfaOms5bzwfE6qeO3
         iN+nNSbzEvwmMseTo8EAbRh3hEKCmEUkzS6VgoLIlkb0TfBnVVAs5uj8GyoQWrMpID
         MNuiLzZS7wczlHRt1F031+/0klTYuh2bPPrTSUss=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221205302.GA29847@gmail.com>
References: <20181221205302.GA29847@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221205302.GA29847@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/auxdisplay-for-linus-v4.20
X-PR-Tracked-Commit-Id: 9bc30ab82108e6a34dc63bf956b49edf71b1681a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38c0ecf6087a8cb2af24ddd2124e9ca3c666dcdf
Message-Id: <20181222231002.28463.90222.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 22 Dec 2018 23:10:02 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mans Rullgard <mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 21:53:02 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v4.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38c0ecf6087a8cb2af24ddd2124e9ca3c666dcdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
