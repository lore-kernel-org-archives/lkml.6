Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbeDLQCV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:02:21 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44453 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbeDLQB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:01:29 -0400
X-Google-Smtp-Source: AIpwx4/LxbsFesNRjBP93GUho51UbhvfuOpofhH3533mzCQn59TDAEMPlaewOfqQ97335Oo3g/EoBQ==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
X-Google-Original-From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: boris.ostrovsky@oracle.com, jgross@suse.com,
        iurii.konovalenko@globallogic.com,
        oleksandr.dmytryshyn@globallogic.com, konrad.wilk@oracle.com,
        tiwai@suse.de, andr2000@gmail.com
Subject: [PATCH 2/5] xen/sndif: Fix missed "reserved" fields in comments
Date: Thu, 12 Apr 2018 19:00:59 +0300
Message-Id: <20180412160102.15833-3-oleksandr_andrushchenko@epam.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the request descriptions have "reserved" fields
missed: fix this by adding corresponidng entries.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 include/xen/interface/io/sndif.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index fc1752cf5a16..b775df96f021 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
@@ -680,6 +680,8 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |                              length                               | 16
  * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
  * |                             reserved                              | 32
@@ -720,6 +722,8 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |                              length                               | 16
  * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
  * |                             reserved                              | 32
-- 
2.17.0
