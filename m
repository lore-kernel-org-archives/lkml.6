Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80E5C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748132085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546810513;
	bh=H9cCQudMHNNQK/1AQwT6JEgwRpvLqj6ObItj/hY29oM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NmTtYXGRcqQc6KfvjuowbG+9/H+E3qYEZdJRvnDl7eQTTqYyr+wrdYbHaZc6gKiH4
	 5D4mgYgCFkxTWbThBZ0IFaHhUyDDacqRLvVbwDNEROXifn0gmGAkfxKo57CNcbvKVp
	 d76xjdq25hgvj2BEovp5bb35neISYcNH0brd1ffA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfAFVfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 16:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfAFVfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 16:35:03 -0500
Subject: Re: [GIT PULL] fscrypt update for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546810503;
        bh=H9cCQudMHNNQK/1AQwT6JEgwRpvLqj6ObItj/hY29oM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IYF1cVm6CoHloUxk0540PuJyVHwe/VOoB6zJI+WmIU2pFFD48C3dq3Bn2gkY6lGSa
         ANcPrkN0gSjkNm1uMLXBTTcnN9zea9f0CrHc0sYLevKi2+QkoONO8HZ4EbvG2jsoTu
         Za6mIZhSkpJ+0Jsjzi7DKCvhcpVqoANC7kOF393s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190106134912.GA27028@mit.edu>
References: <20190106134912.GA27028@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190106134912.GA27028@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt.git
 tags/fscrypt_for_linus
X-PR-Tracked-Commit-Id: 8094c3ceb21ad93896fd4d238e8ba41911932eaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baa6707381285e68cc472efba58e7e736057aacc
Message-Id: <20190106213503.15318.9644.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 21:35:03 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Jan 2019 08:49:12 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt.git tags/fscrypt_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baa6707381285e68cc472efba58e7e736057aacc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
