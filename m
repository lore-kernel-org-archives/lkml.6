Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965959AbeBMWHT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:07:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:48185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965891AbeBMWHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:07:17 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-doc@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        SeongJae Park <sj38.park@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/process/howto: Remove outdated info about bugzilla mailing lists
Date: Tue, 13 Feb 2018 23:06:32 +0100
Message-Id: <20180213220635.2364-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:y6Vk7K76lqZuEu+1Q3QE2wpQ8y56yoWY/TXN43EuQ2N2ilMghjo
 iJ8McZ+hRuitpDt5dnRsfU5WXOBZMeRRXo0ZfXs05cSpFY1bgKr5x2QFyuooto68L7KKrEN
 wIs3k9d3cGSfa4Y+w1ryxF6LCE9+H8xwvwgb9z+FlLuWhhzC7h0p+h+hQdNm03853C02ba+
 /nfhSQ8cp1uMK17FKxIYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7SC177Q3LvI=:IruGbFIi66J2ypZFH2XpAX
 qWagnDz4czAezeYqqoqhDXRkd2DO3oISrBxqSveA1his5FLgVpaDsEACGjm0ThzjX3jsZI7d4
 QsDJmacjULq6+qS3bAwurwzu1s7oMZ+7Q6Qgvd6NChtweDDOyTCkJKZoLvoqLJjw9PyvLiBNT
 vGvQiY1z3ePcP8byeLo8c77yctVhqNUNVZeGQnGCORS70fke0pSvstHBGVkybZpO5FXOlTV3w
 GX8E6mHThxTfzFDg01NL+NY8Ab4GH+pzHjsGaRdIx+JyAk6Fdxt/cFIZCbq6Sw9Zk2mdfAB7q
 nSu5mi4aYN4SZuAAid5G2u5t++/TpXS8jU4GElYXs9NsOrDt2WlsQkrtH7yr6jI6Y/xmvLu8Z
 XuhRk9WzdFuvroVxIKZClC8QsfOqdS6PouiC6U0wkZvh3EFHAKeRZ7M+OvP6IQA4Nt0L4Vmfn
 fLEfMdXbeGhKbqGKVzLBmZIDoz5BEcGO3Qtk2vZ28A6elSp/SQU6DuAQ4UF8e7xZH7ErtAq5K
 FQd81bCIXP3bwZ7Dr177e82JnaFXxiTsNCYul/jQdmZ++CyyymlFA6ASU+OP8LYf67gqc1uVJ
 63BITfWjCIoZJSSBdTWLqN4cqCcyjbOTDpvoHYdx3MAK93nX8EEFEsbrTWxRznyo+VKLmlsnp
 C8lgWxH9H8tDRaZpnZuSIxLymMZZDriBCwvVU9LUyQgbdxilqtJVNt0sIIvO+9XuEPK6yAAVD
 3EhBC+Yl8neTcLET/dmwRyQ+8+D43D9YNnkNWLfE0F/89h2IRfbrGxyplRgW5ni7zvEei/pzT
 DwfELDwMVk8Y/SrxP4xhm9easweO1Ik4FRJyGrR/CuxfjgXdYnixK7yuKNkSVu65iItdO+r
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailing list archives[1,2] show no activity since September 2011.

[1]: https://lists.linuxfoundation.org/pipermail/bugme-new/
[2]: https://lists.linuxfoundation.org/pipermail/bugme-janitors/

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/process/howto.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index c6875b1db56f..fbd236e037c2 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -381,14 +381,6 @@ bugs is one of the best ways to get merits among other developers, because
 not many people like wasting time fixing other people's bugs.
 
 To work in the already reported bug reports, go to https://bugzilla.kernel.org.
-If you want to be advised of the future bug reports, you can subscribe to the
-bugme-new mailing list (only new bug reports are mailed here) or to the
-bugme-janitor mailing list (every change in the bugzilla is mailed here)
-
-	https://lists.linux-foundation.org/mailman/listinfo/bugme-new
-
-	https://lists.linux-foundation.org/mailman/listinfo/bugme-janitors
-
 
 
 Mailing lists
-- 
2.15.1
