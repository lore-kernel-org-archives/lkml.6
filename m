Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18936C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1E32190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550250623;
	bh=P8xRYMP+8Fei8bV/Wl8ot35giYQgcocEVAFX4I5l4B4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FneiwH/sX5J2Dj1yAHpYXiQhsN+971Gm+ouyHy2NWLd2RM0p6Sx5ZBIPlDDekt1NH
	 wbpnw+9z8Lep9BwRnqmeawW15ZJ4cB0CuFwDYg4lavs1Tu5LxBxptvz5QnraJvYoab
	 ebYRGMzn4UEwkxGrUsGSKeWCBJWDTn0ilDBBy7FY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfBORKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfBORKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:10:03 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550250603;
        bh=P8xRYMP+8Fei8bV/Wl8ot35giYQgcocEVAFX4I5l4B4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WYVBKAG/QJ40pVZfK/SIfkPm31eImsZeyihPu26WRIYoi6d3ShKv5D/mudXrWURrf
         UennuAUGqTTMgSBP1HYe+ntVuNkF2v4EZtmCF5JuKph0VCFHLRJO57Xcy2gBSEkabR
         OyjnlUvyONWA8zqTV5Bd0j6E8evoJOWqiYfhcIek=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190214.180059.144820443701078080.davem@davemloft.net>
References: <20190214.180059.144820443701078080.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190214.180059.144820443701078080.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 refs/heads/master
X-PR-Tracked-Commit-Id: f9bcc9f3ee4fbbe8f11dfec76745476f5780517e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e7bd3b5494620265d39463b9289b7ba872f6df1
Message-Id: <155025060334.11780.14810105093180182311.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Feb 2019 17:10:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Feb 2019 18:00:59 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e7bd3b5494620265d39463b9289b7ba872f6df1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
