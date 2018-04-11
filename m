Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDKLwO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:52:14 -0400
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:18836
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752401AbeDKLwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:52:08 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 1/7] iio:dac:ad5686: Style fixes no functional changes
Date: Wed, 11 Apr 2018 14:51:51 +0300
Message-ID: <1523447511-13059-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523375806-29296-1-git-send-email-stefan.popa@analog.com>
References: <1523375806-29296-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39380400002)(39840400004)(2980300002)(438002)(199004)(189003)(107886003)(50226002)(446003)(2616005)(11346002)(126002)(476003)(8936002)(8676002)(426003)(246002)(51416003)(7696005)(186003)(26005)(77096007)(76176011)(106466001)(48376002)(50466002)(8666007)(336012)(36756003)(110136005)(54906003)(7636002)(4326008)(2906002)(305945005)(49486002)(6666003)(478600001)(16586007)(316002)(47776003)(72206003)(486006)(2201001)(356003)(106002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2483;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC016;1:8MLr2GpFOG7N1idCLupwxa+T82ceiMY7J+NAvDOQoyDg9fq05RjgL8f5Uf1RqNoHXDiPX4Gg+0e5+9S1ohVkve45MA9hn6Qh9x9SlA7J3nnGCSe8HF/a0CYNNsIIpBW3
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB2483;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;3:GHuPE9v2yUaxRU2Pc9J2NrFGC/NRLOpqtSIUjCXJ7X0njKJbcwqF5M97cVUzVITyQJAS3pCugxvxntjGuD0EVHoGuyNUns0A/U4LtEyo1U1QWC5iSf5WROaIzEkpbujizM3Vgkk6usRc0q0wX5OSHnIdUkvB1qsDfglXFxgv61mWZNCVtDUwkXR4ejhodPckK54cSPeGqr5CVfq6UupZxNbLaw1/BqFR8m0HfRLxqseV7Mlv/lDng3PP4JjPNKK92Hn2TFBuYle7FVoQqKp5VMAzdU06JTwprsS39TjH7tbE6yWcaMSwPQQRs52tNqsQiB1w5OeGAfv3AmXLAkCN0A==;25:SUmY5f5/EIpwR6O61RVX0txwSl6OjYmHEDFJfFYvjl/SQhLAeqAMs22yqXkWaW4IedJYpgDFjDEM/3pkYtP13t8hH3FgvyV2dfcHTSqj5GIfnzphVAAgEumGJI9AGzyQvag05fIlp4haY7bAjSiyzuB0tahKbWwefGYzJJMg0wlZ9/APo22Es2dBXOE3/xW2kxtNdYESjSQLiEG0LkkDKeBFqFH4a7bPYSJuD+5ahPGJnSh+cLaZ0E5nOLnLI0CxuEqEJIF6MOZlNV5pa7pb/6xUhkA5HH1YLtSSIamD6Qlb4hLEFXMW0dQum4/6Tul+h7XBXaGybNoOxsAevXMZhQ==;31:5thy8d30giN2eUfn5hwycbJjhweyWBOQ9w3z0RmPYMm64MF9s4DLGnaFlSwEA+QR0UA6rkUlqdhwoqU8fGs5irPIZVjTFiBHkBNMzchsbBbW3h7lheHJeuY8FgQRrrB1tsA+enw0puZJZW1JTg9tgZvnW1J0WeXqQefS0I5UtWJBgF8O7JAjg6AKAB3QQpxkcIQEfK/LMiZNW/cJi6aXExA1CFoPaD8VkaZZKnor8Ao=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2483:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;20:vT9DY1fdkmWmqhsZjnh/ZrEJVTwccW+2gpUGJiuz+FWulidCXvAId9dZhRbJqd1ADdY6QL7j+XF3Wz2XVYor8S73wpM9OMaJjDEks191EcZ09qYpvCXwN+Ar6cI1wp2eshRbDPSjnmC0ggaWIVj86PtONtVPP9vpcOrZL3TOGAC+81UsXHqreQCmDIDaWUPYfEH4VNbPRTz/lq8SmaxgCO6CsccWBz9rM5kEk1lXj3rxYAmswiVousliKci/6VtkMywXD5PUN5fMb9bDfK0uDuZJkWfe2YLhAqxqs93oLFayi+fX5CTMsj4Ul96lQ/TW+QEAV4FfEBbLBV5+mZH+3TJai5yV6G0auFeWvFzdBoxEzUzMDr1JZHN2SPtEkA0Jj+TzD/Hctn9xw6AJLnmIq8UCyeMP4D8ZoaTwff47kqp2ORGt4IHy3qAJCCfYj+AHODoTCD2yIcuuWpN4xA3byBlbSVBo/YKnCZvSe7ColCCZvyfskIZqthjBpZjrvLSv;4:eYvnfn6cPLKIDohuT1PQu8rYpZhbm8QWsXVd3n96cJ7RhMcJBzLTXsV3vd4uIFODiW/0a3gNa6/QiGDBal5s+CzDo2t3k5iOm3vMz4LIMyrUD6PzRZn2PR7iCaO4vXjLCVmI+fYn+3+wsDhrXLpIlvw8NcUkktiguki503l0BySx7zTYzeK+tRCWyBynbiueBoCdbwc8KjZ3hk0X1EUzsQRTkJAQw5XTfqBnpzyOj79dP3bxHKPXvCAmTE9307cyU4YR192VxvDjqfWWuX1GbsGisgE0Dz+Q7GzqZFre3nv49HzO8ELRNgstLTyLUBG6
X-Microsoft-Antispam-PRVS: <BN6PR03MB24830E4C5EBF253F86AE5EEE9DBD0@BN6PR03MB2483.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR03MB2483;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2483;
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2483;23:Vl9gB+I5i6f7ubT1+r+5pmE1SXM7lsdLXmqvm2aE+?=
 =?us-ascii?Q?wM3zJbcGEtjhPnWVVl3Uuzl2JQIoG6mwXcJZbJEBS3TEYa2XyOGXfFOscoF8?=
 =?us-ascii?Q?FWTD/F4yV6J1nOcMusOfo/V8r+9eVYc2UOUzHqiVMgiK4JklXzQmjeVX+drO?=
 =?us-ascii?Q?buGBe93zuzHSBB5g2rm31CcA4esu2rh+bH2nGC8Osw3ppmSbB6EuH+JXv9qU?=
 =?us-ascii?Q?WbDbpb1YCgfbtRLEiZOgJ3T14Oay3W1y4m+2oI+w8wujDCOzYlTzZpn7gjWK?=
 =?us-ascii?Q?PbiXh1HRBk+NT0V/uqkuGvcyhTLLWZ/C5Bzx9V6mA3zJsF1nEpZXGKwGk86L?=
 =?us-ascii?Q?nxUjuB/ezscaQ9nG6is3vtKeADUn4lvRLpmpEGciaTxyReDvhGHfFUc8w6dm?=
 =?us-ascii?Q?COyhbA9Pi0Jwz8nLrMfP4XQsyMdyxkLUey84y+d6WpaeqTZkerf62e4GzKbi?=
 =?us-ascii?Q?FEvIpYBBlIOvw05IGzCD8UaQqoB+2UIjYTVGT/+di0kwjt6ZToMYB6+/Sds7?=
 =?us-ascii?Q?Ry76P9hS5OtTUu2ZVwlKVwmzTWE8LbrroOgDpggmkdBfJ0sjmQ+7e+nYV8uu?=
 =?us-ascii?Q?4kQCrK5x/iQrpf9sBT6B87rbsJ4FaDWFh5gst1sapUXxcQ7Z3zBSYDJOhjhe?=
 =?us-ascii?Q?FmSeyISP8XBb/2ntO7vg6H3+guBjux3g51ZeX9bBuWY/+PAG/KC8+rvrXwhf?=
 =?us-ascii?Q?GavpCoAPrtpry8FelPSn1QegOhgiwzf/1LP1JNk4TZi8ht22I+8rYizRxuoJ?=
 =?us-ascii?Q?UbqMFbR9vGW7Lad9Tus7ZfphF+G0MIHp7EeiTcPUrulodLjXnE/NkzH1lU8Z?=
 =?us-ascii?Q?ajidTDAYwCGVTTNnlNNWHrE9U4sw+6krM44wR1x2/T/Fa/GZk2CARU3mWU58?=
 =?us-ascii?Q?ldQX64O6RHX29eJSUhlna6iTUpUhUWcZQonkKtFO9OD4pgJa5nqjozDGKzR7?=
 =?us-ascii?Q?PbPV79WwmYju3FLA6jJRtGqDSg/r5dwyxQJgxP0oeSYQDnTZ/v0wJ/2y20JR?=
 =?us-ascii?Q?3GbRWlbvjXbhXg1PIcpym4KWWc/7bSASiu3bqVSzHreYc8cu6OxQB2O6uo4e?=
 =?us-ascii?Q?NJjzfP8Z+fBJPv3qJNFSLRMjaKjOBvA91+PhSLvAj93xssAbA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Rm9cG75PiXGQ0a3X3KVxWJpLFFRUY7H/G2nu4om0pJJt+DAOV2darvSn7mFAFqf5L+8GupEtmbzt0N0XPhYGGtn1mP8jcn9v9FVYFIJwYi7f21GcBbIUd6KWUrHctvBi93FJNL4ZrSFGmgMu4RzAp8nsj9jj0zAKAM/4pBiOF0cKBxjZXG3FzHajr+dFgo7f
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;6:yCgYuUpQ7ebu4Vg6nyH+MbBlpnJh9m9KPifJjp+0D/vtxYqHHmNqUgaxlDmxVn/qw0EU5ayXV79HQ3Ixfau2voQ9hFYvKxcVkDF7E+pG+qlnFijtKMxlqwgICXcuEFLfcFrlM51evBoP2x+jaopZFTzT9LY5R23MXTyLQPY336Q0TC8phXy1XVajU4DtWIrAiV5cYiQU32SLIvKHX4LCh3aQ4NxQyA3sIUw7sE9ueyyEEXdDrvJwfS5RAk2pQzCVgGN4W7ftfuFt00uAtfooj3utngS3vhylk0i/x8CazQymb3qd7Hccy8ej+Ya98V6aMgrRHDyn3TkEi6SumJVJ4Q5V1nX+pqTpCIN2Lu2gQRT/y7aaR4eibEVOwweHIRJaE+zVXn3WDPC5KVMdnX626bIrGw4RwbqDE4+0pplHFnqfblVAae9IuoN9RwL9Fw94rb0BpEquuJW7PNvIF/uOKg==;5:BpK0hrSg1Wh3K+HdYrcT6zNbdBAe1C+x/N3yGIfV91Qt2ZF8rl2qJC6FUEIoAt+kTm9AIqR6Kg5Nrcv43hkVH0X0o1X23MZV+eszLskNbnBT9O/cUDTTIp7S+G21vRQseaKsgdGQnL62A/Ttr3m0NdLRzLqGeUJINpFChPdaLyw=;24:eRkgwvY1dDxP+12Id7Db6SOZN+D+CVFnnCEGpqMfGmN+o93YH4+xXEYbeAZu7IZR0kV2I5+2h1LV2VOJyi/+cav2sdW/SSkgLJXuBoxBrNg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2483;7:BCx0FBPrS30+NP29Pooa1K04+/Kn5k8/lB03ZA99p0uE+anpAywFCR3og2213UF7o6mL0e1i4SfQIYUnOapQdtvydLb6dhx5Uop2tEyAWlJIwbqc2Q2dxpxjfH6IjK7qGarfaVzv0RTc/alkHZM4JwgSaIFeSqIZQ+3WCqj5Oam1uBc+YeVyokJZHeEym66vs+j5/Vy6lQjAwRK8Pc7vd+ASaK6klD2LMsRYDO34or1f6q6T3d+3xqwokDeIH3Uz
X-MS-Office365-Filtering-Correlation-Id: 04806b83-9907-4d34-6bd8-08d59fa2a5bd
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:52:05.4158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04806b83-9907-4d34-6bd8-08d59fa2a5bd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2483
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some indentation issues and does not modify the
functionality of the driver.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes v2:
	- Nothing changed, just follow the patch set version.
Changes v3:
        - Nothing changed, just follow the patch set version.

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
