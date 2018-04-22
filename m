Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeDVUDG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 16:03:06 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com ([40.107.2.118]:4384
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753472AbeDVUC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 16:02:57 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Subject: Re: [PATCH 3/8] drm: bridge: thc63lvd1024: Add support for LVDS mode
 map
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie
Cc: daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1524130269-32688-1-git-send-email-jacopo+renesas@jmondi.org>
 <1524130269-32688-4-git-send-email-jacopo+renesas@jmondi.org>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <86c2d4c9-8079-9f25-f24a-58c7866a8274@axentia.se>
Date: Sun, 22 Apr 2018 22:02:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524130269-32688-4-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM3PR07CA0116.eurprd07.prod.outlook.com
 (2603:10a6:207:7::26) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:079Q2o5/4WnzUW30gZiCas7bHexoGSSOkeSpD+m3WkI37ejd7QxGGAPelENvQc3ESgcad3jYMx7VRk9ZubNqRT0UN6x7F2XEkG43Uh6v1soAZueVdEb8WBj85Wbmze0ogEg0ubp9xuVCJiDWBsiRod1VxYwpgbejPCF7qRiQalhhve/erv+OeEZbNzOQubf+CYEzinXpxsULodiaQias1u7CMpM1iInv8mCTXebCKo1WAgs5y9IaUWTHc+gd/4D2;25:GQm03Lm2/4CWYzcgqfHS8TPZLAu4peLTJX0qvKU4pc+N3Ju3ECQq8ZnPVrxcH/oiCtTvfvJwOo/CibSiZNAOEzGNe007u2agU8UPpQYl+y1/xhoF8w2ialcotBBL6q5Fjzg+t5mQXu+9qyrMuakAVX2kyWgX/g/Q4ihH/0NNA34Rb2at7jFhMx6x/KZLqr8p6hZoMcBiPhpL167Jt0c4tbKGElxwPCKjyfzprj647vv0r73HzN6cTB85daPvsw3ieGVDKzza16wSyIED+QKJz/ZzEX00Er3CGEw+FceGQFVqTbOMl9RorRx7qr//EUR1BtLbGc2GAoDpIVoyxZiy6Q==;31:fG50RnGdvq59QCMqVeEY5zQnc/DT0DWBuSsxR+NvyTBWYxifYsdKogOsMNhUhICtRjp705ONMNRwfy15b5sdnZ4INfJECfNfatmZHMwLkHB41Plt6JVEPj2lYkN8fAoytMoTIwvGpiwPxAgRyaqk4GnsWBOYZSAGdH5V4Av71lZnnwsS7nA1rUJ9b1RgqzYmaN0P3TA1oU4k8NJ7C9plF9MfYRpgoD/ql3/6TdOy/G0=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782C8BBE3FC37FFA63D1A07BC8A0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:68OISRMsUtaSuaHNcvLOZPV/KQ0QjNqrXpVWmkzdrR2okx9WwIVxoQU8cuFCqt1vDyGq/Mjl6UfgbeUPVNtxii5fHSWmCXVt++YfTnnF1hbL236pbzfI8jbZ28gUaxo6L0av7qRk34UkfY2iUDc7R3F/NeDCZ+nB2nxSF7ZUtqyvBvsgKqlbUUtkkQeOWxs6gogeFEgiKhcw1uV/1d0Jit3zeWfcWfVaVnNgUDvRL0bSXX4T7c/Ok5itOzLof/+k2Gr6UysuB0w993wJ9mebpg==
X-Forefront-PRVS: 0650714AAA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(366004)(377424004)(7416002)(8936002)(31686004)(36916002)(6116002)(3846002)(53546011)(4326008)(52116002)(2486003)(386003)(478600001)(52146003)(186003)(81166006)(11346002)(446003)(8676002)(23676004)(66066001)(956004)(2616005)(2906002)(229853002)(31696002)(230700001)(16526019)(76176011)(6246003)(53936002)(305945005)(50466002)(6486002)(476003)(74482002)(47776003)(7736002)(77096007)(6666003)(36756003)(86362001)(65826007)(26005)(25786009)(3260700006)(316002)(117156002)(16576012)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODI7MjM6ZDVOa0dxQjdnbldVSFZaQkxJR3BHRkc3?=
 =?utf-8?B?NU5hNGEwOGYwTU51SHBudllpOWlDeXE3aURGSDZQRXhiRnljdW9yc2ZRaSti?=
 =?utf-8?B?YVFOMDV1V1E2MUNzNEZDckN3d1E1WjFVUnlya2l0M2U1ZmJ4U2g0TTRGRW5E?=
 =?utf-8?B?dEI4MWt4c0FtQlRZRGNneXZraXlwRWplWHNnNkt5RjIwT0xaZEJNRm1xbjl6?=
 =?utf-8?B?OElUbWQrbkVqWTJqSHJBNVhjZDI3TWt0K1NKL2haV2lseEdlLzMvOEV1K0k4?=
 =?utf-8?B?bm40RlVKL2E1OWJUV0pBMzhMVTFNcFhHYWU5cThLZG9YL3N5NzArWVBEb1JM?=
 =?utf-8?B?cHhoVStkTm1Ha2JVeUQxWTVRcEtIWERuWUV2ZVhhdStLRFJhNjBpb2JYVVF0?=
 =?utf-8?B?S3lzZ0tmRFJSb1lQTnRGTU9PWEZkNDhRVlZqd1RseHQxU3BLMCtGQUVDZ0xE?=
 =?utf-8?B?OTJreFpjMnVGV1hjcWR2Rnl4Y1pmeFZ0Tk1kOGpxVDN6MFRLaUpja0N2WlpO?=
 =?utf-8?B?aGRYd1VwWjBKblFCZlhCWGxnbTBEN0tNRHRPM1RuMi9xNzlUWE1UL01RbTcz?=
 =?utf-8?B?bHpCR2RpaC9ERmhWU0dLWjI2VzNiNXpMTHhXTXVvUTE1RENlL0lFdXVZblZr?=
 =?utf-8?B?UU0zOFRrM21wS01nR3ExaHlHL2J5emtoRWFLZXgrTkErRk5Ya3VCQVlJNHNr?=
 =?utf-8?B?dXNnRmR2Q3Y5Q2tnS2V4SzBkT1BxOWgza3JCUStnVFNFcllaY1FlaFUrZ2ZV?=
 =?utf-8?B?WkNvdGRkTktiLzRmQXVPNW5oT3hwa2tNTFJPKy9FYkJ3ZnIzNkdkclRDV2RX?=
 =?utf-8?B?YnlNRUJmNkNoK2Rya0xyU1BybVFXUlBFWm5FRExyMlZkMmh1a0hUY29jTi8x?=
 =?utf-8?B?SmxSTTFHd2FmRzY5c3lyK1VHWVBNTGQvRnJJNmhXMy9SdTRTUXRTaENnanFU?=
 =?utf-8?B?cHBlbzRLTEllbTBQQm5xMGNTYXpWU3c2OEl4dWFwTnV5ZjduVmNrRHBmU3lX?=
 =?utf-8?B?QWY5OGVpSWJxZjFmZlJNTnJGMStVaW9LeHRBa3E2T3RjSlNJbUtPdFRJVmxw?=
 =?utf-8?B?SE5TRTdEdnBESmJnKzgwajl0UFpEQ0pzcjlEdjNrbmJobm9MR0hBSjVHZEx0?=
 =?utf-8?B?UjBZeHVtd1JBQlZSelJZSXFWUVJya3I3cHpreDRBakQ2cWNFSW9GNlU3cDhK?=
 =?utf-8?B?NjdJNkd3OXFmY2d0MXNqZFduVXlpdSs1M1paMjFwWUQ5S1dHM3dtbGprTTU5?=
 =?utf-8?B?NnRrWWhjWTEzbktrZ0xSd1FrNTI1a2F0ekF3UHJidlNIWnlYVWYrYWROTFN0?=
 =?utf-8?B?TWZFQS80VU1NUmJHQVhYbFBqVmVGSlpXcWp5bVRzdUw1L1ZPcUxyc2tuUS9Z?=
 =?utf-8?B?WkE1QksrNW43MWpETkZuZHpqQWJ2djgzOWUycHlIcXpUcm5nc0s4TXJkQXJ4?=
 =?utf-8?B?MDNpV1dVUkdWaXFLUHJ0ajNwckNZS1RyNlcrMDhUL2dUTEhmSTRDZFN5U1da?=
 =?utf-8?B?V0FkZHc1bmVid01uRXFEL3JDK2tZSDFYOG9NTmo2cis1YzV6eVV6cnV5S3J1?=
 =?utf-8?B?SHVyVXQ3TWk4V2VESGJkc3NSUVY1YVJLM2NpMG91Z1JKMFpoMzFab1VKWk1a?=
 =?utf-8?B?NXBZWWRrcE9RMGZwTjY1M1ZyaWFoU3VTS3V2Z281QjAvVE50SUR5d3ZmTjQy?=
 =?utf-8?Q?V+0TID/aCBjukwBkOg4I=3D?=
X-Microsoft-Antispam-Message-Info: m9Kd1c75Z0Zb2ARmxzoTRYfzSir9JDrQUbQa8KMkkRL9wzAyz7C/wlP1qWx7DBGHT0gM97kOo42JH10sOV6hIGGwK6AnGV7Jvm7SWx7fUDr+BdyPpI2cs2eTt4kmChihOHpGjKhG4uocXdVjHkAo+CUl2qWDc2z92fjvZMtQxqO8f+MCvtxr+/mOuC5ZBzN6
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:F5doBMaTaghhcnxHoin8Kdir5RUoLbNeXjPAV9xTxncjN7vci8EVjrAJaqeM2jiRlFEswDmC+tuQjLW95nbnsuKqJoP4XusaeKlzsaYT2Lbm4myqgD4VKlngWgPn1BvQErMuVb7v4HciNqt5g7aDtZQDWhF5S5Qs84kxpc0JOCvc/NMWAR5YFYsdJDsG3jc1pLJ1jKgcSY4r7LMfopBreD5YxEpbVdSP2nwmqmG/ACaXH6GqfKVD3bK4eYu1caDwNxbv061jZLd80MleUQB7tQzl7NUsRQzE/zzBkZh8EudIidB9b31i4iJyjiTihGsjG0KBcoGvOg1yLF7JpacI1ehE6Mbg34cAo+65YZElXu3+lGBlEJYJydjivMUfLWPElu13VMG435sXdnBKxXKLE1VjqxvcHr6nUfg6FFW+SEyAdMIVoMtZddKz4Tg2aG/cif5WBxH5k4N4NJbjyBI0+A==;5:kD6U5YxZCGn78udaXe/GH8RSy9EHSjaFwPcLkDZKpAF/drtqnIz63d02KhLhuWZROwP3DMkfWgvYqHUdLNj5katgLpzIb0GDz9G4wlTkxSe4jsxGS/wvxCFPCvik5lKKNWA9tOFYRcs76K/n3/9FQx74ketYyFD5rGnID2VqR8s=;24:eRGshKFNYqpvLq/pQtwHaByE7KbQ7pMDFOw305RdWS7LOJFXwY1vGMqzeM7h9ZMwQYWHlvnTunxKLhSJWM4vCA0C9E02mExmCsejLEmUR/Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:b6kySnZ/Yqrn3GFr2K42s6SS/ivgWMgd+VKiI3A7mfR9iOh60+aLL4n9vgcfmLNklO62Xjb+RUkYcW0a+A9KMFsfub5ihlKGJd5Pw9+OoKWUAECwP4Sqre8qizn6neKQoJ1cAnAsY1eHnQnkwuM0HlMxalXj79w7mJXofhAD7zX4jtAZpW+qWwXD6QDSTgB5sDid+Q6ayxWfa1A3fnI5uRZwDFNmPJrWEQlb8nRtOwmxIRDsJvCfdVis1OG4PXuY
X-MS-Office365-Filtering-Correlation-Id: eae056d0-6f1c-4b66-1657-08d5a88c0972
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2018 20:02:54.0465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae056d0-6f1c-4b66-1657-08d5a88c0972
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-19 11:31, Jacopo Mondi wrote:
> The THC63LVD1024 LVDS to RGB bridge supports two different LVDS mapping
> modes, selectable by means of an external pin.
> 
> Add support for configurable LVDS input mapping modes, using the newly
> introduced support for bridge input image formats.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
> index 48527f8..a3071a1 100644
> --- a/drivers/gpu/drm/bridge/thc63lvd1024.c
> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> @@ -10,9 +10,15 @@
>  #include <drm/drm_panel.h>
>  
>  #include <linux/gpio/consumer.h>
> +#include <linux/of.h>
>  #include <linux/of_graph.h>
>  #include <linux/regulator/consumer.h>
>  
> +enum thc63_lvds_mapping_mode {
> +	THC63_LVDS_MAP_MODE2,
> +	THC63_LVDS_MAP_MODE1,
> +};
> +
>  enum thc63_ports {
>  	THC63_LVDS_IN0,
>  	THC63_LVDS_IN1,
> @@ -116,6 +122,37 @@ static int thc63_parse_dt(struct thc63_dev *thc63)
>  	return 0;
>  }
>  
> +static int thc63_set_bus_fmt(struct thc63_dev *thc63)
> +{
> +	u32 bus_fmt;
> +	u32 map;
> +	int ret;
> +
> +	ret = of_property_read_u32(thc63->dev->of_node, "thine,map", &map);
> +	if (ret) {
> +		dev_err(thc63->dev,
> +			"Unable to parse property \"thine,map\": %d\n", ret);
> +		return ret;
> +	}
> +
> +	switch (map) {
> +	case THC63_LVDS_MAP_MODE1:
> +		bus_fmt = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
> +		break;
> +	case THC63_LVDS_MAP_MODE2:
> +		bus_fmt = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;

Why do you assume rgb888/1x7x4 here? It might as well be rgb666/1x7x3
or rgb101010/1x7x5, no?

Cheers,
Peter

> +		break;
> +	default:
> +		dev_err(thc63->dev,
> +			"Invalid value for property \"thine,map\": %u\n", map);
> +		return -EINVAL;
> +	}
> +
> +	drm_bridge_set_bus_formats(&thc63->bridge, &bus_fmt, 1);
> +
> +	return 0;
> +}
> +
>  static int thc63_gpio_init(struct thc63_dev *thc63)
>  {
>  	thc63->oe = devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
> @@ -166,6 +203,10 @@ static int thc63_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = thc63_set_bus_fmt(thc63);
> +	if (ret)
> +		return ret;
> +
>  	thc63->bridge.driver_private = thc63;
>  	thc63->bridge.of_node = pdev->dev.of_node;
>  	thc63->bridge.funcs = &thc63_bridge_func;
> 
