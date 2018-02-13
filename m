Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965358AbeBMRzr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:55:47 -0500
Received: from mail-dm3nam03on0086.outbound.protection.outlook.com ([104.47.41.86]:42736
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965158AbeBMRzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:55:45 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <andy.shevchenko@gmail.com>,
        <fabio.estevam@nxp.com>, <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <daniel.baluta@gmail.com>
Subject: [PATCH v4 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
Date: Tue, 13 Feb 2018 16:29:34 +0200
Message-ID: <1518532174-11350-3-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
References: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630181432077316;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(346002)(376002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(305945005)(81166006)(81156014)(8676002)(68736007)(356003)(48376002)(956003)(106466001)(26005)(47776003)(105606002)(97736004)(50466002)(336011)(316002)(51416003)(26826003)(450100002)(110136005)(2201001)(16586007)(85426001)(86362001)(76176011)(104016004)(498600001)(53936002)(54906003)(36756003)(4326008)(8936002)(107886003)(50226002)(6666003)(5660300001)(2950100002)(2906002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0301MB0596;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD030;1:uPl8p2l4rPirONtaIk1eIRSz3BloOMt5DGZKUsDuGH1i71nOd3DewrQh2LPQPZNsg1UHB6Z1kjqQqthvQoQ+VYPGS+NNVyHcNZpBs5OUPxEDi91J5Dy7+G27QUdCQVbZ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58f48e7-304c-44b2-4aa5-08d5730b006f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BN1PR0301MB0596;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0596;3:ITbIZP5d3nGLUdqwld/jramDxUqPceI1QqPLBtSJFUcs0vD2MuLGdcV8POw9ZvSMUBswHYZuLF0ca/HmA2lpRL2suceB5+0xO5TSvTLBsJ2DTmJjSazSRr8gXAZ++K+iUtyO+RsByvaZJJha/MkVVtpLo3Z8c5ONaXzMmBSkqfsXVTDvy6+eZZg4ovQ40+pK/bVWNsKmKZjEm7Y+/eGXX3t76BmZ7nquH4tGly94q3H6JIeK4Wht69wJixqMB4cvynOI4bvmhd7lwATpzHy1wCn3yz1GUbqWhdNevFtl6Wg1cL8z+bmA4wHfBfP0+JDA5lMbHw9OiYCWhm1NiP4zBAdjZIqvHlbomhM54qYehxU=;25:UDurmdPKVnS+3xksdriKjC2A2S7i8q1YqG2hQtbfTv50aNm5R/Z7acbGmyy5KV9C7FEr/T/iaRk1n2CB/w+HdwmcCJBSzxPWzQrQvuonR9J0pTnWWEBa4lt/8tmfCKoMQe7GsKex/IqymkDg6y5dmUHL6FoRgfkhQ09Fm25h+81LQxs7tQbD7Po0cPQfhZoQLp7qUreQ+NZea5lQK/mfPQvfaRbNYVn9SbwbMlBwVFEBnipUx+OevNKzixQF0hFOSUE9CZU19nK2fEU+m2bE7PQmHOuZpDC2eadBOiAQvuGUy4Qniz6UFj6ozo6+syPrwmmjN5mU1HZvqcbHE+Dvcg==
X-MS-TrafficTypeDiagnostic: BN1PR0301MB0596:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0596;31:DdAIPQwuAc7QBEkipW31AkhP5kspRFVCiL2xhG8wFH2fJl/2Rybt0x4EK6cjbzFbQW+pZ+2P4QfrI3oOl6uIS8O1nsH4grB8EjrL3MnZBOE7B7U3J+6St6cBVIChl2ltyHbVcJhtAqFaWWivWhz1/r0PzfhGfSBX1b1K27GvzOT8wAmV6Zoi7qkmb1QjTZ1KE6ugX7RRucMoUjx8srKkJv8hEgFv7GciCFi/zjftBxk=;4:lzhiA+zLkr80v1c1bBW667A1CRpIWxDnlQHETdnU8B0X9/uAc5Ck+EBtTij7xFa3LTwq/VnzMr5fx8rhkcRlbqoN7IDVTljrBbHhdFL9iAvdxeLiU5INKxB/eDPi5XVAlCuBbKy5PQJmCtOwBfDp76AKocSHQi/9Mn3408jp+kMjpjxTxqE2o8FRzPPditUgFEXVs5PECbWuNdWbJ0BgiD5o4bVyNI8XXWu4wZIXw7jpRL2P9UnqQfnvEwuNR1G7dosf1zkoLDM4LcGn2oOLem+QrB47sGZFzf0kDYl67DPoslVo9YFfIa5+S6hCROKW
X-Microsoft-Antispam-PRVS: <BN1PR0301MB0596AB6077599487D2DB85CCF9F60@BN1PR0301MB0596.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6055026)(6096035)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123561025)(20161123563025)(20161123565025)(201708071742011);SRVR:BN1PR0301MB0596;BCL:0;PCL:0;RULEID:(400006);SRVR:BN1PR0301MB0596;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR0301MB0596;23:El5FgF0pverWR6mc3kMTyt51afqEqIHoQQw0FUZ?=
 =?us-ascii?Q?COxnDcQsyR8LcazlUmFrcg7FDP+VDZnjhDJNNj1aI2fxXyDc2zNO5nGy7zxL?=
 =?us-ascii?Q?oJZiBM5nmV6JPBmW6WBNO/TFKNQgujV+bRRnhYbInhTEUIqgmdC/jHu306ca?=
 =?us-ascii?Q?UwejT/1XnCJA3WChMi1H7lBQJ+DBWFQNUXXQ0IxDT1Qu6DWBlbaM+XguSLfx?=
 =?us-ascii?Q?dq2aidCx+rvlnavO0JSwB2KjCnIoRG7UkUMaGIosA4vf7yElaJSKQfDbEfPX?=
 =?us-ascii?Q?Tu1WKdsEfbAXAr6bPkqIZNnMQiQ07XCeS+SqNw1TKGFJu8wyclqPpI6jzYVW?=
 =?us-ascii?Q?drPDJ9UQcsrJ0UOgcfhilPzWpys2NfqQxox8SuFB6tBni0dubFrinLuT9scb?=
 =?us-ascii?Q?GG0y8D31qUL5vtQsEzIPsfCN83epCj48JeuIaHTzNpsNktz1+NGqLz7HoVVt?=
 =?us-ascii?Q?V4YSMsZsHSywQvBfh4xusfewGJkht59ncQ4soq5QZBsdApwOM2NDfGUAfshN?=
 =?us-ascii?Q?mEJ1kYY+lM5wc6YZvXlG3Yk3qY4PDz1ZQdEWL7E9VGbIV5BE36NrYfvKy7zK?=
 =?us-ascii?Q?A1oXZyvFaz5w1TrYxNEp5FHfKAXqzfqfK85lv+AVhegxchtcO5NRVQSbx4TW?=
 =?us-ascii?Q?Yv7ZhO5hAk4aiufwSMqrqIwZi68IPRzPNwBNZNy/NBTYQTQeJSR5W7Q2Sz/M?=
 =?us-ascii?Q?teMq/l1oRA503iroH37Z85Hn0KKDB4nQlf9jRvbCKhteKEdeemyDG0iLferv?=
 =?us-ascii?Q?c4Y1XVU0oZXVCHd5uJ1w+ZNOZ3Ljg3hYA/KGu6V2d3SVtq9bsu5xuDJsUXQL?=
 =?us-ascii?Q?eFfiv9tBpPKzknHQMj8bReskGM8923eyTuief0khhJQj7V3Chy3FDlOc4YGA?=
 =?us-ascii?Q?7u4gyWNx+gTUUyNRj2f0h1G6I2nqiwQLG0JnB1YOiSCzEEN77mOVuufc5X6J?=
 =?us-ascii?Q?C5mPqgv3za/p4whL+2lvk8y05jF2x5ufC9LotEStkMy4UxPk/5TT6qt4lCPu?=
 =?us-ascii?Q?aH38//PBU7Ol4p6oJbw8iEh/BhN8N5mWpTO1t+YSqbEe6orXbnTdpOych+26?=
 =?us-ascii?Q?i2Km5kxO+ZcbaGotFaBCfV1Y1f1fJiiq5FNZJT9jwfBD3pbu7vgGoybkzBaO?=
 =?us-ascii?Q?QiJgeVzEhv36YQNxtKYNojDzkCww7PoxIQLgbim24FC4FTql5oZ9lkw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0596;6:5K+hS7zuE2VQsH0ksu6Jq0ljKHouTTb+h5pYwSSboBLIKRDF4zFlYr1XiknVI7n72xMAaxXD3m+cSlLgWm1PC3/9xQyGVmlKswV3P0XljGe96HFOrguUZ+WXJELhk8xMSyLf/yJF+h2AZLAye2oftvIxsihPRrDPHip4SoWxWfDvVutPbKMxEMgx+UOypoPRYW5g+4H42oAMl8Vr8EygSpeZEajwO7eV/t42lX4h4E1hPxt2+y5fbiK0EwJnVzZOk0v3YGkfw756Z8R44IIErmG7t8Zk2BsXGOMzL+Db65aPTtfZ9ytqo8EtprQYenGjNu1a462Ga3aaREUXz5ToCRelrR11UA6bB7ZjyODunZ4=;5:4WkpHBVCoLgJ2/59PE/eFy4+bEBDk/Jjk+pHRrcuMFvIIzqXGgv+bQ3n0XTNFS9iCV5tMiOedYx5E4p6BnRf/02d4LN7ZAng6sVEPAKJSa+ZOvAsoDuxdMoqIAQ3HHkwM4+dYMFhe0WP4GAyVFrVtuHkC4m9Vn6x2tChI0TQw98=;24:bGJSXmT3cvn9TK2oImiHMyVW2PbBxyvMlexSO4AdVaMrb9476IJJDkaPPTVlVqSoZApewqHZIHoYqGAS+P5FTylOAB0LQoC36srY+WgqQGQ=;7:rNl7m8lLpLgW1KHyv98hhw341x1e+UrI2PxKdiqbpVj5KoGCus+Bxj1yLUKtMG1h3vO74O72a2lezBzkuoU2+62M2RdCwM92s9jldfvXqq+4rxIKSFRtpXzZH2UBoeU+sF1qjI9hGQv1tbyRbEt1GrAzRpGhht9sMp0/Tri43LMHrqWSSVpThzh+tCGLsps2mu2P1plz4i8LjrBUnQ3OQRPNCyxk+M3uwD8NyMlwfhuck6HtRsR4udluXDoI+ES2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 17:55:43.0049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58f48e7-304c-44b2-4aa5-08d5730b006f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0301MB0596
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for AK5558 ADC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak5558.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
new file mode 100644
index 0000000..7d67ca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak5558.txt
@@ -0,0 +1,22 @@
+AK5558 8 channel differential 32-bit delta-sigma ADC
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak5558"
+- reg : The I2C address of the device.
+
+Optional properties:
+
+- reset-gpios: A GPIO specifier for the power down & reset pin.
+
+Example:
+
+&i2c {
+	ak5558: adc@10 {
+		compatible = "asahi-kasei,ak5558";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	};
+};
-- 
2.7.4
