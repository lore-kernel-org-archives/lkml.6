Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E5C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDD721901
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549216210;
	bh=r+HEkeiTbAcYcmfrrEPq7t3btF+MrYiF2YuSarpmmCA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=plKWX8bfVrGoUeOUt9mxr1oesQYHEqd9wMhZ6LGU8jl0qUfSbQhQ1kQdPb0mcEGnz
	 GyCCQ6QIcz/ESovffec3X2igtSVBomWLzbBm9Llwy7UXXJdlxpMTtmJshGgP6hSZAm
	 c1higOzNXKZZZpVQ61zalN9xSUyZqqflFBeu33B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfBCRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfBCRuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:50:05 -0500
Subject: Re: [GIT pull] perf updates for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549216205;
        bh=r+HEkeiTbAcYcmfrrEPq7t3btF+MrYiF2YuSarpmmCA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dpjy6ZCgkbFZm0JIlfPayv3I0uAyIo8R40Ix+4DQ+6LEHge9/MlkFZg/DkWOV0vrt
         MLats/F9HSD/l7WjHPyEtiPXNU908LmgRds/xTwsUb66pFrG35CSASzfv/nIatVlZn
         SR35Lm0vi0fr+lxHRixHQ/CBqFrRp4pFnOXyb5nQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154921049412.12839.17184514592792868263.tglx@nanos.tec.linutronix.de>
References: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
 <154921049412.12839.17184514592792868263.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154921049412.12839.17184514592792868263.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: d3c8c0af7565ae5b4f9e65cff6e824ee2acdd451
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58f6d4287af751a75b24f4d32e6e1b077146ab18
Message-Id: <154921620524.4136.16146605016832841343.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Feb 2019 17:50:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 03 Feb 2019 17:16:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58f6d4287af751a75b24f4d32e6e1b077146ab18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
