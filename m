Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CB8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EEA223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EEA223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441383AbeKXGPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeKXGPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:15:38 -0500
Subject: Re: [GIT PULL] Ceph fix for 4.20-rc4
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5308B214ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181123184919.10675-1-idryomov@gmail.com>
References: <20181123184919.10675-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181123184919.10675-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-4.20-rc4
X-PR-Tracked-Commit-Id: 7e241f647dc7087a0401418a187f3f5b527cc690
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c98a42618271210c60b79128b220107d35938d9
Message-Id: <20181123193001.17450.37717.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 23 Nov 2018 19:30:01 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Nov 2018 19:49:19 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c98a42618271210c60b79128b220107d35938d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
