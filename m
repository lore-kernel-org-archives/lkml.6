Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbeDYKHs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:07:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:54073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbeDYKHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:07:45 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH] PM: docs: sleep-states: Fix a typo ("includig")
Date: Wed, 25 Apr 2018 12:07:03 +0200
Message-Id: <20180425100715.17235-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sAfiFVdFOlV7c6VzJ9l45Oe3RmlAOv8aDM39DdCKAnDH7nn7wD/
 HS6odjAQHVCLx/L5YNJhps92NreM5IAUwb3WmH65EXTvpERDiNg2pSbEfrXL8OS+QGGA6lH
 uIVd9SwfVf5pX/qmg4b8p/LGgR9pqLyI4a3k7bI9Yl9wBZOFFFkyywLJuVf6kgLpoWXQcb8
 pSaDcEnUc+9dU2NZ1JzlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tK/FmaU5Goc=:ZBATzmAZ6rctrmUYiMlaWi
 I8ZO6iBvqPl1WQ8UsGF3PGcvk71U+IMl4GhDNE/zbSzjcdD596WqGXb4viIF89X+vyjZ8AdNy
 jVC4MWJB+A6QCPXLv0ywfs/blC1svvs4XuHGtUXTmzrnQEzEB7K5LJyd7aM7rIDSmYGpWOwTc
 k94QacTatWJzqC8AgG7XqrOH/yY0I4o8z/zTWb4edgGE2apsCLf3ruKjTqITmSa6Jf2KhN9yG
 Z1KqAZbrANgjORqHpbPPSMtPKzhZY0krzFv8xAQzBkqXJTvko3gJ311102qYnDezyR7KskVqC
 4NxOUFU5khsBnhwHdr7JyWkufQnvdiikaudaDVWDNlAbQ7gHDBT2T2swKxForDFYmvmQw2pyt
 J3GkiLMvSlYIRnlAmMSG66kt+dfhgcePoOG00hspnKqRNzTN/saHdz/13honvP8GVzLG64kkh
 1z0zzeZ289+JO3AzVqrgPX4C6oCqExup5WQoXQmGHxtmdKmOGiwMmGe7CY2O7W3wSyy1VYQSQ
 PZg51sNa1GLa3pA/eDdFLvabQFwzTC81UI935k0LFpw25AprHIyVRoxkc3PKcgsscf9fMBj6l
 /AgeiX4dBIPfFkOkj7FZ67dP6soLncVk0k1UQglEMqmFhHe9d7B1KjQ0dwCLbi/LUIyAFSC16
 7dvhhHl2cpjjRxWonZnRxMU3Z3U3LiT8Y4Tbzb9tozg2NPqRKAQcgtLsGyDnMDYPGyvelZMUn
 g8vj5Zn4yzxPG5RhzMZ695tHlnXQXmHERvNuIgsJL3b3skmQxlUfWrJD/W1ATdpEhffqiG1Zo
 AcimA8XZmODymDXGQda7q32nL1y1t5ueZf2yRYb9pQD1zg8ikI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/admin-guide/pm/sleep-states.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
index 1e5c0f00cb2f..dbf5acd49f35 100644
--- a/Documentation/admin-guide/pm/sleep-states.rst
+++ b/Documentation/admin-guide/pm/sleep-states.rst
@@ -15,7 +15,7 @@ Sleep States That Can Be Supported
 ==================================
 
 Depending on its configuration and the capabilities of the platform it runs on,
-the Linux kernel can support up to four system sleep states, includig
+the Linux kernel can support up to four system sleep states, including
 hibernation and up to three variants of system suspend.  The sleep states that
 can be supported by the kernel are listed below.
 
-- 
2.17.0
