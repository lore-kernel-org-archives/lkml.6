Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeDZGid (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:38:33 -0400
Received: from mail-sn1nam01on0123.outbound.protection.outlook.com ([104.47.32.123]:10540
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753872AbeDZGiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:38:19 -0400
Authentication-Results: spf=pass (sender IP is 117.103.190.41)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
From: <Yasunari.Takiguchi@sony.com>
To: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tbird20d@gmail.com>, <frowand.list@gmail.com>,
        <Yasunari.Takiguchi@sony.com>, <Masayuki.Yamamoto@sony.com>,
        <Hideki.Nozawa@sony.com>, <Kota.Yonezawa@sony.com>,
        <Toshihiko.Matsumoto@sony.com>, <Satoshi.C.Watanabe@sony.com>
Subject: [PATCH 3/3] [media] cxd2880: Changed version information
Date: Thu, 26 Apr 2018 15:42:52 +0900
Message-ID: <20180426064252.32253-1-Yasunari.Takiguchi@sony.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180426063635.31923-1-Yasunari.Takiguchi@sony.com>
References: <20180426063635.31923-1-Yasunari.Takiguchi@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [43.25.41.244]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.41;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(346002)(39860400002)(2980300002)(438002)(377424004)(189003)(199004)(426003)(126002)(86362001)(956004)(11346002)(2616005)(486006)(476003)(36756003)(66066001)(47776003)(336012)(478600001)(106466001)(72206003)(446003)(50466002)(3846002)(6116002)(48376002)(16526019)(26005)(186003)(76176011)(49486002)(51416003)(59450400001)(5660300001)(6666003)(305945005)(7736002)(316002)(7636002)(110136005)(39060400002)(16586007)(1076002)(107886003)(54906003)(4326008)(2876002)(8676002)(106002)(8936002)(86152003)(2906002)(356003)(246002)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR13MB0457;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg101.jp.sony.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT022;1:DDbVrJMwJ85cWdgoXS49sPf4N9ao8JofS/x7o2mKI6RQCN1iUdyznXtI/YmvjnQkDwyEeOYGDvBfYeQpIyX3Zg56t4pcf9MgTJfsNYU6asDUx+OC4F+fG7EwYVVHYtgl
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY1PR13MB0457;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR13MB0457;3:cpWt/VlxqmdokxIpUhqD/tLonhpJeLmrNb+fqU/4KtgI8SkpwSyiZCKrMDrysLOvl4waUgA2oHFSSMFCEGO4zg42Mh+SairswHIz6IYKK4q47fslHcoWjzo2MtejRhwZz1yoYsr/8eRdz5TgVa67Kvo0v0l9/4ABlu1kx8FtgPKo60gstPm84Qd+PvolQ/0f3ZvQcSeKnMP5Dsh+pfLfILEOQIGnlaFTsbGTtn+dL9huUlqrKgEYUk4VpN62YlrxCBFquUX9Ijj11FjyNYsUCRJVlCsvEF8X8rCq80gR5uBhY7pimg5/iQji0PgUWST7a8MVLV+ZwyaeG7EIWULCczKLxed56PSPB7NKCXIjKoY=;25:WL9TFr7laLisIt2mXjd3nMDDQtHvFPf+02T2XgNhA6a4f7bh6dYJDBNRTjRezj/7xUvGWzbZnwbHFw4uAB1ChMQbC+UQytWgyHuC9eJmw1U7pJ1aTm8dtx3jt6cGF4XB7N2hpA+rL9qX7VgSCYl+Y25RfDGvAXOWVy8TuBV6kgLE28GxTib7KkbCl1kTj/NAukMN6S4AP7V7g8DhsU61pfXbE1OGd+WWbPT/ifk9mmCFRwVr1IY3OACtQdXabNPZQX1FJqJhnWKHnyKdj7V3oLohGWfUzuXQhZIYWTbbY9NkMqaaB4QDNBUPp/u/234c4q8/t54WXN3wVvagUk8hcw==
X-MS-TrafficTypeDiagnostic: CY1PR13MB0457:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR13MB0457;31:BCTt2fnvwdf4X3ZJRs1ubVRYOnXC6MMYv8IHQ1doPvqH2OnkhMo47IabVe6KVWOQ6Qk3+djKKUf0/0Ac72H+Cmfi15XBD8B6iBbXrsW/+skYpEWBme6v77VJcXOQiukjLQsmCa/p6KWJkYncKRzO62YBFr/IKQsPdRSywEKPWIdxg+SUWiuKmUH1o8Ae1EpFRya5LCqRUYe582+yR7DGdvhgspP8jV61pok+8/udQog=;20:4uwPJ0qOiF/rrw3eQX1U/IAbWw2VtHvrX0nnMoP2YzIaqi9KSV5e7uszENfcqJjnjptojVNP8ImzppTN3CpGkpSuEhRWblV5YygZuDNUS3NaYq7BezKpQ2+M1d6sZzZOXxhI7UoxvtSVQ21pdo0xwSCvDZ9oG6C6y1rrcr6N1pinWKlvcCp5Gv9e6bwKxAGxKKfp5N264uEhtZoE8fL3aoTePGfmijpcp+vU8ek7fC2u0NutzC6vsOH79zc5zfP7Djk3XzZRcOSLymR3WRvbAiqQxIC9YcmcbAnYl1wfeqXg099NBSm51250rp34wYsD8gLjdiYBZnXlwTu+JhdaJcGYajipPa5ygY6v2+l2o+I7TUBgs8iqiP9n4kIR84VgN/NLa1j/3Msw1ZZm7j8JMbartuWU6K8V7QRj8AyWK1UPe249d9n6K01XWwFXQ/KRmtghWvNQe/1FYnZG4GRFmG5r2FT/G35jiTFJXqRSyEtLbDZjMVSzV9MHRXx5wQd4
X-Microsoft-Antispam-PRVS: <CY1PR13MB04578A657735299FD7638CDBFD8E0@CY1PR13MB0457.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(11241501184)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR13MB0457;BCL:0;PCL:0;RULEID:;SRVR:CY1PR13MB0457;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR13MB0457;4:3zqQrS38LUt9vlFYGyB3bkM19JYDXLSoDFHNLAXj+KlYSkfCP8j4KX84ZmGkNeAgEOsrqEzzBGM629fwUrCzkpf/yWpiyFivrfXa5X9iY0oops6nW3FenBHNC1DYrVTJQksnnCgP7qQQH6iflplF8y3jHJQrItJHauNTcIXlWUJV91SZDm0wiHvIrFuznmve8aVa+fDp+7UwEPbcsaH6GZhNJASUUnjulSK+yqJvRjTF3BeBTZO8F+w8uOWBdv9vSupUkUdSX/rz9+RhPvtU4jwOi5x2Hhi6pt7UGq+Bm6XKlHMS0faYHn7W4mmqls56
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR13MB0457;23:adJtArDPtcLLndTlvO387yuGo33WBqw2kmOEfI8RS?=
 =?us-ascii?Q?Jmz0qSWGL0p246Act4KZopBnS/NCrP8grSB/ZgkP0/Qz2asyqyNy8w1QDCwn?=
 =?us-ascii?Q?hr6aqZC2eq3EKpPn+WC3xfh62BrEasgTNzk/2UJMJ52f7HT5IKrQy+hb/fIB?=
 =?us-ascii?Q?B09F+I6/cKgjNF4B2jDlubGo03pdV8+BMl3RoZVoUXfUVsF2Ljdlqzo/wky4?=
 =?us-ascii?Q?UHJN+aOtW9tw6nLP0a9C5sZlQgILzthsnRQP6gO/zQ2TRWdNb6+OY89gAkmD?=
 =?us-ascii?Q?wjTjqntPwNQtD8Xp5Wl8mJeozcBM8tAz6dCT5wVkKbTDMtp6SL/2QpUrnolu?=
 =?us-ascii?Q?Wl05TTEJZ8QZVh0OJIvTHbK5WJexodm+BaaKlnrR4/qtye0OMNRSDxDF7wK6?=
 =?us-ascii?Q?MBqX9eFLGYmSw78aqGwi93o46jYXm7pLNDjgtHSIxdI1V5R07Q7cG+r4a3wq?=
 =?us-ascii?Q?U2OUNoyg0Pa5ZQGnGE4iaAvHeR88PWVn9hXTwWNcV95Y1YKwzPtwPvRofDcA?=
 =?us-ascii?Q?ka+1kezVbnx5STq9W/4bFIc76mqVbbJq3SULn+asbo4zneUZ/4dYbG2kpV8a?=
 =?us-ascii?Q?/htFFGsy+Nx5D7dbZ2Iuh7yPGWAemEJOTQvbe6N9kBHuxLLafH489QuibRi/?=
 =?us-ascii?Q?UTvBgbYHLb4xVFHitDHZ0/imQ4u8a8uXP+TM88ZhrYkGXtBCWsRrDNjY9iHr?=
 =?us-ascii?Q?arU8pgcc/D6ABWXwqK3InO13K5U7j5yyTXt2esfJOxnFdMO0SintO6sDqJjm?=
 =?us-ascii?Q?8qk6SlzZLdN2ELtg/AbNgYk7kE7mhY8uMmemQHv74OEBi9KEUSB5WfN5TkiS?=
 =?us-ascii?Q?rml2h9mBARcUu57FfUd1KTrE1GEBFFPdtqDW5DaOPhhaB9bs77LvyWLxu/VY?=
 =?us-ascii?Q?/4bVqIwmDKK2+VKk87RCMnnHTnAS20ddqO0+p8bFvFd3VdMHs1gV4gHNF7qJ?=
 =?us-ascii?Q?M8Q9lgtZdO4uKYI1wKdId2SQOVbNOqNdNTeqo4xicWCKjsef1CPie7rHARg6?=
 =?us-ascii?Q?4JxP0gcdVZR733VPOSTkFWf97nzqmnukjZjZCPdSklYrICOYj6giBtpfqneA?=
 =?us-ascii?Q?tjwbFAb1WpFnzfJcUa0lOdkMYZCVn4FxZI4bnGePLP5vek2IjId1mE5oKh5u?=
 =?us-ascii?Q?g+StmzcluZ0gvkd0bJ9O6OMoBOiraRppEokvtUYSCApvaf6ECDQjiM4eQLc2?=
 =?us-ascii?Q?10/KFS8hhcSGMD60VXoh3xufnS1xYC71OIyb2snWnFNc+/zcKuP1orvicBZY?=
 =?us-ascii?Q?wQYCHHkgQZXR8DbQXKbqanxwoEnPyN8AZw0r8MVTT8wbbGor8DM2zI3476Z+?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: ux/1diVopIBC5/Wdq2k74jyGPw/bdtp5rjL71LOy3jBmSSJcGrjChy6+8MuRtAmthKk8fJpHcUOfOh6vo4bvqkzUwjtEym+JnKuq4fPmsBi7bKMtl9X5fv3OQI90bQswjGKSQC5LNg8xzdmyPPVS089TMDUNwNT1bwETOSqmOjFEUU7qGJYM3qymEqaSsfpG
X-Microsoft-Exchange-Diagnostics: 1;CY1PR13MB0457;6:XFhAUXz+4XQVJ+E0kQVoF5/f/WIOvRQUBWeSGbgNfA9P23zU690H95O8ACBk13MLDstK/qGvNEIaaJORvaMYSK8W2DYy4vS12q0nzfdg9RE5OCAOCklCd9TJhdP9KcaM/GgqQCRydl3KPHsRWZAzshUFKZtaljlnNt0gY9Aoubd7+WkJtSFIZU13H8nRjbhrLazXmhCMYQj6YqwDrFfTP4FQVFlmIyJSnyd+Tw1+gVKmMxc3oc4dZPmcMWpO0Ndu+DcFspSZ9cPS8dDcjEiDSvUWDHv+zR7Vy115ZtCc4rOVyg8DQZ2Tt01ZuIzPXoIl6de5J4OK2SMkNKBh2dPHpbH1uoYKkfCO42ppAA0zhmFhyxfx9TSz542Hc7jn8aDCD0nEXU6HwJhTuo4kOfEbEKHJns8WTJh5oG9Aqd4A4cYNriuFTV5mVyDut+w5hN+Mqj6D6P+OfX8oBSL2NkFt9g==;5:YyVqN0pWSEzWyB7G+VrahzPKfpGoOe5up9jaSQMOqLBjVS1BxU6nefkaDo60S90mHJAzSisuUN4E859ufA4zBFZIl7/qyNIuL7qflUvQ35SZDqqYcT9kjfxogPJGSa0O/03qtOd3RZhueY/H+1mhXBfShFCYbpdt6rDKGr3c7kU=;24:aong1I/5JEGPCIo9HwRa1DJ5J1Vl4l7+HZJsGODBeTosnaJqgrJBm0C8VCEyQeadymXFrJiXVAawFt7MTQuV0YLI1X0d3/HRyqcrf1QQULo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR13MB0457;7:KMKMObdTj3/bhNujgqUeGbAVCjJEFCyqLIX9G601qjrGhenvlJ3vF4Yk6xGJG60EO/t7uiVKQo9taxGqoD0sTcGMBXzpPg2cPAtIKyI7PBrsejs+bFutzjXNVbAllkTC+RyH4PnqU3gpHl0lXSbOXSx9Th5TVs82SZqj4zuyocGYA89XV8dIJphpplY2osgbXTfXq/hQjR1q9o1p6EwoicU9L/Fblvk65Wt36lj+kundGTABoDJ6hKh8aX2dtojY
X-MS-Office365-Filtering-Correlation-Id: a2bdf9ee-32bb-4aa2-454e-08d5ab404b4e
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 06:38:16.8095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bdf9ee-32bb-4aa2-454e-08d5ab404b4e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.41];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR13MB0457
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>

This is the version update for this cxd2880 driver changing. 

Signed-off-by: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
Signed-off-by: Masayuki Yamamoto <Masayuki.Yamamoto@sony.com>
Signed-off-by: Hideki Nozawa <Hideki.Nozawa@sony.com>
Signed-off-by: Kota Yonezawa <Kota.Yonezawa@sony.com>
Signed-off-by: Toshihiko Matsumoto <Toshihiko.Matsumoto@sony.com>
Signed-off-by: Satoshi Watanabe <Satoshi.C.Watanabe@sony.com>
---

[Change list]
    drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_driver_version.h
       -updated version information

 drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_driver_version.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_driver_version.h b/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_driver_version.h
index fab55038b37b..c6d6c8dd16a1 100644
--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_driver_version.h
+++ b/drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_driver_version.h
@@ -7,6 +7,6 @@
  * Copyright (C) 2016, 2017, 2018 Sony Semiconductor Solutions Corporation
  */
 
-#define CXD2880_TNRDMD_DRIVER_VERSION "1.4.1 - 1.0.4"
+#define CXD2880_TNRDMD_DRIVER_VERSION "1.4.1 - 1.0.5"
 
-#define CXD2880_TNRDMD_DRIVER_RELEASE_DATE "2018-01-17"
+#define CXD2880_TNRDMD_DRIVER_RELEASE_DATE "2018-04-25"
-- 
2.15.1
