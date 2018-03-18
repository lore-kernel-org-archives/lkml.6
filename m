Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeCRD0c (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 23:26:32 -0400
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:24656
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbeCRD02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 23:26:28 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <stefan.wahren@i2se.com>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/2] regulator: pfuze100: update voltage setting for pfuze3000 sw1a
Date: Sun, 18 Mar 2018 11:23:21 +0800
Message-ID: <1521343401-3109-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521343401-3109-1-git-send-email-Anson.Huang@nxp.com>
References: <1521343401-3109-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131658171864351750;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(346002)(376002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(76176011)(54906003)(51416003)(16586007)(316002)(104016004)(4326008)(53936002)(5660300001)(59450400001)(336012)(6306002)(97736004)(77096007)(48376002)(106466001)(72206003)(305945005)(498600001)(85426001)(450100002)(50466002)(356003)(26826003)(110136005)(26005)(8936002)(2201001)(2906002)(86362001)(2950100002)(36756003)(81166006)(81156014)(966005)(50226002)(8676002)(47776003)(15650500001)(68736007)(105606002)(32563001)(2101003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB351;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC005;1:SLYrV1EFrwAZTbQaoRALGHcCxxEnLfiBiouYUchy9NNyZJi6FfOnJGd92zyBI910RxwHfZNQT9pAjCwj9xuQ7ebl7L6UO55avbM7mS6WV6xLxjgtaN8iDPTTJUCf1rtG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cec4dd6-057a-4704-8406-08d58c800837
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM2PR03MB351;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB351;3:fFTIlOk4SYkMKzrOgUgxyQo4jPiKiOlAKR2GQxaJwjfIgP8JoOmC7jht5lXmT9e9w6nkKndugrPWZUwsZsy4bs4ECeblxUL6ehlJPl1XzBJcU2FrSQtYJxJ9qeskq2ZBMNAA8HIJewHIpUv8DzVO0XUKjaMCMiu/erQANhYq0aUl8XNTIv/HybN3Lldtomv+94deOP5RljN1xRLxKZOii3zod+GHGNzDr7bQA/raww7WneEq8O0IzsUff3krury75Q7lzikK9yGFMwkzLbJW5QiQSLn63hUX8mSH7gO1xMX+e9eknxkqbwdge5pBb9mFBT0zA5avfYQAw6mdG6T/S84PoASt7eSXlNfPUp2zIsg=;25:AuLqRRGBjrzw2+W+igQ3LnImHbFeOLuGd6d1jN+z6HgTzZK+CLIgf4R/xl0/ZUfhcrN2nd8dSqs64tSIoQmg15SuXXSdfuQNuU3oSB2/MX/vA2E/YaR4Pdf2JNA1DrRUWApd+KXOCKoDV1T+ooztgggkMAL+OY5pMIx0cRJbsbLjGIY+Nc9dul74CIzk/FbD969MhyvQpoXrD94+KInJAkQ5IusgJ++r9jWZqD8+9ecNVxvK2arOox2Z5copIWi2oN1D3KwQDD6RR8gICaW1NPGbfVe6ZGYBCngORqomQik94HcMEiBCA/JnfOBKWDZ9Oqejq18Aw5yL37kDefkzMg==
X-MS-TrafficTypeDiagnostic: DM2PR03MB351:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB351;31:/m0l92cZH+vSuoI8n3krirnRGVFsfI9rmxwnMl8iv2YkzsPg0alJgyAk53vOMzIDlvwK0El/MlwvZXCoUf1X9YTwItbrZEdS1/X4LW0U1KQ4iHdQugeulDZs4VBxep/L///CLF2IuyW4r6Rb+NEsSz453wAAqydL2pvk3OQ8o95YVsfBu9/UhlnjqmF7LWZuOiEck0mwJJOLDVqtL5Kp9n1V+YVHlTz8FAo0IwciShQ=;4:K1awV9JU40ZCoG7uJoyFqOMe25QZ/3nlCowoPa4Va0Z39T9nXE74IOBWBnJZulXudjSm32uXfiR74sO3owTG6KZ4Dw1U1tTjP3j4uv+ZYlCgqnrj1oj9xcp+XAp7v2dSNsgbyDUCSHsvGgRcrVoZQxAaSRgAiZPVpuxaPc7tOdl/sbGLzcAjH8/o74EcrOqgNuXruhYuhddiklOyTE+87j7mRjUAIGQOv9Kj4E+elRbdAvfaBt5R7pzKDjtPZ8yhxTMpo9qXGtf42J6C4CUJc+Fb4NtM98sow5ItLKvHGd1EXJYQUgqBWQX8gRMcVDIOjz4QTQkaVkxqnPFpxZsnJ543si4tRSVakJ/cVZYcqlw=
X-Microsoft-Antispam-PRVS: <DM2PR03MB35145FA02CD982D34160239F5D50@DM2PR03MB351.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(264314650089876);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(20161123559100)(20161123556025)(201708071742011);SRVR:DM2PR03MB351;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR03MB351;
X-Forefront-PRVS: 06157D541C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB351;23:hQ1rTpHHJjjyFg35w5siscsqOsZYWv7muEU9GSdYY3?=
 =?us-ascii?Q?cfFvp5Hiy00C/2o1u3j+D2B93DqZWHsv5O5TUd3vVb3gkXLg5FZB7JHLH2yd?=
 =?us-ascii?Q?N+pOvAK4GrhDLcto5NeTWbsWhTGy3nwdFxZrfcO4P+Nj38x7noaBGE0W/NT7?=
 =?us-ascii?Q?aKe7UnHwnFx/vpRM1pudjDalmuy0wRc3h5DkAjjjWowx/oU3P3WmYEl5Bm0g?=
 =?us-ascii?Q?KcVSxF6XGimjy59aHs5QmHoiiDPBIGcnpMg8eXwzzx8vCOuwvh1RzyfNYnfR?=
 =?us-ascii?Q?pIGT078YL8CdJ9gpoUykRLCTfgW6bfYmhEeo5GsLDHW3xqegvCKH7JuoVTuw?=
 =?us-ascii?Q?Gw0CNvJSMSEGYTYSV4ZLAcT6g/XnhD5R/QYbfFXHOaIhMCHw56BkoL2SmBLa?=
 =?us-ascii?Q?KPsOR5S0nQvu/cXdxmPBjRjgUAJqHsQfPBFSJ+tG074qgH8HGcsCdg1UxVy5?=
 =?us-ascii?Q?58KT2SH8/pgyEo+Yyxg0CLnMGCiwtV8O4jAS0uzXxzx5v2DFjXJi11+4L6Cs?=
 =?us-ascii?Q?FUsCRxisbRPnqdfni99LfaZ+T+wSUZcF5q/ds/Mh779NYoNBLKIKA0VFvgeT?=
 =?us-ascii?Q?JT+IPQp3gJVLmz+cL9tJNFx767rgvKsmE4Km3TRd6ZpmwC7JZYI1Jyrhal1A?=
 =?us-ascii?Q?gSsnb0b28mWrZ3cOBr9Unmwdpy6C+8zgsRvIkvOWpryx5Kk9Z3UHxqTzarBd?=
 =?us-ascii?Q?Ob+0Fz3PuejKGwdGcNOVO4A+S5foCsWVaJqnxFbdQhVMvpm3+IZYy9o7h01C?=
 =?us-ascii?Q?wxiaOxP6zsQoL+HKAsdMDVmGzfYkn+cG99iGd3NTc9HyA1/7pjpEfH9xL3P6?=
 =?us-ascii?Q?Jzrv0zU/+5+VcLjo345KxtUVrZJSrwbh8jlOSRHrD91CUmBfPBJVm19ZS/uG?=
 =?us-ascii?Q?E2R7UD/c4XG/7Fkk+XHGtEdwTc2yLfu1+0K4oNbgBCVqLCz+A5L7fJl0PZEi?=
 =?us-ascii?Q?NW4SXo7yiLWdPiv3BqUw4y9zVwJGExeZEAfP8BzDn1ETtfKpoEEZWRAsPj7B?=
 =?us-ascii?Q?lgYG00m1T+yxKj8XRVwEiA8vAMgINxCf2qW52Kem/546u/hCcJY48jSYAjn7?=
 =?us-ascii?Q?uHbMog0vkIt7xp4ICxChNd9C2UCYTWkVdkjVZesVbKLB+jHduHxUiwvCP6N7?=
 =?us-ascii?Q?OkVw2G1V3PrSzflsPjo6yGXFhlu09T7ZwJ7xls1nRiDUM2cQ7M9408+Xoxy8?=
 =?us-ascii?Q?A7y0hul1/EW1ooztyz1Kjpt60DuNaVw0CajhPDAP7u5a0tcEmn9cFoI77NUG?=
 =?us-ascii?Q?XIUoUdJflqYvobNPHgRHHRK5i00G/zqxeClWRTTwUaVb5lXXMcbKkXgSy5ow?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: E2CmEIl+KyM++Y4zNGj0rxa3Ser07wZOepnTvAUfC3z9J6B6MIxh/l9fPv/LK+yS99IE3l2TdN5Fb520dnHH6Nb2G+SWcR2OZomz+2VrNtAjBucOg6M8qwNd9f4oMvBn72jRmqB2PeT8U11cokb7QIA9mjplfXOVEOj//1kmbzHKjYKsdUEe6hSLcyl6iekh
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB351;6:UAOOJ9wesbJYo27R+r2wFs+7DfmBn2AEQxiaBT2hGn2h9zBA+TVuOEMLpR5+4wjOka+MHgvyb/4IuTLJDCdvnnp1TYy25wT8MTFR21gObsoM1VeRYz1iJBQ26JNXdp7mJAQV7LK82gdbgfVvNBt803/GbGi80CHgierhTHuD7m4xUII4x0t9VtdwvmaAXkcDwEOZJ0abf8BooX5mNFel2TOtlMQmkbNDSyR/659XK3J3d8r59kgze67YxXZjOlsqNOMJ0b6IatAZY7iMXyC9PSZ/+wbDwLTfDDTlSIVB1NAaUYnS01S3ANOxpDyX/joWC1wxk+EZS/J0z88260QMI5ICvxTDBhJ3MXLOiRFkKTg=;5:yNdsh3CoVlYhAJcIidwVCZpBdfT9cx59R6GOYnP3sLSovaaZ1Ndim+m/17tDMj5iL4gZp1TOcGhU3HmX2jYPmoXGtfhoyD2jCTtiSAm8PfPw/BYERzNmEI0b+VgLN5J7RGDHzWOMsdKLL3rumIlMNK/Wn1HD40DdGB7Vh5o0lJI=;24:69KPphJnO627BJd5Em+Ksh30tP6zZ2uN6CoZ4EQM+IxLZbF6b5TSmyM8QaKwvMGHqWWrEQm9ZyN7aB/xFI8EJaMP+JQM6VaWXpscG+tIAXw=;7:tKKwil/1BPWPdK9W1pSKOL6FivSpCnzk5ZfN0026rrdB3fYMGNTEsU/+PvV2kHwBwMvGszqX6T8WQCwT2ZNKLAuwmNvdkueTBO9l68+Bh/oUlyvEM8dcNMt1MJNM47Nyd2zkVoiiHVpXOYioTDJetMDovLpW8b+tdv8XcHS3uj12jHFjPRPxEHx6cEiK25YN6Whh7ahvvTEUclLpT0/3D0VG/itfcJHAuaFSg+Xok8N3x4OOZzumHeubkC7oRq9R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2018 03:26:26.2791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cec4dd6-057a-4704-8406-08d58c800837
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB351
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfuze3000 datasheet(Rev.9.0) from:

https://www.nxp.com/docs/en/data-sheet/PF3000.pdf

updates sw1a's voltage range, the settings for 1.450V and 1.475V
are replaced with 1.8V and 3.3V:

5b'11110 1.450 (SW1B), 1.8 (SW1A/SW1AB)
5b'11111 1.475 (SW1B), 3.3 (SW1A/SW1AB)

the voltage calculation using steps is NOT available for sw1a now,
use voltage table instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
changes since V1:
	update the latest datasheet link and add version into commit message.
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
