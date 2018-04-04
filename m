Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeDDMfp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:35:45 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:42912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750915AbeDDMfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:35:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 0/5] allow override of bus format in bridges
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <2233231.my6BbD3pcT@avalon>
 <CAKMK7uH-=BqU+vuePTq4joY3XS2ypvtSKYvpv1LLyovPpSXv6A@mail.gmail.com>
 <1563250.XEJxFDuW0h@avalon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9af25e5a-7334-b07c-ff49-46530df6b1aa@axentia.se>
Date: Wed, 4 Apr 2018 14:35:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1563250.XEJxFDuW0h@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To HE1PR0202MB2777.eurprd02.prod.outlook.com (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1bc721-5fdc-481a-701d-08d59a289232
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:l4lNlHXA34vqPQRybj12KUidS61ZgjZKd5kfN/K9DqtjM1dyXxOngFEHdCv0KWL3TjF6vuTWW8LCmglkzZ20o1yzYsPafQ/NGmeJUdhQbYzhrgn/nJEuI1BgBRvmOi5/LAgTcvRFKM7J0aiw7bUDLVYfyKHy3mPRW7gdW/q8/2Y2NshRJ7oOenGH519njbvm9nNrC2CrGbZhwcmo0nD/G635tcPzG/0xo567e2NF32/cT00JDWCvTkdXpWaBv0o8;25:ltwp+6abHRx7eKlK10tsD3sHQEgBo2hWeSsbwgMjMMSA9PRzgNgxPWf8BHQEtZgiBDHakl7lcxL0c7IdDCpmVnlmbikUhJ82i9emlip1uA+yyMthMumuo1vHXkcUJ58b7H4kWghfHHw3AFKUmg6WmrhT0EXV+WQTDT+8gZw0me3hYwSmgqorh3nuJD8kl6HQAvkrUWptlwKrjKevjgUFAMK2n3l30kabJnjgiNW2OUvam2Yd4o54FtP89LqlfPZOBmB7oGNlMXKG4ec3X54l/47I1eMcn/w/oj0LwPE3THQwt8UIuiJZt4XIcqpuzP3rGUPIaWVtQWOllRaDXR6Dxg==;31:ej9YsSr1Ptm39z2h4dedCJ+GhIoHNbtJA7GgAdNYf4WUzNPggvw+MFTKqjBUjAzmmqX/1euBajsVJ9cxO9fZMHISiqT9M6xO7AB7/AyHJNvodoXAttQEJ+ZphAv9d0lQ57Z4RrNqEwYQuvZlcZHd3Ashqj84TYKnQkQLy1j4BKKdN4y65FXzl3gPitxrZPZzGsPsCJN4g1uOp5pexUcvf93wGRh8jl328O6sbpi3mXI=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2777D554E13460D1C7C4A2D9BCA40@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:7XqDJNyYU71U+fBXzty7QiUx/S3lS2Uw9NGRsVFkmWKEeNyOUuQZXHWGRql0Tc4dtFp97vu2kXHNIBBE1HdkMKY+x9yDo7OFj9qBDzEmvbAqeMHsPaxtcKjxVsxtYrlC43Pp8h8vroGqT40vgUtx8MJCv9/PUyqnfnktvrg5fN5f55xb1m//S0I8MjSsvQtEjjemFzs2enXW277ArPjRGqt1ecjqmV1bZjAjAGwAuOXovV9kjP+vgm6Uo2gF+tUbZvGlETinaP/RzniISgLFQA==
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(376002)(39380400002)(346002)(39830400003)(377424004)(189003)(51444003)(199004)(230700001)(229853002)(316002)(6666003)(58126008)(6306002)(53936002)(2616005)(64126003)(16576012)(105586002)(93886005)(478600001)(8936002)(8676002)(486006)(54906003)(305945005)(6246003)(36756003)(7736002)(6486002)(97736004)(31686004)(110136005)(86362001)(386003)(106356001)(53546011)(966005)(3846002)(81166006)(2906002)(476003)(4326008)(74482002)(11346002)(77096007)(25786009)(561944003)(81156014)(956004)(117156002)(26005)(3260700006)(5660300001)(36916002)(52116002)(7416002)(47776003)(65806001)(52146003)(2486003)(23676004)(68736007)(66066001)(50466002)(76176011)(31696002)(16526019)(186003)(446003)(6116002)(65826007)(65956001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzc7MjM6T3g3S200YlBnS1dra1hJUGJhZ1RSbzZJ?=
 =?utf-8?B?UkFubVQ0Z0ZKczI5bFg3NE5iMXF4WUgrZzFhQmdSTTRxWk1tR0wzdStBbWhv?=
 =?utf-8?B?RHZmdkJWM3NDVmxZQ3MyejRwdy9meVcvOEY2aHRKRzF2NE80MTlPQTU1YnZj?=
 =?utf-8?B?cjI3RUxwNzZOZE53T2wxTWN1WlM4UmVIRTBCMTlHTjI5MkNUKzRmc0NEYnNQ?=
 =?utf-8?B?KzQxdURPVEw0SktHcm0yeENhZFd1L0c4NERTdVNkTm9hRm1mcE9aRHVBUXE4?=
 =?utf-8?B?WGpiVldwWmRvakNqSmFQNE5ManhOcUtkQk1yQ01ON2dpZ3l6MDJBRzlBUDZ4?=
 =?utf-8?B?eVNLYmJ2RHVDZWhrVmp3VlRIbEVlSlZJakUvUUxJTTBhekxWSlIrdjFZM1ZB?=
 =?utf-8?B?bzdTSWdMSGxwWTV5d3hIdGRERkRMbXVRRjV2VjBFZDJyVURlWHhJdVl0ZGdW?=
 =?utf-8?B?cUpjQlBONmtuSXFyWlQzN25uS1loNzJQVWVRUXZrUHIwZk5VRlB1ZGI1RGhM?=
 =?utf-8?B?WW1Dbk1IMzVhM3JYZml3Ky9QdTdRYkVWeGZJRWJEUS9oZ2NIK1VTN0VIWHBo?=
 =?utf-8?B?c0owZXphTW56OWZTV2VVNlowZXBWK1huOWNITjN1OVRUakYreGN2QlhvOHNz?=
 =?utf-8?B?K3RVQVhTNXBXazBZekJXdXdRVC9SbkllRjJCc1p1RDJqSGJKelNsNkhYYUZN?=
 =?utf-8?B?em5BZWt5dHl6TWg5WitvQU5FLzJ2TFV4eHA1YUg5SnhyTEdRcGRsUGFTQjVD?=
 =?utf-8?B?RXpFQUI5TmRla3czZFg0cHVneStkeEZFVFM4c0ZITGVWWllEaXVBblFsaFVo?=
 =?utf-8?B?cG02aTlteHlVc0hNanMzOUZFUklubXQyVkRzbXB0TlEwaVZ3Mnl3NzlkdEl2?=
 =?utf-8?B?ZVF6bk1VQkpGUmVFZ1BHcVN6bytYZ1k2RWMzWVZRNC9tWERoYmdvNHBKdkVX?=
 =?utf-8?B?TzZ4b2hROUVtRW9BR09NVkQ2UlRLNGZGdnhOYWZXUGcxL1FLRlpaSktBS0hw?=
 =?utf-8?B?L3Nyc2c4MHR0cVdVa0VNVk5XMGxXVVZSTUVoMlNVUlQ3dHd2dkdZYm0xRFdk?=
 =?utf-8?B?eGx0cUEyNjBMT3p4UlRqaWl4Z2pDbmJ2WW45ek9TbVpGTFRSZGNpRFZQWVVN?=
 =?utf-8?B?OG1QTFZQbTAxdDluY28yNnhHdmdMY09BNTREV1htSmlWRGpCMDNhNDFrQlQw?=
 =?utf-8?B?QldMMkFVdXZJVVArQzd5emZHRzlBTzBiZDhyY0hQQ0tWdGxGbmRLakVrc09N?=
 =?utf-8?B?RTRPR0QzZkRhNTQ1VGloWWFaWG1sSGxqNEhYdjVvR2VaZ2pGK3FEdUlFTmlm?=
 =?utf-8?B?VGUxbW9USmVIMzV0dFB6UEtacFYwS3ArM25QeHRkOElQU0ROUjV1TVlLR2Nm?=
 =?utf-8?B?cXVrcXNOamVQSE5pa29lbkdpamdCUWtlNS93TG5XRGp5YjJqNGo3cXlZcVo5?=
 =?utf-8?B?K1JSb1d4bmJGak9HL2ZDTUFFWnJSVnhtYjQ4RTBONzcveEhQVjFiNE1mWjNp?=
 =?utf-8?B?SEdRdUxzRmRSQXhIWU13SUl1U09NamcwQUdsR0FuT1VwOFVXeDQvbmc1RXFS?=
 =?utf-8?B?dlN3T1JMc2lhT05jbmQrUFZ2Qi9QVHlNa2VPYm95bFcxdm5jV2dQa2tsc083?=
 =?utf-8?B?QVNBVHNmRHJIRDVGcTQ0TG5TRlFiN0Z5NithVXducDZZMVE0YjEzUUh4MFdR?=
 =?utf-8?B?Zm0xYXpKZnNnV3Q1RG4wOUp0MjZIZURRVHJ1VmovYTF3WGNPS3pOL2NsYktS?=
 =?utf-8?B?Nmh0WUd1QXZFYTlJVGJtVktUb2hBQUJvNXZTTFYzUWVpc0pEWVpuUGdteWVO?=
 =?utf-8?B?R21NZXBMUmlLUGlEQ1pOTnV3VENEZ21KT25wRmV0Zm0wcXNvOHgwNUFpRFB2?=
 =?utf-8?B?MHRJRFN0Rk5DdTV4cDdJcTZQRjI2SGxhV2R0UlBybXdmRFlDQzcxYkRXT1dX?=
 =?utf-8?B?K1ZBZmdYTW4wb1pzbWhqYU9VRmQ2ajJkRy9ZaFdqbmJnTXVPYlBzcG1vcHhi?=
 =?utf-8?B?YlhwZUZZUFlHTDV2QkFlZFRURU5oelBCQlRsdTEveCtaZk8rN29YMGx4R1lO?=
 =?utf-8?B?QUJjMVVkQlJjU2wyYWYrZzNoUW5FSG42OHRRTTRtSzIwcko5clcvbUZvaGVt?=
 =?utf-8?B?MEwycWZFUEZ6T3BkTGF5VzhvaWtseXNXeTkwMEdlYVZYY2hjeHVTS0JFRHNo?=
 =?utf-8?B?UG9qOWxKd0VZQjEzZzNyb3NrYkVHQzljeXRuckNieWNYVGtpdFNOY05MSHdo?=
 =?utf-8?B?aTVHUnc2S3ZIekdTbW9pN0pkN2N6WkM4UE15cjVKbUhpTjVjOHowSk9Lbkox?=
 =?utf-8?Q?Jg+cJCX2hZwpZ8+77o=3D?=
X-Microsoft-Antispam-Message-Info: u7PbdG2rkJGt8vkZmXR/6TTjM1VuCQEOft6/xq8wA/jvbnaADi1+m+JzhrULwuYKlbqEVPH/iYkscQIxzkFhIPY8Nk82NZV8Oab/DFGw6m3tDU5a1qAiammReILtxrMBJEejIdr67Vd9Am3T2hI5RL/KpGWbrpNUPSovITdInmnVtKyybF2kXTiUMtnLVFvm
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:jaaoXTEezu7LyYmADEgkX0PLY+0kJGBfGcvKpgPTBQgVmGGxXNB0eilNrPOdK9qzSmzND2JGch5ZANluReTanHgJB4dm24UWe5HmgL1VJ9PC32J6qjK5QduDicZ71vXQAp2PW/qJJk6koClseN6qwMt6dMS/Mar807v/YkrVEosa6/I3gO0ZON0q7UQR+0TNfrsxM3yjjLCPqWQ0N0NTviPGPfs8i9yQY/cURggFtm9jM7LhjbiFXZX9sTWuSDZe0GZcfAgw2dAfc+z/5A7qumB8wQ/mwEv0y6tOqKcIedtwPDpUQBzBfEsUUV4TMN4Ji+PLGh1kck/v9Lv9pJRx2CceYkyDyYJ7+TO1R++6zSpdZOZpRNGwoxal+Q4C8pbFMMlyXLaGXO6AJqSxgqiJuMEXuMQbwh/mBONxuPBRDDBGWxRp5q2whCXbZIsim1+0/aczREBcL95PWN2dzN3gVg==;5:2LOsSIbRQfMjN5GucvixMxYmt/9T7o5vDPa/ToY9/1bakG0Kgy7u4dR4HSlh0E1HQ4lQ8MQfVwsa65bZRgh/YOPnlkeiLeyHrsIqyNwsGwaAisajLnJAQNKhAYxbyj6GmIO1O7QYBlO99DSxw4FxOZoM+46MVk2796uyRaniC9U=;24:TNQy42+z75SWCnSs3PwONBPKjklf9KN61gAjnTvirPsUbOhuFUT6+ZWtF5RwMjt91uKVOV12eC8evUZIybPRtjy/q11wn18HgGozJ1tL3aw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:GuNlDRfMp9kxMxAmfXedAgIISDtCpqrWf6quBOPOx+H7+HfM6UYLphXPRmjI+mre5OyaLlungkId6ncwzPDEjgbS0E7rOmG0fyRgTg4lTAGN02jAjFiHR5LLjopNsTeBNeMdI7So4ZhnuZr9IClS0UKWUvRladVwor6Y9ZGt1lNYkX+TSDJBMhVHH8NnAmFXP5IpcF4y6EzRzWDygdyT7SHaHjsU0iVdiGFlAtncbHVBVG1QNvywSgUExTGuLZmo
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 12:35:38.1191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1bc721-5fdc-481a-701d-08d59a289232
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 11:07, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Wednesday, 4 April 2018 09:34:41 EEST Daniel Vetter wrote:
>> On Wed, Apr 4, 2018 at 12:28 AM, Laurent Pinchart wrote:
>>> On Wednesday, 28 March 2018 10:08:26 EEST Daniel Vetter wrote:
>>>> On Mon, Mar 26, 2018 at 11:24:42PM +0200, Peter Rosin wrote:
>>>>> Hi!
>>>>>
>>>>> [I got to v2 sooner than expected]
>>>>>
>>>>> I have an Atmel sama5d31 hooked up to an lvds encoder and then
>>>>> on to an lvds panel. Which seems like something that has been
>>>>> done one or two times before...
>>>>>
>>>>> The problem is that the bus_format of the SoC and the panel do
>>>>> not agree. The SoC driver (atmel-hlcdc) can handle the
>>>>> rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
>>>>> wired for the rgb565 case. The lvds encoder supports rgb888 on
>>>>> its input side with the LSB wires for each color simply pulled
>>>>> down internally in the encoder in my case which means that the
>>>>> rgb565 bus_format is the format that works best. And the panel
>>>>> is expecting lvds (vesa-24), which is what the encoder outputs.
>>>>>
>>>>> The reason I "blame" the bus_format of the drm_connector is that
>>>>> with the below DT snippet, things do not work *exactly* due to
>>>>> that. At least, it starts to work if I hack the panel-lvds driver
>>>>> to report the rgb565 bus_format instead of vesa-24.
>>>>>
>>>>>     panel: panel {
>>>>>             compatible = "panel-lvds";
>>>>>             
>>>>>             width-mm = <304>;
>>>>>             height-mm = <228;
>>>>>             
>>>>>             data-mapping = "vesa-24";
>>>>>             
>>>>>             panel-timing {
>>>>>                     // 1024x768 @ 60Hz (typical)
>>>>>                     clock-frequency = <52140000 65000000 71100000>;
>>>>>                     hactive = <1024>;
>>>>>                     vactive = <768>;
>>>>>                     hfront-porch = <48 88 88>;
>>>>>                     hback-porch = <96 168 168>;
>>>>>                     hsync-len = <32 64 64>;
>>>>>                     vfront-porch = <8 13 14>;
>>>>>                     vback-porch = <8 13 14>;
>>>>>                     vsync-len = <8 12 14>;
>>>>>             };
>>>>>             
>>>>>             port {
>>>>>                     panel_input: endpoint {
>>>>>                             remote-endpoint = <&lvds_encoder_output>;
>>>>>                     };
>>>>>             };
>>>>>     };
>>>>>     
>>>>>     lvds-encoder {
>>>>>             compatible = "ti,ds90c185", "lvds-encoder";
>>>>>             
>>>>>             ports {
>>>>>                     #address-cells = <1>;
>>>>>                     #size-cells = <0>;
>>>>>                     
>>>>>                     port@0 {
>>>>>                             reg = <0>;
>>>>>                             
>>>>>                             lvds_encoder_input: endpoint {
>>>>>                                     remote-endpoint = <&hlcdc_output>;
>>>>>                             };
>>>>>                     };
>>>>>                     
>>>>>                     port@1 {
>>>>>                             reg = <1>;
>>>>>                             
>>>>>                             lvds_encoder_output: endpoint {
>>>>>                                     remote-endpoint = <&panel_input>;
>>>>>                             };
>>>>>                     };
>>>>>             };
>>>>>     };
>>>>>
>>>>> But, instead of perverting the panel-lvds driver with support
>>>>> for a totally fake non-lvds bus_format, I intruduce an API that allows
>>>>> display controller drivers to query the required bus_format of any
>>>>> intermediate bridges, and match up with that instead of the formats
>>>>> given by the drm_connector. I trigger this with this addition to the
>>>>>
>>>>> lvds-encoder DT node:
>>>>>             interface-pix-fmt = "rgb565";
>>>>>
>>>>> Naming is hard though, so I'm not sure if that's good?
>>>>>
>>>>> I threw in the first patch, since that is the actual lvds encoder
>>>>> I have in this case.
>>>>>
>>>>> Suggestions welcome.
>>>>
>>>> Took a quick look, feels rather un-atomic. And there's beend discussing
>>>> for other bridge related state that we might want to track (like the full
>>>> adjusted_mode that might need to be adjusted at each stage in the chain).
>>>> So here's my suggestions:
>>>>
>>>> - Add an optional per-bridge internal state struct using the support in
>>>>   https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#handling-driver-> >>   private-state
>>>>
>>>>   Yes it says "driver private", but since bridge is just helper stuff
>>>>   that's all included. "driver private" == "not exposed as uapi" here.
>>>>   Include all the usual convenience wrappers to get at the state for a
>>>>   bridge.
>>>>
>>>> - Then stuff your bus_format into that new drm_bridge_state struct.
>>>>
>>>> - Add a new bridge callback atomic_check, which gets that bridge state as
>>>>   parameter (similar to all the other atomic_check functions).
>>>>
>>>> This way we can even handle the bus_format dynamically, through the
>>>> atomic framework your bridge's atomic_check callback can look at the
>>>> entire atomic state (both up and down the chain if needed), it all neatly
>>>> fits into atomic overall and it's much easier to extend.
>>>
>>> While I think we'll eventually need bridge states, I don't think that's
>>> need yet. The bus formats reported by this patch series are static. We're
>>> not talking about the currently configured format for a bridge, but about
>>> the list of supported formats. This is similar to the bus_formats field
>>> present in the drm_display_info structure. There is thus in my opinion no
>>> need to interface this with atomic until we need to track the current
>>> format (and I think that will indeed happen at some point, but I don't
>>> think Peter needs this feature for now). That's why I've told Peter that
>>> I would like a bridge API to report the information and haven't requested
>>> a state-based implementation.
>>
>> If it's static, why a dynamic callback? Just add it to struct
>> drm_bridge, require it's filled out before registering the bridge,
>> done.
> 
> If I remember correctly I mentioned both options in my initial proposal, 
> without a personal preference. A new field in struct drm_bridge would 
> certainly work for me.

You did. Ok, so v3 coming up...

Cheers,
Peter
