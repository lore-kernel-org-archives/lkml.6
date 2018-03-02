Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164125AbeCBBx0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 20:53:26 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33772 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164073AbeCBBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 20:52:50 -0500
X-Google-Smtp-Source: AG47ELtq72X0YIERqpV/Q2B7zvu5AewL44qBjz4tFM88wUeFmSSL6CD7UAmwpXjuomGzJLjTerr1Aw==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com
Subject: [PATCH v5 2/4] of: Documentation: of_overlay_apply() replaced by of_overlay_fdt_apply()
Date: Thu,  1 Mar 2018 17:51:58 -0800
Message-Id: <1519955520-29975-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519955520-29975-1-git-send-email-frowand.list@gmail.com>
References: <1519955520-29975-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/devicetree/overlay-notes.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index c4aa0adf13ec..5175a24d387e 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -87,8 +87,8 @@ Overlay in-kernel API
 
 The API is quite easy to use.
 
-1. Call of_overlay_apply() to create and apply an overlay changeset. The return
-value is an error or a cookie identifying this overlay.
+1. Call of_overlay_fdt_apply() to create and apply an overlay changeset. The
+return value is an error or a cookie identifying this overlay.
 
 2. Call of_overlay_remove() to remove and cleanup the overlay changeset
 previously created via the call to of_overlay_apply(). Removal of an overlay
-- 
Frank Rowand <frank.rowand@sony.com>
