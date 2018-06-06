Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AD6160290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFFPJW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:09:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbeFFPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:09:13 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v3 07/12] extcon: usbc-cros-ec: Make license text and module license match.
Date: Wed,  6 Jun 2018 17:08:55 +0200
Message-Id: <20180606150900.8342-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180606150900.8342-1-enric.balletbo@collabora.com>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
boiler plate does not match, go for boiler plate license.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/extcon/extcon-usbc-cros-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
index 6721ab01fe7d..a5b75a12cfc9 100644
--- a/drivers/extcon/extcon-usbc-cros-ec.c
+++ b/drivers/extcon/extcon-usbc-cros-ec.c
@@ -548,4 +548,4 @@ module_platform_driver(extcon_cros_ec_driver);
 
 MODULE_DESCRIPTION("ChromeOS Embedded Controller extcon driver");
 MODULE_AUTHOR("Benson Leung <bleung@chromium.org>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1
