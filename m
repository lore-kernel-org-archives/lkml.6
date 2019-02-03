Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC40C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC7021902
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549216210;
	bh=PsUGHdE/P0jP7kN+LBSJLfPIF99iSsuO+4oEHoznjlo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r+W1v93+pD0Cny7zghgFzteIGJrflVK86iDXgmmSY4dUZhZZaXCTapdHZBUOzCrN2
	 Z7R4z8d32E95KFsONoMcd4nBBJYGIJ4A4BfFJcp6mGufBzQrvxmGr2gCBE22Gt6kr1
	 z42Hsi20vRgbzdC9A4bYjhLT04dqiBarolbyppbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfBCRuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfBCRuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:50:06 -0500
Subject: Re: [GIT pull] x86 updates for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549216205;
        bh=PsUGHdE/P0jP7kN+LBSJLfPIF99iSsuO+4oEHoznjlo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PPagXjuz8b2Vl5WcJcd48+MSmNNZWbrW5U6KQympA42rtEBcu8dEJXWOKMH1wEwH2
         xqiUOMVomE8S9HIPUBbLvfizaDKQkKuMv9lDmpyEys1RzQIXO0HVIOCV14gKEhFBSZ
         G4j4QVrOKkT7fE8cx0lPd6bTZ/h5VH9BBq6ePUDY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154921049412.12839.11774598804715206628.tglx@nanos.tec.linutronix.de>
References: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
 <154921049412.12839.11774598804715206628.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154921049412.12839.11774598804715206628.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: e6d429313ea5c776d2e76b4494df69102e6b7115
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24b888d8d59847871387aa3b241b524661070a6e
Message-Id: <154921620587.4136.10348156610204216362.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Feb 2019 17:50:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 03 Feb 2019 17:16:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24b888d8d59847871387aa3b241b524661070a6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
