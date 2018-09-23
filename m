Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEC0C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0CF206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0CF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeIXDJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:09:36 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:38736
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbeIXDJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:09:36 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 4BdMgohj5sezk4BdMgk94Y; Sun, 23 Sep 2018 14:09:41 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1g4BdM-0007G3-JX; Sun, 23 Sep 2018 14:09:40 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/4] Drivers: hv: Miscellaneous fixes 
Date:   Sun, 23 Sep 2018 21:09:38 +0000
Message-Id: <20180923210938.27859-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAvPCc8JOVw0YUgEJWCUfUTlYKfwDrfswtHKAXsbxBR3gJU8vvCCc701X4Xg0S4Pu5XxqQ05IdC/U0KSChSlmBgigZ2Os3xuKqliJ7TGevmk1Sl8oF/7
 JgDQGSyyzY9extZobCOP+XSuMQ65x5Qi4nPYToeAxYDjAx/0wo1OWC/7EWGGPsvfzb9yZiAhPMtrM+ja3YXLQO+5LCvB+D+F22AfABTJikKlszdW/p+nKTDb
 g3/Z45s0ute/hKBd6CFXG4FHbbsnoSUcgG55N3b5aCw5inY23BSrG7jj1m/jytcbRRNzrFi2RRx/B2Mnrj17dKmnFCWZuzbULwxve+yZ0bJtVcDvzcJFw+Tw
 VYRDtq1bf91Jc0GKQX9Nr3DNDz93IBwHoM9kDIDHT4Mcsei31+UVIlcmypESLV40W8XcHbNJ9U8nUqZ/xGbC7wbgKwRzqg0iD8btqcwH7PDtGvG+2mrMnJKf
 7LW4zWTwrEX2GiPFQJbFznnF8Ytv5WcHfBIaKu3hKd795RLnBapmNXvO+PIKgnLBS2vB1iPTsActyoWO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes.

Dexuan Cui (4):
  Drivers: hv: vmbus: Fix the descriptions of some function parameters
  Drivers: hv: kvp: Fix the indentation of some "break" statements
  Drivers: hv: kvp: Fix two "this statement may fall through" warnings
  Drivers: hv: vmbus: Use cpumask_var_t for on-stack cpu mask

 drivers/hv/channel.c      | 24 +++++++++++++-----------
 drivers/hv/channel_mgmt.c | 37 ++++++++++++++++++-------------------
 drivers/hv/hv_kvp.c       | 14 ++++++++------
 3 files changed, 39 insertions(+), 36 deletions(-)

-- 
2.18.0

