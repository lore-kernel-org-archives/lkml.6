Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D08C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E593F218A4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546307107;
	bh=VRY/GxmIK175Ds9hKojiZ/IB3jv0NBNzsd9O4PLeoNI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QUJ8bA48a9byJeqqDz0QjhvrG0kuKcoXWQK0NP5Tu8fTJcjhjwPEF0bq5sg4v6p6M
	 ISXjdfXmDCAiA3KkRSd3XsNWd2DKQTnTU2two/oS8XhfhwsrXafSi3620K/EM6Mw1p
	 fwiE7BPWiZ44/C24B1b1JzkvCl1CinBqa8vQBVOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfAABpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 20:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbfAABpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 20:45:05 -0500
Subject: Re: [GIT PULL 4/4] ARM: SoC defconfig updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546307105;
        bh=VRY/GxmIK175Ds9hKojiZ/IB3jv0NBNzsd9O4PLeoNI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q1cwEuhg+Yfb5FKXhlgGkLUrsdeb3o8xvEXvu/V4RwuQ1lGBx609BxgyAm3JQHcO+
         aVpxEvkd/jYpoBbvaAeCVz874t3ui7lT0ETS2TlMd/LQsUr/wiMuQugQHwjBS3djVM
         XgKTFbSUn2yI1U3NSHIZwRPFkrqWRK8w55w14Z0Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231214640.17015-5-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
 <20181231214640.17015-5-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231214640.17015-5-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-defconfig
X-PR-Tracked-Commit-Id: 82c7b351be3fad005ba38a26f7f1ab7f0841e505
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1ef035d272ef4dbfdda98e58699698305138856
Message-Id: <20190101014505.19922.69449.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 01 Jan 2019 01:45:05 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 13:46:40 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1ef035d272ef4dbfdda98e58699698305138856

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
