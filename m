Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039BDC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7DF217D8
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548619807;
	bh=ga0SdcuaHa6YyBwCD4EZ4foTW4yGn1FKUYAfijdaNho=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rh3s1r3uF9z/uB/QiXpEJGjqND3FXPfLmYltwpozBG+gFLSPdPA+UMzi7FzGOoPhr
	 69190CfqVtKqtjb45EzeAFgXtfxKjhQ3AwcFvkXqWDZJqYUOrCZ+rIQGnCCDN3Igh1
	 Xun8lyS+TZGxfm2KouDRSr3aHEdACRXwIXdUmHlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfA0UKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfA0UKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:10:05 -0500
Subject: Re: [GIT pull] genirq updates for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548619804;
        bh=ga0SdcuaHa6YyBwCD4EZ4foTW4yGn1FKUYAfijdaNho=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rN8jNmf8oz7zvIE8pNUXweXlclkY2qbalvOjGPhv4EHyyd/oEFw5412C3IPTI9U3r
         Xqw5VTm4LqxUwY7ImDHP/9v/J7BmC+A+uJSsuel5wv/VF/WfpexD9CiQFeMaaOf8kg
         kR3OKPeZv84wG/0QT/Tk0OzG/wCA/tBJXbDEqhHI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
References: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 37b144df8099465bf8d08296d8b424c77fd9b0ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d484375d73ad2ec39a395365449a70c200645b1
Message-Id: <154861980471.25513.16606351865862553106.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 20:10:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Jan 2019 12:05:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d484375d73ad2ec39a395365449a70c200645b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
