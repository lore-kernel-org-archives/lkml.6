Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1798C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7893C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544473203;
	bh=ItiFZlxT5Vte88byrSe63KKRSakqwVBwpJFMSPR3KGg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=056kR0sA5RLCzpfExIhWm0a/OQbdyBJGXeuBTtfBsJbu7aXif+tgRrZRppKIgc/6d
	 HVYNpcScopq0zjQq5+ZUPoXZlk1WwIY7mhgTgZLyG9/6j02He1jJTOHANkIpSq6pa+
	 aIWQIzrvYH290s/v6eIfvgPw6JitKn+bq8jzxEwA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7893C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeLJUUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeLJUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:20:02 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544473201;
        bh=ItiFZlxT5Vte88byrSe63KKRSakqwVBwpJFMSPR3KGg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i8hwofYm/Wx0BJ4kauApACvyolpgKKrf1/g9591qKN4kt7sRLS8qe2Caz/yn7YYwd
         XuHuxFK/wAGildH2ILRjTYNr2yjtyuuyYa1OsDhS42SOm1O6EQkpnHBtK8moIw2RIo
         QzVqQ+3T2VveWllvNl+hM8NaHtaTENubKWcaVkAs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181210012335.jmxsw4yyj66lrbsp@localhost>
References: <20181210012335.jmxsw4yyj66lrbsp@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181210012335.jmxsw4yyj66lrbsp@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 0603a9a84679eb12d9dadb97f4e0ba017e684c7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dffab5e98969087039fefa8cde4699c7353b71e
Message-Id: <20181210202001.26873.73358.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 10 Dec 2018 20:20:01 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Dec 2018 17:23:35 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dffab5e98969087039fefa8cde4699c7353b71e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
