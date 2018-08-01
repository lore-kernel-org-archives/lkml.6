Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464B4C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E7620894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E7620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=git.icu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbeHADO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:14:57 -0400
Received: from git.icu ([163.172.180.134]:34390 "EHLO scaleway.git.icu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbeHADO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:14:57 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2018 23:14:56 EDT
Received: from shawn-desktop.hsd1.wa.comcast.net (unknown [IPv6:2603:3023:903:9000:c90e:6b3c:7893:1d13])
        by scaleway.git.icu (Postfix) with ESMTPSA id 17323220038;
        Wed,  1 Aug 2018 01:21:52 +0000 (UTC)
From:   Shawn Landden <shawn@git.icu>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 3/3] net: WireGuard secure network tunnel
Date:   Tue, 31 Jul 2018 18:21:51 -0700
Message-Id: <20180801012151.4650-1-shawn@git.icu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731191102.2434-4-Jason@zx2c4.com>
References: <20180731191102.2434-4-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does ratelimiter_selftest still always fail on slow CPUs?
