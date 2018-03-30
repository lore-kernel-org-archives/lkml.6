Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeC3N4e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:56:34 -0400
Received: from mail-bn3nam01on0064.outbound.protection.outlook.com ([104.47.33.64]:36352
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751259AbeC3N4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:56:31 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/3] iio:dac:ad5686: Style fixes no functional changes
Date: Fri, 30 Mar 2018 16:55:17 +0300
Message-ID: <1522418118-11810-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(39380400002)(346002)(2980300002)(438002)(199004)(189003)(51416003)(47776003)(5660300001)(2906002)(8676002)(36756003)(246002)(26005)(77096007)(107886003)(186003)(305945005)(486005)(16586007)(478600001)(476003)(8666007)(486005)(7636002)(54906003)(426003)(316002)(356003)(2616005)(48376002)(50466002)(8936002)(6666003)(126002)(336012)(50226002)(49486002)(2201001)(72206003)(4326008)(106002)(106466001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB399;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD021;1:MHbsFmNdDau5L24UveXsleV6SuRcvmJpZ6BUZSAoeRc42xxfTILzskmKlY+cYNteVT1ODSaBvYJxvALW9zrZIlh1Em0oJ5QWLM8xhHyAGbRLa6gccAWe/efvHEDnL+Ll
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2a66ce-dcb7-408f-d1a6-08d59646085b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR03MB399;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;3:YAbCtrR5QYOLZXUL0YHvgfj3OYXmENf2to67W0yc89BykVm6Qzxec4Fy83Jydf8CY5hu9ik87RjlgQaWuJd3HhmDSJRfspRxe78LRbu45COkK/BCEWE1cOyroQJdqzl4UlMUBkHkFR4GkwOQGVCCbFmOVrFdZJldZfmR2fk6Xs9XCHDxXDFEcokf7xRcoGofuetFJ16OiW1sTnYEnJ+9zctYRO/Za5tBycV9JXWvfjwmMoOd3us+IGb/935ZitdLFVMb39ynbi9rM2qWCzApZiTOuiCYXJW/N+HXmNIH5sQRDrfAHanogkEvX2LE7mhTw7XFgtU1JjRt62kR7HgHNxKosQNKwr/VpWsIn6sgXnM=;25:IkOGHkzZ49Rl3H6UzKW7tcLeAeya+uuVF3tQhIKiXegn9c7RKs8s6A/O/H1J4h0+T6q5bFMkbSqVun85Xk3kEPgV8IS2bDBm0Je/Ld6Ekc0OCXcYn0DAzWUgXoyGIKKosgJjiKQGqKAl73KGg9uCqPi4nDJIRZa2tH9zYu/bEOFkxQqp9dXwmUDBnJazCREKv8YC4wYvmB+cxIa4ARDfCXhN+Y4quliGNkk6BWLUwAlKSg12ZUEGYlae5UwqSRk6AKBGPmbp/63q8pqj+2+OKllaKlU9O+dUq/VQsVVMiKCK0LtNEeJKsGJXiDBG+Q9IZZWjJ6fqRQLDAqFGu0sbjg==
X-MS-TrafficTypeDiagnostic: DM2PR03MB399:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;31:yT7MhWx4RamiTr0t3PhCmElvpfrxgKodwJc93645lNN1ApHmelvtjPdMqj/G/D1Z7VZsQMnXb/TyUb452m5qTVo4eXVkZ/ra2UY0dMKcyegvAp1/wtWZGcjlL3PNUDCGFNdRzxCAwoDx4ACdC0zX0/ZJaggM9PIZPNKMtNeIWkvph7d8nIjbNNsc2fY9WwHt/5F3oNIz2JmK2xTbdZDp4wOTHRUV60SoHVZR0PH0vX8=;20:EpKUZ4+I+mvF6/NG0Wb3T4vw38fUcqmtBBsTuuMBYsQWKJ3EJYhSze6oGtOPLQIUedODAM/YNZUbaDgOjInP121llBJsBblKKeRYyCqkjdTXJQS6A/tuL5eDCvwojhUWEwG9I0763P6jjQ1DjBRztaLe2G4dr36rILqKDzeuaPPR3GjsG7FPCj91H7MqDYGSH3qujtNKOGfWh5Ud1U0M46tWwe27QNlySZq01TXqP+O5DrpOWx48jiAPjEKEYqqWm8ZRKLee7l0TBgczwnYTGewxWQoeRC5W5eAc66AclkaL+UyZ/q2saqKOkQLxGgBe2n4hbszD8KGbZXETIQfVP0VghYpXWOy2c0Ytdi5pv26y7Fuaz8nGyOc+S7ZQCbZCzVy/Cjq7vKm4kt+CBQUr2k1soN0Wx/JRlVhYFGruzfBIqcEODmCu3tCOR7R/D3XzEDAfW++4q0fjoAVRUaRGeUFbYz0blVosb7abkXxOVYNWEPzaKA5vaGTfOQ3HCRNB
X-Microsoft-Antispam-PRVS: <DM2PR03MB399155265736AF26076BFC69DA10@DM2PR03MB399.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR03MB399;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB399;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;4:GAwYnuXlkqgZ7Gio8RY+ysonIPbKIX8MNcryvWShE9bK7lqYjoO6czxN93GTdt6p4t/djeEe1Zj4sUkj+p2bY3Ozqq2B7DocN4GbgtxeRT8XaVbJYsQHmiFpHPU4KA2zY7PQwgo1yNgee0eDN8rlGv/riiNUfMr0YT4BcPrIw+qsdF/p8pTfjhki7TTMunJiqhfa4+ARGCJ1LpbzR1HoJ5sjruWVBm7E8smKsXwI7n8xxBlu0ImkLtf9DZt34QUvLlGDJrfr1/JwR6FYPYdnXq9YKmrtus35X9R0CoR03d2A2WtzHC3VmseHeiMmb+dC
X-Forefront-PRVS: 06274D1C43
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB399;23:AK6wSoN+dQomd3wh9Csdq8aKJHK/qYJHuubZNlNjOy?=
 =?us-ascii?Q?lTrlpn35Tzfjy8W5WV4IpBT6HNsUwOiY97RmVekBO0DIiVdejf+7p1CAZ0tK?=
 =?us-ascii?Q?2jmf4BR3sIm2AQc0YDBWzgI9mgh3mgrIXnqzKi7lrQfb/WXRIwhMZ4ev8iRu?=
 =?us-ascii?Q?Pj+hSxPrR3Gv3AEnJKM/216OcE8R/Fnc6rXDlnCDRxReb+Rcb8qDiZQ10Ptk?=
 =?us-ascii?Q?sWmwSnEu9Ryc1iGCp05/RTXn+CCRGR9mXCxxeNZY8QhEsGj3LtAJAYh8ggFi?=
 =?us-ascii?Q?DVNr/fCNEZcxgI0MXrCXR8ETio37gE56ENYodqd1SNYUY8eak4M0oaeV1eBj?=
 =?us-ascii?Q?4Ib2ISS+KfqdijTmE3TBUkkFzepYGKGt1+IK3Uq81CnGR/BLmJQExAUwjhh3?=
 =?us-ascii?Q?x5df9jD309UfSQ7k+IS1tg37K5VrrmsWSj9w7xdsgYsEgH+OxVPO2vn72nJe?=
 =?us-ascii?Q?yaKDK3R1vU9UpFDwu0Sh2XB1zOJA6SvJlChyZ+wqK5lVs2EzWzKa9KHgIyvY?=
 =?us-ascii?Q?3mF83I9zgiMuxXZC4JA4naSQKUxMfisCzSTD6e+v7hqNIhCLx61NW6OjPope?=
 =?us-ascii?Q?7pOf8UOtUkY2IyuxybOBhJ6x3xU6OtuW47sSZPZJJF2CQSBfeFS9OdNT54pi?=
 =?us-ascii?Q?L8F++vZ13ejcO5OT0QpZYg3Bn1hXVm3rytIpO4Qf9ZOMz2nWAdwb7ZsxPxSR?=
 =?us-ascii?Q?wbVB+8cW3AgGMITH/+ukzg6tKFuAaYe/LQ2XoDvSObTCQLKAp5V04oN5ZGlS?=
 =?us-ascii?Q?QgxFq1nSWShg1mEeSkS9YhWsOJ3KWRu+2wDnxjLzzZMTSN9wscRLslv2nDcC?=
 =?us-ascii?Q?gO0BN1eawbk4oK8Tq2sqp+UT4fFg2H2bWCWl0bxfoBozaoHsvvK3VB7dDEsp?=
 =?us-ascii?Q?AvIaWUWlaOCk4vEnQYUIMVornL8HzKf/p9Z7ZI+E4J0ADVjEmS0e7gSum8lM?=
 =?us-ascii?Q?8z762mkOW0E63JwCfey85ZCpevM69O+br/97bbCSV6QprzsycK5v3x6gLOx3?=
 =?us-ascii?Q?5pEudErP91dbQ7FCXTT5Qj2I0LxDhco0O0oC6hh7ls66rKm/6MBpbGqbeqx6?=
 =?us-ascii?Q?bOfOo=3D?=
X-Microsoft-Antispam-Message-Info: 8DcReTy1mNBUtHR2KjMIqrdfWmGuKiqwum7gFJ7evQdosg9vBDJfusD7Nm7P/ssoiT65oCbmOvp+b7r1o07Cp6EoaBDEs3wd/Z0HDi5ENOpYFwbalFm2S2nPW+nGXxsGqABpQuQ3UJxbuEF0wxuf07npcPf9inmhqxrneLvVgTj3I8MaMBReUC5zZWU+I2yW
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;6:ocNrFLpAGgEgaN3RlEteENaT1WFUUxkKWg3GW+PeXEVpOxDd+7N+rJk/DNHHz3t7VDrbuWyRKr+qvPLi4SdIthEsUgeuUFbcFOOtIyDJfBeIMJQyVl3Ai6lTDbeMEqLB/9UH8rPh3/mWbYexcyP3squ489lSWXd/dTah8nAgl8UBbD85R47Cww4Bk9IM2YHQYWCHdpUrfxlZ3NoOTeATFbBuF2BwO5fYN9sy64ZtIX+jGZ/CttjyJlJBNrsIV0WJPqi+07/SYSToiZLWTepWpy6GRkPi0jvLFzfYo1kfJVNXHJp17t7cXisrp3HqLv9yeIaJMcNFWy8sG7JBvEfH7mAsvkgBo8+q3L/Kil52jf5jHKKBSKoHL6PfVkMFnAWoxZ+mD1xkbE5W9MZBrz4DcELMoBh7gJYaYtVQvu+jXNp0a4uVOUVXCCSRoTHTkKSBdq5lG/iLXUVrilRgU0Jgwg==;5:Ezn9e+2meIywMab1Uq343mLXS4DUrbU6PJWjE5FV+egkglD6SebXl49efVpevjIxe83tlz+HvOAPpjBglM56zlHIUFEtD5VAdDKaI4mKixWJ2fi4D7CI59lLBZ6hc+qFLbYi5u3dl4KUXHfiTFLQ/GRvvXEn6/2+fU80syhy8QI=;24:KGnUiMPkeJoEbM3Mda9MB948b3jXzn2+8nIdt0GuRfT8gqxueEJupuEGlx7q3nuNZq0J/TqdzRNB8zrdnaOpiPIqX/bALTy0lka1H46fjCc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB399;7:EBqARFQgvEbhHHMiBYafjNPO1Jubcj1Iq7ZSE2oHucYvledrelF02kcg79qkwdR6AmkiYNK0/izKM80COtSdCuDXjYYUCuRCl7X8biQP+4pb4SALmeCMP66Hq3qXKhV0MjAUXm1PsYnF1iGXj4mNBW/veGXZ/i0a6UkejKbWuu0Dyo/0nknt41fjlvGCu5UpdIVMplJmxX9TlHSkhAredvHMg+gjoT2QF4KDTNslCazbmS6/chbnxE/HXKhG6SeA
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 13:56:27.3813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2a66ce-dcb7-408f-d1a6-08d59646085b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB399
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some indentation issues and does not modify the
functionality of the driver.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/dac/ad5686.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 20254df..f7f975c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -24,7 +24,7 @@
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
-#define AD5686_ADDR_DAC(chan)		(0x1 << (chan))
+#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
 #define AD5686_ADDR_ALL_DAC			0xF
 
 #define AD5686_CMD_NOOP				0x0
@@ -137,7 +137,7 @@ static const char * const ad5686_powerdown_modes[] = {
 };
 
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
+				     const struct iio_chan_spec *chan)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
@@ -145,7 +145,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int mode)
+				     const struct iio_chan_spec *chan,
+				     unsigned int mode)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
@@ -163,17 +164,19 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 };
 
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
-			(0x3 << (chan->channel * 2))));
+				       (0x3 << (chan->channel * 2))));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
-	 size_t len)
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  const char *buf,
+					  size_t len)
 {
 	bool readin;
 	int ret;
@@ -221,10 +224,10 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 }
 
 static int ad5686_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 	int ret;
-- 
2.7.4
