Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BEEC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563BC21917
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549672805;
	bh=7FC18TeR9GdqRYFO7TxdF3W3a8aD1xqcJO71kqBUm48=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vwsBg4WBSefyUyIKkBt2YFF3XvhhZq41F1Apk60hKWTZ5+IypA5INJ8ka28A0CpKE
	 vI+w8Y4ZmC3WfkidJn0N49EF9l/S60o4kPHtTYklEJTXgXZrK7wwbtYxtNjPSZkOKF
	 gIUVR4T17GFu/W1nsqyrClvLLzWk7XMZ59vQQ99w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBIAkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBIAkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:40:03 -0500
Subject: Re: [GIT PULL] ACPI fix for v5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549672803;
        bh=7FC18TeR9GdqRYFO7TxdF3W3a8aD1xqcJO71kqBUm48=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I66/RZ5G5Iliwir42khPru3qOt+/Zhex44Ry+1iVLdGHpKfGyFCDMGAC/lTxoJHgN
         1fVgSbTdI7ufnIkMVl1MpVmQqpFsQH/AnW807iHgAXW6IdtXomREKuyDjrBE/pOTd6
         +L92AXO+79fMHKHjrg1VoWlmbtMvEtqDBL/sq+1M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hX3PB6k3GCP2y9MYGJiYH6Fvg=cFdUNuDx0FB5UnVY3A@mail.gmail.com>
References: <CAJZ5v0hX3PB6k3GCP2y9MYGJiYH6Fvg=cFdUNuDx0FB5UnVY3A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hX3PB6k3GCP2y9MYGJiYH6Fvg=cFdUNuDx0FB5UnVY3A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.0-rc6
X-PR-Tracked-Commit-Id: ce5cbf53496bfebe1b7478a532820373342e8302
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2dac603d4bcb98c65d6f97848b72a217d0dd854
Message-Id: <154967280295.26526.10186217024779825847.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 00:40:02 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 12:22:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2dac603d4bcb98c65d6f97848b72a217d0dd854

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
