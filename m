Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932333AbeD0ITa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:19:30 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:10368
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757587AbeD0IT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:19:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 27 Apr 2018 16:18:58 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: net: replace UINT64_MAX with U64_MAX
Message-ID: <20180427161858.433aabf9@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0184.jpnprd01.prod.outlook.com (2603:1096:403::14)
 To BN6PR03MB2626.namprd03.prod.outlook.com (2603:10b6:404:59::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2626;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;3:cU0t1m5iv34rac5fOoykMAgpmz54fAMTqcNkEGlzgQYRQD98tYNziS0XFlU8ep217KbnREBHGZ/LZB5JqfmVfNr3s7dVPG2Kgva0ANM0SxTiJL7rz3zl1oHVXSlK5pnHe7bfj/lFQbDQ6VWImlnpL/Yrd8dZHuH6WRVg2Uf75DXimPJ1ykjIYiFB2d8fUsjciTGiIOPapgZ/bvRHcrTjI3kBQn+H2yB3BXNGqePlqomQ40HC6b0aNc5vB20W8b4M;25:vzs309HeDDGsOT2vLmcbuGkNuS801AdWu5TKyEdIX8QmNf8J6p9JNEeFJTkt5x/8Hvh83lwCcEGLO8wYRX4dGwSy6NQ9xejfsjXHXeANplcr82Z5MJCfOIJqZ43oPghytvJiX/DXOnD4XjxUZACGIbRRLJw+X580IIBJTjZz6hA2XHpXC2DzSOqmmbUcODAJQPuYH2tlIdbShXKJ5h6I91jwOEEzurXOGRZecbVxFUrJYjiYn9CvTGIDhyDf62N5s74LmrhmMbDLECVlpvgszoMple96T5iS93qfmRgBbYiHXeCfsM/kmvbgEwUAw5N1QT6aY80NNU6wI+73S2uTWg==;31:JNBcujGEnxsbSkvx6DNT/E3nb/JCgm7+of4Le+WHeDbbvlfxBH6YrCIC4U1imj23j0xlJDju4qGCJsK23v0PPyCO4uuV6TPD/9kZ8TSIR2GgnehhzEWr93CIkyViYl//AdCqYQ1JVI759lycTqL7MEfCQqT03faUgIDvIIxKc6q7oTbnNptyLoeNRMmk91oYX0s3c6LTYYcHCM9G2m28GtZl8TbgM+cVvY+0qdoAukw=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2626:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;20:p1Aum0Nkps5YXlsIVNJklaj6pIyBjMwX8lgr807/mYeW/pxsMhrfoTTL9sKipvKoyhkhhECndXkyYdxzcAq4XCm7vn/nlulbErKL9rHNHXNrWFrUi6mUrVv633Jpz1La1+DVojGkSvjAO8a/KRf4NGzHXtpN0A3hq2TjuQx3t4e+Npfm5WebzqBnfhAotj3IQ5o+2LxbZXL+bh7U+HHLwjQN/ywXKYKzJVW4Zp5lBFMqaK7ApjxMOYP5HcPizd4lDr7q2C9EZZ3oL7QK+lHea458YKeMKOK6jc5zmxUtWjPaq/cdh0ZGiJi9WnZ1kRU8KCHun8dXbmyGyTowxepbo7QfVPzJRXTaJi6i0xvBwGuCOSdPkASasNjapbeH8vEPWRYzAHYJ8b3tTwM63XkUpijuhhN2tWWWr4lpVe95z6DiYskxl8On5Ak2AjnPy2H4JayukiwwXSL/KoAXD0F+Xi31P86ovevKKzkON3eFIbiASFZ3ZUV7GmiUuI1s7d7e;4:Ze4A5+1aK7wK8IyhS9DBx7gl4TB03rSjc3kAWfDQgENr63x4D0YsQa2jqknVQ1AY3VCn8dcEZfrEHpn5u2CVEWCjfu1VL+jyGv7/Oo2DslD2Pb49UG9x0wjLy+AK0tm5Z0AZ+K++UR34Q/ExSCtCiOQaFdrbMnSDUqQ7MH1GuUn3P4VkmJlyWUUaRvDWg6LdDB1iWebPwxIUn1JB7f9T56wGdKoC4GpKOAwrsJl4dSPwU55eHJK9TzTP8+FJV1kwbPoCIw06ciiRRNbdDwFDpubZm/iB1FaLDbHOkXaWW+f84OZUIdD538C1HeyA14aN
X-Microsoft-Antispam-PRVS: <BN6PR03MB262623F9DBFC33EC10688302ED8D0@BN6PR03MB2626.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR03MB2626;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2626;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(39380400002)(189003)(199004)(50226002)(25786009)(105586002)(8936002)(1857600001)(81166006)(8676002)(81156014)(316002)(6666003)(50466002)(110136005)(97736004)(26005)(68736007)(59450400001)(386003)(6506007)(72206003)(186003)(52116002)(7696005)(575784001)(86362001)(33896004)(478600001)(4326008)(305945005)(956004)(47776003)(66066001)(7736002)(476003)(1076002)(16526019)(486006)(106356001)(39060400002)(5660300001)(55016002)(230700001)(2906002)(9686003)(3846002)(6116002)(53936002)(23726003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2626;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2626;23:87BbekkGYx9kwrcAHnuHSdTxlXyTJaogQHTyIW0dE?=
 =?us-ascii?Q?bafIxiFfB3mLU3jf8OWfP8zvq3anHnv8e8B0KrzdWJ7dMaWq7n+7s/cCBLm9?=
 =?us-ascii?Q?a2baBpqkEou2n5dA8Jb2Jf9V35DeKjvQYhvYOcQZxyqS5KBMN98r2A6vez8s?=
 =?us-ascii?Q?4eB83nr9pMRf6r4RUInTBZCQ9bP2ViOSj6jbVQXCSyZOsYhtojmuUmmJ+CdS?=
 =?us-ascii?Q?A2cQwJafjOXnH7nW3wBE8l8cfRKjAsqC8Bcue68lA8JLeUQK5gZ+k7SR5Bqv?=
 =?us-ascii?Q?YvN9w+ZXrtMeacQXAnkyT+5jA7mdvHPcjvGHyoBg6vCRPWc0tMSGI9/nZUos?=
 =?us-ascii?Q?S4eZqgE0sVT02Zkcrb1ZrqcJ5f3IsHvHnUL9S7rKl2867fEGvkkNvXw69Ee3?=
 =?us-ascii?Q?c+k8YjhaRbpZJ5pWwd7PpH4X7V3JQaTTt6KWQrmjxx5ft+aauJIeCw/DSL8T?=
 =?us-ascii?Q?m/PPWGKZBjfEBdELBEuXOqT5vC92j7LHWoRGjwOePrWsi/BzaN7GFY1i6Otf?=
 =?us-ascii?Q?//Awz2GH1RbjiZX0qtkgGsUDjS2Lq2D65xz8+TxJsPgKtSYG1hyy2DHbfzsC?=
 =?us-ascii?Q?ONqUbNXFTeA0LB9sEvF6NvEOak+0YCGtbB1F0YO2/iEyT/hs2L/jcAJv6rEl?=
 =?us-ascii?Q?d6+oOObUmF6XyQU3ZdRXlSTzcpZRhdCbVLDLXSRBg5dgs2wTLYdaGbuQTt0x?=
 =?us-ascii?Q?Qb5AGToxgWj/8EGPpi8Z1HO+zHIVYs/ocDYpYYsc42G/vy4K9cwPaqdmHOkX?=
 =?us-ascii?Q?lOgBu74luVA2HvS/jQF/eP92cxdK+xq8LL/8eaeTNrLadbnXXk4dcCSD+2Bi?=
 =?us-ascii?Q?JqSm9N8YQSHSyV8PU0oodqKCxyXbVVj1kt8az3GmrjAC5bNb9CXdc1droKmg?=
 =?us-ascii?Q?uIk1eoxIEuDl6X5EDA33ni59NOjci119/gUuoBAYnHuBqnw7sqOl95Y8ZHJZ?=
 =?us-ascii?Q?qPDxEiotR24bWErHyHH7USakVGnwx59Xfni+oDoaRTdyqi62Rgvd1TIfMPQK?=
 =?us-ascii?Q?uZvSlPz5iNOdFrRioaZkzcsGU7POPbUNN43DN+9x6lXvLYrb85xHEKQMGkCe?=
 =?us-ascii?Q?+f+p9m0N0zVc421CcQEocfU2zsqOZgS1pVk8Dzz1X1FEA7O+suZMn8Hg3c2B?=
 =?us-ascii?Q?yd4x1bDkmLY5lb/YL9S7GtkHK8a0owiokMX+Xfbe3526xR23ThE/CfxjG8tk?=
 =?us-ascii?Q?iUfolaY38g28YyTYhznmXR8aT/F5eHDz1oP5wH5liLSc+NEf+lvF4ICNajnx?=
 =?us-ascii?Q?g+klWFP75haeykxWBkOrvoVnYsSxx/xubjCVwTG?=
X-Microsoft-Antispam-Message-Info: p/Vsbsvg4DGKkWP4nU7GYbFgs/mcqDHyR8fnXC+M2oa+JrAvH12zFI2E6ApQsuJHIZVtelyR8ily2XTzZzo6nHaONuXit9uc9Kxjx6i+6+rtrvelq5ByX5asReDDCbsyb/Xo9n4WpDA+CCg0SkGh4HfllRlTyF/Kt2kvJ1UiUBRS5N5e6a19oFb7AMN7RPZu
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;6:DvqgXNp+XkjO7QFKySfevCjR30qvy3gf8ypLpmXDmlFwZ91AlNznpUO5YEu+01XVaEBsKrmfXnh9IjClKbAFBQ+nnBoqOsVXSE9Mr+8hEAw62ZFs8zU+Hn3DPYHr77G9QyE/o/QMv2OGSTiC+WeoFSWbq9qD2o92CeSHkWcJ61GRB2B5i4HAxYO39a+ANm1g7LghOC9MCqMmhtExBEbgwD8RuxJdW+VT/yalVHpaJ23+x3Ko12cuEG6U9YXwzGQPPcjn9DPZEKtCtD/cSbH5NBEFkbNxgu2Q48rbwJcyelecrUg9YNzys+0M5J/uOFNVnoA7zyPWqr+eT1c3B22e0x0KlC9qy/GZnWLvb34BqdqY7rgSiJto8mEFsoWPLdJ1dHD2yqfKLYej8DEYP4fyFeNH7p4YYeYYwpgd7mzVTPgmqlgtk/iEHc8NqEJH4cxgOSPYbrYsoSPTOi1A3A5RJA==;5:x0yKJTlgH0Kck8eIGXq8Gse/LYQhEoyUVWiIIA8UR9EhBtaL/8TOjLckd996Z7WqQk+6YEq7V8RGTvlyZ9BI0Tph1kwJQ1Vm39VVEpI0fxKpNqblLIPYa9ri7wqazEx92gMaPlEOalHhMQIUHxAUb7/zXbvWBjKtQvkhojw92gU=;24:0PkSdxIKRxg6+ghjdKT2rAjPZHe29PFQvdHvy26J4oezf3uHf0rnuv2Oloxp9W8ur/IT1nxGoq07iz2paODnshtUrHQHL8iZH8JeJtF8y8E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;7:OnGTo6MmfdbiSjrv4C7OHQ5RmckdkoQsBbKDPJHFuUevyQu0cwYYgYEQjNxreeUfAREwRC4QLXZqtRvL2zRaZNhU855e5Oc0GlmXgsFvdOTjVG4Fk8sU1QRYd60y7+516MuZ2nLMG1dqwlOUrli00TGs/xmssAvbl45x1Cj+bwyMJuxCdvJ5P0WejJHRgKAP6KVQw8zQ0Tkrb6orHWwmmoohpvAkbBkres/YjWdHeNi+XabjQYDQolb62gkN8+bp
X-MS-Office365-Filtering-Correlation-Id: 48ea7fd0-2d05-400b-311d-08d5ac1795e7
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 08:19:22.3519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ea7fd0-2d05-400b-311d-08d5ac1795e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2626
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U64_MAX is well defined now while the UINT64_MAX is not, so we fall
back to drivers' own definition as below:

	#ifndef UINT64_MAX
	#define UINT64_MAX             (u64)(~((u64)0))
	#endif

I believe this is in one phy driver then copied and pasted to other phy
drivers.

Replace the UINT64_MAX with U64_MAX to clean up the source code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 +++---
 drivers/net/dsa/mv88e6xxx/chip.h | 4 ----
 drivers/net/phy/bcm-phy-lib.c    | 6 +-----
 drivers/net/phy/marvell.c        | 5 +----
 drivers/net/phy/micrel.c         | 5 +----
 drivers/net/phy/smsc.c           | 5 +----
 6 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3d2091099f7f..1a2dd340853f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -665,13 +665,13 @@ static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
 	case STATS_TYPE_PORT:
 		err = mv88e6xxx_port_read(chip, port, s->reg, &reg);
 		if (err)
-			return UINT64_MAX;
+			return U64_MAX;
 
 		low = reg;
 		if (s->size == 4) {
 			err = mv88e6xxx_port_read(chip, port, s->reg + 1, &reg);
 			if (err)
-				return UINT64_MAX;
+				return U64_MAX;
 			high = reg;
 		}
 		break;
@@ -685,7 +685,7 @@ static uint64_t _mv88e6xxx_get_ethtool_stat(struct mv88e6xxx_chip *chip,
 			mv88e6xxx_g1_stats_read(chip, reg + 1, &high);
 		break;
 	default:
-		return UINT64_MAX;
+		return U64_MAX;
 	}
 	value = (((u64)high) << 16) | low;
 	return value;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 80490f66bc06..4163c8099d0b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -21,10 +21,6 @@
 #include <linux/timecounter.h>
 #include <net/dsa.h>
 
-#ifndef UINT64_MAX
-#define UINT64_MAX		(u64)(~((u64)0))
-#endif
-
 #define SMI_CMD			0x00
 #define SMI_CMD_BUSY		BIT(15)
 #define SMI_CMD_CLAUSE_22	BIT(12)
diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 5ad130c3da43..0876aec7328c 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -346,10 +346,6 @@ void bcm_phy_get_strings(struct phy_device *phydev, u8 *data)
 }
 EXPORT_SYMBOL_GPL(bcm_phy_get_strings);
 
-#ifndef UINT64_MAX
-#define UINT64_MAX              (u64)(~((u64)0))
-#endif
-
 /* Caller is supposed to provide appropriate storage for the library code to
  * access the shadow copy
  */
@@ -362,7 +358,7 @@ static u64 bcm_phy_get_stat(struct phy_device *phydev, u64 *shadow,
 
 	val = phy_read(phydev, stat.reg);
 	if (val < 0) {
-		ret = UINT64_MAX;
+		ret = U64_MAX;
 	} else {
 		val >>= stat.shift;
 		val = val & ((1 << stat.bits) - 1);
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 25e2a099b71c..b8f57e9b9379 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1482,9 +1482,6 @@ static void marvell_get_strings(struct phy_device *phydev, u8 *data)
 	}
 }
 
-#ifndef UINT64_MAX
-#define UINT64_MAX		(u64)(~((u64)0))
-#endif
 static u64 marvell_get_stat(struct phy_device *phydev, int i)
 {
 	struct marvell_hw_stat stat = marvell_hw_stats[i];
@@ -1494,7 +1491,7 @@ static u64 marvell_get_stat(struct phy_device *phydev, int i)
 
 	val = phy_read_paged(phydev, stat.page, stat.reg);
 	if (val < 0) {
-		ret = UINT64_MAX;
+		ret = U64_MAX;
 	} else {
 		val = val & ((1 << stat.bits) - 1);
 		priv->stats[i] += val;
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index f41b224a9cdb..de31c5170a5b 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -650,9 +650,6 @@ static void kszphy_get_strings(struct phy_device *phydev, u8 *data)
 	}
 }
 
-#ifndef UINT64_MAX
-#define UINT64_MAX              (u64)(~((u64)0))
-#endif
 static u64 kszphy_get_stat(struct phy_device *phydev, int i)
 {
 	struct kszphy_hw_stat stat = kszphy_hw_stats[i];
@@ -662,7 +659,7 @@ static u64 kszphy_get_stat(struct phy_device *phydev, int i)
 
 	val = phy_read(phydev, stat.reg);
 	if (val < 0) {
-		ret = UINT64_MAX;
+		ret = U64_MAX;
 	} else {
 		val = val & ((1 << stat.bits) - 1);
 		priv->stats[i] += val;
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index be399d645224..c328208388da 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -168,9 +168,6 @@ static void smsc_get_strings(struct phy_device *phydev, u8 *data)
 	}
 }
 
-#ifndef UINT64_MAX
-#define UINT64_MAX              (u64)(~((u64)0))
-#endif
 static u64 smsc_get_stat(struct phy_device *phydev, int i)
 {
 	struct smsc_hw_stat stat = smsc_hw_stats[i];
@@ -179,7 +176,7 @@ static u64 smsc_get_stat(struct phy_device *phydev, int i)
 
 	val = phy_read(phydev, stat.reg);
 	if (val < 0)
-		ret = UINT64_MAX;
+		ret = U64_MAX;
 	else
 		ret = val;
 
-- 
2.17.0
