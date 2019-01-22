Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7744CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439ED2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548183306;
	bh=Nzl4Mb8MClaJVpxlNPMev72GOOZwbtMoBS/sOaadQlU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ESLUxxzRaethgSoKYG1NWcosPk4Z9Lfr7YEqq1mxZW9Ph77XXYkgoTXMUOYbPmHkf
	 LFPU3z6dH9UR/6UKc1MUMpySicpCizZ6BSlwRhcI1SfEl2N1al2uvLAp0XrWnpE/VF
	 FxMn9o58nFZgbktf4Bs7ZGAFbE4Y8FBjiqIsrOgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfAVSzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:55:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfAVSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:55:04 -0500
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548183303;
        bh=Nzl4Mb8MClaJVpxlNPMev72GOOZwbtMoBS/sOaadQlU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wYOI7rCyPgITUC/EFJpPatKjPgcAPdvub7dKsipWmfs67pFlx9RmWsegtYKYMtJ5L
         L/c5n6eM1ugczOE0WIeDFOcTlzPTRyUyN8zinNW8R3ZC2eoIIqsJaIzFRVHfruZCdA
         9yW4ZDAh2MWy4g3JF1223gdI9lStQGPgVFmZOiKU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1901221043400.6626@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901221043400.6626@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1901221043400.6626@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 1950f462916edc9581168ca8d5882a8101e8bbcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 787a3b4322763284a594a5dd3680508c0bfb20b0
Message-Id: <154818330363.17701.1796752936985330886.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Jan 2019 18:55:03 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Jan 2019 10:46:24 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/787a3b4322763284a594a5dd3680508c0bfb20b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
