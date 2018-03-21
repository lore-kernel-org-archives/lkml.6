Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeCUPgo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:36:44 -0400
Received: from mail-eopbgr30124.outbound.protection.outlook.com ([40.107.3.124]:31635
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752560AbeCUPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:36:22 -0400
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
Subject: [PATCH 3/3] ARM: dts: at91sam9260: pullup rx on usart0
Date: Wed, 21 Mar 2018 16:35:52 +0100
Message-Id: <20180321153552.29213-4-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 708feaa5-fb84-4752-d46d-08d58f417ec9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:2//M5NBfjo8yKa2mYoGqxGNe0lUA3wW36N28tivr1Um7i1jg2NHaqGkuKmWcClq7zxzpgtjPbv+t8nMoSCp4SZhGUhK5SvR7TOYM4SOR5a1g204XoQNjviMkBwM5/NLOR8j9nbXvWYIug2mC5nHz05QijllrZv9PD6BcBNUEv6QksBYwFVygJtAZklKWDDKYKVQnowq15PLnMYdJ+teYLnVFePNF28CgsFhKiwUY1utuEtVN8Pdt2htc9kacoGvl;25:YPQhS69lZ4R1peRba4uy021rtg1iitXEcBvoW6Ra9Q7dRm9ntqv0iswWlAhSZ9VJix0QH4c8ZnuqO/792Dd1JdzvX+hWNutII8vBPaRLXWbmHwIz8QuOOwr6A+o2/y/+IBv7HZVtEXudxsEtrusZnZhJ8/AcfufPeNNduhuydjUd47pRXAN/Q9uI7ErSgLBNNDRv6Dqqx2/jpi/NTfnnt7R2FNxbo1+XnNNG/DXFTFGYlRYmtJGPb58luipO7o48DBmdAUqiVWy6X1ZIukwbc4DfabyALLFOKusdw95m9/eR9+oPPStOiYmPO4z6XKPerfoOhk+NT86PI7VcGsxF4g==;31:u7IV06WZnHGJZXWEzU4yiZfaPvRgdR6kMhG7vfTdz+C7UWFRBeK+Y4RMeH2G8yPSRL229YgLmdXPbaQWPSKHFLlXdz+LLrAMbPb22GhJCTaYTFWaHkalNOU9jr4IWU2nzEp4ITtBwAhZ+OmNm9bMgIm+Zp81uJhRZe2FA0k6r072Xx08GCL8UVW2tGJ72VDpe7Jr9GVyHi/2coVMaiT+OaS5ZJUoc4MeTNLrLeOKMHY=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27798E924692E8215A7D82F1BCAA0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501324)(52105095)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:lCMDt9sCW8ws/EtWIH2uC1dyTI8Ui/MiGMt7ipP3/vUw/qGz6/UiBBjG+FIe9PTXDe89sBKnjoRxZeNPfcx2SzIiS0r98B/JAd+xqdg1SMALp4d2wx/g9RZkDRzIcVuGoqP43nZyq46Z6+R2FwjpBWzbyumwZZXr5oGtEIURe5QsEW1+mJlSzU2Vs65jvKF6MchrUHvZUwszmjvJ3ukE5gzVlQ9NYV6vRtiEvkji03wAy04UdsiNBtUI1tYfqJOFm/lyCcx76AVDtqtU5i3GEQ==
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(346002)(376002)(366004)(39380400002)(189003)(199004)(6916009)(2950100002)(6666003)(16586007)(53936002)(54906003)(36756003)(16526019)(186003)(8676002)(68736007)(6512007)(7736002)(26005)(48376002)(316002)(47776003)(478600001)(52116002)(6486002)(305945005)(50466002)(51416003)(81156014)(76176011)(2361001)(86362001)(8936002)(386003)(4326008)(5660300001)(81166006)(6116002)(3846002)(105586002)(66066001)(97736004)(6506007)(1076002)(74482002)(50226002)(2351001)(106356001)(2906002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:OPHI8B+WEywIhVnrkdehNoLk6vjQW22I14jVVz4?=
 =?us-ascii?Q?S+FXtUM0hNhonUpCHf5lzv9NYDlc1oL0FbPOJ6ZLe88VY6310iFeo0XPCS8r?=
 =?us-ascii?Q?f6DuzuTHGD1UgHnafUWRJEkLVbjM7GJh0fpzG7Mw4gcN49A+f1SriyAon/w0?=
 =?us-ascii?Q?vW6HdXlZQO1sOD3ZrrNZsu7qsacHkeNsvhhf3xxYNtAC+M+GazxB88+Ekfsv?=
 =?us-ascii?Q?X2OrWOFd2AuUaqazagjDRbGWIyEaH9qkL2N+UKvNsSDeBLqaabpzjizdlU/F?=
 =?us-ascii?Q?LzAQuS2rviprUyh7zYORvmg4hwnyaCmnAgHvY1LV1QH6MbNT5K4pS9kbaADp?=
 =?us-ascii?Q?H+51rWTaKDdideMZHsNjwnJqJ4P7axIi+stUXmr5ssRAwO7QAeYNIL86mrKF?=
 =?us-ascii?Q?o/RNxXeG/G1imUVLMFRzvwFRVLPsMC9jVuvayTLOW2jiOYAYRb6nxfb2vpaP?=
 =?us-ascii?Q?xGovqfetzURQHemOq1aL1miuZZpMzcJIRx5VQJtw8RtCIo+TK2MObPUqgOIg?=
 =?us-ascii?Q?LJy26C1OCSf3YGq6m/XNvJj6TLOV5l/WuezCHyiCp7fqd2y1QDfz60W9k2ru?=
 =?us-ascii?Q?HOMPGmr6ylwPZhH7c9FAS4yGWtxWWlNPvruZSQ2vmSBhvxo8J3OT5j+eY30g?=
 =?us-ascii?Q?U+f8ErMzfw5ScW1tPFzsKqnr6gaSgzTMblqpHzuDrsdiuLF2mbVsrDs7Fk4i?=
 =?us-ascii?Q?SIGXujQa7BoFcHR+YzoxMm7tmi6MCXs85zRi8MJRE6OAlUVPkCLbL2Naas/Q?=
 =?us-ascii?Q?7ndQLrHpsnFBvsKfTM1AGM67LVhvO33LfXIxlz2MjPz9V8Vt3Qsi1/Flhm7D?=
 =?us-ascii?Q?nZB3FBD3I1+OA5hahbkbD5XaZYH/xkgVuqnvxAtVYthXNyaRGPyO6t1Av1sg?=
 =?us-ascii?Q?VQx7LeBELexkWHa/JyKx34t5aIgDvncDmDpu/xxoC7LWBstiWRrH89V6M2Zf?=
 =?us-ascii?Q?2gUoXWqwHjuFnn45ZTue+xgqep1fQAk2sKn8vhe54RYR4NmT0XKQcm9tAkhB?=
 =?us-ascii?Q?u2SrYQFE7REpraAaT7JKlnoRwhwBHj915BCnSO0qzHOJyvDR/OCFoyDxRUKB?=
 =?us-ascii?Q?DJN8GvG8tEumVCKuGals/O3QkUeOHvTW3qRSQ4IQPAY5K4dX//Ti8lN/ddvb?=
 =?us-ascii?Q?yH7RmHgI2BZEvFf6v/zlVqMn47auHyREdofA14/vIzIEfjK9OQDZqN6+ZljK?=
 =?us-ascii?Q?bVKmLlAF3ttMohIB04aUB2AL9uqn1jPUmv1p6D5gu/uV8zjFnsE0e96cW4Q?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: nj+Agl4eu9z6airZXqs9kN4TqQ/hLyA6QDQZ35gOERxXVbE1PvwOjJhFl1mooOmDyGKRB88ZGWShzBO1VfYxzkmW/YGflvP3JZu844tY7h0/eytJ555wjf4CiJ0fTf3ejZaKOHHB25hx+nnRvi/XW6cFGS777Lz3S07YQNSpQROyS3lXUrRcZm+XC3/RxkWx
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:Nn2VT3CSky/SZtpchuHD3VF8SUJrY7U5lfnvbr3i75opoCNnHFDDL58ql35hTmRJ94yT5TXp0ups7c9Z5aD1UADXDPZdKSqLeqzXRX16kePMzNnw3eTIFXAdqD++hWYKjvgnbK5lP/6V3k62swutZR5MYhwe3IYMrW8YLIzthM1P6IfDtJW74OOPF2aPjQxZLBbzowVKzmqSmDLNisF9Wj7+hZKaonJN1oJOyaguiLMDzCfUPHn1cgymjLpY4Q0Zn1hm1lIbZ+4bnT7EIt7NIqNFtCENZI71n6MwyJ1lPuYGSaGJ3/W8PlW0BhzLRAq2z/XW/dKUUFCwsgw7MMCTmGowOsYZ2S4YCQKNOLymPpw=;5:jM91o0WnNvZO5eDo/wwwTaYqtkEi31n1R5oVPtFkBT27CCw/pbHoP9KhicZ1iYY+CaFa5NzUcMR8XLlhYhwhbugxWDuycOgekazrlZNdVP/eJW4RxYf+whbyHvh5qOqp+YJxgQ2oFxF4EDfoYy/Z0k+mEP7uAlgmUPvt742mQIY=;24:S+9fXrV06NnoGdBuWMpcx3+rVOA3Y68GlTeG8FCr3leA6EixHPzyWuZ6GfFCxsFIBIeiDed1ZezTuc9/0vdBzjPvkBZ+caSnaeMCGs0k/Gc=;7:SBXkX6LJXdPT0fUt1eGn+p39TL3mhN2bJZinVpv0ao7qBJKCReJCl8C6+gBL9fLzq3nJqY3uru7V9HQWyyrzamckQerGquuoOH/PEDrqSNkIxM+KwNChtc6UkoQMR9+c0DpswO8539u1ohABFC/89C0QorfDCIxvl3jb8sTyvsFUrUuofDwkCYgoMXZzMtvMn4XV86mpLjQmi5HJdWTBQ+VhaeK8wDdEaNunot3scQSoQn6wsY62qa3hZlCakMom
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 15:36:20.2470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708feaa5-fb84-4752-d46d-08d58f417ec9
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
 arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 3ae7e6c55fe4..9118e29b6d6a 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -434,8 +434,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
-							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB5 periph A */
+							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
-- 
2.11.0
