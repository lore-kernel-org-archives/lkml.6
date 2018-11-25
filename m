Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A897C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E64E2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E64E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeKZEgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 23:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeKZEgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 23:36:36 -0500
Subject: Re: [GIT PULL] XArray updates
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3858620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181124173209.GZ3065@bombadil.infradead.org>
References: <20181124173209.GZ3065@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181124173209.GZ3065@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/linux-dax.git xarray
X-PR-Tracked-Commit-Id: fffc9a260e38acec3187515738122a3ecb24ac90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2125dac22f2c9c66c412cd8e049a7305af59f73
Message-Id: <20181125174502.9594.98807.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 25 Nov 2018 17:45:02 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Nov 2018 09:32:09 -0800:

> git://git.infradead.org/users/willy/linux-dax.git xarray

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2125dac22f2c9c66c412cd8e049a7305af59f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
