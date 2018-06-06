Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="oi3x2oeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAA60605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeFFGnU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:43:20 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:5570 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932107AbeFFGnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:43:17 -0400
X-IronPort-AV: E=Sophos;i="5.49,482,1520866800";
   d="scan'208";a="283172778"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add bindings for r8a77990
Date: Wed,  6 Jun 2018 15:42:28 +0900
Message-Id: <1528267348-18960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.138]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To TY2PR01MB2300.jpnprd01.prod.outlook.com (2603:1096:404:10::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2300;
X-Microsoft-Exchange-Diagnostics: 1;TY2PR01MB2300;3:AyDzI80yNGnOpsp6brUCPtkTMSJJEV/W+J1gOit91ajpPl3WrwiCTVHnsOnQ2xUx7SXPjdKNp6cH2kzXufHKTk+rQTltsHJkYdHIe2nN6kfLnpnAhf6+CmzfoN0ShcF3nozdUN6iTutC/lz2owg+PlNqZvs8SQBs3LAYv/kk4OhSapinkhU5FjaYTHeAb1ZRngVKuFIu4R32e2PigIFji9odmeg8Lv+mEWDKyc5lxWsiMCgIsYdSLsTZ2ztcON89;25:QT5ZAvwUFC04uuR3KswoW/yI3dQCb10Kg0UYXMMNO30ZNi6Xp1hskvQ0dXB5zaRsTx38jsAJmVRO1FXMjvncax9Pb/Pu+2vnKNXBgTrgw/UakeSFELUofWJW02klEHxKlT5x25OtTlszLRANH8g9nA5ymGRrOU+oeACH9E0n0sDHno8/xhI6jdUnpmd3cNF591IV+IyvHUSXeJpuX2knPTJzK+ls36xKKHeej1R0fFLf23lnHYFqQQaqF3epF9Zf6XYmA2y030Y2EvIUaKjsPb0IQ46DnICu9cYxrTK1CM/8i3NK5WZI5ZDlzRwVPw3QUZAUb6JkLNwR+cksKwHK6A==;31:HHt45CNdEwnnaqNVnryJEvCaz2Rv48hHTBuMXUF8ht/xF+p7osQdVJlJOBszZKqUVrkqWzFbi8LGoVx29t6de/UriQnX0ZCN5XXXLVhkfcgDMT/RHGrdKiC5CKdPQglXbQpVZn8TcpXYE0MtwCNLaasfryIMjj15eSCyT3r5C015Djhrbe/N2p9scjdXqL5AOFlrb/WRjIItc1K4dlDKilFJJGoEZBrWvWMkDNMPvVc=
X-MS-TrafficTypeDiagnostic: TY2PR01MB2300:
X-Microsoft-Exchange-Diagnostics: 1;TY2PR01MB2300;20:aPZAoxUjPZkHjmxoiohv1YAc1UjPSFSxuIjvepS4tuCSdYmCM0E0DFF4bQKv15i2s15DwDFwOlWXywSGieTOkKqZsOsmKym3urSvbpTlg1vOVAaqeVGZqF1PFUOosngmYyRyL2mkp0cpMwg8QWTsmjnkGGSkODCPHE+/f5M8wNVDbGVFdku7Q6Mb7IxSFYoDnHZGq/ztoOeXN6ihxScLQdPUYqa5c49gDTAgMm92e9zryLSNgzXpZ1qH2dBG4s920IhoIpi+IukRWRaFM6yxmQ0nHw/Zunwuqd+fGGcpqJGpoBd2Rt9qyqJP6grgsPpf9blfq5wQ2HWgW68I4sm46IO9RDENfKX0VA4rnI0z5rgzLr2wPvdd2w8jKQG8yUXAmPXlP/U+ycr+ORQrJJt+26zqCdT0Y6V+tR57v4xtiS3K2DbZiholkw4oxaatYSUUWu19P661rtbNOl+KUIZS++y8l82w1q1k0R/O07w/EDeSHOWURIXwtStWS9vZV+vz;4:ymaj/MRkyQdRoeTKRCBzja98FQ8PY6meDyVDUMLgRmCVwhW3hiQIUU5ojVo8TyMHwaZxM+j0rG1Ain5Y4t4joJwsrU6wZzVgd2w9eqVNBww+hbqgppNJP9dnRi7RDQFh0OVzzevlkSDjvQFTBwddwPcerLwiidBzAA6njP7tA0wt82NnRFnfywsZiKuQ8ozq8tWoonfKevLu+IoZht5hTkvTCQVqZjmi5gfMZAcCipc891XN+xhY9ltXsUBaq+VyERCeNnv2DUyD3ENKnABuSg==
X-Microsoft-Antispam-PRVS: <TY2PR01MB2300902051FB616AE2907C52B8650@TY2PR01MB2300.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:TY2PR01MB2300;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB2300;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(305945005)(50466002)(25786009)(6486002)(6512007)(105586002)(48376002)(2906002)(486006)(106356001)(6666003)(47776003)(2616005)(476003)(956004)(4326008)(107886003)(97736004)(53936002)(6506007)(16586007)(36756003)(316002)(498600001)(3846002)(66066001)(42882007)(386003)(6116002)(26005)(8936002)(16526019)(81166006)(5660300001)(7736002)(51416003)(52116002)(1857600001)(68736007)(50226002)(8676002)(78352004)(81156014)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2300;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;TY2PR01MB2300;23:GCMCxhyOFZPNJwZwIM9F23nvfkBQ/Ta60IX2x4eHQ?=
 =?us-ascii?Q?jYttZq3oTPDSLHXqyOD8ZZdR1ULX3FRR/1RIo4tFjmtV4A+ACZO0/nwk/Pc3?=
 =?us-ascii?Q?jKk5mgn+47l5qNc0cg7Hzs/n97d+BWJIae6oq+fLxFNY3E7aHyk9XoGmZE1c?=
 =?us-ascii?Q?GcIiPDJutU9Dnlg7ZfoAe0/6aBx/hvdHG7RVfjoAcdb+AUYg+ErA99kKP55v?=
 =?us-ascii?Q?k0LtouRIB6vInawS6eRDLJZTx8tN1VT0BVEU/D8b8/dz4zCeIia0geQi8Eq6?=
 =?us-ascii?Q?F13xs58fpJwWp/mNdETMjAfDtyl23S0NPV15HgErSU0eKRXhKk7uGnNRbtWQ?=
 =?us-ascii?Q?1nRw5SU+B2f+yMW5zj1ygQxgId+HVYQFJ6GpYkahVfWMMJlNPc8lyxBiG1s6?=
 =?us-ascii?Q?2Ozud72KuSMgqcaH65+Q0J27uyxAd3a7XqPUs9Wpm/njoJ+Ytpk5CurNi3xH?=
 =?us-ascii?Q?tAZ7cZzwQuKFAQb9TGLMs9PKJWmN5WOWgs2DRZ+JJFRNoQN0XQl23NHvmxM8?=
 =?us-ascii?Q?TjjmEhso5P9sXCtCcRgBNBfZV6S2hL49Su4p7SjgbgXB+Gi5IF4guQZ90gcf?=
 =?us-ascii?Q?IADq4hqzdtCtfeoC9Ul75MnB0v/Oxep5s5Q2YM2S5wxXASUvTpH+odIGtp9r?=
 =?us-ascii?Q?6GQO+cSNFHlK0Pggm9OJLiaaUAf61snEVU4MNEx6868w/vBv9wkBW3F6dN7f?=
 =?us-ascii?Q?IPRheu/9z2NYJdZrRnJ+PXC3dIjYbuAa00GDCoYKED0ZRcDxg4z5lnVBek+v?=
 =?us-ascii?Q?t5fzIZttrucVWhk1HIRWPTnZWEWRqgUPQsmiNR4A7SWjjS2uhmuepWabtYaJ?=
 =?us-ascii?Q?yRR1VHFGh31fw9CXHKBJX9ldNamo9eIDCCzhDFKY1049OFjnKVYY8cyluU4G?=
 =?us-ascii?Q?twSxTFOYJeqnt8JEhieKfMifQ/2odn6NI4hHbZQzbA+f+k6Ov7t/TKPbPgll?=
 =?us-ascii?Q?/MIevSLcXQ5p3QTXlXslqNO/zwD2KRlzTo69LkOXd9qurAV9hUUa1b/GlzvN?=
 =?us-ascii?Q?Z+2ndKhmvqoz+2Rm192JA16w5ChCcL+7GN3eaTJmI0er3OsFAnI4a2uab4xZ?=
 =?us-ascii?Q?5gMLTbKvgix1s3SlbONN0HQlaytop85YnAvvuwdexBpFelkrtBC9c4rK12Qd?=
 =?us-ascii?Q?NhLMU9je8HwccnJpbYkbK232n9QSh1lZ6avmdG4H2IJ4YepCIdKKNAA1+dep?=
 =?us-ascii?Q?aECu+ra+9cIM53NcB5m33ZTwLFnRXgpPxEK?=
X-Microsoft-Antispam-Message-Info: 3ywJaFmv+88VMAIW3YKD2NP/YKUmFAGxFdCU2+54iJl2sVGsyCL5+boLG8kiN543vf8XFEZVUYkjOs2GL2W84ghIMxm7jDh3Ur/esXeUndSanwNwmFc67sboPXoOicULtKADfI6cEqYgZmrtd1zubc8/lKlLq+AxTl0G9wioqKTPN37BuSMhIlDe55/eNpVB
X-Microsoft-Exchange-Diagnostics: 1;TY2PR01MB2300;6:xLTJGgo1C0LSIZlQ+ueeaCRQSJODmoNjwmiE1jdDav963XTPl3Tw2SVnzaVf/JEicLGomcWqmt2Zif5W8bHXGJgtKYfWx/q9olrLVTticcHflbqenZz+TzAJpFJea9C74xAaUSUf+DLooIVtvzOrhSGjgm9X8MhcPw36e/e0TUAuBAQ4O8UkuhU6grx5yR1gqPSAdyjbWPLTGl4kHhO0UycG4e4Bhz+DHj/64z710MUJ/xGDum8J2dI+JP71NJlvwootKOYCcLf2yHAqEI3CNJVaOoTXu5BzWw65/c8cUkih3JupcTa5zJ/pS8ErcfpcPiFszA0pJe0R8NNsCsbQ0TqbBCPJt0bbP/IUoDSX9bu7cgypzNvKZCFoUOYTiihGp/Cv9/9HgNTC7tsAzyf/OGErKOzIOIfId9Ku8o1XydtNnzU9vabE0naZnP5j0ETQPSPioMozGwHOfzgfIAt2fw==;5:ZpygV5aPDBXOwsERFazibzkOzIovstewEQZEZ+o4OOZKRYDx1WbZsDuPO+PcYv02Exweiwg1p+tUAmGC68XlTPqR9m9kXfdWR1fQQxfSsCJinZ81ewUCFIjYHB8qNzvNTIz/LRgWieDx+Bf06K7Hu5pHVkvcg5zW47njlihDjDw=;24:KN5dfjqUsVvWlR/Il4tZfwVXnJOUIvV2G9E3g/3xKyi3kGlMYllSBapIfnvwvreoeZam6wi+Mj0hgK81Hc8P/+lvhUCEXGjxp1C6zYC83Eg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;TY2PR01MB2300;7:kINRmPd/J3WsUnl1RNo2DqXNjDQuUM3txHYj239uomXviZQYSi0jV2xc4NsJjCXfY7rWZ7IXIsde0dFcvbX16NroLYwS+iYhJUhA7tph/6LFvbu3og5siu6Cp9mZA7okwQD8/gwL7fL4aiTmMuDpCve5w5n235J9VBmxPwMVJ3de4AF4em7q0llm5q6Xo9+Fas4ey2bAlpADguJzSKsIHsgtNAv8urE4NQIHQGY6h46PVwOUZeXmtFAJq3Ol++LM;20:+gcIoYoBWUOHPASaLt23qC9IDslg2BUcykIANFOOxaIik/Og3qFYiKXvvwEKndkPJ81FCMvPsYD8eu930GHj8AWpdgafsQyEV5lRhiq4+XtHq/ta64bV9W7E57Ck/brVt++lEyvui1aPPbZZpJjtqdFx/XGizznfD/rxSx+8a6w=
X-MS-Office365-Filtering-Correlation-Id: 94f22ec5-1ec3-44eb-3ca0-08d5cb78c61c
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 06:43:12.2145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f22ec5-1ec3-44eb-3ca0-08d5cb78c61c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2300
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds suuport for r8a77990 (R-Car E3).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
index dbd137c..fb4a204 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
@@ -10,6 +10,8 @@ Required properties:
 	      SoC.
 	      "renesas,usb2-phy-r8a77965" if the device is a part of an
 	      R8A77965 SoC.
+	      "renesas,usb2-phy-r8a77990" if the device is a part of an
+	      R8A77990 SoC.
 	      "renesas,usb2-phy-r8a77995" if the device is a part of an
 	      R8A77995 SoC.
 	      "renesas,rcar-gen3-usb2-phy" for a generic R-Car Gen3 compatible device.
-- 
1.9.1
