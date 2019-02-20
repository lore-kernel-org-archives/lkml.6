Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E439C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C4621848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685018;
	bh=PVAE7cxVOwn8XgihkfGXSvD6s8UFV0h1PunSdeWgvs0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r2wQdi3wi0TiLEFIaeqmNeqA31/KmJk4dMI9kl1NcvkP96o2NKZoNTaopChPI2L2z
	 DmuI77GRFOr+AWZkoavAdP5fQn0Un/0I+np5INBFeR+x8HrGhh4lJJYktHWw+0f5JS
	 1G+cGj/pF4g++6XDCrOCE3L29PDyp0TCVk1LzDto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBTRuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfBTRuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:50:03 -0500
Subject: Re: [GIT PULL] GPIO fixes for the v5.0 series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550685003;
        bh=PVAE7cxVOwn8XgihkfGXSvD6s8UFV0h1PunSdeWgvs0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RniSbpNIV/hM4fOcRh2xEdxasLmh6UkqiDixcFSqHsvrameA0HYbMXM6tCODgmqS2
         IAt0gf+ZDdejcy0KTl7hqH6PGc0sWmxAe7D8iQLbxchXxMJ3iq9738zKUrj9lMdCUR
         715dO8u0tlU/jhvJzCtRS+NQYmY7rIsPKYM+2fmo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYq5tVpFNC7sjdSATOMKCOeMxrjKK-pP6HNzgHt2bbVgQ@mail.gmail.com>
References: <CACRpkdYq5tVpFNC7sjdSATOMKCOeMxrjKK-pP6HNzgHt2bbVgQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYq5tVpFNC7sjdSATOMKCOeMxrjKK-pP6HNzgHt2bbVgQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.0-4
X-PR-Tracked-Commit-Id: af14b2c98adb85e9517390bb88309338b9075350
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c828c2651b9a8184e1414fa0611d18b84d3847dd
Message-Id: <155068500316.4632.4691349679153311331.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Feb 2019 17:50:03 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Feb 2019 09:03:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.0-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c828c2651b9a8184e1414fa0611d18b84d3847dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
