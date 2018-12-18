Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B9AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76C22184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLRMEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:04:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51973 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeLRMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:04:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIC3qGJ2823748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 04:03:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIC3pra2823745;
        Tue, 18 Dec 2018 04:03:51 -0800
Date:   Tue, 18 Dec 2018 04:03:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-07daef8b41e0d9e7802a448f6766504e7641a234@git.kernel.org>
Cc:     john.stultz@linaro.org, tglx@linutronix.de, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, sboyd@kernel.org,
        mingo@kernel.org
Reply-To: sboyd@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, john.stultz@linaro.org, yuehaibing@huawei.com,
          tglx@linutronix.de
In-Reply-To: <20181209062225.4344-1-yuehaibing@huawei.com>
References: <20181209062225.4344-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] ntp: Remove duplicated include
Git-Commit-ID: 07daef8b41e0d9e7802a448f6766504e7641a234
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  07daef8b41e0d9e7802a448f6766504e7641a234
Gitweb:     https://git.kernel.org/tip/07daef8b41e0d9e7802a448f6766504e7641a234
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Sun, 9 Dec 2018 14:22:25 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Dec 2018 12:59:33 +0100

ntp: Remove duplicated include

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <john.stultz@linaro.org>
Cc: <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20181209062225.4344-1-yuehaibing@huawei.com

---
 kernel/time/ntp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index c5e0cba3b39c..bc3a3c37ec9c 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -17,7 +17,6 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
-#include <linux/math64.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
