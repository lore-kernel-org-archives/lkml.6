Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754727AbeDTKtx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:49:53 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com ([104.47.0.96]:6304
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754555AbeDTKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:49:49 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180419162751.25223-8-peda@axentia.se>
 <201804201731.D3OnDg0p%fengguang.wu@intel.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4e9bd91c-6b29-cdd2-9e1d-1728311ddb81@axentia.se>
Date: Fri, 20 Apr 2018 12:49:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804201731.D3OnDg0p%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0045.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::13) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:kAH8YziHAvZhEcmASbTkd81jfJYoqooHHuqkRj0XEYTD82ARPcgBeA0O6jMmKK65Ox03ySL4jToOVxn4d66Y3nMJg7nWmySpZKkdJY6h0Y9XnqCFadqbaaMWKYkY2/PFiyPIbSAIz96B8lcZOmnBzEDDC3xdoiCZypdA64Lb0nXYJpLE460Uw0ZKzJOWJXrasfCF9nJDCuLhLEndvna3imoQP3+uue7mhYONolQyPkk/FzUeCfsOD6r7RxGoBCJU;25:IZKwzgzV+Rc4ypnn/A5C/Xqu35G92657SCVHFqJJKU16XMQQm3LZJkiLL3p8kqcy8G8egosH1jnJ7GaaNZtJGVJxHURaV5vbAETorLntLevUdfjrE/+7Erq7HaPVKZra49qQpks6kHEeGuEwmYDUoh+dsRDMy/tr7clHy6HvXABtIH4SPMSdPpKuwffwaIy/bZQ5ELp0RC37OTlTZpNGd4nXQAYc10xtdXnVIOGaOsuvuoQj7GUBH0aKxciw9o6pfyURWlQuVpbgqnfij4OZo+Yfxr7wFs6UFv2v9QYQUaXTc+XSD1iaGVmnpQ1U9n9t3jn9SrOttd4J1emuysm7IQ==;31:0HhkirN9Vh7aV/lx3sRfm4kOERnU99vt2MV5XGb63LoRQxJnF6774fem7mCuQAwGJ2Isoq2lDYM19dAxJAbZkZiP4+AkkGwgdTBkqjMyA3WoNYjdkV6dT5isQSiPTqZwAVMWW1OyK1b98bBiVRfL3XCO2zTw2EgYzZ3lSkzWZglNL/SKfI9r4+snDTQFOOwinwcO5BgHuV3meWpxoHysk8f8A/7+Jg9FI5BQPnNjELk=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775D55B82BD953B19222715BCB40@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501393)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:jLezG+YCn+6E2dpICIhBiiYqH/JZL67RyodHkkOZSIC07HV64uK4+3fYNaK7mmScdcMrqQqf1KfZ4TZ48f9rRE+UXZVjOZ+bUK01lWwB9uMoPeqVxEQc8re+evQDoVEarRdYz7syjl0EiUPUHbzWmQb4m/zI8HRqGyfN/r8Y57eXpMO++Q+c5ePYDz4oyIDTC8WRARNQU20Nz6smiY8arxPKNYuaIRN8IAEFNjw1Ps+Uoyuzg0wbGodPZoXEpzDsXhSQo6UDg7eT7s92aTVeV3mIBAo6Ke8dfS/ujmazjAig09C5DyERs442ssZXuRZc
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39380400002)(376002)(39840400004)(377424004)(7736002)(86362001)(4326008)(305945005)(6916009)(229853002)(31686004)(36756003)(65826007)(3846002)(6116002)(6666003)(966005)(8676002)(81166006)(5660300001)(6486002)(53936002)(230700001)(478600001)(2906002)(6246003)(31696002)(6306002)(53546011)(8936002)(7416002)(74482002)(316002)(16576012)(54906003)(186003)(36916002)(23746002)(446003)(52116002)(50466002)(76176011)(386003)(3260700006)(77096007)(476003)(2616005)(956004)(25786009)(5890100001)(16526019)(66066001)(26005)(11346002)(47776003)(117156002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DB6PR0202MB2775;23:DOwmLakcF645qJu/wwirXoH79Hct6k4Imrz?=
 =?Windows-1252?Q?CKxeTPdEKBS2YJ03SrEsGH6SH4Y7pjP7VFjzZn3i77Tw7Bu2aPY5h5tx?=
 =?Windows-1252?Q?nrX0y5+3gK+QMjeyO3Xal3F+JD3d3FShdIhUHNbj+fvzudvlmuIi0Kez?=
 =?Windows-1252?Q?LrL13orbjLlbqgf9jofCpSoDZAi72yH4UAYcEne1kpCCY93edmAXfWoD?=
 =?Windows-1252?Q?mPz0d4q2wOlCUnQ+06l1C/OY0UFenONGvpnjSblFt95j/EutuOSQe3AM?=
 =?Windows-1252?Q?z9tnrji0e7fXSbpQtQp8SU4jEB5kxea+gkjmBn0tyDUTqmZeQbJWNyd/?=
 =?Windows-1252?Q?yMPfH24dwe6YTXmcChaBDBRUR7ncDBbawg6sUoa8QyK8nnt334nHKgMK?=
 =?Windows-1252?Q?Yfee+PYbMna+7UIesGA416WF1BH3LztCS/skQBjkoEgX6Ctn+EdCxceE?=
 =?Windows-1252?Q?RbMbD9CC3wVScXNPbjeGuFYXk7doLHfOPI8Hq2L7qETmZz+BrXgmH/bp?=
 =?Windows-1252?Q?JLag5BanFX5017kPXr+XS+OcPxmoQzip6ocjNZ+nQKkVPaaECf/OHHjk?=
 =?Windows-1252?Q?hdD6gdwb2nXSM8yBVOJgaOrtAqOxKxeZeClyT8+I6PTB9s/C373g9tRe?=
 =?Windows-1252?Q?1DOGgRSRPvq9bkYWoNNAkMVgK1CHQAo1fNobRm6wkJQdAM8Cz4SLb7nJ?=
 =?Windows-1252?Q?SQiy7Jql4Ol4DTA6f/URm1EMEozgpuOeW70/zKAQkUATxtKcf7BxpuEs?=
 =?Windows-1252?Q?VuA8a86GK3lJzFxRX48T75GBl9hVVHFTDoAUlg6yRF/Wm9rHfbqB4GYe?=
 =?Windows-1252?Q?DUFeOnv2pJcWw+ZgChkDPurMGuYYi6O1hpQun3SJZhHeswLq0Zrbt5NT?=
 =?Windows-1252?Q?momZBIjerek2CY5MN742wuF+OzQBxWIBGYh+C5cPtebYTLuxfiUYeOKK?=
 =?Windows-1252?Q?Qw7uUXL5jgJw/ygQQWuCwAAe5fBjj4B3XLl0XM6nCHuSTVWauS5BIi5b?=
 =?Windows-1252?Q?/84fqypuVhCc20j2ffULDSazmmz1r1s95XYYDV8085mW3KFq+HpMsLCP?=
 =?Windows-1252?Q?DRV4NENFg3RGF75PhNIftlaVRvTkTTiZCDHB2wjIBKrsKx5u1OWv8jde?=
 =?Windows-1252?Q?kGgKE24U+OF81ZJkz9D5Xv4ETgEEpOp++f57mAY4ABSyhDszNgVxHGCC?=
 =?Windows-1252?Q?bxHZuVufgu1uKGklk1cLPX8qZ2gCVes8J1eMkajtuvqwm56NWmZjUMjf?=
 =?Windows-1252?Q?anD1d0uG3L69U8PI/C3JiQxYqmfKy1xlrxUqcCPJA9x5t4khMsRgnw/s?=
 =?Windows-1252?Q?jCVeV+fDFDjoomQA8175ca30zZauyTE00f5qSHJGnuGEwxb8G8SQd2+h?=
 =?Windows-1252?Q?CJBVfdfqcpauFLceEFCCrjyTwbsGCb+n5nUU95BLUpaEX9d26BXLMcYW?=
 =?Windows-1252?Q?ar+Mir3DPswdlooZBVP/tYt4Tq/RaWiGCLKNhBDtoyw=3D=3D?=
X-Microsoft-Antispam-Message-Info: o0jkHz7f+FTQ711fOkYN1cyrjBIiv7K6WdNuwQCoNzQp61Z9MDLpGHfjL2OEjUA6CuMxDZKUAVtZBUPQWhWn9hJ0UP74aYl2Dbt3XC2KIQPBfUh0dsLqTVfyxKlsd1CmdXh/RsCoJ9qDmX41aSQQYPaW3tMR9Js+rsctZXnMkQ52sbsHrndql7fsZdBHLEgN
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:hLJLbubUMn+HJJFtxwqNJM/LrE5du6yiEoUwpjWzQAccdBG99b9lMbo2Wi5aXNjZUSevuFBRLTxC7zCuT0MqsC8qVrPh6pdGjuIUZsIBLgAIoRHbTY3MZREm8DnjSPH0cbfJ9vnXSsVsR5SokVwKMnj28Evie3EEdl260U5eissrNofD64JLOzVEqRg6PjFweXfwaW5TyfDZbZzNcyiC9zSa6YS5Skut6eIMkB/UcIRbxS+U3hg0SdIE6ej9O80cdbbHolpKSYBgxR4H/2+WrLgC/PmT2VJWOJyKn+LVSkmY90x69K/vloYrvMfF/LVSvPsplfuRKHDvW3KD4Z3ZyRvqMsb9BV1Jxr91iMWLbhquYs8YFdTTxjuiwxanM3+9aou47nswo9SMfUb773N9ESuWGCBOcURrF15I5UTBOnTOD1TtXCkJyyM7WlJ13cPxgfd432cbW+XT/+pxwniZvw==;5:dh1Q40OtdIYbkk3uMYY/GIBOG1VyvQe+lZtyD7mQjfiDvK3zKquDD+dESCEPsfmpd/xcbGKFzAaDyQJgn8ELW3dVkCxmC/1w3pgHOr/ZqSKcGAIP2CQnfIhgIcfIg1AhrvTsrJp7PuTwKy0+iPzcTRdbrUG3VFsRpkvDAsdT+9o=;24:XXkMv2HGTJYN+YVsE2jMnO9zgBAS3VwUE1gWfnyX49ZYjblPYz+HRZKGAaQOqFeeKpTNPGim+1eaU9+jWHXpab9PChUPu+MPsCgfyqohyJ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:Eg3DUkdLhAsFD4FUQmCrWA4EZTRNDrHgID41bv42VXQdIOgsOhV3sMHObYPEKicucgRMjiNALWmK6SsdfmVCAOhi6Zo2W4hE528wTeC3ZTQUHYMUJ8Q7AuiMCjBhn2igqn2ASfsguf/qilM9d1QK10L6SYTo3McDdh+5P6mTN26eKdMGLykU3SH58x5QQ+gFCqKdPn+l1YXrPQuB7wkSnW3x5bqrwWU9EiQRx58O0r8/dTcx7zdiYCZJeziwbTpe
X-MS-Office365-Filtering-Correlation-Id: 1786b1b9-6ce4-4261-1cbc-08d5a6ac6f08
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 10:49:45.6119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1786b1b9-6ce4-4261-1cbc-08d5a6ac6f08
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-20 12:41, kbuild test robot wrote:
> Hi Peter,
> 
> I love your patch! Yet something to improve:

Yup, right you are!

> [auto build test ERROR on drm/drm-next]
> [also build test ERROR on v4.17-rc1 next-20180420]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/Add-tda998x-HDMI-support-to-atmel-hlcdc/20180420-160131
> base:   git://people.freedesktop.org/~airlied/linux.git drm-next
> config: i386-randconfig-a0-201815 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_probe':
>>> drivers/gpu/drm/i2c/tda998x_drv.c:1859:16: error: 'struct drm_bridge' has no member named 'of_node'
>      bridge->bridge.of_node = dev->of_node;
>                    ^

Anybody got a better fix than this?

#ifdef CONFIG_OF
	bridge->bridge.of_node = dev->of_node;
#endif

Cheers,
Peter
