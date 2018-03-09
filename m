Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeCIKo4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:44:56 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:39460 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeCIKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:44:54 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] of: Documentation: Fix forgotten reference to of_overlay_apply()
Date: Fri,  9 Mar 2018 11:44:46 +0100
Message-Id: <1520592288-7680-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
References: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 93a6039000b5acab ("of: Documentation: of_overlay_apply() replaced by of_overlay_fdt_apply()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/overlay-notes.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index 5175a24d387ec1a1..a4feb6dde8cd08e8 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -91,8 +91,8 @@ The API is quite easy to use.
 return value is an error or a cookie identifying this overlay.
 
 2. Call of_overlay_remove() to remove and cleanup the overlay changeset
-previously created via the call to of_overlay_apply(). Removal of an overlay
-changeset that is stacked by another will not be permitted.
+previously created via the call to of_overlay_fdt_apply(). Removal of an
+overlay changeset that is stacked by another will not be permitted.
 
 Finally, if you need to remove all overlays in one-go, just call
 of_overlay_remove_all() which will remove every single one in the correct
-- 
2.7.4
