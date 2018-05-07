Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeEGOYz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:24:55 -0400
Received: from mail-he1eur01on0093.outbound.protection.outlook.com ([104.47.0.93]:29940
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751884AbeEGOYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:24:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/3] drm/sti: do not remove the drm_bridge that was never
 added
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180502074025.12421-1-peda@axentia.se>
 <20180502074025.12421-2-peda@axentia.se>
 <20180503090648.GG12521@phenom.ffwll.local>
 <bd8d12f7-0c71-c96b-80fa-54de7de39511@axentia.se>
 <20180507133929.GG12521@phenom.ffwll.local>
 <d378241f-7420-bbaf-c447-18cdfd4f9dd3@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <7f79c109-6b0f-000e-569b-1f702e0006d3@axentia.se>
Date: Mon, 7 May 2018 16:24:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d378241f-7420-bbaf-c447-18cdfd4f9dd3@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::37) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:hp9E8X8LQrY7dBS7lfuMa0YHqQ8Fg/TFsxxc2MaRwx9PFS9J4gVj6UOc9n7Rc1r8PVZHL6SDSSdWpop+nrxPBaeAGzkWfjBXuUfGk+pWe1T7NoZnNk3I0fwUIdWBAkuAEVqeMzRsbfq2Zdmy8s1MKqYKE+94DHOgxPnSJgPnRRB0nTq2trTXFT5dmEDh5JJUXBKtMfH30eVv4lLp+7GyA5MrLNi0mzzQsDeNlXud6yRUBc3+f1HAkDKSEr1t+Hug;25:HKHQyYbkxwX9qtDUthoIGB2Xk7/dObAOhvce3iSB+nbWiwuMKNJeGqBLQqnv6AehSWhD2goWzG7RVpwZoly6JD+P3hY/7moBk2+alTzWsW65U7CP0VjqhQkcsBtzeM1vXLa5KFFJQ3V+yXnYwbcuoL0oWXTjxf7bmyLeJRFJdwmmvSbJ4bi6/TZNvmZU5HEe4QBrrRdewNYf7w0lZYnTiHpBQEfOOimBarKVC2LBedj0eGtaztv/bNu369KKfmL4LeWpsPDehdxzkW7CEeJy959xIyD2LUPfko61U05NEVY7rpIxCyBQwHSZNqi+RyjV2D8J321DCTOhmwt/ycbiIA==;31:D+IN4LUbYwI+TsUn2I564dAE04byDUwtkyyUCPBvR17kXeMcuO2dmgFQf4/qmRkHFTfsS4vIICCvbdPhtJnnMrWrcrFnbZMACrdjsFBmtcJPL9aL5keXpLIKL4deW1rZM2f8Jfkplzz0fhs9V7wTVAYELgrEDs2UGFsM1MJzdRuCMeiNHOhJv3VobaRRaRtf8Vq1MUKLamNlmkJuBDIxi+e/SOAELbrDuUtZH+WGb/k=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770D1451A96A3A7A6B79A81BC9B0@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:mnEV2Q/tASjbL3jZdBqxVZt/gaRFEWVatYkiOJs1XpNSymm5TKrrp3L2ajp8nJHk5wrREqhArtza49Xyqrrs9YbbFHJ1KzQKUFMTGWW7EHU6ZsOWvwSXdLn5n5bB6YMeh9UGRTU0FCSkzmuL3jb4HMV7zlXSBR+oScgkOMx80ssXBc+TSPn4fysYkQiIV2Kay7i6eZ6AAUM7GlMDdDhIi6CeTzlBTvdPL/TY4ni61DksdlfyPlGUkGurEl1Xrir6cEFJS4jnbALJ4FuK7glE2HOQH1VTeKvvYpJX2wtcN1asS8yiJj/AYfLVuvPukcSH
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(366004)(346002)(376002)(39380400002)(199004)(189003)(377424004)(486006)(36756003)(93886005)(16576012)(316002)(110136005)(476003)(2616005)(956004)(58126008)(6116002)(11346002)(3846002)(478600001)(446003)(31686004)(5890100001)(105586002)(106356001)(230700001)(53936002)(6246003)(2906002)(6666003)(50466002)(7736002)(229853002)(64126003)(8676002)(305945005)(6486002)(74482002)(8936002)(81166006)(81156014)(117156002)(5660300001)(65826007)(97736004)(7416002)(3260700006)(25786009)(68736007)(65806001)(65956001)(66066001)(47776003)(52146003)(2486003)(77096007)(76176011)(23676004)(36916002)(53546011)(26005)(52116002)(186003)(31696002)(86362001)(16526019)(386003)(921003)(42262002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6ZjJHcHB5Q0JhaVFtUkpGMVVJTTFleDlv?=
 =?utf-8?B?UFoyZ2M1eGgrLzhqamt4VzB1RU5XdjU5SUE2SXdOOUM3eGxGVGhHMFdMTit5?=
 =?utf-8?B?aDR3QUt5SXpvbEswVXVyblN1bnVzQUNsUEgrSmJtUFg5OTMvQnFaclFRRmtv?=
 =?utf-8?B?SHlqTUNvTDVvSXdwanh4dFpzUlc3T0NLcWdBb3NIVjVhQnlBdktFMUxQMGY2?=
 =?utf-8?B?V0pKWkJ3aTd4OXJGaldGb1dEdU5UckZNZnJXajlQOVAzWWVyRWZOOGdDUEgv?=
 =?utf-8?B?TzA1SFVSK2RJM0ZlWjRFRlF3d2o3S2pEdUNFYkYzVm5KUEJYRWxOMVZOQXJC?=
 =?utf-8?B?cjBGY2ZHTk5MT09BU2Nzek5RUGpubmcwSWpFTk9jM1hxS1UyT1FEU1FEUlFl?=
 =?utf-8?B?QUNRUGtoZHhJbTB6Y3RtYUhzaVEvZjhmZG43SHlMdGNPeElnb21jcXFnd3ZF?=
 =?utf-8?B?MjBUeGZ6Z0ExK09scjl4dGs5NjcxSER6V3JCL3lMWjRiaVVzZUdLcW1nSzZm?=
 =?utf-8?B?Tko0dXdsQXdzcU5ZR1ZGVjlVRUdUNTZhNzFVVVFweURrNmNQSkwzei9tdG5J?=
 =?utf-8?B?Zmd5SXJuQjk0VGR3WGFyQTFFd2QrMm5iaExxSS9ydHdiRUpZaVdqQ0xEaVNw?=
 =?utf-8?B?UDFxdWg2OUIza09QKzUzRFNrZTljMzlST0F4Skdwdjl4Qk1GbkVGVm5jajVH?=
 =?utf-8?B?K1dlUEZWYU0vdE5yaEdLa2NzenZFTUd0U3BDNmZxaHVsK1VVbDBwK09TSm4r?=
 =?utf-8?B?YlZPRFozc1dsNzlWdk11ZWV6ZHJNOXVnTVV4Vjg4Y3FsNWpLV3ZxTDZmSmZs?=
 =?utf-8?B?TW8xVXBaSDgydTRwMzF5c083UFNRUWdkbjhEMVlLWDhlN2JubFhpb2hBN2cz?=
 =?utf-8?B?Z2hscTkwYmtIV1Nod0lHVFBFc3E5bnhOUjBwcVc1NDcwZUFxK2RHc0pteCti?=
 =?utf-8?B?eTRNZ0dHZjI4b2NvTUNXcVp5L2VEWDNaY1JPclRNVXA2WUNDNEpnRHQza1d3?=
 =?utf-8?B?UFM0bkprQVJDT095TlRYNkJvN1F1ZTA2MVZwRmJPOVRnUGt5bXl4VUw5Mncr?=
 =?utf-8?B?Qm9oalVPVStiN1E5OWlOOGhRaTI4bHB5T2Z3aHoxQkRCK0dBUTY3VkxSblE4?=
 =?utf-8?B?NXpFa29vZ3ptQnN6UHZyOWtyZjJlUFF6M2didXBaTzdFbVhQZklXOU1yM1NR?=
 =?utf-8?B?czE0NEE0MjFmWk5heVExSkFsUkRsZnN6RFZDaVhtS2ZHYk1qczZLRTErMXdT?=
 =?utf-8?B?WmRQc09IMHcyMTcyd2JMSitESkovaTk3R2xaSmhzemVhTUJLZWRaRHFIYUx1?=
 =?utf-8?B?ZTltajJPTFF0dStUNEVidXIydkhaVDFBa29UbmNhdDFSOXBJRFZ0Q2IzU3dh?=
 =?utf-8?B?OEJQRFpIWC9UTzh0NlBrREdTUjlBa29PWEYvVWkreFpSNVpQUGRhUDFqc2lo?=
 =?utf-8?B?L290cmhRSGNIdE5xakJyN2Z3aEtVY0xkN2VseVQxV3B1MS9UaWZSTzd1bUx5?=
 =?utf-8?B?bk9RNjhUUk1CVzdWemV2d2FUU1NNY1Y0K2EraGVQbFBHRW5lSUk5Nk5PSDdK?=
 =?utf-8?B?RmkyQ2NnQW00cHV4NGRZYTVIQUR1SUdSMmExS01Mb1VCOXAwWFgrNUhiTE01?=
 =?utf-8?B?OU1GY203bDArWmZsekZzbUx0ZVVrNndVTi84SmlVUS9LdTk5VytBVlRpdDA3?=
 =?utf-8?B?YWg4ckxadnliUUN6SUFsMzA3enVkLzZsMGhYdW5HNmdvR25hdmFuVVloZ0Fv?=
 =?utf-8?B?OTU4MnRpaDcwQXBFUzNJeFVHYzd0WU4xa3FDQlpBbjRJYnFsOVk4bW9tQWFv?=
 =?utf-8?B?RFJML1BpczVrbXY2SzJJUy92eWNFdWxqaG9RekJGcThVQWNqazBadHI5UHlt?=
 =?utf-8?B?dmZqRVRzUW4wamUyaHhXVmRHKzBtaU96ekd6aElKbzNQTmY4UHFoNlp1MXJE?=
 =?utf-8?B?TUVFYVlzZXVmNVBDTGxTUmdOUGVSREhmMlZSQ25VY25Ed1lpelNqdVlteGkx?=
 =?utf-8?B?L01YQUVTQkdyVEp6RUVRY3BycDlmbnlOTGRWMVZPeXE0eGFFWXEzdlQvakxy?=
 =?utf-8?B?eWFENW9yVDdDZUg1K0d6VEZaWG4wdDVNQStYWlZwUk9JQzA1ZFBvUFU2c002?=
 =?utf-8?B?Q0FBWnF5S0hlSHlIazB4R0pKQmwyWE5XNUpnQWFaRjVWQjBZa3VlY0ZIZzhQ?=
 =?utf-8?Q?QtiGjjFUg+fWTP/c0uqoxhGcjF27ACRroDiRoXvFBtdw=3D?=
X-Microsoft-Antispam-Message-Info: tK9UQ4arRYauoN1zJI/HXuDmHQRuGGBXhCSDbzgNhmBvZyUZpB6RX3EOu86Lh+SufqKx6hDUulMYKdEcJ+F7OvDXwE76GrW+9D2otHmhZQWUYniDgVB/bZF04q233hpl9x5L3r05bFa6vy3shf40g3qwzbqY+3RI1TrSpj28Pu9IPtvliel0dCmLDJdEo2AA
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:LpH27e09tQJ+kCeV8vS0gI8gE2F5B7FcGaACVYgOXdM0ESn0EvP/cQ/VtM2mkHcBxEmEAUvdyXoFvVvrkKL2sFDqMaZpfYjmT1XtXYY3/Djk+pnOWNGLWFQBQ88KR7AffiEeN/MX5bGkzjw1501GX016slF60NUsOPk2rz3O8PEDRRqa1ly0E0v5dnaWq1jTOJOAhrC3Mi6XnGN3lV8MkdQDnU9sGByBfCfhJcYy5lpFSfBS8V0uH+zLfGdhpDAlRUxMCztBeRhN5x5A1ydljjRyzP3uEnjNuQU+MdfR/ui4OpQ+XkFaRTx8o/alQ8FiHfa79wn/HWKgbUMfLKRYCoaKy2t6Svw/kBv+QIOOS5ytXIDwd0ZGHGk/JGzWpMwUqjS2BjT1R1cd7xw3cgA6mJYGtya+8GssWITwBd2xrwasTezGMSnswGl4OBltE80XgNEEoMk6gKx7jfo0kcOO2g==;5:r0tMAcr4SxaB+1B9jnQaOPkH1i1qHofm3FOWNsXX5n09Qt2JllqI3P9NhhwVDreEM91hMAMsBQ8ASiuIuqaVgoDHTt7uO4zXNEsqR8fm7Pxc0SW4YHtuym3TxDRrzM8vBW9zYNaS6oZnMRw9vtk+Gx42X3jS6pU/nk8qt9qoOaA=;24:qkTAvjWzsREg1c9HbV18sH2wy6mSM3c1631e0A0xmuvMfKLIUSdIdMuzM8HF3zaM5UC0hF8Q765SBNOJtf9pf58mqN8kTE3f0GDONsTMoB0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:cQzGoZJssgmZe1sZLcKpAVMLZAjHeS42WnINOA+IJ5wjlbyM/uf92GWJuEKWQjj0Ud1DlXbFOPWO2/rv6XUvOFsgvR4HaWFylMiPmnXnuewjCepMMVQ/qwIERZd8q1GckrbQbfKWN9YDECJFwA5dARADl+wjSFtTr4xl57XsH92hLRDRceN5jnC10qRIAevF7/cJwM33wJLM/ATeECSCZfM3Y2LBoq14QFK5kBU+sAFfxrlz/hUE2foBK3r0A6uB
X-MS-Office365-Filtering-Correlation-Id: 1b1b7df0-6155-4da0-ad46-08d5b426495b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 14:24:46.7013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1b7df0-6155-4da0-ad46-08d5b426495b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 15:59, Peter Rosin wrote:
> On 2018-05-07 15:39, Daniel Vetter wrote:
>> On Thu, May 03, 2018 at 11:12:21PM +0200, Peter Rosin wrote:
>>> On 2018-05-03 11:06, Daniel Vetter wrote:
>>>> On Wed, May 02, 2018 at 09:40:23AM +0200, Peter Rosin wrote:
>>>>> The more natural approach would perhaps be to add an drm_bridge_add,
>>>>> but there are several other bridges that never call drm_bridge_add.
>>>>> Just removing the drm_bridge_remove is the easier fix.
>>>>>
>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>
>>>> This mess is much bigger. There's 2 pairs of bridge functions:
>>>>
>>>> - drm_bridge_attach/detach. Those are meant to be called by the overall
>>>>   drm driver to connect/disconnect a drm_bridge.
>>>>
>>>> - drm_bridge_add/remove. These are supposed to be called by the bridge
>>>>   driver itself to register/unregister itself. Maybe we should rename
>>>>   them, since the same issue happens with drm_panel, with the same
>>>>   confusion.
>>>>
>>>> I thought someone was working on a cleanup series to fix this mess, but I
>>>> didn't find anything.
>>>
>>> Ok, I just spotted the imbalance and didn't really dig into what
>>> actually happens in these error paths. Now that I have done so I
>>> believe that the removed drm_bridge_remove calls causes NULL
>>> dereferences if/when the error paths are triggered.
>>>
>>> So, I don't think this can wait for some bigger cleanup.
>>>
>>> drm_bridge_remove calls list_del_init calls __list_del_entry calls
>>> __list_del with NULL in both prev and next since the list member
>>> is never initialized. prev and next are dereferenced by __list_del
>>> and you have *boom*
>>>
>>> I recommend adding the tag
>>>
>>> Fixes: 84601dbdea36 ("drm: sti: rework init sequence")
>>>
>>> so that stable picks this one up.
>>
>> I just wanted to correct your commit message text - the correct solution
>> is definitely _not_ for sti here to call drm_bridge_add.
> 
> Ah, I see what you mean. Do you want me to respin?

Hold on, no I don't agree. sti_hda.c does create a bridge for it's own
internal use. It does not drm_bridge_add it, because all that ever does
is adding the bridge to the global lost of bridges. But since this is
a bridge for internal use, there is little point in calling drm_bridge_add,
the driver currently gains nothing by doing so.

But, drm_bridge_add might be a good place to put common stuff for every
bridge in the system, so it might be worthwhile to start requiring all
bridges to be drm_bridge_add-ed. And IMHO, it would not be wrong to have
the sti-hda driver call drm_bridge_add on the bridge it creates.

Do you really think it is actively wrong to call drm_bridge_add for
internal bridges such as this?

Cheers,
Peter
