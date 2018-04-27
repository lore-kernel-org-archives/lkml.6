Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbeD0N5N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:57:13 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43012 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932666AbeD0N5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:57:11 -0400
X-Google-Smtp-Source: AB8JxZpjYuZyn7E9bqGF7l+kIwXS0GbuN327PNlhtD5kZ+GAvvqbvzL5WMdfeNh3QefX/98AsxmhRw==
From: Niklas Cassel <niklas.cassel@linaro.org>
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH] MAINTAINERS: Update pattern for qcom_scm
Date: Fri, 27 Apr 2018 15:55:41 +0200
Message-Id: <20180427135541.11961-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update pattern for qcom_scm, so that get_maintainer.pl will show the
correct maintainers + lists, not only for qcom_scm.c, but also for
the files: qcom_scm-32.c, qcom_scm-64.c, qcom_scm.h.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 834cd3b1d79d..da60870527e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1817,7 +1817,7 @@ F:	drivers/spi/spi-qup.c
 F:	drivers/tty/serial/msm_serial.c
 F:	drivers/*/pm8???-*
 F:	drivers/mfd/ssbi.c
-F:	drivers/firmware/qcom_scm.c
+F:	drivers/firmware/qcom_scm*
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
-- 
2.14.3
