Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2B2C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC51206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC51206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeI2EWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:22:41 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:45341 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbeI2EWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:22:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 08DB218223854;
        Fri, 28 Sep 2018 21:56:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brake84_76eeeb274f559
X-Filterd-Recvd-Size: 1715
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:56:57 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-watchdog@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'MEN Z069 WATCHDOG DRIVER'
Date:   Fri, 28 Sep 2018 14:56:55 -0700
Message-Id: <20180928215656.30272-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	9483	MEN Z069 WATCHDOG DRIVER
	9484	M:	Johannes Thumshirn <jth@kernel.org>
	9485	L:	linux-watchdog@vger.kernel.org
	9486	S:	Maintained
-->	9487	F:	drivers/watchdog/menz069_wdt.c

Commit that introduced this:

commit 81ceed41d0c2b2c9300de7bc30c1451680257f52
 Author: Johannes Thumshirn <jthumshirn@suse.de>
 Date:   Mon Jul 16 09:25:10 2018 +0200
 
     watchdog: add driver for the MEN 16z069 IP-Core
     
     Add a driver for the MEN 16z069 Watchdog and Reset Controller IP-Core.
     
     Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
     Reviewed-by: Michael Moese <mmoese@suse.de>
     Reviewed-by: Guenter Roeck <linux@roeck-us.net>
     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
     Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
 
  MAINTAINERS                   |   6 ++
  drivers/watchdog/Kconfig      |  10 +++
  drivers/watchdog/Makefile     |   1 +
  drivers/watchdog/menz69_wdt.c | 170 ++++++++++++++++++++++++++++++++++++++++++
  4 files changed, 187 insertions(+)

No commit with drivers/watchdog/menz069_wdt.c found

