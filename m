Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeD1Bbd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 21:31:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40019 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932940AbeD1Bbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 21:31:31 -0400
X-Google-Smtp-Source: AB8JxZqRgs4m9pzs8o3oL8tgfvouexpONaiOkMgJiDFcw0XVj6Whj98QXo5PNL3gcduhnnhbgYu/VQ==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] MAINTAINERS: add keyword for devicetree overlay notifiers
Date: Fri, 27 Apr 2018 18:31:20 -0700
Message-Id: <1524879080-27111-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes from version 1:
   - removed extraneous "From:" tags at top of patch description


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
