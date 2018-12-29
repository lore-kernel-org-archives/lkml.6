Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF036C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0A4218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061803;
	bh=QWJdJxJUr+ehIT+3bvGl9NtkW0wNHrnUh0aGXIlike8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Jd0hnLrTdDLD2ICpA+KUWh53wwcx8M7HllZqWlccC0tTztoOVZAqGTnTIxuZP//3m
	 aGrtkOblAWJEP67E+Qwe9HzGY2meDT4eFpelusRVNpKlKI/fyS969+MmguzTGqYY1M
	 RoqwMPaUvLp3kBgNFwhlEahUji//OArQ5nQZd+5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeL2Fgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:36:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbeL2FfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:05 -0500
Subject: Re: [GIT PULL] GPIO bulk changes for the v4.21 kernel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061705;
        bh=QWJdJxJUr+ehIT+3bvGl9NtkW0wNHrnUh0aGXIlike8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tak/PlpzAlI1JAJBqj3V9T7LIFWMNkFVA/dc+D4KOMN5MdHkiHWo0J7AvIVgrjv91
         4abPTKlkLlJu4BE9bQ4Xphh22DgvKluKkRi5khd4q2xNR3aMjZX0Alk5gygARslSuq
         7414fbJlzrtFZ4hVi08bKiiM96e521MOY+JgxPcc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYD7469+XPRhNHRVtwkQzsWJ5-AK7cD_yVcDCLko-P-dw@mail.gmail.com>
References: <CACRpkdYD7469+XPRhNHRVtwkQzsWJ5-AK7cD_yVcDCLko-P-dw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYD7469+XPRhNHRVtwkQzsWJ5-AK7cD_yVcDCLko-P-dw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v4.21-1
X-PR-Tracked-Commit-Id: a7c23f8d154f7919c5fcfceea6e0897be2d5ab71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24dc83635ffe3c93d8122099a83ee228c9b7e4f7
Message-Id: <20181229053505.9301.47837.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:05 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Dec 2018 10:23:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24dc83635ffe3c93d8122099a83ee228c9b7e4f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
