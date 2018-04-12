Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeDLQBa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:01:30 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42368 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:01:26 -0400
X-Google-Smtp-Source: AIpwx4+HdMnUbnw8Zi4GWPhfjEW4cyydzRlrnb/dWK7L1aoMHz9vQQhLM8AXGTE3n+HG0XPVcPfn+g==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
X-Google-Original-From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: boris.ostrovsky@oracle.com, jgross@suse.com,
        iurii.konovalenko@globallogic.com,
        oleksandr.dmytryshyn@globallogic.com, konrad.wilk@oracle.com,
        tiwai@suse.de, andr2000@gmail.com
Subject: [PATCH 1/5] xen/sndif: Introduce protocol version
Date: Thu, 12 Apr 2018 19:00:58 +0300
Message-Id: <20180412160102.15833-2-oleksandr_andrushchenko@epam.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protocol version was referenced in the protocol description,
but missed its definition. Fix this by adding a constant
for current protocol version.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 include/xen/interface/io/sndif.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index 5c918276835e..fc1752cf5a16 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
@@ -36,6 +36,13 @@
 #include "ring.h"
 #include "../grant_table.h"
 
+/*
+ ******************************************************************************
+ *                           Protocol version
+ ******************************************************************************
+ */
+#define XENSND_PROTOCOL_VERSION	1
+
 /*
  ******************************************************************************
  *                  Feature and Parameter Negotiation
-- 
2.17.0
