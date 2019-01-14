Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC66C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E036820651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547490618;
	bh=eo4eVgJ6Ke++SImd5LTuKxl7ZoMVdbac8AoU9Lw+at8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EeuO9SRUv+/E0apK6C9mLn/+ErPNYWlvSCfHjzf7lAHHd2W5qkRGOrXT8xjS4+pbK
	 omVEepqAKv6mTcelkXQfzREDHPDua2RyNWY/GftSagncmc3EEzv2dpV3fuNI2JowyI
	 wJpuapAOQhRRuUfUAjRD1z68KHjbqAtNo6jRdhRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfANSaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfANSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:30:03 -0500
Subject: Re: [GIT PULL] GPIO fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547490603;
        bh=eo4eVgJ6Ke++SImd5LTuKxl7ZoMVdbac8AoU9Lw+at8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aTG4ItGVYWS28wPQHGscf/G9+I9pk28f4h4t4rAbzg1mTq1g9CKUDViW/q9ef7Ic5
         jbBNy3DBSB29sx2KxQD5l9UiMewAFARYDqBVL2fWQ+X2+gxyapPZ12RWX0+3Ao6pHc
         CLP2YR5aM38B+eu/ltLArMTj90rWnwfWDCjF37ic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbP+kAp6px=QOZ6SDMLKVEYsjEA=CoR7D4whv0c4+motw@mail.gmail.com>
References: <CACRpkdbP+kAp6px=QOZ6SDMLKVEYsjEA=CoR7D4whv0c4+motw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbP+kAp6px=QOZ6SDMLKVEYsjEA=CoR7D4whv0c4+motw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.0-2
X-PR-Tracked-Commit-Id: e3e4767bd550b3f19278e42bcce143e0d2316ba2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c962cb323ec260652cff9331e7bf3d606292db88
Message-Id: <154749060314.22817.14172887361318069096.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Jan 2019 18:30:03 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Jan 2019 09:27:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c962cb323ec260652cff9331e7bf3d606292db88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
