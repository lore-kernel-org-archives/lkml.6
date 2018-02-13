Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965063AbeBMQzw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:55:52 -0500
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:31343
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934546AbeBMQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:55:45 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
CC: <mihai.serban@gmail.com>, <linux-imx@nxp.com>, <shegjiu.wang@nxp.com>,
        <daniel.baluta@nxp.com>, <linux-kernel@vger.kernel.org>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v2 2/2] ASoC: ak4458: Add bindings for AK4458 DAC
Date: Tue, 13 Feb 2018 16:14:48 +0200
Message-ID: <1518531288-2017-3-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
References: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630145433444566;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39860400002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(2201001)(85426001)(81156014)(305945005)(81166006)(5660300001)(26005)(8936002)(336011)(956003)(36756003)(86362001)(104016004)(76176011)(6666003)(106466001)(2950100002)(2906002)(50226002)(50466002)(356003)(8676002)(110136005)(316002)(54906003)(16586007)(51416003)(48376002)(97736004)(105606002)(53936002)(26826003)(450100002)(4326008)(68736007)(498600001)(47776003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB471;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD035;1:2xM/hO8QAiml+ldpPyPIhhnKsKWfzZqOz5+O2DZIYStr4JYf+z/zfez/zHGC0ROYQIZgXcHvSi0UsqOhRvnbIhf0+P2xThWWd/UAW3uwLcVt8DQKqg57rwV4cB+gsZRE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a36f67b6-62df-4ecf-15ce-08d573029eaf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB471;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB471;3:ccSw8l0+lkYCC/RaAiBurE5pKRT/H8fRCtnb+TcZLkb3VBf4u7YD1MQbqIUUW5o8bjqaAbiJQEO/0iZoY/xgbID0PZYxLmmfBJH5j+VyiMpgazi6J1YGByG6b4ofSpeBBXtntbRRDrL0CVIN1mm8DIuhh2CwFqgL6xb6NmQVd0SejazTTHy1zK88iY0R77kJhKpM95CTxRPyntAgMMXLGwniqhwfV/hM/yiMZ0HrO3+NCxSj+bvLuc27PdLEnBGk2uRLJJCeaCQ9HsAiRRJciSDJoc2mt4LYs/SYPC2HenANWjwVpaeLEVpD0iOaZgMUx4KfQUYUX0VJk9A0yrgMxSUtMudSg7Xcs8vaBA6+FsQ=;25:X0iJtmr8tNxPjLDoirJVPFzauTYJiGET1+uPAOrIyZ5aZaGLHbAXmq/v4qCj13y2Tt07rGQVOT9x7R6eKoWY7x4VEco6bE02EztqFZ52twWbykaj5vU7X5jIlgtvAxmaiPwodW6cE64R7gIix0V1n6j2e3V/L5mAKrKa2hzQF6EHWltQSNTLMlCeraBnfTu3XedIYnFmV9zX4T/iU54qXXr/Z+GhpiOUXDhH9+doJE0ePQ0lmh6DTQO39CQmP/jZQueekJxilCDkWcQyG9majG0VXxAxFGq78xaOtnocDfoi8/5YTdetUU92KGB3gST3ERA1hZvjtT+siWdgLSZFjw==
X-MS-TrafficTypeDiagnostic: BLUPR03MB471:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB471;31:nGogOw5/VJfgYiySvQAekQQlGLwshtfV688xjOj5MsNJUIYL0huRd3ekREesRMSxTOZVD9ybfhhKIINm23FEcc5dQDxyOYae84skRe59rKKuCfuIap6bnZ5ro9bMKCaaKU4Qib3aSrYrf+cyc0Z+CuMmWnmNZZAzDljyAOrpE95Sw5WWq1d63alMBfPfmttjqsCqhi4BHBpEJApFmFWaviMD1N2Hyl+LjtHxvNW8Rys=;4:UtsraEXpO5usWbo/7JIY38g0vhIt0t4edBvlBdg1HpSZvbRfMmeZ3SFwgEU52p48ce2hTts0mPwGZjORPPHJjiuAbG1yxeBAeEaF+55GPBheJdfKEaV7LlQXDKM4O1Kk6SnGZFXajPBc8u1xdycKxbIYhtbDdO906+gpaa8PLbfZHNbK/NiyFnrCjiYTbwrHtn4w3XD8wNj3iwo7P2L0im0eQl8P7mf75uR255hehItvEIJha7vmueCWWHojCAj/QsTXI7eXNpk9Bhk7kSr2NOpMwWZuF8gqr8HXE3jDPWO/Pmf8gXr80qHyD6kekN8V
X-Microsoft-Antispam-PRVS: <BLUPR03MB4718378054BBDB050ED02C69CF60@BLUPR03MB471.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6096035)(20161123563025)(20161123556025)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123559100)(201708071742011);SRVR:BLUPR03MB471;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB471;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB471;23:08Oq9dyEOcoxgyAFl7vxr6hZsvK35+juFCi1sxvsrY?=
 =?us-ascii?Q?4g06CC0EMxdqymdTJfRVajq7ql+9fEh1jEr/GgmmSpI51WEnXlr2GYMYZknV?=
 =?us-ascii?Q?FJ4OohJcQIcJr7+SAoPsp4D5AhLVuj8Y88vmKp4N2YShaAQ196/WsJSqfNMU?=
 =?us-ascii?Q?j3QSwXGeco6I8oVjsECRt6x/2rtvQ0tna6ytNuoN3S8ZnZHJmqd6dIXUZ1Cf?=
 =?us-ascii?Q?e0CNwcAMUEtfSwDX2EtwCwedWfqtciC0F4Z9NegwTIZ7SY7jidQrs1xEJpnq?=
 =?us-ascii?Q?Hn72bL+2VDBWZM1ASJQWU+iNDdOratfkzmx4xACk7tASyeX38Veh4H5YE159?=
 =?us-ascii?Q?Db1GsyhUgOT/Fb1Vf8ifgyrlz86jw3v7eN4M6r2tKyMtS8fLR+mTidqbXny1?=
 =?us-ascii?Q?A8Vhxc9ICwpGtXcmPrNXln6zYj8bucml2iLPUFtU66/0RAZfLNa9/upNYTSe?=
 =?us-ascii?Q?HgRf9IYbClWBjEZMx3l/9oK7PyiasVcCge4QvPaJJSbb78Iv6tWOSwq3Ox31?=
 =?us-ascii?Q?2griPqXyz7DTRBrTOAzfXwjLZ0S5dSOaXAZGTy7OIssbKWmjwUAVfBJeCMjG?=
 =?us-ascii?Q?51a6nci+OuzJphSSIYz7wMuOwS/rirshJAAux78OL4pf8pg7Y5v3CK4HKSH5?=
 =?us-ascii?Q?LKDIzP67pDjm4uGj1qkQn+ogaOp0OqfouG6BadltKs4usFiN0Hr5Oy4fWEpe?=
 =?us-ascii?Q?EV3JfoOg57u0HtEMtIjOiZ4svviv01wwFxAkCEvue9YgawYdipOgLbUiT77i?=
 =?us-ascii?Q?D3Qh184Y+1TjOxd3OWyCzE/osBGIgrfA73iQz8/HN+WCM+WskMFuVNiqmXVF?=
 =?us-ascii?Q?qi7hSC5+tejvIwCPxftl+pCJqXhfeZWQAmd+zL9x9I3VWnPaftd9MkK2mGtv?=
 =?us-ascii?Q?89j0rvzT9JsWzMJ45VaokQE/YZbVt9cCjeRNZWYVbNnavYc3pGYrfId5pucL?=
 =?us-ascii?Q?pw7ySJLIm0rnpGbcPA1mREfYYzYUmEkId0zSBeRRtO7VgcjHZyI7XJsF08vV?=
 =?us-ascii?Q?xCMIuosLu2m/XAaKbQMuFNmyJrsc/xfhwfnQWUkvWykg1NbV+dZK2mQY5Jxz?=
 =?us-ascii?Q?xR2jmi3HJL9xjPBpYsAWZ9PsjPTXHgijYnFsq7RmlQyB0iAIq0DgxFKOmaAY?=
 =?us-ascii?Q?T89dZ1Xl6WFD67CNQGH50GHlsXM54m?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB471;6:GdqXU1gBzz0rNo55zYRtMesOpRn6SB4+A1Z48I/ftmPkFfvn0sqktMKRJJ6hTtY5q/gdCsbai/fdv4H3MFmh12cPjcrgiouod7FpKKB/L2PtbXgEoVc9Kxq+1xrxl3NGaBMNVAhSh5UMAjpdr3SWjz9uyL+qsOM9/kKZ/7sLa4vhbkwZ68BO4Rj8CIXsmrL+6oBKWzSn8RIvweegofzKhjTCXkE3YIkxJP0M3BMeFBiUEZLrle6ug1mWwQ0JrlghI7tVh8JcfqmNhM9B4gjLl/A+Z4E1NCeVRnbLx6oTe+ZrUg7Qch+Jtjf2OXNDd753VH2MOcyYyWEwtjqekw90q3ohTBM/F9wm/eL/NLmR6MA=;5:Lj0A38I1JFhHC54+Q5S1UE/0BYethP6XdjeXYGmgTkf93AeScAzWQLQc+GuoXoEIqgTfz93VBKK3DDNsTyY2clMnDVRK7JzJR696LUWGq5KUVtvBgneHENQtJ0zxEcN1XzbchgOOOiUi6fPbUyjgrPrZLy7KIrO8JTAnBUN2uXY=;24:JjKvAWbgYYKRH8idP/43hUJHhnI9aw+p2MbFL6oNmNztqd2jo3JNcwnGjnxxLeq4iFKuDiaW77DAXnEhkgn9z5ZRsYKJa4O4NaiODRM6N20=;7:qwbV4htFO91ZvpBXpV7NgpF0wIK/PyaQSVmN9yBJH8lukJEpcnDN3jtHoSWm9Hh/CBIhp9NwS0/PAQJHKz+mKQqsPNSw4o+x5UkNvJy+B3USeqG/4nGrzaCYSlQKby/VNKbAolGFRLNwGt7TZ2ZLA8k8OnwHSr57bTFY/umfn56rA0bK75+gvZiDMHF7AG60oYIc4Ofc3XRmrKSbZIqN0pDM3L7qQD5r4AqvmT0BQHTqPwL9iZT3VTfNCOHYea6w
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 16:55:42.7672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a36f67b6-62df-4ecf-15ce-08d573029eaf
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB471
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
new file mode 100644
index 0000000..9bab245
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -0,0 +1,23 @@
+AK4458 audio DAC
+
+This device supports both I2C and SPI modes.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak4458"
+- reg : The I2C address of the device for I2C, the chip select number for SPI.
+
+Optional properties:
+- reset-gpios: A GPIO specifier for the power down & reset pin
+- mute-gpios: A GPIO specifier for the soft mute pin
+
+Example:
+
+&i2c {
+	ak4458: dac@10 {
+		compatible = "asahi-kasei,ak4458";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>
+		mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>
+	};
+};
-- 
2.7.4
