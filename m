Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeBTLzr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:55:47 -0500
Received: from mail-by2nam01on0058.outbound.protection.outlook.com ([104.47.34.58]:4256
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750710AbeBTLzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:55:44 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <linux-imx@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH 0/2] Fix coding style issues in AK4458 DAC
Date: Tue, 20 Feb 2018 10:56:06 +0200
Message-ID: <1519116968-31759-1-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131636013431767476;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(2906002)(86362001)(50226002)(81166006)(8676002)(81156014)(5660300001)(4326008)(450100002)(53936002)(2201001)(48376002)(68736007)(8936002)(356003)(16586007)(54906003)(110136005)(498600001)(316002)(26826003)(305945005)(85426001)(6666003)(104016004)(106466001)(36756003)(105606002)(956003)(26005)(50466002)(51416003)(336011)(47776003)(97736004)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR03MB1418;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD037;1:YGX0r5XKZ9PyNL7fJ+h87sBJ4nrOqTTVBxYOD398+gfSbRQNNw9hAWYfWm44J/4df+0MKB9afG+nDs23hpvgC58Qt7rzfvXisR4ZrX1lg3sgP/SzYX9jJ3Pjpohjlwbp
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1372fe7-7e03-41ea-c1b4-08d57858deb6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BY1PR03MB1418;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;3:UGW/nBL+SmNQqzYNGh0AgskGqTX72/5lMvgUuPxPTKFk6bqDStaLFfvO9bY8Ywzauo9CPmUaL/UNXroexIFww/BOPQB5GyrGxU75JDRaBvyGnwOXtVLZphzlMf1iMUNAvbu1uYaQo1U10J9E+bRkv+0cDh1qn4g3qQkrVn7gbs/MRD3rgM0tI2X/t8H49OIPc+uelYcq+7RUK5iAa6iPMM/XpXC8bngI8z8Lsy9e7rtqRnbRKfgB3n8jnTrvn4YD1pMYX/tq5ob3u9lXNWkNjq+EJVcreceqmVKLbBpz78wyGtBddjUDMDo9a6f2sVmXR/ulFbR5Xa4fwC3Ql1hpDux5qMUtT3kHiDsMIBUwkWk=;25:/pBvj64WUXdpLfIiHKOT5HouAS5RPMyNZZitOv0pC19HhuR6820YYWhtWhwR0yCScRiO69UcoIGn8FEAlxrZmZVX33TjsJjDeNgwj/leIepGcXKFLVF9ZB1G4s2yVuSmwm9ChnrRxweW68Pta/Sm4WOibzsm4pybMGuTCCnjSCJjn6Z8fjTLvCUp8ZHqrDLVeLkgR/BWuBpM5qBOTQkThCdC/SEEcLR75c5NM4BRAuDL2/YEViDkQIkv1e+TINePZPiEiwTZ6Kzpt3uHxkKrLRaZQz8wYHIQQaatRGfZvMZQ1l9HZGND8KcB75aMLAoA5iAylBXxUy89rQVTbCTg24vcbAzf/JBy8w291cYJnVg=
X-MS-TrafficTypeDiagnostic: BY1PR03MB1418:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;31:0GfRFO0wep13GP2ObrD/PM2Wq4o0i++WkR9AC3NIa/9sS9CiafeLctV7h6FMoB+4ELro898vdEHPkqt7t9lb/+6RTyWlvWSQ2ZWICz4x0OAZYGO6TVmA/lrEwWFgprow9+7QbRCIj6Bevk9WNSLrqOGk8Zqa4SJsXu5dteI2LQAfqsbv+KzoBk4101odYwypo65Omw1lDCh9GWi2Zg0kQOhJV87Dr+y1Muw4a9N5EFc=;4:mCrHUZDB7kHugblHZgDgess9DsZG+AnqqF016fnj+LeXWb2wVEUhqSWD8D2d5G7p5VZXHdPCMZzdtun52DRVnHpmdQc/U4nXc3og00yoR1QGVRSG2kT1wIAXJ1P9T0y6P/7pfnGZ7bNupvodeDjvGpkAARf5gYFwQaDdlHVSjofADkWT8o+o79QefT8nudLmUktPEbge+rfXp+qOasgGxRJ+7dTo6zPeSWTSExeUTUsXkP7ANmEPfemGnJjYmln6EPoFVTmbvsMLKX4dlkYrCA==
X-Microsoft-Antispam-PRVS: <BY1PR03MB1418DD0AF5A4F2BC9FE03CD39CCF0@BY1PR03MB1418.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(3002001)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(20161123559100)(20161123563025)(20161123561025)(20161123565025)(20161123556025)(201708071742011);SRVR:BY1PR03MB1418;BCL:0;PCL:0;RULEID:(400006);SRVR:BY1PR03MB1418;
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR03MB1418;23:MBAKbSp8+8jtiUWOR8bUlYmHiZ6ooKfrlYKfoGXa2?=
 =?us-ascii?Q?ATzJk81XsM3IX/qJQPy00gbOzOUcZwbjk4+TEUXuB88+vhg5tKqrMXOKLXKK?=
 =?us-ascii?Q?jxb1JV7dJDNBKaNSIc/D119eQsR6evpnoQF/PZqVkeGaKnhfHWLRGynvL8lf?=
 =?us-ascii?Q?AP5JpkFvo1nVS/TWFLYQQCA4nc89KlW1syKdCS2fYvxcsmeTktGGiN2obcMw?=
 =?us-ascii?Q?3q2/a0dFgyoFZqbbfJ7XtpjGzTuy2FeSHWstrag6oHsRytvC/Mt71hkMfDoz?=
 =?us-ascii?Q?UzVIt/O3KGvTfOq4u3EKAyLdhkqPf2T23gFD7uXle9FqX7q3WA/IpOINB5aH?=
 =?us-ascii?Q?bFX7vo5H1lp/x3o7j6HGyXk7XG6J4c+wlrj1v+X5isX6CYdFQNs//ZFaJefc?=
 =?us-ascii?Q?XnUdNYzuEkNS+LeeQzXxNylbKADiVhKNCDR2rBY+c7wjx+K9aqhd4dOskjPQ?=
 =?us-ascii?Q?OzcYUVouu541VKDbGRtNXPDFJQhNDf32PqY5E3RKrsW+yzbh1SEQpvgB2Thu?=
 =?us-ascii?Q?AGf3q7Cfv+o74bJQWCu4i0xAuPjm0paRK9qBjihXw+lA01cQ4UXyii33FltJ?=
 =?us-ascii?Q?5vrtW7GFpjEl55xDoQMIC4z3yWHr8iJBqjIOKeH96kGlEuqyghDOIxx2pDcC?=
 =?us-ascii?Q?GXnPG1nqhQaMWhWkn9bno7mjTQ1B2axiEIunmarRnwFyVVpMROkg5FrO68ip?=
 =?us-ascii?Q?4A3dXsm9+XckPfg9sIuF/AOfw24sCu8x9uqtJvYdfYu0bo4j2ulLMviDbydX?=
 =?us-ascii?Q?wym0SNclqdHtW4Za1AruwbHGgpS1JGLifL8hAWeT81dOF5Sdnbw8eUzwl311?=
 =?us-ascii?Q?PQOHTSKLxtWGrdHKV7Oi94m+Iw8q+e/CozuKixe+MUR0fNlY6m2ePkCQ9hEG?=
 =?us-ascii?Q?MshnNX5VpZFC9NGju/npYN4HgoqSgdanH5B/mpZnaEky0DPXUbsYnQi3gExt?=
 =?us-ascii?Q?s885oMzlGmixNI2sKFpjmsU1yFc+RsIez/2zMHkMmcnfu6N2UqI75vpqoYer?=
 =?us-ascii?Q?dBWtnRzSlnSNY2i8mScBpOkvAAUgL4mAXKdsgwvjD/2vJV8ZOkBodZ6NbpI9?=
 =?us-ascii?Q?49TirpTCO3H1BZJMBD6ee2xWMI25EDKrbpkj0Fy0LbNsAK84g=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;6:PKSgOty7aUCuyVGcHrLpzAU1F3CHVqWkv+TrwMil4pTZ/34aF7pvojPtFfzVgGo8RA+JKvvpKSBEYhhocq6SbHrNBsZwekxLt18JUJzn3y2vqJzuqUNpiD5AguRicxKBi7nyFTAeAJyQ5IfltR9EDYyilGntghOu2zmxPEglm2kCj+szNmrtYlIWjQL9gVdsIPy3P367Sz6vZ7IOvULn3NT26E8PM3baNi6D7UI+BYpW54FUX679X5LAfLL+KIiLOQpqMu/5/cGO9QwKP/eAuOKOdMhd5HzSLkpvURpP/to1QBvnA1P3JXZ/kNU5JiAtInfsDs8BAjf39OyLBxXsLOopG+/6zsvF56NuA6U29lU=;5:pBeOlykt1mhXq6iVdU7A2LdG/VTZn64nZMfUBxRI2o5gFIwpcf0jU9gNhKC+jfNIlSPaTPbplb9yO6SEhpHo/Wfw35dqsmFOwC1PYDjsrE302VMY+i6nRNhdkisrTi2erVsMg1bTQNVfTVFyVUlCafjWM3f0sJv+HhOhCM7Mssw=;24:HhMgrjKgmdkNOml2dsn4J+eKTHwbaNiFCZCiADFhBG0UNR2HKKKhPBf1HxyE+KFUpGycFYeaCO0OOj9ehtv9enm+8XZDCrvN8cwZYTlVHAE=;7:taSpconnURSjaI0gO3JtcWqYUJCXICS9RQVyIN3EA2splks8Eh6XBHepUaRVgLHzymMjIcyt/7ok6LfLVP8XMilEo2UgMeHb4qHIVlecsxS8UqAQZwVVH44l1OzhiqkmITVQLnR8Enrzy4QUnEI1hPFx7KUbO9I2ccZwtb2bnWy3YRrnpwvr3Sfqy+nDC53ljUt9b6NNWuJ0nRNYfmzx7RCSDq+B5xX7IKRGYfQ2BUmMWKT6BM0fvBTnbfNpBr0b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 11:55:42.9739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1372fe7-7e03-41ea-c1b4-08d57858deb6
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB1418
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify SPDX license comment style and sort headers alphabetically.

Cosmin-Gabriel Samoila (2):
  ASoC: ak4458: Modify SPDX license format
  ASoC: ak4458: Sort headers alphabetically

 sound/soc/codecs/ak4458.c | 23 +++++++++++------------
 sound/soc/codecs/ak4458.h |  2 +-
 2 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.7.4
