Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeENLnU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:43:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22431 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeENLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:43:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180514114313epoutp016f675f3ee000118126b2c331b6547733~ugB7X-Ftv0435504355epoutp01k
X-AuditID: b6c32a36-b55ff70000001027-4f-5af9765118f0
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 03/14] thermal: ti-soc-thermal: fix comments in
 omap4-thermal-data.c
Date: Mon, 14 May 2018 13:42:10 +0200
Message-id: <1526298141-14045-4-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCmnm5g2c8og/dXJSw2zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsErow1LUkF0zkq/l3tYmlgfMbWxcjJISFgItFy6B9jFyMXh5DADkaJ
        J8ffMEE43xkl/nWcgKua9fsqO0RiN6PE+v0LWSGcX4wSp39cYwWpYhOwkpjYvooRxBYRcJOY
        teQPmM0sMJVRYtOEehBbWCBMYtWELewgNouAqkT/5ClMIDavgIfE851HoLbJSZw8NhlsJqeA
        p8SG9pdsIMskBHrYJFb/vARV5CKxbuduVghbWOLVcZChHEC2tMSlo7YQ9c2MEt927GGGqJnA
        KLFnvRCEbS1x+PhFVojj+CTefe1hhejllehogyrxkNg87SkjhO0o0X94GZgtJDCHUeJca8YE
        RqkFjAyrGMVSC4pz01OLDQuM9IoTc4tL89L1kvNzNzGCY1LLbAfjonM+hxgFOBiVeHgDlv+I
        EmJNLCuuzD3EKMHBrCTCu9voZ5QQb0piZVVqUX58UWlOavEhRmkOFiVx3jlKX6OEBNITS1Kz
        U1MLUotgskwcnFINjCx8J5wK0vgXhIT7nvQNT9zxuU+ZVc20/4LHtSl/Zk3qsM1KUNA+Gxe8
        5E1c1aSg/Zt2PchW3Lfdh3/9H+HU5Vm5Qtvffr6c8GFHxp9oqUNfZvQ6GArwmMdss9ujnzK3
        KSio78eywzOCLitWMTIeDvthNCP0/Z21N9gZ99vNOlqsW9q0t+XNNyWW4oxEQy3mouJEAMRe
        nTzFAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xgG5A2c8og+Wn1Cw2zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsErow1LUkF0zkq/l3tYmlgfMbWxcjJISFgIjHr91X2LkYuDiGBnYwS
        U6YtZoNwfjFK3Jy0jR2kik3ASmJi+ypGEFtEwE1i1pI/jCBFzAJTGSUmfzoFNkpYIExi1YQt
        YA0sAqoS/ZOnMIHYvAIeEs93HoFaJydx8thkVhCbU8BTYkP7S7C4EFDN7d8tbBMYeRYwMqxi
        lEwtKM5Nzy02KjDMSy3XK07MLS7NS9dLzs/dxAgMo22Htfp2MN5fEn+IUYCDUYmHd8XKH1FC
        rIllxZW5hxglOJiVRHh3G/2MEuJNSaysSi3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZq
        akFqEUyWiYNTqoHRdNXip+1X33y1UJJnTGsRT5MqtpqcoLlB8TRL6KwvMWbXbX5s/y049/XN
        N87Tj0cLNGpVOTiEvb3jt8E88OqGHUesGwS9D5rf2/zs+B7jV2WHmZKU03KOTzC/LLzqa0qg
        MNfla1mrr+WktO1YY332cfyFw+79p5dfmvt/tfTsym//tpxXTV5/WomlOCPRUIu5qDgRAI9W
        e78fAgAA
X-CMS-MailID: 20180514114312epcas1p19fffd35baae3018f47df0fe31ca1b1b0
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180514114312epcas1p19fffd35baae3018f47df0fe31ca1b1b0
X-RootMTR: 20180514114312epcas1p19fffd35baae3018f47df0fe31ca1b1b0
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114312epcas1p19fffd35baae3018f47df0fe31ca1b1b0@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments about ADC code values are incorrect. Fix them.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index c12211e..85ba9dc 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -46,7 +46,7 @@
 
 /*
  * Temperature values in milli degree celsius
- * ADC code values from 530 to 923
+ * ADC code values from 0 to 127
  */
 static const int
 omap4430_adc_to_temp[OMAP4430_ADC_END_VALUE - OMAP4430_ADC_START_VALUE + 1] = {
@@ -136,7 +136,7 @@
 
 /*
  * Temperature values in milli degree celsius
- * ADC code values from 530 to 923
+ * ADC code values from 530 to 932
  */
 static const int
 omap4460_adc_to_temp[OMAP4460_ADC_END_VALUE - OMAP4460_ADC_START_VALUE + 1] = {
-- 
1.9.1
