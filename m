Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB94C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77332087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548870307;
	bh=2u5P+iaP/RDaB95DTdCh7bKJ5HiSR9V4jhw2Yob5rRU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ExkFv63Pzb1KD8Z4uGJebt0AgjNTH6DCnGDOzwpxKWPJ2ShV44VrLy6fqqljS9jdV
	 V62+CHRlAEgLB5TBp2rzu/rIFC760WrQY1Wq38IFx6Sa+cr6xRsxjmFriotvda/U8p
	 dbCGVo1OJmHPpx9wj1JZQXDOQGbmSZAs6ovTnKEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbfA3RpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732509AbfA3RpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:45:05 -0500
Subject: Re: [GIT PULL] GPIO fixes for the v5.0 series, take two
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548870304;
        bh=2u5P+iaP/RDaB95DTdCh7bKJ5HiSR9V4jhw2Yob5rRU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q8IsVQ2ayh+6/UYl5B1d6LJLETcv7Zb6L1KQVRN1iJgRbtSnDcRc6jnRplNVrxjEA
         kJJYxEIRYYGcv1ksD1zTeV3X9evW2q7TkyzejjN14UrE3dNGVyf5LmwTIkgOU+zO4i
         3ntqDbKMYOSJfK1vRYlwR+FKEXLJYjEYJs9L2GkM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZWGrinXV5oF0c5aggi51TKTR5GsL1nO3gA+6RMO7U3bg@mail.gmail.com>
References: <CACRpkdZWGrinXV5oF0c5aggi51TKTR5GsL1nO3gA+6RMO7U3bg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZWGrinXV5oF0c5aggi51TKTR5GsL1nO3gA+6RMO7U3bg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.0-3
X-PR-Tracked-Commit-Id: 7ae710f9f8b2cf95297e7bbfe1c09789a7dc43d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 877ef51d53abfdadabc64809d045d9c27c1cf757
Message-Id: <154887030436.3523.13116179291683735423.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jan 2019 17:45:04 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Jan 2019 10:08:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/877ef51d53abfdadabc64809d045d9c27c1cf757

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
