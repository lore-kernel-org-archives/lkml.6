Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDJP5L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:57:11 -0400
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com ([104.47.32.43]:26079
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751820AbeDJP5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:57:08 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 1/6] iio:dac:ad5686: Style fixes no functional changes
Date: Tue, 10 Apr 2018 18:56:46 +0300
Message-ID: <1523375806-29296-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522418118-11810-1-git-send-email-stefan.popa@analog.com>
References: <1522418118-11810-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(39380400002)(2980300002)(438002)(199004)(189003)(47776003)(2201001)(2906002)(72206003)(4326008)(8666007)(36756003)(106002)(316002)(7696005)(426003)(50466002)(8676002)(54906003)(246002)(50226002)(6666003)(5660300001)(48376002)(305945005)(110136005)(51416003)(336012)(8936002)(76176011)(486006)(478600001)(16586007)(126002)(186003)(2616005)(11346002)(446003)(26005)(77096007)(476003)(7636002)(107886003)(356003)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2485;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD028;1:o4vt3UfoAephzubqo4wwmcc0rbL/aLaHUkKm7W/XEW3LlYVLwDlXKpa0nVYgjDw3ndR6y0jU5CZmgArH25an7UDLE4/GnDBhGDc5SoN4iAQ4vNOfREmr/GZUV6edixs0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82ad5a49-3d6f-44e2-c83d-08d59efbb565
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR03MB2485;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;3:+RXm1LofCsQO6aiegacL3l5Ctk4uJH+IFPUgBpBDJGuxE8g5s58xPVMpeFAeD7HgYy/tshG3JCOMO3t0tNZs6rzkcEUl1ubtOSJ1Wfjh4tx9c6DZv5l4p0JHJxbiSUfWhQvPns9v+7Q3BPlpF5uIworgcF/TgjLJgsectun3nP31QIyIrA/iB2SRqQXjeY89F2HrJMpucg3uT4oMvrqgjnne46VUQOr3cmcLEWG1Wf+CkPDtoeD+4PNPhL5MlFDQq8fSMy+JxJviEmJzXAG4jm5PQMR1lUH1XfrBHlYgrE1Fo6srxVeyka6gusXViLQoc/u1/X/EYfinfPnC1GTUZSg4Y3i4TA3qkQ2ub++7Bvk=;25:G72+X5tFD2sYJEAWfKj1KJ3G7oS56yf2cWTmhtoBnxC3nABWXAXV45oa7pxs+u0WIi59mUWUxhiVZjsugqsrxwMRjRRxX3t0E+LrqgmGZeg8K4w8MP1VhdtPl3IOOjKX1SfFHJe0D8FpJNhUrNznD7pEQtTS8gVM3Zok+ouQKBxncTAzqknVbPAzZL7m4KG8OM0jtYq4Z/QWub+jEIKxvfkmkr7UNnYZVvSgh+/YNqOnams4NXcE2dMq1IiJTFh3aNuqKfZUuK3TV8JWHlKyvVQMZYTfmbUAw0H7AVsyAfx6Jk2iEhaoDZbaZy9L8yJvUitG5m4TnLNyLMI+9tsmOw==
X-MS-TrafficTypeDiagnostic: CY4PR03MB2485:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;31:dCleVz7LaCt1LrYEJhuIw68a0Nou3oDZhew3elei3q7/bujdXtY5nRK5erkJ6YSKo6J9lBRC4xexfmkWWC6FGOb5B00kgVwgD4DZpsdakHuPua4hwBJ5O7gmZLsXa+8g4wC7LlK43z4lEnFesJuUxZPF6pznYtF91chYozwckStGltC8KoKYmegm+U5LIBoAQcz6BzwbG+R9wY3cadzJ6KlCc+E8KkZEFFqxNc9ainQ=;20:sGnCM4CrBnWx7u9LlcGb3T9bkSSi+ShoGHhkjj5m3RMUCSMfsVEUeVHKgiYmB7OE3+5F0cdMvAzyNzG5kTXMNwJvmbsqPJjAWpdHWBNaGjlNRvb4qxUEnpkIuLz+UEfQdV+kWWJfsb1t7BKXSv6Xd/F711kDtWEg/xtjlhE2NAUTO0BV+zV6QhrzLhZPyDDnD9h7OZ9buFrNa1Iotrga6S6fEiSGGhz9H9X7NLdmloBjzNltgd+qIxq6QjEdNl/kpB0Wif2AUs8GrP1tkMDH4z9T4AZOzeKB3FQus1uF/iBoNAVNV3JEPGVeBEkDLoAavp2HJL/g7uKfl7lrwadVCqaiuAK+5EQh/Jrf87CmDXxL/I9DOBK5RcblaEEh/JXa3swR77c6eyjInH+ViPg10xszdYaxYkBBvpotc/aEgBLhz+X+ILC39p07rkjb+OEFBvAnnPZeRYHkohCwvf//8+IjZmSEtrmGJIlJMz42hNc4P0SeiD7j3wU0sFcuzmse
X-Microsoft-Antispam-PRVS: <CY4PR03MB248545362DA91202786E28459DBE0@CY4PR03MB2485.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR03MB2485;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2485;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;4:5b6WQbXiMrsth9Uf7RK6YQMnW0QBrpBa4juvg7pOLMoyz++Ip9K/lOa38INXw7Bhay+yDEjHHsXfksCut4QiDglDo5mMAIC5SA9DlKaxxwdZhGZ0CGCNf0PMBsrYBnbMOTlmQqnVSHlYQCreYObkIO4M/hjQNYdY25/sEJr/uZnPr5vwD+0eQJStziN+Z/vdkIlxi+Z3bC34pJTOuDLEBTXwEB6m4GChW9wpcfp2l1Qa2P7pB1Ij/qU6jEppCWZvvYpnUwVjBOCte3mm3u6Pl3RpFmVx5ShFGvA4lciututaaFe9yE2rq7ednNxpZZnx
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2485;23:Ghd9bnAyi2jDUeX/ZtyvsKdUo8c1ncTS7Et/wbqVm?=
 =?us-ascii?Q?BnozR60cKIV3OTEwdUJvhcwHj91gCDhUfuDWxhgLBAMjAhkrVaviDCE+u/Cu?=
 =?us-ascii?Q?qs4QOCTBjjoDv1M0l9YxEHImWMFNLdGJzeahe+qyP/kqYBezWsSVXc56CeQ5?=
 =?us-ascii?Q?UtAKKoB1qPVb3jBmO58xyxk/QWXQdmEzSjbGi5IdMmwHfB19tdLfL9miVnAF?=
 =?us-ascii?Q?J6Go0zTDiJFMd5gbnEswHTMWgnMRHyCHA87dykW4zV/UwCNDVzhPvc/FN3DJ?=
 =?us-ascii?Q?ATSV27rk1Z5W0jjLgGgTPC6PpCUJecqxroEBtP2C3x41QRvXwfNyCughT0Xq?=
 =?us-ascii?Q?UDbUGtfvNo1XjfrvjOiKOdj7HyZhH7rHNSI4xGe3qXbF8kCE6NrrERddgsum?=
 =?us-ascii?Q?wKDYqInI6riUx8BvFCMtzYtTGOERf2u4J1Of82v+dMxdrAe9mY8LkVx2PBeb?=
 =?us-ascii?Q?6NOnc5ra2OXJFwIz2j4q52lrBVnDQIOuN/aKRldmhmQFDdX9hIffNn+1/qIJ?=
 =?us-ascii?Q?dbaAKBunzF9qGfYnA5c0VQ1PSxq87DrMpdI6p9N1SRw4ce/wefcsAwPgSTQC?=
 =?us-ascii?Q?OldBwmyyyGadxm1xkC6rUqk764g+3R5WwjuXq0JN9D3DEi6yneymAruJYF4Q?=
 =?us-ascii?Q?lQsZbP9PqYuWkkfhAVeXjU3rxEB9yZh6M6XeeYPFQAWIZ/Hj4aRK7YH9R9/+?=
 =?us-ascii?Q?xEiIl6m/VUPOC00TrifJpfSgRqsuaE0B0zKWNVVFVYVq/00jWMD0mMMwh6tO?=
 =?us-ascii?Q?1K9lIeiQdplxql5B5u2q4kqf4K51jWmsFF9asjn5opB51yJ9XXGr5GHoTWwR?=
 =?us-ascii?Q?QiHr4s7AbGlLpc86NgEZSI8Xkxnb11bYY7++GaPNh0irhidCqJo89fZBDd3K?=
 =?us-ascii?Q?DvfNdGSSiwFI9FUS1FgGVmeWri4YEXIhzf+WS909bQxNK33LuthYTkNNLhkB?=
 =?us-ascii?Q?zS6lzHWb5tXu0AwyHviCgTw9CFQDCIbjCEWIn1TvtRRq5Kt/PJe4SZG7hxYt?=
 =?us-ascii?Q?p03cMBvbV/AXz/qA6hvL8EMU9vEEh+cpGcPyr0LyRpQDH7pcJCNsAw1E2CTi?=
 =?us-ascii?Q?p17zqRx6nSZEQxarbg14BAEIMJa?=
X-Microsoft-Antispam-Message-Info: wRK3aT1eWqtPcFV3ve8SZxH3qt77SdOTjU4LfsVUVHDsuo/9mYQXC0k9arS4gwzfrlvbgL9ie3/1JnodInrjAKNBrp6iNcXjjZddC7nKH6Ro2lRvVyKxqsy0UUcoR8RZrbiTUXsmtShWG4vwKT93M9akziweQpK6h082OOO41HGY8j4u937AiOCKuDoxQfDD
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;6:ranaBh90tZhFF36A3K9hwLR20RKuLKssa1fmQhZu+LsBODtJFpcDcUKhwubcDPS+MDU6j6bMU8RXHgTGevHeVrQCLNDczOSpLd6McNI+/OQ4pIpxV35F3BRqxID9TqZFqx9z1tmBeDcZ1RqugORkLatbj9T7ah5xWIj2qzIWwWnxEc5t+muc36zxMbbw9B05GJAQFJT2+j9Zq+LrBB3R7U15m34+sU31dH+f0mHbvmEV2mkF9BlDfrI9D5Eq0fIOIQgKYuRQHFJPChGhPoz8li4SGdthG3d7TLEHUf5SWCPvt0N3UScNt8wVDB3RWTfe7K/WMlmCNsob70UGCIcAgqXr3ADML5Ua7lNqLVlwAC3c1/xFhud18TR3fC+v/n8MvDNUE3lEDm+gRPcIc5ChkPUgcHkn7aT4txrf+8aj5fbpKBXoLhh91p1OQ/e+5v0bL2j9UbfBfDQBkM1ImiXYTA==;5:XEziK13ysIFVUqHBjCkh2Kqh2nNVLZF/9kuvzern8yWumN7bb0UxdmjB60TTdS1ZxIm2oEN6YLZF08QX4Nnsg39WB5z2FH1Wfg5tpiDP0FaC1yk1bXelg8YZHOgtEQ5y35r+iKc/H3XRNYy/uWOK571croaKUjQT8zngoxfSeEI=;24:ugM9gvE8HJV+zCGefYyS0i4fTh01iqdh5KSDEl3BPYk1xcCvoSqNii01cu4hN/ZqznDc3PtAvtVJSs2KxncCcaLoUU6NmO4ZglpNTuiQDbQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;7:8m978zDIXZI2HuTb5BkWgEZo5gkAp9M+mgaPcqCfWK7hqhLAV/HELnPN3GusmuulZ+f4j2ij7tLMZ3GHd8pPdjSN8QPJ8GKl3s8JKDByTP/NHLCzLKbLHQ+ob2ZiHgiObR6HSyQzojOSzZ3XVQQg/zY0NFiKU+IFZkuPes9Ys4gFAXd1imeFtdq6e/mIYR1z/DRB8po2Wg7yNzIXWSyjyOqDTiNZHfKhCbCp2lf/F8+rLi3E5yQy+LuDIoptCQ5R
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:57:05.6375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ad5a49-3d6f-44e2-c83d-08d59efbb565
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2485
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
