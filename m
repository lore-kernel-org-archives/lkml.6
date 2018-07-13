Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08989ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60230208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60230208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeGMN4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:56:22 -0400
Received: from mout.web.de ([212.227.17.12]:48019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbeGMN4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:56:21 -0400
Received: from lab-pc04.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LiUC0-1gBv6D1c8C-00cjXM; Fri, 13 Jul 2018 15:41:21 +0200
From:   =?UTF-8?q?Oliver=20H=C3=BCbers?= <oliver.huebers@web.de>
To:     gregkh@linuxfoundation.org
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Oliver=20H=C3=BCbers?= <oliver.huebers@web.de>,
        Vanessa Borgmann <nessa.x@web.de>
Subject: [PATCH 4/4] staging: mt7621: Add SPDX license identifier
Date:   Fri, 13 Jul 2018 15:41:06 +0200
Message-Id: <1531489266-20410-4-git-send-email-oliver.huebers@web.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
References: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T0xiyMwvTypK8xwxC0O/vMdZ3+/k45CLYibczE7yiRB+UlG9RHR
 fnkU6Fpi0YgoZ15yeK16PbURmcm4uP+V19Fs2UWyOmdDmrX00rcz0ay+HNH23iJaDe+l1Fy
 6JNUgOXLuV/uCFzcyPC+/iQVpuLYghELgLtU1zc2I5LWaVZD5wKInHV92fIXmsRw8RyK3TR
 h59Kxp0hko4o3SkC9WKJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hwIW//L9T4c=:+THBNGWd8SNP6CXPkCxwlm
 f2VnOpnOoxHHKLo1Xxw7mimcMWbMbdRwfWBRus8yd3JHiQ3Ma5spoqZ04ndb92sebaL7MC2iF
 fTIWCx8Fx6YBS+hchQmiFk+HGoOvZaupfP8M2kmZMGDZaficJN6gqw0GvSrkJUjNwVIMf2a6z
 VchBtkBPqV9y+tzEGk/Xr1rrAT9fR477bdCMEAEnIJ8R7SHWKQswgT8HP44UXW4kEWy8hzXcN
 xgXLFtYpAFXFWkad0spDG+PAXroBHzB9cjVW+UYCq50gE8O3blqKwWxeza3KpZpWOzhfwuaAr
 WP9Y9Zu2pgMyk4ItQNg7dX33Z4yRffSOUGzRIWPXPHaW+Df+pvm1UrAiwQVg/eKcZhyRllI6B
 O6C65ar3sJMLbNKBef6J2XHjfvb4+r5vKMvjBm8mX5FmnwAeUEEzPfjuN5Jy/OGjV7iWa6vdA
 /8R22nqpMRdxHmfz3OURs6Q2Be0/EaI5aiXH2gZ/Xyj7j/Op8YM6YiKB9lvlTG/2NnWisWNMy
 1IYmNOcRoPtkJXg41enmeaNYtAz7TIOZYVp6u+9SEKfej5Gzt5wWyye3pJhDk0eMusB8Uxs5i
 b2ArsHymi0+/3cC5uKyr5iODM28fNE+fBKiKuuuo+/3As1M95tPCqYQoyBD1OI3pKmOr4zjnp
 cDo5iCCJ04PCmNThSOS8HKXy0cj+Iz89S3wCcKBrO/MtYtx2E6VpPinDsoQpJjUOL9fqPXjFL
 L4nIXigNBJ7ReERpQ5np8f5JXlPgK6vDobxDlYjlaNW7R7yStTDbP6NyV+otvdLQH8jupjMCl
 7/nGY0b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oliver Hübers <oliver.huebers@web.de>
Signed-off-by: Vanessa Borgmann <nessa.x@web.de>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index c118d78..fbffa3e 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /**************************************************************************
  *
  *  BRIEF MODULE DESCRIPTION
-- 
2.7.4

