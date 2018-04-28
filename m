Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933011AbeD1Auc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:50:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39133 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754447AbeD1Aua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:50:30 -0400
X-Google-Smtp-Source: AB8JxZoreGjbV6cDRIixW7ej1XWvYwfHv8xAzk8r/pRuBwGfaHveHtKOBzTpK55xyTS1+QCHmV8L2g==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] MAINTAINERS: add keyword for devicetree overlay notifiers
Date: Fri, 27 Apr 2018 17:50:19 -0700
Message-Id: <1524876619-26283-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

From: Frank Rowand <frowand.list@gmail.com>

Devicetree overlay notifiers have a chance to potentially get
pointers into the overlay unflattened devicetree and overlay FDT.
The only protection against these pointers being accessed after
the underlying data has been released by kfree() is by source
code review of patches.  Add a keyword line to the devicetree
overlay maintainers entry to try to catch overlay notifier
related patches.

The keyword line is added to the devicetree overlay entry instead
of the devicetree entry so that not all maintainers will receive
the additional review traffic.  Add Frank Rowand (already a
maintainer in the devicetree entry) so that he will receive
the additional review traffic.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92be777d060a..aca3956694f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10422,12 +10422,14 @@ F:	drivers/infiniband/ulp/opa_vnic
 
 OPEN FIRMWARE AND DEVICE TREE OVERLAYS
 M:	Pantelis Antoniou <pantelis.antoniou@konsulko.com>
+M:	Frank Rowand <frowand.list@gmail.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/dynamic-resolution-notes.txt
 F:	Documentation/devicetree/overlay-notes.txt
 F:	drivers/of/overlay.c
 F:	drivers/of/resolver.c
+K:	of_overlay_notifier_
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh+dt@kernel.org>
-- 
Frank Rowand <frank.rowand@sony.com>
