Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbeC1O7U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:59:20 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46695 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbeC1O7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:59:18 -0400
X-Google-Smtp-Source: AIpwx4848yEnuLjoplBjcOZl2HP5T6WBQsEGs+3tbX/cFuA0xfA7PAe60dbT0p0ZodLXLzruPxRo8A==
From: Sanjeev Gupta <ghane0@gmail.com>
To: corbet@lwn.net, linux-pm@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org
Subject: [PATCH] Documentation/thermal: Check links and convert to https
Date: Wed, 28 Mar 2018 22:59:13 +0800
Message-Id: <20180328145913.14026-1-ghane0@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All links working.

Signed-off-by: Sanjeev Gupta <ghane0@gmail.com>
---
 Documentation/thermal/cpu-cooling-api.txt | 2 +-
 Documentation/thermal/nouveau_thermal     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/thermal/cpu-cooling-api.txt
index 7df567eaea1a..32917d178c51 100644
--- a/Documentation/thermal/cpu-cooling-api.txt
+++ b/Documentation/thermal/cpu-cooling-api.txt
@@ -5,7 +5,7 @@ Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
 
 Updated: 6 Jan 2015
 
-Copyright (c)  2012 Samsung Electronics Co., Ltd(http://www.samsung.com)
+Copyright (c)  2012 Samsung Electronics Co., Ltd (https://www.samsung.com)
 
 0. Introduction
 
diff --git a/Documentation/thermal/nouveau_thermal b/Documentation/thermal/nouveau_thermal
index 6e17a11efcb0..502b0b95c2e2 100644
--- a/Documentation/thermal/nouveau_thermal
+++ b/Documentation/thermal/nouveau_thermal
@@ -79,4 +79,4 @@ Thermal management on Nouveau is new and may not work on all cards. If you have
 inquiries, please ping mupuf on IRC (#nouveau, freenode).
 
 Bug reports should be filled on Freedesktop's bug tracker. Please follow
-http://nouveau.freedesktop.org/wiki/Bugs
+https://nouveau.freedesktop.org/wiki/Bugs
-- 
2.15.1
