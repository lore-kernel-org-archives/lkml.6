Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeDLVQY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:16:24 -0400
Received: from mail-eopbgr30136.outbound.protection.outlook.com ([40.107.3.136]:40576
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753469AbeDLVPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:15:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 2/5] ASoC: tfa9879: fix whitespace issues caused by mindless conversion
Date: Thu, 12 Apr 2018 23:14:34 +0200
Message-Id: <20180412211437.21599-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412211437.21599-1-peda@axentia.se>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0105.eurprd02.prod.outlook.com
 (2603:10a6:7:29::34) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:ZIeYdd6MFcnR2bY4JQv8wJl2a4iwFkxdkBQfruJ3Ey+3GqYGmge2EMK+ZnnJUc9yE8OgoTItwBhil3EvkAJNOCTF035gbSb2SDvZttaZmyqrCQ3lorOaZjCG4e2qefeqVp/quxHVaFGIq+slW+BVtjOQleN3/75tpMEQ7wDDvB9ZE1J8uolSOVcFmiivV0ElCLFa+f1fh9eYLAkbqguI/pzx5IuBBImMvD98ivA6Zku04cnFQ2CbXEJsUbG80rHU;25:Ig5NQlkGjGyMJZ5fRBUz2YMsI5U4aO+G6y3au9jKM+u533YPE6clOF8cQd5hJ7TNh44Iz+tNE8VQmswE7Dp+6bC7QpBFr0SyTzCnZQiVwnK7itGMjyduDOOJjhbYDoE6LTHSX/c2rPdT1eK6yREFTGGHa8nrH5U88hN2lOopc1/DPnnLTWEZRf3el+rIPGsuofAneG8iWcv3QFtPQoKyh30KnWob+glX2pWvSqIaJyCsqvjPPnAdpqHOOEj6K+fJbgTOCpPmQLctAPvTHiEzXp9in1g4enfj/zkzwS9R3xCcE2TtR2W7P17niUl1vO7biLqhnYEyFyP87XN3EkbePQ==;31:bRX8leMXwIHITnh4wRTZcNckIACQqQjHcX4FGJVdCoAqNlfeZFqoIamdeqGqCixNgW6Ynoqrxt9Qy2X7pdpbb+6KMMRbM7JOeOuZKh1gGcb5qvuZt5rSJNfbMHYLRK4T2F9YkeG2kf0ErNApBm1w6mA+fDSEuK+eu9E/r2n7W4orDD1CwWP9rMTpoveRjQWrGUZWsxE76tO8FTwpBxQllSyRwLsLTPaY49CrSisRIZU=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27700324C301F7B8631B86ACBCBC0@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:DWVo3bHkQAgWMcMF2/bNDR8Pr6eImWKeVOPPoRSmhR6YdA68mb59Re4vs2/SfyQAFxrkdRAX5Cl/k0PMcA/JTL/dUCnbmPidROOgnSW8BzYcVwVTpz+yP/upWWtl6XQk8EcFLbKo2nb3tT82syVtEDtNXAh5F1KRGX6UoDPhxNajt+B8KohDeoUJoBup2cIeYyM6d5Ua6sXqRPVO/hhSJuvYCuL8eP2K3h3jrdhzWv1LHcWv+7YOLQg7VGYajazpXrpldr85X0quBGxyK7gz8Q==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(39830400003)(376002)(189003)(199004)(97736004)(6916009)(2361001)(36756003)(2351001)(68736007)(6512007)(66066001)(86362001)(11346002)(2616005)(2906002)(6116002)(7736002)(6666003)(47776003)(478600001)(1076002)(476003)(486006)(956004)(446003)(26005)(575784001)(54906003)(3846002)(4326008)(8936002)(25786009)(6486002)(51416003)(39060400002)(186003)(316002)(386003)(53936002)(105586002)(74482002)(16526019)(16586007)(76176011)(106356001)(6506007)(50466002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8676002)(50226002)(48376002)(59450400001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2770;23:z97KvCRmn7qmDFEIoiADlxI9SM6MJrFtWluwj2Z?=
 =?us-ascii?Q?RgakUgs7KVhf8kdF7DGZdYHtsbDV9dwmE3t17r4dIXlhjWsR/u9t60zNyMtG?=
 =?us-ascii?Q?GnOAri9bl/8dYyOsTSWY4lqeZN8iXbw15X07jP9ZdFK5PbhXcMaP3rJs5wau?=
 =?us-ascii?Q?DB2kNR5Q4Vwe/6oHcgOOddA9zgAODTrbeGgFwZksuFUqnkQEMHPRdqXLbaoM?=
 =?us-ascii?Q?z5nyte5yNSGwC/7kGsBQ9rYiw+c+cJ9RNke+7NQb/l4jXWYHGXsGwAItHhq7?=
 =?us-ascii?Q?/ArG08Mms2SyB5Mu6zf8GQBL4oHcIkHaT7UOnJO54YSBdmsVU9dSNVJc89qM?=
 =?us-ascii?Q?T32zPmCM3GtlcCscLYwhCtWqyXykhU18kvQYbXfay8+mpPtRxFtUcCuKvcJu?=
 =?us-ascii?Q?K2iGgmRG/wF40sMBxSi7yjxn7AeA4KbqlAAlZMEJ/n5XUQsk4eOwGHGVzR4M?=
 =?us-ascii?Q?atW3uzeZJNjOqJh1AztoaJo1o8oNwVciXgXABaCZkanZkWHlM+4uQ915rMKz?=
 =?us-ascii?Q?GEQodBnMoQYUD9kQlhUUMjm20QuKeoRDQrR5Wf9LfmR3rMmzKLjQOnpk0tIl?=
 =?us-ascii?Q?xB5rDFO7jtC142bsu+MKBQSvab9dLXEpzrRIygaLgtHUYIwB95czBHvZHMAP?=
 =?us-ascii?Q?A3XvKzEkISrV8KKqJz281ZMMRE7Dyb5NP2VvLElP1d6PnDE550PYTJfnf3y5?=
 =?us-ascii?Q?rCYkA3RrcHS8aX3v1uX8bPfSNOvV+fMmNZqUezdcbpxQ+fnMq+GmrEjWfsXV?=
 =?us-ascii?Q?zUq0rVBTDMOJEkBJ1HivExNFsGLxdEUW/fmY0zbCQzKXhBsjaA2VAFioNVZo?=
 =?us-ascii?Q?ThMN874PRwA464P87Vnx84k+gxCIV/OmtmwCIqvVhWt7/KR8JAAYeITk1Gj0?=
 =?us-ascii?Q?0CbiTdpRJ0/5Ush7MGp59wkcq4rgY3Y1UTYfT8LCzfrQkyh1NVuYCyct05fH?=
 =?us-ascii?Q?jXfreAuRvUvir77k8Y4YGQZ+IceSGAl5kZ+9vLgFG0Qs/+qJ33FXxKZrD8gD?=
 =?us-ascii?Q?wPWR6o23bKVaSe4wf0Vn5JNuNoPwQCBMNWwTGCewZWFmBxOVz06IcZx3GYwO?=
 =?us-ascii?Q?L5J3MTMFCzk+KQuVV6GeZsLeY8q/nxHv5Fml5XZyfpM7K2ev5BsBB5xOopnI?=
 =?us-ascii?Q?zs5sheVAB2S9V2DN0P+CCYxBiDfEEly5TsB2nbHVR+8yjX6fCUc12S8ay458?=
 =?us-ascii?Q?A+ptOC2GiKHat+nkioCbIp+v9QQsQwLUBhK/mzq7lqc05k7oTTvDZ0vPd0ws?=
 =?us-ascii?Q?zrj/WtCP8Pzqm25MvI9mlx6+fxtuZoWrQIeLuYvSWrzIS13JcQ8aGv+fljl8?=
 =?us-ascii?Q?UvfcYNvBfBW1NcZ3zSSB3MI2pyn4hUYy8WDNKZVTwmdY3Vm89WPxpOnExjHS?=
 =?us-ascii?Q?rMfHZSSeB8+4zOx9TSDXGmZnhPef/NIZ6stXX222j3V0bcvuj?=
X-Microsoft-Antispam-Message-Info: FNZJDSgWTBErXymubnXQrWdpG332hOOOyNGtqgjzMbS5P3ZruJsrm5DqvbXna6ZaewYAXhkPKoP5bZZobEfJAqHmynu4jl/5cxX8cVXWU9cqbJ/v5sq3Dqg5659ql1LYIJIyl0uXX0pPYX1uGmfT9sNcLsqlbv6AUKoeGpGFPPGWUhZ6NYwxE+nJxO89zH+e
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:cE7/V41Jb5JpAa4TIr+U68yXbGil0d4e7SXmSd00/EMf+tDC+AdbH9gMINSgnhZ8l7Bcq+jKY9qyrSXmqT5OVue9xC0dOICSNt3Y0bAmvMUdlZ//IvYGmr4RZiPoAjadXKrO4QT3K98aJ+xE9Heh1a9EoILlk1mdJonyIx7HZXwXshIm7UsmxLrWJFnR+SBDv/Yseuq9io6qi55Cmr68v1tCB7sFdM0IMPtAAyEnvymsvfVV0wqwzq4Prm6TDj1EunCKb6i5I/r0iVLZ2LiKwQhpQqsou5dEBmIGREIb+4E89nBzn6U/jSF+FPJV80L8QaDfLzPi9gZz63F4YlENtHACfVDGjr5dSnAs90R6ZMwrexkIfqWcmFi8ENnbn8EpEk4t920rUCHqOVLVC/MxGrF9hQ7T37LRNLSxH9D7bnaIMnlqSOqP74qAtj7Ypdtv360fK0Y2bPTfMLLTMIWbWw==;5:lUnRzyTNYY4f422thm119Sui7VTiHBERH4mhdjS+uCRYfK/Ok1o171khBRGzxyA++x6dM9VRyb0lYGemVTNIJQXLWFU9pSI5Z+Jlkf5Y8riUwid4cwKPZ6MFQUeNQ1kwyLOzb82cCnEiXoYtakc/yBLp1tWWydQc+cCQOviyOlA=;24:Bm0af01Sb3ZwDdScg/Lfmo/kKrk/J1XFEHuY7vjf7ouaMdYFcOtTnx84AeIf0PX8SgPp8CLMi5+s/oDV0bR0DNHAg2qkE2FhES+sEhzej7g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:ci+EYpOALCR1DkEQfvLIzM4VICZdPYpAvvursXcfIIIIFshucYFZS99e1OEqWQ/1YzEOzwiTRG4TGMgfDPscXT7PMdcwSnw2fvBB9gjbUzf6huZpXqkvamuhZJb0b+e65L2LsQ09Dxdyxr1VDmIG7I8Ux/9qVd3LXh/3EmZkWfOKdKrwJaXVLE9HqCKXhc8RPKQwMaCCqvEK1Vq5JJzB0yyOrRrTb7PzAzkfLN1PZ8CgnMU1pptSlUgrmz0z99HH
X-MS-Office365-Filtering-Correlation-Id: f3e841f0-4f20-41ad-9f37-08d5a0ba7d7b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 21:15:16.6939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e841f0-4f20-41ad-9f37-08d5a0ba7d7b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long lines and bad alignment disturbs the reading pleasure.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 6d213c6d3920..c30e0efdbe39 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -88,13 +88,14 @@ static int tfa9879_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (tfa9879->lsb_justified)
-		snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-				    TFA9879_I2S_SET_MASK,
-				    i2s_set << TFA9879_I2S_SET_SHIFT);
+		snd_soc_component_update_bits(component,
+					      TFA9879_SERIAL_INTERFACE_1,
+					      TFA9879_I2S_SET_MASK,
+					      i2s_set << TFA9879_I2S_SET_SHIFT);
 
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_I2S_FS_MASK,
-			    fs << TFA9879_I2S_FS_SHIFT);
+				      TFA9879_I2S_FS_MASK,
+				      fs << TFA9879_I2S_FS_SHIFT);
 	return 0;
 }
 
@@ -103,8 +104,8 @@ static int tfa9879_digital_mute(struct snd_soc_dai *dai, int mute)
 	struct snd_soc_component *component = dai->component;
 
 	snd_soc_component_update_bits(component, TFA9879_MISC_CONTROL,
-			    TFA9879_S_MUTE_MASK,
-			    !!mute << TFA9879_S_MUTE_SHIFT);
+				      TFA9879_S_MUTE_MASK,
+				      !!mute << TFA9879_S_MUTE_SHIFT);
 
 	return 0;
 }
@@ -152,11 +153,11 @@ static int tfa9879_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_SCK_POL_MASK,
-			    sck_pol << TFA9879_SCK_POL_SHIFT);
+				      TFA9879_SCK_POL_MASK,
+				      sck_pol << TFA9879_SCK_POL_SHIFT);
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_I2S_SET_MASK,
-			    i2s_set << TFA9879_I2S_SET_SHIFT);
+				      TFA9879_I2S_SET_MASK,
+				      i2s_set << TFA9879_I2S_SET_SHIFT);
 	return 0;
 }
 
@@ -298,7 +299,7 @@ static int tfa9879_i2c_probe(struct i2c_client *i2c,
 			     tfa9879_regs[i].reg, tfa9879_regs[i].def);
 
 	return devm_snd_soc_register_component(&i2c->dev, &tfa9879_component,
-				      &tfa9879_dai, 1);
+					       &tfa9879_dai, 1);
 }
 
 static const struct i2c_device_id tfa9879_i2c_id[] = {
-- 
2.11.0
