Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbeDZHD0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:03:26 -0400
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:28160
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753022AbeDZHDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:03:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 6/6] ARM: imx_v6_v7_defconfig: Select CONFIG_GPIO_MAX732X by default
Date: Thu, 26 Apr 2018 14:58:18 +0800
Message-Id: <1524725898-27974-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
References: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:604:d::30) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:tWff67hZVhv8qZMAO/QiufrnBZa4QA1YtI19cXjcyI/PuEgpoW7bcnhk81/bwgvBpW9IMH6yurHFRQbcWcER0yKI4UIuU3YCJo7A7kfEeUAp6XqKeJ/cJ283eI88eR5pOa3Z0kkfD8XtRiPM6hvHoSNwPsEG4JghS3WtAB7TB2bzj56VQST6bCqAiEb5qbO/1RhBer9Tl937ZgTXDfVt6+kDGQg9Bew2a23HWBbB8jve4qDvCi5Skj1hSWSygrtG;25:lZe5rweECY2T729d5nbno0Unv7xNMCR4ft5ORaX0HRjjyNQCfA24b0zuFMKP/hNhnypp6X+EGRWZXdeDD163i9NHoGQ4xJX5hAcpXqThOFWTHUe12t+yl2q1wELzZQikSUCRpZIY0A2Apv6tt5RCiwuKO9tvQaClIlsU7Z7AWXIBPumV99TknZgUh975TpWr8gudjuwFhZHprKLvRin74+5Bl3YZhfx+6t1He5WyscEBCjtzUkVZTVJR8vQB+ci582xalGkneqb1qpB7apKwumt87LB16X8jeGUgnzBikSCN3rlPiRAyv17hn42WzlU/nscc3LkyXwlb7YjGayTNQA==;31:VM/RFyiF/EsVhfiYJcFQUmyt+A+zkAPIpd4cXsXivYxJBXdvI+VEBucKEjxC4jG38iauM33DslPAZ/9r3UqSCdpjw3ciPzQKU7APq0rp6pd+Z46ye/LoZvdtk6xkmY0MtzkvqbQqNE8n6IFaT4Elpy8rq3EVUtRVjZB7cAXWi60XHYjsBo/jl7W9ECyfdmSrxtpog1HkhpdXNyTK705kiGRC4KUTO0p6KA8tqEsqsK8=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:bWZPOPskPl4gStaEzzMIXx0vURwMYA8GMif75WDSAf6r4GtMNCEHY9tVZ8Koc5IR6PK23QuT2zAT7yyjkElf0n6S8ti/kduDQwI8ymTpuEGKrtn9Yy+F/Z0kZNSI1AKdHUrFjZxY0yZIbKYd5N1SyZLvOn3Udi/dGWX+2O5Xr4Y1qbZ/UmWZeWSl9wHdnK5NR655YxA58IQiOtmZ8E4Pcg4/mTMbc8yqoscjHSiCzMwISqRvnReybUuUXg9MEK+WCsA2Y/6TaNngfsR6ojbmaP8GWKOtfaD8gBF90l6krZRj33bfdfI1xPy7lHqL94KryAEXHE1/N1FrJz4pBg0zNef0RnxDOGRYBsqGvylXzPEZWQ9a0o7FtPNWmuA7rqlgk/76Qp+OLNQA+h3uRd0kh2H72652T2uU2oKXuU/cZ6X1qb6RArI2MBgETjkUX6VS1LJbO7eC5BLMGHPM9eVzKzvEXP7SzAxn0UYVo6i4HQvAtDX/dzhHd9f37cZWIgYN;4:yj6NlG0EbK6EMb7yx1VL5wDIwVUvtE/s+d1Lfq6cjsTAlRQad+Q/uLtiah2ObJuVh47YsYbPfkeMXgC7jiyjjnWfCh9K/CNxOcE58pOY9W1yZREKkMv2YakWlkB7nBuo4S8CJpQDw3nMgamizLARwgnusQuX1tp7KuldpXmdjWBkYIf8nFc6SKVPBAZBGE2n2GIHJtbTWJAY7bzeDVZJboh+9f+wIJZd4Acu6N6mJQZdx7B3z1HIBwH0cwtgtIfYQdLhWrtKjCss10bUzedWYqIJZGeWbq8h4aPmnLeyPhiVIo+SX8ar9hw/h6fy65qa
X-Microsoft-Antispam-PRVS: <VI1PR04MB1327A280F92F38D65042B349F58E0@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(36756003)(2616005)(106356001)(8936002)(11346002)(6486002)(97736004)(956004)(50226002)(25786009)(305945005)(7736002)(8676002)(81166006)(6116002)(478600001)(81156014)(446003)(105586002)(16526019)(6666003)(51416003)(50466002)(3846002)(47776003)(52116002)(386003)(6506007)(6512007)(316002)(16586007)(76176011)(26005)(2906002)(186003)(53936002)(486006)(5660300001)(15760500003)(4326008)(86362001)(48376002)(66066001)(476003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:z8qRxTYHcDPj2AcnI38e4z0x84NPJbtR4SybZLoTf?=
 =?us-ascii?Q?IBrUoEdcTe2+/ALWnP0WYoE74vUaiQJmUNVl+SYtA34rvqkPFs1pp+VhFPLo?=
 =?us-ascii?Q?4HHHt53TUN6vpdjlz+MgjYwYve67pj/dCo5sL6HCXWuZGu4IqKTM/4glRL5N?=
 =?us-ascii?Q?bq6I5YfuOMuG/C1xO49AdL0AvHHDl46DBtjrr2XVhpvuWgTtb/fgmSE2ZoEY?=
 =?us-ascii?Q?oBHtECK/8+DqxS6IlLyno0HbPlcUpJRUQ06J4L5C/p4reYnQv7RfRHxGmpIz?=
 =?us-ascii?Q?1qgbeTQ1FEEWo4RFhldOZ3b5F/gh4l7IotyxWbIRKSz8oDna/7bJAj1xSp2J?=
 =?us-ascii?Q?gXvEPcGewO+4Ljujf9anqRa/FTskQVb/hZWVanLiJkpc2+VOPghqEjhbXIEq?=
 =?us-ascii?Q?DjEjceC3/0IwCPcx8Dx0SiVKSX7jUGpWx/uOEezfQfMESkMe8r1wAdn3nkOw?=
 =?us-ascii?Q?T2Iszke51zh8EgtjeglNY7tUIHEchHV6yN/7p6xCp0R6pe26+CjCuerpy/+S?=
 =?us-ascii?Q?mFQOthQnfTEJ9JLIzA94Xm9YmkRgQh6A4Tjf8fvh+W87eo3DBAU65T3Fc5sE?=
 =?us-ascii?Q?3SPvcjy9tZNAkW6V7NSErxM4+xMeU9RXIpLdBwwb2T7jAp6fXLsZ3DjHem5q?=
 =?us-ascii?Q?0hzSWoGfF6popwXX/dWBDchIyxoJ4YV5+f2PTCxYr4t7YycsbampP6B29utF?=
 =?us-ascii?Q?6OHAdT6UCLeffx0Patm4D6BbsanHrc3G5qp1B5UpCdY9TPAmHZSDrqX4LXzQ?=
 =?us-ascii?Q?slGqGGYMOYwEcmzqRF21uOk7u4DMOPGmrpxIlAmxIzbPAXcIlUNK70BmJp4z?=
 =?us-ascii?Q?KGEmxm+HjEnhAOsr1GZjUUBzj9aiGi/yXHNbd3yapG4nzaYOq/7cWdL+7nch?=
 =?us-ascii?Q?MWX6s+o/2K2C3T6xoPFg791xFm6f3nKhCcw4fJ8y5oh+dq7Uh4BSlKIRXEyy?=
 =?us-ascii?Q?/xobwu/Lftg4iOHnT0tCLwq7YLY6tEU6qVwC/6CgA6h3CihIePZykaRwylp8?=
 =?us-ascii?Q?lZ+Ef1oVQsPPWdrq3edbUibaTh/vZNWXEs42gSd3fiaaYzQONnl7FVyPsQAq?=
 =?us-ascii?Q?4rsvpNXpBisb7ErNLSGgCk4cp5GGuptrAUylv16yTnqboNPlGhpfigJOao9d?=
 =?us-ascii?Q?HkHep2F0gdPyKIC4ZNdOqay8uA7K2I8xxfGLQcBW7j6YRPdfs7DhX1UV1GYR?=
 =?us-ascii?Q?XO5FeBEaxB64CI=3D?=
X-Microsoft-Antispam-Message-Info: 4hb7B2ZNcLSCBCFEyTv7Ohf/BagvEAMmwWWhPPJ1fQ/ZsMtrjBloKSnSFIZDUrBasDmCmM+Wwfr7mekrjHIYm5b+apG26lvPbISmQtEU4L/wyHxh75qmtWnW7BuK5g7+8KZug7AUn89gc/Y7VKKil6LKakbZP/lPd/+maP9HKspRHAiAD/9zt7SMgpzxtVdp
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:nZxsY9vtWGd4AZg8287lqtxBHXUllko6YNR2L1UHIh++M8wtqXBFYKcOa3GCNYZfQab8O8ONs7KWHCEkK6YvQmkT08P/q3nPlUSCPUXlJOxD4ksmPh0wj4Mjnd4YFiIGkVvi4w18TiVx1c2g2wDrtpzPSQ1OmX/YMkBRcYk041tQE0T2SfBdiLzdQzFtf/e2tYOvPx86+XBi+NOBX4VrWbMS7h/2Vl/A0sIhjFY7ERJaVogKmmqOn9m2yZlkzDZpbS9/MMRypion4xL1RimZGK557lBoCSsHlbp7rrFb22Dgf9W0agHFACLPsz/XtUjW0UPvWXRZ8Tu108nD5U0hv/5iIgP+KwWulb8IlDjwq3/91Ifd9d7k8G3iawl22t3yJWPE5ZCICU1nnb7llRiBQx/OhsGX6XXvT7QyZEvyPjIRd1k9+9hPLXmsUugn4FOTcuKINE8Rt6SmqweiULzL8A==;5:nXWchLPB5uPk3dWUmfbdjtQeC1yUGImvQ+ui+T6wID0Ov43zUY+9eoA91pOR65shh3C6HPZMYv9gIBTvCkssqV54k3RAC88lR4YGAvff1qkwd3Xonzz7/VMQ7AGKA5FwPcgoUwTrVkmS/A+GnIXNL3gSgQ48udNilqMi21cVU1c=;24:NRh7aMWG8EikNRCQ6paXI6zuOagL4j5npTbVvXvA5EXFDC1pwKtd3r3+itbh1MHOVvBPKxQ/DTnrhCN9LSYKA5cNhBkyTpbDcwCebQDyCVk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:6tdh7awcIFqO842AWvVXSwlly58vkW1OTmxUAwoSyPvWsfp4jVnT8TYLWROoiwwxITQVdSqEvnzPBQz7ynLNGK2a9uqv0rmPJ4Drih2cApMEEU/uOf0MLPFwegRZ+YDWyyV6YlmMBPmeaFMPVVmCkaqwvRg5533jLfaFfZWOS9q2C0vwillrVrerpzUvNDWfRWF12t3UGkfjSktMEo6kDqyN/XBm063BAeB8e550qGq4YqN3iXvPh3xNQRjGgYGA
X-MS-Office365-Filtering-Correlation-Id: ced45fcb-6c06-48d0-9ce2-08d5ab43c6df
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 07:03:08.5024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced45fcb-6c06-48d0-9ce2-08d5ab43c6df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable max7320 IO expander for i.MX platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V4.
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a30843..8455d39 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -199,6 +199,7 @@ CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_STMPE=y
-- 
2.7.4
