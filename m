Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965816AbeEITqS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:46:18 -0400
Received: from mail-ve1eur01on0113.outbound.protection.outlook.com ([104.47.1.113]:64783
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965181AbeEITqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:46:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: hix5hd2: remove some dead code
Date: Wed,  9 May 2018 21:46:03 +0200
Message-Id: <20180509194603.28986-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0206.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::30) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:MdhHSVmqY+inIqIwAhr9Y0TfJYmrKhOExrqXnWmoVS//pylPH2Hzs0G5VAvQ64/CmOZAjWxReh5dcHW5do32aQ0QvAzvp26EU/3tEhtJWHjGQ7tx80+G1QqYnPmpEg5SwXq+bXNUSJl2AdbqePDK2wk3zwObpbcYID5ETdpTxeOIhiV0LOGmJdoC602TXUwmQPmPpumc+rdslcVEJldDB4HhAOTaGzWhvUYDpAHTHhptgSWjJAi3HqJ1tY1Lj5sp;25:YpaHYE+hENtBz7zCzqI5rEWSkJPok3JRhwjP3NMBWMWXetQB+65FfgCu6CkuHs9FB5h0909JuItLp93YEEbEAkfa6pDCk6Wmedn2WlCw5BZoTxXGNdCRGPjQusUPDpv1Dx5EiDP6Rq6J9N21JX5po4iDKUpG+cJQ+ctm1ELiItDNgfrN0f5S4resl946ESGhpaJlQkia5xOtaB2hCSNmDeAd9kRtQX8S72XQ7+mOcCVokX/209QmaBQSGdkNU1VXRsyLypbhe3ENHXgqaPCd7aofDYuojxTFeLZMoS2ECJI4z87nQ9y5hHMXNPLHTCqzAPVsnw3LFfI7qDvmGo3DOA==;31:UFdNtTnhg/ih8hW6j4liuksMFy+6/B86ONutnQXhT8HyLQeqFbBpu6YX8wQgb6W7+uhueHq5tNkS0etT2v585TwZrbyCoSqdv15xwRGf5KbFNn2duV5T7Ujqy6q/N3NGOLR7za0E/1N6SX9kRd+9WS2v1zCw/M6v1mpVct9YfSwBtLz2GTKpt25I4hKtVCzQ+puzrB1UEpKmrYNAidOj+jCQSdcaNeFEWC3cP8wd2G4=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B50A8937503EC7BB1C72BC990@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:PNX0/FPRxH4sU06v62ZEk5UZtycUGzIW2tvn0Q42k0aGzbXdkBz2OGSyaHOBi3KYclsaoxkz1qYKjpp4LlsaZwGSZy4gu0iyRiBNrbDj53lpFNjYGV+aKfaWPZg3JtL3sd7JYSoCjvlcuac3tYNZgofLxnKkzHnyizG2Io6k1A0/5t+iGH8mq0MhgeNakGpKWP+qmnq6jVbPwlXQFfGvMPKfVKoqknAu15crikbjgP2bBOIoIfF8CS9cXN3VwXuPAk8agNgY7zRTObeG+aK1yQ==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(366004)(376002)(39840400004)(199004)(189003)(26005)(2361001)(956004)(1857600001)(16586007)(86362001)(2351001)(68736007)(106356001)(386003)(478600001)(6916009)(25786009)(66066001)(2616005)(50466002)(2906002)(316002)(54906003)(36756003)(1076002)(6506007)(3846002)(6116002)(4326008)(48376002)(105586002)(6666003)(59450400001)(97736004)(47776003)(8676002)(50226002)(186003)(7736002)(16526019)(53936002)(81166006)(81156014)(51416003)(5660300001)(52116002)(476003)(74482002)(6512007)(305945005)(6486002)(486006)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:lebJ1M9M7YX5a2Tk9xMF6FoLHLS2I2MS0bCEjO5?=
 =?us-ascii?Q?8hMbPtGhS0zuXe0mIQsVJbfJ8UdEGJGgQ+UcXItJhMJY4up/IbARgBaw3n7A?=
 =?us-ascii?Q?DVIIek+3S/l6Me3BUE+BPiAAHUAfdKLk2ofZvxzuVkCZJYpB+nHN/w9odXtD?=
 =?us-ascii?Q?/DE918h8lwP0UFGAX9YRtWuNNJWei20vw603if82HDEhsdfr8sJjdUv+aIQ1?=
 =?us-ascii?Q?JiD8iVu2VKCzS5evEYkrzfOM8T3xU6pIm5Ls+2kgS3R+5roHkGv51RijyvLo?=
 =?us-ascii?Q?XxpIhyvu1BkXNxCG63P/avn52vyyWcvpCloRg22jMt5NR1ItA7MKgrSSIut3?=
 =?us-ascii?Q?9+IC9kiwN7gD1tLLy1nvR4X33W0YHQslaO9ULxnoYBl8QDrLbCOTBjcRx0+h?=
 =?us-ascii?Q?d5PzoofRiN71VdO/rBCRnpqeegbvyxVT/ZxjTjlgpbELh21/SoLBbr5X8Pjx?=
 =?us-ascii?Q?udEWXcRn2mDAdc7DB0QqCKhwoB+ckULe4HhPj2nzYHXKB9k2VQ3WG2O6xFLw?=
 =?us-ascii?Q?QnVS8rY6ELeyBE1QgVKB3TYsagDeXC0GUXay7zEbMnp+vbOImvrMyUYL/Y6s?=
 =?us-ascii?Q?yC575fZCCiWudZh3ajtevLn4JqYzYQYZilx712JV+Q05cnLkAF923fCji62F?=
 =?us-ascii?Q?I3pPZiTHVulxBQL2j5SH/r8cb0iXiiMOsjTmXbh9oGop+dc90b113uaDJAdZ?=
 =?us-ascii?Q?SS4HMi6nPsU6Iboo2S0pyG4dY4dNLY0isQMzkURFffMgSe592TSuLe5GECyR?=
 =?us-ascii?Q?WzgrFrHErMS1WLOvLdhiukuGYw+P5NVKhjJFYZbsBsxxqRNYW9+X+BlXHY7q?=
 =?us-ascii?Q?QA5hi4NdgqVa4Lt2KOxrgjCh1Otc1clc8uAth0o4f9tLQ4yXZBxvT/QHLgkO?=
 =?us-ascii?Q?j0HhuGmBuQ++wgRupOC7jsTjOLa2l04sO+rOTUh5+jILWu5YpktLxIXeaTiD?=
 =?us-ascii?Q?+VQiylZJiVtxXKwb5KqFA2v0xeZF7KX9znfo6XGjY4jQ1T+0ZsgxxWJRAxzy?=
 =?us-ascii?Q?zlQQW3c8saSfN9xAw+7cui9wmm+MxBV7o9jMyZWYnlpe4tS+miMdHW3qmcgK?=
 =?us-ascii?Q?MnGXAgdQLCHitssVE38Ns/5rS+K8bNjbisnKr0Qdmb5teBlGy2kyoQRDs6cv?=
 =?us-ascii?Q?tZLScXdJ0szMvl8MYHgJGyPDRz+V02DRsnJtV0XV5dDcP+9FdaT61ttaVPu8?=
 =?us-ascii?Q?oOPEdrY/QYU5Ao1/bl2Hxbx4KNkttJM/VwhYDdo5lvtY+vFILVjdYTBkqxm6?=
 =?us-ascii?Q?zKDicmwOgg8+lzfgaUqMzbiW7Wiq1WBY7Sey9PXSHzZuhqUvjtEr3WfYP6Ou?=
 =?us-ascii?Q?bkQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: gnJWp7TsNOCnpo61CvueA9DJx0oFLYCbNgwaB5eLaMzwFHXaVwbqcDF1vhYFTP8NZbWrfBMWFWugeqVCJkrZ2q26bmIib+AcvEzgloz0/OdV4iQ4sxPCh+pRwUD+vC7nZkPfWaMSDVJvgmYqDLXjpOhWy6uf1UuoostajUDPZHSv1fiKP6A5EzviAzlBBX9k
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:pJgnaOfHIlNGZiCS4eaEDqvAdqDRQ/8gAfvwiEPOasC45FdBDfq2f4MzrZcYaVpNyPmXAueWbxj8Iw7sWy2OAYBE5hDSeDrplt008JhgYB/yijDpXEs3eP3qEPzKaRG5X54KAyJ/2xPGRfaJ9sU0cwsOpXnlqNtCOjwgtZJda/rOCfzEeLiTX6HYFFidA8yN2qy18cOQ1/3S/9bycK7tLnG9fBolnM5VxQt0TI6mISFFQaBU0t9zeGiSbggDMdjE4cOzYo/iWmKuvUZ9k0rqkYIsohqYWl8gR9NWDsRsQes7dJTHPEN2+b7oAwe1VQrwQDA/00ICvOO+UYXTc6Tp5dE9pwTw7ZLMvP5f+zCCh739nqV9X8fr8Cg0wV5Nr8TsBpoAmC08BMw86VVEfuBiglMOMuiSKONzEBn3sHOXzs6jH6lt50/OW71wWa3zKsCt4/37iAYPgPQL5yndi3YF5A==;5:USN6pce6EA+Di+lX9jSQpw4t/fTirXI00I0VSJ5u7v/ZZNDNhuJpfnH66Cvw0zIgG0bDW85faWp5mWxZFPYZupDAfiuq1OMhVTX8pX5D78lqCvfTkfkpwB2GMF3J9aPRqR3Lc3DNLPz3iUa/u8r/hNAWSJWZd/8SSp+OOHvHdgU=;24:J4NYvyWp477xusr2PsleKAe9eLer0nuPd/3EnoP9H7JMtIrYr1Sc90l57ZVz5cIiKGdsvi9HI8KzBq4M78cK0La5MguHWFxmfgD6jNsO9+4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:TmxzMFehh7yt2FhfwbOC56DfGzels+++ShBQWiVINx6iWCwtHXK6INFMkbumyWapAMDn3QG2pzh+Nlae9h0QKx6HaIshrNTGelkLzMOu2zTlnc/xD6UwxBIBgHytY89zk7V9e4HhZuxfV6zHdwrdG5dyeFqkT8AuzjCFJSidQpL6hDND5oM18IoG0VQjca81v5waRuPGy/938+jmiPtxZk7g959uquL/cGdR6njQp5QtyT/0t3vs+3GgvJFejsqA
X-MS-Office365-Filtering-Correlation-Id: 13250bb9-a3d2-4cfd-870f-08d5b5e58532
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:46:12.4768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13250bb9-a3d2-4cfd-870f-08d5b5e58532
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The else branch cannot be taken as i will always equal num.
Get rid of the whole construct.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index bb68957d3da5..190b250e6834 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -377,17 +377,7 @@ static int hix5hd2_i2c_xfer(struct i2c_adapter *adap,
 			goto out;
 	}
 
-	if (i == num) {
-		ret = num;
-	} else {
-		/* Only one message, cannot access the device */
-		if (i == 1)
-			ret = -EREMOTEIO;
-		else
-			ret = i;
-
-		dev_warn(priv->dev, "xfer message failed\n");
-	}
+	ret = num;
 
 out:
 	pm_runtime_mark_last_busy(priv->dev);
-- 
2.11.0
