Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeBBUeD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:34:03 -0500
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:7587
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752259AbeBBUdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:33:33 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <andy.shevchenko@gmail.com>,
        <fabio.estevam@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <daniel.baluta@gmail.com>
Subject: [PATCH v2 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
Date: Fri, 2 Feb 2018 18:20:06 +0200
Message-ID: <1517588406-3295-3-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131620772101972863;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(346002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(5660300001)(53936002)(8676002)(86362001)(110136005)(6636002)(26005)(54906003)(316002)(6666003)(2950100002)(2201001)(16586007)(8936002)(81166006)(956003)(356003)(104016004)(50226002)(106466001)(97736004)(305945005)(50466002)(36756003)(47776003)(2906002)(107886003)(498600001)(26826003)(48376002)(336011)(105606002)(51416003)(76176011)(4326008)(450100002)(85426001)(68736007)(81156014)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB468;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD055;1:pfhyWFu/e/26CqrEdnMLn2rboXsrbz6RQ/FJ2pWHhKiLWhoNjvu9uEqdtAWLdRCUzvbrnupCug9J20TERU84EIsIXEeyVEnBeoS3sLkiYu4CIqkwHCdxOFzCTVeVBaps
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af7bd94-023e-481c-637f-08d56a7c38aa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BL2PR03MB468;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB468;3:CpLqsh5Kwu3QaxORR5a7vGf7DNfzV1acyN3kebHukNWwOeRAB3YsczCloESZVIWgO39UJLnYqbDg60kH8iUFhKKfSvNV2gwdYobiwdxA/ik7zW8yoqhP0/YLDSMfNrgNS3+6HSx2lFjn7zwhULdvOAABgbCH5uvk2GWMlD/6OvVfwde0AlsYFTmBG8bBIiveKeQ39Z0JAr3VGZlPPGRXe7W4tupf98AEn+Qd7trtEm7ZGJT4TbCk+ONcv97XmYr+zNYcQpVLwx0ycyNLqxR07utLsuiAqH52z6zl2GbaOxev4j4zj3D2dgqy8xp1Tsb+EyJn5ZgswOxYaF0njHJj8JMmfuitg1FwQ6tyvR7DSCI=;25:M3m1hZ116WWy5Iuc3PhUfVgWqvKdOF89eRcObXIK1Cwe7HqaW+v4ElavaIe6BwcJw/tfV5YbYhScoWIF4HSSq9ZeOHtDaIoLjxfG4UZ2eyvVbaeX5rJfja7u9m+6t1OpVuRudw+06z4iyNqQMvAJ7fr+QFfCK2C6Kl8nuEp31CyVa3xivz9ga7YZq3+yT6rvlliGSTd+93FdUIpbWGPiou4BzKG5u6qk+W0JATqDmpYOJjnTfNc7AdW1Cg34DBrVfdJfW0/CS7xPxKzLExpuZa9tG17J89ld6bxOjw5WWNQ0bsYLTnsDQAqf8wl+ZR/kT3+Q5IU50BDsAx9MDY5p4Q==
X-MS-TrafficTypeDiagnostic: BL2PR03MB468:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB468;31:TkPIbiHfX+9EH/yKD7CQF8cYj3VhNGH0mHJrAfbU6mThvb7lnsyuz8eWOh0JwvuTyQ4z+JxaC1qMm+0o3YI4elG9OnGLvs682YjYDzGjcmGuxmhQK4K5m3Zczl8HJdx92oxZ6ywvbKEzg94vz5HSeW9Pk0Mn35ymyX1BO5DOt939n9RTueH0GC91+u4xsGfEDliO8XKx7omKJ0dFCvjF46EPss7hNshgde5AME1cZDY=;4:s9OoDDf1VI1i8y5h75cXaLa6VVnQiBC9wtxvsmjU1KL4w/6DVZsKi77I1BbAsEGCyAdTZgH5iWdDFOr6IZ5yaN7lK9mWcy/fCsC47pynVpc2M7Oo+Wy2Uuqrq/pRd62EkmYnnUuyrTcuifV4k+bfIa2Htb4rKy05nTjJKzA1j6VRYR/JQhEIlHw4ela+iOt4mHxrvHh5hrGNCsJQ8OTzz2VEM+tt3kcjDzJATfYDClD/ldlgn8rsXx/3U4mwSuiBBQeNKSuNEdYI1L4BTjYi8fJCDGhdyGOjOHUvpZYMyBO7LADTPY85l9rmsKDuSMge
X-Microsoft-Antispam-PRVS: <BL2PR03MB4681AD31BEADC4F079C20A3F9F90@BL2PR03MB468.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6096035)(20161123565025)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123563025)(20161123556025)(201708071742011);SRVR:BL2PR03MB468;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB468;
X-Forefront-PRVS: 05715BE7FD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB468;23:HCOh2VQTnTZern3QOy0WjmBv9N2EcCr8fUY0/DkjrL?=
 =?us-ascii?Q?c9g2RaeAocMB5SsdvOhWOJQKLzwd5IqsJVfNbLsqszwHri1ZFjraK8CZCuYR?=
 =?us-ascii?Q?JZl05n58+wAECTsPFGng3hnuxljabzBvKiv+6r6flijATQnEOXuI0/Zl6/3h?=
 =?us-ascii?Q?GcCrBwUSUAHw/iVq5Dfc961QYPBaC1sc5nJmpe3Imc+Ini4O5pkgtR0zioXI?=
 =?us-ascii?Q?K8YP3hjD2mBmOPebkYi39y+TeB1fCPIs60w7m3cgvXNmkR5S0C2+9nkTCN3J?=
 =?us-ascii?Q?sH4exLdrbPhYhQKoHFIBSLa+ukZSvoPSGfl5IHsYMFv+JN2eaLHwLnNYSOeh?=
 =?us-ascii?Q?ckmMzVj53SGFEmww7EAXDX9mhNpLIsDKHS7FOUWpSqytRAQ18LOIwKfvnDTL?=
 =?us-ascii?Q?kSPIZeXMO9uKgEg7liHh8wNcBEWNoflMPcVAYQo1O+sck1Yy5561rLsFBmze?=
 =?us-ascii?Q?rzyv/Jk4eQFDZkdhAPQ+YSvhfYT775VLBdHcit6jyFyavg1qSbkYiFd+5Qd7?=
 =?us-ascii?Q?vP9qfbiyfnuS7MyGHJfk5xWedEOxqwMcwevVHV2Rlm/D93DtORggNA39nP8q?=
 =?us-ascii?Q?jHcI+NRwkjWVOMxzn8W+47NKUq21XO4F2udZPJDdIdtBY9fsk40XEx5AZrDZ?=
 =?us-ascii?Q?EKtzfaeZ2O2ct0h6vOOpGKcDoErYNYVapyW5V/tgoaxaDBQcKjrQXWBeJWVp?=
 =?us-ascii?Q?6uqcyloSTrffE8IJypXbItEm4wsfpdEQll33N19pJxENtY3Y7X9nGJzkO8+u?=
 =?us-ascii?Q?RmA8pJpfqfBrsj1GgiF6GXUg5v9zbBe6Ko5P3JbkIf81RLjAjXxQytA1Lk16?=
 =?us-ascii?Q?woSO1eC2YOZQk18nt940fmvnhFeADDTDh6tu70S4Gm4PpGkm6mceYA9e5wzd?=
 =?us-ascii?Q?Xg/J5NylVkyHf3vDlwGs1qC8XwmNZTTGXc4FxajeKhjx1+8Zqx+0JP8YtM69?=
 =?us-ascii?Q?jCK4UEDWEJnJ4Dk42rEOOizbmybnDERjwH/K7cT/l3iokhqssQQFdlqFzd+2?=
 =?us-ascii?Q?wwzz9iX7zb5rqgLd8BGl9z47J5L+9e135+Mfpdbo0XRaMLfQOfOdOtpL9c7I?=
 =?us-ascii?Q?8/nC1BaPAfs1Rl4f+tbb2oyzjkXSTzsuL65AoXFtnKR5yFpDJU67ap1KDAVL?=
 =?us-ascii?Q?u+bPU0IzdOB4XAvCjJAJ82y0BNx+N9Eov+71aTiDnbMu270Q26UDjS+jYzdV?=
 =?us-ascii?Q?j4rAHaF9oaw5k=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB468;6:O2lQayBLaJymgYs6CUk/72NN01V7u0yDmQTt+y6P5MRzy0Dl4Jl4ktviP8y0UYd5ge0102sj1gvfQJG+E3NHsoKVQXiOfOy/NxKVEGO9PUVggsGQ1B4T63wdJ2SXB9zpNfFV/YJcSmzawLydmSmfX5tRdNLyt9CgTneLiUVCcB5l4axbsotJ4yPlRum4jNZPU6ycPwtDbv3voeeQLzTzj5zCOnAuZjQjk5nHLssnly/QCFCHxrH0ouUUEeT6a/AMp7BXHRCi5vDO43KkmgI7KTdcLX1vXq8ELrYbFuoRjDJLzTTvGiU6Xjvj1W/nXb0AM7nswnEMMoHpgKSX0tOkEWgV8bJc+bNOgJXMTbJedxM=;5:M1umbUO+2pChlFMno127htuv+y8rM7gK1Q/BgPHpIi6TY+gaxiRsi5ytyyZ6ZqZUNySW1uQiJ9AFO6Kk7HINOTLT51axqkCGr6oO8kLMv8ztCIXHhUwS+pECBPXwc2ai5ZfGSGUcA0vVvO6g72KUR5fxOq96VVPdGy6czpvxc4Q=;24:2dqIfG3YMZX87BH/Nls7GFBSLyMCPl6ns4H8Sj7rrDuidkZj+ry4RVQimqJcdG3uRbxo53MTquQaZs+s2P8szXiWyvessGWKB3ulj7EaKhE=;7:jSQvFJ/ti1YFrIkszOOmsuTWcKN6RLyMBEr0K6+m0qSXsW1WqY+K6CGEn0fwNH1nA4S92WsniL2SPCvKMqYHz2Lateku3ods03Sl9yAUGjGIosu3eUiJT0kESCWdm7Z4lE8cnttMRW4NxLEDDj/j41Oiem90kctzPraPtcmADJTfxRw5QCab0Ju02nszhJX6vKRH7HNrN81zi5B5jLVYsuS26yoqjmbnyjwNB2qRMnUpSBHUJGkFX0O9f5gkHarC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 20:33:29.8073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af7bd94-023e-481c-637f-08d56a7c38aa
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB468
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak5558.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
new file mode 100644
index 0000000..61c85568
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak5558.txt
@@ -0,0 +1,23 @@
+AK5558 8 channel differential 32-bit delta-sigma ADC
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak5558"
+- reg : The I2C address of the device for I2C.
+
+Optional properties:
+
+- reset-gpios: A GPIO specifier for the GPIO controlling
+	the power down & reset pin.
+
+Example:
+
+&i2c {
+	ak5558: ak5558@10 {
+		compatible = "asahi-kasei,ak5558";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	};
+};
-- 
2.7.4
