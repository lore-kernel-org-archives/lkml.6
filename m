Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBDRrd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:47:33 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36396 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBDRr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:47:26 -0500
X-Google-Smtp-Source: AH8x224c0Vh5lDdur174h2X1RcYJ4vX5BKnCPiIXO3Nk7PahdgBJPrpwDi1EFFk5ir79iCaWM19EbhKijfMVltk9fW0=
MIME-Version: 1.0
From: =?UTF-8?B?7Jik64+Z7ZiE?= <zanywhale@gmail.com>
Date: Mon, 5 Feb 2018 02:47:25 +0900
Message-ID: <CAKCSxhMXx0oa=FCRn7P8WxJTXneW0xUnEdx_e_K7HTQpa78pCw@mail.gmail.com>
Subject: [PATCH] Fix a typo in Documentation/device-mapper/dm-integrity.txt
To: trivial@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch to fix a typo in Documentation/device-mapper/dm-integrity.txt
Fix 'nubmers' to 'numbers'

Signed-off-by: Donghyeon Oh <zanywhale@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/Documentation/device-mapper/dm-integrity.txt
b/Documentation/device-mapper/dm-integrity.txt
index f33e3ade7a09..1179ab6b93cf 100644
--- a/Documentation/device-mapper/dm-integrity.txt
+++ b/Documentation/device-mapper/dm-integrity.txt
@@ -120,7 +120,7 @@ journal_crypt:algorithm(:key)       (the key is optional)
        "salsa20", "ctr(aes)" or "ecb(arc4)").
        The journal contains history of last writes to the block device,
-       an attacker reading the journal could see the last sector nubmers
+       an attacker reading the journal could see the last sector numbers
        that were written. From the sector numbers, the attacker can infer
        the size of files that were written. To protect against this
        situation, you can encrypt the journal.
