Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95A0C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8571B21874
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484706;
	bh=hRv43Mht2MjfJo6tENSO33a9Ywb1dnYnQTQE+0MTUdc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Mi9IUXhYX6P+Uqc4hBeZK9Tql8o/7959lI0V8HNJpLd238YnPdC/xDxp4S80W0725
	 6WGQSLIrs62HBakcAVP67hEUvd7/Ndx9QImrdc5ioosR76D2V1BgN5PMbpaA7WldoG
	 wXE8vetn2QV3aSn1sNkbE2JE1p6WJVSGXuUzR6Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfACDFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfACDFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:03 -0500
Subject: Re: [GIT PULL] s390 patches for the 4.21 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484703;
        bh=hRv43Mht2MjfJo6tENSO33a9Ywb1dnYnQTQE+0MTUdc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wx+0AQjsdi6nNivimbg+mCz4n0t6bannvry6TrYA4savpPoyXsRO1UZ+MDNrA4Jmj
         IA0yGIAvYv48gW56D9N4ysYpjh3CqXAUa6zlOOUkZFEVxGIX+VHoUnM+scRH9hsUy1
         0PCTldZjwLISec3bZm4ZMgR2cuq8AZhKMk1EQ0ro=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190102084354.335d2272@mschwideX1>
References: <20190102084354.335d2272@mschwideX1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190102084354.335d2272@mschwideX1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.21-1
X-PR-Tracked-Commit-Id: ec10574d00da0d8b6ec9d0099410aae8aad4695a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04a17edeca524b71dbb5be41a7002d247fbf34c0
Message-Id: <20190103030503.10885.59291.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:03 +0000
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Jan 2019 08:43:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04a17edeca524b71dbb5be41a7002d247fbf34c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
