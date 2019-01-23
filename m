Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47FBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91894218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548275406;
	bh=wxpjSuqhJMJOfTsP4EWjtg2IcGIs0+e6t4HMHC4sFuY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1pWvsnEciDJAtrnkRIvQxtjCHTEGNM2CVKCZ66oP/2QSYHlcSEmSg5WQ/AaEcXiPj
	 Z4fIQCKHo/Mt+wlO2b5kacJ+555a6qpsrTS4tII9Qw6EdaRoRFVK/zUKTHLJmMMi8N
	 Nnh9KoxoBbfGmhkFTP4obeeHQTj5fmylihXaH1gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfAWUaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfAWUaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:30:04 -0500
Subject: Re: [GIT PULL] s390 patches for 5.0 #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548275404;
        bh=wxpjSuqhJMJOfTsP4EWjtg2IcGIs0+e6t4HMHC4sFuY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VPr+naYZWRpzTVgORF8oDCa9axuPeo5QgF21jIADWoxHuU9Nc9cMLd5ymfeW8MztT
         59LNQ+stdFzNHQBYMhI1WujzAP2MScFiK1V7x9O8xjctzGOFHLK9ie/Lne7vWe/nRd
         NJOkOzHj3n5uQFEESbvpDQbwxzx0C2tSYYApD1Kw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190123130147.079a7007@mschwideX1>
References: <20190123130147.079a7007@mschwideX1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190123130147.079a7007@mschwideX1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.0-2
X-PR-Tracked-Commit-Id: 60f1bf29c0b2519989927cae640cd1f50f59dc7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09c2fe608a2608f9c7de7928f96f0ebc6197e195
Message-Id: <154827540401.2661.13499491075347329054.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Jan 2019 20:30:04 +0000
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Jan 2019 13:01:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09c2fe608a2608f9c7de7928f96f0ebc6197e195

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
