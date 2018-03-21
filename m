Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeCUPgk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:36:40 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com ([40.107.3.102]:54149
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752674AbeCUPgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:36:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: at91rm9200: pullup rx on uart0
Date: Wed, 21 Mar 2018 16:35:51 +0100
Message-Id: <20180321153552.29213-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180321153552.29213-1-peda@axentia.se>
References: <20180321153552.29213-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0053.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::21) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c6f967a-c401-4179-35c6-08d58f417b80
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:cnRXUuW9TmsTdlNFEdrXLtjFJnl91ApGE8uThibKCvFuBcHIJ9NwjReuhS+tljpbdCfylXMD0icpqDA1KJNtivMSPMQDcbX9WJaP5y8f1cyous7m/pZW4vsh/DGTbKbXF1dZNlWuIRBfnVHXSI86AqmbnV2QZ0l07t4uc0Kj3FDIu6ste+3kHbGMjQwe92iKAH6eMQbn+jl2NJTWbptZT7qzj3mosYclE+sh+sIfNlKJWlgrGDUPpkV1Stezgkpj;25:262WnI99Hojv0mpi1FjplbUc6+rAEuUsOa4B8AaQI8b4xzY8bQ6v/NOFpYM7m8ojeZW5mqyFLhciAJkDYLIF800M85XfnOe/IZ0ZM8Nf/CrL4QMNg1+4aYKtogvCpyjl8PNHOftsysTBsKHUFmA2BiwyxKV32z/UF3KBKVSVbMl111jAJZWoUJnRAsDrtXIdGM75QWaBJNAvaPC9GQYTJzG1wn7mh/tTGFKGFr4oXBYoHqqNEIn9HkbtRFYv5gQfuICUd8F/fib04NVdzyNgLS5JxDy84LgpRRlITLAFlnFUkckgBqO9tgOdVWKZ3s8tJM+Ms0hQUP6L8czHXHhfFQ==;31:JCIMTbMeZ0ZLp9OnAZT54Zkmj7DTk1QrHtvmQWzDk6CtgKzkwRxfSt//1xgQf3a1gsgtX+of1gmLG/8PWSn74MOipT8pzL/0raKKacRI87clYJscoiUsvWrJYLDyAmThvDgzhZcD4xcSpvq/BgnN7sbfN1lNHSx2WhKyaY12DkVn0of+wqamZ9zxYDWe1pFm2jkvvHvmvedvAb6waEwN4TcY46s3hyfX6vbQd9zHTJ0=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779D822B96A3CA0EFB1E456BCAA0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501324)(52105095)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:fCtkNkNzBGIbU3sREkp9vQofRGefp5JSzgYwWiaXhNtFGn0W5dOW2T6cL0RhB/dbggjULdJmgvLYJXsdozhmCa9ItbDgdrWr0A/jkiUa0iceJSV+aKlzTDKD8rPELgOD7N8GNX58LCmUi/fHbqeO2y6JNLkyoWDRyNdvfKlUx4DtBzozYAPzJG6eJtosnVDBZpqEW7u3BwI/7e+KRODxj2oN/ua38BSyHeK/MFcbiMH+dKAml0dVdHdJ3qzAJqgzfsbNG8V4QP9tWz0GFmnbew==
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39830400003)(189003)(199004)(6916009)(2950100002)(6666003)(16586007)(53936002)(54906003)(36756003)(16526019)(186003)(8676002)(68736007)(6512007)(7736002)(26005)(48376002)(316002)(47776003)(478600001)(52116002)(6486002)(305945005)(50466002)(51416003)(81156014)(76176011)(2361001)(86362001)(8936002)(386003)(4326008)(5660300001)(81166006)(6116002)(3846002)(105586002)(66066001)(97736004)(6506007)(1076002)(74482002)(50226002)(2351001)(106356001)(2906002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:lnEz/OueZ8yKaETtyAJSsoe1ylfATBSrZuTab3L?=
 =?us-ascii?Q?fKkyLH/UNfGuLE0ZQjOgJ9T3Yq/lk4h1MAjufunK3hoSI2cYa5xd+XTkOCkX?=
 =?us-ascii?Q?mIN4hUAnDdyUneMf9QQPbOy3z89wF8CKM8BQKLA9aFo6VX4Nd2r3QdlBBEXn?=
 =?us-ascii?Q?33oqhmuQHvB6p0nk2qCdOUi3znoGx0qLUN6x19DyNcv14euKuH2hTJqrB1ST?=
 =?us-ascii?Q?f1Q6FlogyDMbbbrLABq4+0WunuAlWIEOQSEx0oivN0J63bIowKqQTpWieav8?=
 =?us-ascii?Q?ikAePRBBA5MWTvjPyv8sRTnN0dWQEy0WEAC+Nk9acD6iG8evFKpKZd3ZcPTe?=
 =?us-ascii?Q?8heW/wjPvViwFMFIk3dPHUJktH5dDnzMrulcQRd1KuUDMeP3rF2JzUY98y+Z?=
 =?us-ascii?Q?oj7bVkJWceHpRrp8hPEc/FzB9iEjgsGT2zk6C4cwBjj3pIh+prW7+UX8Q9Q7?=
 =?us-ascii?Q?FAr5p6AbYGQGboAcPR0YF6ZprkfAv2o0or58VBstDeK8gw96SZvzAv4/YYjT?=
 =?us-ascii?Q?HZ5gjN8TW0NGa2cX4hhl3tqaMFBkmBjxrw93jcW6GLq0/iNhRBjteNAA0nir?=
 =?us-ascii?Q?y51lX2tXR1HUZkSMWEMz89cN5FtNTUE4zHw2clPmdloZ9JANuu2LbUdZpBzH?=
 =?us-ascii?Q?9vXGR+xeMXbuVP3ITOUtbIjSOlEaa/PE8HYMUJBaDLwawc1DGAtN/qz5r1Fq?=
 =?us-ascii?Q?m4G5piVYvpeCVYnW0950o2kmG3hNZtD8EO2+kPNbBi7daIyFrn2tj1PIVqLa?=
 =?us-ascii?Q?Qk2UXnYx+5RQh0k3borlqZEFo6yenu7Hi09WZFq6JJJe41m7BL6/3WT8W00K?=
 =?us-ascii?Q?NjeWrGUfy+HIVNJfDwZAk6hwlVkaoEGuEB3sS06oKw4dn/5MjQ6MkIIH7pCH?=
 =?us-ascii?Q?dIlnSusFMq2UDE1mER79LcCRrndZZ86Gc8rh0I52uwQPrN//v9ApRgU9zs1v?=
 =?us-ascii?Q?yrhclP8xok1JeNclde48nkUFESCtrCdWKAjoicSWJ7BcyHkAPuX6deT4JCr+?=
 =?us-ascii?Q?XR99EHnYnJLtlIn3WN9xt2yoxa3hF7x1fPfFRp9lS7r17nzUUKUE1IirOIX9?=
 =?us-ascii?Q?0JbsVHD1YVzTNc/R49tRpVhOAHMUFCpjks2GWBWKUKOAzzGz48YY1Ihsh1G0?=
 =?us-ascii?Q?f7+pYjvKWuGl6Rx3yRv1OaKAhOHXO0T7Z5O+vIKbdTol1oYCrZKP6E/EBm0P?=
 =?us-ascii?Q?n+/upYoDDCgjD661gdsqU4kHBVFNPUUx0/c+A725Bbo6PNB4K+kiK9dh0XA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: UGU6Z2GvzXV46z/N7hRWlZGcydyACfqw5t6FVsf0ec8qHH9kaZptneCNQNERZBVgN6EomSYJmNl2sAs1z8Oyl17Ur9omj5gONUpveHYwS/u4KaucWaDXBt316YL1Lr+jq89ieoXAp1JpJjSOxV7XLlEROJ2LQhlhC1IjxiyOBo+gp6T3ZJpF0d/u437mDgcS
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:1bD9CCGcwql0CeyzTs6PlarhS6wEMdeRDC4YP55ynETudbDgsFRGBLl5WdR9EvPv+PrJnfhKqA1q+Gs8RkS5rs4opffGOFXG2IaavNId+Ci0fhDsdWBCpkdLPpcCvXmnKaugE/Kx+2IqNY6Rw8QnIJltu0kJcfJPIbN7+3O0Mmmv/qZ/xCwMoo4OpbEPGpKz1GGTiSns1uMrn43HiWOVg1b5oQOp0NPg6qG/hqUnl3d0Wx1QMwpJNnQzljxLe9KJfvZlgCvr3y3FjbJFBJj2d38XPRnhJh7Xuprk41tRfESSd2Y5kB8n0pfeGKrQr7bzaij2VG/izPnozO4XiFH0wXY6NCHWYvfQZJBDWV5xIrQ=;5:T1KbulvV6VWPGdd/9ywhHLD+803k6MO1xxSxnRN84SkU9v4iMtbo0Md8Sm6Udg8ESfmpgnoGIo62SK5l5vPXOmvJ02kktfAn+BuQIb++71TCJSPpu1hDiJdGOZRdwrcszGtoYAO1yAQOEAS8f3vgFCEyDeD4mfoWtIiR07WIYaY=;24:N3DT3rrJbUTcyHFVhNS4hpIHJt2S1jJkSfdUAv6C5dbyBKArZi4QchGRjtRR+khl/h0iZI3v5cqGxPWMM0qEPOxTPkIW45FyblPboVHBplo=;7:OMUQeuYIZU45DZPNYZP+YgA4flaXTDh03310P+XPjfL3nEeBOLUMZrEYx1IFZwkaNdwpllHwa97a2wAEp+g6vEXgCAiX368U6qiDGYwJSWJcZZg0107DXpyIHJrdgaFsa6DXLyBcrovXS8oLxXFYyvl9KIkV4AusX6ZSmOG23UkqpHsM5H2BijorRhCdifX85CMhRIS8TgHSPvswIt0txKf0bQGkKPhebwZ7Pv6T9EzFhaI+7Eq1lPLRUbqF5Sin
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 15:36:14.8095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6f967a-c401-4179-35c6-08d58f417b80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency with all other serial pins, add this pullup. It also
prevents the signal from floating and so consuming a useless extra amount
of power in crowbarred state if nothing is connected to RX.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 3f3149c156a8..2ad69a7fbc00 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -493,8 +493,8 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOA 17 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA17 periph A */
-							 AT91_PIOA 18 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA18 periph A */
+							<AT91_PIOA 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 18 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_uart0_cts: uart0_cts-0 {
-- 
2.11.0
