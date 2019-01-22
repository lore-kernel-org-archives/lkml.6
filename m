Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37791C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8A421721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548132007;
	bh=0MdyYNlrGqMzZ5+VQDCHMqYdpWVOtyDIouAZ/aNuKBU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PQbqIXo0nMxtwTIBPYub6fXFh+smqyc8vYXj1BNWMI69sauFsQZUFFgtQ2zSQds06
	 bRMsqf3buQVUstZcXjOBWx5FHcW/bS2W4w5Ru3tRVLH36aqI1PV21IfgsqC881neIo
	 BMDNvJZvJGL/ILrauqz6oYWB5wnsNRFH0C1rTRBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAVEkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfAVEkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:40:04 -0500
Subject: Re: [GIT PULL] XArray for 5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548132004;
        bh=0MdyYNlrGqMzZ5+VQDCHMqYdpWVOtyDIouAZ/aNuKBU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z0GOyDQ80j679PA4FHOpGKbW/mSYl5ESRdX9Hv1mecJ3lyC65WNVuLkk5Dy3QipVY
         0/HqCPjcY2xSzGuDKGaYeBJOiNDPdCLYlleXteWpCz5TsBs17oVi9ZORAPMc7FpSpD
         ccbi8ECGaS4tMeYzWvBUbJxA/Rtr0Dsy13wu/hE8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190122033135.GA18123@bombadil.infradead.org>
References: <20190122033135.GA18123@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190122033135.GA18123@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/linux-dax.git
 tags/xarray-5.0-rc3
X-PR-Tracked-Commit-Id: edcddd4c879af48ec922d680b2d56834c085683b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48b161983ae5266ffa42f0ccaf7224eaeda38e59
Message-Id: <154813200429.26009.5069525543307431081.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Jan 2019 04:40:04 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Jan 2019 19:31:35 -0800:

> git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48b161983ae5266ffa42f0ccaf7224eaeda38e59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
