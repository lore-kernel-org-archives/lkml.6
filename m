Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeBEVah (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:30:37 -0500
Received: from mout.web.de ([212.227.15.3]:40187 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751970AbeBEVab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:30:31 -0500
Subject: [PATCH 4/4] HID: logitech-dj: Fix a typo in a comment line
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Message-ID: <0d17da5f-00ad-259f-932e-dc54eb45696c@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7rIfeywd5bdAgbbWiug8cP1PiiIKAac14itlDLrW6OVy9OFzUrE
 QBT6rlkBZbkOmoidbARV4YsmlAGmpTQQXwTNKBpEzfbGoBp2qMuFogn487wiOzPzULEeLg6
 XrTl4TwhyuY68djq4eaGGRrCqRWknN0b0WqByZoHlLsY7atadoOIYgxqeq7oInlInm5QTR3
 6ZbRaUrSKI+ntk+OEZ5Zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CZQIK/pSeyc=:J509g7kSYqmSrEHlj5s4Mt
 jJpPaVb/K7c6ckUkykTN6h9hokxtUFbUVlkVqFHKRBFl4hF8Hz99Sxf3JY3aLVSmTX0UQn308
 2EnTUel3YEfvY+jOLSQqwgsojes/6f+DR+W2gjBRgdVrvSKriywVaumzQjvniZL2ksC1+6lyr
 f7BVrdW6Ls6y9EQsSxdDafoECwIHLRAbhQ+ATLqYoETrRdZOUkfE/I/Rjc9MDuxy8HFV66HYJ
 qvMlJDS+hS/1bpOAmZx3si5oGVKg6to7tMfPzxrQtKEdFKy3pDRQWQ0pYhvc0PpuWi30cC4gV
 97CH/DC2f7i/rAbqW5R5+cNrZckj3tTysw2S53NEb4VdfTDWK5K9g+fU0dWPdKEZEX7iWRIGY
 pezQtr6M/pd8inH+IL94e5qvoOZ+rNvXoqAg0Vq/1kHRS5IkOB994a2HeDUzgUlYbKTfFalAn
 iLGfhf3SxaxtPJq4MxXsR1XStkHnWHAgdfwbnAf/Uco0TKtkJBtuKv/eWA9q5CDHTJJbIjNja
 iKBwgFjvXM3j1HqodRl1ksms5xp31j+OdFGZiVPlWE+f8RGyQRnrp0DWrCT9zFy4YtxsFNImH
 5mFwg7nB19wwgLGopLob+XmFklWz2GSdHDY567BxLxkKjBtLR0pbwWjjgOqwYSGvomF0ZsZQG
 9NZhUSk8YrkDS/S5xWywZEvr31dcqzmcx/mx6J3RwV+PnHw69SmxnMFp7AsDSGp5GHe5uBO3j
 55uV1G7C1EhJETQDVge0l7sXf8u3QLEF/r9NJQ5R7n0mUhz6ZkP9l72gejlffmoejjxSPt9s6
 +3dRXAWcj6LpzevET0TOZW3pVOp9GP3oxKGYdHVAzv4KoXjy8g=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:14:49 +0100

Adjust a word in this description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-logitech-dj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index f1496c6303ce..de1859fade5c 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -318,7 +318,7 @@ static const char hidpp_descriptor[] = {
  *
  * Right now, RF report types have the same report types (or report id's)
  * than the hid report created from those RF reports. In the future
- * this doesnt have to be true.
+ * this doesn't have to be true.
  *
  * For instance, RF report type 0x01 which has a size of 8 bytes, corresponds
  * to hid report id 0x01, this is standard keyboard. Same thing applies to mice
-- 
2.16.1
