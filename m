Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B16FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12E921B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549910110;
	bh=OI2L5XYc6tmSoxU04a80mo2HQXYs6X8Ya23WM5NB7dI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ox61lk6dlZjLh9OpB8KijXNtVaOU0yP1KH16geTu30At94BnrEi5AABBN8jlrwPH2
	 pfjPsWYKpW/KXEDR8fK1Dro7/Ef4DsmHuJtxVfRVTZotPQ5JX4+Z1sB3Q1yfMw02/0
	 gafwjGniVTnaA1lJCWqOPWYi8oTCBeodf2jfZcJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfBKSfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731953AbfBKSfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:35:03 -0500
Subject: Re: [PULL] alpha.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549910102;
        bh=OI2L5XYc6tmSoxU04a80mo2HQXYs6X8Ya23WM5NB7dI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k2E7gSuXBxCU5WAm5T3ul+/XrtDvlf/OF4R8pGy3GyzoXUTMj76d46pI2sSV1RnMQ
         twOFoGQBIc7/gBuaCZo5kD9qwjDFFQcEyXm+RY4BQnYXOlYo4hm256UTpit2MMp6LO
         yn9s6Z5g+UPIEqeAN7DBEA9h9qZDHX1WJwtiZ6Xk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190211044615.GA30805@p50-ethernet>
References: <20190211044615.GA30805@p50-ethernet>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190211044615.GA30805@p50-ethernet>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus
X-PR-Tracked-Commit-Id: 491af60ffb848b59e82f7c9145833222e0bf27a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 244cce14c17705e6376cd12c20c27f8712793acc
Message-Id: <154991010269.27938.3585347665579017754.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Feb 2019 18:35:02 +0000
To:     Matt Turner <mattst88@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>, Meelis Roos <mroos@linux.ee>,
        Bob Tracy <rct@frus.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Feb 2019 20:46:15 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/244cce14c17705e6376cd12c20c27f8712793acc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
