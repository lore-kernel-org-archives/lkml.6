Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE6C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B401320892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544034012;
	bh=BIi1hZ66zkvyDapsBOnmj0Wu0Y+lx7A9nfovLhZgTDU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QuJx7nXxlWhOYIAig1atVev0U4p8fTVPJ6lEraeKi2PUN8ReNHmbpcFuwnG0xhwXH
	 WAM7k5XD4x6LMH8l0v50Qhq81Jcz9dQb1lMArlsZt3W0m8QmVt/2DykTpydU9LyzEo
	 7IvzErA816O7Bp/l4K6b9N6SrzctJuF4EdbDxJIw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B401320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeLESUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbeLESUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:20:03 -0500
Subject: Re: [GIT PULL] MFD fixes for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544034003;
        bh=BIi1hZ66zkvyDapsBOnmj0Wu0Y+lx7A9nfovLhZgTDU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mF8fK+KEhdiVp4eKz+vvL0Js7pj/B1Mggo/iH7all6n8C4OsINEuZzTQ5Fa2TErjk
         qHU5zn/LQsPI75JlhVjUU9kz8OgQ6iOIebKkMQOghIeMd4/M2acxUnf+AUbfPTGijL
         P3QG898YsbFS8VBw5YELBD8wN+I/Ssz7abaoEdpM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181205100856.GC26661@dell>
References: <20181205100856.GC26661@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181205100856.GC26661@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-4.20
X-PR-Tracked-Commit-Id: 48a2ca0ee3994df53da230c7079a18a70ec914f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e0dc1a7ce1f322c06e993845def2c73cfc485fd
Message-Id: <20181205182003.5826.28704.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 05 Dec 2018 18:20:03 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Dec 2018 10:08:56 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-4.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e0dc1a7ce1f322c06e993845def2c73cfc485fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
