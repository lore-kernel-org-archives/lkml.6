Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F60ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6999820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="FB3WjB+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6999820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeGTWLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:11:17 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:38546
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727671AbeGTWLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpXXPuxInlQ5gojQHFObtTWOx7tWZuizHhd0UdtIyZU=;
 b=FB3WjB+VHt3HNcMkMXzyCROsKtEI1cE3f72STrASQAu5JCdDEJmdFvdhmAhjmC9Pk9gAkjrcBWXH5AdnKA4iOeIX9SGXgK8bbiGUU2QI0dH3Uy9qe+3/4clxBhM7Ev9TEq33dBWGh/wyN6OHP+SkxptVRDlyIIgta20EpY8MY/s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=khuong.dinh@amperecomputing.com; 
Received: from portal.office.com (4.28.13.142) by
 DM6PR01MB4091.prod.exchangelabs.com (2603:10b6:5:2a::24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Fri, 20 Jul 2018 21:21:09 +0000
From:   Khuong Dinh <khuong.dinh@amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Khuong Dinh <khuong.dinh@amperecomputing.com>
Subject: [PATCH] MAINTAINERS: Update Ampere email address
Date:   Fri, 20 Jul 2018 14:20:45 -0700
Message-Id: <1532121645-23575-1-git-send-email-khuong.dinh@amperecomputing.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.28.13.142]
X-ClientProxiedBy: MWHPR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:300:ee::25) To DM6PR01MB4091.prod.exchangelabs.com
 (2603:10b6:5:2a::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c97027ab-28f4-4158-0d94-08d5ee86b6be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR01MB4091;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4091;3:RjkVfZC94IlYZnjzEvwwIfCHzuDtijPF+cJZCpyT7zNK4+69RLETUo7G+2A7eHnPrCttGFb79jejqb9d6UG7nyJQk8Ql8U05FmjJFLvarGZRGiIEJfQdAPGQNZg1+mqju+7Dlole2kNXhsb39TKS5dpNdaEu6rKpozHt9mPuwC3fWlB6CBxgyz2oQBexL2Ff9azz5zh55kTKnk2Y30IOqhGJtXUyxNqETQRv48SWskPFVni5vlACXHayBJG9vd7k;25:8DfEVMvyZz7q000iL4xPEs17Viav4CdqUyeD7tWz3K33WN1fdNW3VqKuczke1Cioi4S2fqWzJscYBes7YR6mwdGe9NHc20XiZs/SZvVW4LpPOvLN92ncSRxC9wDXTVEaX8tKCUlQsjnayxlJ9Yl3Crhs357fbRtrC47pjFTzQtxQhdOnXifJy7Fn8Kft9ZszwERBIpE+ZYrUMPRg3X/Ibmd4NrcfTL1UgM+lVCUIiKoKBlcPFeePJvgKpez1/n77JZKJ71RSSAkpfQUGsWX07I7jqhX1oa/DHEkaOjxBZeyTO3ajT2a5yDS3vAguuOk/MVlEcjTDAlc5NIc5dHvDjg==;31:hSw36J52jBiMuZhtboUL2B0AmV9tMoWf2Axgm3ze+98y6vLv1DCeC3LiwNJnIFr7rNH+OlN1giCTRQp3MwnEeBAFMSX3qrFjQaNnfpsjJUTkLo7vchk2AwIawrZIulxFlxbOzfwmtbv71RfD+tI8I9VRhVjwTxqvrY1+8q1CjPxZv6fh1EeRrq0J+PaZ6Hgx9N0RnnuvsLvNxF78s6AYJEiOIiEGtH5sQGQ/vbT/+dc=
X-MS-TrafficTypeDiagnostic: DM6PR01MB4091:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4091;20:cYLdWbhHPceB25s3yEFQMVL8vk68PxCT2+TuizGQ8K06EEr62FnPdyZm8VGl65RK8TswLGpnwpKc9KS9g4vVwDuN7k46d2kXyDrBrtFeHpii/RoUXOPMX5blsXljfBBhZG2Q3FM0Zw8/LKBmvnDkOHopG6DQXy8I0SJYTRSFfFs=;4:ISGvKcCdS1kAaXp4rC9TDwFtL0U2RtxsTR9q+jF6aIsq9nNqJ+isNnYHCcusQuWET96phfH68YZUgdkM9cw2xt/aeH+/w1jCRrM19J0sXp5X8pJveWFZNHGBpkXbm46u/uSiLU0SrYW0Cj2CEw7n1qcccI0qfGlovc0UGvXAF5ytGsMLIkHx++82w5+Tj9E3utzigrzyIFhlkXI0o6BEXLogROHYDAPE2Y0m43V+MLV+EoGsnvGZY9g3ix0HfZXzjd2fbiA9DfC1Y7L/OlqjB9cZQfWC0XIpji9VghE2dg84flCuw62mx6K7snx4d9Nvp9ezE16xzXFMrjDTlNedFF7mrs6Uqix1MdvXBHCjZeU=
X-Microsoft-Antispam-PRVS: <DM6PR01MB40910083096A42E79F65370EFE510@DM6PR01MB4091.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR01MB4091;BCL:0;PCL:0;RULEID:;SRVR:DM6PR01MB4091;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(376002)(346002)(189003)(199004)(53936002)(106356001)(105586002)(53416004)(4326008)(69596002)(386003)(6506007)(97736004)(52116002)(25786009)(107886003)(48376002)(51416003)(6116002)(3846002)(36756003)(16586007)(50466002)(6486002)(15650500001)(2906002)(6512007)(476003)(66066001)(8936002)(6666003)(186003)(478600001)(956004)(16526019)(26005)(4720700003)(86362001)(316002)(1857600001)(81166006)(8676002)(2616005)(81156014)(44832011)(47776003)(486006)(305945005)(7736002)(5660300001)(37156001)(68736007)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB4091;H:portal.office.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR01MB4091;23:cX5DXVkk6E9Zij9nXYjE1dVn12n5mPm45bMMZDJQ9?=
 =?us-ascii?Q?NW/yz/xf7v7zuLSFM4O1p1xbzgBdoyPp7IIhiYTVvfRM3FHHSYti8tw85ZER?=
 =?us-ascii?Q?f/+PKkg4bxjeYGa87FkhcFS4DTHtcnQ2v9llPiksX1cxNy5F0oqR/LWzoor9?=
 =?us-ascii?Q?CqzExP+wvUDmkRsJz34CtAxhpAs8BBZHCG5CzKP0nx/CuLjC6DlWzRe+6G4I?=
 =?us-ascii?Q?WBLuwtsp5gVpzrOo9nmNx17pUxoGUQDsLEKm/uNaWE2GM+9BAuTU1NZZup7I?=
 =?us-ascii?Q?BbaR6L/hdosJzMI9eyLlc/uVR0Rj6dikWmanNrfzhwXww9ZKkC1SYDcJhxLd?=
 =?us-ascii?Q?WEi7uhHUXdFkUZ7sSlktgJOoitJ8CP3KhaTt0HnOfrsLOq11OHvWeSu7bMZW?=
 =?us-ascii?Q?XhLnwJPUja5T0JK6VKbXmNHrGO0sD2zQ10iPcyL/UgVp0kCmEK2SQ/XD0Vpp?=
 =?us-ascii?Q?MQzKhwuvTn+E9Wf1oSXpCZDIIXddthWMCyv8TpbVQzeM65nQiCa3Nb74IhkX?=
 =?us-ascii?Q?nhsD9IOOu9FplpvNskC+8i7lqMPowHNqhm8nwU1YPxF2w2Nx/rxsz3uN5PAv?=
 =?us-ascii?Q?2fz6HLtV9b9iePERBGThNn7mi2E+pzh/haDSwcffyflYhOMDKac0YNtNNvCC?=
 =?us-ascii?Q?Zbzr16Fc/OMISoY7xoufq+UTbArBXzsxKSp9ff2fjXV5hGm6LDH0M6hLpwKH?=
 =?us-ascii?Q?Ew7Ud3EaiKn3o8VE66f3m1gIieRj3ScPKBXd8R+VJgIaOgWPjP20E1SZQ5AV?=
 =?us-ascii?Q?vhQZGuz3rL9L+HBavs6fPiWMlrqVtYmHUQp5zgyFWn+SAxyXpc4pRFFsPZDI?=
 =?us-ascii?Q?lRGMuMSwpDMqN9Yc35nZjALW4SDn8beiKihxZSx6rKrU94e5YvOFB5Jsfsjp?=
 =?us-ascii?Q?KvsMsW75lifN/BDUFKWqYmc7McuXW5bOcyxdwG0HereOADMNe6j5lPOTHnZd?=
 =?us-ascii?Q?oK6PqfXMqjfMGUHgXe8HQA/m7TybjihFmKlnBPBUP0ExBRDfkWMQHVO2027g?=
 =?us-ascii?Q?tbufFG2BK4ftXpSuo9CPLgxkjxciFV69ZdzhC+YfiW1ymTmGdR1DxT3gaDyN?=
 =?us-ascii?Q?phi/gbd/om9lO09urWtc2/O5w9oM5fogCxp+foS2E6q5+Cei2DACHXoRdFZ2?=
 =?us-ascii?Q?/30OSlsoM2RzlLo1yTCw9vcWFSBAUS8B62CW7oO9I6sY9ehX7+ticjZoBh7O?=
 =?us-ascii?Q?matJ+2codQtBf7jzggO6XJj+LxX0hyaxmf7+AMjk5vDRGUJDa5RNK54LK6t/?=
 =?us-ascii?Q?HV5tlm4W7nudAx2xrn/Jws3+813i55kZhoYkKJM?=
X-Microsoft-Antispam-Message-Info: /zdWPYMfoVJ799IjUY826Bk5XubKDaA4WUh1GS/0fb61OEUOF1m4XsDuKzd32w9/3IHJNK7eaO+t4aBH90wueNYb53EuW3/En57+lFsMWzPxQfvZTpyn5JqPZDtufTwJwASxSov+BSYbQUQto7ENIiANk/ycjak8VrpS9A8BHU5DqmWExxVQectoEbYIaSlU6kPHX1OAeOVMuSfTJ6Bk1cOug3C8NhMcbX/aR8yRvrgPTIgqihMtEKzP9V8w6HAJz3M5gA0ALg6t/6pm9n9/ws4Yy5k4tMyPioyXpbmJhn7teCPXIpfwBWw3iLJxNa2BJtNdsT1wWMPyx5oFLYjdAU6S91MDtL8AocpWO4cQ9SQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4091;6:17GZMngzn+Yfa+3Iz4K72Ent6YpS+IoKexNKX1HlMqMJ+EtVStgquKqUdeSGXnwodbOYPI7kVOF+0dJkIyvRUy1YWrZ53U0mJ94DUSV3WYnbx3xJNZ2uod7JPrbLNLJmBfUvEFRONZ0RB9P6VW/yS04LEKuvQk/4oKsfOKhFVGFythuG4TXKgJpquzrpcVbI8gL6XLx6LGECnqoj614ii6TTLXbmATyFbkbuKUD3FyzhRUoRYvhuqbwfWgxnRxJLcTz+/k4UMIvPAVa2iIMrUK2vnFkp/kJZHC2rHjWF3HdRrgz/i9vjSQgdfxrBlCsAg4WXyJwg/jRMOY5H5injQoHOlKbLMHSZIhakVDANwJqfUMqoz4raIQuLK1fOFwjtmOmGBC5KEk5CpEmkRGmhSZwTd0TaT2L9YSexgOR931jQRlcZWKx0l5fGYAgU1Dx1NgD8Xy/LqOAWS+GQSwnDZQ==;5:snOu8XGZEZ3JAxn4F55lXjakLaR6vLocer6NmMMMVr2nFVGMdFEmooZQhMNc4nQx2wFzlBQPgiGALuPDgI45EooACA26pnnlmCjk6M7vU4s0czbtNUallsEok41w9gbpyhxOtriqdP5ok1s3bNaWnGbQeLMhrnna2iRwKEoHMNI=;24:XTELYFTENEgwf456V0rQvIU+xgjzcknqJxG3N4obCiFUCgwlMNbvvbTWDyz0LNnjrzBHzaRwiA7ODpVooHdaH3r3QQUTJqpvJLkPGhMIp7c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4091;7:MqiOA2xb+cQ9JhOU6eTad1g/qgqf6kc/9VSaUpDP21YqF0Saooa8J4W1i/ksH9IwEM5haxRBQsixnMUN2ab2s76Dqc+AT0a3woUWrG5Xb9kWHmCOoo1q7SCojCqnrQilIzzKfA++7mjzMtolrteOFZZTUMj1h5Ir6WKtKjIa/cJl+hHFDzTZCIlPI1VAnE1fFQGAZ7mykZt3gjmFREpSlDujy2Ze1WsSoMdS0Nf4DNwmDIZxM6AopcTPEZaEKDQ7
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 21:21:09.7042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97027ab-28f4-4158-0d94-08d5ee86b6be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates all APM email addresses to Ampere new email
addresses.

Signed-off-by: Khuong Dinh <khuong.dinh@amperecomputing.com>
---
 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5917247..1f28433 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -979,26 +979,26 @@ F:	drivers/net/appletalk/
 F:	net/appletalk/
 
 APPLIED MICRO (APM) X-GENE DEVICE TREE SUPPORT
-M:	Duc Dang <dhdang@apm.com>
+M:	Khuong Dinh <khuong.dinh@amperecomputing.com>
 S:	Supported
 F:	arch/arm64/boot/dts/apm/
 
 APPLIED MICRO (APM) X-GENE SOC EDAC
-M:	Loc Ho <lho@apm.com>
+M:	Loc Ho <loc.ho@amperecomputing.com>
 S:	Supported
 F:	drivers/edac/xgene_edac.c
 F:	Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
 
 APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
-M:	Iyappan Subramanian <isubramanian@apm.com>
-M:	Keyur Chudgar <kchudgar@apm.com>
+M:	Iyappan Subramanian <isubramanian@amperecomputing.com>
+M:	Keyur Chudgar <kchudgar@amperecomputing.com>
 S:	Supported
 F:	drivers/net/ethernet/apm/xgene-v2/
 
 APPLIED MICRO (APM) X-GENE SOC ETHERNET DRIVER
-M:	Iyappan Subramanian <isubramanian@apm.com>
-M:	Keyur Chudgar <kchudgar@apm.com>
-M:	Quan Nguyen <qnguyen@apm.com>
+M:	Iyappan Subramanian <isubramanian@amperecomputing.com>
+M:	Keyur Chudgar <kchudgar@amperecomputing.com>
+M:	Quan Nguyen <qnguyen@amperecomputing.com>
 S:	Supported
 F:	drivers/net/ethernet/apm/xgene/
 F:	drivers/net/phy/mdio-xgene.c
@@ -1006,7 +1006,7 @@ F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
 
 APPLIED MICRO (APM) X-GENE SOC PMU
-M:	Tai Nguyen <ttnguyen@apm.com>
+M:	Hoan Tran <hoan.tran@amperecomputing.com>
 S:	Supported
 F:	drivers/perf/xgene_pmu.c
 F:	Documentation/perf/xgene-pmu.txt
@@ -10944,7 +10944,7 @@ F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
 F:	drivers/pci/controller/pcie-altera.c
 
 PCI DRIVER FOR APPLIEDMICRO XGENE
-M:	Tanmay Inamdar <tinamdar@apm.com>
+M:	Toan Le <toanle@amperecomputing.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
@@ -11109,7 +11109,7 @@ F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 F:	drivers/pci/controller/pcie-altera-msi.c
 
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
-M:	Duc Dang <dhdang@apm.com>
+M:	Khuong Dinh <khuong.dinh@amperecomputing.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
@@ -13869,7 +13869,7 @@ S:	Maintained
 F:	drivers/tty/serial/8250/8250_dw.c
 
 SYNOPSYS DESIGNWARE APB GPIO DRIVER
-M:	Hoan Tran <hotran@apm.com>
+M:	Hoan Tran <hoan.tran@amperecomputing.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-dwapb.c
-- 
1.8.3.1

