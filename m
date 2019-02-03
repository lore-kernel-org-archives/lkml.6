Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E45C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7576E21901
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549216207;
	bh=1ih4K4wBLQyG/F6PiJqg3M+c3hVZ2m1JpqXFwoaGDxM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Im0t7kXUqssFmpn5MO1OswhdoRY7rRrDSZ8cekQAoSv1FNTmMjrhwE4d9U7bFuNQT
	 NklObDA0Nm6t7+lyOPRW+ZAOSLUxL7yaquIL5YSRZOWDswzfSuU0lpYP+YLc8VYhlB
	 DVBFhGaZczGQo3OtskzBObJv+wPPWio4q70KJbM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfBCRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfBCRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:50:04 -0500
Subject: Re: [GIT pull] efi fix for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549216204;
        bh=1ih4K4wBLQyG/F6PiJqg3M+c3hVZ2m1JpqXFwoaGDxM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1PhB+TFKoFh70m0G1oxVcDywQ/Oo+HuT8c3SxOJtz2Zr/UiN9nw/zHSimUW7aKD/N
         ZciUliGbvqmpxWIOFJuBqV5/A80Zd9fdHhygryAtAd4wRF744JhoBvLjyoReuTtskV
         6E5/R/4xsM8slZVAq462knJr0MI1nzrw0PBHXhHM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
References: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: 74c953ca5f6b4d5f1daa1ef34f4317e15c1a2987
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89401be6580eab6419bab1f553144131e7a335dc
Message-Id: <154921620438.4136.14887910699628779934.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Feb 2019 17:50:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 03 Feb 2019 17:16:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89401be6580eab6419bab1f553144131e7a335dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
