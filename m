Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDKG6X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:58:23 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:25303
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752588AbeDKG6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:58:02 -0400
Authentication-Results: spf=fail (sender IP is 192.88.158.2)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Li Yang <leoli@freescale.com>, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 6/6] fsl_pmc: update device bindings
Date: Wed, 11 Apr 2018 14:35:51 +0800
Message-ID: <20180411063551.30368-6-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180411063551.30368-1-ran.wang_1@nxp.com>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:192.88.158.2;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(50226002)(6636002)(50466002)(6666003)(336012)(48376002)(81156014)(47776003)(316002)(16586007)(36756003)(305945005)(1076002)(110136005)(498600001)(54906003)(81166006)(106466001)(68736007)(5660300001)(69596002)(104016004)(85426001)(97736004)(77096007)(59450400001)(126002)(26005)(7416002)(11346002)(8936002)(486006)(15650500001)(356003)(105606002)(4326008)(86362001)(2906002)(53936002)(51416003)(2616005)(446003)(8676002)(8656006)(476003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR03MB397;H:az84smr01.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD007;1:srF0tLsqz7kvaFRI68ZfAzWFBcI2n0n3LSxthKGT/3tg8dWZ2+xzPRZevXUP8w9iLgDbzbLBleYm51/IryL6+2cqTFjwFVjKpSq7OYS0OHjs1RcOFvSZ0hKk1fyETEG8
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(2017052603328)(7153060);SRVR:DM2PR03MB397;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;3:W5Ewko/Cn4MarM9COI3/ERwUbVPLkZ7MoLWbsG9R4o5byNPh1/dV7Oxi16CM2m0zfAHKXWSY2+yRhL58JFM4mTT8OL5EDfCBcwcfJWCHENL6HAB3Ugq0CrL7lQAuuLxWFFZVWz6nKLm8uv/YOBi5GoYtR2YSv8OItRzJraKswgRExWRsKdgDS/ViPfaQ+JE1ISAwztFUJP4d5l4eI/fnnWHzJ2CBK/5XVeXJkES0UUDqBqinvOJKRlwiIfDnvTqjeziF9Cdn0QTgD6UrjCPaNKIU+3OU9ptatmqLgZiVpDosqKaRALrGRFfE6gRcxXlTdEcAzJxvMv5utRQ302B2OewotladyTdlP5Lx3MkttqQ=;25:pmkNkTJXptZoju6FriYxR635iMlNlH1IJg/lnn/TuHRTIhrNHhuRo12PaMji68LQdq82paivjXNRxVLMFAhYQQrbHZqL/wIkeSIPGetV8uoOXslpwTKk0hMQqGd8whgJtfDkYr8y/nq3fLKeCRpDLoMnE1uNIU1ix9WiZrtJ8GdPzPXG66USEM0A77uFp5detA86s0I2z8bKdS6QaHyoYZbCw09JE+fYbpWYYuLC/71llIssLbJ4p8yTTXit50/W9yq/yp8nLfy+SMPUVxoDy5MY9SeXiAv3R87Jvmg9Kk86fuTKa83keE11BBvHglwEEHPKPMgufMB58Rr2Iq5Qqw==
X-MS-TrafficTypeDiagnostic: DM2PR03MB397:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;31:0yv1qBQl+346BDfOyRzAbnHCWgiU7zREoVMUX7j0CvYGsTDEytV+Y+sXTO0rq1+Gb0nJWk4rtr8PF1r+D9l961++a+1Lbqdq7cCEnR4Rv7z8ldFc6GGQCY95rGWb5EW2kxqBA+mTYUtD7LzvPEHl+2tySi/xGBSCnzV+H+hi1W0tVdcaM1Ii2DjB5uYCpQbU4//COm2n5Z3qgtJziVzTG3YPDhwdVEFBCPMe2hCn7/Q=;20:LdMcMSQkr78I6jNPenPLeODOSaO4HfTrWAD7mVlHjI/c9Pj4tGGRxe7Q1EFm/v6sXFT5YBjnUaWxWaxUX2m3fM6Kmvmkcp8hPzVhfucDW3Mj3zuc7XB+niiRc5WTbvekXK2dwwFNqtSwTyCHYzFq7SvUOCGnlHFf3BQJzkh5lZPIgvHE9r/wnaO19+R8kRkFH6sQ2BRAqsHvBTwL5RAYM5dmlOb0ajoCcsf/OV70owgZzMT0NkV8h9D4i+Mhcf45/CzzvUruuaT476jCaYkyHqziyu3KMRmz1WmAlmFoC0thCO4WgID7AiMbLBNcL9+8HnC6dXYib7hcfe1lga+OwC57zEprafT41gIXOI0t/QysiMoLEan3DeZNbxoVvCTwdpT74cw4l9lvoMNHnc2fjU68U37NMw4RMmD/71/YPkLC+69B3oPfqMgoWcqa14IQngo6V+WaJearFNIpAhkyocQAWjyHMfGr141jUWZ1nDdeLtrKWvo6lDfwTfZgBxNoF+B3M+SC0xlW00OsrgWfsHj7jVXJYzg89AlpmG3OHZTGAczc99CqbFnXX4RipgeD5WYnPTb/FTV2NcQdIAcDojQxFyV3CW3Was6VpnOIqb4=
X-Microsoft-Antispam-PRVS: <DM2PR03MB397F6E0186E634F17B68B3CF1BD0@DM2PR03MB397.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93003095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);SRVR:DM2PR03MB397;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB397;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;4:t7q/f7UD7GF+tPdKezpyIKNjwml4ZyzaMvN2hdlK2u5Ig/eVF/3lHC2m/hZvvAhJ6Oc17gDZSEecmKTVoKLfrQG3FdCnwTCoA350cn8bT8u+KrTfCq1ZXHiWK+3qlCmPQvT+ErAbv/aGzCFvlM6rzsRCELDpvfp+Kj7cJ6DZc1WMiovd0DRLObDlqyKf0LXqQAerVU0CYEVBcQgAOU5D3ttqBKTG2nhy/RDllUpAg0dE7zkPU5IbHCXnzQWitZjlGcM6g4aDC/YCaq24aG2uDlWdWb3NUjiScHm3mH3q7wqxojJKjVW68/1D6/9vKpqAtlxpmhzDsqU4MIFGJw1KmD1XoKpLYWnOn4ol5vTOMPM=
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB397;23:Eze9Q0zD9gRV1sZ9l2gqn+zkfDGcnZTkLF2EsmD7Me?=
 =?us-ascii?Q?oA9NbWXysZxBbc91SRY0QYzKr1WhxVo+L63S2XlI+JOOSp2qh4RfuzXhAjnY?=
 =?us-ascii?Q?fWZooSol+nZrqt5oQsqRWx0eN0NK/YX6hJKumac8VlfZ1DIfXDaYw3TBhYY/?=
 =?us-ascii?Q?yOhcijQomfkHVBBYy8jMZigOzvjE8O4NGYGbAzL1z67sQFi7xq2VOQH0p0Qw?=
 =?us-ascii?Q?AFG71ZLEM1GbXTcWdR2uN61qg1agJt6wbNSz4NV2UkgUIOr+kODhcGXn+yQb?=
 =?us-ascii?Q?LuPIuhYdGY/Ka4i+U1nzqpPWR20kXKP34S7mleKTgVi20bnGvWQQunc4zm5j?=
 =?us-ascii?Q?MhgRxKwKQegiv11cFneDNJefTYBMSRz1sHzSPlHiwHVjTLInrAtjfR9LB8L0?=
 =?us-ascii?Q?TVJBmlQxXy14BX34TrSNzKLpfthenWx9pEArMlDQjL6Fmlo7DgMtz9JaDDhG?=
 =?us-ascii?Q?ls6kZselF2aLdbPqPis/lD9slQnAak1kqaKOQgTQv5JCz5f11TTXhpZU/orD?=
 =?us-ascii?Q?zM16taC8xUhCK+tNR/80jPC522H4cQ7tb9+q21jnT52m5WEoNP4mGoVMTTxx?=
 =?us-ascii?Q?ycSp6TaReIhyhAYucIZH8eX21dtJFthlx57ZoesQ0+Iq77QFUjirWHprXDfY?=
 =?us-ascii?Q?MyDV8F7nQU9wLfdfZ2A98fmeq7Eh9fQzqQYG3xDCBLuqk8bQ65erJMwkqGm7?=
 =?us-ascii?Q?2esT1les6WbFiL68yBfnYxW0QRMRc5kFzhTTnD+x63dA5CCxyMT+gg/Wdgjw?=
 =?us-ascii?Q?b5Ejp/yRNidJJBg8+GGsMI5KGmYa0ojHc6Qeyic05KpZU64ztbkJ4mYJpjes?=
 =?us-ascii?Q?AIndPgrO+fuGKShL6gQuJBDYZDSLzO+RiWk3U8tr0+jOqFfA3Q6/1jCdB5Mz?=
 =?us-ascii?Q?YzC0hC14PrPr7cjQxxXsbInhdJThvtU0FcTHkE927vz69ShtXT/nwIVHO3lz?=
 =?us-ascii?Q?+QnswOh8t5W6qLIjVy0GHtv74KLvMPx+k8iPT6/0x8VdWzN/C5YU49YQ2rHC?=
 =?us-ascii?Q?c8AjP224WQZligs+9S3PWjkzntPHymwDNBXv0g+wC+KSPMs7jclTDWXdNHmm?=
 =?us-ascii?Q?uCnZ+SbW7l2CBdmDFoXrlmiMixi9w6TxctUrDjnRP4hJa3Ep1bdOv+//Qk9i?=
 =?us-ascii?Q?z2PFKtS1yiaT9Yu4KCp1nLubrpx7Q4uORE3/0cVZsMonLv0bB/N15te9pnbg?=
 =?us-ascii?Q?edCNohEg3c5pDcNM1tU6nZbDe7+QfJKfGlEaLX4BLsZaTy9rBZUoNGUuGT+3?=
 =?us-ascii?Q?uO5DmDgbGf6cJuSoKo1xvd9epz9B/iSAjcBPz840VWceRK0V8jmF2eOeYrpA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2osLIh3ncjDQNO13AykVThdVCruPMo/gVRBjJKcRUUUf5m33h0nUFH2T2B6jthfv39jOJIICjIjBfCD3OW0yDXoLE6HetSAwKU9aoy7wxjZCe14zpZIhBhqv9JSOs/wBFkA/ZCf40Q8ToIW4mwu72pjcU24CO3AkTBKqKrIT5BHdRUz06Iz/U63Kwu6cCy5a
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;6:D5trVLeSPU7OT3Mjx3lU4jnelr6PsUhb7exq5biS0Dnl+4RNYhdBsIzen2pPr/SixPGAeBjmxl3LOO9e7qxeG7fpL7nkoLW81h+/zt5Zuh60wCpbbusa8qaj681K0yjhLVjWYQuOTbzGgPcgDB9K5LKIpM9dy8J8fPjx8zYDr7Agl4h6rT900ABK2dGKOfS5UD71ZnqKPfU6K12WtDvk2eSqaeoiZRaYJEv7FIDpoT9drZXBi2uZTHHxp6I2ibTcx/GrJ+ZJ9/p8zYTANRtn3uvjcl43QB9UDK4ZWZaaNWa1OZwFMfPzJdcDaXjD4lGkEHJX440k/fQ1NzMb5rnoCoPp+4uBM98b2ay4wbps7v/mNGkoeKJzphO46bz0R5FlEwOGUu6WjhMxzivJj5vYWLI0qhkAZ3KSYwsLfNuueJKTBXFv4m9E6zQYSem+eiF7oqdcqJ3Ere60TNP68Vf2mw==;5:eu3QSNpqxnjM3hR4D1GVK/G7QWlW+ZP9oFluyztb6pH/0zGtqXUrRysxtivNnskjpgLU1oMvsfLjVsS/7jlultFqx3ibJYE5+iMf2SW/fRzFx4BwOEkQ/FlSjh2uDBFhzrmcDj5pIdEiujm8R/ElXJnmuEk/kCqqx2VcY2nATko=;24:NDx0n3fv1xPSqR/8HTDWSJbzYBwvAZOUIk36FZyRV1ZeRpUxa1sXe92rwZ3LlvuE4IQxJgtKahhWIXaYzn3oTmwgF7AsLkBXGnKwbbO0RRM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB397;7:78ImJnSiAIHZLS+jIyda8T/t986TL1gp3sqP4fD+P82ykaW0iL1c8qU5hIv/4N/npiK1KED6qk2kZOUxOvO5Z4s5201iLxpYkANr8sAlrGxJgFUrPiwi0Bh5ygtU+imlD9MBi8ggavbOVPxDsfgqaDcQ4U2Nntujvf5oBUGr2CrNXAj+kiEDN9qZPFwS2REhlUo3bAcNXI4dNQH0ir7GgayFoqi5viX75LlaJ7lbei8s/3caAOsmscmhvk/hFoVi
X-MS-Office365-Filtering-Correlation-Id: ef2ecf37-a9d8-41b1-ee83-08d59f799045
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 06:58:00.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2ecf37-a9d8-41b1-ee83-08d59f799045
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[192.88.158.2];Helo=[az84smr01.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB397
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yang <leoli@freescale.com>

Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - new file

 .../devicetree/bindings/powerpc/fsl/pmc.txt        |   59 +++++++++++--------
 1 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
index 07256b7..f1f749f 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
@@ -9,15 +9,20 @@ Properties:
 
   "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
   compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
-  whose PMC is compatible, and implies deep-sleep capability.
+  whose PMC is compatible, and implies deep-sleep capability and
+  wake on user defined packet(wakeup on ARP).
+
+  "fsl,p1022-pmc" should be listed for any chip whose PMC is
+  compatible, and implies lossless Ethernet capability during sleep.
 
   "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
   compatible; all statements below that apply to "fsl,mpc8548-pmc" also
   apply to "fsl,mpc8641d-pmc".
 
   Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR; these
-  bit assignments are indicated via the sleep specifier in each device's
-  sleep property.
+  bit assignments are indicated via the clock nodes.  Device which has a
+  controllable clock source should have a "fsl,pmc-handle" property pointing
+  to the clock node.
 
 - reg: For devices compatible with "fsl,mpc8349-pmc", the first resource
   is the PMC block, and the second resource is the Clock Configuration
@@ -33,31 +38,35 @@ Properties:
   this is a phandle to an "fsl,gtm" node on which timer 4 can be used as
   a wakeup source from deep sleep.
 
-Sleep specifiers:
+Clock nodes:
+The clock nodes are to describe the masks in PM controller registers for each
+soc clock.
+- fsl,pmcdr-mask: For "fsl,mpc8548-pmc"-compatible devices, the mask will be
+  ORed into PMCDR before suspend if the device using this clock is the wake-up
+  source and need to be running during low power mode; clear the mask if
+  otherwise.
 
-  fsl,mpc8349-pmc: Sleep specifiers consist of one cell.  For each bit
-  that is set in the cell, the corresponding bit in SCCR will be saved
-  and cleared on suspend, and restored on resume.  This sleep controller
-  supports disabling and resuming devices at any time.
+- fsl,sccr-mask: For "fsl,mpc8349-pmc"-compatible devices, the corresponding
+  bit specified by the mask in SCCR will be saved and cleared on suspend, and
+  restored on resume.
 
-  fsl,mpc8536-pmc: Sleep specifiers consist of three cells, the third of
-  which will be ORed into PMCDR upon suspend, and cleared from PMCDR
-  upon resume.  The first two cells are as described for fsl,mpc8578-pmc.
-  This sleep controller only supports disabling devices during system
-  sleep, or permanently.
-
-  fsl,mpc8548-pmc: Sleep specifiers consist of one or two cells, the
-  first of which will be ORed into DEVDISR (and the second into
-  DEVDISR2, if present -- this cell should be zero or absent if the
-  hardware does not have DEVDISR2) upon a request for permanent device
-  disabling.  This sleep controller does not support configuring devices
-  to disable during system sleep (unless supported by another compatible
-  match), or dynamically.
+- fsl,devdisr-mask: Contain one or two cells, depending on the availability of
+  DEVDISR2 register.  For compatible devices, the mask will be ORed into DEVDISR
+  or DEVDISR2 when the clock should be permenently disabled.
 
 Example:
 
-	power@b00 {
-		compatible = "fsl,mpc8313-pmc", "fsl,mpc8349-pmc";
-		reg = <0xb00 0x100 0xa00 0x100>;
-		interrupts = <80 8>;
+	power@e0070 {
+		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
+		reg = <0xe0070 0x20>;
+
+		etsec1_clk: soc-clk@24 {
+			fsl,pmcdr-mask = <0x00000080>;
+		};
+		etsec2_clk: soc-clk@25 {
+			fsl,pmcdr-mask = <0x00000040>;
+		};
+		etsec3_clk: soc-clk@26 {
+			fsl,pmcdr-mask = <0x00000020>;
+		};
 	};
-- 
1.7.1
