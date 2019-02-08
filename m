Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE0EC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2128C207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655113;
	bh=oZMPvd2dUru5qKccL+k0azlrRLglTL9kVeO2DoI9zZ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nuVgTqShZNcPIp2siCKXRr+1AFQ5DVyEyTGLeRQpDYpVpnRHiGrGvFrF5zzB4BC/K
	 xlV+ruQzrdroqAhx8IRKOKrkHOH2ysfAPJkGDrgmjSs56U8PBWODVNOPzGaXJ2Ddp8
	 sMRfbWDXrVzSAMciKKsxzvupOYg840rWxaQNiDjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfBHTpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfBHTpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:06 -0500
Subject: Re: [GIT PULL] Driver core fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655105;
        bh=oZMPvd2dUru5qKccL+k0azlrRLglTL9kVeO2DoI9zZ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WPX2drM4CWnYSSLsYfOKJsZjYjCn165WQRcKsfPJYcxxUcQPD1hFs1OxUuueSor1c
         Tfipw/m2aUI8EXXlw6YCMzgD3HXCeZpbN05N6F7gvqHwEHh/KH327Z5+s2C5NuXE9V
         ywDEhO6f15PNpOF2vm2M1CkUdJUIaMZA3QtNRugA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208083904.GA27008@kroah.com>
References: <20190208083904.GA27008@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208083904.GA27008@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.0-rc6
X-PR-Tracked-Commit-Id: 36991ca68db9dd43bac7f3519f080ee3939263ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c8e62cc983938a554d39497b5600b842f8a7965
Message-Id: <154965510554.5511.10300336532155378090.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Feb 2019 19:45:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 09:39:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c8e62cc983938a554d39497b5600b842f8a7965

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
