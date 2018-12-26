Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91D6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949FE218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545855305;
	bh=DCp9X7JfJIgVXo+i3MsLIK/amggH7QTU4Hp3HlscqLk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sobh90IYssagHYCfvOXm3T30ilPPvdKdl9xRMR0ZI6ijcVHQIpJSF3GO7bnNV2xvw
	 djtLglGYZS3X9/9LBMXQKwJqSavrt13BhgYrBWMINZOQZgxnN8NoxzNomH9Q2DenPy
	 lLrooMidCb97RujXfOt50qOip0xGFcGtbgJFCnGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeLZUPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbeLZUPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:15:02 -0500
Subject: Re: [GIT PULL] xen: features and fixes for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545855302;
        bh=DCp9X7JfJIgVXo+i3MsLIK/amggH7QTU4Hp3HlscqLk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nL1joWPmoLSDqDch59GTxj4t2aXlhDdPFYXnTT6Xq7FSuoO13gtyncuV8nI6yrgM3
         /U7JrcXQbtotLjN69SiJOhk0WWKEp/tqfYFyHwDKRrc93Le9r4lVTjFbC9afk74F7f
         CidyeNUn7pwv32U+CHq+wWsWn/35m8gGevarIWQA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220182823.7803-1-jgross@suse.com>
References: <20181220182823.7803-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220182823.7803-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-4.21-rc1-tag
X-PR-Tracked-Commit-Id: 58f9d806d16a38ed3bae11e2ada83393436a4956
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 460023a5d1d2aa0f733b6708b2fae5ea9f9dfec0
Message-Id: <20181226201502.31976.93393.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 20:15:02 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 19:28:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.21-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/460023a5d1d2aa0f733b6708b2fae5ea9f9dfec0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
