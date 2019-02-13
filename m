Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89813C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57640222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550022005;
	bh=FB5k61Zte5ntsoN/7KjAMVBm2M1aDxcTd/fVJU4f2p4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=p/KLnvPL+xdf8E6oYKcgAN8uMTddaKLTgRWg0yEdZptmvl9TA/osFIweO0HdXR1zH
	 2ZGO72LGdzRXN7gxRW3T47+fT+71/pZ0aGfjaSsgX8fNQZM7H+qS8P3M87EraMqaRa
	 1Q0nBgyBNinN3KIa67w2mmRFkViLxRnBxQL9GYDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbfBMBkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfBMBkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:40:03 -0500
Subject: Re: [GIT PULL] hwmon fixes for hwmon-for-v5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550022002;
        bh=FB5k61Zte5ntsoN/7KjAMVBm2M1aDxcTd/fVJU4f2p4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AfdT1lXUZgNKTABPWuwTgSJ/oArcZde6KXvB3sIZ9tXEU6GLxaLkr0W5OyOGC34O8
         jLtrVHODD3aiXL5JAfl8ewEa4z50y10FdjIY02VHAWX66nOGmTBuITWAhlfEsj81vG
         yjOkcbQ/8zqSUPKMZBGBc/Nlk2D4OqQ56XQ6Azrg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1550008589-18228-1-git-send-email-linux@roeck-us.net>
References: <1550008589-18228-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1550008589-18228-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.0-rc7
X-PR-Tracked-Commit-Id: 2a2ec4aa0577ec0b7df2d1bde5c84ed39a8637cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 991b9eb4243b53e6dcaeda94e515d713ca7ddd2e
Message-Id: <155002200285.24766.18170098131434310929.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Feb 2019 01:40:02 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Feb 2019 13:56:29 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/991b9eb4243b53e6dcaeda94e515d713ca7ddd2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
