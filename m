Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21961C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D94A24DFE
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gcb/HNNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D94A24DFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeFXHRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:17:04 -0400
Received: from mail-db5eur01on0046.outbound.protection.outlook.com ([104.47.2.46]:40837
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750737AbeFXHRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/VviLqSRcuplUOhDMSasZG5YYXtWLl1WN7B3sEfoBo=;
 b=Gcb/HNNpfFQz6x+MIuOYFAFuwlSr6TmozhJPY/8BSZnHsElPfebi+y03IK85Z8jMXv0+6InEVHHiWb0//igJ4n8rp48tDhVTRE4QUABe+1B9fZyrwZLZDkqn0/5D6E63HeZ7giaQooCe9DTMy4wXA/rTqNPrX9Z4aWwn1Rh0GK0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
Received: from lti.ap.freescale.net (14.142.187.166) by
 VI1PR04MB4253.eurprd04.prod.outlook.com (2603:10a6:803:3e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Sun, 24 Jun 2018 07:16:56 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH net-next] strparser: Corrected typo in documentation.
Date:   Sun, 24 Jun 2018 18:07:21 +0530
Message-Id: <20180624123721.24287-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BMXPR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::20) To VI1PR04MB4253.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d22f12-eca5-4cb5-6ce9-08d5d9a278db
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4253;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4253;3:qV8+0li7hWklBuqslcHavFqr3Bz58FNgGMuVeqV/BbimXFqcpEKeV/tj7HVL3yPnoZ6rDbHHmcY/aMFKC6rL1bGvBO6D+1Y2GeUCjKjL2faooN5zFp8wqrZRGDWE9z3Yyw+3+GH0Vi/JfEZ7q+TAwfTdUvONQ0gpAplUChUXXaWNgYWcY7ADliZs+Wox4CBW11DKPOhKRscdXAIo3GDwwOMofdhFq/TPQ6c95P3FCW1wWL/OHA1/Zj4QudrSy4Se;25:59ppDM5WkISDZmGvE+imEmzGW3XPuQPSvOqPOod0zOtbMihmokWVtorYC6+GhEXBu51NY2p60tp2/qb8YXZJpdxmaUt0jdaGBUK852rRA59EbvjwXsGbmw+MfN26vIT5V0ZqCox9TBFUbY1yH3x1bmKb7uxdCA1U8Ov0WvJS+oYeO9OemyDrelWVImkkU9msIDzg0SYGoWaeYnUmE/V4itEx6A6mEHHm6Lh+zGcdUQcXSuxgz5sB0VJZH2itgJCdLA0QLg36LpbmHyhF3olPYBOtqwNtmlpa4QyJ/htCe0u7W9+Hrw9j+BwmnRcdUKwPuPF92nmOLW2CwwilQk37ww==;31:Jq3IaYYw0j9P5rYBcxeEQNqKyW7WHiA/XREpAbmJmdIUZbMhIq/d2GtlxEHAjAlrglGKS6JxDQzfDcCWbPFAb0GzPyKu0TsaQL2cUWx6W3xCdRJMwdeBntHFU+iVA1KO0TYQJ1nzmgS/5YdhW+scDNAL0nwZiSiaqeIjKHMBgiY3rMi6Wv1VIg36yyw39KVDOh6YomXWE5JzF1aR5OLFAie5o1xUej5WPHwuiVx636A=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4253:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4253;20:6kWSRZBDN+/8LQgD637BTqF3oQj0WoIs/VE/Wbdsh9q0KdIOpGmiTX6bCB8uGOjiKNclhQ7GS9LjkDu26S4oddovn4f09gp02+bWyeDfAXSFp0sxhdZUCy2OIgwL/+1B7ynVyo9xYiNjmfKTxwHcEGYpIUElu801s75m18iXpSUyt2uDLZVI9NuGO0dUx+3I6P+UE/mE8xkfUPzx56v9wQxiwK/2PFhkO+opow/v7QALXj+xNYUJHdb7ZTD9brpHo/ZddYpYpRVb8OBqYXtb6KH55d97toZCN2xM7HWwaB7MMrpY8So6mKzRShImw3kJ6RgkorrfjpPs3B+7ZlQIC5oYeHxN3YfrvNRL3pSCB8I2cQM6dkfbl+nJCtXyyvwP3YOw66FOzjJzgZckCU/c1z8Vcstc9ZZYsWtvVsoic1NZBxRieUsziN5LDCgs9hcQyhZ7Or30Cxh7BJs2DVplOsdQxNrRsrZeR7hZbXWMz74QBzkIXdAf12/hGl58URrF;4:8FA/a08Ct0mu+AJr5j9wqJrbaaVHxIdUvfVs+fPq28FKrqe8SFUVwN5bK+VgDZ1QSsbSewSR24nPMiiJ1k7kaBbne2eonynkoxsbLzcwROo2otOqjqzJmHMshhmqTjMnoZallABLeKHiFVXCwSF0u0zwNqsUrda9uh9IpAAsmzbC3aIzwROy2vkQPzUS+qA69zzRST2u+8mODXLXXElIb7rPZxn5Eglzj6RCql8dz4jgvvTYWVPSDA+Zb3/Yv5e6sSqJnekhEnl1Ne/QrzqTq6fEzwYmIJZNoMvQVuRRVdRzCd95zivnAN8je6M+dCfZ
X-Microsoft-Antispam-PRVS: <VI1PR04MB4253537C2F5772482E3ACA348B4B0@VI1PR04MB4253.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4253;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4253;
X-Forefront-PRVS: 0713BC207F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(52116002)(6116002)(16586007)(6666003)(186003)(66066001)(7736002)(6916009)(305945005)(47776003)(97736004)(105586002)(486006)(106356001)(50466002)(86362001)(16526019)(2361001)(81156014)(3846002)(5009440100003)(51416003)(316002)(25786009)(26005)(53936002)(8676002)(48376002)(81166006)(4326008)(386003)(6506007)(2351001)(59450400001)(478600001)(50226002)(6486002)(36756003)(8936002)(1076002)(2616005)(5660300001)(44832011)(476003)(956004)(6512007)(68736007)(2906002)(55236004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4253;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4253;23:QdRvTLGD4t2oJiFEwUPjYBXc6W14ueF7FX/htb8w4?=
 =?us-ascii?Q?rgwbNgN3BnNclZgwJ8FXCVA3RKdib4/knmV3NKikNCIFuqpCIEsv9Re25v/k?=
 =?us-ascii?Q?YLpJETb5vLHOzdTzskxSlYavybFFACG9cyrI4UkP7YY0Ts8JB4PCmXYLClB4?=
 =?us-ascii?Q?bit1JN0H2s4j1HzGsSPyWYNE3IJ+oe3JsSWUNckA8GY7rJrws7Ul6j9Gymxz?=
 =?us-ascii?Q?30mh1XvwnBGQU4yiyQdduSb3KLlHqcayoFOJjGB1KwMLFja6yNJLvYKHNghi?=
 =?us-ascii?Q?0eFsKRWfE/FvWZGwJ43nPmkj6rJv6zHziobDAXD00NPU6liChGdXcFNm8cDG?=
 =?us-ascii?Q?+A4Qqno1moPh1lAjw4lJo/Mbsunh90FrJmudL/Ehh3ZZTQnmQptgEB6v+FSy?=
 =?us-ascii?Q?DfYiKW9Jw7FMGypuZNXpJhfzHn5fhXq+UmutdrT+CSSIlatl/8zLFnWxQPgH?=
 =?us-ascii?Q?bgv6FIGp9Tq/Q80vP3fFqLpSTlvfk2MsPwovYmCpmFiJWi452EPhMB9OMroc?=
 =?us-ascii?Q?XPMk0F7BVUZ998d4RebntleeAyKFJehtt4MCkxwwrMcf/jHUXmA8t0Lb5tCz?=
 =?us-ascii?Q?cl0QgVcBZHph7hHB7WsaMG5JKOcM30HfYb1O2/uu8BioS7p1AqpTmC27MIzE?=
 =?us-ascii?Q?UxZTeYaLddejG9cEwBTbGZQ9pkvjH1UTTeGYsj6jsC01V5aabLUdCK1SqOby?=
 =?us-ascii?Q?OFUu+ctX+qumbWUSOGcMfzj/cRgOS7eofBTfNem2BvWsfOx9mrtSsyE8esIP?=
 =?us-ascii?Q?Xvlr7dgLyFHUaKUons/GU/BKIappAq93B/zMBSSJkhmace17W0BjIDSjmrP6?=
 =?us-ascii?Q?G9q3jQm1PWbtfN6swCVfceJ0NIIFDT7ClYD1fPL7kMXplbrTRYgZWB2xAL8C?=
 =?us-ascii?Q?7k+rv09IEMulQDGaestgSiTywpmAu4Gq24Wgy4yB1fvkSxU63Dt6mxYltBqC?=
 =?us-ascii?Q?+6j15ToX4RFgl1nKj/nTl4nzBspE1jKfCY9jUP9KXETVN+qcENlsitWCH+Ri?=
 =?us-ascii?Q?nLnycz85rIPPHGkGLsFELJwxNPkaB0fYIU39Jdl5R9tEtfRnsNs6XovXGtnC?=
 =?us-ascii?Q?b+VnxjsxDKVXu6e5T1pDOooHEgZRhzcOV8IcM2HNknd95i4qRa+h0Z3ZUpcs?=
 =?us-ascii?Q?Sxcd9EgUgoEeH+Ui7z2mH1shfxN3o7DfdSywZLF6mcIboiIM/AHHPWAKhgye?=
 =?us-ascii?Q?7Bb19P07LK4PQk3AUW+6esBqHwhPwY0pealGQhrVQEiG6UCr3kuzFOnNKIH7?=
 =?us-ascii?Q?/P7oI/OoLacth/rWoIIBzqcE6r4y721hD1mb2BeQ/dL6y6+HDbJxuMOHfk/f?=
 =?us-ascii?Q?ZsRjbQu5qDK56Ubs1YGk2g=3D?=
X-Microsoft-Antispam-Message-Info: GK+fpGYYikhmpZ40duow8MHGuvdJbqyMH3FMmFrHLpV3mriokoitTwrw4m6jXfvOiOyPMO6IYVvFGX0NO+4n+m9p3X+FSlQVu60MnqKWaDfDi5oo1w6e0tFaxUj4hqPyZBq/aTmMqdLYL30Fu0ZCeoaWKHo8BeDCxZ8ekswKwnbTjOd83IDJxQ8QTNwPX0f6jOLzCeRywnWoD/7zqNmh78VaDrHht8UBm+P6406TKogG0H1A4P7oAraIalVc8g7Aq6ruHDfCNJjduHcjgTa9iTXFRXapewg0DZmo5i92fP5HiuJUaKFmUAHjBNCb9lveepGvcQOG0+GvnKSeusLTTmUZR5jelwuXYiVINl65itE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4253;6:TPCQ06yiFMoQ+KSnVJDD3Mv2pFmXHzGAVtgRGJYqWeH40QR4vEEUSJyVmqY1AREHFldUaV24iyOSDg+TZSteuPsEIu62sStw24XpTudhsz2A1t9grhjAUAbt14qeJXYRQ35OCNUvL8voxzfzxI5a1ji/iMymmKs0xJIfaBXC7DSQ625w+lY23yLIJLrajWIdYomdJIWJWkbhBfsVDne7O2UAri8LQsEqTYNKFog7nrUjWIX1gmkRPJffVb2DYqwGB3NTpppzVya/SAKY6g3nzJ8WjHLp4V2Lw0AMSr53iDiaFJ/5wx0ymo9Mok78PleUM9tISO1JKItUA+ziOjeeS17w5VmuIyDMxIj8DUz15tPZ7uLlVXarLo5dtjRMZL9DCTmeK5BoZ9rpyEOs3LvOqsyznSm44X+hAsoWXPyBN0E/Ik4oAzQq8BcED7Wiko76DfJHRYyBxumoXObeVDlLpQ==;5:8vV8+U99ilS9t4032RrHJeZVBh0MCAz67hNcg+9fBKjwajI+16TXlKnw8VJ6YVD/iH6cS8M9JyQBeel1HHh0WvlCWHdeYpnaN365ZesKnNkpQniVwr6SJPrwPWTjsJamO0Fi7Ly6vCcOOcI9fn2u2rKU5AZJiZj+Vlt8uzceaYo=;24:NRIVlek0H2xVr4EwnXn75igekfJVbUo+GHz146Rruzd9E8Tg52sFLhqwiQw7QfxMyHL5dl6rewFuBwhRQ7uqERXo7avzTu/SDM0Dl7K0UDI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4253;7:9Tb6FmVD/aOgXGIQN7HBhxGJO9jIQ480MYe0YI88aF+pj1IRJbuLzfYE8ofg+Iw6SQLdm/TiJS9tjplnLNbV5jJg0s43i6hCn6opZpjYqV8il1BOtUStfUDSAd9P0eWoCmW66RLGCX7y3uwQclEet0ZTxB0Zf7KWmypodA7KakVzYEeDgkACU70AoKQ2fdfeY/PzAUxI5IwVMs+l/guYUpEn1g/499zlAt6tVoQV2zOQkOlieW5vr1qfZWOWXVbf
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2018 07:16:56.6860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d22f12-eca5-4cb5-6ce9-08d5d9a278db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced strp_pause() with strp_unpause() to correct a seemingly copy
paste documentation mistake.

Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
---
 Documentation/networking/strparser.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/strparser.txt b/Documentation/networking/strparser.txt
index 13081b3decef..a7d354ddda7b 100644
--- a/Documentation/networking/strparser.txt
+++ b/Documentation/networking/strparser.txt
@@ -48,7 +48,7 @@ void strp_pause(struct strparser *strp)
      Temporarily pause a stream parser. Message parsing is suspended
      and no new messages are delivered to the upper layer.
 
-void strp_pause(struct strparser *strp)
+void strp_unpause(struct strparser *strp)
 
      Unpause a paused stream parser.
 
-- 
2.13.6

