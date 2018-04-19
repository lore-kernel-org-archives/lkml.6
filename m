Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeDSQ2V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:28:21 -0400
Received: from mail-he1eur01on0125.outbound.protection.outlook.com ([104.47.0.125]:48919
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeDSQ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:18 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/7] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Thu, 19 Apr 2018 18:27:45 +0200
Message-Id: <20180419162751.25223-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419162751.25223-1-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::49) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:cNN9BS6lyesZENP1ENIZF6wlR2iRyfmW16QNRC4xxZwXIPfhllRQfjh9Xak7Zeet5gi4eB0p6rAQS3y6nhbVxJ20NvysI22rdL+KansuEyQpI+uebeKtD8Wt8jXwYkU+h0UdFveO5bRMDktsffpyEQyJNIIXF4dQb6ZBsz4CwJ9KLemFT37czHAgMALnQLP68NK0r2fwYyx8xLn9/8dAoKI5JmjWx+3l93n9+6LiuXc6NiPDaKDLwzpkirROWHln;25:rcatWxWkf/OLCsjqvlaj+UfAEkXc8JGCtVlLPtBQGvZpCbWsue/jZgphlNazUveD9VVUrMAjQgu5wejJCEiWGICQzDFGXzfaXl1nHALs+7h4PvLrlgSHoKCatLi/Fr5JdoUj9IN8D/ibRr3/T36RMduRhgrsaNN+rI/q++BbyELunbJ0bhS7HPbnz0AekD0tsbeqGGLvd9aUSIT+c/0NdivBevwXyCl4PRLGG/g98yPscQiRI2u9orqgn1Sbkjs3zZVFfz6Y6P73rhCJb8ORFk87SkiNqe7TjNGuG7V78M8i7+odBmmvzfYgYdTuv9tR5QBGccoZEPxI9c8XtAnfYg==;31:h+/0LHI0kTs0jlhNM3W2GOrSMr7F2yniJNFt9r8rCDQv5/lYhn6ZcUe9agB3AAQLm3CmxRBY7yWQQyigAjk7ytNxL+gBmiAVT+0BNEkrSahKymVjW0s9mZIipzIokqw0XjUzxqt1hJeVfVpmx0yqzPhBeQyhvgEzBvp5sTHVIeWwdzwI0KzBt90ayXYJsFQOlCJi8U38VzVCf0kmHs7/zShQm27y4IDitnAlxTsI6Vk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784622A3A976FD34ACC2093BCB50@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:UijVFtwqUPw1VsE9ADDlV0Ejdq0zRTloPYBwRMMZtM48/IZu7ib0b7b21NHk/jCfvtSpsO/rI2T8yYZ/HS+CCY4vMTczssysRwzab4Pd+01IRujCBBBzOR1PMQWo5mRaDBuyNpAszJgzNSpfC0MMzeSo+lN5zacuEFNE1wL/4QDJX8+M3nQ4Ap69yO4Mvl3tONBPSE4GSU1oHaeHO6V6nKwg4OXtJDe4RFIZgJlbiILzWOfYO9qWaBgj8Pr46KHDXC7N7Le8DzaGvnoCYDmbSA==
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(26005)(86362001)(50466002)(50226002)(8936002)(6506007)(386003)(76176011)(47776003)(1076002)(59450400001)(2351001)(66066001)(6116002)(3846002)(2361001)(16526019)(305945005)(186003)(74482002)(11346002)(956004)(2906002)(446003)(6512007)(52116002)(53936002)(6916009)(6486002)(476003)(478600001)(316002)(8676002)(4326008)(2616005)(36756003)(7416002)(7736002)(6666003)(48376002)(16586007)(5660300001)(54906003)(25786009)(81166006)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:WsYPlUVWfzRn5lK8+wG+TRkFyLA01Wp7eVzvUwL?=
 =?us-ascii?Q?RZC2ZwfFHgibxWLvWOOl8XUY7ygg5djHeSa1tOmVLVbg+9hOpE0oJsLUxSCG?=
 =?us-ascii?Q?bGZzX6r/dY5qZIDEPd9X0C8ggujtvSGA00mK9b7rIvRmmqrbL77XRhi1Q/6g?=
 =?us-ascii?Q?5VYLgT0D1u/qgCbyxIiZY9p+14vNduBu2bMDYvIGQzuf6/30g2LTGKjqk29k?=
 =?us-ascii?Q?e4yPio/DqMeA5d6btUy1xyLPyFNpFPyPZRYd/MOxxtESg7vbmwpKvFW6SXh6?=
 =?us-ascii?Q?391nYA+/ilGGGRd6HLR7KDuHenEEyNDw6H49ICu7fDfOjgeFh2lZRIFYOUUU?=
 =?us-ascii?Q?qZQcK2FNKYF1Cj1QJC7EkPMLAWzbDJk5u3ZRdv9fF6pcgZp5uxoghJZa4q/N?=
 =?us-ascii?Q?wKcRM2IEWiL76EJKpQHDf8EhZVUOgfU7kzhehQXVMm1pxSon63qTohP4qDH/?=
 =?us-ascii?Q?Ax0yxcKKI8/hAg78QgrnhzBmfWKwWJNDNd2QeJ+iFWixT1jWRbBjp4jSQVBI?=
 =?us-ascii?Q?9pHqM8sDv1ppkOVn91Xe1uJRLazTdBDJOBJuT6rwnllQmfMNwbOSDkQZ+AW+?=
 =?us-ascii?Q?ho/o6lJpQZnB5sLPa+gHLZJEvH3gIDBuUXlVpI/sdI9nJ0HM6RanAcZ1Y1RX?=
 =?us-ascii?Q?a9O586XtJQ2aA4yvXwE1gLj1Q8ASTlQ+d5PeHudI7l3HSh405tLCa1x03MNl?=
 =?us-ascii?Q?V+y4UQGVURwXzUeLsJcKT3wq6Bqq4H4UYmdHiMwyVSyLnG23NCmdEhSuFHvu?=
 =?us-ascii?Q?zpVa7bhxQ81ggeayNbTXgYEt0QtiXZ5XyJl7GlfUM/dhnyrx1jEospMwt9Bb?=
 =?us-ascii?Q?CPOWfIH6hFQ3MaLgisd9bqWjW+ty2nLj/AdiYzyv8/UVo8/WTPWq1GHxW68c?=
 =?us-ascii?Q?NJFEmXlLjRZ9Ob+IdRftvr1AJsJYTefl68BD2HoUcsJ61OeOVaJIVQEwdZTt?=
 =?us-ascii?Q?JAGGvlsQHqu22UfGMsHuzzzNMWVhcdc8YmNlEV+sSu6J9trAkJSMEg+CaJe5?=
 =?us-ascii?Q?NUW9Fsn7qZuIjrn1qk1Mh6btqw/Yzbplt0sPHIu17IIjB9GqrjFFRT6H+lSd?=
 =?us-ascii?Q?+cJOWdb+hfqTvBZsyoZphlsk8bDbdOzRLls5u+pt8suHBeF6W4RJKypsIMdE?=
 =?us-ascii?Q?04WWHfRw7xI/nymAps525Xa4p5DiqNZx1SQ4f/6puOt5gHFL4T4IWRA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: bCT7UN6DU3QGTIlkwP4oMd5Y6wUFgRwMnpZBKt9ewown+PpgBwhXBI+5Mr7E1nCUnyxLaZ3XyT6cEG67XqOVNoCVUzjCkGZtUUeGHBPHzKhCytnyiOuCFf+A0IgkDNAvbwtGbh1OuVgXJThb7JUNFqv0er2ybqr96kr+YczQnz5R6K6rF0V53WY/0xtXy6l2
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:vT4xAlVcnB+bRln+NsfebT9LE2eIeFgwgLiN8YCYL/FDnxenQ14Dr8/icuG0MMf3H7MDTbCFB8bJmFLPfq1En0XfNE8E41i21jBTRJsSOLz6zpYjVkbOSsF/l1IPC54YI4do6gESb7EITvIgxXlJh8mQJYasCk7EqOb2gouMY67Y2mUngSLZ/8Mk+SGGrtSWEnaDcqKCruurmoEizgeUWihSTuscEnEP0oKwIBJVfpKXWVtOyUIbJvE/LMQcD5h6JYWIuHTZck90PgGBpykSuUqFTYAQbI+rzUxyH8khxLSnOxMp1aNEOY0bdtR7m924RhSLkfgonLO1UN/qY7mvGfTw3pTQdp+UHTi5PLQ8M+/826JVCIm3EgQZuf7VGWsS7qZ7b2K2XUmy78s/uTxCi053wCslAjya+xEWi9w0Tz1MqMjNbG43noSrAa+cAdhdyB7d5cTGFiuF8aj9R4hNzw==;5:D0uYFc82OShVnOjVC/Yyko94aoMtzGFzs1CotLKZG5WgEyVKdSEEoAYspOJXymQwrfp6CS2TcFlFLM58NC0eBmHK/3GIrWgsTVvjKqR36q5gjf30oKWVfW//A3ObwUEwlUMN4kkPMe4gDTt/KT66EZYCvf6naALSVNvXnuHZ+8I=;24:mrmDWZia98bcpMW/DAbbSznC0PJ+ZIYKIiETdMwiNo/AVCihUMl7QwLLxVCBJyjy0fAUxBQoJ1w0+nIMBiss7gyAvg4puZkm08omRMqUOvI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:gyLkDjbtscSRA89NE9A3r3i2AgrHH4g8lxk6BABNIw9Ynaw5yWuxXdy9tOuwszTSB+3Enop/6eU5oMXqRQ6p4ymgWF3MiLXw4w5OHY9o3t0KMvmbE4fbKMxxG9ndC84r3Ucnlp1q6mokq7xH1lk9ah5tseuZoLfdrjutlBhQEAvcAhTTVFzWHvjboW1XVmwemrHqIp3yrcDqH8yUoB7QYnkv2H9tF0UlgA/Uti4/7wcFkVJ+gwbVKDNkZyJTb6qC
X-MS-Office365-Filtering-Correlation-Id: 65aaf89e-cc2e-44a1-b530-08d5a6128d34
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:28:13.9738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aaf89e-cc2e-44a1-b530-08d5a6128d34
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
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
