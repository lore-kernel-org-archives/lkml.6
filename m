Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeCQHAW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 03:00:22 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:6130
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751529AbeCQHAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 03:00:16 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: <yibin.gong@nxp.com>, <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] regulator: pfuze100: update voltage setting for pfuze3000 sw1a
Date: Sat, 17 Mar 2018 14:57:08 +0800
Message-ID: <1521269828-8874-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131657436144555065;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39380400002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(81156014)(106466001)(105606002)(53936002)(47776003)(2950100002)(6306002)(76176011)(51416003)(16586007)(72206003)(110136005)(50466002)(966005)(316002)(26826003)(336012)(2201001)(7110500001)(86362001)(356003)(54906003)(97736004)(81166006)(68736007)(10710500007)(59450400001)(2906002)(50226002)(8676002)(305945005)(104016004)(2420400007)(8936002)(15650500001)(498600001)(4326008)(48376002)(6346003)(26005)(77096007)(5660300001)(450100002)(36756003)(32563001)(2101003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3168;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD015;1:Cd5Z/vvENY6Re64SKKn97Wl6T9tiHGEC9JGe+OE1lKLJB6g46HDKx5/YquOwbtoG4kDM/uqvnLaHeUGj2l6hDZ3ot4ov+uE0oXw6jTWWf8Qfc9D9FMWs99cH6r+5Wy8e
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32ca3096-6ac8-42ab-f2d8-08d58bd4bbe3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:MWHPR03MB3168;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3168;3:KBeydful7FIxwsbmVE1S1SI9FAahDDT/kj5XLRMC08wd80HaLX2Bv758A5GwmrzmXGwQd1fPYSnMG9lgmM/mBfK+ZgcecSnrhZ7Cn5p+JlrJGyQj5Cjx6WMoildri5QpkFG0tlkEPro+g210B2O0snuYrAp9miy0Sg0j8+3Cv1XjQk+RQ+wWtulzGBxqFIpKariNZduLbtKTPHqDJIwjcaDmCyVVNSljSqF/ruFfzZuVM4xFgX3Y5yRgxhMpWKLRdD9KB7GeIMqtBEfR50/a0ax5llFQc6WgUS3UGgXeL9mTyj7XgAOqWRSRpytJPuJrVvgf/R6+ezFB8iNxaymcjFDWke8sqNYKRQMLsDgfY1I=;25:XsqWL9q61BAqmAlCWdT5ZooSmIS1yCFXkNx6KYHM3i52Yy3eHeefW+RXSUjDzn/qHT/1I1g76qXAnqxj5KfrrRlEiv5MBL7LEDUQ+6+t5etaPJ/j+YsCvd0JqxOYHAxrhbHtOfEkbuxamRrPpBh4QndDNRx69ctOgCDJh2xnSaHidnZCcKaxB6clPAmlH7YTI2zyhg9e7Jeznde6/pq3O+K7118nfUyHhGvJ0ipZicZfstSJZPYEZkC0RGi3pyGirIavJzzbCWNAGkcsqszrhsB3aUvW/VSD9j62oLh7Uh4Hq9C3DSR1a/LrwpMXkmsKyULpzi0CCtHksLGZXPg7BA==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3168:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3168;31:vqJkz8Qxselsd0s0SsN19xGLlDd9Mwgqn/J2AFmcFDK39PJgQNxDS2lNKxlJ6kuS0veDn1S0zWsHRIjfnGpUg1OZ6CmvC3M1PY2nTKMJbV8ROhZfy3lnY0TfYUNipn37AkuY5nxNQTqdEvzy2HCi2hXFvC8QH16BnAE513UfRphHF556twbrhADtGbkOT/Z8lfbYC1n5+oawLOR769QewcOglvi3x1XmqZBFKPwhrHY=;4:fY+G31+qyA4iUYNb1pnmGw4a5gUpMagwrXyYhnQHJ8iA0xQDeNv6M94w0Sk1/11daM7Dhqg+LTyhKx9j1tza2S/2q6nMaHlV8T1HJtZmMDV74TXO+A3/eoQ22DGQ3fag0wmBWNZynSiQnhu6xJAdxJgqPICMRxzFhrtAE+5cpEKbRIJGjqvtLkEdFwLKoPwCZhwFr59l+5cyukc5ny8i2pUgiNnh26+fpz2kX0HJKOZ1Km88D7fQo9y/4ZjBZ+/1j4wYPsT1EZOs3s+Ddx7IehofPJWWW4aYNVP5tGAk9ESxq3B9pqBsRmQp7+rvBjG40BiyerBpt0NNoneuGN/Ga63ckunFwzAgvPQeYb4gVDM=
X-Microsoft-Antispam-PRVS: <MWHPR03MB316873B31F2E75E8B3E0E7D5F5D60@MWHPR03MB3168.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501295)(52105095)(93006095)(93001095)(3002001)(6055026)(6096035)(20161123559100)(20161123556025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123561025)(201708071742011);SRVR:MWHPR03MB3168;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR03MB3168;
X-Forefront-PRVS: 06141B80DC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3168;23:huMTP6X0+dPGmXysV/LC7KoCbNNH5k632kh0qctBd?=
 =?us-ascii?Q?ZBa/Iwyi+N9VPVhPe9MWU4Ka0t/qJv755/VC0rJva1EutsyMtDIS/faOwv9i?=
 =?us-ascii?Q?csGQK7WNmc0s4mCV/ZNBRb5OkPjFp/BbKGYc6fe7sEmTi6xhfErqyhEbWyJR?=
 =?us-ascii?Q?X5M/nIKLs0CBt+3pfVm/TQcqCjCTJNj+KJsZlzga8F/l9uxRDDQusMlrzQ9m?=
 =?us-ascii?Q?esHlHoHN0ooWo8P9ORgq2Z4yowckPsN13/QJ/O3CUG5lvRgP0nlwBZo4eUEv?=
 =?us-ascii?Q?tQ9H8ZJdQNZi96UyBaEogRHylgpQn/X0PIUfdjBJvBZiZe2Ih85El8eiKiXy?=
 =?us-ascii?Q?ITubT5GqBh5cdcHUQ2Sg7XE0VImyRa/YhtzRbkuN64OdlW3Sbyl2uCPQ3ydM?=
 =?us-ascii?Q?9cxlH9gpfYHJgsKgeCYGpWxMVqPwgxigoze8bcG399tygfCqHo/PGdOvn3vZ?=
 =?us-ascii?Q?heLDiPEUU3EWKijOYGDbHu1OM2NDDYxVWcGDRFym/iFNAbLwPG793+tgEuoL?=
 =?us-ascii?Q?0W9ee5lyUXuIxq/nSRYCyTiyqcJAB6Tv/Op0uEDyKCcw7tpeiliEKhLev7mW?=
 =?us-ascii?Q?rUbmTgB4A/QoI0NejbStWbCcaKgEaviqBc10ALDyX2UNxpYXlsWXOdiI5RBi?=
 =?us-ascii?Q?4TjPlghX8mwWaF5+14n9bLzvM9hqHIdqTgb/rNj5RHyghQj7SKGczT3nfQdw?=
 =?us-ascii?Q?T9zr5NJ04EzwWfJ7DruVO/xWZcZJxDdbZyd+Z546EoUAtHIqRmrUW5Swmr2i?=
 =?us-ascii?Q?ckWs+4Zxs5vKWCOcQTe3TzBKGuAl13iZiHZ5vSXeG3USl7Kf+dbaA13bMw0Z?=
 =?us-ascii?Q?t0MMLwllbb/EZz0vwcGp1HQNU20Th1luWqrYmIW8A02pOJmwPEWRVV7YOkt9?=
 =?us-ascii?Q?gKB2r+Y+JZl3gWGP+f7AjAWC+m6EqPzj3f6YaqOk7ALvu4+j/mHujpe+RiCg?=
 =?us-ascii?Q?oW8ji0j5M/fNBeXliAjIiBhfIeUf2u6SNsHJnmz08ob94vJWxZHi25BOUDqA?=
 =?us-ascii?Q?vMBeS4C+GSzKZIe7CB5XtezScy6sKGni/9vG2qu3BIWFYHww7qMCG6r1Efah?=
 =?us-ascii?Q?bEVMuwT5PK4mKYu4AZb2n1O+JN7J6t+bvHuolfZtZwoq4WUzZOv/Mp/cPbGM?=
 =?us-ascii?Q?9W9lCHO6leFCz1d342gT0YBl9kmFwRZGHft/8Bi6VUl+jrYJnmcN94JWBJLP?=
 =?us-ascii?Q?KyuQTO28eQ0eyUBEPUqmAOCPTgQHOSIezo2tk62eO0fQ9jDMqTPOooFDAVgR?=
 =?us-ascii?Q?HcT/3eHrd0C/GrnEdkDermRdEPnE73Eg9vIW5a0En1JX8emW/TvCzd6Bpq16?=
 =?us-ascii?Q?TonKWhCAABX4hEpyGGUZU5cBl/5MYidQbbRKCk0IlP6wht8INx1Hf8GpIJeH?=
 =?us-ascii?Q?UCP5Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: ximuma1dVHeS242BSnpuuYEFJHVZRr8qfT31gvBzzQXNflfvoa/raaBNeUk4OSQYbOVoFcu4MBCKU6+XeZTzgoHJt+43gkDSu60+a98+xjaQhheA4/h5U1rLUyfzix5IL1t7iH4N347rVzjdYT7rsyeYIY0j0aIaHHxZd1ALG5tm5q1T2pJIkKUfTC6cH9ks
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3168;6:V/zBUziviYbS4JlyfI1E3GIgKeEXHxtcNaZHEHJsfUUuCvWW5rAp3BdqHD3YHL0v44dLcbNV99ver5Sg37NwwbS0yVO1mFXrL47+bFgeEAaA/EWGGQq45z8DveWsw8KllbzsxAvLWBRmAjlAbxSJ7PqncDKhKyKooIgznk3eG2ueqdDfqAzP72B/F+3jIHPfjgas7qcU782YL1b2+QyUSWhZklY3SlTokp8+lIQNBa3UEOkh0xUWgplXJriHFvkwXFDh8gEDSjWDlce5BmhMOE7HYOM67nXYPVMkie3n1YR58ANcBF2CuWkh2qRB6ZnestGlX/fJXlBWb7ozr7OFNxd30Vh9poXPaH3v+heo9RM=;5:YvHetkL2CqkKqglpW96P9WipM1cjbEWfLFzIzAfEndZhzllRLTeh7ybWHSlH9hXU5E0ykVViBGvkSgxbYdqYfGS659XO8+wmaH9QpOz/e5rbIREyVvSWus96mMRNT4L5V3TvjqlX3JNSR55bFM3/mDtWc0I+3bRMjri2gglWq3Y=;24:P93/UEIMdRU6ZJVOGCBtoj3d7B+VGGCLsIMqhUEhD7iQCAVkIUkK2F1h1Ll0pxwI6zlsLprUKcilAymG+Nym2KKPv+Vqajgsr6W0FUicCAM=;7:7prfstiPry2uCoL7bliC5vzHTneCMT2IidpGnTbDTAmvJEslbi+vJbh1xmzcL9lSdYfZfHR70Yyz4P1pB7PFBdw7yJUWdmh6s5jsGPiwYCVeeT/7/M2gxplTZBiu85Za0d4SwklLdKln0W4P42pA/FHg11vK0Nv2nPq8zXMcC0gZXUG6LfiW+fCFjraGcbxXMMpd8FUO0MCNneMYkA4pcvVQF5XEUz3Vzv7dKJIgnKCQJL17bkkUvBm1J1FeyUGE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2018 07:00:14.2839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ca3096-6ac8-42ab-f2d8-08d58bd4bbe3
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest pfuze3000 datasheet from:

http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1

updates sw1a's voltage range, the settings for 1.450V and 1.475V
are replaced with 1.8V and 3.3V:

5b'11110 1.450 (SW1B), 1.8 (SW1A/SW1AB)
5b'11111 1.475 (SW1B), 3.3 (SW1A/SW1AB)

the voltage calculation using steps is NOT available for sw1a now,
use voltage table instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/regulator/pfuze100-regulator.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 63922a2..680f076 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -86,6 +86,13 @@ static const int pfuze100_coin[] = {
 	2500000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
 };
 
+static const int pfuze3000_sw1a[] = {
+	700000, 725000, 750000, 775000, 800000, 825000, 850000, 875000,
+	900000, 925000, 950000, 975000, 1000000, 1025000, 1050000, 1075000,
+	1100000, 1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000,
+	1300000, 1325000, 1350000, 1375000, 1400000, 1425000, 1800000, 3300000,
+};
+
 static const int pfuze3000_sw2lo[] = {
 	1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000,
 };
@@ -343,7 +350,7 @@ static struct pfuze_regulator pfuze200_regulators[] = {
 };
 
 static struct pfuze_regulator pfuze3000_regulators[] = {
-	PFUZE100_SW_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 700000, 1475000, 25000),
+	PFUZE100_SWB_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
 	PFUZE100_SW_REG(PFUZE3000, SW1B, PFUZE100_SW1CVOL, 700000, 1475000, 25000),
 	PFUZE100_SWB_REG(PFUZE3000, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
 	PFUZE3000_SW3_REG(PFUZE3000, SW3, PFUZE100_SW3AVOL, 900000, 1650000, 50000),
-- 
2.7.4
