Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDF5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAF5218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061717;
	bh=b2fsscT4hXSJcNWwwA4G1Yp+qzjF7WogXZzQAC3wLqA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZEyB95ywmcqZhuhhrnnhrIqa7FE43DyPC+FNH27LZ5s6Vqz61rCFvOjNB0sDxyFOw
	 1opbvNZG+OKJTR4iu2wy5lSdSr+4e29443K4Ht666pjzEEP/bapKAbRtvcmnqK7HoI
	 s0/rmU+i9Z9EJTfpGoQGG3emOzOUx3Ka7lQEDcQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeL2FfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbeL2FfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:06 -0500
Subject: Re: [GIT PULL] power-supply changes for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061706;
        bh=b2fsscT4hXSJcNWwwA4G1Yp+qzjF7WogXZzQAC3wLqA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UjFwV+rvkwZ1qFfSlL5nzijayvT30hG91cAgNR1jtuYil4T+pRfNp5XKCEKLLKqsp
         C/se8jDXjvyUelZluGl/7liHItORqjd19OLlvFzWeymCV8fuqW0mOBxII5vd8hwBo3
         W8X9x2tcVUI8fUwTkgglwpgf/Ay4YqkEaauCitoI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228130852.vqihu6gdyzczddq3@earth.universe>
References: <20181228130852.vqihu6gdyzczddq3@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228130852.vqihu6gdyzczddq3@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v4.21
X-PR-Tracked-Commit-Id: 9580913966488dc78d8d2893c7427d0a84124e74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 579a70035949b771a63a686db8becdd9b197d986
Message-Id: <20181229053506.9301.16598.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:06 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 14:08:52 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/579a70035949b771a63a686db8becdd9b197d986

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
