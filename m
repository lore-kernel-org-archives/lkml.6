Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4702BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E4E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936039AbeFMPVG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:21:06 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37391 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935971AbeFMPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:21:03 -0400
Received: from faui49man1 (faui49man1.informatik.uni-erlangen.de [131.188.42.189])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id AEE2858C4AE;
        Wed, 13 Jun 2018 17:13:51 +0200 (CEST)
Received: by faui49man1 (sSMTP sendmail emulation); Wed, 13 Jun 2018 17:13:51 +0200
From:   Jakob Albert <jakob.j.albert@fau.de>
To:     devel@linuxdriverproject.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenz Kaestle <lorenz.kaestle@fau.de>,
        linux-kernel@i4.cs.fau.de, Jakob Albert <jakob.j.albert@fau.de>
Subject: [PATCH v2 0/3] hwmon: (nct7904) Fix style issues
Date:   Wed, 13 Jun 2018 17:13:22 +0200
Message-Id: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches fixes style errors reported by checkpatch.pl. This
adapts the code to the coding style.

Changes since v1:
* Changed patch subjects and descriptions



Jakob Albert (3):
  hwmon: (nct7904) Fix SPACING errors
  hwmon: (nct7904) Fix CODE_INDENT error
  hwmon: (nct7904) Fix UNSPECIFIED_INT warning

 drivers/hwmon/nct7904.c | 68 ++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

-- 
2.7.4

