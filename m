Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeCZVZW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:25:22 -0400
Received: from mail-eopbgr40113.outbound.protection.outlook.com ([40.107.4.113]:36320
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752171AbeCZVZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:25:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, Jacopo Mondi <jacopo@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Mon, 26 Mar 2018 23:24:43 +0200
Message-Id: <20180326212447.7380-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::27)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb28b203-2a58-48e3-31ae-08d5936010ed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:AhO01TesuJBWf0pyM+m1XFi7itjIHJGHtyNTYrLk23lfOqLQ8XXW2ueXm8/poEcs8Ng8bEufErIoIkwNtEwrWpSUcQtfK9rxfyxg5ZzP4XDBxSiq8rdlHwGBZswowzOmBX7BM0QrGR2UPU40GIXp4jdAtaFrRCN3pjpTkEa+4D8BXkmwDrxf61YWU8ODBGF0wewYtjfqYVhW7K6dRqOMmXvuESJdXgju2y2Bz1MZQFkrExViRH7BAUdYsUxME9xs;25:1n5oCqdQ4UNaOZbcChKvZoANFdgWS+sr28JCBQ7+2pAM+GRlQS5t+KnAaGQg3rHs3JPcGOzYa+Tmki0zESf+0/7AoWvYY9HKXXpY6kzbisxmgMuxGwnTanD3cvFsrnKmHvP/TxUQSFMzh9vLwPpc7eM/q1t92MA5VvDoslq4Gc5jRWpm6LyRQIX1PTAY1qEOck8a3jgtQjAS1p/PNEC5uI6wWqDDFX7fy/lQT2DV2y3oJAkAJQ7nma72r67zuGvsW/J9tD6mUh0p48JA0J714JhQU9omEAoWjjnClO35cLcvgDoaUrHqt/kb7mqhJF09vegXEedkRZ187VbSJ5JSGg==;31:s+DyrjeD4L8Lkh6NLSvQEaiU0lJ4ssED5ityhNFP2hw2KwFS71D8G/d/bCxdVe1/TQ3Pkqu7Orjchgv/Bbuc4rkQcy4U6B3P9UAn/EoDwyvdvpj0i5jeMUI6E83y117KAeajCTKXvL5De73StfRs/fGn+QKcP1FOOfD72QNBdbx8/yrRUgVLU8MGhR5ZFnwDKVI7rne48EUioIIfDQGOPnM4ufW+KpaKbHb5BXsN0S0=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27693A55FC0A2E7C8991C172BCAD0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:Fsyb7hJhOBUDA6rWUx2Ibqx4CxAn0U9vjrF0YM2Zdc4AtXOy0kBp7ubCB+t8OdcVkg/rwdoYMZwka7aisRYXuEWpOyWKDSi6mywJl2lTUM6wCE1DUiiEnAoh9lmDY6X5Zff/P0EtmGBKIhX3IIl1nApLa3V+WYcElK4UrANr2R8SbWsD/5FO0q4HXf2/mMiBqsqPpTBO2BJExKu8xLeMdPv9DdubdfDXbeF+srYgv3nEU0krecesGbVlj0x9PCFD7sKTUs1puww43KSPjwOT/g==
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39830400003)(366004)(39380400002)(396003)(199004)(189003)(446003)(2351001)(316002)(16526019)(186003)(54906003)(16586007)(11346002)(2361001)(97736004)(105586002)(6486002)(53936002)(956004)(6512007)(2906002)(2616005)(1076002)(68736007)(66066001)(51416003)(76176011)(48376002)(486005)(486005)(52116002)(6666003)(5660300001)(106356001)(86362001)(6916009)(50466002)(47776003)(478600001)(386003)(305945005)(8676002)(25786009)(26005)(74482002)(6506007)(7736002)(6116002)(36756003)(7416002)(4326008)(3846002)(81166006)(59450400001)(81156014)(8936002)(476003)(50226002)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:1mkYp2d54pyJJ25KxoI3afDBWtraDIBGqASbWX8?=
 =?us-ascii?Q?Apm3aTpzZLdUzh1VNicjiijULKwYCgVap9YdoN2VY35ehb2WeWy0Dghf29yb?=
 =?us-ascii?Q?UMXtQZqbnO/IhcCm9tiduA1PjXqqXEyWIhFsqYVVnEgool/uC2nwORXADs0h?=
 =?us-ascii?Q?XIFlRqHKvfyY/dGelkd7yY5fyKsArGo9OsNN+qCgK7xGngSB6vGGc1ZMJu+8?=
 =?us-ascii?Q?yfygAElXtC9d9ayB4J5/IRNAWsuoJhJYCaqcZpVqL/zD5Q00Qtpr4pWiJCrE?=
 =?us-ascii?Q?kwbsecWBtCS2CVCn0elJ1O04hheIZ6pMn3tY1LauXsIDH1a4zuEfEE0ItMe4?=
 =?us-ascii?Q?dyJEiIyKRMQzTsaTe02RwWNIRoNF4apzqzRIr+QbvynN4uaamdGX02T+NrhW?=
 =?us-ascii?Q?dB/fNgrEBkYfKgx4CuDnFj9elXrS9jwDVAUvTVhPvpe2vQLXl0v5WSxpL0Xe?=
 =?us-ascii?Q?6NmmQNgvXElZtIMkWbZ7LbFwU3GxqigU/vtjTKlDXfE5uziDsnjUCs7C/hST?=
 =?us-ascii?Q?PIjbI0hrU+Ihkm38HTmO5vCDkaEOkwQPFGZch07AjMEBdmOQjIxpPrTAZ7KE?=
 =?us-ascii?Q?F82uuR1LDQMrXiKqsGHKff9SJjX92HACeNwwZjpIewPTVdyJoah0aLkiIi3u?=
 =?us-ascii?Q?6l/w37mjLij59ZgHIPN9dPrC4CwQj1cPEOV6Z6KLvbbL58HmaBg8Q+0GMRRp?=
 =?us-ascii?Q?7UAPwW2wGdamfUqUpdjB+eFfNGkimu5Wx8Q84TUgNEZvwfxPScmO3pq+N8rQ?=
 =?us-ascii?Q?iWoYopB1Y0yDlsQrBwwaHregIVzOBdq0mxGBUf5ETU+61xOyBLp6CbBrEUnh?=
 =?us-ascii?Q?StrsyfMKqvT5dnBSY3v31pmpCHyEBaJfazLkVfFtEWX847ZWCnK2U+spRDhC?=
 =?us-ascii?Q?68TtZTpAbb9DgOk9OROTYRQiGZd9ZEiO3/ZAZtwD5nvpRSnc1cU+IIzNPW0q?=
 =?us-ascii?Q?582mg+8VYEhELfhqpTRBbBZKtRHmMqmWy/PzbS+f0kDEmulq4L27QszTGg2I?=
 =?us-ascii?Q?UdBVFdi9REAFtZFRIsCRQDcfqx270su5g79jzXBdG5aG08EXJzdveHjPkf2F?=
 =?us-ascii?Q?GbOWbTrnIFDPxHHglZ+DZvG467sm1pJn6zYuHS9SHttfXibHZHbt+upkC7CD?=
 =?us-ascii?Q?uGQrxNh3888nIbwBwpJFOcCQkk2FuAtqZobWvF7oKTMQoomkeUCvA3zsgg11?=
 =?us-ascii?Q?jWuMpnQbzYq02NmBmwM/WOdJrHLnIuv1bcxwhNqehG9NhpbuYL8z35yzNf5k?=
 =?us-ascii?Q?7X2WA1zh5DVTPz6iL4H4dhPzVo7V7brjotX4qb061qxCWTskFC5FFu1l2S0K?=
 =?us-ascii?Q?jiqzuL8LIKElfe4MFH/jON0kPYL3/ziSDavbrYhoR5n9DSF9V/a6o6mYKyPK?=
 =?us-ascii?Q?lpanwpOWuEl8ktGoxB3N97gu787I=3D?=
X-Microsoft-Antispam-Message-Info: 2FtABdgY0RLlYY7BKXd9knrvn8CYx1MQxnWX5FbmcvA0bwgoBWdW8xJb+/hxxJN0ArX3ch2bvS9iC1ssdrao6AJugu1EqCgiGWTmrpgfFb4GE3JD0FCIBsqNmDsV/yLMj5qLhCXpwVaKFSqBU9w25W1uvXaY7DoTwJi0YrInV607WlHKOPnEMUYzm0HeZr9G
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:M+qljus9m6QbyrKarDoSPZEvvK5hEF+kCt5hLzn2Lj1makfNmpl84LznTPj+gcf1aILzF6Sp+QqagjHk6O88jxJE2sOzoHCf10M8ESor9YHJ+KrhdYZT5Cwua+RbaD7MecpMW+d9SY/mMgQ9ebvK4djgUzDBHUOmHsoRyxauqGpEiEq9F+I6LYH63oJCh8fiyAbwU9+VAHco0vyszeErMWJEnl5IB0y/5/HLqc42lgiSlzyohIO1tj0JfLCO71osZWnvBgNC/WCbRsfG+HZq6dsNJIpEUpFkTYKFcDCdzg/OLcTqBN3mwVUeU/TV4CQIpfNneexS/Z0ukMbQsGCzj5N7vfF1jaxugfHO4NiuEPkWbea2qhG1mlCtuqOCy5ZizxJH5ObJi9GVW8KtsUBa9CvDyyxBZ5MWMYPkp5SSc1tXJpJB6nfmYp/J2QAi/LOh3WRa6E29wzguMU4MAB4QiA==;5:j4royHAhIBhKKMBgftO+jal7Z00FqK0+1uI/tqtCZr5wsPI3ENMpS8NR9vgxXlU9uYFdYXpykM3qKYncH57nVFAZKOvlEzRdiZ3EGqSCXlPcge8F1iztaU8C5fiPEKlkIEFu/+fLXUujY+Fm1aalB9RxiKZQ4TotfE4KxsRNwJE=;24:n/fhvwlAT0Yt/yfjVo0RO2ZIgE1QDPPPYtPcKDZMJ0NC6S6+bqSdVz7fJuozVy8LJ+hYqaj6pe3CMe279uy6if1tI0J3b2ZYxINXMseN6w0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:KRZ75L8aAHT2gAYeaG1H/dec1olR2TawbQ+9AMXTFs2qyT2xzUNrRuh+HrJpd/61PS/ktOFFqIjUS2v6iGUsNAnNXCgn1XojoseeqLUJoHT9ilHSqRuMhD3fFF+HQ7SYArGG9hRYr6ATNKD8+CtqoIl0Vq51MmjtTP6iBlrc7HcW9g2LbA8Gh++7gu79/qG+k3oT3yZmlzSAZrFweCLtsuvEciUu0deocjmqwK/euhktmwZDQxyKLyuSSdpaVd1C
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 21:25:14.2208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb28b203-2a58-48e3-31ae-08d5936010ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start list of actual chips compatible with "lvds-encoder".

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
