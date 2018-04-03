Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeDCMzq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:55:46 -0400
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:12635
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932214AbeDCMzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:55:43 -0400
Subject: Re: [PATCH] drm/atmel-hlcdc: add command line option to specify
 preferred depth
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Egbert Eich <eich@suse.de>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180326073502.19259-1-peda@axentia.se>
 <20180328093454.4149fa3b@bbrezillon>
 <ce723d9f-6858-0bad-bffb-85ab036510ee@axentia.se>
 <20180403091037.GO3881@phenom.ffwll.local>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <6a0a1730-be02-758f-b411-776b9c751a3d@axentia.se>
Date: Tue, 3 Apr 2018 14:55:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403091037.GO3881@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::18) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6860e5-9aba-413c-5673-08d5996233e1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:hQ4rQjUT6HzabFe4ayePpySH8Hjqphkl+3ZwQnQhdSpBH/uM4dsPVMlWC8M8KbYvKPt//0T/IUQY5UXOr6e4DCGyIgCoHCW7Bz7Z/k/D5TzZqcbaZcuDrptvPZcNTIPEYtfuA00Q95tf2Z1rRXx5C4STQGLTpovCkX2BgHKMqEiXKJVK5gufejxSNQRZrsJgbuvTLeO9pnUJvdJfa42gdfeEPEMgXq1RufSCHP7zd5O/ijLBU6l2XFkrRN3HWotP;25:SJ8T0nyCpDHg7p7yxPh8MQuGi/zCQCfkKr33IcnMzkcvclT5TrNGp53PPWs2yX7W/6JasC1dZTlpMo5gXrs4XkJAfVsLKzgp0g7gs1p/u4dPIFsOeJFHDRLzmMLiJHjNku/bwpDKD1Y4I0EXZhDX2nRPshiIeuz2o06l194z8jApSSGUHYOiexz+JjluTwRkVMdj+//VfL8CCSTDG+UUVEQzHd4oH9fXa8ghbGKTgIiPOKBhRuAErahuvZbhkdkZwMf1jy0QBflSoMJO09SpYTDSxTmSsSieiUtegKMfg6zMMhBpoRAxDCgYEIvpyfcUkCceNYbERobWND4Vtqs1cQ==;31:BgXoZb8OmziuiUAiJGiXUWFOBh0e6y3qG42j/skXiAQq+Fw3Jo6L+GyCPTNtbJQx00c1Rl8TN9dhJX9MQxIT6KDtXF9ePIcjLYyDaamoMqv9KwjZ0rfp+bGV9YfovJc4FYj2DZjHO8o31RmKfgpSCVEbFKpcF3c1tS+QYnhIzt/+hSu5zOoU0Jf6ce1GdWnaRlnINfN4GAW5PKsS+3WJPFk/fAY5o86tciN/VQ8RR6g=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776F76C5C89C069987CD29FBCA50@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:y2XEZAJcBHs+Rz2b7tfnzkXp1eRto9IoCnr6g8lPMldTYq5Efl/i12MQlHDQkKiaa7GIAoqRwjAQKHPcaagplqriBCsOrbEuGnzyPaXv4IHpcsLTAHyG658j/CrA1x6KR4hbq5w9Vro+uOJqRikUYxeRNjqGbQyP78z3x5lj2RMdqwiqVxD04IKs4rnauDOE6aY6x1I5wdalmTPuYhGCLefPh27pyxhdFBR0SNpzvnePuC0iikWXuJKgrCP3C0vGiRXlESa9nqVvNSXm2xNLTg==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(39380400002)(376002)(346002)(366004)(377424004)(189003)(199004)(446003)(106356001)(77096007)(5660300001)(65806001)(478600001)(6246003)(26005)(65956001)(31686004)(966005)(105586002)(36756003)(229853002)(6306002)(86362001)(7416002)(16526019)(186003)(68736007)(66066001)(81166006)(6486002)(47776003)(81156014)(97736004)(31696002)(8676002)(7736002)(65826007)(25786009)(16576012)(6116002)(117156002)(110136005)(6666003)(53936002)(93886005)(64126003)(50466002)(23676004)(2486003)(486005)(52146003)(2906002)(53546011)(386003)(74482002)(36916002)(956004)(76176011)(8936002)(476003)(11346002)(305945005)(316002)(52116002)(230700001)(59450400001)(2616005)(486005)(6346003)(58126008)(3260700006)(3846002)(921003)(42262002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6dzNWUnpqQ20zRXJ4eDlZdVlYTjZLemN5?=
 =?utf-8?B?VlBaSi9rSzZLb29BTnRQQ29zTDNHa0Z6MzlidStrOExsZWJmeFMwYUU1VjNL?=
 =?utf-8?B?bVJIdk5sOXo1ajZGdytQNU1SU0wxYzJ1STEzdlF1NlF0NnY4NUdKM1lFckl0?=
 =?utf-8?B?TG8wcW5hQm9DV1EzdjVoREQ5NVdaN2FBQ0ZORTN2OGdjYi9nZm0wenJwNkVF?=
 =?utf-8?B?WXdoU2RtNTNtSjRJNEVaOCtQeDVjNm5uU3l4L2p4TS9oekRKUFhFc0RySXN2?=
 =?utf-8?B?L2NBdnhpZVMvSkVuRy9kTllQWE52UktkRVhhNjBMVWhiZkplL1NHYWpoL2hD?=
 =?utf-8?B?dXNuSDFySDBteWZvU2N2cm9tdzJnL2NrdjU4dnBmQzU4bTJvaFZ4b2FwYlFr?=
 =?utf-8?B?emI3Z2plOG1rVW9xcktKcjVtM2JyVlVadGlQRjg3OTdDSTJSTnQvdEhBUTg0?=
 =?utf-8?B?dzkwNjBlbWkvdU5QalpjR1FLbXRsV2QyaVJMb2xxcXJnRjJVSFJ3aG5EUnlz?=
 =?utf-8?B?VENaT0VneU9UNWVFZE9FeFIxOUpFME5NVk5SR214c1BGTVRUbVF3cnUwNGRZ?=
 =?utf-8?B?WElsbHV6aHNIOHZKM0J2dTVLczdyK01leXU4T21pUmk0RDVpRmE1YXdTeExS?=
 =?utf-8?B?cFIxdnZyU1hDbk56Yy81czFXaGNUK3JndmpQZERLYTI4Ylp0bnFIWlQvRjZI?=
 =?utf-8?B?VG5oeFJJckh6SlFOT2ttNVNXY1ZEeWt3c2p1OEx0Mk9NNUQ5RXlhS3FzLzU0?=
 =?utf-8?B?anNiRUR1clc3czE3M2k3SC9GakFaNUxaSW0zUW9INnZ0MmlEYjJDMjArZFpG?=
 =?utf-8?B?QTBjby80OE5YOVpORmZEREFGSDV1czZWK05sMVZ6WFFrOEV6bTVNNFFCbldO?=
 =?utf-8?B?ZDU4enlTc1JWTUJJdUw3ZlhRTDlxRzFNeXRVMkF2VUtOYmlxaXIxb201MHht?=
 =?utf-8?B?UmR1Q3ZhSk9EMlVkQlZzMkN2WmFqaHZvaFBweE5IWjFFWmFoS2E0Q2JEQVp3?=
 =?utf-8?B?S20xZHV6bkVxKzEzZFZ3c2lBY2JhL0NiUnZDWk9hWFlRQ1NpZlZlK3VmRWk0?=
 =?utf-8?B?RERZLzRwTHpHc254dGdDR0JSVENFRTR6Y1B2KzdoL3dEdHAvSTFpc2lsa2dG?=
 =?utf-8?B?UEtjYXh4aUVQMytpbm1mT0Z2TFhwU3h2SlF0c2ZNVU5hR25QQ1N2V3F0SnB3?=
 =?utf-8?B?UUxmQlhtcWMveTZBQUhGaS9WdFBERWREREU3MXY5bEsvZmFyQnNvc1llRXRI?=
 =?utf-8?B?d2NTbmR6Vk1uWkNRdHpRRmo5cS9LN0tsQ1p1K0dLT3FJVDVqWm5pOHdka0tQ?=
 =?utf-8?B?bE45cVp4NytNODVYaHlUczJhYjROak1sOWdWL1JXRWptOFYrK1VZRnA3ZnF1?=
 =?utf-8?B?b2NnSThIYjk5R1AzTUhjTElqZ2o5djJxdW9OSS9tRTE4aXRjNC93V3h0ZXJH?=
 =?utf-8?B?RUdoRzNMSjRjSFAwYTBrNnpGaDhqU01OeFNqM0MvdXdtVDgrTTRpUHV1Rjkx?=
 =?utf-8?B?OXFGbXRtT1ZQTEsrYUxObU5xVnVJVDUwZkcrdnRIN3NlckRycHdjdkdQblJo?=
 =?utf-8?B?TXNMSnFweVlHVGtuTUZzZ0FJZXNaNE5Ka1BoWDU3RzY4dWI4N2E0Nm1UM1RZ?=
 =?utf-8?B?S2pqNW9GNnVUNUdZSzBZWWFSV1UzRXllUlJTU2U2ZTBzdFQ0bTdKZ3pENWxs?=
 =?utf-8?B?M2ViWjdURDRkYzZwYjhRK0Fnb2lNbUk5RTFHMXNtdS9idmhFQ0lFY0Z0ODcv?=
 =?utf-8?B?b3ZGbUl6VmlXSnBrRldYQkJvaHVPbHN3NzBucGl1SExhNHlsZnh0Mk5vMk5H?=
 =?utf-8?B?N0VXbjZMY0NiL2NlUGdGNUNZUk0wcnRTUDV3Vm1DMUJ4N2pscGtWRjZYTmhR?=
 =?utf-8?B?YkVxYXdoQVV4YmZkWkVKU0M4b0V0WnVSTUtZTkFmRWFXbVo4TVRaWDNxMjFm?=
 =?utf-8?B?emVQVjVzTzRsNk1jbXMvekMrS0VuRTAvbk1UdEdPZXJPZ2t5dCtMVklwRUUv?=
 =?utf-8?B?UytOWHJCY2FvbU40TVZER2JuTE5RK2ZNVzkvRTJBaUswUU9uYlJZaEZoWklz?=
 =?utf-8?B?cFlBaDFlcEF1OFZLTkxKMTRNSDQ1Y1ZrTHhzdjlpK0pETkZubHYxdVMrc0lr?=
 =?utf-8?B?RFA0eFlzcGRGcDd1N1pHK1BIcDdZOWxwdkxxRmZMdkNFM0xIdUd4dldOWVlF?=
 =?utf-8?B?cFcxUlM3a2FNdFdLaDVwYzllUVRXZ0ltTUpQRlBkWEE3U3N5bW1uOEtCZGNj?=
 =?utf-8?B?MjBDV01UZVZORE5nVmlqRjhpV2lONm9ybGRZbXVKK245Ny9saUdnTS9LNUlK?=
 =?utf-8?Q?FJ6aJWz4mpMNedE3RA=3D?=
X-Microsoft-Antispam-Message-Info: GCFqNLx7yHelmtDviprgjBWB52xOHs3Mo5u0bOvsZdeuSBWlWjlWqiWsjtfPFAmptZit2hAPAv8tn/xOWt+gDOqX5ZSQBJS1HwURKiBi62LXpPWzMDbIOW/FYor0s3+CRPGAWxjAKGdKc5x5vzLI3iz3YEFkWcQIQ9ej8SI3425JkJK/GJhHr9dYBdEQhD9p
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:JjlQ7e9sK2REgmXLjgZa3hXn9aZqCV41T4YkAqCXlAMDz6TL75NPhtEz0Jpt9lXK88hOMAjfpp2jQDQ7C2mPsGonzzlW1QjIjYOvaV7DUaU8XwxW9YH+apojJMGHEvzakfpStQ9abQkO4Fmi3sk5CPaJiSK7hKz+KFFWbYn8V+r7ZLqRxzfNqv/KhzFItXm00JevW3ysDkJOR2y6H1f1UzKcFPopstRBL3XlVDjoRp/4PUIKqJenTd8yiHmP172RWxSnOXIjPb7qj3G4xAToeq03o6t6rGGIx1ZlW0EEptOWP9afoIc6aEWLwX0PpBaEx58kDCtyCsraajySVIdKre/VFr2QX5PYyLo1vSp0LkefGwXnI6+rCClHJmAgtHiBghG/eC5KZBgtZehGRBTZnSgKkll9B8QFerufur0krtTAk9AZbBO065JwiMm4nFp88xSp1BKJN0ov1z8YO+d3wA==;5:ZQFhIYtIkHDFY+iLcfFnQlaMTdGIVIdAuw7y2VM9aYNV/WraMMZPcAyQLpBbN5Ne5/q6kKifMB7p3omETeAMGbgrbGRssJNVS9a7W9I59jtRZ9Hue7/jjk0Wxw83qZa4rj3yQEn1PZOCNJSBsRZsuUk5fZBYCQ3NgCBgO+PRzOk=;24:sGGgZ61Wl7O+hUbdP2lqBY8uE9bFrUTiPjb5LNCL0g3hEpt0DT7q5FN//n4KASwM2m6+Rdp7R1Y6emWPrwHXZgpE79iUmWqqXLSh/iV4F1A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:Po6wVpn31vlAYghEeL5AG/sCB9TB/0I6P1W0Y6qLAG73+uh1okr2o9aDSQ0jd/vVY/fzgEgYdH/I5oUnGssRcnDOpSVGFdFUeI5BzXurpZ5eorT6oNQ/o5ci/oh4SEjfdwMTEgIiK2qRDmM9/io87fgHNYb1TPTLU+9ye6AazB6BMaB8qwIedfHvugB0eoMHy78ef+fn8EzmnnmpqxBvpXFsc5r3r8PG6NkviCRRyRozTn4/WaqSQVQ1ub8++b5y
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 12:55:39.0606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6860e5-9aba-413c-5673-08d5996233e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-03 11:10, Daniel Vetter wrote:
> On Wed, Mar 28, 2018 at 12:03:39PM +0200, Peter Rosin wrote:
>> On 2018-03-28 09:34, Boris Brezillon wrote:
>>> Hi Peter,
>>>
>>> On Mon, 26 Mar 2018 09:35:02 +0200
>>> Peter Rosin <peda@axentia.se> wrote:
>>>
>>>> I have an sama5d31-based system with 64MB of memory and a 1920x1080
>>>> LVDS display wired for 16-bpp. When I enable legacy fbdev support,
>>>> the contiguous memory allocator invariably fails with the order-11
>>>> allocation for a 1920x1080@24-bpp buffer (~6MB). But this HW can never
>>>> make any good use of RGB888, so that is a wasted attempt anyway that
>>>> would also waste precious memory should it succeed.
>>>>
>>>> Sure, I could rewrite user-space to go directly to KMS etc, and that
>>>> makes the (attempted) order-11 allocation go away, replacing it with
>>>> one order-10 allocation per application restart for a 1920x1080@16-bpp
>>>> buffer (<4MB). But after a few restarts, order-10 allocations start to
>>>> fail as well, which is only to be expected AFAIU.
>>>>
>>>> So, I'd rather not change user-space (which was originally written
>>>> to target a smaller display) so that I at the same time get the
>>>> benefit of an early pre-allocated fbdev frame-buffer that can be
>>>> reused over and over. But to do that I need to tell the driver that
>>>> 16-bpp is the preferred depth. Add a module parameter to do just that.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 18 +++++++++++++++++-
>>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> I found some inspiration regarding naming and implementation here:
>>>> https://patchwork.kernel.org/patch/9848631/
>>>>
>>>> I have found no feedback on that patch though, which makes me wonder if
>>>> I'm perhaps barking up the wronig tree?
>>>
>>> Hm, isn't that something you can already overload with the video=
>>> parameter?
>>>
>>> 	video=<output>:<resolution>[-<bpp>]
>>
>> Heh, you are right...
>>
>>> AFAIR, <bpp> encodes the color depth, so what is the benefit of adding
>>> this new property to overload the default depth?
>>
>> ...but hhhmmm, I think I will have to have to encode the display size
>> in the bootargs so I will have to use distinct barebox environments
>> depending on the panel, but that's no biggie.
>>
>> Splendid, please throw away the patch!
> 
> I think we could fix the parsing to allow -bpp without the resolution ...
> Not sure how to best do that though. Maybe state that 0x0-bpp means to not
> change the resolution from the default?

That could be done, and I had a quick look but it's not immediately obvious
to me how that should be accomplished in a fairly localized manner. Since
this is no big deal, I will leave that as is and simply specify the screen
resolution along with the bpp in the bootargs.

But I do like the idea.

Cheers,
Peter
