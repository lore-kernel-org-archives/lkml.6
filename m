Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103F5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EB7218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549046131;
	bh=6Lsc2BDkAtJexa75ozdgr19pkTyGhXbp8hDAplazpy0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IuipBp4wGQuR3lLCtU3m28OjkUecDSCqut6m4hmqP2CW9XQ28xLtJA+0+qACG4sR1
	 u/DJEz70R0fQldm/LN2hEz82toXqLOwi7k4KEyY2YAHKFVJ+4fa+b0VXMwK1GKagzu
	 IyimC+BWJiWI6ctJkk8bGv69VgfFrzSedAfrx68o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfBASfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfBASfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:35:04 -0500
Subject: Re: [GIT PULL] ACPI-related Kconfig fixes for v5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549046103;
        bh=6Lsc2BDkAtJexa75ozdgr19pkTyGhXbp8hDAplazpy0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kk6cWLrsnIXRcrd8KwdhL73fvibQ5NwxQSwjMT6IaNOt4m3vP99cOJ0GHHPGKD3lr
         5A/aFwtR/sXHR5u56xmrllIXjUH5U3fjc53WI7mPKiNrLl7jj4aTw3dQHhQIFXlFFZ
         TIPmzpm4hmcHmZaftA/ePalar/bC6OU+Ky9wSuk0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hCRCMfJS4nXKnLrGJpEf3Jp6tLwkAeqtTOFOFNk4ckjA@mail.gmail.com>
References: <CAJZ5v0hCRCMfJS4nXKnLrGJpEf3Jp6tLwkAeqtTOFOFNk4ckjA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hCRCMfJS4nXKnLrGJpEf3Jp6tLwkAeqtTOFOFNk4ckjA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.0-rc5
X-PR-Tracked-Commit-Id: b473406a06c49d39d6d653e9981b0bd70300485d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4771eec1d0f25c41b31073176c6ff8f9904e4eee
Message-Id: <154904610367.32661.11807690646417596914.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Feb 2019 18:35:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Feb 2019 11:38:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4771eec1d0f25c41b31073176c6ff8f9904e4eee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
