Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9234DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FF62084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544473212;
	bh=H0wtviDofOxWBtsMV92/xGSpY76vQfjFaCLF1InQ7g8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uaFS8RqdJevJZPXDf1IfpaAyZ8m9WYktEy3OGO0pWJ+5bxAS+xcJr7PPI3MAFaLR1
	 CUBfM9d/tDGVEDjB9Q2eOIV9L2EghQWRv37nV7yO/dnwk5QYDDurR+bax4vTpUkfJI
	 saFhgVvNAvbld14vgoGFxO7AN4JQ4IalF+MzRSzo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FF62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeLJUUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbeLJUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:20:02 -0500
Subject: Re: [GIT PULL] Backlight fixes for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544473202;
        bh=H0wtviDofOxWBtsMV92/xGSpY76vQfjFaCLF1InQ7g8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fKCvu8I93n4ak9rHuX512VxAKg8KTo8e7ZppJfU1zLOJo3hpKNYq4mGvj6Cwu0dF0
         taJPZyfLkuXowbl9fEufi8/liLPVGsurPkCkLGuc+gbgKI01THQ2p/sAlPYiZwHnyb
         D1mHdQSLn+NNPLhEjFyX6gJjWlV9r6w0zBOWWJCA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181210155143.GB4497@dell>
References: <20181210155143.GB4497@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181210155143.GB4497@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 tags/backlight-fixes-4.20
X-PR-Tracked-Commit-Id: d347d0c82a99b41efc2770fc01a04066903300df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bb40f0108857ddb93e7480a7f38c1a9ad432e1d
Message-Id: <20181210202001.26873.90026.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 10 Dec 2018 20:20:01 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Dec 2018 15:51:43 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-fixes-4.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bb40f0108857ddb93e7480a7f38c1a9ad432e1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
