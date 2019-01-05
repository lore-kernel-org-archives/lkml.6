Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11075C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D300C222FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546719620;
	bh=M5uW0obrKqO+dzwMohMdcVbUvPZPon4CZ4HN9uKeZFU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bXxVSrEuC1LyysoCJTQcHM8/WaV6PkRzdlWa6ffvE5kcjfZegI6FmSnakgnFRDVU2
	 TAlCPkYTQDtiY04lDXyBOovl2RckzNQzJgx4jH6oClOn4efkC9X5XGENsxAqByObRC
	 KO5LszvGUxUAeDWFUDnVTrTgyEDhycf/ji7YPCno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfAEUUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfAEUUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:20:18 -0500
Subject: Re: [GIT PULL] parisc architecture fix for kernel v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546719617;
        bh=M5uW0obrKqO+dzwMohMdcVbUvPZPon4CZ4HN9uKeZFU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kkkcl5qaA52GZ0HJopAIrXs/ymCSrphO6bXX9rKpap7Yuxg0xXaopA/LIkqK/NfKw
         PfDSZOpWjylz4HBk54651F6p4dKgx2gUqPveMTHdTyj3D85z0LgmAeZdJ25j0xe/jF
         xAa/2XrwLz0biXbfmQqpAeApmlECCr+A6f3L1i/o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190105104005.GA32301@ls3530.dellerweb.de>
References: <20190105104005.GA32301@ls3530.dellerweb.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190105104005.GA32301@ls3530.dellerweb.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-4.21-2
X-PR-Tracked-Commit-Id: dfbaecb2b707cfdc5276b548d52b437384bd6483
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd08f68c659f42f9ec23b25b9cefd1ef49dc78b5
Message-Id: <20190105202017.12651.87323.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 20:20:17 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Jan 2019 11:40:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.21-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd08f68c659f42f9ec23b25b9cefd1ef49dc78b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
