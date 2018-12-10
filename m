Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8870E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544473204;
	bh=0LzsFTmA6SvgaBQJ+/UDdW36XFaqbB2GT/ubpPnsGsY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TZQ4ct2p7fieNW84Vw/HV62NILnJNeI93jdGivBGxeDmRRyazTzfmEiEtXVxPBzvP
	 02sDabBc0CD/BHBYaNWRScvjFgWR1nDC10Cg/qpAjRnDvA0lCdSpC6A+V/mJow3bjM
	 bWYFXju9nTa07lmj4MrTvU+Ka45HIUfmWm7xrvJ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8870E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeLJUUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbeLJUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:20:02 -0500
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544473202;
        bh=0LzsFTmA6SvgaBQJ+/UDdW36XFaqbB2GT/ubpPnsGsY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rSFxqybovmgUkvvSzQjKkf6El0IZS24DzwgcX4ZXi6+yEGBLjQH+2nqU8wpW/AYoN
         XsRKaoTV2iok8Js7xZ4vBhLPSFq/bgS6qZIOPFcMjaAazY1ImMLB8TH1HpSRAZsHHx
         UERpsUEzCqc0j/2XOovzPpTOekb1zdLeGBqc7ABc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1812101702120.17216@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1812101702120.17216@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1812101702120.17216@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: c201e3808e0e4be9b98d192802085a9f491bd80c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5d582777bcb1c7ff19a5a2343f66ea01de401c6
Message-Id: <20181210202002.26873.10072.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 10 Dec 2018 20:20:02 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Dec 2018 17:05:06 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5d582777bcb1c7ff19a5a2343f66ea01de401c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
