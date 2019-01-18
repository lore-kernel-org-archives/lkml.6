Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB6AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3582087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547787904;
	bh=006OUrKTevYCX2185pTGlu3dz0nUnugdRFFdiOwcO3Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xquBVcHdLl77fRVJnUB+QgjZfYJxgjg0ZwpgToXtym3QgUEo+eAbApbqVrN8pK9ar
	 q8EFZNtAWLbY3j7KAfC+ij+SQeDL4t5Lj2h3L6O0wY0Y38X8JusdnH6bd2pKtsi2ue
	 JeO/k739SthszwtRaeisx2ZlyQFEHMREl29mzIzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfARFFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfARFFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:05:02 -0500
Subject: Re: [GIT PULL] hwmon fixes for hwmon-for-v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547787902;
        bh=006OUrKTevYCX2185pTGlu3dz0nUnugdRFFdiOwcO3Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I4SBL39K2qU92xAntkgeWBenGxfCXV/98KSwTeAWcQxRSxR/SVtsNEw8ziTo7Dmwa
         MzeuQiMh0cfP+trHJ8p7Ix0B+WqnvBvvcylfo2Ck1hQqDXghF1LZf4zpcnGlTV8c13
         PhEUrlG5ALWidpipg95ov/+pv0VZgrqixUxGCbuY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1547758610-27138-1-git-send-email-linux@roeck-us.net>
References: <1547758610-27138-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1547758610-27138-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.0-rc3
X-PR-Tracked-Commit-Id: f422449b58548a41e98fc97b259a283718e527db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a2fbed84a962c486a71d2c91c86a31332dcbf02
Message-Id: <154778790197.10702.16097371652738285782.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 05:05:01 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Jan 2019 12:56:50 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a2fbed84a962c486a71d2c91c86a31332dcbf02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
