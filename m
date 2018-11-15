Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7E9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E992146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E992146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbeKOX6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:58:17 -0500
Received: from ms.tdt.de ([195.243.126.94]:34325 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729010AbeKOX6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:58:17 -0500
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 457F220186;
        Thu, 15 Nov 2018 13:50:20 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v3 0/2] hwmon: Add device tree support for adcxx
Date:   Thu, 15 Nov 2018 14:50:11 +0100
Message-Id: <20181115135013.30723-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v2:
- Use regular voltag binding

Changes v3:
--nothing--

No progress or feed back so try to get this upstream again.

Florian Eckert (2):
  hwmon: (adcxx) add devictree bindings documentation
  hwmon: (adcxx) Add device tree support

 Documentation/devicetree/bindings/hwmon/adcxx.txt | 24 +++++++++
 drivers/hwmon/adcxx.c                             | 62 ++++++++++++++++++++---
 2 files changed, 79 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adcxx.txt

-- 
2.11.0

