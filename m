Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965803AbeEITpx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:45:53 -0400
Received: from mail-eopbgr50104.outbound.protection.outlook.com ([40.107.5.104]:42160
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965398AbeEITpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:45:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Andrzej Hajda <a.hajda@samsung.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] i2c: exynos5: remove pointless initializers
Date: Wed,  9 May 2018 21:45:32 +0200
Message-Id: <20180509194532.28929-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180509194532.28929-1-peda@axentia.se>
References: <20180509194532.28929-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0197.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::21) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:80sEi6flAhWVnjGzFAO6weTOGHndUF18nECZrpYJFtMXx/3twKFwKLpOMonk+bg5MYjWYos83bDh447I1i20pvKzoGzw/H9Su/IPAG8fxsx0XZdSJeePqb5LGYby8+z6hwRAg0Hj2U9tQPmVBqaqGiOwO9zJwZTpiP5av4coVlSB924T0++iVj57TwQb9Cx1oNtOfwOv/jFW3nCi3HGVmhkL6c1BgjAOIdB8IJRerPCfy6NToiHBVIYoB5+0D2L9;25:JP8D6zPv0DEhhw1cVtaMqXYXro8SftOaOToYXHGFVMXWuy8l9TePbT7RiaEywY+kQ5pk3MzohVRTNzsV5O0wKvL+SoXXcC/njiofUDFBfVDHWha//pHlZS9MUhUof+oVsxms9SbTbyYlcOUUC5/+jY4+ahGIDLKomTcQcGhfu1+OS+y1RD/MNQMD78TrdQf3q0stwcBjr8ZXqegPCEI7c7k6vRuBLkyrgDp0WP7skxuUj/qn+N828+BHJPUbghgmA/gRXdw2zJGlITobr+X6x2F5X7FHxOR8gf0Hk+M7rQCpan/XMzGpZfcq8gvkviaEYfP1dsnL2Xoyh3iuMZjJ/g==;31:WYJC2pcctKNVeaF4VH/Sy/q2esHQ+78keRmHGCp4luX0QzVhc6IEcvUrg5MBUg3UfbasK3du7lff7Dqd3cAK3n5aUt97sFLnWidMIzVUM9561u3UruDlFAvVNSdLbmdyQKgeJvLz+yIMGJSFB6122OJ4DKPXbX24gcal6H0THCBsAqgZCoV7N8AlXs0KigkJuwGlcOslSDBu+kuu2hGynV2kNuqHElRC9EmGzg0AyJk=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27790DB2B239FDCFE208B228BC990@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:ffKZ0GJ9Y5Tb1E4aOsGI6UsZPeOcOxlA06xi+nSQt4+ThHomdZ7Ldh/mZffVolxEnt6AYaPAPImoAEYzT4xGvZJ2o6Z1F+qBf7yS68ShTnVO5VvKAs8CEF9dCIwGudvtnqrqN3Fy0Mdhp8wm9MwTNSz6ATD7DrxCaOIWrYUqX2QuzK4I3cNMJTKPy7a5QFn5Y/dHnSmlop8Kgkaj5m79ejpxeEQD9hG6fWF77ZcqW6Ib2frvW/SvLmVI6JmsXV5Q6vsBdG/fYrx+qZuZbVaSdA==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39830400003)(366004)(39380400002)(346002)(189003)(199004)(6116002)(66066001)(1076002)(97736004)(446003)(6666003)(11346002)(6486002)(6916009)(50466002)(48376002)(2906002)(478600001)(3846002)(16526019)(186003)(26005)(25786009)(47776003)(2361001)(86362001)(36756003)(74482002)(6506007)(7736002)(52116002)(7416002)(59450400001)(105586002)(106356001)(305945005)(386003)(76176011)(476003)(316002)(81166006)(486006)(53936002)(81156014)(8936002)(956004)(50226002)(54906003)(2616005)(2351001)(4326008)(5660300001)(6512007)(51416003)(16586007)(68736007)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:Mzk8lLBwTTgeRsoNo0vPW2vfF1lMODPmIpddYs4?=
 =?us-ascii?Q?8h7asNKq5xNWvDsxPDmbQOZeoRisMB35UOatAhvmQ33ZTsGuqcu0yPhegUkY?=
 =?us-ascii?Q?Hi5qKCjrPCI/uuxepgB7n8Pr0onV/65jcu/cYj1hKIZdZhJ1Bd03h5GQfE0G?=
 =?us-ascii?Q?Z/Dwvl3gZnzDxWlohzo/id0ZAfrH+WikmmgDeBdFipaUcNz202KSL8sHqxDR?=
 =?us-ascii?Q?ZImD0sArql2FFPwV1CdiuZdxx4t15PdLop3Z0JV+aJxIR+5u47f3r31SFqnd?=
 =?us-ascii?Q?RC4Dm39TwsrsA9X+GhAmpyUkqQ8uh6BIobGEpA4lE7PMoBZ4lwkWzUCOv+wb?=
 =?us-ascii?Q?qj/lOONqLtMU+IVCeZ8XET+DUWgQDVbfApj3EcJPXAruDOdgHIMHYWAOqaju?=
 =?us-ascii?Q?e+Dni5LIcHt/fqAGUvlMVZNFy6m8XO5jZQUr7Tn6NLZddi4xt0RLxJZILfqs?=
 =?us-ascii?Q?3DEADmPofp9TfUfbR5F+2gNwCONTwNCvu2G78lODelaFJ7fhmoNMNM85Sg3k?=
 =?us-ascii?Q?8WAKPXzqkkGxveY/2MCYFlx2ocwkyqs9GcsBfpC/e6l9LrL8mQxeFSI/SM9D?=
 =?us-ascii?Q?Zzz22qhjcQuWpMLp8VD04Ursi9HE7EPHh9BhiBNQiBKOvQLG23SVYXbdfUVp?=
 =?us-ascii?Q?eDKOCeDtaSQEb6dQoQP3hEHM+lPckYB7AuX1SLpHntJGDkCE+hq/IqB5oBvQ?=
 =?us-ascii?Q?fe5Jh2PzQzZzb28QcsW2hUi6sGCCLbF+Ts7oLh2MoSG3BhmTMeMoN8jGix8M?=
 =?us-ascii?Q?T+GTCoU21vwyxT8njLDUtRdkUTgQsh5m6VYcvKMzOmKq5km5MCaukYaHVPJM?=
 =?us-ascii?Q?JbvAaj4GoNxxiHUmTXEs7K4NeT2SYPcgEsILKK3esO5m3WcPSPjf5GO14jWV?=
 =?us-ascii?Q?7bXb9BcBYsgllc36K5cvkvkOWGHTUqq3E273g84hPkZT4Qby2Shzjl0wXUvD?=
 =?us-ascii?Q?A3mAMbhxoklJFHxmAwBnP09J333k9ClqA2y0NcqSD/pnhBCjR9URQuQ8jMT0?=
 =?us-ascii?Q?vmCyFFuS3TBlKqmHfeKuanK5z53MkEpTRVgZ5JKNbWRJWta1o6SWzb/O9wtP?=
 =?us-ascii?Q?2FnlmOthsVtU77CT5dnuTWF3Sa43d1J/UaCPU4OxQ2gMQ8NZ3pOty2YFeDp+?=
 =?us-ascii?Q?fYRYAHdHcohtrmgE0Bj0QgDW2OBbo4oNL0ydAUxRRwsSc6VnYYr2AnDvuUHe?=
 =?us-ascii?Q?46oXEpS47guhX7XPOERTaOHzwN7NgYR/id/MwkOdpWjavRPEYzvApPPEuc4P?=
 =?us-ascii?Q?BoVg8bDXORlsyK3tuYhupAcy6PIW04Hq6ZdTEziydssEYHVwh9WTAo/YR5aF?=
 =?us-ascii?Q?44E320pVYhS8LUb1V7nPA0l7PuIdn+bfbOmtyz/Ef79zI?=
X-Microsoft-Antispam-Message-Info: e7Rj9iUSdPHerGsL1lbT1f1iDWkKlTroRR2LUK0RKJPFn1hkSza/bLwc624nwXDjoxSy07pR+qIarTTaWBZkDBMdx3nNcTqpNxxmtM6w+BkKJlTxfBtgtV1dxvG6OPSbmggsYhSuUlADsaG4BkjU/1M651XlQkfQU5Qm91Lm2kgIuTSnH7rMdVmnqX1AvK8D
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:JOIdI2mRPMS0pstoTyKRYOApOUo83VPE3GN1ie6e8cOaE3kR/vAlwNNfjwGs7KDn0584zCjPGF2qdtyCn4vVpxf+GZ36k9vXg13eQ3Av/KNmJfUQgMJFUG3iXMBgtsuO4Lyj/Cqb+OpLLU7uixXsA1lBc+//sk+u2WAD7PJmfNyaTa5EhGFoGy9z7fwXMflYqVtHBDVNVMQuGfN+5cilY+M5bKV0hyOPp2DLvawzuwlCmUTIKywuvRKXQyhLXxbBoLnLM2zdpI0lTloqeYVnCCuumpK/OBC7bKSzagfeRT4gGDCXHKUCdkOxy4xxd/UqGjqZc5j1xieUSM4mn/F0zsN0zD5XDbCtz2isvpF4MTq2J2W+tucJU4K4SR/2n8dX/ebBtd4cpKy+TX5oRinD853I3aC3X9g/dKReT5rveneoJkMiIslZs/MR509cu7GWvQdK2cjxwz3ZUXhGU5nbxw==;5:VLVocW9Fj/e92UWfGnWneb2HSLvlyCRotxJfShdDGicu4vxNHWZT/PWgN4VBqngLS8n/pRr68nb4nLMRCbmXwJl8HGrtJl2XbwLaMCEnzRZFX2Xzqh5kCwZM0JJlbV3bRZkwrFNI9nYcKG3YvsGU4+p18FpGoQCXaDi/nRJgr0g=;24:ORj6TXQr0teoZ4HVJ+s+c5ZZgEBG44BkyTc0zwGZSGSZXFv6YM0DVew0a9Qcb7KjdLNK1BDm/npNwLKUawZ898Zgd6hVg/yISXEyVQN2qYc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:2Jei4Al9MhbTVjNnKWQHOQYsOiyfqsvi0VaU7X3L4WE1TY0MJRcTYvM3lSlfdgexII1ORHjJnfbz/8gw+QVVNgmuLiUOk9Dp1sLuQStegFkQ34LyeES0MLevQtBiDKqXnHdK+H92VjxHbABYAh2nWhGWK/Pt1YClUelOqro4aWLTO6nJgZbf9OtlW6jEmjW72Vl1gsjXi/n4ZDeoSFiBUO+yI8w2eE3QzqBqx/NaZiGcXJfcPTlNJUpj8JKi8XT9
X-MS-Office365-Filtering-Correlation-Id: 6d66a958-1b14-4147-bf64-08d5b5e57513
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:45:45.6347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d66a958-1b14-4147-bf64-08d5b5e57513
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables are always assigned before use anyway.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-exynos5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index a2cbc779c33a..185fba37e830 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -707,7 +707,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msgs, int num)
 {
 	struct exynos5_i2c *i2c = adap->algo_data;
-	int i = 0, ret = 0, stop = 0;
+	int i, ret, stop;
 
 	if (i2c->suspended) {
 		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
-- 
2.11.0
