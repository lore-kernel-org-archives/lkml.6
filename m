Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6823C43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23C3222A9
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742415;
	bh=BRQl3gxEbgjvsLE7t8/IIGcnYSjmUw5mWzttTmp0llE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sRc/8FanzSsx18nwxhSa32vC/fReiK5s1yxS7wbbykgmBZx2O4uNDaKvqazkooFz3
	 5wy7ZvpqqURMCKzGNwdCk+okbiiGH5kn2Qvhr+TcTuxOQFSJY72ICthJzzVcYZ5b39
	 dVIw6WZdLr2nPvUxQIYZs+M/hEyQ1uWjB9BKiJDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfAFCkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfAFCkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:08 -0500
Subject: Re: [git pull] FireWire (IEEE 1394) update post v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742408;
        bh=BRQl3gxEbgjvsLE7t8/IIGcnYSjmUw5mWzttTmp0llE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PMBkzv934YDtFo2QaGEpKQJhNK/FhgjyBbew5Pnc0XZLF2jvEADJwMwh5FR2PNJiH
         K9FQU4zq0bq36E8g6HR624hA2arqAXTcEmmM28EVzEZSP6LVEVwH2CT6+wM7mJhsfK
         fBEM7pCm9f4wDYmJrqxGcfV5jO8L/Pq7UwHYQSJA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190105170540.23961069@kant>
References: <20190105170540.23961069@kant>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190105170540.23961069@kant>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
 firewire-update
X-PR-Tracked-Commit-Id: c820518f6ca150d099aaeb7b71ad9e96c61113c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15b215e5aa29993c1b0f46693a1b482296bcf08e
Message-Id: <20190106024008.13237.61757.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:08 +0000
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Jan 2019 17:05:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git firewire-update

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15b215e5aa29993c1b0f46693a1b482296bcf08e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
