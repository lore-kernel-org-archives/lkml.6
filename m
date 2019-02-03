Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF87C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F2F2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549216230;
	bh=fgr/W5c4HPxfjngBP/1hqBZ1SR0HtlokFZxrGrC1+p0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nCYPEmvUZIhI1ET0cdAAsYogvXQYN8yXAzA7rrd7jSi6mw04n+IMgwAfmK3gsGKSn
	 VE06g7/cLftYKCvc37P7p/hn00b+aQ0mJq4WRBJGN9r+hPWB84uDDIRRqaMq+o5Mg5
	 CAbs1PugNDXa3bC3yFgkoAMBqBAxYaPx9wE40qyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfBCRu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfBCRuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:50:05 -0500
Subject: Re: [GIT pull] cpu hotplug updates for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549216204;
        bh=fgr/W5c4HPxfjngBP/1hqBZ1SR0HtlokFZxrGrC1+p0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J1LgA4RhR1t+NJTsElANBnH0Hocfbs0/c0t0SKcxSjGQgiEAKHSphcSNd7QRSx6Nw
         Qx22ibxmiVS61OOep1dWSNdhtuVjv7Tq/mvYED8Jy9hl65coG5cUFPPb0Y2go5AP1g
         WlT/CGoYZuKGwGDDgFUVUq3MCUNG7XKgH8NsDlWY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154921049412.12839.5997726190802534205.tglx@nanos.tec.linutronix.de>
References: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
 <154921049412.12839.5997726190802534205.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154921049412.12839.5997726190802534205.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-urgent-for-linus
X-PR-Tracked-Commit-Id: b284909abad48b07d3071a9fc9b5692b3e64914b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc6810e36bd875f197fcd6c74ad01f48090ecc05
Message-Id: <154921620459.4136.5164971916056932996.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Feb 2019 17:50:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 03 Feb 2019 17:16:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc6810e36bd875f197fcd6c74ad01f48090ecc05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
