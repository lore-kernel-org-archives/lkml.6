Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeDWHXb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:23:31 -0400
Received: from mail-eopbgr50108.outbound.protection.outlook.com ([40.107.5.108]:38184
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754003AbeDWHXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:22 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/8] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Mon, 23 Apr 2018 09:22:54 +0200
Message-Id: <20180423072301.11962-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423072301.11962-1-peda@axentia.se>
References: <20180423072301.11962-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:JHP6HPHw3ne3B0bQFgcsFR6ij8HQjvj51nPv6nVLwPNKnfND8mGL4GmDlg8WRhiJ6tzjsJQEHvXEK/LdhFiRb3Rf83BpHjPkzMfx2cpAa42RIgmb6B/JD0O/Pw4L6gKHSWXJ2PCty3fXRxytuPWekse5VrzzOf0wO2DJrCz/S3YE8ExNMm5Xatl0SSyeyyVVyZoxkOaJCcfMVS/A8cFpC8n6XiVd1JPwc+gNJeHZmzlZ3EGecQ3Y+jUPoxHM7lS0;25:3o//FBvhm7cqvdXd/04vC/7iRf/+SGUKy68CcfRWSi2OW6q+51rBuKdlSvX+zr5hxk5HUBnZ2AvH8MmdUxuVDeeTjQ3iAmTMHoX6Uax7hMoqzPBuqepvftWEYGggdyVOprUGSQfiuIE39T34IjgldpxcrY+nYOnqvR/TUknNvOrteDOPTATwNO6cWU7Rgaug3mWqeFKGYST3QNPZDxR9OEJ6zYmoebb9hnc0a77LkkxpLYh9FV+lvzEJodMZpwoG6idrJCxCH1eycnqPHyditi7UK48Oie80rFAG5XalINkZ+zOpiGx6DxxPtt4mF5FTP16GECvHVP7oFezf6viUsw==;31:j2tlAhKOMDwKP9FwjIO4t4SJk7U6wuW7PVoS4qgem6OMENhL9C0bxiOmcJ/e+wV6P7rURtpm2AR+mujGXeyRbv+59mG6VVnszD+VwFQzAmpASXDuX28Z35tf93H4csPtOIcYRyBR/up+6ixXSHxxQQGw4hM0DKci7C7woqdbrf12do3DXHL7wwP8g6/3WmCGAZAMQTYWZ5V9Z/pvAMzJIbNb94rjZrXf+dH2QEB5iak=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB277460E6139203AF2FD51115BC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:E4cAPhltTUElIcAIpv4UUJhlQSRK3nYHsb++HOrnptYsRjmTFNZqo1z0ZbarDrJrNe7qRyndEnwLWTQFHj9NpZ41+A3Y290jQLWYEOf96TUSIoUsA9Xj5sEL2vRW3DjtWX2oTe8OeOjAopaKVCwLfu+VRjunYcSbdMqoQi2nZM5binsn5oAgolBJDNIPfYPKOZ7dCidrJpCVVf2Bift6LTulzr620jy/VfX16y6QhcPYET9JOKQSziUkVkBJuy3scE8aAOSB+ZyBV8y2UDKnjQ==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(6506007)(386003)(59450400001)(2351001)(25786009)(2361001)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(11346002)(76176011)(478600001)(52116002)(66066001)(86362001)(2906002)(446003)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:nfM+XF77i6UjT+d1MqGgBeaLHS6on4eOdeVBdEx?=
 =?us-ascii?Q?tj9C8vD8d6peoXgiunyOfBO85f5Y2RpT325jKlE9roamhUSI7XhraI6fq6nM?=
 =?us-ascii?Q?qmtGVJxoajzafjcAab+nsKfW09qGVy/krYon0Bg9zFqaGNS8mi4keI/hTcsQ?=
 =?us-ascii?Q?230VM6tSgs+1HJl2Bm9ZG8EjKaWd5rLl2n8BgX8AfBmNO59G1m3y4g+s/QZ/?=
 =?us-ascii?Q?RCWvfGvXvMtSeY+bn+ApMTodQLuCDHMjBhJThnLyr+MCF3NrrpJ36lrLwDim?=
 =?us-ascii?Q?GMEW5G/zSf8FgEsPlAs1DwPH99Q90HqPiX64wHBZ4FVmylDwJlBdHs/tM1PI?=
 =?us-ascii?Q?E85DGmf+dc8UUrGdgasJa5eDq2kz6F+dLnKusq6rG3JeulF7HUheDQPZJzfL?=
 =?us-ascii?Q?o6C8Be/U08yrZeqNEIWZm/0BChLhZ5sZGLP9vZpDIhkMfJwkzA2uV0Fw3c0X?=
 =?us-ascii?Q?ypMhkBuSar5m9Ni/JuT4p/Qkq9hh5A4tFizSZnN4LiFsylgJo2xKuyGLq8Ys?=
 =?us-ascii?Q?hJb4s8DdUBvVp6beD0RRcqs7Lh74raH8WdV/uEO/0aY4XhK+xbdt7kmuB8eY?=
 =?us-ascii?Q?DKtoQH+TMZDRhsr7PVCEDpMXY+BZ7Z8Eqgoawae/yb8tC7qaBs10K9oZn8mw?=
 =?us-ascii?Q?TvTcdTFoCYKlgSPptt7MUPohfLeMXqyMOIP34N93gwWjfiLPMKKG/1wg2hP5?=
 =?us-ascii?Q?JZF2HyI+kJ95gQmGcQANLKyK/GqhcKOsV70nx2pyBe5LeZqrF9RbHbOvw+WC?=
 =?us-ascii?Q?xBphE0/9JbIKhEaa0IfF7mnwWwnzfKRAMsfbY3DD01pcHFsG6rMK3L/gzZGE?=
 =?us-ascii?Q?wucYSf0UTDhwibk/DxgRwFSGXt4XVZtzB3vNxMEktkr8teRMSbBNS2JdsfjX?=
 =?us-ascii?Q?Cuxy9LtgMfKZ+ZoRzf3c8QO9D19mKZgoRTbeVWs2jeOV/M/gz0s1gO0BSCgV?=
 =?us-ascii?Q?xbhaiYH5KmgxYrSVCeox6rtztO0v/nih2d6x8AGXRw8SdZpMaUS9AyyR71dN?=
 =?us-ascii?Q?y2FqIt31zPS2JzwCIZDiuBRU8DqsVTQo0x1KdaTajF4lZHgQfmt6yYHRjc8H?=
 =?us-ascii?Q?8PxqoGEvyhW0VhMM5701WU19ohKc++TMlVva6yQwakOB6e7Y520L3Y0yNi5J?=
 =?us-ascii?Q?l9kHSn2/3ZH89U72X9QwfFaN8T3ut+3+syw/qXDVvopVT+RKJ8gPsdg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: eWV+tuvde41ZQ2XZ4zFCA+m2p6+xJUzShUgE5RvHBsKnI6s1Fk8mJcpxVcQv6c2jIm0g55pm9OTScziBRsxTq9ND8qwJfBIIZbIoVRRb205QUMcOAOPCznaLAD7olF0EJFhb9hy3JRUqMGDD/TFVZwckUvRApkrUEQh+hLetWL0JtHOE8LAz75DYRLdcO3X4
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:8P7CMAQ/IHoMVvm6KjYfY8yM8i2Tig01EIpM4HtFaJv5sfc1aMEt0rPAiPRxIXvim6RhwNFFiJehrQdFtF8hgDdTDM+RIn9pSXsG55h5Wk7B/ciFabvvYNAlJLyL3BEV0vJuXq1w+zx8dlR+0CIn9Lk27YEfTv8UEwDeUaWIfN+uUhVl4dGrPwhHUvQPNkbY7vm9khHE4BNNsFnWizIUY6MKKiBh1WnghyJvWDAAbhw6fN34nEewQTcjS/ppaCnZOa+bY7V7G6DKy3iWzZ3YqzX5hdvp3btiPRPGGjo+bOI349aFlUl492MlIb10Q9Uhl8i7Y0BHdoAVkPFNzud4bm/5IHD48igq52T0pJpgX0+JrZ+JrKwCdkhsd8pDdD6zFKXtSWKEyn5HO3RrHL2arhFJD7oinuGhAM79DqmC2VxxVgbhoSB43/ll3TrSyeBr+yfZHyG5bb+JLtkVyjEGyg==;5:SJ+rLVmUd3/4/Q47IYBeu4acMa0LV0FL0d0AsVrh0dekm0FYxcgRg5eRpuAYc37DMaV/3ADo2i2p4JAkUlAbhMEJp3P+tVGSFP66tm/hiLapXrTW4pQanvLh0mtDgv8RCJEszNaGFz2QKQy1TahJASL0G//dK7/RBtyMpSlaun4=;24:5a1+gc5mOLz+ykH4JsX7H2aOHhS4G3uefqhH1hGi8Q20lG0/mgnjtlPO3M8BhPOdB47NgHJGiv6iCyqAxFhrn76p6Q5sbwdDzuQfXzQVg6M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:A3jaPEIG3uwVBG6JgDhTMd2VpXGlMNJxXieVdJhBQ2AYdAwkK3SHVDIaFKFl2S0SzesTMgv6vipj/R1NpMN/9WHNoxo1t7Ma216hr/Ht3tZqBLwtxGjXJAQhDaZVHHO3qvOmWyA7QRyyZg9a9Tt4tPCo+/ZmYbb2juH8yt+J1no7qlkEfkCuL75koCA1ggMEOcGY5edhOqwZlX90S1NswatKrwKusLZR+odnZA5FJ1a/oFA64/7un3kKbxG/BSyH
X-MS-Office365-Filtering-Correlation-Id: 666e9efe-6f6a-499c-e15c-08d5a8eb16bb
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:18.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666e9efe-6f6a-499c-e15c-08d5a8eb16bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start list of actual chips compatible with "lvds-encoder".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index fd39ad34c383..50220190c203 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,7 +22,13 @@ among others.
 
 Required properties:
 
-- compatible: Must be "lvds-encoder"
+- compatible: Must be one or more of the following
+  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
+  - "lvds-encoder" for a generic LVDS encoder device
+
+  When compatible with the generic version, nodes must list the
+  device-specific version corresponding to the device first
+  followed by the generic version.
 
 Required nodes:
 
-- 
2.11.0
