Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeD3LOZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:14:25 -0400
Received: from mail-he1eur01on0136.outbound.protection.outlook.com ([104.47.0.136]:21376
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751513AbeD3LOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:14:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 22/24] drm/bridge: remove the .of_node member
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
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
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
References: <20180426223139.16740-23-peda@axentia.se>
 <201804281608.Iji1Keed%fengguang.wu@intel.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <f5f99e99-1174-6ee0-c097-e1a9d4d5a62a@axentia.se>
Date: Mon, 30 Apr 2018 13:14:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804281608.Iji1Keed%fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0250.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::26) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:QbKD30JMhM3PlBxVlNkxqT3zWrtyc3b2E8UWFqol3fMFAuS4Z6u8CAQv9pP++oCtweKgCa+DgnBzJF/PoddbsL4CYjc3wORbyPx+3Lv3W5frEQjwC/x3gjS2fF2XwOyL/tyrNceaIAZqLXN319tGWaaOSChXoCZA4xE9SlTe9bZvWbbAx4qUEaP4F5l2qBWvplrv7B92nz6agBkRmmYEI4q7KdJhjRgyF3iuq+92LwM38LrJfCsnJDbQMJwyvq2F;25:0A0Q7SvBi3hsr9R/eTfmBB/vs1Ld61sfo5uW9rgJ3P95b0MXCCUUB0p7xHstTeBSdpuir3Giq4GfplrXMemf/6AGtThw5cV1Zp3Ug8oFXdJz4oK152WsGBh5j391r9I7nJjLVujs0i/PfrEU1CKXaEIZ6DZomX8hrqkapcHQFUYfYrx+unKaINkBqN+xxkSHLtoMl0JHJwGF9kNQq2DR5KPO4Mg06q2YnWVZ8U4AJWyQwxOP9O0vxoqw7d6hwqvceEzCRjhdoJZ+WjWkueJws/q8bvKzTkNfVXfg529986tHFiNsh5S4S+OPiUJScAxCHOEoItjuSAhyrl0UEpDtUw==;31:s54jsIx+tcb5rz/sCAZjfh9bg1gqrLofSH4NXiuswG9TkCCzr427WiddJ2m7jxyIUhhgz93pPj8LsiVTra3vYCovFzlx6mPS40vfZIwVB5UdayK+F5KMbRtJGCo4t3UZ0aZJiAf2/sBFLHZtdpNRYOPenABKshElbscDbLnamxnc9A31PMrFsGBYsZ3oAveqDld6l2Cgp0jjOhkcXZFIOjUPJGxJhFRpWCzvfaEw1ws=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770375D5BA6DA40FCDC67D3BC820@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(275740015457677);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:kkMJ2AX56izU3g0GlfJRzueS3WcnYLERm4kZmq6Y/MEheMMjbTmU1zTd1VCi5NokmKBThqtE+CCq4zaIk9NJbg4h9Tw8SJznTy17jNfH6q0lWMmUq312VWMNl9vwMOTnFYPYltvamLMkuo3807DSn8cjGUxfQDrDypQtrFbNLVj6iENvDkorBPhmWdaM9XTsMcTctmZhoJIv6BXSRsObv/oIJMoWJn6uDQBvb30a+10WqnTp3+4zBZY8BhQGDKKb5gWBfl4OesCdvDCyyiygc8UZS/DCu5qD6b87h3NZu7Z/2WSwg3qCcC7ELCwaxDUOxK9LwbeJQxz6rtDxteFFn8po11qT5IUUx09JRO04NtA=
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39830400003)(396003)(39380400002)(376002)(366004)(199004)(377424004)(189003)(6116002)(25786009)(6916009)(81156014)(6666003)(36756003)(50466002)(2906002)(230700001)(11346002)(26005)(386003)(3260700006)(446003)(117156002)(229853002)(8676002)(2616005)(65956001)(3846002)(76176011)(81166006)(86362001)(64126003)(65806001)(8936002)(478600001)(6306002)(486006)(4326008)(476003)(66066001)(966005)(31696002)(105586002)(186003)(316002)(16576012)(97736004)(54906003)(16526019)(106356001)(6246003)(7406005)(575784001)(58126008)(31686004)(47776003)(5890100001)(52116002)(65826007)(5660300001)(39060400002)(23676004)(74482002)(36916002)(77096007)(68736007)(53936002)(305945005)(7736002)(53546011)(6486002)(7416002)(956004)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6bkxhRHcvVHNyd3ZXNDJ1ZjRGUWQyVU9Q?=
 =?utf-8?B?ei9NS2YxV1A4d3dxVDNTS1JRMmw3REVpL2poK1NwaU42MzFuTEJFUThFVFhE?=
 =?utf-8?B?bCszaXRhUG1CNlFJdmgxb3lUd0dJdENwY01SSnV1OGNQcmR4TzQzYkNtUFpY?=
 =?utf-8?B?WHdBZHBqVjRmMVV2M3pDSVBPMnZUM0F0Zm9Wc24zVVhiQ1JCVVMwSmp0Ry9w?=
 =?utf-8?B?Y203L0hJcXZ2bklhQ2VqdzU4eU1tSkZOUnRkT3FJS3YzVWFPTWdPR252Tjcr?=
 =?utf-8?B?dEliUGUvZmY3SmlXMXBuTUpmdjREVXJVWmNmV2w1UGIzNUNsN0lyTWxWaktR?=
 =?utf-8?B?dVB1b1BOOUV5MDZUV1BSZGhibG1uZmpHRDluWTlDMUNFSnk3eDBZN2t3bkNF?=
 =?utf-8?B?aHFwVmxKR1dNdUdXM2VUa1RnT2NMYkUrWktKMmJPZ2Z5S1VXc1FseHdGM0k0?=
 =?utf-8?B?dTMxRlZtajEzNDEzRTI2b0lFekVNaXc2bWtxb0JSaldiVE9lMEdxVXJtdEpt?=
 =?utf-8?B?cGczM0xnMFJ2UVl3K0x6VnpGUUFvKzVBeHVHRDFiU3dLOFd4TUVVaW5IbVhQ?=
 =?utf-8?B?NXNGMURZMWNBU3czOEJPUDB3Um5hWDNpa1lXcWtud1Nhem1vTjlYU2xnT0JL?=
 =?utf-8?B?T2YreFJDTnp6Tzcvb2pBZXYyTzdZYjJQMDlxeDN2NkswMUxMSGQwOFJWTmF5?=
 =?utf-8?B?ZkVDN0NjU0xVa2syQXZDZ2duR2NFbUwyQi9wdUowbllHYWVOY2dRTnM0YzFL?=
 =?utf-8?B?VW9ES2pFblUxY29FbmJadGlpRG11MlhxaG5aK2lCRldjWWVld1pZRVZVUE1M?=
 =?utf-8?B?VWtaV1dMRmQzc0toNTZLQmsrd09JRWdIR2htb0dtVjcydTRUVmdoV2twdEtx?=
 =?utf-8?B?cjlyczV2WmpxcHFJdVkrcDZHNHRTNUdHVnJjSHNJVDd5aGRSV3FJOHJGSDhM?=
 =?utf-8?B?bFJPd203VVh5TW1qbjR1L3Q1dWIrYmFSSTZ5b01taFQvS1QyQU00QUt4enV0?=
 =?utf-8?B?OEZZL1NWb3MxV1k5d1FvN2dtUDE0Ym9jMXQvbjJRNjZucXhTUXNNZlRIY1hK?=
 =?utf-8?B?OUhNeEVnb1hCN005ODh3UXR0OVYyQ0tnSVlPd01keFBEVjM0NEgzNzVHUjZX?=
 =?utf-8?B?R2R2bUJoTVM0blVGYjZXcWxNMjFvdFIwcU9lRDQyMmRVSVgxRHhGOWhrUElh?=
 =?utf-8?B?RnFoRGl0TWxLeUk4LzJXbFl3bzQzQzExYzJLeHhXV2FOR2V5ZTdDWjdPSmZS?=
 =?utf-8?B?VmM0WURpTmQ4NnVmT0ZuVUVzRjRpRGM5dm5xbmZTUzlBanMxUjNZWUFISVE5?=
 =?utf-8?B?TU84enp0SHViVlVmeEk2RWdFc2RodWVsMW00MUJhREJPYU5INkZCeTJOOHVN?=
 =?utf-8?B?WDhWQnROSk9leUozUmlpVVBtSitubHVPTDFVWktzcnYraFUzL0VCQWNGelho?=
 =?utf-8?B?cUFKbjNaWHhkQ01SM3JXVWZzK25ZeVUrSWt3UlROK1Vib2g5WjJvUVZlOHNT?=
 =?utf-8?B?anRQVFdzQTE2SHBOQ1RuUithVjR6OFBZVUsxTWhsZXF0anlhN1hXUGJReC95?=
 =?utf-8?B?UnYvczBIUERVeFRaMGRPRitlOHA1cUJqZFBSck5Ldzk0c3ZSWUxQeUU1Z2Z1?=
 =?utf-8?B?OWJhbFc1ZktxWGtHeU1kM1A1RFBWdjI5clpkc0h0Umo2NmhCSTlwVEdMNEdC?=
 =?utf-8?B?NG9MdXkyOVgyQW03TUZaWURSM1VMWWZJL1FDaUpuL3YxeXBlZTFjUlJKVTQv?=
 =?utf-8?B?NEVlV1FvRldoQ1F4MUpVNEJLNTNjMDU5UVk1a1dLN2s3eWR6MGVid0RucnlM?=
 =?utf-8?B?U3FEVFhtQ2o3UEZGc1oxd2FyeVZ3Sm5mblZrbmE0em9iRlBxNkplWkRzRHpo?=
 =?utf-8?B?UysxM2RubmdGY05leWxISmMraEpoQkJzSVUwQ3YyZzREZldTbHFmMTBkSXJO?=
 =?utf-8?B?bFg2ZWFqdTRQakpFN0pvZzBiS2Z4VkhQQ3ZNSW96Vk9NbmlIOFhXd3pFMmVC?=
 =?utf-8?B?QkR5dVFwcnN6RWRIdmpNQ2NmZzFMaDVPWUYrK0J3dGdBV3hSdlZ2dGwvUUFa?=
 =?utf-8?B?S05nVlk1V2hnL25RbG53UnBaY2FhYzdBWDJRcDdndVUvU0g3OGp6a1lqeVZT?=
 =?utf-8?B?aDJoV3J4Z25VanVVM1Vmb01QZVRLRFkvb2Zsb2pjcUxDZEpkelQrZU1yL2Vh?=
 =?utf-8?B?ZWZtQVZWemZBUmJBUGN2azFwRFYzL2ZxTWZLOFZaZ2IraXNWbEZKMVcwcEZM?=
 =?utf-8?B?Y3lXNmZvVHIzSU1OUjlna0QzSXdUb2t3V1FvYS9NdityUDhIQVBqR29DYXRE?=
 =?utf-8?Q?5PBHhaJUz+Qd42kGF0=3D?=
X-Microsoft-Antispam-Message-Info: MMynA7tBPulPP4j8hTvQxUh2RXCzLxe0WoQDkG/39ydkJ5sO3oYKWnrUsrgJI8VuntqY7hNAV5gjZ/fIJLojOnFFJB1d5d14fLBoDKgwguLiNoZlUVPDT+BDxhrUiwF5pEYYvHrVbvjwkq4z1jTrTnMdz1OhMHSa7Hf5F6eomVtet/ZE/8QAIGjOypqE0hsA
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:MZhFb2Ja++6EfHv57q0x1gW2VxHopBLucVOJ8d/f+Jqsht/jtR05m/phpLYPD8JLnqQ8Jre/Q+lUYtjTVeQ+Lck3smyCDmlny013JHbFTPmU4QLDSQSEOtnIQLTi8ZMnYHapP1/PCoR9RodxdCAWn8XLKgbbv2GbwQJRgcSZRt+yA4egcVYeTmjwIj2qP7BDCZohyoDe+bjnl+7i4Nst9y1o0a2TwAAgzGbm024PqeQESXf2REEbbee8oS5+Cvo5VvwE6QYZ8A85OldDoBNFwwtadUDqZMKsZKiX3MG14h9s4TIU+/osVzg5IpiRf1xDeO1RZJ3ByxG7jr7NhiD85YKA+luTKncCHzhdCKXjljCcm8WOenLa+qtQ0s1pZ1pRy9+6W+uCQZvIsRzrGRFozxTTaQu/MOZ7GXQMS1MBQziXZhZA+VqxazFag3m8iVxbjVnYFVLHmwOp+RCdZ150bg==;5:5NIzuSF5/NGkz79xPBdkqb+OYwczt0vgGtO6wrdzYQfRumngkkeGgEr97bESGqqapY196833w9ITkbygQ8ScMGbQdqRnw1gGLi9OPsDfAI6CMrq1dRlUkh7aeLGejyErDjwZLvFi9yvjUcEnwrQ0az5s3KZQpHZt0bSzyc3ZpNY=;24:dlYZ9RsREaDyh+SDqu4rkhKRIHrtBdhtLmWPncvqdvdmwz0ChOpfIbNOy1vsaHfQekub9h5h0K8PAO4Svrx/4mjadvBpVwasRzdJlTKQ8no=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:mxrJh4S7IQCs90ah7m/OaA1k8hSQhJ95lt0dHhANTIYuedGhTda4TVxhlgZozQBm5KchXUXxJNdzgtu4j68pDcgAY7WLBV2u669IUBwKyU38mID0IZan0g68raYMrO/fafjIk0Ye27LXA1786qTJDlZ3iaqUFj8m5J0BbdY+RpDv2KWlZ/LEgui0kB8fUJ245iUUcU3vOrbRZ9MQ54R+O8eVk7/qoViVjwUe21a0e5gTLacdL5DEuH8Gif+HxKjO
X-MS-Office365-Filtering-Correlation-Id: e17e51cf-992a-412b-3e2a-08d5ae8b81b4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 11:14:11.4470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17e51cf-992a-412b-3e2a-08d5ae8b81b4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-28 10:09, kbuild test robot wrote:
> Hi Peter,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on v4.17-rc2]
> [also build test ERROR on next-20180426]
> [cannot apply to drm/drm-next robclark/msm-next drm-exynos/exynos-drm/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/device-link-bridge-supplier-drm-device/20180428-135229
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/gpu//drm/rockchip/rockchip_lvds.c: In function 'rockchip_lvds_bind':
>>> drivers/gpu//drm/rockchip/rockchip_lvds.c:381:24: error: 'struct drm_bridge' has no member named 'of_node'
>       remote = lvds->bridge->of_node;
>                            ^~
> 
> vim +381 drivers/gpu//drm/rockchip/rockchip_lvds.c

Ugh.

So, patch 1/24 needs to be amended with this

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index e67f4ea28c0e..3f33034b3f58 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -377,8 +377,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
        }
        if (lvds->panel)
                remote = lvds->panel->dev->of_node;
-       else
+       else if (lvds->bridge->of_node)
                remote = lvds->bridge->of_node;
+       else
+               remote = lvds->bridge->owner->of_node;
        if (of_property_read_string(dev->of_node, "rockchip,output", &name))
                /* default set it as output rgb */
                lvds->output = DISPLAY_OUTPUT_RGB;


and patch 22/24 with this

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 3f33034b3f58..8c82fa647536 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -377,8 +377,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
        }
        if (lvds->panel)
                remote = lvds->panel->dev->of_node;
-       else if (lvds->bridge->of_node)
-               remote = lvds->bridge->of_node;
        else
                remote = lvds->bridge->owner->of_node;
        if (of_property_read_string(dev->of_node, "rockchip,output", &name))


But that is of course just a stop-gap. The real fix is to adapt to the
"drm: bridge: Add support for static image formats​" series from Jacopo.
But that's orthogonal.

Cheers,
Peter
