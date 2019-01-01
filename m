Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B07DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA5C218A4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546378813;
	bh=Ke0d0T35Qjn4ASbLJdwxGjjrLaP2ME6TKXFIbVjnGBU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CuwbgR/4CfUTzZVthkJuMg7o/oiluDX15idyO65y7Jh/iDmrzRt6je4qblIye+i2D
	 hgZqrV0KNyfmI15Wl4xGdrLs42A5u/cTxWdaIsrddd4RLU12a6JYiM5YvcFR7OG2re
	 Qw1/bjTv3Bbfcuxmb3I75gOUOMLPiljtA+9kTvRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfAAVkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfAAVkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:40:03 -0500
Subject: Re: [GIT PULL] pin control bulk changes for the v4.21 kernel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546378803;
        bh=Ke0d0T35Qjn4ASbLJdwxGjjrLaP2ME6TKXFIbVjnGBU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A3Hzy/p8pbBvu3ACRI3ymH+8ObigZtJ0W8MNLfhnqVAbp0Q/z0schCYYUQtzJLT/v
         gn+fQI2Lc95aLPa6/IiIb08qc7fdSBp3JEaOavI1UNVRFzxAtG/ElaFtM07ARxGJaR
         vkmCv+NNBRCEcMvExcX10llNXysvrZ7Wdd2L3tkM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYfxQqxtCkDQ86ocZC5fL9b4zO0a7SyEau7UD26PE07AQ@mail.gmail.com>
References: <CACRpkdYfxQqxtCkDQ86ocZC5fL9b4zO0a7SyEau7UD26PE07AQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYfxQqxtCkDQ86ocZC5fL9b4zO0a7SyEau7UD26PE07AQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v4.21-1
X-PR-Tracked-Commit-Id: 88cc9fc41c7318565bcf28a843b1e4e3f2acf894
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9bef4a651769927445900564781a9c99fdf6258
Message-Id: <20190101214003.29500.62475.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 01 Jan 2019 21:40:03 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Dec 2018 16:08:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9bef4a651769927445900564781a9c99fdf6258

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
