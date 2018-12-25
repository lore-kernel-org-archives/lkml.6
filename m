Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD46C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7990B218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780010;
	bh=RQXd/hNYKcF4ZIMEFI29geoBiughOjB1HLSxxcz3h5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ogf53q9NuFMObJd4cU+DbtRAQY9QX+1ctkFaIZ72VgLuBir8MZpdL1fndGDH+HTFJ
	 4pYjViKE4Z1Kl+Wjj2oIWpVGFCNwz41lka9diSUA13D/aYd3F2aQ5g4pjXVcdbI8nl
	 frnGiswAoEdM1oaOakJGYtvKoYbL+vGvtPfthzcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeLYXUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbeLYXUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:07 -0500
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780006;
        bh=RQXd/hNYKcF4ZIMEFI29geoBiughOjB1HLSxxcz3h5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m4RAd02r0WfPmW+e/yP4BFC4qeNQK+fwqb8aGq0ff8mCI5SyyhAuoSlGFJ/ijauX9
         HDMUq+eBHb6cOXXnf0XmSbFLPR1RVX0SamLmJG5dzvM6QIdZxqVKdg9fwEpCtwEITE
         hRgHqJdoPYqkYfKgCe1Yh1qCNsMrX/pdWd3QTU1A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221213408.248831-1-sboyd@kernel.org>
References: <20181221213408.248831-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221213408.248831-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: b677574bdf292e31c8f9810ff0fc0b35839d4636
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fbb2dc6f0ce95e73b9bd7e8e899089f5cebc99a
Message-Id: <20181225232006.23808.3515.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:06 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 13:34:08 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fbb2dc6f0ce95e73b9bd7e8e899089f5cebc99a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
