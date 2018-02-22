Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeBVXci (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:32:38 -0500
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:52704
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751317AbeBVXce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:32:34 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v8 3/3] MAINTAINERS: Add entry for drivers/net/ethernet/cavium/octeon/octeon3-*
Date: Thu, 22 Feb 2018 15:32:05 -0800
Message-Id: <20180222233205.28857-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222233205.28857-1-david.daney@cavium.com>
References: <20180222233205.28857-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:3:16::11) To CY4PR07MB3176.namprd07.prod.outlook.com
 (2603:10b6:903:cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96f724c3-89b0-4745-cffb-08d57a4c8b13
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR07MB3176;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;3:+HSiGXtP36O8RWb23uYo8yIlqd7kLCXNUW5Citss+AGuIYlrYJAgPc6PCahjhnSTAx5gofbLm7TQ0FLlH4w3hhw6O6MOPDQjom5QTVg2S1g3pwiK3RjF8sHBxfjrXLX3D7m0cxI5ObVUavE5B1ssp2fh8Kk5wSljrBLG9dZ9kMCThynnzYiUYm5Fnr+YnlXrXruv2BIPybBn23QdxYwq4W/qB1myqaXApu6aGnSYKCnvuG1b1iDOePMuqvbcMafO;25:HlpS5ZBDqXNE1VPw/ExEbRh1kbImcbC6+nFci3rA8Dn8yGn9H5p9bDdGE1ZuFPnjht7mEbwYpnfa7mmAq5FaBLiwMQLSEQDm4EVaMH2h5jFzta2u1ZaXIyr7pgf7dTUCC+KnsYz7swCvHsR5i9lXR6rYuwonvhCy2VZeqoouO3FdDmgmX+ofyBRdZ1f0f/2H9a4aL34kxtFuftvosNX5gzp+JqaFDstRkIY6FdqczaJ3bg7QvBnYhhC8ozb/0gy1vWYQP1mb+1JFCGtOYi5pMtKJT8NrG+bCoT88Vfat/hoepy08d9C5DCdG6JOHNacbR6MfQCerKFHUb/JItJNn2Q==;31:9Plfb2vuxVmQjdno6eXeXb2qSGOGtAEx8eeNa3GMcknaI9jCc2vraxvESj5LWVjC0peNK6LzRxJwm9FkORa9cpkpi8yBwg+K04imBY4UjsH7oeo83+Gv0pYXdfO5+e+FlQAj7rIVE85mT3D3YJnrua66lryYGJjOvTQlHyYNcQ7fWVTaKusCxTD/wepnW3KEb5FPBbfZrtPk9DZBAY3kzTLYhE063kBw38tvNuc7EjM=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3176:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;20:x2uHW4j+JWXLqqjp5/7MTWDjiBJvw7kc6YZ4W3NFqjUpNSVoZuUqTklP57azEq4QE19++0W3H5ClaFANfXYgwSRVNSL14+jfCAg58EGFXLWY9qZ0a/E7BZaDUDDlfAl3M8eqhpRrXElA1LnayFw1zk7bUwQtvEe9RVKQxrXiUQk8v9MWuK4sCa0GkRINDfajiKqnyhUZlcgqzESJ4v/lHQkSYZf9Sjn4iSHbMsyGrMc4asVsfB+zml9LkXRXMarykVg+32uTh3Urvk7aMekMxIfmi4GfL5bzNlTIaPdDfFvWDBzU3YB7VpR81e/LiOL3nKWfRxStMm7XKSrXzp6zUJeGeLA1aCCJY3NMYaxTWifAofTvoKiJ1Ng0AW5qXEkaSRPFjZdBqwt9TkZj9JBEBrztjkzaeNUh5QQyJwG3/29nzxKWhJKS0ki0aY7WcbIpDf5eEsRK/P/trtPuzK6guhLI5IJ6dZ5FkapJ0gOdIJTcrvww0IAzczZJAzWXXpO9;4:HzHgmRa/oYkOhYnR/MeLnCz/ObmDb0Vjn1KrrBgXLaOn7okmq1xt0w+m68sRfxyw1S0egjnbPE+M51yCi9d1bzlhp3j+5DqmkZTMUhsEjfFloo57212sNUQ9aRLdTHg1K8Tj+HE9cwm4SmKA87ZEPBH/wsYqiJmcjx0yGNyQTWHUixAYzq0vcsnOfx8wEB6NdjPbkspzNlJumEO4r0NZau4iHfE/QNyY0aL5cYgnoJrutocVehtAX5Vk/OIXjs5byty9HfD8zxoHYOGVRFa3o4SUAfBCWLO6jbBsB+DIKeY8OWfsVSQb4ONryv4oxrf0
X-Microsoft-Antispam-PRVS: <CY4PR07MB3176F6AA957AF941E837107A97CD0@CY4PR07MB3176.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB3176;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3176;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(316002)(1076002)(5660300001)(6306002)(25786009)(478600001)(305945005)(7416002)(97736004)(68736007)(105586002)(66066001)(53386004)(47776003)(6116002)(3846002)(86362001)(2906002)(53936002)(107886003)(76176011)(2950100002)(16586007)(54906003)(6666003)(50226002)(39060400002)(16526019)(52116002)(6512007)(110136005)(6486002)(4326008)(106356001)(51416003)(8676002)(7736002)(6506007)(386003)(8936002)(53416004)(72206003)(966005)(48376002)(50466002)(81166006)(69596002)(81156014)(186003)(36756003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3176;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3176;23:HPNLdNrvO3kdQy7gwX1OzrL+8cJOZge1OiuIBK9iF?=
 =?us-ascii?Q?gkDcqoiTSrJAtw3NlF210r7ieJf9qLpqImAKYas0sDNJobXfakIk0mkTIExZ?=
 =?us-ascii?Q?D6dYcsFYsj2sfPMWvZtb+hDrDed08dspbuweMhOx1Fy03t6bBvDbjxSRvP6n?=
 =?us-ascii?Q?jfV1buHxy71UlZ32yb1l02oYRC1tZ8jpyVf/NoQOFzRobQ3NKxXc1/O/4MW2?=
 =?us-ascii?Q?+q1tVx4WSjmzuSQ3O3lMOj4iQUVbJxyqddM9VDpwA6iuUOhQDFeGOdgoYI8y?=
 =?us-ascii?Q?+0wpQ4j1odwB9rIVgqexuYYK5QBJL18LUjjXasKCHiwyir/DSYo7ZxrlT4MB?=
 =?us-ascii?Q?3MPgtttgUV4eH19nQJTS/N8AC0BsMPTDMtanTJddUjuvQZ5w9AZEAUfqPWL/?=
 =?us-ascii?Q?9SvxMqqfdmKUxh4lzC6qBwOAR5PautBXDMxEYwUr5Ho7Xlfq7UbShe/yt42S?=
 =?us-ascii?Q?kyu+xyoGRO7mWdnD148WKBX4nOGQjXKCklecUSUIjMPvDZ0K2jNlV26zWRjn?=
 =?us-ascii?Q?depn5B6XovODIl86zkazgo6tYgytfYqubbYPjw7DYmBqY3zaQJq6PyPs97rn?=
 =?us-ascii?Q?hr7CIdTlEYhxyZ4rAN95C9nB51vPzwO7TtB5wZI1kfAKukRKxvfrUetyzATi?=
 =?us-ascii?Q?RhXu82/9iQWCZ/ieM+zTSt47EJ/dfBCUv/pHv1cuM+6Ki5OD3Z4uD7lMLX+4?=
 =?us-ascii?Q?QnIOjZoGp0M9lvP2TvWrZ3duNfscEkKJHCymEesJmcFxUFXfA5xZzq1XEHEC?=
 =?us-ascii?Q?CD+LD7uc8p0occus6aCv0WgG9w0HrcEmN5tIuI5g/N1oed9WI3WvqiqV/mVi?=
 =?us-ascii?Q?CxnYqp7mgTelsO7G92Hn90SUIVI+Ik0m0ERa4+qCMBpxCDtwHk+2gY5q6gL8?=
 =?us-ascii?Q?8d6KhpqjM45oo+cFDd6SIgZIrOexJjtIuR+x0ddXGE56o0fQZA4tbITNBPYN?=
 =?us-ascii?Q?Mc8SFznCuPsDmYQ99N1RTrpvE01TERD1N3Oj2iZM412CL1vsjqEvqoIORECr?=
 =?us-ascii?Q?PTpqWOOk+jb4He4xZ1ovUmiS7qV9BKzTdCer1h2XZADjsa/iTYZ5c6rYX2bD?=
 =?us-ascii?Q?hugZRifGozp/ZMSUQat5pVJ7zDQNEBPKWGfJpmrHYCMjD+u1LePq1tDaNtSZ?=
 =?us-ascii?Q?NctwRD+vc9gLOhUf9HDjNlXDuBtMqv/CEsnOjl1kic1tnAwRG2uOzORJy30P?=
 =?us-ascii?Q?79ybumPb0shpr0KkDd9/sDldZ7oNCf+7KpyXW52hIskGrqm1kWnvrFdmwagd?=
 =?us-ascii?Q?flZheTAoCdqP9fVjD458DFqWzPv+nx55gnbjQ+9cCXiQzvEJkwSDdTABm+0C?=
 =?us-ascii?Q?DlEHdLOjNg5saxthj32cF2+ehULjFNpyn8BJXp6gIFX?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;6:i8m+ScY+tj1LFSNzYNOP+ezuuXUjLR0Mrb6BR3Xft0dmdIP7wgFRSTAdXiy/X0CMYxFzjXA9+wgUBppFLbsiusd/VRtLQjm3MYlFMmyBaJyPCSVoeYk9YjC/2Ow0+duAV8FSQ2sZD4wYxi0aWotyXa2CAGnOrIL9joU2ybgOzYTSLczpAnKomvA0B2GTaMYnNGyOnUebMTafomVcQ1MLyXwJ7+/esyKK8SSlviTrxStU3Le0DrHaLBTJZ9yvGvaPZRnjIp6Er707W7hgASNmsz0hCGL2eaQesGq0NN0lR9DnBDoGpJeUmG364uD693bBuE+4Z42CAVXfcHfP8S1rHnz6yJ/A/oW+lsTAw0Ti88k=;5:010iTuls8UWtXGfdkySk4YdQ7iP/48tXHIpXUfZs8b8yeBRrqKDO1CH9gL5gaOgeClOHr/hwtg/lZl1qlFi96z8OXKeDX9f2qCXxGnhMknQOwbOKx0O58h912tDIHeIQrNqdFfSwwnrdZuaRKOCp4j10qXfgc405Y26kkpTjDjM=;24://tWEaanXfncqJhl9eS6M94f5FHJf+Z+VxXcaFWN3EoCWMzdnTOr/lbUy7GlnoKPWhT+V9a/emj9E9gYd0HmfF1O7Io190TvI2Zg4XySTf4=;7:lzf80Ts/bSySxXKQRNEZDxg2lBVK8Pl7G+d2l4j65yRoaiqM2ZDdNJ9MGyGGoGS+P+RS4Eo5KueXXS6j9UGq7escESCKHSV//U3nQ3UjgvbvPUzfOoUu9EzhDjg/5Z2JWTo1lsC9Pscy0glfogoMFO/HVccTOU6gJa4NSjrRo232Uheu4A0uE/5EftTooJxmYDxjBH1kPziuaE0TXh7iDX8yrmqCISecx6VkwUJyPum3rrrQW/AnUyX3Q4hK387B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:32:30.2071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f724c3-89b0-4745-cffb-08d57a4c8b13
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Daney <david.daney@cavium.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..b36371ae590f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3259,6 +3259,12 @@ W:	http://www.cavium.com
 S:	Supported
 F:	drivers/mmc/host/cavium*
 
+CAVIUM OCTEON-III NETWORK DRIVER
+M:	Steven J. Hill <Steven.Hill@cavium.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/cavium/octeon/octeon3-*
+
 CAVIUM OCTEON-TX CRYPTO DRIVER
 M:	George Cherian <george.cherian@cavium.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.14.3
