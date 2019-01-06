Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7144CC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 00:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ADC222ED
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546733704;
	bh=Dz8XVBfsBJtzGJpdS9Amnuwg63iRfR2fC/PQcqSlgmQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rhUjhZqQp680mqCz89u2P5Fsn/HZjT6uUonmdZvjy3vNDRS8cI5uBRpOGlpf/NgXk
	 h/gANEUTyuGD7lTcepUbEV13pTAqf6kfoRIKLryRa8nDj92msa1y77nIeD0QD9iVaU
	 NLQPUgt65DBvhPIXy8RcBn8KPK30SS3e/LvB7A6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfAFAPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 19:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfAFAPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 19:15:02 -0500
Subject: Re: [GIT PULL v2] Thermal-SoC management updates for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546733702;
        bh=Dz8XVBfsBJtzGJpdS9Amnuwg63iRfR2fC/PQcqSlgmQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ULxAJ015M7aBYK3KPelSIsJJBxom/nqeJma45uRQ+El0tPG7g5weuWiW+4dzwDsk/
         vPbn80vqvn+mWGrep8x8is9sz7EmJTP0sEIeSIu7EkEd7VsvZ3L9XsOkSlzqDnUOUT
         CbUpt2XHCnIk/nq3nO0Mko+iK25bxlyfudffENKQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190102200532.GA2320@localhost.localdomain>
References: <20190102200532.GA2320@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190102200532.GA2320@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 linus
X-PR-Tracked-Commit-Id: 9d216211fded20fff301d0317af3238d8383634c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c280230254635da33703dd8f4a10cad23f640fb0
Message-Id: <20190106001502.814.26251.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 00:15:02 +0000
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Jan 2019 12:05:33 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c280230254635da33703dd8f4a10cad23f640fb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
