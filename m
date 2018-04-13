Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbeDMLsL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:48:11 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com ([104.47.0.96]:44704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752899AbeDMLsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:48:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v3 0/2] ASoC: max9860/tfa9879: switch to SPDX license tag
Date: Fri, 13 Apr 2018 13:47:49 +0200
Message-Id: <20180413114751.6464-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180413111927.GC6854@sirena.org.uk>
References: <20180413111927.GC6854@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:206:1::46) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:ZtW5RdUlNHnvfBxDfAx1Hdnlja4vaX8jslSpVGtGxxedqR342DqYYeLmBEQav6mNqcD1G6kJcGmu9vL26Pbk3iP/ue7Y/z8f7lnRODMX40Ly2REkZZKDvfcXDZNkHkUr4vVCOT/8u9t/oimlNWpZgdT9WVrUFcJQ+ovyW4ofy52HZk1JGtlGofxO6nAIqqhjWkhlV4trh8RcejoK2ZhHsK6R6qH//ptdzTWpLdrX6WKdthR4RnxMwV6BwE4evjcm;25:w8tMUYOhfLKs+wksVQaVsNnuFqyFwQRQqKQkeUb+AvmQMAQ6MLVHulIoHWfoaWMZpIaAPM8eXx71SRZthRosFhbgMfhoMwpyORy4KeIqVr+dI5VnQZLrp/f9xbTImdknUWbQq/xQ3y9ZumVZqf0nDDlmVD3PSKeIhYzUnkkUbp3tgPbU1Huk/DNgr/LTMZxjyOACbcm0nOhZlY+MutyIFR2godEkZZHPLR6DoT6GFX+Y9MpbDuG01HRQnwev9nCVZhb/hHRzMFPNW0NER/e2CtmaYM8CnYIBV9iV7U6FleRYrtirC9crq5wRdB8nCK3fcLHs+aO53kutzM9L8kqGrA==;31:DtEAmIMG/f+cpsYIgdvmTJ0PGu9n3qgDxcpqGat6Aw3PYweIJ/ahgIHenWA3pMfXeJeJp9MM2KPq1J+mR81QFHbrG1ybWfcO2WPM+y+zqNPbhxtOVVwl1MzGNU4CSlvLipnhFLRDBxC3/IquQJwXkUr7m/esQoHNKF4CJtI09CJ5FdHWeaK0fm5Lr/kT73T1Rl0tuUp2SrUCrrDX7eXtHBMnnjOpmwkm+EVWCQTfBmI=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782E7C2270FF654A301EB1ABCB30@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:VuLUkyiiQMKOqKd2PTm+UpRMrur8wed589EsIm4F4+gIA2OrAhnk+QA6trQUxD53M7c37TxW3UzhXEvKGzhTJwEy/zYwyklEtFWvUltUw4ckX8ZGhmVnsW3VTH/TtNW2KbpdHtlxRkzhEGpG6enbljvh+5eslXiMRmhrsKKfq1DNdaypICq6BAp7Q+rqT78848oP/HYIhGtNWQ7KTMPGVPSQnRqOtV4NnVEhVXUhklcVX7gQkQD5Y80TksSW/Aq48AV4ldSsvEJc5KwCN8sVyA==
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(377424004)(956004)(11346002)(6116002)(476003)(8676002)(54906003)(386003)(2616005)(53546011)(6506007)(36756003)(2351001)(81166006)(76176011)(316002)(16586007)(6666003)(86362001)(8936002)(6486002)(81156014)(446003)(74482002)(305945005)(6916009)(26005)(16526019)(186003)(5660300001)(50226002)(106356001)(7736002)(39060400002)(50466002)(6512007)(486006)(48376002)(2906002)(68736007)(53936002)(47776003)(4326008)(105586002)(25786009)(97736004)(2361001)(1076002)(3846002)(51416003)(66066001)(52116002)(478600001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:RsZAdj6pfE+S6839U37YtfazLnhIkZFl5vDQgyR?=
 =?us-ascii?Q?fUefJrOwiIVd6a/uLaqC459atTDpQRJcO6A3nhgQc7T5z3qTnQBKMMQRcr1S?=
 =?us-ascii?Q?8b/GBmSjA2jdI/KzYZ48fGZbeSC2+G4TrLWCBPCn4NDvZWHZxva2WLjw1nzS?=
 =?us-ascii?Q?ETtbrkhf3I5nGBeMIUD8kPlUWvkB6Zr433hOhXigccz2QZK9bkWfUPmpL/fo?=
 =?us-ascii?Q?uhe/2qXW9TQAMYfHvT6ZSgaomuS5Mn4v0WdCp51YPNteecRXZLG0EeaA35Bi?=
 =?us-ascii?Q?uGxeUcbYZrPlz+Ud112i0K6+h1xvb0PbiRuuFLThk2Q6370GsAHZpOOtnEf3?=
 =?us-ascii?Q?Mk9PEReVijCtdId8aqNgHHHpQhTdkugSPNRwvJtMLlHxj77e/3XgpO+EOB2H?=
 =?us-ascii?Q?y6T6mRIjGxdUBrlg3ng/a4D6y4ilHrNknzrqoQvvewtwu/flprmavhOSpgXn?=
 =?us-ascii?Q?41FVgRcWcOE52JTFlhFvDKHyTU6s+Za6NLubfQ95qNY8V89K7L/DK68NOwS4?=
 =?us-ascii?Q?NVJo+61Y/e1Hft01JO5hE+Z4FaAFKG/z4D/Hs62oKbdIRbDV7OwXOxE88vls?=
 =?us-ascii?Q?Q9s/sEuvqu0iYx5ReEH+86VEWqWrx89zZksB+VyKjENNxt1DyRQI2orPKxoW?=
 =?us-ascii?Q?XBxQjhNEH6LPSitGOHvmApFxlsBqBEB5DxHl3Z7TOcHkfrZ3oi5UeD3cZibN?=
 =?us-ascii?Q?I+AvI0ulapOeNSw/jnPTKozTL+vbm7AAP7D3htzOF6pK+o5ZdOZvdrk2k7NI?=
 =?us-ascii?Q?uCYKV2hIoSbtNW5ClU1B9NO//JVDJPWqvSZhTTljHBFEeNdXsWECvvUnq3Pq?=
 =?us-ascii?Q?RGQL81E2uA+gVU8e/4Fosg+5DoJFl1k/kmVgY85fi5Ui/OFTBJqg85gQidZe?=
 =?us-ascii?Q?Y2m8wQfRRZ0DNpHKXKN14VkTDLp/2Y/YmX5wzTUMEy3kbySMtUILlKR3jELj?=
 =?us-ascii?Q?KQLw9EyWmjhABIwrI7Uyd76HmlSG5BQmiao5t7AbE68oPEv1C5xwnmtvroUb?=
 =?us-ascii?Q?+jjJQcKf5Xuh/s35x4qeijwnrAuAbvUn8adZOKcOsfMLAX4289FKIFZ0T4RU?=
 =?us-ascii?Q?nw1yAVtQ3Udo7/SiLYxgDm7gecwWBa2Q5bD/QrcSAR3YX66ZDNVg8bJIX6l9?=
 =?us-ascii?Q?ppD4XGUvUEl2eSJ/cguy224aiXMUl9w56LFk2tnW+vUJhZcAPvguX35rYpXy?=
 =?us-ascii?Q?hfhlnkHS9j3tAsj8jVvV/5qoPRd0Xk02610EoDVbkihD6BPh45N5ONI+7WLF?=
 =?us-ascii?Q?q5gAHMLrpIXcmzbM6TcR02X/5Whc9uRPveXA0blGOiL/HI52d3Ai8bxPWJdI?=
 =?us-ascii?Q?J+jG3eXtYvqnTxkKO0rvp1FO12T+4PJDtxhb13LfYYqQY1uCHWiLfUHISlRi?=
 =?us-ascii?Q?cRKI53Ce54+lKsaQw1xogN+qmTrI=3D?=
X-Microsoft-Antispam-Message-Info: mLFsr4/2lN0uvA2Hq30Vuy445DXdkWdidhuPa95zxrimwHlEtUe6wikG7w4Tp9aXZZV+dVJr6TTzIupXTCGSn+vzsqM5yyl21/ZYV4B+KRz2NnI6EVW+n8lXvJdnxtD6n8nWxC5f4rflOF/gIWSq7IwEBn8+I0sJpckAPhYbiBwf64igmpNY9PtAcPRXeBcM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:+LbKCWfH97dOgi+WMqEjaigaAN1SnSsrCNBBXT3mR/RhBi8Jv8JbnLz1HnKtI/OGuCrxNtgqsZPsomuZueNYtJkvwtoMrhEIli/NjZz8btVgViIRonNJCnzPHF2HwjCmmpjwdZLApJSShvgVMeDsqqsJKhY9HP1olDH1GeBbZQWA1KjSZ4o1049ULq1ovNGlAK+c7tPEnsQaQR8SvkT+QGB/25WtaxBn8ghXnnQNVyRLToI+kVPUHm1Gxe6xTgH65vvGaWH0FGDEsa5mORwmjpiMtmJGr2GcqwfCqWYhN+p8L0T4iNfOAq6GYfRsyUHsiLOuX4onVrlUNkDomlrbyamrNJO7W0viviLcRkuuef9i/SN2GwSheXKwf+mT4uMGFGq1x01hM47YTlB9MjdzYXQcjtGyafM+wcPNv7x94VaAdLRO87O7gi1tCx4DKrlUbLDNZMFXjIUOvuMM5UHr8A==;5:+QdQcbNUpFk6jBSjGVUdJjOKSZxD5OJsf2dKCjexcj4aeIt9xG3zpOwny+OZWt5NCFUGcYiynLtuDH6xXbvhGE+6Ev47f56oj8kIPLvbo1TOS8t6XOFlQK5z63zAXA1x/tusBEsIu72hSXTNVk7uXpfkRgMF1vTfs1f/xCAnOnw=;24:QUduEQ8/Cy5EBO+nlSC2BxhKr9IE7r+9/W0Mkzoh7g1opXZ4AKvlp1Fh98sAM2JwnhgoV0SuE+gHCSc/tP9oXf+YLhDPNFHdj6atHyoBmi4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:4qdBw4uU3C1qA95nqeuC6c2F6kxe4g1Hm069aZtoCZ4VzbuAuwh7nTGUjolB2jv7p3qemt5jkdgs0svTGbszqR+gF22P+rm/IPUrT58sRVeRZrEfOvIOK3+NVqP5FB40hNNvcxXeOtrNSReknpyopwP3tNgTz1ADiNV5itV4tWRiirnNmihjaI0iUf3YcqzUU+pcNvuvVc3GOixyFtm3BCMMD8kP/BPns2n05IIL09GVaKPjqZUCoAKRoP1BRq1L
X-MS-Office365-Filtering-Correlation-Id: 990a5298-2452-4e9c-8759-08d5a1346b58
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 11:48:04.9440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990a5298-2452-4e9c-8759-08d5a1346b58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-13 13:19, Mark Brown wrote:
> On Thu, Apr 12, 2018 at 11:14:35PM +0200, Peter Rosin wrote:
> 
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Driver for the MAX9860 Mono Audio Voice Codec
>>   *
> 
> Please don't mix C and C++ comments like this - it looks unintentional
> and messy.  Just convert the entire comment block to C++ so it's
> consistent with itself.

Done.

Cheers,
Peter

Peter Rosin (2):
  ASoC: max9860: switch to SPDX license tag
  ASoC: tfa9879: switch to SPDX license tag

 sound/soc/codecs/max9860.c | 31 +++++++++++--------------------
 sound/soc/codecs/max9860.h | 10 +---------
 sound/soc/codecs/tfa9879.c | 18 ++++++------------
 sound/soc/codecs/tfa9879.h |  7 +------
 4 files changed, 19 insertions(+), 47 deletions(-)

-- 
2.11.0
