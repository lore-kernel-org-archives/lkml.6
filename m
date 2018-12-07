Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2EBC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9CA20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544207715;
	bh=7kUmXPjWMNLZrT0S4ZvPcTl8RBG3n8vFUulPe3HBqts=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Vfs1j6AkdLNFbzMxQZdcAANSX4s5TtaNq0dRBRwf5BleBTyNKe23s1btt4N8nrNru
	 8cvFdnc4WC1kI9rvZVF0OXxpsB3ZvuJAqy7NIREgYDBdYx7eKMrn179nAwwb6VsZ2/
	 ITuaJHqeyXJMROw5TnQCYAfjDPi/UwqaY2OnM/q8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9CA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLGSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeLGSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:35:02 -0500
Subject: Re: [PULL REQUEST] i2c for 4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544207702;
        bh=7kUmXPjWMNLZrT0S4ZvPcTl8RBG3n8vFUulPe3HBqts=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lWz8ZXwkO/4+5yXgSlO79VvuqFdpGm/hDL3QEeVCO9GQVf3kHlFlXFudgsUxkfCNa
         xJ44ZNVg5e7ZF0/h50HwhEUJiRYIc1tbHlNiQRUeV7G0bMIvOBUAZjHLyevn0EIe2X
         0ItrmWGNr6+5Ttk3St9ocMcotU16p3qPEqS6lKug=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181207130848.GA2661@kunai>
References: <20181207130848.GA2661@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181207130848.GA2661@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 i2c/for-current-fixed
X-PR-Tracked-Commit-Id: ece27a337d42a3197935711997f2880f0957ed7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52f842ccd615564a75ef45f8a0985ff14a0a61ce
Message-Id: <20181207183502.15805.82304.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 07 Dec 2018 18:35:02 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Dec 2018 14:08:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52f842ccd615564a75ef45f8a0985ff14a0a61ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
