Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B71C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3946208AD
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="bOEjlfF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3946208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeG0NhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:37:20 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:51952
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729431AbeG0NhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qcr8jiUvRQ6kwlnru+jhoQv5XkGCtp5oPAKBiTQ2L0=;
 b=bOEjlfF5H6/Ro49IKd58QcHiCf/ugqbzO3tPwPmULjujNhGu5a3OqLKfR1NK2Uv8NsFwYpayDdV1oK/Tf92JFI4zmctFPazuxYyR4hMkpc4oJ/VOvovZGKPwGZ6QhAEYdEB4wU/lq6wemgCPfGeZfb5AsdEjyFgSnq1fCgGptWU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 VI1PR04MB4670.eurprd04.prod.outlook.com (2603:10a6:803:70::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 27 Jul 2018 12:15:36 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] dt-bindings: Add Y Soft Corporation vendor prefix
Date:   Fri, 27 Jul 2018 14:15:15 +0200
Message-Id: <1532693715-5234-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: DB6P18901CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::30) To VI1PR04MB4670.eurprd04.prod.outlook.com
 (2603:10a6:803:70::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02d5f349-01c3-483b-20cf-08d5f3baa933
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4670;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4670;3:WBou8wmeXzOyi6ps23YJLDEoQDStfaP/57TAmDSACymHaJto6xzzQkQ6BhBXwpAV+ubkJNH1nqyubCT3EWZd9C0BxgTH5zulB46Xq7fTsf18Qqr0hMUaOrfcrSG/kXkHF9QVtszdxUnKtIk4viWHtzNppv6ZrO7bf18936RdhqwJHUH2dSiK6RkrQqGwzM41DwLG2dZOs9WK6WCU0ujWR3dCBrUtAlKHNzN+iXSlB31FAxLzzJ5Fv3OljMwjuMBi;25:s2qxywAyYy+LWG/Gd8BBET9S7z4+fOPg6k8bU+Vu/cUWjGhkPaxmIeQtTOmNSoNsZ52R5DFVzzwU6jaEasayoESPSuX0sXtEXqvv4EPeKEWdnRSt4r4/tukUQgMfnVBsg/oJoB1rRKSjKvB/VKoV5y7IakOow7ewUI8Zs+vNSnPY6CUXrZ9B7SCbhvkeLQ3OpHRwc/1CEdM0cvgpuV3qCQD6jSZhg8hKfUCX6Wwa5FS7zYvVa41bUC5SfLYg4DS87jStZczvgPwD2CLSs937I5dXltdpGMrlzY/KQMZIJrXkXc0uxxZq1C/iP0GfltVLZX2XrKtblKhCdR3SADRRiA==;31:ieOoEgIIylu6J3BzHe8Iv4q5cDZiiONm3I12/rUqC4LYVG0VSEGY8224Je/ZgpFBreHEDTGgolNgCjiPC0ZZyRm2ecKq2RKlWbisT1Gp2farpbnpeeEK+C5abWl/jAhGcPKlp0+OebXCF7iuB1lcpMh+CnRJf98Y38Fm8nxexwiRiBqURCO38EfePK4Q+7dskzNLSeYEE+SAYKNNFjc4Ed2dEf7lqlq1DBKLxwj25To=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4670:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4670;20:pR+4wS8kA5Smeo0XuCYbISCn3GeB0SMzlbEIeYtaM/9Qut9OxVF7WpmWGNVxtzkU7LwOO8gYr1E8EX+nO7xw6zrlgIdre78vT1G8Dtq5tJWbrTSU2LNI392HqwPBaiZm++kJGoWUbAhkmFf8ZwSkKUmGKIdCM/o/GKdm6MANczXH1Ps//8PrEIGM/x0+hiaNf88x1xqbM/KS2Il9GkjtVoF5e8e/jg1kxB3Z0RMgcnJWgAbmpLLEJ8N2JMP6OPol;4:SgJTtQ5wAOVmFtwZ65tt5qzVEFZH3XuwFNkhnyjmqFscdsdLZUBgZe7R20rzvr6vfgPHheaXf0+fY41A4GpJyQq6ZpWOoOY3tsXlGXOX3Z3lks35WHYrKQdG8vWU37fQ3uu1K4y5lCPWVSMq4MnQsGc0CYOX0eC9X3wT9uUOLPfSIeg8O/y5y9GI+XZQJT1aoJjawgl95vkkdyCPTKwtylygDNnSAg2GpM3o2XdGlmKREe3J6eKEqKowY+kVDWU17aR+4Yf4Hckc2EyPXA0wwA==
X-Microsoft-Antispam-PRVS: <VI1PR04MB46702738C9D0F6B6EA88FFE49E2A0@VI1PR04MB4670.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4670;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4670;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(396003)(366004)(136003)(189003)(199004)(47776003)(66066001)(2906002)(6512007)(6506007)(316002)(110136005)(386003)(2870700001)(54906003)(476003)(6666003)(2616005)(52116002)(186003)(486006)(956004)(36756003)(26005)(3846002)(106356001)(1857600001)(5660300001)(478600001)(23676004)(105586002)(86362001)(50466002)(50226002)(575784001)(6486002)(8676002)(81156014)(72206003)(8936002)(4326008)(81166006)(107886003)(68736007)(97736004)(25786009)(7736002)(16526019)(305945005)(53936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4670;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NjcwOzIzOmlsQlZGbU5QT0JnZHY0aWd6THUySThWUGUr?=
 =?utf-8?B?MXVuVm9oWXFVWGxXRjU2WSswT0o2THZ6dGpFUDR1eWtJT1hxZkdQK0JDbWxw?=
 =?utf-8?B?SUduVVlVaC9VYkEwNENXb1J1L0QzQXZyMXY3dUc0MnJxOFl4STVLR0M3WWpn?=
 =?utf-8?B?TXdaV2tYSHVMMjFtZDFPMFg3YWRnZkc3Ung5S3Q5VTRWSGV5L01iOWNTNXA4?=
 =?utf-8?B?TmRJcUR6Q2JSTythRGVGUm9QNGlVRjY2MFpZdUQ3b09lSDcyUTcrQ1NDd1VY?=
 =?utf-8?B?cWprRVg2eDJYWFVZckt6OGhDckF6RHpTTDZ0TnUvQXZkZFZyNE4yL3MxeWlt?=
 =?utf-8?B?Rks2QWl0YU1EU1JodTBVUE8rWE95dGpwRHRFeTJLbzd5OGVTelBPVkZuQ0JU?=
 =?utf-8?B?YWp3eS9sUzQ4YW8wMnZraXJvWVBxVDgzbWpBdWlhUmszYTlLWnhDVUFTc0Qr?=
 =?utf-8?B?ZDlweGtyWnhORElHRUQzVUJldmx3SE1BQVArTXJHQTZpTWsvWmtqYzgrYXow?=
 =?utf-8?B?Rmlhc01HQXNLNjlqcllGbnZXZzdQTlRuVW5taFRHSm5Bb3J6SktEaEk1bExZ?=
 =?utf-8?B?eENNVWxGdUdOM1BHMldmSlJJNEpzcFJZNUpKbWtVWEN5Sk1Tb1lPaGw4dThZ?=
 =?utf-8?B?V1RwVzNZb21QSVQrbHZOSytPM0tvUXpPNy9lTVFucjRrMTZyaDl6MGh3YkNu?=
 =?utf-8?B?dEFQb0RKVkF0YmJIY1BvcGw5RFdZRUNLamxZSms3ZmMranNZYkFYZEZqcGNO?=
 =?utf-8?B?aUhXWFkxbU5xbGJYU0JBOGNRWE1YbmFBWVBCVmpvVXFzUHB3RHRwSTlGK3ZT?=
 =?utf-8?B?UmRoQVhFZWtCbG4rQ3BYZG1UNEZyZUp0ZGRNUHBZUWhGeGZGNG4wamc2REFK?=
 =?utf-8?B?M0tsdUpnZFhoVEE1V1BKYWJQNjRYWXJPejBHV1R2WW9ISmhCamdHeE5vZ1gx?=
 =?utf-8?B?YVZQcGNWbEx3dnhrV2diMC9rZWY2TXhOeHJhOFZNSlRUUUswa3l6empsdnVN?=
 =?utf-8?B?MWh2RTR1a1NtR2dIckE1UjhBUWw3R1JzT3FqZkRwVFg1RFdHVzRpalpwUVFC?=
 =?utf-8?B?N2NrYWNFZEN5bEl0cEEwS3R5M1NreUhpRnA0dXdUYUhNVlBmNmhRcXFJNVN6?=
 =?utf-8?B?OHplbEJZRWFDNmpMa21EeGovZkM2bWlibGJSSVBJeHh3S3dFNHprU0xYR0k3?=
 =?utf-8?B?RzV2RkI1RmZqR21HVUxIRTBiZDhCdnNMcU1HZWxXZ1BMUEExY0FsN2tNdmNN?=
 =?utf-8?B?K0MxWTQxTmE5SEpSUW1Pam0rS09uL1EzcnUvTk9rZXI3NHRiMExGTVI4anYv?=
 =?utf-8?B?T3RCSzBKUE9pNEVuOVYxWUhTeUhxSDlRMGNvK0RxL1FkR2RYWi9LUVArb2JT?=
 =?utf-8?B?Zkphd3JIdDROdS9LNm94elNPZUdPWGtUUDdhOEhYTU9vZEREU0VCN3NHeFRC?=
 =?utf-8?B?MVRiNG5YemdrRDh3a09lTWxIMlBsQ3BramZkb1k2eG5IK2lkQ2VOSjM4QkNI?=
 =?utf-8?B?RzFYRlRncWl5WXVKeU9UanFKSWJZTUl2UTdLejg1WGVXMU8rbVN6ZEprRkZm?=
 =?utf-8?B?bFJFamVYcDlHdU5Scy9wQ3MwaytabkJ1RGJHM0VkcWtCWmVoYkk0UnkzdFNS?=
 =?utf-8?Q?eh/bqcXSbZFwq9IhWesq?=
X-Microsoft-Antispam-Message-Info: mtTZyYUgqXJ+I3aCEHxNGdCUXZl8Vgsow935ljtP3rU9MMTEuly8XkhidmUymhpFk3a5BE4h2zoX2hLgcJ1rzS1HOI694O3p/xxcXWjUMPsUG3PMqlxv6gM/D+Bo5oshH+ErCvJvyB2Im4+qVHo9SrhLvQyHq+WpkdiGxpvwrtQiSZ5Wiiqa4ayiFfEZf16O2iIbqJHe7yo6DwllWevlm1uKqijBvEG0lQg1m4i8Xrz0m7qswSq7wnF4XvJol3JGpV2KVx2OA850ExVeD6coN3w9UsbYQVjwbMRRdKLX0nQxupQzfTn27L9TTn80dEIKIQfU3vJv8AAsYrdYbSRjfiC6qB/lA58BKcvkAhydfOg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4670;6:U7wGVkUQ5S+z7PZ5l0Z9XDUI1c516B7opokCMmroN41Pfi3MMYhvKH0iTQNSR5f+Mxo5TFmwQKtRmmY3sii4jNvN7Dm+UNMGdHKrTbn0DNNsCx5L2tL08TealhWjfkjuAT+TMsQKPQQxzFdyie0DAs+eZi7MvI3zeLvBhLgK8Tw2XUE6Qi5JTqT59C8aFUn31MQ6WntX3DK+HQtzU4MgdxxZhtsXHRYajmWM1+tSdOrXNbTVL+Us2dEwlCaKCkdvQQAt+QSgBDw3d/hTVAwFXao4PtOOt+DPww6Zp5mKI0BwaTKQewknV6t6rQ08hxZ8PAY8a6lXQgTIYkQBjxC3zVTCcH2YA4M7fMViBLdzBS084VORX8nRnZi9ZdKJwcwp2xqDGx4NDTVyhwYok50YLF8Q3g3ljgWC7eMoK9PlMK/EoSrBZDvhAK6ZbidlZSLo4EkFfDpZYzPyO0ex3/ShXg==;5:slRpkCF9T1MxdUR8u+73kpKd+K9rWXEhZn3VHx3M/IPwngrR5JNiyUxiU/6dazLdJqnO6DRmQUzXa3buEorqFoEMXmcrgTOAx5B2Nw7vo4txSvdTXtUyLbtvCRrDXxLDq5qBG3z87iJz9M0GX5xoZew1bz/AI5BzRu4LB8465lY=;7:Slor2Nd15zhcPlGniy/77JKn4b909lvAiWDvgLQSpWfoR9jMA58zrUIbUWbI6dXafgHKutsMbFqnOTYF/OMhVtE25mu8gWGXckPDAQCf439KmHlHod+lDY5FGWYKyUdFYZKZBGq101QqRujCBh/aGxHRQAtnPGwtMPewKx3453WdUTPoOG6IMhKWCtNl/p7dSX/5zXZ3eKfr/N7i+ChsBlj5g6scqp7zJTnsuLm3RBUQ/1KrAw6xRjasHnRr/is+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 12:15:36.5236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d5f349-01c3-483b-20cf-08d5f3baa933
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4670
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y Soft is headquartered in the Czech Republic and it is a worldwide
provider of enterprise office solutions for print management.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
I work towards upstreaming support for our custom i.MX6 based SBCs.
Those boards are used in our various products. This vendor prefix will
come handy later when the DTS files are ready for submission.

Thanks, Michal. 

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 500d5dc..f38fe0b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -413,6 +413,7 @@ xes	Extreme Engineering Solutions (X-ES)
 xillybus	Xillybus Ltd.
 xlnx	Xilinx
 xunlong	Shenzhen Xunlong Software CO.,Limited
+ysoft	Y Soft Corporation a.s.
 zarlink	Zarlink Semiconductor
 zeitec	ZEITEC Semiconductor Co., LTD.
 zidoo	Shenzhen Zidoo Technology Co., Ltd.
-- 
2.1.4

