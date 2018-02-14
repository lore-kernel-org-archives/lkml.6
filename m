Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031941AbeBNPz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:55:59 -0500
Received: from mail-bn3nam01on0085.outbound.protection.outlook.com ([104.47.33.85]:46880
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031832AbeBNPzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:55:53 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
CC: <mihai.serban@gmail.com>, <linux-imx@nxp.com>, <shegjiu.wang@nxp.com>,
        <daniel.baluta@nxp.com>, <linux-kernel@vger.kernel.org>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v3 2/2] ASoC: ak4458: Add bindings for AK4458 DAC
Date: Wed, 14 Feb 2018 15:21:07 +0200
Message-ID: <1518614467-20613-3-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
References: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630973516278892;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(39380400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(4326008)(305945005)(6666003)(2950100002)(450100002)(47776003)(81166006)(81156014)(8676002)(48376002)(50466002)(97736004)(50226002)(316002)(110136005)(8936002)(36756003)(105606002)(16586007)(5660300001)(26005)(54906003)(2906002)(106466001)(336011)(76176011)(51416003)(68736007)(86362001)(956003)(104016004)(2201001)(26826003)(498600001)(356003)(53936002)(85426001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB468;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC016;1:8/+aIZtYYIX/FG4CY0zAa3k1Ng6mwCVyl2mdmLuRNhB9t6BbYoBTSNb3LGIfAmOaS1eqdZVC0D0ZoMiNoK/q8Cm2a/5TThARnwtrO+Cl7bSUb+eitCO/hrZgDZ4/7bMo
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 471493e6-5262-4e8b-0b0f-08d573c36c55
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BL2PR03MB468;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB468;3:lZcp8C90fhZ6N3PxZIQOUjTO2V6CSQOps3uF8JNWuUr1rIhE/ADVGYd5rL6owqYQY7/5nwWI9MnCVd/Vdsr1Qr+rkAmNKVVQ2FK4h/SPc6sF3rOinZ0AwoHpjHLmZIvdxyD4ouytVvSn8o+0b8fEEdjOLieHCvbxGvZNePc08zIJ/nf6ELOSjRNVj3A5yu7j6jPiKS+TWFd6RD2l8GeIxNOpjkObzM/l3zkVVLmfm6QQS+Z6MQhwn8ERcokRAkRpi2zorN4ffKH0VXiTI+w+M9N4fw5FeIqSpLhCK+MHX0FVVgjsIXACwOlEg9caRfI7d0KOHZq0oOuMrMQK/wL4X+ozmS2RyfsoC0C3kuhFPAg=;25:Hn2dc8RePSST8vho+nagonN//qZrTFIbMcW+yAOvhqvLH0x/xJRPY1npJaXxfl7tyUaNnvQLKk9PIBG+f3ZbpamU/xEilLa1hKqXyc976y+tUZMfPGxaB99ZvGQI5VQLebcDUusb7FUeNA/Cdj0Uw9fjnAZ2nQd3NX8Z83NUInNoTqmE/8+eFooDWg6p0wiObiLnoZ9TdRRO7UsCNR+zMZ6nmHwukAGDh0Ve3OjcOVeVeEINfd1GFI4w0UdHp1MrlOqfX4mseSGAbjpNP1CzcJc2EHJSN7G+K+3ABNJ9NHkVSIa9W6BRw7ZFSKaQWONSEVMoHYVwaHzMr2SIwVsxTQ==
X-MS-TrafficTypeDiagnostic: BL2PR03MB468:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB468;31:6W63965huJ3EFI+pKqOiJvMlSk73Gq4++Uexl8KRgXB9aRH2tD4rcNCgbifgcN4Gkr+hc313mG/R+mh6TJ356KAMK5VSI0x+GfvR7kW8QloRT3M9IsUWyLpbGZDZjFedMLh2twqfv1vPRSpzPnCyStx9WnI24GVxu3+qE4ZPmfxpx+Zy8wd/H7atJid/XR1oIv3aUTZR57eoNFv6waqZkOtTTaFd8xLNudJLodpIMDU=;4:YvtgTje9GUxb4aQPltZf4tyNIL8xUFsNJd6W54ZlANs48ZLSKEMVVtNxsbvZEXybXN0TuKUEh5peVYWXCpGJGhAl0W/MdDiuIeXLvkvz3r4QRXBFzKUmeR9yBYpXOiiN7shH43GnZTk2NeEMoq3+J2bwLTmgUTO3exLuTEWhN8e9yLYdwIzSPX7yx2I9z56+EEQbACsr0O2uLd/+sbzw6Ezx7UrDl44F3Rq++2UoJSc5hgDho9N9jhXJYR+Q7YHvrAFa7X5xuBkp2/ZEIsjEA45N6K3wqHkbl91ummgMcInfHa8KMK4fqgVciFpBveIr
X-Microsoft-Antispam-PRVS: <BL2PR03MB468D4FE66C5B7E7A90879569CF50@BL2PR03MB468.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231101)(944501161)(10201501046)(6055026)(6096035)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123561025)(20161123556025)(20161123563025)(201708071742011);SRVR:BL2PR03MB468;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB468;
X-Forefront-PRVS: 0583A86C08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB468;23:3SD/m6eKFJPdnw0PkaekFmZVsE+Hq11bsAa/XHv+ZW?=
 =?us-ascii?Q?zadjj5f1pkgEH3i82RjOevSfve4NCA1eM7ucB0Egw2366FRmQ2v+yNH9g3/d?=
 =?us-ascii?Q?hk5LNZrnv/r17HsY+w0jaJiZovw5gaLfY5VRnItgC4gvYTZIDcE1pJ2ITjdu?=
 =?us-ascii?Q?bsfOA7+SCHIS2x7kTq6Yg0lQp2Do9gPjL01r6qB7Kl9iXo7pnfCHtDlMbiwe?=
 =?us-ascii?Q?0uqf93ngtSFF4XJfiLq/3A9JDC2dfnuCUdbbMT8BJaqVNb2k1AWyy/L5RKKV?=
 =?us-ascii?Q?Nxyo6gTin9m1qodCjwhiSMYLGi6EP3HIwbilfw/ZOkxv/QsWslW32AkNiYIs?=
 =?us-ascii?Q?cDRIp9TXktLJIcqf34FkLuseL6+huXYRI8qzzKHE0qRa83Xp6D0tRhmJMApR?=
 =?us-ascii?Q?/5k0Q9+eY6s9VT472MTBBdorW3cpgOqVsYbsyWCffkOoc9PzSXIis6oo7DjI?=
 =?us-ascii?Q?FdTb1gu8O4BgWwNaGlJaXFtbt3VwUjOfHPjJf4kqat3aQzU1hhddFILpZTSi?=
 =?us-ascii?Q?10ndX5UiXe7gFPSuWk0GEOyaA9c4w2fPih0w4nmscpm9EtMtztgjIT3ZkKLM?=
 =?us-ascii?Q?mT71BVQLto4qoUXutvJnLc4ZYt9ZNBj8zsJ7s6dyZAsw5Q8FsGkpNZoz2PGJ?=
 =?us-ascii?Q?lbA7kyyZ8yTUkNA7O5RTiPH3rd+zG4cYmLpkcyrIv9xa/bdqy1RI9ZefwaeP?=
 =?us-ascii?Q?5jQ/FdH7mTXW/qJgww/3j6jAhpRhjFyU48BVvYInvMFPtGfrgL/WN4hCLceA?=
 =?us-ascii?Q?VGxyoKph/pHmpQJRH+KHYggJWtxI8JPQM+5TL3/I32Upc3OfxQVNR0y1s6So?=
 =?us-ascii?Q?OLFpGBX7R3mkQtcDLw7Sh4Y6QdIYnZFc58GkP7Wdy0PbtLGIu1YSLXmD6fwg?=
 =?us-ascii?Q?rtKSzPgjPfIVueObrkXGhxM2TGuzb7sFVzWiM3F4jBzV9Arz1TLJ2IkWz9r7?=
 =?us-ascii?Q?aTr56YsSELkV9KdA48/hJsDTsPrnkagDKG5QsowyNDSPhch1eBS9SudXQ1Sw?=
 =?us-ascii?Q?7czcssTL7zl5Jv+kMNxEVYV+KmaYujM8ddD+5kOT3WFcgS1WUBhAAgSGF74h?=
 =?us-ascii?Q?REHUeZrJr3K/utHWxRpAtdF7vKcN18Hi8kTNAXYbeEutOthBl+1tvhwHbI7w?=
 =?us-ascii?Q?nSOkIJ65PKHmPVaFW4Umzb92wkBJZu?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB468;6:BdZieoxak448+rtDpuXR0HG737M3+bPS9Z7LSzbmMA4Dt4DPx0fuVzwMAsGfaZTND1UU9aW6aTqi3/vnBhsmGSHmOSMzk0S1xpO3k+VNYwhlDX5x2H1qSGe1OEYb4NR4fJhZa8NLbH/vT+DOAj6p3lkUlGlUW8p+Ze3cNvZJvT35K8yp3OPj6D063WW/gkpQHoVPf6X/C3RHFpc//iIaTU427wL5FHJCbkTumdc6kl2ML44OMUzHUNh7ne25nCugit9rfsA5/e/avb4k63JDnA2t9NL21L19EtpctinRZ4rnRE+pdTj5WZ1zT2VOtedSqBy4tqBv8WDRHL7u3UxRcKtPVuwFZWAhfx+Q8RZU36E=;5:6aXOozg9c46ThOuv1KcgqZiXxy1ksnqmfBcL5mAAyYW1zuKrJO90eWHdc6F3zi7s5XxufBjRodqL79la9fkWNp2w+4ijB5C1zu9gIm5U+LYb/EJqk5igS4tiADnqvjVs2GVQ1+kbiCjfw5nw55mdIwHfFhybQZ7kHjagjGWAjLY=;24:dtgs+wB2tgaSRJNi2G3fIsWHQ4SYGrIuUF2fBLqTSKovVAt2bpZIgj8P9IqnCt+QDWexHvSA14cHdxYbbPY7rWUaikRBELVIyFM35HzOahQ=;7:ROIjqe0PlmFzjrbdAKgDPMIBMJeX0aUkUFFpCmiH29E0F3e9FPHWCxoPiYoAE2gg8NwNJ72msIiOnac0tpsbE1ZI/M7ryiQUrmbxfK+Mo0Xj4hgzyGGL3oZ2JJG/KLB/+ay4RQw7uLGKi9yBUcfTXdFkE5JAz1AF5IQ1DyZx2/jmcpijiSR3V0h3sWqVLkbF3kNXRk9vJxDCB7SomTC1CjCUpIYU9G0mcua7W/Ijl+OcQlf7AqupqRQ4UywI/VCl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 15:55:50.6607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471493e6-5262-4e8b-0b0f-08d573c36c55
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB468
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for AK4458 DAC

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
new file mode 100644
index 0000000..7839be7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -0,0 +1,23 @@
+AK4458 audio DAC
+
+This device supports I2C mode.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak4458"
+- reg : The I2C address of the device for I2C
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
