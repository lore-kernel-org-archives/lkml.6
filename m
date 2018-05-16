Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeEPMIo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:08:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:59459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbeEPMIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:08:42 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: gpio: driver: Fix a typo and some odd grammar
Date: Wed, 16 May 2018 14:08:00 +0200
Message-Id: <20180516120800.12517-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iOTjbbq5sgjGLRBCCUzRpOU5XOQnkLGhLc/0m8KcuMX+7RDITmt
 ZVGBUpfTwBscVwML0gJMfBu6qHOkiZ0KyNkHiUbs+Vv4ZNHBSlQDvQY4jrnCmEHgOjIHI9c
 /FvlhDpS1qjJt9rkDfb3gekhtLfOZU4jM0kp2DzowIM/ajqrBNXBQ+2eQBUK2RRiTmnKa6v
 WfODNdbEqGopO1pWme84Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yQdacdg8yfc=:mOPRJQ+zoa9oTWfclq8Nmm
 T0bwjsfle/5E55wCbjKfbT5S0WyXzBL9aqHz0QP96rUynr20YXAjmWLNm3IOoIRf1bFyENhhx
 gcTE2s4b5TS6bfGXYgnuLozf9FO5CmR4Ol/i2FAgk0fBYfLk7q+gG45b/UjRM784HQo3ZlMGc
 tuEwAVUnMa7YQuglNtJZ2qILyj3PSxaj8E9LMyQz4BeLl99fXpPj8FKHqrPsa6yA6YUtGB/dK
 /wrDFQkmhDnquDrd1qPe3F4t8TRmt4JItbtCEow2uh5c1NprqFH89nIgo/lzPx2hB+bV26aem
 ch89Yz9MsV/jtehR5V0mhqZ8CuRbi4yHM1J9VMNKwgmICqJStiUSK/41yCWqR/GivknAkMXGA
 SK5+72nWQT3RuM3Hm3nCPvCzIkTBhDiT11Tn8FQYytesj5IpJIDw0xcNQQKVMPLpsFGQp4KxW
 f02r15lmyFBDqbvJm3nBDojHtF+oHbqMzpNFuyXVYtLhZ9j8H4f+rj8M/mIebrFlySdknW0jS
 Try9oF1qVb8Fr5/y02siLvQqrttt+w/eFuwsFUHPL8g1n9BNsUpClcNNJt0qwjX849Mv9M5TP
 Z2DKaq+pCql6IF5QxsBRKMDPUj54liBjUzbqB+PqWwPGDFV+p9CrIW91Pt8B7cz5ehl67IVTt
 S0LIQc7MTJQM5nECkYUEA+Ef8f71hcF+XojuTX5JqkU80wBnZ66ChMdgjfIIEd87g0bHEUVC1
 O3uHyJYyhKRjuuHFx2MBaEoIM7VuA+Ae6XGawTma0aHVXiDE5x8gV03XwtuyUh1yi+/BTSH6L
 nKRgQrD
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/driver-api/gpio/driver.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 505ee906d7d9..cbe0242842d1 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -44,7 +44,7 @@ common to each controller of that type:
 
  - methods to establish GPIO line direction
  - methods used to access GPIO line values
- - method to set electrical configuration to a a given GPIO line
+ - method to set electrical configuration for a given GPIO line
  - method to return the IRQ number associated to a given GPIO line
  - flag saying whether calls to its methods may sleep
  - optional line names array to identify lines
@@ -143,7 +143,7 @@ resistor will make the line tend to high level unless one of the transistors on
 the rail actively pulls it down.
 
 The level on the line will go as high as the VDD on the pull-up resistor, which
-may be higher than the level supported by the transistor, achieveing a
+may be higher than the level supported by the transistor, achieving a
 level-shift to the higher VDD.
 
 Integrated electronics often have an output driver stage in the form of a CMOS
@@ -382,7 +382,7 @@ Real-Time compliance for GPIO IRQ chips
 
 Any provider of irqchips needs to be carefully tailored to support Real Time
 preemption. It is desirable that all irqchips in the GPIO subsystem keep this
-in mind and does the proper testing to assure they are real time-enabled.
+in mind and do the proper testing to assure they are real time-enabled.
 So, pay attention on above " RT_FULL:" notes, please.
 The following is a checklist to follow when preparing a driver for real
 time-compliance:
-- 
2.17.0
