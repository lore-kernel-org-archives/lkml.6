Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE77C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D9F20684
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D9F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeKKBO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:14:26 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:39331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKKBO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:14:26 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDv1A-1gBZYQ1cdY-00A2CN; Sat, 10 Nov 2018 16:28:46 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>
Subject: [PATCH 05/17] clocksource: bcm2835: Switch to SPDX identifier
Date:   Sat, 10 Nov 2018 16:28:39 +0100
Message-Id: <1541863719-7244-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:iI02+GZ3eW+q92+QuoeCB6JO3LqDfqoYpzIALtiYfN+iNkYCgoZ
 M3MrO49gU+ppOCkNm/isM79vhgVuJ7Uk7cf5ItLXbZFeFYr7IhRk/0FiWsyZbgvmbfD9HY7
 ZflIrhHx4XtF0hlURpidghcH2K+2eBO1DcD28bwQAH4mGJnBQehXLlRvsFRabmQCdi6Fsfu
 ZASvFodEALdxFt6A/xEQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nr17WLyrKfc=:fPZzOuh557PVFSF22//f9y
 oCa60P3R+L46mzxNZhMDVUlKX1V/ruJmWap/eLRJq2jfxm3dz6oB3d4UJ4N7xxI1GuCqJQF/E
 4RFylBMN2MX/m0q+DLPJnikwbYSWPlXG/uARhg5xcTygiSZL9jFE4G8uAgN/UWr+4d7VDq+Hm
 edGQ6rAUJac+AqB4TY3qo+WaaOaMMPo8jyT8hsjjZxGVO4Vlu0Uxv+mLYGJWqwEkOHsgOsgnp
 uAIUYc929d2DpEOXKkFX5ZAawoDwOwI51kOu0Bk5BNX2QohcCtP/qBN6fFTd60X0kdUcTld3f
 LHtpxGo2fbqI4XIDK1ynwfAIOeUJwFB4R7MX794eUWOPfvAPiBJyqa79VvmIgzn2L5GirMX4a
 WVm/AqAZ7St1SQ1c4N6UAB1T7NlkBkxnliytaAPEPmys0DzhMsQKIqFusnmP+aSBDdAcFE59x
 w9eQfaEvhZw0JV0haNMYfeJCPqCXb2admI1OVD7Q4PhsVXxjHG+d2nVagbZ2bLrWd9Ym1FF78
 +f2d6mxVGQtHuShSGxKj0fQSyjgwEJSv0jRaYldxMS31CWR09WRBkRsyhH6DHzSYunpk13h3i
 Kr95jUuU4C2E1AY8fbkWL7Cchx0/utZGaHVpO7okAkiQ4EzyebGTytKrRU0q7n0+e6I6+6EYp
 BlnnltpXZ82wxnilsJny5T46VAuwPVR5kwL8rtlqzXdB3MffLhEePvKEq11+kdxtxNcmPqN7z
 XZoslObEcddw5Q3E4i3x6HDO8ZuAvwRdhyATa1pSXC0q6iqxDo/EzpplLEaB+QztuPmVnWtle
 Z2S6opIkPpOWgm6VEA0043/bEyuCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management. Also drop the FSF address.

Cc: Simon Arlott <simon@arlott.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/clocksource/bcm2835_timer.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 60da253..2b196cb 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2012 Simon Arlott
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/bitops.h>
-- 
2.7.4

