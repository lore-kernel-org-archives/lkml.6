Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E43C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A55420892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A55420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeKKFVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 00:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbeKKFVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 00:21:06 -0500
Subject: Re: [git pull] drm fixes for 4.20-rc2
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65812208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzQBpaa7HcNvCHNxrPUDmF4o4orGy_kTJBA-8KBQO65Mw@mail.gmail.com>
References: <CAPM=9tzQBpaa7HcNvCHNxrPUDmF4o4orGy_kTJBA-8KBQO65Mw@mail.gmail.com>
Message-Id: <20181110193502.26034.53729.pr-tracker-bot-20ef6d06ef9a31a33516637a80521b9fc7f1f849@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 10 Nov 2018 19:35:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Nov 2018 04:43:57 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-11-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20ef6d06ef9a31a33516637a80521b9fc7f1f849

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
