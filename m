Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCHXla (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:41:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:59807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751377AbeCHXlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:41:22 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 8/8] Documentation: gpio: Move drivers-on-gpio.txt to driver-api
Date: Fri,  9 Mar 2018 00:40:24 +0100
Message-Id: <20180308234024.24145-9-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HjlXwKDUO2msKbcxssVu5DRynfVIMPY0D3hOxL40vQQNVGsdvPJ
 Dd8yCoT6e/cxTl9W9uV2q3tPDu5GStS4IK6cgnKYFaXEUq6xsBbsZlN8dJ7/sjsTmVYswuq
 A8X4V99LWXhr5WliC44p4GAJJpH68LSpU1dr6rHCA8aIznYtVQjARb/6rmRfUABknpUXCIb
 3jJu5Kl2kw8U4Y/aD0EvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5Rzzt/zS8bw=:QQ1kfg2+X8EnvHRHZOGF3U
 eGxyHZmGZ7T8PscQcelPqFrji/v2XAjU/wujM4ST9z+MPfjMA4uvyLpvoc1jlJfAmyOa7JM4H
 1TjzB71PQkGjqSSeW/gfqJD4Rl8qNNckZlCTjhQvSOMenzzYnp25PX8xqh4mPfD/sgNVjrCPL
 SiCVx58wZBwYgWMGjVHfLCU7Ol8SMtEouu0dsCwxXRnbWvHhi6IpZroiFE/bSP+3omRaveGM3
 p7qGKmvH5KtVAGYGZ5847woR8c2tYY5Bl2a5KTMPgLWDn9p+0+izwHEGJ+uCnh2QzLD4Hcn+M
 J097YqtZwYolIS9uYrGJjHP2NhM1ou4N0pvf5cvsRF2ZvD9HeIfj3V4OKmTmFoKFelEbRI1wM
 jWRFI7tXcV4QkyoEZd+mngdDR1rmECdTsgv+fSfAVYRoOJGzspQuV0UWNx+M6WtzS28yPTvl+
 hlMEe9gdPUFDlkfunxJNU92ZuW3i8TvPnXy/FsuWvjd67/Kc0ylQvXoVLPAtkNr1o5JwUmQpy
 YN1hLGqtEDptSzMwOzvgt+IqpEbvJuT/IiSPFMcNOBEwGxl1V79HOoeWMlq0Hw4a8iUb1x4O/
 FMI+4C0vxh4UbceXqoLO6xMGhEAuCvWjm8iUChLLvtk4/HybOTk5g5ujgyM6387mT8J5tBHBP
 Xph2u9sNfnk/cdhuzC+Z+ENBHG+9mXDGeashlAmPE8/0cQqp6DCdQfwrgAS4Lsht+iq1jE72J
 C8Z39aI80xMiQ8mM2eeLb1CsyinkgS1YSSCLNu3t7fssekXqqExBKAbnmm4ciHcNt1norD1C3
 TBN+9swXcMAoAR6WlfOoO5mz+KgCRIRnsJ1djHQs2VFdK3pLIA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move gpio/drivers-on-gpio.txt to driver-api/gpio/drivers-on-gpio.rst and
make sure it builds cleanly as ReST.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

This patch applies cleanly on top of 93db446a424c ("mtd: nand: move raw
NAND related code to the raw/ subdir")
---
 .../drivers-on-gpio.txt => driver-api/gpio/drivers-on-gpio.rst}      | 1 +
 Documentation/driver-api/gpio/index.rst                              | 1 +
 Documentation/gpio/00-INDEX                                          | 3 ---
 Documentation/gpio/sysfs.txt                                         | 5 ++---
 4 files changed, 4 insertions(+), 6 deletions(-)
 rename Documentation/{gpio/drivers-on-gpio.txt => driver-api/gpio/drivers-on-gpio.rst} (99%)

diff --git a/Documentation/gpio/drivers-on-gpio.txt b/Documentation/driver-api/gpio/drivers-on-gpio.rst
similarity index 99%
rename from Documentation/gpio/drivers-on-gpio.txt
rename to Documentation/driver-api/gpio/drivers-on-gpio.rst
index a3e612f55bc7..7da0c1dd1f7a 100644
--- a/Documentation/gpio/drivers-on-gpio.txt
+++ b/Documentation/driver-api/gpio/drivers-on-gpio.rst
@@ -1,3 +1,4 @@
+============================
 Subsystem drivers using GPIO
 ============================
 
diff --git a/Documentation/driver-api/gpio/index.rst b/Documentation/driver-api/gpio/index.rst
index 2b73ea5a1fbb..6a374ded1287 100644
--- a/Documentation/driver-api/gpio/index.rst
+++ b/Documentation/driver-api/gpio/index.rst
@@ -11,6 +11,7 @@ Contents:
    driver
    consumer
    board
+   drivers-on-gpio
    legacy
 
 Core
diff --git a/Documentation/gpio/00-INDEX b/Documentation/gpio/00-INDEX
index 650cb0696211..17e19a68058f 100644
--- a/Documentation/gpio/00-INDEX
+++ b/Documentation/gpio/00-INDEX
@@ -1,7 +1,4 @@
 00-INDEX
 	- This file
-drivers-on-gpio.txt:
-	- Drivers in other subsystems that can use GPIO to provide more
-	  complex functionality.
 sysfs.txt
 	- Information about the GPIO sysfs interface
diff --git a/Documentation/gpio/sysfs.txt b/Documentation/gpio/sysfs.txt
index 6cdeab8650cd..58eeab81f349 100644
--- a/Documentation/gpio/sysfs.txt
+++ b/Documentation/gpio/sysfs.txt
@@ -32,9 +32,8 @@ standard kernels won't know about. And for some tasks, simple userspace
 GPIO drivers could be all that the system really needs.
 
 DO NOT ABUSE SYSFS TO CONTROL HARDWARE THAT HAS PROPER KERNEL DRIVERS.
-PLEASE READ THE DOCUMENT NAMED "drivers-on-gpio.txt" IN THIS DOCUMENTATION
-DIRECTORY TO AVOID REINVENTING KERNEL WHEELS IN USERSPACE. I MEAN IT.
-REALLY.
+PLEASE READ THE DOCUMENT AT Documentation/driver-api/gpio/drivers-on-gpio.rst
+TO AVOID REINVENTING KERNEL WHEELS IN USERSPACE. I MEAN IT. REALLY.
 
 Paths in Sysfs
 --------------
-- 
2.16.1
