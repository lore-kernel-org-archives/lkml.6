Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84492C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E52B20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547229622;
	bh=rrPiq4a+QPfjG6Ectb6uPYZcM0jPpyIcwAhE0QebPY4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CMihpA7LXQ7kp4tL7JVzCXdOnSpTFauOYrAnfNxEatwwAL2EvQDdlKTvLsTDOxtBm
	 68blpAw1vm0hSNECGcXeVNJLrs48Ix3iO7cyLSUtRnZ4iSAISTzkp6/zj62BLNB09t
	 QYrf5ryIKYQ/PONOPGTXslzneggo6I5bHj2MQp6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbfAKSAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733132AbfAKSAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:00:03 -0500
Subject: Re: [GIT PULL] Power management updates for v5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547229603;
        bh=rrPiq4a+QPfjG6Ectb6uPYZcM0jPpyIcwAhE0QebPY4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WCKEqpzb2jvZ0JKOMY3tjPzSnkLjtoeX+r9GC1WmROzDZxeSNLM8RIdMVyYZjJlpc
         arCVp1WXi5LElqyPHfRDiPl1BpKfN163EuGmKX7MUkKGFy5QUv8kHBUA4GLC7n+/dW
         YbCkp0JZ97hSgLQ2utq/J7bNPsYhbRIoPZhy0qaU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gs=38z8y67j8Y-qbAComzfyucouK0-T7YL1ajoTK3RhQ@mail.gmail.com>
References: <CAJZ5v0gs=38z8y67j8Y-qbAComzfyucouK0-T7YL1ajoTK3RhQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gs=38z8y67j8Y-qbAComzfyucouK0-T7YL1ajoTK3RhQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.0-rc2
X-PR-Tracked-Commit-Id: 343e60e52a3a093bb7baeca441789724fcac4bb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4f31fff32252da3791e9d901adb44f963a79153
Message-Id: <154722960308.6916.6463791352335874480.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 18:00:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jan 2019 11:21:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4f31fff32252da3791e9d901adb44f963a79153

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
