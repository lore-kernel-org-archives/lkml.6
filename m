Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC77C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1645E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1645E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeI2ESg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:18:36 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:59534 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbeI2ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:18:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A95A2100E86C4;
        Fri, 28 Sep 2018 21:52:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: milk59_53615848c7a08
X-Filterd-Recvd-Size: 1891
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:52:52 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'D-LINK DIR-685 TOUCHKEYS DRIVER'
Date:   Fri, 28 Sep 2018 14:52:51 -0700
Message-Id: <20180928215251.29213-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	4010	D-LINK DIR-685 TOUCHKEYS DRIVER
	4011	M:	Linus Walleij <linus.walleij@linaro.org>
	4012	L:	linux-input@vger.kernel.org
	4013	S:	Supported
-->	4014	F:	drivers/input/dlink-dir685-touchkeys.c

Commit that introduced this:

commit 131b3de7016b73fca1aba8ffb528217ac95b2505
 Author: Linus Walleij <linus.walleij@linaro.org>
 Date:   Mon Jun 5 14:48:44 2017 -0700
 
     Input: add D-Link DIR-685 touchkeys driver
     
     This adds support for the D-Link DIR-685 touchkeys found in the
     router with this name.
     
     The vendor code calles this a "touchpad" but we are registering
     it here under its real name.
     
     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
     Acked-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
 
  .../bindings/input/dlink,dir685-touchkeys.txt      |  21 +++
  MAINTAINERS                                        |   6 +
  drivers/input/keyboard/Kconfig                     |  11 ++
  drivers/input/keyboard/Makefile                    |   1 +
  drivers/input/keyboard/dlink-dir685-touchkeys.c    | 155 +++++++++++++++++++++
  5 files changed, 194 insertions(+)

No commit with drivers/input/dlink-dir685-touchkeys.c found

