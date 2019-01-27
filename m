Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC52C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E5F217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548619811;
	bh=ml6HxN4EUumVtm6TJYLXc+Y2lH+jk7rWxVyqvNi8aw0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Eh6VKQhorGyB1YyfM1Iq4q5MtYxM8hpaYMiA4GGatc7IV5RRBKECtWi7ZXomTv/Co
	 BYVwKSHVqPlVJYJ2xy37JJeJg3ue10RVtBnTjBAZ3YtggAmUDOaL5HadBf0hRkLJXQ
	 UPOHaGZ3BkqEcpapfwn0V43FJ2dupNytke7lwQkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfA0UKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfA0UKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:10:07 -0500
Subject: Re: [GIT pull] x86/timer updates for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548619807;
        bh=ml6HxN4EUumVtm6TJYLXc+Y2lH+jk7rWxVyqvNi8aw0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N1KGVOBInxHoMgZxJUEot39TJ7J0lANk4RlaqyITiEvjlVCoQ/MfBnGNYceKOiZje
         ggDLtkGD07hLD1PFN85D+I2KJwbdhTzuw2lueTwcbXGVvewKo9nRBrCyaXSFovYcD/
         xJgjejEQ52Ncx2XtpewT6540Kj1pGpM+Fn9+poV8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154858670614.17124.11558077810916024944.tglx@nanos.tec.linutronix.de>
References: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
 <154858670614.17124.11558077810916024944.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154858670614.17124.11558077810916024944.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-timers-for-linus
X-PR-Tracked-Commit-Id: d999c0ec2498e54b9328db6b2c1037710025add1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 351e1aa6cb4b136e3f772605071d7a8db3c5b4e0
Message-Id: <154861980745.25513.3328846038709714606.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 20:10:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Jan 2019 12:05:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/351e1aa6cb4b136e3f772605071d7a8db3c5b4e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
