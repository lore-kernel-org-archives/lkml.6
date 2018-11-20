Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C42C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB7E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB7E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbeKUCy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeKUCy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:54:59 -0500
Subject: Re: [GIT PULL for v4.20-rc4] media fixes
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D11D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181120090344.6ba64433@coco.lan>
References: <20181120090344.6ba64433@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181120090344.6ba64433@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 tags/media/v4.20-3
X-PR-Tracked-Commit-Id: 4e26f692e2e2aa4d7d6ddb3c4d3dec17f45d6495
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06e68fed32826b44aa9ffcf282c14d3c58918a70
Message-Id: <20181120162502.9629.25421.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 20 Nov 2018 16:25:02 +0000
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Nov 2018 09:03:44 -0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.20-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06e68fed32826b44aa9ffcf282c14d3c58918a70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
