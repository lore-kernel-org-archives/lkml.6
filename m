Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686DBC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C672086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C672086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbeKQCiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:38:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390212AbeKQCiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:38:04 -0500
Subject: Re: [PULL 0/2] Xtensa fixes for v4.20-rc3
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EAD2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181115214107.7376-1-jcmvbkbc@gmail.com>
References: <20181115214107.7376-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181115214107.7376-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20181115
X-PR-Tracked-Commit-Id: 40dc948f234b73497c3278875eb08a01d5854d3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50d25bdc64318a8a367c4433fa1e030c38331f05
Message-Id: <20181116162502.28259.60251.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 16 Nov 2018 16:25:02 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Nov 2018 13:41:07 -0800:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20181115

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50d25bdc64318a8a367c4433fa1e030c38331f05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
