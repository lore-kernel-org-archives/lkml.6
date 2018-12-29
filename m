Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84839C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F2321905
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061708;
	bh=/LnxdOPE+v2jlKB1b4f4UWnqeOackra89EMNR3JCDkg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ivhHpDLxfE5Qys6k55S4ivvkBRxgYJQ4iEo0IXFWjrXZeODaK/ZOe4Yqy5agLY8rW
	 2f5fvNJTlUZX1yum0upai+tvgPIx+9IHvImERI2M5TlKT7cEoWAxZgRMxNvqwAyI3k
	 ySpCaO9DpFNrrwaDviuJbn1rmYhT6Z0YWi+6/bRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeL2FfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbeL2FfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:04 -0500
Subject: Re: [GIT PULL] kselftest update for Linux 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061704;
        bh=/LnxdOPE+v2jlKB1b4f4UWnqeOackra89EMNR3JCDkg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vc46dCPP9SPRzT0OJpBP4XJE4R2jzw3R/jbGqFrvqIzddjgvOhpmekaarEwWEu1R9
         AJlDkuCmIiSB0isgRmLEHVzO0ANjkCqI5VtJwUb/Xir1BpJXL2omB9lMzq7svwyfo4
         VzXxCj3oqT3xJxf1G8ly6v2q6QsFQRgoVVWyekdM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6d5aa143-4c9b-0bd9-4c14-8801f64ac40c@kernel.org>
References: <6d5aa143-4c9b-0bd9-4c14-8801f64ac40c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6d5aa143-4c9b-0bd9-4c14-8801f64ac40c@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-4.21-rc1
X-PR-Tracked-Commit-Id: 283ac6d5fb2a47f12bcef7806b78acf6ad89907e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 903b77c631673eeec9e9114e9524171cdf9a2646
Message-Id: <20181229053504.9301.21095.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:04 +0000
To:     shuah <shuah@kernel.org>
Cc:     torvalds@linux-foundation.org, shuah <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 09:45:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/903b77c631673eeec9e9114e9524171cdf9a2646

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
