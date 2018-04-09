Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeDIN33 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:29:29 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com ([104.47.2.116]:45024
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751643AbeDIN30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:29:26 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 0/5] allow override of bus format in bridges
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180326212447.7380-1-peda@axentia.se>
 <9af25e5a-7334-b07c-ff49-46530df6b1aa@axentia.se>
 <8bba78e3-ed61-4648-d4a4-5d12dd9ef11d@axentia.se> <1535937.JbitjzqBjA@avalon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <23354fb7-c907-2913-24f6-a8024a01ea40@axentia.se>
Date: Mon, 9 Apr 2018 15:29:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1535937.JbitjzqBjA@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM4PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:205:1::48) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709c35cc-5613-492f-ded7-08d59e1de7b0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:h9XDhGlT/BMzYL7JWRl13w3pPhyh2PF96+WI7M0cikHidW5LXX5cpAbwompDfAnsq6Gipst5pD8W2qmOUQJJGtwVZBFEqnvIxmGTmYp1fP3HMyxjavizuWmmods4R2CN1RHaAjdo8hqd233SJaUl/urV6B71592m0/Si3m/sXmH9rIzqVaUec4JXfx8KG+EdOvMicYLkXx5Goyu75Er89HJtERCzDw9/lEedQWdnDJ3SpHMP1YyEjOxKx1SQKR0h;25:vVH2D9YgIARU4+GadshLYJgMXXXPOcONP3fZ+Xz/h7m3kkuXMAz9Piz/zzB0T8pqILMAFX7UoLWztEgLg3kpLPOFUUn0TIVKZXWTgStjKSQ5Ewc6V5YlRvDYDsNMN0yJ+l8COLxuj32D/79IR1wzxSa914vJGgxtM4A9xr4FjlSO46dT7OwI+TvB3b703X6RNZnBjljJQiN2z5MBd1Yj3NLKIgC/SxUeLb2s/Wh8EbDf7mdd5ts7JpOY5cfkoDdlyKhXAPVhqktRiiHiPH0tqeHxbkrvslCbcACsJZAKVxgZ7VEwEdv0fAIOvW+S32m9viv+kJyeLpIoeuNSC0vIZA==;31:nh0i0NazUNS9HFe7dWOfudREaMhh3DWt7Fe595wWJbhbw9RU/YCQBpXXiLeSBIXrtYrQHkqoo5i6VuA5fqsfLrEv4bObMyGcMfzhxcq2RIrnwb2ZsLCR0wANRJmC5SPJnBkpCqr15UAPl7muagy9g55t+n8YYZggZt3Ppp2A0Ol7EHmoqpnipFpM0XK83Dozo20l9v7jy/SmKCSMx01nQ9GuIX4koA54iGS6sxLvZnI=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27749FD35950A7A05B0F1ABCBCBF0@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:b6Am7W7j5NzyieTUxnWpD5pniVAKMrP/+A04z33PdIVfvt9fHDQDxd2yWo3YqlrQD3r0TXKV0OJJSad/9QUjI00AiEzK2geyoh8WiaKvjd+W+s7+lo+AmTv6l13lN6Cc5BRZ7w2P0gVet2EKDrzg76kBeG6TaaYdheqh5kYvuMgTi0mSZsbY4l5WpPtkZk+ltr2xDlhMYoGEfEeBPXMkcrrBUAeIgpYQZQvxZulMavxMyhmdRvUfhy3S950F6IZkRYMb4Qt+Lh5+MghOIx4QNw==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39840400004)(39380400002)(366004)(346002)(396003)(377424004)(189003)(199004)(51444003)(6916009)(230700001)(93886005)(68736007)(966005)(53546011)(386003)(446003)(11346002)(6306002)(58126008)(31686004)(64126003)(105586002)(6666003)(316002)(16576012)(26005)(186003)(486006)(8676002)(65806001)(2486003)(52116002)(47776003)(16526019)(36916002)(23676004)(2616005)(77096007)(956004)(76176011)(476003)(52146003)(59450400001)(81156014)(81166006)(65956001)(97736004)(36756003)(53936002)(54906003)(86362001)(25786009)(31696002)(65826007)(7416002)(5660300001)(8936002)(478600001)(66066001)(3846002)(106356001)(6116002)(229853002)(4326008)(3260700006)(6246003)(305945005)(117156002)(7736002)(50466002)(561944003)(2906002)(74482002)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzQ7MjM6ckRRMDdRa3JOZEhtRXNTMWg5VnRTbUxC?=
 =?utf-8?B?U2JzM1BmcE1aSS83UVNIZXZrMGY0bXE5TFpEOFNMQnlUd2wvUWhVOE0vL0sv?=
 =?utf-8?B?d0RsS0NNc2RTSkczM3pWR3FtK3M2dGZlWWUyM1VrZThpc1Z2bGVjT1F5NkVY?=
 =?utf-8?B?QnliaEs0cys3TENsN0MwekczVEpLZ1hLQXY4QWQzcTgwazNBc1VpSkZZckE1?=
 =?utf-8?B?TmcwR2dpaFZQME5vYWVzWGx4aFNaZ1hlSHA4OVdYMjRhUGFyVWVqZ2J2am95?=
 =?utf-8?B?UlBQNVZOS0VSZ0trbFhoUGNuVUxCZFBDNDV2K0pPZW1YVzAxNzdZVCtiYnQ4?=
 =?utf-8?B?by9aRGo1bE5VN1dLR2dyeldMRStFNFVUYzErYUZLckhCRkVGYm5nQ3ZOcnFV?=
 =?utf-8?B?Y2cya0liOEFmVW1zNy9sc2tTRlZMWnZwMXVDajU1MkhiVnlvc2NDQ3l3UzdK?=
 =?utf-8?B?Z2hzRG53M0RtbGY3ejlxc2dLUDJnKzBkRkMzSDk0elNuZWN4N014MkViM2hP?=
 =?utf-8?B?NmlMNWhUZFAweGNiNDFKYjJMS3ZrNWtzL1k4ZjZxUVNyZnVsYVZtc0xyMWpW?=
 =?utf-8?B?blFMNVBUOTlLbWdRaThHaDAvN3RQNUFNZHF1elc4N3psYVFhR1VaeFRvZUFn?=
 =?utf-8?B?Si9TTkFCbTVlSVVFb1lPb2lTZHpReXM5NkRkUXpjMUxzZjhTd2hyQ0NLUGhV?=
 =?utf-8?B?ZSszK2NuWEVCNVFDK1ppdkRjK2JBWDFLcXRvRktGeDFWeHRkV1JabnJXTEgx?=
 =?utf-8?B?eEdLWkZxenV6WGUzZUFOUUhWUzBVUXAydzJWQlNFb1RRT25jN1lJWkdEVDM4?=
 =?utf-8?B?SmI1SmlISFEwQ3BuK2pZbGI4bmZYQnJiNGExajhtazZ6ckorS1JwVVpuVjRX?=
 =?utf-8?B?cU5BWjdNRzBZSlg0aGVIallpMzkzUG5KTGlSY3dacHFHV3E3M1R6dWFBVVQ5?=
 =?utf-8?B?SktnWW5yaUhRcU4yS1YvZTdFNjdoSEZHVmxVc2QwMUE3ZGhoNWRBU3FGaFFH?=
 =?utf-8?B?RHBDc05hNUJXN1BKcjllT1VzSXc4bjRjeituT1g5UmFtVG9ocFd5NXRBcFRN?=
 =?utf-8?B?aEpXRFkyM0tzdVFWcW9PeTZhSlg3VHpWYk1IR2FqT0dNRWZUL1hGYXFwUkIw?=
 =?utf-8?B?UEJQbG9jVmlPQ0tJZmJaRU44SUVsNC9UNzRHL2MxaHFsdnRDVE1YYllJTnpK?=
 =?utf-8?B?dHJRNXJpb25Md3pHU2h1WFRoYW95N2grOHQ4SFJlTndkbGVwNjl3SDQrMWFw?=
 =?utf-8?B?Ymcwd1NXM3gvbm1iNE93RHM5TEhXMlA5WHBaTjk2WWRmMk5hZUY1Z2tqMnVR?=
 =?utf-8?B?VFhpMFkzZ3IzOC9PaHVZQXR6Vlk4UlM4K0IrMFBVK01FZ2ltcStveW1RWlJI?=
 =?utf-8?B?cUxjV05pNFFIbnk5ZXpHUjNxZU83K1ZiVUJmSmx2Uy82Vy9WUjJJeVB0b3VE?=
 =?utf-8?B?Y1NITU9Ub0I0VHY4ZURiUHFNbUxtUXU3Y3ZJK2owTkNCTDdTWEhxbE1RcUd2?=
 =?utf-8?B?NC8vOFJnakhSZm45VUhTMWFBMlA5a3JHL2FWaGxLTWVkelpLTko5SjRBOFE1?=
 =?utf-8?B?TXJzck95OVhxSjgyc2plS3dDSVFzaWpkd0M3S04xRms1RmZZaGVaWnFNdVo5?=
 =?utf-8?B?RGc4aXpic1BNUHh3TEQ3MDZ2MUhybDRQc2VkOGZBaXMyS2wyR1Roc2x0TWdF?=
 =?utf-8?B?bUhMWXRDN1dScm4wVTdnNUVNMFB2WmljMVRMemhwUzE0dmhNYlhZbTNPOUxq?=
 =?utf-8?B?S0NHdjhpd3NWbDBSOFdrZ2szcXREZ3hMdm10TG1yL1V5dFVkbWI5SWFrSWJN?=
 =?utf-8?B?SEhib3QyVFhVUklmS2Vnc0JYT0lOTUdpay9qWUlQR0QwNSt0MnZrRUZsbm5v?=
 =?utf-8?B?ZjVqOVF2TGU5ZExiTGVkdWJWSEVHTEJEUGxZMkZDZ05UQjhsczgvbjd2T3Zk?=
 =?utf-8?B?dU1OUnlnR1lidlV3N041a1lFYWhFRENCZTNiMGRVM2RQMHROY0tSUklrdEVG?=
 =?utf-8?B?QkRiUFcyQlVVYWxRUll3aDYxeVRDUk5kckFmMzkxTUVTWklaUjlud3A4V3BL?=
 =?utf-8?B?MHhWaHJ5MHpUVytDakpwYUx4b1E4NXliR2F5Z0Rib2FUZmRmYm1KaTNZckVC?=
 =?utf-8?B?UHRMbWt1R1Z6U1lvdXozNWpSZzNIVFB3UnpIdVRoUkxReFhhKzN2TjVSOXJm?=
 =?utf-8?B?c2xTaGVUa1FIVzZWNHY0cDVkdEhZcTJTTXlCYmcvT2kxelhZUUppQTU2dG1a?=
 =?utf-8?B?aURjaHZQM1hicDNVNStWMjN2d1N6VUtzcVo5NG1uaXdsdCtTVXJ0dG9OaEMy?=
 =?utf-8?Q?BoLkXwL7QlDRrSLB7LvFDCgUcb0K7a1+TayJfKI?=
X-Microsoft-Antispam-Message-Info: +fG6yfNFiDWesAmYS8SOqjPiL19D1xnrwgwtU+AFk13kqTLBMQluWaEpKr+J0JuVjYZ3nHZGL4npG6A2xW/B7yPet8eZZ7+U4GTdrq+I5/BWZPyjCptz8dK5XLbiyJDDItfjbdSI1qzqfFrYq/CqGOUNaItWwtE6ap1NSh4VldNRpe4X0QJMO78TKp72kvME
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:A+nPVpB+UFdsbym/RNe329PmItNvwGBjKG8xEM4vUqwEjWrXo0y6p4l/Hyb/153wVT0CkTyP+Q6q98jOqyszqt1NJyNdUStQazTeJOqkzeuWKGhe2ZS0mdnqvbe/1AjV1SI3zCKvrNAzWIivScBomg31+V6BCVFhY9bavnrWrns+md9aGoV2OrnTcbU4bR6TOxF5vfvlCr/uWBewIwlG2k5AwwfyGrr6okvFfMXVplVO/P/J0/RpmK6Jmh8V8VIKWFsQ6rHqSzZhWg+An1zvgMh3D7H0GuPyPWefex5F2PjO6XyMMY93MDebqaJD6kXwFlij6l0PAAJqdr4TyzISZ4yfJPt2sJkTYLsvBoe6w/aM7nGY4IG22DJCrEcyRpouGquUzb+MCJFaMByr80boOpMF3VhaPftaYYaNMZ4T7zYU7GyJT/gowgh1SS/U6QLaTNHH9ANsfPNhICBRy3xxGA==;5:WTwMWB9/mMWZDym2vBwSWb9l70BO62irol0LtNpLW2T1c2txc8kJLrfONey7+qrWvaIwEqk3kjP9gvipL3vVXM3+B1+zDRR0AyQa787uQj0CBvUFOCdmjB4w9mgGOhWz/92zMMBgLkmccOw4nUI5m3SGsuCfXEBZHFsgJGnkv3M=;24:QzNaiA/Zn4ljmiZ+tOq44BcYQkVALyfDe27WtKNn1PwmxvB6Yo4QAFREFrv+br/B7FK0BgfL8GoJGXMWnmTUVW1uwyq8hk+vvcxEb50WkRg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:ydjdCwa/2iBZRAm11wSlJ1r++Oju6SPcpg+iutqN1tGggIk+Utl+k4Cuz1sNWFxLskOd48UvHespzluaaPT/RCqcGJIMlWF4YDvjg43pCdiQCzGHYxR9XJzNY9rFEcqNA2eEct7ZuOmzH8uuFqwi8qFTtwR2/SNklizNjl3QUWEM0FZck2pFm5l1lmWBrMPw746YsIg2CBI/x9IpUbPfvjb6ijk5yfnedojd181ozPVe9/qU82zvxXTBq19tydX8
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 13:29:21.0536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709c35cc-5613-492f-ded7-08d59e1de7b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-09 14:51, Laurent Pinchart wrote:
> Hi Peter,
> 
> On Monday, 9 April 2018 10:04:05 EEST Peter Rosin wrote:
>> On 2018-04-04 14:35, Peter Rosin wrote:
>>> On 2018-04-04 11:07, Laurent Pinchart wrote:
>>>> On Wednesday, 4 April 2018 09:34:41 EEST Daniel Vetter wrote:
>>>>> On Wed, Apr 4, 2018 at 12:28 AM, Laurent Pinchart wrote:
>>>>>> On Wednesday, 28 March 2018 10:08:26 EEST Daniel Vetter wrote:
>>>>>>> On Mon, Mar 26, 2018 at 11:24:42PM +0200, Peter Rosin wrote:
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>> [I got to v2 sooner than expected]
>>>>>>>>
>>>>>>>> I have an Atmel sama5d31 hooked up to an lvds encoder and then
>>>>>>>> on to an lvds panel. Which seems like something that has been
>>>>>>>> done one or two times before...
>>>>>>>>
>>>>>>>> The problem is that the bus_format of the SoC and the panel do
>>>>>>>> not agree. The SoC driver (atmel-hlcdc) can handle the
>>>>>>>> rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
>>>>>>>> wired for the rgb565 case. The lvds encoder supports rgb888 on
>>>>>>>> its input side with the LSB wires for each color simply pulled
>>>>>>>> down internally in the encoder in my case which means that the
>>>>>>>> rgb565 bus_format is the format that works best. And the panel
>>>>>>>> is expecting lvds (vesa-24), which is what the encoder outputs.
>>>>>>>>
>>>>>>>> The reason I "blame" the bus_format of the drm_connector is that
>>>>>>>> with the below DT snippet, things do not work *exactly* due to
>>>>>>>> that. At least, it starts to work if I hack the panel-lvds driver
>>>>>>>> to report the rgb565 bus_format instead of vesa-24.
>>>>>>>>
>>>>>>>>     panel: panel {
>>>>>>>>             compatible = "panel-lvds";
>>>>>>>>             
>>>>>>>>             width-mm = <304>;
>>>>>>>>             height-mm = <228;
>>>>>>>>             
>>>>>>>>             data-mapping = "vesa-24";
>>>>>>>>             
>>>>>>>>             panel-timing {
>>>>>>>>                     // 1024x768 @ 60Hz (typical)
>>>>>>>>                     clock-frequency = <52140000 65000000 71100000>;
>>>>>>>>                     hactive = <1024>;
>>>>>>>>                     vactive = <768>;
>>>>>>>>                     hfront-porch = <48 88 88>;
>>>>>>>>                     hback-porch = <96 168 168>;
>>>>>>>>                     hsync-len = <32 64 64>;
>>>>>>>>                     vfront-porch = <8 13 14>;
>>>>>>>>                     vback-porch = <8 13 14>;
>>>>>>>>                     vsync-len = <8 12 14>;
>>>>>>>>             };
>>>>>>>>             
>>>>>>>>             port {
>>>>>>>>                     panel_input: endpoint {
>>>>>>>>                             remote-endpoint = <&lvds_encoder_output>;
>>>>>>>>                     };
>>>>>>>>             };
>>>>>>>>     };
>>>>>>>>     
>>>>>>>>     lvds-encoder {
>>>>>>>>             compatible = "ti,ds90c185", "lvds-encoder";
>>>>>>>>             
>>>>>>>>             ports {
>>>>>>>>                     #address-cells = <1>;
>>>>>>>>                     #size-cells = <0>;
>>>>>>>>                     
>>>>>>>>                     port@0 {
>>>>>>>>                             reg = <0>;
>>>>>>>>                             
>>>>>>>>                             lvds_encoder_input: endpoint {
>>>>>>>>                                     remote-endpoint =
>>>>>>>>                                     <&hlcdc_output>;
>>>>>>>>                             };
>>>>>>>>                     };
>>>>>>>>                     
>>>>>>>>                     port@1 {
>>>>>>>>                             reg = <1>;
>>>>>>>>                             
>>>>>>>>                             lvds_encoder_output: endpoint {
>>>>>>>>                                     remote-endpoint = <&panel_input>;
>>>>>>>>                             };
>>>>>>>>                     };
>>>>>>>>             };
>>>>>>>>     };
>>>>>>>>
>>>>>>>> But, instead of perverting the panel-lvds driver with support
>>>>>>>> for a totally fake non-lvds bus_format, I intruduce an API that
>>>>>>>> allows display controller drivers to query the required bus_format of
>>>>>>>> any intermediate bridges, and match up with that instead of the
>>>>>>>> formats given by the drm_connector. I trigger this with this addition
>>>>>>>> to the lvds-encoder DT node:
>>>>>>>>             interface-pix-fmt = "rgb565";
>>>>>>>>
>>>>>>>> Naming is hard though, so I'm not sure if that's good?
>>>>>>>>
>>>>>>>> I threw in the first patch, since that is the actual lvds encoder
>>>>>>>> I have in this case.
>>>>>>>>
>>>>>>>> Suggestions welcome.
>>>>>>>
>>>>>>> Took a quick look, feels rather un-atomic. And there's beend
>>>>>>> discussing for other bridge related state that we might want to track
>>>>>>> (like the full adjusted_mode that might need to be adjusted at each
>>>>>>> stage in the chain). So here's my suggestions:
>>>>>>>
>>>>>>> - Add an optional per-bridge internal state struct using the support
>>>>>>>   in https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#handling-> >>>>>   driver-private-state
>>>>>>>   
>>>>>>>   Yes it says "driver private", but since bridge is just helper stuff
>>>>>>>   that's all included. "driver private" == "not exposed as uapi" here.
>>>>>>>   Include all the usual convenience wrappers to get at the state for a
>>>>>>>   bridge.
>>>>>>>
>>>>>>> - Then stuff your bus_format into that new drm_bridge_state struct.
>>>>>>>
>>>>>>> - Add a new bridge callback atomic_check, which gets that bridge state
>>>>>>>   as parameter (similar to all the other atomic_check functions).
>>>>>>>
>>>>>>> This way we can even handle the bus_format dynamically, through the
>>>>>>> atomic framework your bridge's atomic_check callback can look at the
>>>>>>> entire atomic state (both up and down the chain if needed), it all
>>>>>>> neatly fits into atomic overall and it's much easier to extend.
>>>>>>
>>>>>> While I think we'll eventually need bridge states, I don't think that's
>>>>>> need yet. The bus formats reported by this patch series are static.
>>>>>> We're not talking about the currently configured format for a bridge,
>>>>>> but about the list of supported formats. This is similar to the
>>>>>> bus_formats field present in the drm_display_info structure. There is
>>>>>> thus in my opinion no need to interface this with atomic until we need
>>>>>> to track the current format (and I think that will indeed happen at
>>>>>> some point, but I don't think Peter needs this feature for now). That's
>>>>>> why I've told Peter that I would like a bridge API to report the
>>>>>> information and haven't requested a state-based implementation.
>>>>>
>>>>> If it's static, why a dynamic callback? Just add it to struct
>>>>> drm_bridge, require it's filled out before registering the bridge,
>>>>> done.
>>>>
>>>> If I remember correctly I mentioned both options in my initial proposal,
>>>> without a personal preference. A new field in struct drm_bridge would
>>>> certainly work for me.
>>>
>>> You did. Ok, so v3 coming up...
>>
>> Nope, v3 is not coming up. This feels like an impossible mission for me, as
>> this changes core DRM design, and it would just be too much of a time sink
>> for me. Besides, the final paragraph of the nice long "state of
>> bridges"-mail from Laurent, i.e.
>>
>> On 2018-04-04 15:07, Laurent Pinchart wrote:
>>> Finally, still regarding Peter's case, the decision to output RGB565
>>> instead of RGB888 (which the LVDS encoder expects) is due to PCB routing
>>> between the display controller and the LVDS encoder. This isn't a
>>> property of the LVDS encoder or the display controller, but of their
>>> hardware connection. This patch series uses a DT property in the LVDS
>>> encoder DT node to convey that information, but wouldn't it be equally
>>> correct (or incorrect :-)) to instead use a DT property in the display
>>> controller DT node ?
>>
>> hints at where I'm going. The reason is that I have a patch (that needs some
>> polish, will post soon) that makes the atmel-hlcdc driver use components in
>> order to hook it with the tda998x driver (an hdmi encoder), and there too I
>> need the atmel-hlcdc driver to use rgb565 output. And in that case there
>> are no bridges involved, so the proposed solution in this series has zero
>> hope of being adequate. It simply seems that forcing the output mode in the
>> atmel-hlcdc driver is what fixes the root cause.
>>
>> End result; the only thing that survives this series is the interesting
>> discussion and patch 1/5. But I will include that patch in the alternative
>> solution, so you can drop this series entirely...
> 
> I feel some disappointment here. I would like to make it very clear that your 
> work was appreciated. Not all efforts turn into patches that get merged 
> upstream, and some of the greatest work only results in ideas that are then 
> taken over by other developers. Even if this patch series ends up being 
> dropped, it served as a very useful experiment to get us closer to a good 
> solution to the problem. As such the time and efforts you have invested in it 
> are certainly not wasted and were very helpful.

No hard feelings from me, and maybe I'll revisit (not all that keen though)
if the output-mode override for the atmel-hlcdc driver is considered a
workaround in need of a proper solution. Not that I think that's actually
the case, but who knows...

Cheers,
Peter
