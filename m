Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932235AbeCIQWk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:22:40 -0500
Received: from mout.web.de ([217.72.192.78]:52451 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeCIQWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:22:39 -0500
Subject: [PATCH v2 10/17] mfd: tps6586x: Delete an error message for a failed
 memory allocation in tps6586x_parse_dt()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <a0adebd4-4efc-3f0e-a4c5-6adb9c3c263e@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:22:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:6yHrUo2x4cnuzx4TP9cGwZ40VLSPmY0ZZeLuQNZoMDAPSeEl13f
 IWHWGI0Z9rjYVbdctNaCcyxR3XR2vvAtDgil4bRRV+zwvhdaRgJc3/gx3sofX33/FNJy/HL
 OKUXBB3MukygJ4Am5iCpZrf5DJMm410i4aGN5k3nAdQvqbe7+vCOH3aEXQleh0z5y3iPjHU
 gLxWs0bOtxOR6Ddw8AxhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JnEc6Y6IEUA=:PPAshD8uNpF2bGVfGS0g7l
 2LCuc0OGZYMbkLBxKXlhfdD6FDqA68z5poNvg/5l+9Yx5yBm59IAbrWC0VpUDrAntzwMK8nC4
 eLXDy+x3rj7qjRAuPnop7at6IN7D3IXIxEVSsXbbRIwkj3Zwh8dk0fxip4pG1QcRitJRdq8rE
 /cks8mCIAb/tZ8kPRGgkPyRgDD+LYGlETj83zUqsYfwDBHaKDZB5nJH+ctOXHxO4FdxRPMI1I
 l9XmWOxS2aKq4hnAsNoO4yMlPJAralRmPw482nN3Z+XZUhmi1kXZFTqHRQyWg8ZMua5G5YB/n
 CZbq85+kHCgrzmueUWwHDYAW+ncTx/OBJ43MBl3lOP8hKsZoL1snyF2lsT0pKapQvXmHdgIsi
 FppwzVrVTiTIRuxGhm4BEME/dpbD0hhOPH8e3qjJ6RKRhDiS6YaeYyYSv32KlocA6IqTFoaeD
 2oH/M9JsHQaBqTBrO6dtUB1INHdWB8VhkyeiWfP8T6RfxYE62r9m0fJt3SwIorK4jx9Yfyzg4
 wqAo7H1Op4MBv2Ne04jkRBX6Ft1yYSrnYVyEWVoMtRnf7Wlk+UaRJj0/XbxBiuM6AjBByEpif
 GzzTXawYZ95m1AShSue514x0gACDiAgPWVfpLCgD0fzQz+FfbY8ofhMFtEAIlkGzGkOfLByqu
 qeJq+hYUQof4ZfGFxTTD6Wcb9WrAIDYq1Y/K4lp4jNSpmtQPcoTu7eJIkzKxNIvs0o1b/utUa
 4OXur54YOdU0Rf5lS9w/3AUpky5H2T292Vard1fMokRcb8DIhL3+sIliY7CenSL+GS5OIMmE8
 4MuGk712aixXh1ArDKrCA4YpPpYW3ECqYHW17H+9ss4wMifbUn50rDuxckbRrBVPnyiV7weRu
 P+1Jmr0mwDY0zljaoAVq5+ech0R6PKd/nb7VcVTi1FtHQhf6BF7Qf0V4xmwHOBWzYeU2DcgTi
 fmjWZ1oiQuVzTzmQsr7Rt8uCWqZ237t6HJONjWOA4x2AkutbFsoD6yZHr15V2c9vc6110t7B9
 ONBzG2hFEXtrp7O7HabzLEs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 15:30:54 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/tps6586x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 5628a6b5b19b..b89379782741 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -423,10 +423,8 @@ static struct tps6586x_platform_data *tps6586x_parse_dt(struct i2c_client *clien
 	struct tps6586x_platform_data *pdata;
 
 	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&client->dev, "Memory allocation failed\n");
+	if (!pdata)
 		return NULL;
-	}
 
 	pdata->num_subdevs = 0;
 	pdata->subdevs = NULL;
-- 
2.16.2
