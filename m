Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967180AbeBNKVD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:21:03 -0500
Received: from mout.web.de ([212.227.17.12]:53903 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967064AbeBNKVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:21:01 -0500
Subject: [PATCH 3/4] crypto: ux500: Adjust an error message in
 ux500_cryp_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Geliang Tang <geliangtang@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Message-ID: <93bfba75-2372-c20d-731e-d11dcb40dc3e@users.sourceforge.net>
Date: Wed, 14 Feb 2018 11:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/xikcfVPRz1h+MyPkwdkhN1BcKlDehjoyY2MMLu8QLHoHgzimiq
 6FW1LRcSUuawvyi8OFCM01rd4NhaoDIZRuza/N5cNI+ievRJMxFgoiKWN06IfXTjn+8mlsK
 2xTxLpUwKE9aDrm1OBOBw1iXWJTVzc295AtcEjIBIUZU6FH9WtAatCkqAXPBTxfVXyXZoEf
 BNFA8ybySAt1J/h2+jtmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6DzjkaZ0Y4s=:hV1ub8WmRY9osEGSy87oPd
 LV1d1xJl53WNKglpDkIqe6Br9jn/Hyv7WnoXn73ACCYR+/FwsoXsUpPXPmOJ+2O4vp9t3ceOi
 ZLXVhwIgjcJkk38l6u0jnsFbZ22gp9ybYjnNFiXuqSflHA3cq3X8AIPgriN53cG63bOoRGWUs
 HU2FsvxzCwFsePKhOqWsJI4ZMTc1dlqm2osWNXVR6DbkuAKMaq0xU4y0g1PT3JKGWxaJr6fXF
 pASSmRGbTE8zaytAmwJMJkIFZarYG7fYuHcIAeyZaoKKkXNVDzvSHz8JL+OBOOUwIV7bIHKYt
 tZvM1Vl9W/63njhx3CB4oPE5i77IDMscjvaE6m7jszUsGhNt9zkTmeYuaxNPkC1V9OG7csQ3s
 SWj+/fLfK28Q0jQtYXkFASclEI06m7Ez6pd4NZ0ywK+KKZ3mWziQE1AES/L+3Jnd/FpditRd4
 YMPWRofHZYvm9yKpjxr9SCHxCIOgNOtOLbnODSKB4MFSVfnxyoAshm87K7pIUKJ0DQAB7/jUA
 sx8Uf7WDN3nkuZbss18tHq3OzUhdcY7bCugImkhO4FiT01h7mHtjTCf03073A9E8OT5g5cfEW
 mrh1zWSQW14atbFqURxJsZrLEXr+O1GYBetCA0JnZ5cFUFXImiWxKDpXKFVBIy6WxeaYJgx6k
 Q1IqcDuwtbk3OouVRH1h2XdQLk4lFgzxVbslraa1OoUcYd57Q6cYaroro9PhWdAeP568nri74
 KRrLSGSWVBr8OWiGqcYfhHZyjqjripWuDSi/EL1lgGWWsuWOsyy1YUX6f4BUJ3Wg2qOsrg5cN
 C0OMW0qeRdx/LiJD2Lp4vtcXzXtSCn6IPRFTQhjHJkAexg5D9I=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 10:47:31 +0100

Replace the function name in this error message so that the same name
is mentioned according to what was called before.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/ux500/cryp/cryp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 07cc92f88933..7c811d7eb274 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1478,7 +1478,7 @@ static int ux500_cryp_probe(struct platform_device *pdev)
 	}
 
 	if (cryp_check(device_data)) {
-		dev_err(dev, "[%s]: cryp_init() failed!", __func__);
+		dev_err(dev, "[%s]: cryp_check() failed!", __func__);
 		ret = -EINVAL;
 		goto out_power;
 	}
-- 
2.16.1
