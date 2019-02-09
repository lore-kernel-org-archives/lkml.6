Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30001C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15BB21971
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549745117;
	bh=JSe/agq248wTbpv5XFgEgHqLzAR/bsAvDfcU9oXtkN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VrJ3cp1FtYkAO0BV/22aoicRyNi+cwjMWB3nB8Ls0dTAMyL84LlHCJGpZ20SsMFE/
	 3l+WbGyUSnO4q4IHlVhnMyxQ3qnhF6Xc3My2jZQMUDDHGa9zEWIwqLTnN7laJVrqbb
	 ItFHQYzcBT8a6Fy/iQrnl0E66O0SZzNJ1RV5DdbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBIUpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfBIUpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:45:06 -0500
Subject: Re: [GIT PULL] MIPS fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549745105;
        bh=JSe/agq248wTbpv5XFgEgHqLzAR/bsAvDfcU9oXtkN0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uKVqHAsCCIBAHQqGaIA4H6u3m2t7sE2LddUFkpMJmUOILt4f3lzbywy61NY4oiecH
         Qubj2QTGW6V1GR6gdd2NtY3bO39in0Z1mLKZFjYtqaDazdqM7T17yAl6irx19YcV6h
         njfUItFh4znWOJTxqUoBHXtbaCb1PC6CdpuU9UvY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190209194236.lbdhzionhq6qxc5d@pburton-laptop>
References: <20190209194236.lbdhzionhq6qxc5d@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190209194236.lbdhzionhq6qxc5d@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.0_3
X-PR-Tracked-Commit-Id: 05dc6001af0630e200ad5ea08707187fe5537e6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8b50608f666cf5c314a9df3dc4b85789a6aeaa5
Message-Id: <154974510560.20101.7593828077886556712.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 20:45:05 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Feb 2019 19:42:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.0_3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8b50608f666cf5c314a9df3dc4b85789a6aeaa5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
