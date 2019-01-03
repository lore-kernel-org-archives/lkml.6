Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5922BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275DE204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484737;
	bh=FSuN6BMEZ/TrV2jVBK39ueO2fTEUPTGTj/LcPFM1BvY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tup9U9X1WXRDgivhL7Lst1gtl8WJq8xYF7FEm6F4Et7OveKjbqAl2LtIdi8cBzCU6
	 Xd4MmoiTvL5LQ/iEc1hNvh26dGCbIRG4VPK5YhhU2tfROMWOoq81m0+myHuwPyh1Ty
	 y+dg8/luSNl7MAqabRV4y5sXLhF9j7DRt910GQi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfACDFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfACDFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:04 -0500
Subject: Re: [GIT PULL] Device properties framework fixes for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484703;
        bh=FSuN6BMEZ/TrV2jVBK39ueO2fTEUPTGTj/LcPFM1BvY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L61vHVnLvZROrhYKTs54RUxJcNF5vWu4TeZVtX13aGQiiYhv6P10K+vljpt0EpBRu
         JdhwGpzbMYHV+RWeR8mCC4+t1aAJdFCszCeF4KpHdAgmktKOkqyNSOptNy36ufJmku
         oLPILdejaf2WksPhfifX2WKdjxORKb8bjYYv4Hl8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h9Xj-gqYfkJFoEyVoFQKm1hBKboPtcvmPzE0OYTLu0sA@mail.gmail.com>
References: <CAJZ5v0h9Xj-gqYfkJFoEyVoFQKm1hBKboPtcvmPzE0OYTLu0sA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h9Xj-gqYfkJFoEyVoFQKm1hBKboPtcvmPzE0OYTLu0sA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-4.21-rc1-2
X-PR-Tracked-Commit-Id: f4747b9c68b8864cac32cddc45fdcfdfafb3397c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01766d27d265afe7e93a8aa033afae5635d5aba0
Message-Id: <20190103030503.10885.25071.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Jan 2019 11:33:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-4.21-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01766d27d265afe7e93a8aa033afae5635d5aba0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
