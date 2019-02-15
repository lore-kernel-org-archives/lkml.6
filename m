Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795DD222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550250605;
	bh=iXMEOiAv1vU3KHQvNPAzMs1Dy+gWtacEYhND3tJYL/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V35qhL6Q2EwHrnCUkkP9rBUyouCtgyDIlooNdlLVjMJAAkyFQF90QyBPIIzwrNckU
	 +uDhehAbGKddmEXozeHcDNBkHjLqSfsdCu20THSr29U2pbbY0m4fWh3sgXIQ32Ybjv
	 W2Gj6iMyq9fLFZeHiqLbang6hBP+kMheAtool54c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfBORKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfBORKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:10:03 -0500
Subject: Re: [GIT PULL] signal fixes for v5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550250603;
        bh=iXMEOiAv1vU3KHQvNPAzMs1Dy+gWtacEYhND3tJYL/c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UtK2fCJtBwHjlQKe5Hf67S/PMAuWNO0ouEw4MJo5XAtBU9G2KM8x88Pf/up2dnW1Q
         cUDhpviKaKDX9QlDexe1IT/HxRymxjDNsvg2+zFG0tVGzhD0x5XO2x44Bw+gcj5MYH
         NuGuEEAMH95sykJs25qQ56YI4v70z1gZXzTbHKak=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pnru2io6.fsf@xmission.com>
References: <87pnru2io6.fsf@xmission.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pnru2io6.fsf@xmission.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: cf43a757fd49442bc38f76088b70c2299eed2c2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02d75040897f37e43cc6df9a7084ecdd20526f1a
Message-Id: <155025060309.11780.14710612938853392300.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Feb 2019 17:10:03 +0000
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Ivan Delalande <colona@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Feb 2019 14:56:25 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02d75040897f37e43cc6df9a7084ecdd20526f1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
