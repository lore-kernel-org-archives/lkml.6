Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C4C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA1C20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544207722;
	bh=euHgTufRxwCoon3ZrPxGnXNjkpg1g4vHReVj76uZttI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Tas3N5VTYIO/tqJCJvBRlq0+vcR49BW4/TjVAMuL7/qvBHu4fp/8hOvG3b3Bq4mT2
	 x4/rQIr3L2OJf68thmy1Ee4lsEtcCPIihD5ZO5JYBgCzyz706v7Cjva45qetbvMSw7
	 8Eo/y8LxUYVJ1b8S8Z4D38WEzL9XgzqLaRlbZI0I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA1C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeLGSfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbeLGSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:35:02 -0500
Subject: Re: [GIT PULL]: dmaengine fixes for v4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544207701;
        bh=euHgTufRxwCoon3ZrPxGnXNjkpg1g4vHReVj76uZttI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l6wOtA1XYwhOEzEV6LHbr+THzSmgTIUSaXrQBxOodiTgP2guwjNgpGWc5aZiYUZ1A
         IfZeo3nXpLJ2dm5rghTHOCzg4XMoRcl+hpQXqkXe0asbwDwiOmJe+LeV958qyZVgwr
         /OV6SZ8RtuzVRxCEqjy5NMUbEnFzisANsv7b/rIQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181207044304.GB2847@vkoul-mobl>
References: <20181207044304.GB2847@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181207044304.GB2847@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-4.20-rc6
X-PR-Tracked-Commit-Id: ffe843b18211301ad25893eba09f402c19d12304
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c431b42058ecad834d87fea002604dc38feccfd2
Message-Id: <20181207183501.15805.52608.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 07 Dec 2018 18:35:01 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Dec 2018 10:13:04 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c431b42058ecad834d87fea002604dc38feccfd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
