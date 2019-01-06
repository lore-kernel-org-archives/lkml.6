Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4DAC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D7620830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546810504;
	bh=XJq/NWs01oSp2XPROkQJ2dlhGvGFTZyQj7QFK1tPZcE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HNYwf3nqL2tlEuk0pR1UZunQTgYdNfU+iVgZMEp9Q5D2JJOIuSf/ktqyPvCLLCRy3
	 5cPon1uw5dNY0ZAjCn0U5LtQ5lQGMssrzUUDlR9B/R11YFOC+pzlWp9U93AAuWrzNG
	 Tu5yxrAZ7lS68G7RKy5DcgfLJoHP8EWj1Uxbge3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfAFVfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 16:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfAFVfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 16:35:03 -0500
Subject: Re: [GIT PULL] ext4 bug fixes for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546810502;
        bh=XJq/NWs01oSp2XPROkQJ2dlhGvGFTZyQj7QFK1tPZcE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jOYBfcts1ftJ5sflmzhU10ybBztQ5PWyS+BiCtWoxFXcc6SioxXZOWaNpnWFlhreR
         qme1mzX0aWoh5bpN+miRO83sBJUsD1/4mznC1LJU1U2q8o2nCbNeWiryDHnUW9xvMh
         3JMKjvxCXOg9MtpoB+RxZ/7OiTQB8kRTsqgcdzlE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190106133943.GA10099@mit.edu>
References: <20190106133943.GA10099@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190106133943.GA10099@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 191ce17876c9367819c4b0a25b503c0f6d9054d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 215240462a9672db771bb60adcc1c4fdf40e8ec4
Message-Id: <20190106213502.15318.26248.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 21:35:02 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Jan 2019 08:39:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/215240462a9672db771bb60adcc1c4fdf40e8ec4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
