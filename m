Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966252AbeE2S5t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:57:49 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:47008
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965433AbeE2S5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:57:44 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Vishal Sagar <vishal.sagar@xilinx.com>
To: <hyun.kwon@xilinx.com>, <laurent.pinchart@ideasonboard.com>,
        <michal.simek@xilinx.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <sakari.ailus@linux.intel.com>, <hans.verkuil@cisco.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <dineshk@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vishal Sagar <vishal.sagar@xilinx.com>
Subject: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI CSI-2 Rx Subsystem
Date: Wed, 30 May 2018 00:24:43 +0530
Message-ID: <1527620084-94864-2-git-send-email-vishal.sagar@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(36386004)(50226002)(305945005)(8936002)(50466002)(63266004)(478600001)(6666003)(7416002)(4326008)(26005)(8676002)(54906003)(81166006)(110136005)(486006)(316002)(81156014)(36756003)(8746002)(77096007)(44832011)(336012)(86362001)(2201001)(126002)(5890100001)(2616005)(107886003)(7696005)(47776003)(106466001)(51416003)(2906002)(5660300001)(186003)(356003)(446003)(476003)(11346002)(106002)(76176011)(426003)(9786002)(6306002)(59450400001)(48376002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4143;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT019;1:TwnNdY/TFRY7+mo6ekyS4vecgk3lKGRoMJg7ccYTA/WNVsQ5cHoHGd/Mi+lKspzXvY8rRC26uB62Mxo4NX35CuzdNwONVqcGaiRBE+lyR6F8oSQ+XVnQG29g+Nf1k69z
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN6PR02MB4143;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4143;3:yjWqG2fY9TqoshRntyFXOGpUtGqLfOMWJV8iAsr9gSqWB+YBfFZHwFuqydrYzoiVUXFp6dwkOKcCmEYuhHiNrgUf6UJSUMYxWAvBMaQl2pbN3Yqe7Il2kRoEcLcNfR7ixdaFSJzXl/a0rd0dLJS1EcLzMD6Um9hunie40xiEsxUmDURnmFiBmPgJUgHO0IYRoLV4bjUg2j0dV3VvaMDbaFtHuA/hBpmsPBgZ/FqtWTB8OZFLcSwj3jGUGgBwrGMw9sjhHMTBvCjxPX5dcRVKHebT1lkK40lmRv7J+DfxBrmV6kWOhnO/RFKBHZoTGIVvF0W4NnGUR4A4vPwYFXhASJoW57bm3MmalYzYpb6rU2A=;25:G149AgVWnFEO6Z0tXWXbOQOXa1qcMpF98fl9osVuxViYOD5WgZIlbMaIEcl0eJAORErd8dq/jtz0yErtUFetXotfUJSKE5LbI+OxRhT8ZPEZrdgnaUp21DUQIpF+RXB3Y2XW9h/o6vNZiGHOUZ8XJTLRm9vP5FVPwMRuAgZYzQJejAKR4kWPneTXIw4vR5Br3MYiHsC+667GQlGV76wdaZ7ur7NgZA4OaJKjg5nAhyLaQ1K4Zde3AXOaxipiNfqkSp+R6QSAH4nFPt0NYdtJyOL9KeTXTLQ6CwOdKrX4CLnOHGUg6P+vX44E9jibJjqf94oWhR2IP2rHkTPAvuTTUw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4143:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4143;31:iOHRFaUU07ZTrjEIftqGppcte7PR+m6HHEhc/QRbjgU7pIAaDImmOBmkr8Cf9S3yNmpHBla0Y5lEBLp9oju0gx6N6s5nvcIdGyTtrxhuJFuRPZB4Ozu82ILIWOmh9yniifJ+9sRu3y0U+YqRzDcfYLEzk9IxA9/XWkiQg4YDM2GjB33YHru62sqZ813KmR9mIpHz+DaJiac54V+VT4o3GBgBBPhjKk/Nz0Anv4o0b+U=;20:2DgzjhUK6KhnM7FHPmgZeh2l6ZUh+Op5TCEVYNp0y7UAPf60x5S9lOxRza9weZkCpCfAyT4RhNXPeloQSpzTfeFGNgIS5vEnoZGPjP+grBjAd1oMK/hCnmxjML3BrQEfZ97PJj7TuoafkQV5mB04tZnpg5GWDCgBzLw9vxvUXrIFeNwf8/JNTuTKvhtsVk1Fe+EfkdYxbMyAoUFiUMaVZPDUMQLY0pPcTLVwweX5VXY+93HfBmyMuo5ecmPoDLwKyVKlVP84NQmqILPqjLAHeQUGFPF0OC6jP8OLnEHbbHWYI3pxWvlAJUX4TeZWpmACYbkRNr0oitNQmG1tcuPUL04QLbXTMNUkFx7dyMW9po6C0BUCCgZEE4wI09XoNIkf+lu//+BxX/BZQxnj2jdCXFKRUokYTOR4OTIamjDrx2td8WuD/qi1e8UaJudwdASzOir09+nZVmKssEAxitmbKtG1hAIx9skNR3VJlOodjZknYCQTAf5x4M3fpxA/MDIT
X-Microsoft-Antispam-PRVS: <SN6PR02MB414310E4EBCAC7BB8AC9CA4CF66D0@SN6PR02MB4143.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4143;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4143;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4143;4:QJep6bvzNcaPkCh2rhzKA+4iOs+D1ubM+bPkYOhoGs9IQyZaNp50gsgkkpZg+cS3k3hBBxifiik3GMRleEqsomGEJBR2kN5vdqzl2sp1+0J08GATXhwlwcaLOnOM+4GkTXcc0dw6HLqC4WVgdQYlkQQ66ApFSUTBJO9DOibZc9U8UaFD/bPU7muatlWt+7MpFa8O1r2KACjKH5kTcS2shMao/m+ZReFyXXjP0tL74PRIUX0YAIwnsALcHYlRUxjPMxml/7EW+kQIq/CNGHkP928ei14LG7VPeqcFQqRVIamSV9DsFmuw1LzHox3YdxTMrBTFomJAxhQWOh20CrXF1zWatw1lzBVLHq4i9f2f+M8=
X-Forefront-PRVS: 0687389FB0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4143;23:3pxb1kdDMz0tIWCFWTOjPhoQWDBEdpaUK5Ko2Z9cE?=
 =?us-ascii?Q?LVMSBMeiSDFmPu6CauP42UF57pfEIXAkWfxbKaOscJkaGBq00+/jKkf0bIaf?=
 =?us-ascii?Q?f8LT7jBj2goh8fl685GI/XmBEGgU3L5MBHqwTubJbtK12dTqsqarD0092wJa?=
 =?us-ascii?Q?yzoffdkyj1G4nYnvc60VR7tVa6Fua1qDEHu23fOMYCDry0GcePMyf+POr7A/?=
 =?us-ascii?Q?xHNy5CmyEySko/Oi9xzzZzgwX5rqIYfJ/OTeiR2IOLmA+19jlY8H0L4MVoAh?=
 =?us-ascii?Q?yplq8+YtGVkD4HfWC3a+mJd6B/TwaOeCVReAl11wG+gaXE3yH8XPu70tnw3i?=
 =?us-ascii?Q?pMIsZOT6uRdbIWFWPLCO7y588Xwl1Vq3azAwzS6hHTwXGUPsTQ9BRtQ5ewrr?=
 =?us-ascii?Q?ZL6cBhYaZpgvYKuwIY7+zNpTgW/C+flWIP9NkbFFUGc09TXM6CPTmmadKv2m?=
 =?us-ascii?Q?VcsYFSRHztFKt27ZKoQKIQfChrgvu+AkAUk+0Zlb+F9ITPz3RpI5gjH+3X1W?=
 =?us-ascii?Q?d/bk93rGpiksCDghj0IJSgPkAB4D1MiZrZWAKx6GIuZnT3xLr2AJKKSGNYpf?=
 =?us-ascii?Q?CJerwCY9jBMzZhrs7HSmBbt9wf5ZTWIeGhUbLdfhzvhvq/92ki+tDJkLhPAO?=
 =?us-ascii?Q?0jJybruSI5pgeGCrf1sAMJEr32OS1Ievgux9OfzHhyS84er1ESBMRtvJmPVU?=
 =?us-ascii?Q?UNDuj0sLbAv0i6p7oYpn7QA5wjEZGu6AtvRn/gus+5+32RFaVv/yRD0O5Wwy?=
 =?us-ascii?Q?brDJAGFm5sR05wPE6u3DAIFAM/D0D+J7ST3kUekDiS8yU0iDLbs6ROsF4CKd?=
 =?us-ascii?Q?SNwSIy3E8kp7qgR0abZnYu+E/7cB63BNyUWObBZNDt9+2TfHbl1PxjPj8xRN?=
 =?us-ascii?Q?61P3tZhp0cywYXDdPGjJbK77eu47LPtAjSjfdTKFcZhaMccpX4tOb+yJd476?=
 =?us-ascii?Q?eJThpwktwErJUuSvovnddMiSIPmg7PyFhuy+dM1Hpy75g9X64aB83NkqQz3D?=
 =?us-ascii?Q?6nnv+jzZYReukQqzhnN/Bu0EsyGjp+JmpY2kiLJrI2eIHg7ym3SwP397wEfR?=
 =?us-ascii?Q?79U8eqxMpy667nTg0aqOOt8ECFykywL9kLQScSJUSvtRhtA015oMAbWr+3r/?=
 =?us-ascii?Q?7pdIqAVR/sQyBZF0p5OH1Gdmm2P1Y5DOkHdi1t5Xq8McGBJnWndprvWSxnd3?=
 =?us-ascii?Q?+KWBE3C9QKY1iB7DdzJz8VbR4VsAT2BFHYQDPWYlrO92zhjq9LS3ciPEiih/?=
 =?us-ascii?Q?DcgTQrJavQcPEsXtJWZRA0shw/oE5goMaUcJ0Vc6I1ljizBmGFJufycdRg+3?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: JXLciPKUbxGwJWEbaXFgD2GppvLTqYykeituqQ9Qrj/myt8bShoLGYbZUNR0feXn8cgWGS+1x2wFlEYLZJ1tPb/sdzm+sa//B4uF1fu0dLesUPe6Zc+S25Cf+xEGbVnqnJf0RENx4RW6ltrV8n11cBdX7SeAwSw2+Dv8VRu+aPokOOua0YpFkgj4vbHvHdGM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4143;6:iXWmC8ljru26u3SJn4lOZeUQ6rLqTw1L6qaI4QMOeaQ2j4bNISiw2hTo2Yk8lV4YxqpMTPcx4tJsMEDBpmc3dHqUoV/fZAMnqd09nSVFkGgXbjOmA51hnFcVs3SST9YZGYh9K9i1kHZxMGIwwI8IyMqG1ntdR2h/pXi9ZIiz5tV4DWlYzo6scxVhJ81C2CjmlAoVXsDKrdpgxKA2hsbj+9JxRGfdedGX1pLacoTLKYTiEw//TSYtr5kW8+EC5CndR4Ww3PW+yxgoxeNiIKs5K32sOVqchyGWJ7bDpXTF/c4zi31pK1m5Ec3AOSrPRSu0SaT6kyWR1GDrVLQ6VFwFKsmVuFEXnGcCHSq3yZA0p3Mz0xnba9sGn1fnn+NTEo4DBFdz8Uj2H8/PeCxFF2HrADJ7S223HO+3h280NzB7Ko3xTwuLqJTB+cS5e0iO75okxXFs+C5yRSQDai0T9y4u3Q==;5:fwpmsSyVldUhnQo+78sumamixlIjb08drN4sYR9WMWITXrZQJkvKZt96Wh4371GpD8lVrtSoKQfHbRzkHxYc/NL3VI8k6YTSMR1PWBgW2hYAatTdt4TrAzCjlqmrPFQRM6Dz66fdBE7PZw1qbIke+5PdoOX/cBp2EMvEkv1wht0=;24:eQC9vHgFZvBqAb6TCfjK6Da7Ewgo5d5ID6t+jRr0rcedm3SyB25250+XMwA72tfj8ZHTyeDNmPTIzWHTdaF9JrNXdr1JQtNi8h8cvh6iFjE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4143;7:GlUDyShK1eT+KpQwzeb4zgzsGS2LXTc1wdnLu987WgWts4NpK0Y2dpJgaBLzIJ2Zuk+7HFwRGbeM4Y/misd9f4F4HKser8A/V5c6Y2usWg1sQOyYsRbdamHxdNTeKEyG06x63duZHZMx0EhdwoYrDPcQMc4V4yRjV6Ea15B24HQOdMasNS07uUHGdicx9PaAERhvMYwqmuLY4bkrcxjwFXTVFZ7wMpUxOHGoQI2bNs0ZxvBp4TKau9qS0C0b/htX
X-MS-Office365-Filtering-Correlation-Id: 6c1ceafc-f7d7-4ce6-4415-08d5c5960e04
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 18:57:40.9188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1ceafc-f7d7-4ce6-4415-08d5c5960e04
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TIvwd0016387

Add bindings documentation for Xilinx MIPI CSI-2 Rx Subsystem.

The Xilinx MIPI CSI-2 Rx Subsystem consists of a DPHY, CSI-2 Rx, an
optional I2C controller and an optional Video Format Bridge (VFB). The
active lanes can be configured at run time if enabled in the IP. The
DPHY register interface may also be enabled.

Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
---
 .../bindings/media/xilinx/xlnx,csi2rxss.txt        | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt

diff --git a/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
new file mode 100644
index 0000000..31ed721
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
@@ -0,0 +1,117 @@
+
+Xilinx MIPI CSI2 Receiver Subsystem Device Tree Bindings
+--------------------------------------------------------
+
+The Xilinx MIPI CSI2 Receiver Subsystem is used to capture MIPI CSI2 traffic
+from compliant camera sensors and send the output as AXI4 Stream video data
+for image processing.
+
+The subsystem consists of a MIPI DPHY in slave mode which captures the
+data packets. This is passed along the MIPI CSI2 Rx IP which extracts the
+packet data. This data is taken in by the Video Format Bridge (VFB),
+if selected, and converted into AXI4 Stream video data at selected
+pixels per clock as per AXI4-Stream Video IP and System Design UG934.
+
+For more details, please refer to PG232 MIPI CSI-2 Receiver Subsystem.
+https://www.xilinx.com/support/documentation/ip_documentation/mipi_csi2_rx_subsystem/v3_0/pg232-mipi-csi2-rx.pdf
+
+Required properties:
+
+- compatible: Must contain "xlnx,mipi-csi2-rx-subsystem-2.0" or
+  "xlnx,mipi-csi2-rx-subsystem-3.0"
+
+- reg: Physical base address and length of the registers set for the device.
+
+- interrupt-parent: specifies the phandle to the parent interrupt controller
+
+- interrupts: Property with a value describing the interrupt number.
+
+- xlnx,max-lanes: Maximum active lanes in the design.
+
+- xlnx,vc: Virtual Channel, specifies virtual channel number to be filtered.
+  If this is 4 then all virtual channels are allowed.
+
+- xlnx,csi-pxl-format: This denotes the CSI Data type selected in hw design.
+  Packets other than this data type (except for RAW8 and User defined data
+  types) will be filtered out. Possible values are RAW6, RAW7, RAW8, RAW10,
+  RAW12, RAW14, RGB444, RGB555, RGB565, RGB666, RGB888 and YUV4228bit.
+
+- xlnx,axis-tdata-width: AXI Stream width, This denotes the AXI Stream width.
+  It depends on Data type chosen, Video Format Bridge enabled/disabled and
+  pixels per clock. If VFB is disabled then its value is either 0x20 (32 bit)
+  or 0x40(64 bit) width.
+
+- xlnx,video-format, xlnx,video-width: Video format and width, as defined in
+  video.txt.
+
+- port: Video port, using the DT bindings defined in ../video-interfaces.txt.
+  The CSI 2 Rx Subsystem has a two ports, one input port for connecting to
+  camera sensor and other is output port.
+
+- data-lanes: The number of data lanes through which CSI2 Rx Subsystem is
+  connected to the camera sensor as per video-interfaces.txt
+
+Optional properties:
+
+- xlnx,en-active-lanes: Enable Active lanes configuration in Protocol
+  Configuration Register.
+
+- xlnx,dphy-present: This is equivalent to whether DPHY register interface is
+  enabled or not.
+
+- xlnx,iic-present: This shows whether subsystem's IIC is present or not. This
+  affects the base address of the DPHY.
+
+- xlnx,vfb: Video Format Bridge, Denotes if Video Format Bridge is selected
+  so that output is as per AXI stream documented in UG934.
+
+- xlnx,ppc: Pixels per clock, Number of pixels to be transferred per pixel
+  clock. This is valid only if xlnx,vfb property is present.
+
+Example:
+
+       csiss_1: csiss@a0020000 {
+               compatible = "xlnx,mipi-csi2-rx-subsystem-3.0";
+               reg = <0x0 0xa0020000 0x0 0x20000>;
+               interrupt-parent = <&gic>;
+               interrupts = <0 95 4>;
+
+               xlnx,max-lanes = <0x4>;
+               xlnx,en-active-lanes;
+               xlnx,dphy-present;
+               xlnx,iic-present;
+               xlnx,vc = <0x4>;
+               xlnx,csi-pxl-format = "RAW8";
+               xlnx,vfb;
+               xlnx,ppc = <0x4>;
+               xlnx,axis-tdata-width = <0x20>;
+
+               ports {
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+
+                       port@0 {
+                               reg = <0>;
+
+                               xlnx,video-format = <XVIP_VF_YUV_422>;
+                               xlnx,video-width = <8>;
+                               csiss_out: endpoint {
+                                       remote-endpoint = <&vcap_csiss_in>;
+                               };
+                       };
+                       port@1 {
+                               reg = <1>;
+
+                               xlnx,video-format = <XVIP_VF_YUV_422>;
+                               xlnx,video-width = <8>;
+
+                               csiss_in: endpoint {
+                                       data-lanes = <1 2 3 4>;
+                                       /* MIPI CSI2 Camera handle */
+                                       remote-endpoint = <&vs2016_out>;
+                               };
+
+                       };
+
+               };
+       };
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
