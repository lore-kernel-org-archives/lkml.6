Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030630AbeEYWIS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:08:18 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46294 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030505AbeEYWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:08:16 -0400
X-Google-Smtp-Source: AB8JxZpDua5DpLZLm3e3l5Tp5GXEcdIFr9y62VHu+S9mS8uv4HjETdzZX6ase0bvOgVfXq24weVbvw==
From: Douglas Anderson <dianders@chromium.org>
To: balbi@kernel.org
Cc: Manu Gautam <mgautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Remove DEBUG define from Qualcomm DWC3 glue driver
Date: Fri, 25 May 2018 15:07:48 -0700
Message-Id: <20180525220748.15117-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that a "#define DEBUG" was left in on the recent patch
landed for the Qualcomm DWC3 glue driver.  Let's remove it.

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/usb/dwc3/dwc3-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 8abb6f31389d..b0e67ab2f98c 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -3,7 +3,6 @@
  *
  * Inspired by dwc3-of-simple.c
  */
-#define DEBUG
 
 #include <linux/io.h>
 #include <linux/of.h>
-- 
2.17.0.921.gf22659ad46-goog
