Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B9C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE9C20883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547937306;
	bh=HmKRbI7EgL4QO1tSmXDwZjLM/wvC/NJ/Yqxa/2V2dDA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TBnwH7t3mSNh3H3G6VzmZxJk/YnjJx3Ikui2tJ/PSg5x2QYM61TGeEAIFcRZa9GJu
	 je+EoYtR2FFMKVOoNWUR6qnxMZ/00c7NklOpkYj4NsD1n+Z/MQtbWn5H6XkdbFfRs8
	 q41uQ+G/Ttxp6sGxVcFVC1a4FXqhzWPV0SNnk1BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfASWfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbfASWfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:35:02 -0500
Subject: Re: [GIT PULL] Devicetree fix for 5.0-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547937302;
        bh=HmKRbI7EgL4QO1tSmXDwZjLM/wvC/NJ/Yqxa/2V2dDA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IDGJuIiuuKsBaljShpmxf6iYQnmqiDn8mpZtpV2vIwsNFvoFYk8ySTcOXc3WHlDzr
         AGetgdIfsSMPUoDbsek03KiXL+x0lwCbcCyAcCyW/Axf++kcstuAzI0Dn5njey8HYr
         rOUiRcg6CpAPK8jaLPhsQj46xA4x8Cb1BWIvukUc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqKbma-kw0hrdBa2e7CLzSBsEy7dJZwvj+BrLjqzhuCPQA@mail.gmail.com>
References: <CAL_JsqKbma-kw0hrdBa2e7CLzSBsEy7dJZwvj+BrLjqzhuCPQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqKbma-kw0hrdBa2e7CLzSBsEy7dJZwvj+BrLjqzhuCPQA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.0-2
X-PR-Tracked-Commit-Id: 75a080cde08d2dcba19ee864f9732094d93fab41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a0141a0966cfbd765bff065c3eb61b09a92318e
Message-Id: <154793730204.16838.2158961933177037543.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Jan 2019 22:35:02 +0000
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Jan 2019 10:43:42 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a0141a0966cfbd765bff065c3eb61b09a92318e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
