Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeDLVPU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:15:20 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com ([40.107.3.109]:36256
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753105AbeDLVPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:15:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 1/5] ASoC: max9860: fix whitespace issues caused by mindless conversion
Date: Thu, 12 Apr 2018 23:14:33 +0200
Message-Id: <20180412211437.21599-2-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:q2QdmZNSXL6CGLSm7kw4JIQbXh8GA6ZUMY3IY26RaSNmWRgBy3mIIQLtyptLj1JMUSlDiM9Lz/zGzG1EItCNJhCM5qaCoBDred49NFoWHjdMR1Z/YR5ZzN44z1wPu9op04i8j0OGtRvSoVCEam+NTITigAQRsGteGt3trycs1pyopuS7v2M+P64D31AJ9NrfN4pMfiWIfxjjvecIIbLh/154St3VBpx1HGb7z9lTk9XbFp8hzBMeTagC9SssfjJm;25:mOH30Kmr4MLzkqPJ1/ZgPmpEtf528rIGJqnNy8stqGD8wZNfeRKa+zAkuhBPdEl5fZ7NClSXn26z9ZE/ugsyh1t7RBeNMtOpQ1THT4wm69A6cppQbF7rJxv96sIDOUvGifnqkRONBQ36MGgzStZZ6OcPDKZVTnNHWQqiPy8wfV7gZJwpamD5CYlzOWePocCj/xdC8cL5Z7Rrj0fEH8kRgQALmJBXrv6eIK57Vm0/0fnEDIIjemfLnNpgF5lXppnWpigIj3jYf//XK5AWJUZhbxjbaa4/zwgoWJ3rCik4zl3IWcfte3heqs8XVPldBfyYgH0yjYMkwiZRRUUHddUlTA==;31:v1FAb96A6uL1MkSLqIM3CZCFoV/f/vqdUlVmiGijLbt29nWmYBsGEJckXgVv7QWUviVhe2hro48axLjpGpdHpJMOrZdzc9GRPiJUer1NCDUAPKZSqn72sL6N7haVet94hcNq/lf9sqKVPh34WuvnbQKgviJ50en+v96a7DwDx9dcEZAjec0Iw6f9fkWvXFWdT1MEjX3Hj+Z18OI+JsmIHSAqamylIRIIH/Lvb2SOrOQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770208E9D4436005762C64CBCBC0@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:YkMzjZ3AeCyWVB5B3t4OUQzuSTPJXiyTDfN8IRJIzzqkERqxrrbQWR+mFU+o6kxEC41UomnQHZ0fYQ+IJpaqLszyjZZSIQzhsEMKO33MrA6myQgh+vIWFRjKBALYiHuuYMltTzNPLt5y0+uGhUOUOh+/91XYfUFZtCt1fbni+mS+j3nXYZS3AMHrr7rNhNozRepPj1jCE0bJjaKruBj02tOiIhC51QwWAPyVguOognDc5UjibCy5Wr064mceYW3q+nzJlDDvCnoBDtmsIJEXmw==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(39830400003)(376002)(189003)(199004)(97736004)(6916009)(2361001)(36756003)(2351001)(68736007)(6512007)(66066001)(86362001)(11346002)(2616005)(2906002)(6116002)(7736002)(6666003)(47776003)(478600001)(1076002)(476003)(486006)(956004)(446003)(26005)(54906003)(3846002)(4326008)(8936002)(25786009)(6486002)(51416003)(39060400002)(186003)(316002)(386003)(53936002)(105586002)(74482002)(16526019)(16586007)(76176011)(106356001)(6506007)(50466002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8676002)(50226002)(48376002)(59450400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2770;23:REt5nMIkQAjaREUQKO6dm1iGrHpR91VTC7Bqi30?=
 =?us-ascii?Q?9ODM/tBvvXe6nIqU0gg9wZgu79ejf+JMi2m7A9CsviRtgCNCxZNdIUZ4I6gS?=
 =?us-ascii?Q?S7k5zwBdhUZsi+5OUDCzFvUkKsdzUf3WezibzZVXmBJpgou4YvuHCId49XRs?=
 =?us-ascii?Q?ItF/2pXtGZ2vjdWcMnOfvdVhUADM1S+gAacmgJ0T+9gNIE419K3MnjvsfPZh?=
 =?us-ascii?Q?buYUz0TbWbUGBbDaHingxV4iIczmvyk9FyiAlJttKVuEFaSGDPMjrZZ05PzC?=
 =?us-ascii?Q?StQy7PDqocwesfAb9xyurqZU2k1BJjDHCH34MGc5y+H5Q5eUkFBxiiDESy6u?=
 =?us-ascii?Q?6+uB5BfSMlKDmD7++DinH7EGySXvJkQu+0kCr1JK3Td3ezIh78UTFgwAoOSx?=
 =?us-ascii?Q?Y3OpPEGrX0uLZBLI7bkMSJw84JFrQoVLEROHsJzQa+RlF/IjwgjqyyHzMHEx?=
 =?us-ascii?Q?YsvJb1JpFrAb1tHX5Ck3EFwHrZ8gIpW35ue1DITS2dDLxGB+kTEvDy2ARwgn?=
 =?us-ascii?Q?8KrdlG2mKpH95xuhV24/7mpp4raIC7Sgtt6XC7ek0fSDrhNHEliDtmpkWIVN?=
 =?us-ascii?Q?L3VbLhjTHZoBgCgDQ86NgFyG3ZSXV7sijFf9qFg6XndExbWiR9g7ZhsECUVb?=
 =?us-ascii?Q?6yY3r4NSFjc+5oL7QmsVbh8xok9mBQR0BDcFkuYmQ7vpXVZuz1zclLYYyVHK?=
 =?us-ascii?Q?MF0wZbgB+9wMMUf1198nGx1ZLsfke7aNplvyY3UVQTNUozI3O8wWbrPRIzM3?=
 =?us-ascii?Q?ElF08B4TvbYc1kcme9u1l0jHPNy9gQaczXsLyw2yLoPZVCACBD8cx2c7Q5wW?=
 =?us-ascii?Q?PMObMVMoirrsKF3qyqld7rR/8ANsTq7Li2b5qrWFCeo9/1oubMwSQN/eoYU1?=
 =?us-ascii?Q?auF3He3UhyVcQDwG0OQL32cjB1hgNMjvyw8a/Spu84BW0wB6wmFrxuVRSYFe?=
 =?us-ascii?Q?+wHp9NzDew8+QgsfYuseDk4n4SuxRiRwUMJSe549FCR/iK6qmSrFgvV1MKmC?=
 =?us-ascii?Q?pifehCui9Hd1+twtv1knAr/CcApNeAnJP5qh2KZ6vIB4aaZTUEziHdihDB8U?=
 =?us-ascii?Q?rswnrMXD26l9z66qvgiMwTpjJi/e2p24BamOIKKPZ/MV7VnBguZ4rQZUsLy+?=
 =?us-ascii?Q?825vCjL498cEDJu1WEe7sIZnyvRzOOrFsW82kdigJhMfYiuvQs6NSNjMOJDK?=
 =?us-ascii?Q?E/LeuuiYrENi1VfQJKs2fHxQ1YeZFPmH6+72lHCkttrVtSqcG3pX9jG+SQkI?=
 =?us-ascii?Q?+A4YNOPOYBcYTicdQ3jXxvjOe0NfTDlzav8Q84xLEoADV4CKoqKm0cvfXiRC?=
 =?us-ascii?Q?5Gex10g0FieyFoCCGVPChgrfOPq3uwgCyMWOFziT+e38qD10u1Fwo2O+cqWC?=
 =?us-ascii?Q?iCA5Suw=3D=3D?=
X-Microsoft-Antispam-Message-Info: W11xNobabWAj4Jwkn12iKxv3J0AgqTJn0tJlZL0QP9G2teotiMwKfek5BhpUPwY9gPgNFJuGrTP59bcnwl9t0rWc1h1q/5SgTJx3UWShAW2Fvk+DeoOm9RxG9/9+U1OwpZ3nXd3Q2w2GmEbyDBcf/4GjXbIStzZTYyl1YRP41mJhrKsCbIWiwGn34mqwLom3
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:UniwAeyUp77/hyUm1Uc7Uyt1F30Zg2bBoM2SJai/WFTI18frnR3cACukflvpps0vL5pUAtP5p7A581elDObhJUCA2R60hMIE7L3YBDMEUMM/luiS8+oekwLhWadwkddQwZ222/b5iG0W48yRNBoj03lOk89RMqYLcoGhxdtsNaHcnCMPn1wiOHyIxOXfwzuXsM0qTloe4HPTlGuEyzeSUr0jj3adqSBalrIR1XzpQZzH5jdYKvBUOpFrtIqChoAtQzluneAERWZyUurh4p1JszlS9aRb8wJ4ZvrwhOqgmiJzKQNDrO6D2lzCh81XcTlcJed0on+MOs8Jp5uSpjznQsziqVuMVS4g0ZtIsHpJNg23+MmBjNIMVc4rXU6nDTU0DS2vXkzBdzJNjLIZYpu3Rw0jl4VhvksbgjDq9tnYjxQ9w5wp4EyPzc0z2VvBtUuYSYiG5/K9oSrIJa5MMmtPRQ==;5:TP1UiwQU9JK7Cxi1aSEMxRxBRvTPLG7hOn6GrGqbMwMR4sgCowDYGJyuvQcpvv1T+fHiHjxjEyyh3ldOSo0DOnZPV58coWtd8i6RJc+5REugmAnz5cCQHS0f6/mdlu/3ZNQkeQBbL0yMvxMTS/pLELWOLUYLLKZuaToJ5VWep1I=;24:iocNtNnpN9ydfuwd9m1REOHttIf6YXInQJy2xi0KaB9NjyNK3Ds1rzSKmjkvWxunz5hHyYM/Gw2GJwuvHfV2CCbM5xLoY1LnvnyuaHOt+EQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:g2knm2go1m/3koyHuNNowV57HfWdEBPo/hNxqw/th3xDOEqTUTRrONqTjke92HGGa1dC3BirPHa8P/VwUrIulQjKme7SblL5+9lmkXl/epzPhkfhlFN9K5HkE94V9WfZ3gHudxbHg8y0MVjQGylHHX6JVdPOz2ki70DddiucIdrLGYWseffPm0fgysEmqqJKgJcIk3iqao9qKdp4qfV+oNgJT78eujBqYj60uAK51Hd1gg+fDKbrWt1KBDEXsx1O
X-MS-Office365-Filtering-Correlation-Id: e4745068-7fda-4aba-03e5-08d5a0ba7a13
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 21:15:10.9752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4745068-7fda-4aba-03e5-08d5a0ba7a13
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long lines and bad alignment disturbs the reading pleasure.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 5bbf889ad98e..53448b7b7b28 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -443,7 +443,8 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 		ret = regmap_update_bits(max9860->regmap, MAX9860_AUDIOCLKHIGH,
 					 MAX9860_PLL, MAX9860_PLL);
 		if (ret) {
-			dev_err(component->dev, "Failed to enable PLL: %d\n", ret);
+			dev_err(component->dev, "Failed to enable PLL: %d\n",
+				ret);
 			return ret;
 		}
 	}
@@ -515,7 +516,8 @@ static int max9860_set_bias_level(struct snd_soc_component *component,
 		ret = regmap_update_bits(max9860->regmap, MAX9860_PWRMAN,
 					 MAX9860_SHDN, MAX9860_SHDN);
 		if (ret) {
-			dev_err(component->dev, "Failed to remove SHDN: %d\n", ret);
+			dev_err(component->dev, "Failed to remove SHDN: %d\n",
+				ret);
 			return ret;
 		}
 		break;
@@ -698,7 +700,7 @@ static int max9860_probe(struct i2c_client *i2c,
 	pm_runtime_idle(dev);
 
 	ret = devm_snd_soc_register_component(dev, &max9860_component_driver,
-				     &max9860_dai, 1);
+					      &max9860_dai, 1);
 	if (ret) {
 		dev_err(dev, "Failed to register CODEC: %d\n", ret);
 		goto err_pm;
-- 
2.11.0
