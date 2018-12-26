Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07526C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF272218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545852004;
	bh=9DGizY03IcncnCMsufbDf3Swt7qXpr8Sj/jyYHzJ8fk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Os3vSi13ESXKZOUGl6YfG2OR4PrVoEmP6OKCSrViRiiRI8DbBPtjV74iGl7/ApfHU
	 EbE07uxyUlgmyvV1Er7VIyxrssFn+Gf3QpPrFCrWZ06QHGDIU/H0B7ka7y2+0H3V8R
	 vUv5V+yUE4SU9iC203wCpa6dbLlS4TfP7yrfLY2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeLZTUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbeLZTUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:20:03 -0500
Subject: Re: [GIT PULL] arch/microblaze patches for 5.0-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545852002;
        bh=9DGizY03IcncnCMsufbDf3Swt7qXpr8Sj/jyYHzJ8fk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qlia4Mb6viC7VDhbznEGdFmDtgTxNwEXRGk8IprlrCt1Pox/VEy4Vb+mX5L59uxDF
         9/ZrQ6L3mU8T8BHndgiRcOP3NazXoE1SZateXmbL3jjv5zYwH+UOR4HdX4nyjocIBs
         3ik3fGiBIaTDCMc/8Kw3R7pPla6sUNOj9ND3DTUQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878c9d07-cc61-5599-3b99-8c29ae59a3df@xilinx.com>
References: <878c9d07-cc61-5599-3b99-8c29ae59a3df@xilinx.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878c9d07-cc61-5599-3b99-8c29ae59a3df@xilinx.com>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git
 tags/microblaze-v5.0-rc1
X-PR-Tracked-Commit-Id: 19d111ccce9f4c3e0820585d991bf5ae9172cbe3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30807ef2b76e01ea209fcad66a87e534ed1edb40
Message-Id: <20181226192002.20075.13443.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 19:20:02 +0000
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 11:13:09 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30807ef2b76e01ea209fcad66a87e534ed1edb40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
