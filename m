Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530CFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57D820844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ta4+WMHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57D820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeGaR3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:29:44 -0400
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:49712
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726789AbeGaR3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjnfoBOWlCoVcGlVUYKmfLp2DayiKssT7OQJPzukX6A=;
 b=Ta4+WMHGHnrfId1m/AJxP2nsYz2Q01zXqRSiYQrnfRO5ECtEXCsgSu9LYi1oraSAhuNmOHgkm9TVyIyfSWtUFXY7qlkWHxBd2yTZHPhYxivMxfrYTOjCZZszMKVe1SV2Cmm/7Wup4+qmpFYapmE51PvIr3sEa8slpW7lCJrEInU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 HE1PR0401MB2361.eurprd04.prod.outlook.com (2603:10a6:3:25::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 15:47:02 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     davem@davemloft.net, corbet@lwn.net
Cc:     laurentiu.tudor@nxp.com, stuyoder@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] Documentation: dpaa2: Use correct heading adornment
Date:   Tue, 31 Jul 2018 10:45:53 -0500
Message-Id: <20180731154553.3648-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0201CA0009.namprd02.prod.outlook.com
 (2603:10b6:803:2b::19) To HE1PR0401MB2361.eurprd04.prod.outlook.com
 (2603:10a6:3:25::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc4c04b1-6921-4b5c-78ba-08d5f6fcdd22
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2361;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2361;3:zVbscFmHrz6aD1Y+eeH417m9/ZPKc2BS+OHwheU3kC4Rcw5fWQl+XzqtWM0N4uouQ328V0PMUFimJ9bpKob4gGL4KE94fnea9R/nqKF37TwCh2wi4uPe0m5YCUNdFuC4b30PPs8c4eAtIKo4Jz4UmMwpF2+GMGWEAMChpX8+McH077Fj2NyriU7xciLYZKD15UUzsRC75CreVTyN3dGmg6Yp8zAtRuP5s8p/o4mEPjYjROFKbIZad04oIffEnO95;25:0TaXgcGSl2ATJQ5sSaUn5nm8eHXfzFfQzkzWRrbt6XG6jOaV/r5tE/pGhTReDMU9OO4pNG8Mh5xVNjncdjZHSRoVLWKw3Yw0PUH0u1q4UOXrAUwr4rmGvHKUJkwHz8GJ2ExdRq+pOEZ27GDXG1c9sm2gAo89sik8WO8rOz2t3QmEGpwFENaVKGG17GqnBBt3FZL4Ui6x6uucml5u6QPI4cmXtxekQIq9EEz3YqsXE0OhEJFbH7RJJNB52IDl9I8Du1heM6o+PK27KAemJwFrDQ5yyZNNHpTGmrUZKUXVZ36n+ref+90YI7kw8hLhMT8kHvtBB5s91AvEtnosw0hrMA==;31:9DFUptqRoCb0ORZsc+BefQFO2p2DN7OK2r0jwrCRlp5B8UNZZCAhNtqtEaxQeTdM9Wt8NM4fzbW2o/y2VXkdDw1HN/IK9KNOfy5fln8P1vQqbNKfZ2gE/60f6WrcJEkcQEzB3kPtWWf2Px2XTWGQYL2UkkYoGXga8zatWCB6gnpfSh+vkZ6h9iqRoUrQOrhg1C5QK3RBZKVctzmpEd7b4C1KIc0F1TQ3fOdqS2FntQo=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2361:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2361;20:GGHXNwtR/plb/tPBVioNi8VBbNbgz71JtEuADBZCvxCOiQPGppKYtoF/5CJLYsj8xC2EsfzCtGHNHUnDJm9T0sdtyixLEoGNRb8Ua7FyEeiYEXOKoIFV6WMxoTr9TB7yWw4VZM4V/pQ49ut3m1i2foxsdUbsftBIaKSWPAUonwKTRH0t4gzZnfpS/QnkfAWsEI0MNS3wMWDZrU4gCw2S4q52cQWqkW04ahDgPvN9PvOlxInBJLZf3jgGwjybydef//qbth9XjrmlZsZyw7JPPl8ibACh8lfzIaRg9LrVUUz8VkLDluTW8m3CURxGz7ksFISv2hJbo9Oa1vvqOC/J0SSiGZyxUM4QDMdWl/j92Eafn0AKnJR9J/dKGpzOqTztM/lpFv1R3xEcoGrJRAcER41PvD1UCFH7WBMtGdE6hxFhcIEk8D/CAVzvEuAufdA+PB6iohWL8dHGDXsA9yRGUcEdDrVC70R9F1O8j8AhBEecDNmqpoxTZFn74IHt6Qlu;4:/iyf7FciH7sni1zSlJTcq86rLT3my2ozkggb/Vo34UpJspzRwb8l/Mu7xDR4TrhVbpBYBnvxbpnb9OZ6KYtLsEHgCDzaSlM5R3oZoWm0a1RTYdLh5LjxaWSFM9Y2nSTXaERGvZ9J24Ql3eHddoMTGOTbLO4raIPZHhgCaPnNOSBa6erSWLa3YbaC9lelHito2x5e/PZ38JNmH7AamJZCJPKdYKXwlY8kG2naNuJv2AWuM89N/rEf2GfwCwzskHl98ey6GP2ygxEkPT38Hc4zk+0+toHtxPcbVMZYFT4TRjgACAM89bJRd6QfCmUgSZ/k
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2361C4BFD2A957C6129FACF6E02E0@HE1PR0401MB2361.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2361;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2361;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(366004)(376002)(189003)(199004)(2906002)(476003)(44832011)(50226002)(486006)(305945005)(6666003)(68736007)(47776003)(6486002)(66066001)(5660300001)(50466002)(81166006)(1076002)(8676002)(3846002)(6116002)(7736002)(478600001)(956004)(2616005)(86362001)(97736004)(52116002)(25786009)(51416003)(53936002)(106356001)(81156014)(186003)(14444005)(48376002)(386003)(105586002)(316002)(16586007)(39060400002)(16526019)(6506007)(4326008)(1857600001)(6512007)(8936002)(36756003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2361;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2361;23:ba4/brY/m1NGZB681UjsoEiey26pEMVsWKu94ne?=
 =?us-ascii?Q?gb5r046q/kZvU6FbYvF2MoACQ2cOK+vganzjxAccnaszUqVAkKkHzCzxSS/3?=
 =?us-ascii?Q?7Gq0Kho2N7rF6bYpAhRyOly4IH7yqkUTcKURYd58UR1N7gdpBf3saB6vPtr9?=
 =?us-ascii?Q?rU3IJ3Kg43hE4omYT4qaaIlcZ8nR6tKBJ4njfVvwQw6CH3CC80xr5gJMkaQR?=
 =?us-ascii?Q?rmvz0j31zx/4Ve4I9iH1jjSIw/FBSiVBzLIKurozgtixmMF2SacQwjPfyBU0?=
 =?us-ascii?Q?wwhpzHwfEjQ+jrssF4o6gEDtdT/A8xQBPGjWlBjo+PpqtUxX5fPcmXa4kLMQ?=
 =?us-ascii?Q?EWp9O0hU9svsZicx3zgQ/SXUuB22ecJkPibUAQIm2y/6CuWtaFau6aoPajNu?=
 =?us-ascii?Q?BGzA182ZqqeDXsz0E3KVvfFfNU5wDETV9KAWnUiQNJ4fLZ7To3zfPWSKlIUQ?=
 =?us-ascii?Q?KaEbwU8wSquoQsCqbVJ+7fMehFV/ax049+yC4jdnURjzp5easTp5cLL/G2bq?=
 =?us-ascii?Q?v+MdupxsJdPZyH7EjHtS9+HPPOeUjdMpoMqAkZxqbMbJXA+gwyAUYOzN9GMS?=
 =?us-ascii?Q?gEXQVdR1HSwdsY1XZZ0s5FaAx2jAvdAMIhwr/y1k5pUlea/8tQNOfrCq8tLD?=
 =?us-ascii?Q?FEg/V0yGePqsfwwFj2k/ln3TK1qPSoRA2PwXzhGdpmzEubDhUrMO5IZE5nK5?=
 =?us-ascii?Q?gAyKXnCfQpY/+OwyriccwCHXXMyjA14mc8C5S9YgTRRy4YhjFF4j+6RNWRi9?=
 =?us-ascii?Q?iq7eaFROfOW2AzI9dyVHwiIncZzoA1cRaaPK253S9k76FQ1YacJuRZb1qgnY?=
 =?us-ascii?Q?741tT/FvEgqn+LpjPOJtWOIaYwxnBgzvFXgkCo8sIMEIjvU9R6wHUQfxc8Fm?=
 =?us-ascii?Q?wq3bIxzh0iVWVsygRUQdn+H4urue3ZhIYgcvBKH5yJrhMhEbSaCgv8UEB3cf?=
 =?us-ascii?Q?mNlfR8JA1BmZPkJgYBjI+S5pWeFTZi4V3CcSwlSfbS9ZuHOgyIvFF0FzhnLf?=
 =?us-ascii?Q?t6AjuU3v7e01cwsLhGyARZ3dK63V0NJiuswG8TY2ZGEdzWwisSSKa1pEfEWB?=
 =?us-ascii?Q?cI5Kt2WauY6tfpoU3Fz7U51qstrLEN1AFhcvlVlcexi3LQSyxctEU3h7o0+r?=
 =?us-ascii?Q?I4a+92hAxLiZytKcoFbn0SzKM2GjwOVEvt5beL5Lskdck60U1s/WPsRaqWqb?=
 =?us-ascii?Q?qz/TkqDcuoKH67hvaP5PS0aWGDa/zT8bUkz9Z?=
X-Microsoft-Antispam-Message-Info: QVWaWY0oYb1sPGHXmXXusB6eMXKBWXP0ocB3G5I+WRIdi/ERVbBMxo1Ba3MF55jKxWBCIBWS/N30xAJ4tMBxHdN5m3o5/FjS8PtfHdNSdJyorZTwzjXZN6zbOtLB+2ktynYNF3IoyFaIlyVQcwGTGxe3kozV2OQ6Z0a2vR3JBZLl4mhf2t3hFXNq3QkGSfMGp2TudWCE2/08SWVml8CUCnwJD14TIHWSh/55TW9eh2yfLjcZehkSXOR/wwgMjDuStQLJ9w/r08w5s+Y1wVQHhqYOMj26CxX9Nz9gc5Ug2zcyIWVlIxwfBCQ9RbQUhF+cQujszT7nshX8xoMxKLACZ4IQFpOolaZx9+gAxZ0vUKQ=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2361;6:E7Qi/c1ihRmCz7lee2KzSF3TmYI0GcJahM3HZHoq1LyBrWs9Tnu6FTcEOy3PxrLgrEOaUHIvC3ynD38Pwd8aURL6dy2gcLrDH0WydWxj2svFwNNvCyX27QupoKBvcDb0/cm3jGVzL1WLcZ7T/OBUNeoz5WAWOuq36NkO2ypZNCfmbkPyRbHk5P4V0mTT+q8ROrzbBITG6ORwa9iGgSk80qyizv6zqw82jocK3orPxPUKtlke5kZBhNaat/XFmEiSKUY92afN56Wd4JZ2yWL1lkx7GpBebhvMNjYifsg5+N6/tkGcmpnKBqzcIE+/CPcVqoQeEhCn6+EiuCBCayE9Z7KWO392IPddoBs2aVxpW3YnnAyTUYJKYcFKCG8JALn2cD3yUSFR/Ky74h6nA77ua5taJrgUH0191NO+veQ8aC2bD02e3+dAIMHlVnFJBNMo6uc3FxINk2gpvT0xymEMJA==;5:g8SzlGdRFH9LJQaoVoMVfOvsPq9zMD+Ma/uVPpYPuZshKGO0Ei3/MlBw7KNA4A7+xrpsLjQhwEwSjPSWBF4CXPPkvZb1ljeiLDe3A7kkfIGAwvPoislRQL2GbWOPCPeefgKA10hOn0j7bzkrtH5BiJm+DHLOTPBmSmUIVtvjH0w=;7:cG7hCN/MxV8D7x0x+22MJ86E/DAVNKfQehqK1WoR/senvxnnD2YMjaeii+Vu0jBbyvc44b74nllT5Lusx3eaBqq/SKJSkozHg4Oo7rJ6ZgY2Kv55Ow0Oz5YKw2Wln3Vr4FG/0fJIaXCkIEUg/tYyEGDvj9KBXypqRuXtuUbaa6tsmiBsEW5EVb7s7OnA0lXRlEHPV8XSyfPxS3ZMFbwAQjvGqPFmEU5nFePyB4K9uy2Cg354X5mEzitLgwbcDYNE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 15:47:02.7123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4c04b1-6921-4b5c-78ba-08d5f6fcdd22
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add overline heading adornment to document title in order to comply
with kernel doc requirements.

Fixes: 60b9131 staging: fsl-mc: Convert documentation to rst format

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 Documentation/networking/dpaa2/overview.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/networking/dpaa2/overview.rst b/Documentation/networking/dpaa2/overview.rst
index 79fede4..d638b5a 100644
--- a/Documentation/networking/dpaa2/overview.rst
+++ b/Documentation/networking/dpaa2/overview.rst
@@ -1,5 +1,6 @@
 .. include:: <isonum.txt>
 
+=========================================================
 DPAA2 (Data Path Acceleration Architecture Gen2) Overview
 =========================================================
 
-- 
1.9.1

