Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98041ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F47120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F47120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbeGXMWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:22:52 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbeGXMWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:22:51 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LdPHS-1gPXWz3Kl8-00ihTY; Tue, 24 Jul 2018 13:16:43 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] s390: ebcdic: convert comments to UTF-8
Date:   Tue, 24 Jul 2018 13:13:26 +0200
Message-Id: <20180724111600.4158975-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724111600.4158975-1-arnd@arndb.de>
References: <20180724111600.4158975-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=Binary
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TAfHxN6CJzbQ0rFejj3b+XRvgGNJgKHcFv1N2tfaG+n7i2maN/X
 SMbEe/DpZOsGG7DMRUhNy8zwF+Ydbzv3mBS3VJklCKOsmSOeqZZ1Q4oqpSw9/lEq6PYvJMy
 GQdwptX5B6wUPg3naFjUXMjwfC0vdoGhMsuteC3VaugvGcffqpCvhDfJDubBWOUKeJXOplq
 TPoLaTK2VdClKIRydCUtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5LrmUM31fHY=:TQSpqRD0ZohY0g2rJLaGjT
 lYj1I1IqfX1u55vN7/IE8l9AprN9fnDsGFnEVuriRvH8k7vuxua7kd0TPUZfV9ya7b5wKEH06
 1UVHZW8mTT0HkSmFb0Br7MJVQy3t14K8fe0oiJyvcop5KevNoA2Qihs3kqvRUqqz3iAVx6t9l
 8Kn9SLtMYAql2yO3i3NiQe9sFI23+V5GTtInOBexLea+xQ/l5QkufpRbWgYRkvEzxoE7k3gS1
 +2hEj7Sy0aVwnhXYQ/2FdC2MwnE5JRsNcw5q4a4Ppo7z2GVB48nMJqw3qajf8LXWw8VJjXF4Z
 K+J47MU4ABnc/o9n6yR7XZ0qiNZZ5xQXt8T7/Kh4/d1vZh3hDEVj1JE8YrN6aPkMOjCN8j/Ej
 e+xq4ONVMueQn5QZj8xrtkq4yIYpqiStdJZv2ZKFzc4iVklma1PRwvVpCCN/TqK1Orpg5WVV5
 iUvcSA9YzTI/htATOcAxJV7imbJMWU6xZBzhMLmFD5484i8K1kHoAnNB3BK4nUj6sxzPeK/4t
 zZlTDowHy0RJzToWpGiUKfRwexoOx43CgdRYB+VAjFrbMmReuNVRpvKsq3RsvuEsh0dRyyfrZ
 HP7X9VrjnWCdKLMyVXepikTYP0W/lONelmKT6FXeMjLgGjCK9UKYupSQ49v+ouaQ2mJWvA2WS
 Yr3Eve/7p4eNwDbQuWR7QBQnuPu/1MpoW7nuezZShSgjKTxJvPw/42bAPIntXMEQfTfGrUOja
 hgxCsmsVCHntwea3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ebcdic.c file contains tables for converting between ebcdic and
PC codepage 437. I could however not identify which encoding was used
for the comments. This seems to be some variation of ISO_8859-1 with
non-UTF-8 escape characters.

I have converted this to UTF-8 by manually removing the escape characters
and then running it through recode, to get the same encoding that we
use for the rest of the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/kernel/ebcdic.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/ebcdic.c b/arch/s390/kernel/ebcdic.c
index c15caeab1dbf..7f8246c9be08 100644
--- a/arch/s390/kernel/ebcdic.c
+++ b/arch/s390/kernel/ebcdic.c
@@ -111,15 +111,15 @@ __u8 _ebcasc[256] =
           0x07, 0x07, 0x16, 0x07, 0x07, 0x07, 0x07, 0x04,
  /* 0x38  -SBS   -IT  -RFF  -CU3   DC4   NAK  ----   SUB */
           0x07, 0x07, 0x07, 0x07, 0x14, 0x15, 0x07, 0x1A,
- /* 0x40    SP   RSP           Å‰              ----       */
+ /* 0x40    SP   RSP           √§              ----       */
           0x20, 0xFF, 0x83, 0x84, 0x85, 0xA0, 0x07, 0x86,
  /* 0x48                       .     <     (     +     | */
           0x87, 0xA4, 0x9B, 0x2E, 0x3C, 0x28, 0x2B, 0x7C,
  /* 0x50     &                                      ---- */
           0x26, 0x82, 0x88, 0x89, 0x8A, 0xA1, 0x8C, 0x07,
- /* 0x58           Åﬂ     !     $     *     )     ;       */
+ /* 0x58           √ü     !     $     *     )     ;       */
           0x8D, 0xE1, 0x21, 0x24, 0x2A, 0x29, 0x3B, 0xAA,
- /* 0x60     -     /  ----     Åƒ  ----  ----  ----       */
+ /* 0x60     -     /  ----     √Ñ  ----  ----  ----       */
           0x2D, 0x2F, 0x07, 0x8E, 0x07, 0x07, 0x07, 0x8F,
  /* 0x68              ----     ,     %     _     >     ? */ 
           0x80, 0xA5, 0x07, 0x2C, 0x25, 0x5F, 0x3E, 0x3F,
@@ -131,7 +131,7 @@ __u8 _ebcasc[256] =
           0x07, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
  /* 0x88     h     i              ----  ----  ----       */
           0x68, 0x69, 0xAE, 0xAF, 0x07, 0x07, 0x07, 0xF1,
- /* 0x90     Å∞     j     k     l     m     n     o     p */
+ /* 0x90     ¬∞     j     k     l     m     n     o     p */
           0xF8, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
  /* 0x98     q     r                    ----        ---- */
           0x71, 0x72, 0xA6, 0xA7, 0x91, 0x07, 0x92, 0x07,
@@ -139,25 +139,25 @@ __u8 _ebcasc[256] =
           0xE6, 0x7E, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
  /* 0xA8     y     z              ----  ----  ----  ---- */
           0x79, 0x7A, 0xAD, 0xAB, 0x07, 0x07, 0x07, 0x07,
- /* 0xB0     ^                    ----     Åß  ----       */
+ /* 0xB0     ^                    ----     ¬ß  ----       */
           0x5E, 0x9C, 0x9D, 0xFA, 0x07, 0x07, 0x07, 0xAC,
  /* 0xB8        ----     [     ]  ----  ----  ----  ---- */
           0xAB, 0x07, 0x5B, 0x5D, 0x07, 0x07, 0x07, 0x07,
  /* 0xC0     {     A     B     C     D     E     F     G */
           0x7B, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
- /* 0xC8     H     I  ----           Åˆ              ---- */
+ /* 0xC8     H     I  ----           √∂              ---- */
           0x48, 0x49, 0x07, 0x93, 0x94, 0x95, 0xA2, 0x07,
  /* 0xD0     }     J     K     L     M     N     O     P */
           0x7D, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50,
- /* 0xD8     Q     R  ----           Å¸                   */
+ /* 0xD8     Q     R  ----           √º                   */
           0x51, 0x52, 0x07, 0x96, 0x81, 0x97, 0xA3, 0x98,
  /* 0xE0     \           S     T     U     V     W     X */
           0x5C, 0xF6, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
- /* 0xE8     Y     Z        ----     Å÷  ----  ----  ---- */
+ /* 0xE8     Y     Z        ----     √ñ  ----  ----  ---- */
           0x59, 0x5A, 0xFD, 0x07, 0x99, 0x07, 0x07, 0x07,
  /* 0xF0     0     1     2     3     4     5     6     7 */
           0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
- /* 0xF8     8     9  ----  ----     Å‹  ----  ----  ---- */
+ /* 0xF8     8     9  ----  ----     √ú  ----  ----  ---- */
           0x38, 0x39, 0x07, 0x07, 0x9A, 0x07, 0x07, 0x07
 };
 
@@ -260,15 +260,15 @@ __u8 _ebcasc_500[256] =
           0x07, 0x07, 0x16, 0x07, 0x07, 0x07, 0x07, 0x04,
  /* 0x38  -SBS   -IT  -RFF  -CU3   DC4   NAK  ----   SUB */
           0x07, 0x07, 0x07, 0x07, 0x14, 0x15, 0x07, 0x1A,
- /* 0x40    SP   RSP           Å‰              ----       */
+ /* 0x40    SP   RSP           √§              ----       */
           0x20, 0xFF, 0x83, 0x84, 0x85, 0xA0, 0x07, 0x86,
  /* 0x48                 [     .     <     (     +     ! */
           0x87, 0xA4, 0x5B, 0x2E, 0x3C, 0x28, 0x2B, 0x21,
  /* 0x50     &                                      ---- */
           0x26, 0x82, 0x88, 0x89, 0x8A, 0xA1, 0x8C, 0x07,
- /* 0x58           Åﬂ     ]     $     *     )     ;     ^ */
+ /* 0x58           √ü     ]     $     *     )     ;     ^ */
           0x8D, 0xE1, 0x5D, 0x24, 0x2A, 0x29, 0x3B, 0x5E,
- /* 0x60     -     /  ----     Åƒ  ----  ----  ----       */
+ /* 0x60     -     /  ----     √Ñ  ----  ----  ----       */
           0x2D, 0x2F, 0x07, 0x8E, 0x07, 0x07, 0x07, 0x8F,
  /* 0x68              ----     ,     %     _     >     ? */ 
           0x80, 0xA5, 0x07, 0x2C, 0x25, 0x5F, 0x3E, 0x3F,
@@ -280,7 +280,7 @@ __u8 _ebcasc_500[256] =
           0x07, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
  /* 0x88     h     i              ----  ----  ----       */
           0x68, 0x69, 0xAE, 0xAF, 0x07, 0x07, 0x07, 0xF1,
- /* 0x90     Å∞     j     k     l     m     n     o     p */
+ /* 0x90     ¬∞     j     k     l     m     n     o     p */
           0xF8, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
  /* 0x98     q     r                    ----        ---- */
           0x71, 0x72, 0xA6, 0xA7, 0x91, 0x07, 0x92, 0x07,
@@ -288,25 +288,25 @@ __u8 _ebcasc_500[256] =
           0xE6, 0x7E, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
  /* 0xA8     y     z              ----  ----  ----  ---- */
           0x79, 0x7A, 0xAD, 0xAB, 0x07, 0x07, 0x07, 0x07,
- /* 0xB0                          ----     Åß  ----       */
+ /* 0xB0                          ----     ¬ß  ----       */
           0x9B, 0x9C, 0x9D, 0xFA, 0x07, 0x07, 0x07, 0xAC,
  /* 0xB8        ----           |  ----  ----  ----  ---- */
           0xAB, 0x07, 0xAA, 0x7C, 0x07, 0x07, 0x07, 0x07,
  /* 0xC0     {     A     B     C     D     E     F     G */
           0x7B, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
- /* 0xC8     H     I  ----           Åˆ              ---- */
+ /* 0xC8     H     I  ----           √∂              ---- */
           0x48, 0x49, 0x07, 0x93, 0x94, 0x95, 0xA2, 0x07,
  /* 0xD0     }     J     K     L     M     N     O     P */
           0x7D, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50,
- /* 0xD8     Q     R  ----           Å¸                   */
+ /* 0xD8     Q     R  ----           √º                   */
           0x51, 0x52, 0x07, 0x96, 0x81, 0x97, 0xA3, 0x98,
  /* 0xE0     \           S     T     U     V     W     X */
           0x5C, 0xF6, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
- /* 0xE8     Y     Z        ----     Å÷  ----  ----  ---- */
+ /* 0xE8     Y     Z        ----     √ñ  ----  ----  ---- */
           0x59, 0x5A, 0xFD, 0x07, 0x99, 0x07, 0x07, 0x07,
  /* 0xF0     0     1     2     3     4     5     6     7 */
           0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
- /* 0xF8     8     9  ----  ----     Å‹  ----  ----  ---- */
+ /* 0xF8     8     9  ----  ----     √ú  ----  ----  ---- */
           0x38, 0x39, 0x07, 0x07, 0x9A, 0x07, 0x07, 0x07
 };
 
-- 
2.18.0

