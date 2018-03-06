Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeCFQRt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:17:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53006 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbeCFQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:17:47 -0500
X-Google-Smtp-Source: AG47ELtVPjV/kAZ/OAEflFO0UiCMwdUgsGtb9SaDYbKNCdgdi4bLaLb05I5NkmLXNz0T7o3+vSIctw==
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] meson-gx-socinfo: Add package id for S905H
Date: Tue,  6 Mar 2018 17:17:42 +0100
Message-Id: <1520353062-8919-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S905H can be found on the Wetek Hub and Play2 boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index ea091f1..60fa2de 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -41,6 +41,7 @@ static const struct meson_gx_package_id {
 	unsigned int pack_id;
 } soc_packages[] = {
 	{ "S905", 0x1f, 0 },
+	{ "S905H", 0x1f, 0x13 },
 	{ "S905M", 0x1f, 0x20 },
 	{ "S905D", 0x21, 0 },
 	{ "S905X", 0x21, 0x80 },
-- 
2.7.4
