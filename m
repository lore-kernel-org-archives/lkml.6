Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeDYDfm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:35:42 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:8368
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751336AbeDYDfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:35:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] ARM: dts: imx6sx-sabreauto: add wdog external reset support
Date: Wed, 25 Apr 2018 11:30:33 +0800
Message-Id: <1524627033-535-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524627033-535-1-git-send-email-Anson.Huang@nxp.com>
References: <1524627033-535-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYAPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::13) To DB5PR04MB1317.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1317;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;3:seSW9Zz4yHGVLhl48t7ctSlnJ7OFt568xof4Dp20ejX082KaBvHvTg/gasUtdscm5psBDqeQ95xENd9rE4bY/+w7Cx04p8an0q6SGctht8JImLHfgSGf7SGeGB+00alnhYJZLv9ZuxemhwWJ7ySMW00osCv8dbCsoQ0ImJN38zaGIhLOzos31cruQpVF0aOQ6WE/C5kxfn2nznPo+zUYK4h+pwjRinpBVeShDxQaeTZ/szaTe6Brb99Kp129OTMW;25:GhxZ+6xaDF0op3Se5F1pWu2+iyKfD4NsmhuQ3jXgwnWTlO3YupnR7TD5GakT9n9VpjnZRGeCCAVcQuWP0eTYGBOsBKYoxsAaVUHo6fPzZeJ+orByO6Bi1W4Ha7OrSZaxnIFK7uKzK+xmmLq6AlLKhuSmUJVcbnfd8/ZJJtG4ePg9Q59JgQJz9P/8p8d8n4pSaApWzQMgNvGjhECObNQsOVL7yN9v121UshMmoZqH376EUvQNS6YwgO56VVY9gCIg/WkKnNytUzQJHpDq6Yerr/jY9wQOELHNO+vBfChqSwRY4kep+WZao8RokOshEFpHoc4ObTvr/YuwMZ0obW0xxA==;31:XEZG3ySc6vP7gft+3qEV7KsJZF6PJCXvlvB+nIAZo7UENRA4eHexFFSkTwUFOANJ96TSHQRIpN0fivnMjMUHwj8SrRQL4M3+z6Sqt0JIDgBbZY7ZTaHEqSVhJkd2KttEIMJfoBqjl36SfN5wNqwe9p672K69zZ1DM67oW7Kd4iIbqdwyr8heMOkjIJd1jIIaB91//6ZNMDV1AdmTFBAFNmTX+yJ1eh235ZpxyQjHcEU=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1317:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;20:4xcgtEDr3UIzdpKlcf3SaFQ3ErTTYw3Bt1abvZjcVF/6Z/NXY/co+EVfrrCENsI5uroAJ+4scmRxR2j5aiT7KcYKMvK6NpfzJZ6KQLrRLnGb7Q4xL35q2qK4AwGMD3G5qyrw7C8hW28JSnk2pG0H14LVvcf6aUOj4VY8yLA/11v6aYbtlyGPhX32XJEL34Y04oaFapTD+Pmf4WB6LPTbxtKrGokkyKRpl0BRhwQ3jOW4vF0AB8FhobTwHpqCVmy1FhfaVw1ikEjgRisghYczdWf6tZt1YREiMxmz+pZyOvl6BgtV85/WBbSXjb/Y0HSdX3G3xqqZmw7hE3hVJg8LeXmvKrbbyH6j4DDk8OiBK1K1Eulur9iP2kt4v0GivwEhzq61lm7B7hdPvb6eFQyapN5i63pGO4+5MNRliJJmTJTVSBR3Ez+WMCE0u0KpGhMrXz14tjxZgSLRZQH5WfnDdBNDXoSm81vZhPzstqIT/zY4+s09k4LMq6XUOrrI/3Wd;4:U1zbtHZYhKmZ+sGZZ6t9OaP35JYHx+HIdAwxoVIYjAOzKxqtgLU497Tr59CHCMDC1Zru3mgJpWhiBTeEspSD8+pfcoC8rTeBg+H2MF8RVluv7eBpJam9jBoz2CAWN+NHKzxIagNBoSbJwM5IjiUD1Gc3cRItEke5BS94xAZvatYMoe044eln/v2Hy7/voWUQw+3tCQNE8PfTdwODfhFeZs8rlXfaJLNYG/NiC1dGKglR8o+brFHS/jQjSou1WCm1EGrM3rxw7CfCdj/ZngTYZz8AasjeO54jRPovvpd2IBkvk6lZZFFK/BRNFh6GFJPy
X-Microsoft-Antispam-PRVS: <DB5PR04MB1317C55AF35E4E35608E0E81F58F0@DB5PR04MB1317.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR04MB1317;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1317;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(39380400002)(396003)(199004)(189003)(36756003)(478600001)(97736004)(6506007)(386003)(4326008)(25786009)(6666003)(53936002)(6486002)(6512007)(86362001)(8936002)(105586002)(66066001)(106356001)(47776003)(68736007)(48376002)(81156014)(81166006)(6116002)(50466002)(5660300001)(2906002)(8676002)(11346002)(2616005)(446003)(50226002)(3846002)(305945005)(7736002)(476003)(956004)(16526019)(51416003)(76176011)(52116002)(316002)(486006)(16586007)(26005)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1317;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1317;23:6y560mkhw+QaWWT9Khq+KFbjTsIf4mNsIEesFE33h?=
 =?us-ascii?Q?FNigbKPVqL4YAfRvksDZdR+c9A8X1d9v6AfmREDZ+SQlsAOUBL+/ZCfGiOoM?=
 =?us-ascii?Q?fmooOeKyMrRK0VW70wiC6wtcJJNKmEzPoIvhElLAro819cG7uatcpybr9dhc?=
 =?us-ascii?Q?OoVp7wkF+ggeeAHqSh0FWAVfwH+CC8ZfIcFcJb3+hH1eU6XrHoXc3SBWqzqH?=
 =?us-ascii?Q?qeXgoM1Tp9w6OjwSaEw1l1tnu42IDOXnVOtat2DoybMD6nPEPc8ver5V+TX2?=
 =?us-ascii?Q?2EPxS5F1YlruZBaNtc4IqVhLFXIzjPF8totkSom0Tr/leQiVGBZn5FYXgAbf?=
 =?us-ascii?Q?mZ9OEvS1599tBrM2oP8N7ZLNXRFTp66FeTw36COvIjeNVJ8Z41QsuCiZgJLy?=
 =?us-ascii?Q?Ax/nL2SSvLqSERyNLAL4FXxAtcnJDDM+CPJDuj0MWTi/MPtl9RmJS6CKC8kN?=
 =?us-ascii?Q?r9rk7y1LdZtGp1myP/hthMhiKq2GZhMK1Wcn+QoGJewMRuALu/RglYFhH4Z7?=
 =?us-ascii?Q?7+k3nJRGyg/Jz52n4CUtoIL/6wCyaPZtPk+PgXTUB4mbTh/dvnmTJ1dCj1po?=
 =?us-ascii?Q?P7mWkcV7sETLn40kDj5R3L9eSB/XIp/7FVAggN1uZvyJKrEy5rJ+lFAbo6df?=
 =?us-ascii?Q?bxNj4KYrsn4H1H9addxuJMnuVuGuD0+JdhaspjurxgSer6O4wFGvI3ZTdzDI?=
 =?us-ascii?Q?r138GtjNo4UBK80pf7t3KmiKfIwauy5mrCVAWUvWGH0KOLWdZqKClbF52/Pm?=
 =?us-ascii?Q?sOgszMzN3m8PML2r8+C4pgNGJnXciEYhaMNgcgV/SuGEsBuAOuXhIfNmhqyN?=
 =?us-ascii?Q?iG5SMtuhdx6FJqx7pfBnfggXTqq/R+anFF14xzOuPUEH77VPn7EahrJ0R5Wv?=
 =?us-ascii?Q?Si+mj3vl6XEgGPfWnAxuKepepvJCIYsWgxul0gwKnLKc4Ot80BZa8cXHzMGa?=
 =?us-ascii?Q?u2OaDn+QOp1R6TBhqokOnXMsw+sFffCqSHRIuxyCwrG6yVWQwSMb0egrGK+k?=
 =?us-ascii?Q?B3NQy8g15wgYH3LRhkHMZEuIJIhX8vWZUQ/hvrDg0/IgjG5y7yR+0MuhVGaI?=
 =?us-ascii?Q?k1LK2wI6FfMZMzn5V5RsPFAdAHGZHmKeEyZ96lNDNJ0bXww+h3khnJuu1d3Z?=
 =?us-ascii?Q?whRMvu23drOOPNZQ0+9gagmyVMBRmlpZMVFQVPx8zlXicVt51wtsveLYMI4g?=
 =?us-ascii?Q?8+cxCqj/lt4UT8=3D?=
X-Microsoft-Antispam-Message-Info: zmYQ0NXiUhFoAVSLJ8ryOZ2GHhYthGq9fkAiEjnrQvX04FcIcaXQHb4qNZLFTMEklSVdh62Zv+DC2I5oXnVxexobm6hhGz+C24zcfllXACy67VyFdmwm2PLZuI3c47W3JOakUpCIYk/iYVXV+nIIP0dHfM3+Fts39y7nzO6zKwUi45cnMVCB152Omg02G76S
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;6:7I1ia1WhVKwsBJdIJ3yivl5LWWASuXJvM5b7BKgZeeZQLWb7G1wp/8HieXCH4g96i7mKYergYuP83zxKrEV2NMRsEQpdG84PCGxFdLMzlM7xfFCR8Fm/4cJW/ZMz2D7jNVJbRjKCrXECyV+er/W1cqjqooGCnpy0esKqZq54IqeLdg6o6+slEug3xIc70O8uepkXMEphrnrhkh4Ui0qJd6AGyAKFppoMPYBTIi7TQKEXeWSPhx+/G/AfmkW3i04rqbT8LmTGo6h8gunJ5hZDU9OYLPQ0fYKYfHN9fXfQE3XzKWV2E6TVIWqBKAFwxdeq7Mq1O04E5cK9c0dJ3FU+masY1qxwCT5a2HqkVA+O0Ci429R04uu4/F69vU8xQH5j2nl/BBFhAixMaBVBx5ZM5Rn86Uk8PSKt2tJq7hgyqGxnAhe6nInPtxKX0FpKbkzD5SrqV1Co8uO01JBPIF6MVA==;5:/mHh85gsyWa750ehy25jjwrW+VPnHl/E+XDBBQApDQAgrok02xi+e69oyjydtkK8h/uHOp3675LPVFdj/00c7R/MioT4O3zLinU7q7cJDUab0WQ8P0zIQ2/2i537NHPPb3u0KQDhxQiZEBu+iPHlo81EewZbexPD69B25hPZ+Z4=;24:GR5ELtQ+nJLThhBga3pGnHW1gj5PMJ9R5CgxhXMv+T4OGXqx/i6YwvGceH1gfOC5eox4FOQNO/Q4tGY5xXMsE8IOytnIEjIFzGFWzQiev6o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;7:ClHmF52E4Q1Nzdl5JSwJ7Tw81eAEor/aNp6/9KVT1HzZK8WtqlvG7rbUpSowN4baCMOW21q6PS38gBORi+/mK6A/4zSh8MCKEV2Xo2VvAdMkn3+F3MsDmIblHctMioBYyDns3yR56wlcYmWxH3qgoapVQft1eWYBulj1W9eEnFwhB/FA143DWYijE/tSr54PwYlvKl/cgwC4IXiY4r0e5Pge8EdCKtKetrMmyDeQO8rd+mt3cGnjSdNWwe9raeag
X-MS-Office365-Filtering-Correlation-Id: fd101337-22a2-4e54-5e91-08d5aa5d9093
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 03:35:13.1267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd101337-22a2-4e54-5e91-08d5aa5d9093
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1317
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
MUXed as WDOG output to reset PMIC, add this function
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V2.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 812f40b..abe9054 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -161,6 +161,12 @@
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6SX_PAD_GPIO1_IO13__WDOG1_WDOG_ANY 0x30b0
+			>;
+		};
 	};
 };
 
@@ -300,3 +306,9 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
-- 
2.7.4
