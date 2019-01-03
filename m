Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA776C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8939920833
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484723;
	bh=j2HtnuhtJWYobK9vDdELXvpqgglOVTJqrphZRS3CgB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b+frkYo+p+ma/dURmul9pVtxCSJhaDnW8ndXX1RUzH0qvn8ZJN/2NMQcpLbiNbfqZ
	 5vfyjBVt++cC+Tm1TtdwYOJ1MtF7UxTcIWUFLfk0WPZgTTZeywklQfI+ngTDuL1hiD
	 x5iAG+llNfqLijFrBvSVPHwb0Hl0e5JSCYZSNGDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfACDFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfACDFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:04 -0500
Subject: Re: [GIT PULL] one more clk change for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484704;
        bh=j2HtnuhtJWYobK9vDdELXvpqgglOVTJqrphZRS3CgB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kdJLynrJfClaygYTL4AvltXadCSln2eg6B+BGhpiGC7FiyhVnIvAjXLvMMWSkNN36
         FUBCNLVDJe3BB+ocQG0gsyljodvxNkWUTsi50vl77UeeLH+TqyBUhyDeGd4YDJ5VCn
         pXYi44+Pj+K4q53iD13jCSrcMFnPmilD7xBfMVTo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190102175342.71807-1-sboyd@kernel.org>
References: <20190102175342.71807-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190102175342.71807-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: 08972760d366b83a87d366b0079747f8c409163c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f2107daec8137e1ea8bcd6df1323ffe46a2e873
Message-Id: <20190103030504.10885.79564.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:04 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  2 Jan 2019 09:53:42 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f2107daec8137e1ea8bcd6df1323ffe46a2e873

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
