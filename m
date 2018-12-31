Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A26C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8702D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546279504;
	bh=6Bu0HC8+rLnJS/sxzzDTIZ0MW+mIcQdHhppnb0rJL6Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FZmqA7snZo/OfyHeGSmbvMInqe++1HkAng9jc5e+ZNDmlBHo/7lsxP6HamDOwJ+/v
	 IHJnFVbyeKfF/qZYqodR3S/G99y4Nu9UfdRkOBBqdAMvEB3iK+JKPThh8nde0j3qwq
	 BDDSK1BXnHY6Nmgq1jnPB8HslsmM+roQP/cV9wKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeLaSFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeLaSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:05:02 -0500
Subject: Re: [GIT PULL] dax fix for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546279502;
        bh=6Bu0HC8+rLnJS/sxzzDTIZ0MW+mIcQdHhppnb0rJL6Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FUcs57lcNsRZ4yQTal5UbcAO13DVQGY1LIpEGY/WMuRWANWKTc015m1NFFeIbmxoJ
         MUXtuEjwrQI4PvtpvO4yLOmOzutRAUGm3XLyVLd3kXzquENo2hKUMiPim26fLE5WjY
         JDsHsB6Ge/y03MioJKy4P5Rver1rktuiEHMoR6IE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b7f5fe8af0fe10a9aeabf4b48a7cf8c126676c24.camel@intel.com>
References: <b7f5fe8af0fe10a9aeabf4b48a7cf8c126676c24.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b7f5fe8af0fe10a9aeabf4b48a7cf8c126676c24.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fix-4.21
X-PR-Tracked-Commit-Id: d8a706414af4827fc0b4b1c0c631c607351938b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a1a2c1a76cf89aaeb98a89179c2942c7882f68a
Message-Id: <20181231180502.27307.62490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 31 Dec 2018 18:05:02 +0000
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Dec 2018 19:52:56 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fix-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a1a2c1a76cf89aaeb98a89179c2942c7882f68a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
