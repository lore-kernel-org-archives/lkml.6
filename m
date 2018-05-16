Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeEPKQ5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:57 -0400
Received: from mail-he1eur01on0129.outbound.protection.outlook.com ([104.47.0.129]:27708
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753487AbeEPKQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 24/26] drm/bridge: remove the .of_node member
Date: Wed, 16 May 2018 12:15:08 +0200
Message-Id: <20180516101510.13215-25-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:VcdNmutE2eeAmryV/LIAbvPJdemRUdbLvgirXN5vjVDnbm2e7Jx88ykZk4uuk7iszV2VAcEhfXv/TQ2hbsrK5RGBfWQ8MFxBYnypGO9JmDrMxorzp/wyR76hLeAfXofjbNAtaVNyG5cSzFZlakJVAKOaeOkYIgOndCCajUdMeLDc/ZevJF8lzXc+QedxcIs2dakLhxALPo0M3uvbsEoXdUuKOYj4FnIZi1XbBe+Xp8YUD6tg9BlO8i8b2CWhqnX+;25:qyxOmyB1Whu0MJTx6T0NmT8AhwZYhvf2RlSU4Af1CseYhqbvMu5dcPGl2SWQjIw3fGzVFaiP4JPEZ56z0nhgFlPbvZPn0RCxBnAW6tPnFPBeRPi6tfkRf2CX0wMaX05hAIJPQk68jlGkJd9C93YupVnAXsma+1Efoz6Q1+Ed5ilGtZK1LAGbsz+tDHscAEK96MF5F3rgFLVzVsBIkOqSwRlrh0kNjH//4LNZHV1kRhahIRV73/QfNfiDpSe6dsXhiHjZ21a4q2lzTrKsIqPQ67pIfGdoZJi4915e/S27WEXJ1dzpBlJXMvbbG22Zyo10mJvUbkIUO9NHGGn6u7dwRA==;31:APRDLnABHdDsV7b38lBJTvBgdwkZVZJmL6yvMOOHmXQTirf7klIXfb+WrtlhJgIVCKoyTvB/KykUncN6iEdY6oZaCDM01OUB13NS2xYdA9CHY0akUytHIYom1DHnUerjHlnpODAeLJqtEVmnTC6ozP5vxpVAr2YCr/j0WCqdJ8O3Zf/+hZ1u0Fa1tfgXg4mFFYpCIDOi6FzHYONFAAfBaWuScgpaTmp4b0DNb4GffS8=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772133FFB9312C4EC493D5BBC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:DFK+beAQ+3KBvSF6L88mKyORrMQ8ypvjJ5k6zfteEVU0k0MpXsrhfbPGs0azg8f87bVNlTXFEk+Kzyos3vw7OpyamQVnyNbZzJN/19uLccNOskAELXfycZrR+2Bu68InAD45NJrfAJAHU10I1sZ+ZMf3MTGQc3dIGmdclLwWUkq1UanovouoffT/4VDVtWiCtDmOvdCANJHX/1tybGWE/E6C5wemIHO9RcFvTjvJx7i1B6Y//UjaQ0/KBowDhdRU8XWDyGjSBat9siJIxueRIg==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(7416002)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(7406005)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(39060400002)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:C7N+sk0MrUcf5ZjeXRGPQWXxHm9Y/AQAIPv0cVz?=
 =?us-ascii?Q?Hy1vW5BvgYzk1ClN165q4WcU9EwHQ3cBnKi3S3PsA4uMlkoGFbHGizaTbbQS?=
 =?us-ascii?Q?Uwz6TplN2ih7417iqck6JpINNO2YQXRBSa8jMWEhyVhDIhjIKlXQ1EqHjNRs?=
 =?us-ascii?Q?+b+Ddyn21WtxHgBc9nZae4Z/zceZY0R2X5Y3c64dBX51++1HRvnpWbpnfPlg?=
 =?us-ascii?Q?660ueL1NbMrBT0JSZvhSXDff3Phj4NZ4xwh4pYOToFVTagIp3+a4GD/JhKz7?=
 =?us-ascii?Q?+LPY9N7soVwod/kC+bXF0tSClidqtsF9gvGyQXrAkIcR/ZuUlqtUvwUV3O2F?=
 =?us-ascii?Q?2x/kaGlPjuvES7xl2FMb6qkl4wExdEyo88P7HZIVZ8gzV80io4MFUwW1gqtS?=
 =?us-ascii?Q?7o8p3t1kdPxApcRkU1ycHMtYsNaCfDq2waNkUOXxgT5eLcDEVgNDP3O0HvjB?=
 =?us-ascii?Q?iDqhXIu1eHx2QwiqgN3fvejibA63LWHoLrbBMKAZl7gnOKnvSUVlBf94vIQE?=
 =?us-ascii?Q?af+Ll0lM8ccNZsQ05bNGflwUY8Sq2YzHb9aW8ZPWX15Jwip83gUEJclR6rl+?=
 =?us-ascii?Q?LQL7loByG3lgRE8Um/xq//IweAo6OQtk9GWD5bNf7q9QgXCUWsky5U7QIcjS?=
 =?us-ascii?Q?hO6OYfmgB83ZKheNpYUihxnAYbcWtWirovcQ2CtnZXEhxPk+/ClHi2szPaOq?=
 =?us-ascii?Q?wOKZYbPX9ig5KjKzIaR/Bx03I4hMsKg4U1H+nVvT0ZqDFqHVK7yRERZ4B0vo?=
 =?us-ascii?Q?pu+BJLyvp4doxEBLmLC95MeTpTSHflxTplJQPRtIogcgZM9TAnJK+E6oSh6j?=
 =?us-ascii?Q?GsH/XXmtaOXw/QnG3UJli9zQq4BPhGpRB4xIfjS4Uq4hXwnLQTnxOnNKVS6b?=
 =?us-ascii?Q?y1mSY3/l5QRKPpx0/f00Jc4gd9Xp37DIz63NmjPqjQMfgGZ2JUVZPPMkoGtn?=
 =?us-ascii?Q?6ZotOWicTsKcifBg5bwPMd0jda4wMVEf5AcszOK9ZDkcKKdP0CC9OWJYQ6iR?=
 =?us-ascii?Q?lpUbhrJ5N028Nurs3zTxPqqo9OEfTukD7bEfvDNU3Jv/+ShX2dI7C2Q93bUf?=
 =?us-ascii?Q?90KD61h2WhReU+fzWdkfde0tpYuA7xcapdhU0eDaj78CBk0MxexbrbIwBodr?=
 =?us-ascii?Q?apv2rzKcwRrbB8cXol9yniixFDT8C7GOXqVhZtGtrQ0TpDNezM5sa9zwf7LQ?=
 =?us-ascii?Q?0KVZ5TFLYv2+04h8U6FT55nNxyUykZcUDeKoL3D1FjXE2tJ5/0RYJjuRbRMD?=
 =?us-ascii?Q?9wcyRxrSdbOgYKxtmGt7Q+mB5H3VQoR6k883sfa1u3qSnBXdnnQKw1NehWcp?=
 =?us-ascii?Q?0NBHHrQ9+EZB/kb0vMHjmzXjo0TXOjl+4q3aDBh4JqycIY10lqTJLUN1JIln?=
 =?us-ascii?Q?tqWTAk74UAHaszvc0viixjJFUpWRituyYpL8/FUcS2v/bhp4yqJSAnuosxU3?=
 =?us-ascii?Q?hc4ZXIW5uGA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 7Uoo0fghOBOp7w18HR6trFTXhZlcIHlg52f5ukGJiEEiptQndUyJpfaRdtvE4Y3nByjPl/oeup04Y0WYIN0y4GVLuIRGxhQ8oLeua+Lz8eZwlYoM9JPPW8cb4GRGu8+Un7aOJJQTuOowWWL9Mv+/wng8ovpIM/PE5sG2OIGF7ZDKkNNLVjt91rqlS0aAfchb
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:ErZwIOQle6x6hMdZ8vFz++Nnks7R5iYnxHtSDmLUlts/dv5vez4EdQqKCDKxS9KJqcxzLJAYSp5S8NMh2muNuzqzhXwhwSP9m4iVAWzct61QAPEOucQZNynsjl1Rc7ClceN39P2gsO2BxkBQU/Z4cCHXjbMAfTAtbHRYlWC2zXLsHtEURmE5QrhGn3UT24wXp9dtmb9OzjGK9vaoPwnKJjPoz5RFTcaiSq53a5DjCRXHpvYIpX2nAGigu5ycAc/H4bm7S18Hm0LQL9ZTEYmuMz7jxXXPt1/XONp2SkSEK3IetDcqwMV6Ym+AuU4RnLZCT63b+nx6z1XLr+nAyTZzSXMqNQk1b6DlRO+8dPA5PDAyKzZVZf3bCDzqwaRWcwahTRUjL0Py519W23Lzej/IjPZP4N0Ax1gV8WCaH7EsPF0LgwNbFUqEQBlP50LV6Tl4KPTJaXsoN0ZFvdbesR6WXw==;5:Kah6EaHffD7t2++CV138/ICRynBbJ3NuT9PS408XeF5lZlSMPI6kUHilm6rqKNsPJ3lNk3aL0guYHbDfaDsxFxD+NANBHXGXBoxT7lUAbfdJ12jRyXdDPtpeVdWVvw7yQPxeZRUjWweapgOTsmY7Kf4J95u8jshgAv8pqgM7W4s=;24:TKGbnfAcPTlrTuihePv2c1DZj6PfTsW/oQz2iXiSmqHxsbTw44PNhaUwNE2C7sqOZIV7zQES6EGFWok7UReXGm7SGlqL9PsM5HaZ/BS0S0M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:5k6Zcxf5/9mRtqbjHwrO6OTsxfh/qV5aIc1Vqt3V6gIs3O2bbIT+HsZosR5rncxsI5TfwqEST1UZmyHA2GRNTPQYmiaBTIFPI9UaZPoNzNY0Vmm2Nf3YnA7O0BQzWsaa095ixE9I5ccbfdKWSw1ckv1ffKQ5B91zJ2cvJYr7QItppkVm322aal1FMHUrGX7ASPvUlOnbA1ruFKdspdWSj/t7EOGLg6ghj+ws3zxoW+lfotPzKWGb1jiXnKxAp9gn
X-MS-Office365-Filtering-Correlation-Id: 283b49f3-d3be-4419-69da-08d5bb1620e1
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:43.7384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283b49f3-d3be-4419-69da-08d5bb1620e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unused.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c             | 3 +--
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
 include/drm/drm_bridge.h                 | 4 ----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 3872f5379998..df084db33494 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -365,8 +365,7 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list) {
-		if ((bridge->odev && bridge->odev->of_node == np) ||
-		    bridge->of_node == np) {
+		if (bridge->odev->of_node == np) {
 			mutex_unlock(&bridge_lock);
 			return bridge;
 		}
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 557e0079c98d..e77d4c909582 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -377,8 +377,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	}
 	if (lvds->panel)
 		remote = lvds->panel->dev->of_node;
-	else if (lvds->bridge->of_node)
-		remote = lvds->bridge->of_node;
 	else
 		remote = lvds->bridge->odev->of_node;
 	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 7c17977c3537..b656e505d11e 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -258,7 +258,6 @@ struct drm_bridge_timings {
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
- * @of_node: device node pointer to the bridge
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
@@ -270,9 +269,6 @@ struct drm_bridge {
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
-#ifdef CONFIG_OF
-	struct device_node *of_node;
-#endif
 	struct list_head list;
 	const struct drm_bridge_timings *timings;
 
-- 
2.11.0
