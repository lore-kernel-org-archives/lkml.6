Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeBDJrx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 04:47:53 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36722 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBDJrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 04:47:46 -0500
X-Google-Smtp-Source: AH8x225Ho5br4dzs7zeJ4SbSjIyjAsQbm18SOiGJn25x9yrJo1ES+gwD/dLEVgpnVFhrs4ah6zHC6il6sDuBurS+u6M=
MIME-Version: 1.0
From: Kangmin Park <l4stpr0gr4m@gmail.com>
Date: Sun, 4 Feb 2018 18:47:45 +0900
Message-ID: <CAKW4uUxRPZz59aWAX8ytaCB5=Qh6d_CvAnO7rYq-6NRAnQJbDA@mail.gmail.com>
Subject: [PATCH] Fix a typo in Documentation/sysctl/user.txt
To: akpm@linux-foundation.org, trivial@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch to fix a typo in Documentation/sysctl/user.txt
Fix 'documetation' to 'documentation'

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

diff --git a/Documentation/sysctl/user.txt b/Documentation/sysctl/user.txt
index 1291c49..a588286 100644
--- a/Documentation/sysctl/user.txt
+++ b/Documentation/sysctl/user.txt
@@ -3,7 +3,7 @@ Documentation for /proc/sys/user/* kernel version 4.9.0

 ==============================================================

-This file contains the documetation for the sysctl files in
+This file contains the documentation for the sysctl files in
 /proc/sys/user.

 The files in this directory can be used to override the default
