Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeEPHlO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:41:14 -0400
Received: from mail-bl2nam02on0068.outbound.protection.outlook.com ([104.47.38.68]:44960
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751151AbeEPHlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:41:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Wed, 16 May 2018 15:40:22 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: dw-apb-ictl: switch to SPDX license identifier
Message-ID: <20180516154022.074c5414@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0164.jpnprd01.prod.outlook.com (2603:1096:402::16)
 To DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:AE60Y6sOKX9FUMfjLIgdk0+DRqjSFn/qp1TFsnVRSjnWuD9q5MbQbDMCY2U/UBik4ZZjCQH3seBTseoUhZSzVIL3NTGgbHUX7Wx7GLyaF1XlieUyU20fTmVjtV7fTCaCW6WFwXtHNfNJk9JJZ2iCKaVPRXPgkea7HW0eawl+bEeVEKpSv2khpgjXVPiEPgRKHwfU8jkP3CvEm0CAI/4TS6+QzJV0Z0DUQQ/FJT/p7ZWwUVi13AjaFUx+jArFZw+U;25:KFtgQRDdODeSa9tt/R9HOzxNAhbZAH6aMrswIv3cLlmRY0g5HTirYHtCzR1fMheecmraxcPqy6WfrbxSfarwSFHc7pp/aYVhPli+SwLSK9QvXA5J7H18S5WvpUgZXZgK7aGlNcKlpoiEEh3TyW7yUCnH0H1UYCZ8sB7mkeHEDhoSZLODgZPEb22k2pCmxg/5htgB+xSuum9VRsNsamPcnlWRen+pXROkaX3NLfF0TzzvpORAjAcyTTw8mvCWxQYnkwjV1CMZpZ/WRm71h3Ajk1AL3eMqKtCjGWybdcJ7MP8XkeBkqHpJuWZusGluh5NbQmBxhJ0jx9cMopN5CENveg==;31:Iv/QPVYJ1IlWNxsuA0LPWL7WaW6FNHkgYNz19EyvoSyhEeYChmuhqR5kSUMy70x9mrRJTCvCttu62ZWDWr/WLDCYrynKWvI37uwVoQAFX0PxLh48UxDbYz1JXrcXYBdFnCahgrz517VC+Z/8Rdc1mqNoJPWvbiz+rAVsjY1y2NJp/T+a8t20oWbOt/O45Oer1+d8Hz7go52jvj4NbeLQUL7MYhqtG0TSDaJs/jM7fyA=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:RAohMRE3ANnpsYU/Psf7eobrTOc0C3kGlsv+CWNuh8ueJ+XsE8ri6ICnjy/llKoVKAHRALwCaZvhBdDfTRl9rLKR73CdqNhTMgXYY/09Hp37bNw6xYlZ7k7rrKTVFch1PZC5Xar3517sQVRz4fM5CQPGpuKxf6+fY05YM0dGWO8LCAI3M0pR5cg3U5IpZaPm6wMjcf2H76EDE4HK9Sjc8oi3ZHZDYFsZDf3XUxKqiC1OKE2PkKNgk2L3rEDwGFM+A6LB4dBIddASMcwW0kZSHCx3Sb0n4H+QfjvhuJ00gSdR6tGXIwG02eTcxO+YuLePIB8mnlnzZdh3TWkAoGBnotaaOttyU98Wf0o73haMIRtlkla8dfDyd99Qa1y0XZGQJV1PLOCHefvT7VgkZDd7v/BXkYEvwZbO1DsFUQgGLZhtgAdFcUpMSMHNTEUpGD/0MkIVGD+vZvsZUt55gooMmyKw7F02OGTVBto7IKa6QHPwM4AN4XybUJSeTJRBoe0D;4:99eQhcpEQC6Sgtwg8qeHQfIUkd2NqsGzfTc5eyY5BjOHisXWiXR2xmqBvOcuRNkWSpofQiWLr/7NtUeOAQE13xXXLbbQPqs45bjtFVxO1zN9JA9HU9pMAgNhQykYcAYk15/6qbg3Il7DARee2jJPBKAc0FXMkRTVmkuvUlfK/dWoRAPwRZoQZ/EJ+DRQsxucgL+pNWUgb9nYjgtdfz281nGiKnBrJoDlTIkJKMtrll3Xn9qQ6XhDBRPCgYaiytZ6JYnDBbvO8+D/KgWEw8ZAIQ==
X-Microsoft-Antispam-PRVS: <DM5PR03MB263675526F1BDE21C25133C7ED920@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(189003)(199004)(5660300001)(86362001)(16526019)(186003)(6666003)(55016002)(53936002)(8676002)(9686003)(81156014)(81166006)(68736007)(97736004)(105586002)(106356001)(1857600001)(26005)(2906002)(4326008)(110136005)(476003)(47776003)(486006)(72206003)(478600001)(956004)(230700001)(25786009)(66066001)(7736002)(8936002)(50226002)(305945005)(23726003)(52116002)(33896004)(6506007)(50466002)(7696005)(6116002)(3846002)(1076002)(386003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:x54/zx93remUwCbQYeZAsGLNkYugce+u11EAoXxck?=
 =?us-ascii?Q?Asc+wqwypFtoUfw3fROXoeFEj3FBuzD7sBfKIamPOwwjuOImM9w+z09bKU1g?=
 =?us-ascii?Q?toc7/bAofLWHDlSs0Ic/iK4idiGFrvWaAvOLi1RJbzUt/6UaGD00KRT9wQxn?=
 =?us-ascii?Q?3cLoajfImdiHkF6LxpFwqm0GOrPsIOs3tjcBycsTun0M7yPEynXc+rpKDm3Z?=
 =?us-ascii?Q?tIC+rKGi7cMXm+PyysJP7RgUkdfZjRXUURDtgZrN91I6heor6fJahg0YFxcK?=
 =?us-ascii?Q?3beNq9zD1PtUWDbaf1BP6vHlsD0h7UNbiRATd4FOzP3ILtoMVPMzonhhEhE+?=
 =?us-ascii?Q?JJA7RHLp+XJGdL2a/jwKrJTy8F3joRzoHb4qV3ZpchWpXmuW2vh6olt486pW?=
 =?us-ascii?Q?+ty0UpzPhEOrFyEmBEr1IAKE2c2gCkf2t9rS3D7T2r6t0kR/gz07yUOE3f8B?=
 =?us-ascii?Q?pBks7n4SJK9Lu1ZL5M77UgY3MPYVrtgAOKsCWQl83B3pPWDhymprfvsUE8b1?=
 =?us-ascii?Q?uU4KjJYUuNv4+d8DM9bbvFTuYHIi/NZvoSxPWvUatruGW1Kt5XGQwB4e3AcN?=
 =?us-ascii?Q?6lJ/rXaQid7OVNOSOTNpzL3to3Sna9vsCKts+mfx8YAoGLYmlSuXdHTKyDpt?=
 =?us-ascii?Q?YkbapgdilJlIvYNfH2yrc1ufgavpi8uTWv7IBom9v7piFbJEGF2LEj3Nz1lT?=
 =?us-ascii?Q?lsT/P2KGHbslhpLEGYsgMqCE8VowVXJB+X6gNo43hjYeob23B6EXUMBCNunr?=
 =?us-ascii?Q?2T5OqCndeI1n4BpwBhPj9MfdK8v/2vGicw25xHVlCtJ5Z9jXyAQzbqHRICrm?=
 =?us-ascii?Q?7kDlLsrsJK3PWIbpD16x06kzNcUZdXqb4soKdRVtelEhSEhCcW/9ipdDwri+?=
 =?us-ascii?Q?SD3hjQbs+lZt1eqNyK4huwoVEUWKQeL9CO9o9w/KKi0Si+fcRZKo2TTe7H3E?=
 =?us-ascii?Q?yPrcnoRoxvBRdPyICGMk7N7Ysp2PeM4UUTBMEFVjvmMM0+DLr8DqMNMKdUfU?=
 =?us-ascii?Q?GHPuervQk+8Vgq9hGHYXi51C2iSDqkQWTxWQZlYiZS41lF5/jTkWitH16Ny3?=
 =?us-ascii?Q?Z7f6nbRsnJirklRCgGbinogPamc3zT0ZN92GG/PbMT0kKg/HupH0XDh4yf6P?=
 =?us-ascii?Q?Qd7cmgh64V2w6wKRMogOpL5jqywe24Taw08PrI5QjpEokqcxsw3ex01qPNUO?=
 =?us-ascii?Q?sJkVnrYcHzxLy+i588nw/pFmIeRtVUR9dGy?=
X-Microsoft-Antispam-Message-Info: z+FWRz7F62hcHNvKFpfBkFV+4qs86xPY2WbMmDIlSu6fR3IRrstSgNTbOAzxPYMzQMT3os0xlb9JmJeOKd3P5ga35oHvMRty/2z3U+vW55k6MtSrL4+huj9SWq6VQAicpr2wDp5RRrtLQKgDKFnBU1vTY+3Ic+bLBdlMZNJ3BKeoWIzB80OaY3imSmfnIdmc
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:tiDx77TOBNx5pSPaDdtra58PiR8wKoc3Aj36OrpjLZk44Xwddgdp7DGQ1z2TvQsN/IZ0fUWWcex7iREXre2mxf2w8RfgqFyZLyfy79sczCxPdhIxXXVIS6LEIiCByS8svdnGUIhk+5YbjN7VZ9eZ2vgsPgZz/RlPqse1ZeddkMfcOimfu0Bxib8kEWceZrakWPnmmLh+4pI1X4Q7WzNbnyVjsgpIkbTVXIdDD7Wg7wJbOAiBIRWsR5tl9kgfC5y4QKmT7TKgbSCSwQoSzuUZHgEFsOWw9Ncm9pCZzy16EuG6k7CmzhkRrrpvWWfHOdx1bXvcCGWjPobmmYjoe7Em+7vF2GrzJQO8OEaS6BY06/YTKhgTb94/7lbl4I2pewYRN43Ez6LNm9N43qvd83I65IjoKr4XKYsI67UiCCoUh7zxCnxSfltz6nF5NPtuy4z5a48he13BnqFXFdEhALBRkg==;5:qs3ep+uG93DtkGG5J2KQkJKMqUobhVlmEU/C2qCZTM36SwFiIemMwVcNnbZiSTDlokUhzcJYlhMmBj9XE61KqodQQhpssd5RaKZY008+IUMOHXe7vnolyKTts5ZXIPpl2p36IhhM6tGJRMsCFuoIghx1xS94JOWvu2NGbcnZktk=;24:gCjWMzmp7Swt8XEGqeRiFHtwZS+7CLVSqWBD1cJjC1a+rz+eNsqTL2M/EFfBHyvuknUvbaOg59XG3wdmpDHLgDOaSqxNPwwmpGhjLe0jEc8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:WdyhaXKgEVr8Lbm7fUOdimZ3oqc0MbXrF3pJW1h54YW4etvTLW60p0/Krzy11WfYZalihoJwceZWTOsrHVQDMKmpEyMAIesx1CWvGJRqhe6Cz+Qty42OF9wjoD5vA2qBV/kSS7/VmUcu1XNPslxGc3MN/561ARma97X7xtyNW7ozmR1Hi54Sa691SUuWRil1KxyyA8NPph3Mh6FyWv7H/X3ikrc/wz78NVZCdpSVe2PVmXjB78U2aOx51Lv1B107
X-MS-Office365-Filtering-Correlation-Id: c118e131-4e54-4893-107b-08d5bb0064e4
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:41:09.6418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c118e131-4e54-4893-107b-08d5bb0064e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifier and drop the previous
license text.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/irqchip/irq-dw-apb-ictl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 0a19618ce2c8..fdc5c7d19651 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Synopsys DW APB ICTL irqchip driver.
  *
@@ -5,10 +6,6 @@
  *
  * based on GPL'ed 2.6 kernel sources
  *  (c) Marvell International Ltd.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/io.h>
-- 
2.17.0
