Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeCIQrJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:47:09 -0500
Received: from mout.web.de ([212.227.17.12]:60679 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751184AbeCIQrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:47:06 -0500
Subject: [PATCH v2 15/17] mfd: tps80031: Delete an error message for a failed
 memory allocation in tps80031_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <25f40839-22b0-26de-591d-cfbbf4b28547@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:46:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Al7durf0UYhL7nYJILigPKIbJxWYkWcN0kmt5DID6tsvnh9N9UI
 vsPOncJx+rCmivFgGhxqrNwQUEM7mMXCCDcAXIP7p+K4Gp07rUcMHPY97l16k44wI3Y7qgw
 VaNUWfohxZ9wYyo52F9Jnw4xgwGG2FrKicUGrbjC2RiMGph+bFW99YQavIYJwygcTSGjbdV
 uSDEdShTqs0hCzjrRotVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q0S/sItaY2w=:+ZqnRHHSSs2DvNUQzZvzLG
 VDWJ96VwcawiYSA/bbB7RRcsW4SLkJGTyxjhLwXlpO0a0y+GA2IySfl8boTURKfU90RKNqt6F
 cJdseeJO4toD0S4OPKJ4eFag0pvnbFsyjgZyXGQ8fxnEntVgW3+c47LwuOTxgYL6uUtlY+kXb
 I6F7l3k+LUU+/2yWKOoMOG+2xfbBx59N1RVBMUfDmzwAazw8Ptin6gWz8/B/T86X/iRC52oAZ
 KbO5z0y/aE2/32U6EtXcKrW5NQR+i7Ik4MmhpBe/2dWPvuo7tN9zNKC06UIW7dsMVFzjrDv40
 htYYk5JL1fqaJ9tUf9SP6LLmr1m9JdgALhl8038K5GuLOwtB/ElJ9ECtpA65YsfMtx/lfMpvQ
 4F/IARLWmU5/2iweDJti+0U1WtuZazp5YvB4OHjbZwazdWNN9su0+hnDTeWwkwHqvKtIFUdEX
 ODltGpS76aHxciARLqn+f7Df1oLjj6oisayLs/EyQWi7db0TOaRh9K9sfLI3Sexg1j1QJTTUr
 fTdnR60WC5BNVYp53NAlmKCOvKQqbcYHIUl+DdMFN1bx4e5oXfFf50orw8VssW2lMjL+jsHmW
 umhW2vYvGwcMuNnkyI7Af7ODg6y67n4ea9FK9uQLuHLwGZG3BIyV7nvisvLc1uokTaTpu6dKe
 tRogjC0dL4/JjfkHyD7kp7eP6zDBoBUpA8f9KvE5X/QREMgwKFS3wU4e19Yj2yVx7sedZ+5AZ
 hbMHid2k3/XPSPxq/EJ0Uq/qt/33eKcd3sb2q5whAy63InoubDK/V98SZOYlLPS8ylFa3fzM7
 zmGux0kcGfRzV0rpBMPLS1kgb6osgaErP1M1KkUSbIV3/QcWR32pBQq6htLq59LPNXPPeRbKn
 qTqaviK9m8Me4uA2JBZlSVInu6MLef6g8D84BklFERyTXVCkfk94MzjeJS8DGl7u6UM6MeMdv
 V+grTjAgFandf5HeVmN2FlUDx7fGL1y/mZdfnRSnjVhgyaNL+PhTTH1ZBVsyhas1p1j4B/M0e
 YqU1crb9PjEYFKchh/KonLw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:45:13 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/tps80031.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/tps80031.c b/drivers/mfd/tps80031.c
index 0812df3b0d47..608c7f77830e 100644
--- a/drivers/mfd/tps80031.c
+++ b/drivers/mfd/tps80031.c
@@ -431,10 +431,8 @@ static int tps80031_probe(struct i2c_client *client,
 	}
 
 	tps80031 = devm_kzalloc(&client->dev, sizeof(*tps80031), GFP_KERNEL);
-	if (!tps80031) {
-		dev_err(&client->dev, "Malloc failed for tps80031\n");
+	if (!tps80031)
 		return -ENOMEM;
-	}
 
 	for (i = 0; i < TPS80031_NUM_SLAVES; i++) {
 		if (tps80031_slave_address[i] == client->addr)
-- 
2.16.2
