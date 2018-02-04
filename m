Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeBDSDP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 13:03:15 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39346 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBDSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 13:03:07 -0500
X-Google-Smtp-Source: AH8x226QGs9UDwhymZRFv1XBpGbksG7iZdAzVAKd87kzzZZw3VCf9C5t6SBCewWskjzRXajFKZ4PnqR2lzVC/oKXQ8k=
MIME-Version: 1.0
From: =?UTF-8?B?7Jik64+Z7ZiE?= <eclipse1725@gmail.com>
Date: Mon, 5 Feb 2018 03:03:06 +0900
Message-ID: <CALKo_thZB-3ffie0r=KkctD2v4bJWk8_V=E2QECoi7NJzQzH0Q@mail.gmail.com>
Subject: [PATCH] Fix a typo in Documentation/device-mapper/dm-zoned.txt
To: trivial@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch to fix a typo in Documentation/device-mapper/dm-zoned.txt
Fix 'convnetional' to 'conventional'

Signed-off-by: Donghyeon Oh <zanywhale@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/Documentation/device-mapper/dm-zoned.txt
b/Documentation/device-mapper/dm-zoned.txt
index 736fcc78d193..2be4add21298 100644
--- a/Documentation/device-mapper/dm-zoned.txt
+++ b/Documentation/device-mapper/dm-zoned.txt
@@ -97,7 +97,7 @@ the buffer zone assigned. If the accessed chunk has
no mapping, or the
accessed blocks are invalid, the read buffer is zeroed and the read
operation terminated.
-After some time, the limited number of convnetional zones available may
+After some time, the limited number of conventional zones available may
be exhausted (all used to map chunks or buffer sequential zones) and
unaligned writes to unbuffered chunks become impossible. To avoid this
situation, a reclaim process regularly scans used conventional zones and
