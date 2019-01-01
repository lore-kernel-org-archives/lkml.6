Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88F9218A4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546378804;
	bh=NaSMwkTzAimuJ+VwIEQRsl2b5Xm0zT4CpiI2HNXUWd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yBMNCsh5eb5Xd5/omyLfQCN4AiYWbDXf3hYlWthg1/v079tYUUbpoeJT2TboRITFB
	 cjmF9CNZ19eK+He3Kp94kNmACoN5ynMJvgLlMsxo1INDBESkb9Kt66rRJeSbIhHYvQ
	 QC7v3B+n4w+TQ/tMsU1KjIJ0CC7cN04gmohx5UW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfAAVkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfAAVkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:40:02 -0500
Subject: Re: [GIT PULL REQUEST] watchdog - v4.21 Merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546378802;
        bh=NaSMwkTzAimuJ+VwIEQRsl2b5Xm0zT4CpiI2HNXUWd4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rBUZ6qiGzIXSxLZoAnTtwOYWmmBt5gLRTTfORTYLWEpznmqypL+OMRNrXsLav57A/
         12SxmdtT+fK4+B8wnLSI0ms6wBl7HLie00XhpqoWnDoCtVk0rYe991v68v0A5BmVq7
         nvuw/xcSZBmi7AvjdyH/5wsQ19YovpobJUAjD+PE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181230112445.GA12489@www.linux-watchdog.org>
References: <20181230112445.GA12489@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181230112445.GA12489@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git
 tags/linux-watchdog-4.21-rc1
X-PR-Tracked-Commit-Id: e3c21e088f8936a004a3d9f2f4e14b3f2bdd6ea9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 115502a6f31d84d8172a71283aaea266302a8ad5
Message-Id: <20190101214002.29500.27049.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 01 Jan 2019 21:40:02 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Colin Ian King <colin.king@canonical.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Dec 2018 12:24:45 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/115502a6f31d84d8172a71283aaea266302a8ad5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
