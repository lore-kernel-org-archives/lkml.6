Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1283C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722B52086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="Y6lgjdG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfASMIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:08:16 -0500
Received: from www.linux-watchdog.org ([185.87.125.42]:59548 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfASMIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 07:08:15 -0500
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 007B2407DA; Sat, 19 Jan 2019 12:40:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 007B2407DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1547898008;
        bh=U9shrOMEjJW+FUZqB9QlVGVp5gP3ABviHcUzETNUfd4=;
        h=Date:From:To:Cc:Subject:From;
        b=Y6lgjdG1paELuc7WT8EoY+ETRtcQs69Lk06psLVsnf5iuASY9dObZXyptvFmgOwyk
         WRqmEpCPqTQGom5YxlxCwKYNfPRAxaOY2ynGPLtC3gLsSVjmQzYpcsnjWQTrOiV1Yy
         N3CJLxYx7oJMnW6m/fQI839D7Ismn3msLm6iHI2s=
Date:   Sat, 19 Jan 2019 12:40:07 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        NeilBrown <neil@brown.name>
Subject: [GIT PULL REQUEST] watchdog - v5.0-rc Fixes
Message-ID: <20190119114007.GA22111@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v4.21 release cycle.

This series contains:
* mt7621_wdt/rt2880_wdt: Fix compilation problem
* tqmx86: Fix a couple IS_ERR() vs NULL bugs

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 3bd6e94bec122a951d462c239b47954cf5f36e33:

  arch: restore generic-y += shmparam.h for some architectures (2019-01-06 18:16:11 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.0-rc-fixes

for you to fetch changes up to 4a22fc534f2f55808c41197cf17d829099032acb:

  watchdog: tqmx86: Fix a couple IS_ERR() vs NULL bugs (2019-01-07 10:10:35 +0100)

----------------------------------------------------------------
linux-watchdog 5.0-rc-fixes tag

----------------------------------------------------------------
Dan Carpenter (1):
      watchdog: tqmx86: Fix a couple IS_ERR() vs NULL bugs

NeilBrown (1):
      watchdog: mt7621_wdt/rt2880_wdt: Fix compilation problem

 drivers/watchdog/mt7621_wdt.c | 1 +
 drivers/watchdog/rt2880_wdt.c | 1 +
 drivers/watchdog/tqmx86_wdt.c | 8 ++++----
 3 files changed, 6 insertions(+), 4 deletions(-)
----------------------------------------------------------------

Kind regards,
Wim.

