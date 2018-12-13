Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7929DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C8020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735709;
	bh=F2iCT3bdI6nBeTTxS1sBN1QlS+iP+nh4GxxDjo71ZjI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fV9RB1OJmYgwiaRUxVa6hTKcVnKEO33qWOaYhbBiX2Q6LsVy8GnR77tRzADPXYrw4
	 6rDrIII139p+sBEIMKxXJJUPVlRliFKVOiV5O0BobLxtOd+6bfIhZAG8WSs0m+Q9eQ
	 e0PZFM1sgavho9fsKG3x/NJ1+W3sghcKl/a/frCI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C8020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeLMVPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbeLMVPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:15:03 -0500
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735703;
        bh=F2iCT3bdI6nBeTTxS1sBN1QlS+iP+nh4GxxDjo71ZjI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VFiH/ydsK+oXZDjSRrWiHXPXJ1KJ4z+wcl8z8OL3Bul0++RxG2rb0rRYbcIsd5jNu
         IcasiWRebKclBCwzM0Au2cVblvi1icYjH8YTktUJpW/3d8Nz4KCEN/WYIhmHP6exED
         gh4aB704gbhOOgt+uA13xsjrObB31HAwA21sTF4U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181213200146.GA15849@localhost.localdomain>
References: <20181213200146.GA15849@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181213200146.GA15849@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 fixes
X-PR-Tracked-Commit-Id: 99c47fcd4daa2b9a1348872ba49226dcdc58cb40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76a5cfb8e7c98ae0ea238910f97c17cb1f638918
Message-Id: <20181213211503.3163.99421.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 13 Dec 2018 21:15:03 +0000
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Dec 2018 12:01:49 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76a5cfb8e7c98ae0ea238910f97c17cb1f638918

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
