Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F8320856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547750104;
	bh=Y39I2ksIAFwZ89d1yHuWmlvo3zTIqaG2+ZyavD0m8nY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tuyn6izzyFH5A6lSRhz7WQkNMox3w1TLGOvoz4it2uKXkQ1pUYzZAkwbkF+ajjTev
	 3wvqRA4NLRrpTi49GF5FW0CWogBmoqYyz6D+LxUpgVBXu0E/VzROcpqYyWvgKIWOqX
	 V4mSTyL5VAAZOupmZTMfpszAE9B7oIRYq00k8CV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfAQSfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfAQSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:35:02 -0500
Subject: Re: [GIT PULL] Devicetree fixes for 5.0-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547750102;
        bh=Y39I2ksIAFwZ89d1yHuWmlvo3zTIqaG2+ZyavD0m8nY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y91HcYWp5wMOlgFCn0YjSXmfdWXA+a6FjrNboLop/Sv9AFl1YOn+7mASdlBFzU+lH
         KilYNEY6Dsrn1bPMU37oJMw1BFgSoML5m0d1Cdw9Rcww5kue67/4eXzWmGc2ahCTMb
         /V32502QzALmIP2pai/TiSDdo1YHQ0t3AN1epzwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqLiE8-TCRSigXxaGonaJE=7j9Ywggniy9_QXR3qFSbojg@mail.gmail.com>
References: <CAL_JsqLiE8-TCRSigXxaGonaJE=7j9Ywggniy9_QXR3qFSbojg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqLiE8-TCRSigXxaGonaJE=7j9Ywggniy9_QXR3qFSbojg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.0
X-PR-Tracked-Commit-Id: 3705add0b783e0deeb6646ba0311bf214fe52b0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d471c4dfa19f4d6de063256370a5be411a1f3149
Message-Id: <154775010203.11520.10054394903386986474.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Jan 2019 18:35:02 +0000
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Jan 2019 08:26:36 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d471c4dfa19f4d6de063256370a5be411a1f3149

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
