Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746C421473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548811507;
	bh=/PtK2qUzjVUlnAmRq7+3ws1jXoM42w+z2TYaJf8oUJQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FkP3GQLa549XnaxbyaeQBgzANSuPnwrY626+Sn/hqmOuoFyxhgSJzd1wurDV7DrLs
	 ODj/Po4FwfmBPNUNBpoBgljqBaLLMbxaKj+XvRmZd1C8WxRViWUeMrNqf/YMcpR6iI
	 B8jKupZ0l8qZldPnPTfva/6go011xV7jutbVIK2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfA3BZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfA3BZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:25:05 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548811505;
        bh=/PtK2qUzjVUlnAmRq7+3ws1jXoM42w+z2TYaJf8oUJQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NB6/8H/raKuJC2wR56I34eAvPbTb5epjPeusKOLm2ChMLZthCvbL5CoYXIecu5mER
         BH4GRCthfOMNM04mCkPl8AysTRLTpaOfVTCUSwihu8bxozJmSU9FkgZtsAsFnpPm/s
         utIzXpOB/qdDiAuf7oeb6OgVH48RKxi8ITQxBhgk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190129.125500.154282464274712566.davem@davemloft.net>
References: <20190129.125500.154282464274712566.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190129.125500.154282464274712566.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 master
X-PR-Tracked-Commit-Id: d07e1e0febe10b65eecd3205ad3bd1e999754887
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62967898789dc1f09a06e59fa85ae2c5ca4dc2da
Message-Id: <154881150504.1173.10044766642377383359.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jan 2019 01:25:05 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jan 2019 12:55:00 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62967898789dc1f09a06e59fa85ae2c5ca4dc2da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
