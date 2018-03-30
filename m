Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx48ry53/jqAJeVCxkchUQ5TH6Zr+8AgYTxwy5WDzv2cPncsMGX8eS5DZhBXgpRmM2RN1Vj61
ARC-Seal: i=1; a=rsa-sha256; t=1522449494; cv=none;
        d=google.com; s=arc-20160816;
        b=huSihZSY80Ovt1BLel0GEnepC2eUy42SLYs+GNaXiSSlzG4wO/pzN8O7mVXcz0PLVM
         iGNFhqzFKEWfgOcDkxCIJIFMOYwmFknNCOb97lCkHhPCUH/+pAQRTzsOX2wQ/hA/HhWl
         /vrRt2jwyBgy4aqn3MHs83SpTxvD2s4Em8gPT0K09i1Iu0EUVPGhwxtza3AEBgfTPehi
         fD2ZTgQjK95rXLwXpaf0MFYNgAlH8aLYcvZYoTW7yRkhMYF1ItNPNlP6YW5RgbAoYqYj
         LIzkHtmWjlt0D5qtJ5lio9zlYsA17yUqMd3rKsL0oHGpQScmmXttpfTmewpkZ74PjrPG
         ESTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=6KmAwl9LMTROfp7y8jtifP3gZtgbI6+PIQ5dBYmIEJ8=;
        b=qKYdH/I7IQkjwSAMpGpQ/HBBnqGD/gYHsuyx/NaBA6vfpftvA0FZ9K1FNgW1Rdj95T
         Fs3v9E3qbh2Rh46HOQYmlABHfDbzHj84TTqr9cl5i9j5tsJQtRAAzfZxbCb5g6DPZRiH
         kINBfL9NplW2xQaXOpQQLRU5/0n4Fm7PfunQyOO8NAdKnEUIrQLdlUlLRQ42N2CxCuse
         EZk785EzOKeNh35xQkW83mZziPvql4z3/mYJJUtT+uZSCn5aAX2RkJT4VwVIUflM0ELH
         BQGo7BrHGdN23Czqd2ETQvEHi/sY6SKF7DjvFlrhJ9oxM8Tg0fQv9j8xRypP/GLeEGKx
         vJsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=TMQQtXus;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.2.122 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=TMQQtXus;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.2.122 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/3] dt-bindings: iio: wrapper: add
 io-channel-unit-converter
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Mark Rutland <mark.rutland@arm.com>, "David S. Miller"
 <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180319170246.26830-1-peda@axentia.se>
 <20180319170246.26830-3-peda@axentia.se>
 <20180326222326.sxdeawy5x5bjkla4@rob-hp-laptop>
 <986a7404-e157-6a1b-0610-07d1e127465f@axentia.se>
 <CAL_JsqJ3RZoMX+Q5boK-w3uHc=qgPCye7esXxJuwQcMM0HPLNw@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <96e221e1-9f6f-40cc-1b80-6d33acfdb933@axentia.se>
Date: Sat, 31 Mar 2018 00:38:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ3RZoMX+Q5boK-w3uHc=qgPCye7esXxJuwQcMM0HPLNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0312.eurprd05.prod.outlook.com
 (2603:10a6:7:93::43) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6335b1-5a8b-4bfd-c8cd-08d5968eeb0f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:L1pYtkAwjPxix2QQm6IsOKy3f57FcVLnADzPdocT0EFGGir0Cb/hzpJRx7Z66N4eClVtAbsesDGvUVutx+bOK50E3ZdkdUpVpm79qXzMoodtiBf2QsvZgXfe437xZ+YdGfngpQA9n4FbXqNIL5EX0ScpDkp2S6UVLiuAglC9b5cZXcJTmJNio3ckkPVPQAv51Cr1OE3TEinlThZ6oyiCPY0dENeSc0NuZJSmHl1/xQV49pmqivR39MY7/HvFcEJ0;25:R2RY6M5Cp0VOMsNwmznwKHSJKRV7tufKcT6qpW6ezHrAmrCIuqDzOeWGdMcevKCCSzy5tHomzcPAXbcBijBHw26PUO9W20Y2h4Fp1SqP0FLhw5b5xvT/K8vs2s7RHjSRMIT2S4L7ldTC428+OiMf2w4GAyvYtEzkpiACIvcQLgJk/AgfIMf7YH9z5pemeGdDrOa0BlZUbgIGY+l+Sy1C64+aoBPdwRHGfZ1fTdRM3Doqd+u71en0YEKJFeIoBbJ7K2qQ5LFb2c18KqKpI7ZuOMMTkFc8VD/QpW2/MORn1mk1nJvdkoOoi6Uo722TKxOCQJKvqtN3qy5rrz2fJZu/Ig==;31:TwzZSp3OubZwpb38QZc1QA7cnURYZqUXKxwmB+RL8B5Ht+QGd8eqAp8owZZuLB4uQ6IEAhKRCXGGZxRppODgT1TJF2DGwvHFCCQLDSYNEvVaisX0wcqsuGb7DrEbyS+4jIpRzMUG8ddGIzdp4TKQkDZ23jBUcgFcSYWaXxRCj30c0NwaGCm095i3x4CnRZ4qJghkhMbJdfL12Iv2o5Zn8E66OAEikS6Gg7y0IFjkh04=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2777DC3A2AD67D60B992434EBCA10@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:eHp1fZ8VHkuV5tdYvTgFNJk5EYWUKWiuZUY/OXCwc3iddFRL8hmyY97Pd106YErcaGOe+qani/w9x+MLniXlWqrNjpPqN7wtQHsNK1uWgGV1JRKJlcnaiRWvtcOAuFMaPqE6D6yG1F8a6GCm89WCxLls6wtjT/mzPWcC1+f7nnTym2NSAFG5vmE+TOHtndFypZmOQ8YSi1ymyxKm3ipjVcCImUSOC5DXyAm0Ln4F59AWHJMMHoVxORtADDnXqyByD7cSeo0ylWWdqHAqURmHeg==
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(366004)(396003)(39830400003)(377424004)(85664002)(199004)(189003)(97736004)(386003)(52146003)(105586002)(65956001)(6666003)(47776003)(50466002)(106356001)(2486003)(53936002)(65806001)(446003)(64126003)(956004)(8936002)(6116002)(52116002)(3846002)(76176011)(8676002)(6916009)(486005)(2616005)(53546011)(486005)(86362001)(74482002)(66066001)(23676004)(31696002)(36916002)(5890100001)(11346002)(305945005)(31686004)(7416002)(8666007)(77096007)(6486002)(16576012)(3260700006)(478600001)(93886005)(117156002)(25786009)(54906003)(6246003)(5660300001)(16526019)(65826007)(68736007)(229853002)(230700001)(58126008)(26005)(476003)(2906002)(36756003)(7736002)(81166006)(81156014)(316002)(4326008)(186003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzc7MjM6UGNRaVoxMVptMmFHYTZ2N0lCclpPQ0k2?=
 =?utf-8?B?WHhrcDdPMmpUb054SFp0T2NZMDQzd1cvS3BVMG1DeFF1T3FoT0dROUd3SWpO?=
 =?utf-8?B?T1JEbnRwcmpSZ0RoVDJnOTJKbFZLNi9pTStEbnBJeVZESWlwYWJDZWZHRGNH?=
 =?utf-8?B?a2ZtSWhTNktOeEJYbTV1QjJYaXVhcG1TTzh2Q0xKQzZOb1d5WXg0R0hQWnBQ?=
 =?utf-8?B?dS9QWUlKNURnaEF2SU1vTzg4cFI4SWFycUVLOU5hUlVETjlvUVpFd1V1Zmoy?=
 =?utf-8?B?RHBhZHpUU2pMMFl4azkzSHI3WmIxM1RIRUtIWUxDdFlDUkpBUStTWVk0M25l?=
 =?utf-8?B?Smp0ZjhjcWd6TU93d0JGMHZQY3RpTVdYVEJHU3dqV2YxeGliY3o2ZUI1aDFy?=
 =?utf-8?B?MWdNV0o2YXFWUU5LQ1pHNWErWTNBMzg5TUZTZFpvcVk2TTF0K3FJeEZnTDhB?=
 =?utf-8?B?VmJZL1BtbHRheHcxcVZwTGRNb3d5QUIzL0hDWmlMR3RsV2FKVEtjY0tHSjFj?=
 =?utf-8?B?RTBSWWVpbWpzK05YTDdOUU1vSEdsUDNXMGRzNGIyQ1BWdENzUnZsSnRiSVov?=
 =?utf-8?B?Q0Jjcko0S1U0OWFFS1ZxK25FNTJ5elJxR25ROGZDanhTMXJCaHpQa1l0L2Ro?=
 =?utf-8?B?SzRzSVBYbmQrYmFBQ256OURBZW45SnZmdDZ1bzUxWERJQ2Qrdno3cjJZeGg3?=
 =?utf-8?B?ajBWTE5xUE9tdWFabnFJcG9yYmx1MzFnQlA2NHFnNWxzYjJjQU04U3hDclpE?=
 =?utf-8?B?aFNYM0o0RHQ0R2k4SFpEalZFdGc4cXkxNUZheG1Hd0ZVdlNYQlBvL2Z4NXE0?=
 =?utf-8?B?RWlSa0hKTDBGemd2QzAwMzYwTUh6RDZxY0I1TjZISDRGYUdkdkxHRHlUN256?=
 =?utf-8?B?OHlJSUt2bjBDemYzeHZzT09ldUcrdDA3LzNIU0phZWhnU3pOQ2dYRmhkRDNC?=
 =?utf-8?B?LzhuZlJKbERNQmJWQjNyOHdVekM5R1A3ZzljaXVHWmhkNVVnWDFncXUyaGRx?=
 =?utf-8?B?dGg4Ym1EM2prTDBUS1VZWEtYM1hoS1UwMHR4UldiVlEydGpXRVpvTituQUNj?=
 =?utf-8?B?YnQxdnpsV1FSQ2xGaTZERVhpcmIrYmVVMWEyRkdEM2F6dEh4bUYxODFMSXJX?=
 =?utf-8?B?aFZ0dEVQV0lQbTJsaFM2OTBlNU5LWEl5MTRjamorNGE0bC8rcTg0aXNxVWxj?=
 =?utf-8?B?Q2FrWjQ1VWJsSkJnaVRCYmJwYjErdXM2ODBLd3VrWlkvbEl4OFhBK3BHL3Rv?=
 =?utf-8?B?R3NpVW1RUU9wZlpJclpOQ2hDK3AwZXJ4OTZaeUVzWGFoOFZSb0l3M1lQQWlX?=
 =?utf-8?B?SkVvY1ZqUnJKaWpyL0pqR01Rbjh5dlVobzJZam9admIzQVpEd3l3RVliU0Ux?=
 =?utf-8?B?MGczZzNVZmFmYVVyRFJsQVNXS1V1ZW9OK2xwOFNzdFdsUjFZUm1OcWxMNHRG?=
 =?utf-8?B?S21KRmhRclQrcnMyMFduWHBCUlhQWWNuZzZLVVozVmYxLzBaSXEwU1FOL2JQ?=
 =?utf-8?B?bGhtZEl5KzVNd2w4OG1ZazVSSW1LeEMyUFZBYTY5MWZWZXc3UnN2TlZNU0FF?=
 =?utf-8?B?SVFmd0JkWkg0OGY3STRDWUk3SHI1c0t5dGM4Ym1jSHV0RU01TjI5eGRiYmRi?=
 =?utf-8?B?by8zTTNsblJXQXFJK3cwc2JRTXlOY3dWakM1RWhLMk1nY3BPV0dudDllbHpt?=
 =?utf-8?B?eW42K1gwSlkxV0V5R2YvRThpOU1IVGFnTzdVTkRVbWJjdjFFcDdsclZiVFAr?=
 =?utf-8?B?angvWVdPaE1UcUhwTTdjNytXcVR1YWRoNEdObzMrT3NzNittN1BzQ0FFVUNm?=
 =?utf-8?B?TXVEMWR0ZGZ4b0xHa0hUK0hSYXBmME0zanB0MWk0eHlRYXFacTRWc0E2SHdO?=
 =?utf-8?B?NUhXQU9paTJPdWEwTU9NamQxYzdEek1IcjhHQ1dIYXBKUUE0SmMxc1lyNVVk?=
 =?utf-8?B?djkrVFpsWXB4andrQWxWREtVdFM3WE9xNmJESjFRVUYyaWVYeGJlZXQyWEFi?=
 =?utf-8?B?aW9LTkV4WVRUb1hCWitqUUpZL0Z6U2lFRDIwcmdlTzlNeDVTZ1kzcWNIZkJn?=
 =?utf-8?B?dDdCeTRHcm1ZYXRoOUZTVDBQVEVmUDhjR21kVzI2MFBnZXhBbCtLSzE0eFJB?=
 =?utf-8?B?VzArK0R3SUN0NHZrYStnclFJSzRGZTI5TklESFpvamM4S3NOK1VOSjBPUjBW?=
 =?utf-8?B?cEpSMHNGN2dpRkxLcWZ5RE9aMHppNkozYWl4b3JieXBiRVNFTm5VSzlpSDk2?=
 =?utf-8?B?LzdhYnZ0eEVISXlXT3RscG16WnlnMHFMWVRIL3JESXRIdmxRY3QzdVdWbjI0?=
 =?utf-8?Q?XQKD/En9X0VYTEJDv0=3D?=
X-Microsoft-Antispam-Message-Info: 5cg0Cf5fsCKvF+DyatpALVzvD3d1GiZQ69dssQzsdSaEybiPOJfBiSi+yM5y0nX77Augthh0H2uBhRx4o5twwS4SaBeyzzNbPNux/mVPe+MZmksxlkzgyuA/Z79/mnTEHhNTv+/pIUNUEZkv2mIyD5OBKW+SL0XSalWhJsHkc284BvBpdTGRJLnjtYZU2CKl
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:2xeKACV2dZdIfwvDInN2w1qZ39RmmHgJ41bkoXy9mb3lI12XybzI93CGO1an7you0v7+F4AAC7rozjSMNN46z7E/h8bhckS6AlQkTTqJ4eXuvdQez6aj0tPTBXWUs/3KX1J9BdGIf8rS/Jz8xykF3sZPR/biuRbm5UZeo7f4gTg4KDgP2o4vEyJzg49YsXKh7pqI0w2mHvwFm3bVQxyUXzYJFavTRMxqavha9M/+WnJqcrIqaLbe9j6wQe1/F+iGExox0ydKQxUBmvzmeLD9yLMIkBXtRsruObGd9Ruvt8CHqyXnmXJgDjjbcqO/P5Q5a+C7GfLxECp2SXihOp54V42ETwdeBBU+vHan92mwGsfvjHPWoO08JqCoIuUcFUV/uxo4YfVVNg+mZK1vY875+wx+68jxtQgULrYG3veAh3mqnpY4oEeNz5NYSJNB7SKM6EXMTsEgmmlkLdssLoaBfA==;5:cO27qtA2iimVWwRp6QscJlu3ZlCGR4Py5+isfgYv/eVFwcn0m90FXGy6wo75iqGkB84QTJgxV8uI6XcXGHl3GaI+kbxQDqTwDi45/n+YetfR0B1U1fSQrLVnNppAs2+WFZ5IFohsV7YdBhw90lYmODFl9xlY5TlVubaZY16UDDw=;24:YhqsB6g+Pxo9OUUi5dMzWXCEtNocKlfNxI0s74iB6cOUxjQ5mAOrKiyON1kmaySiroCqwzp9o1ItX750L89xNRUBq+VZu3LoeGbvZRJgR+E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:MfmEDesJHnhItDld2Z/STvNo+E5AwPXdmDCLbIuR7BuRGCgz7Zwdq0+59Ap/99aHmd9tWm9FmVoSZ3mDu/pkwdMIni2Bfho9WkFYkgYtHELAbMu9ML3BkgITeDXDmLKVOvXDsUhU0fuzISajs+8vWV2l9aSXoKwb5/vPEFJDegkSmC+41SaKuSBPTskw50Sgig5wuRhbnRda/LGDsXiEngeSk27OyMCYLpP+pNFmotTtf0mg43nd9rPe8PrcVi12
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 22:38:11.2089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6335b1-5a8b-4bfd-c8cd-08d5968eeb0f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386352511078978?=
X-GMAIL-MSGID: =?utf-8?q?1596404001338282881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-29 15:55, Rob Herring wrote:
> On Tue, Mar 27, 2018 at 3:01 AM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-03-27 00:23, Rob Herring wrote:
>>> On Mon, Mar 19, 2018 at 06:02:45PM +0100, Peter Rosin wrote:
>>>> Allow linear scaling and modification of the type of an io-channel.
>>>>
>>>> When an ADC channel measures the midpoint of a voltage divider, the
>>>> interesting voltage is often the voltage over the full resistance
>>>> of the divider. Likewise, measuring the voltage over a resistor is
>>>> often a way to get to the current through it.
>>>>
>>>> This binding allows description of such hardware which is external
>>>> to the ADC.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  .../iio/wrapper/io-channel-unit-converter.txt      | 84 ++++++++++++++++++++++
>>>>  MAINTAINERS                                        |  6 ++
>>>>  2 files changed, 90 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>>> new file mode 100644
>>>> index 000000000000..23af661abe32
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>>> @@ -0,0 +1,84 @@
>>>> +I/O channel unit converter bindings
>>>> +
>>>> +Allow linear scaling and modification of the type of an io-channel.
>>>> +
>>>> +When an ADC channel measures the midpoint of a voltage divider, the
>>>> +interesting voltage is often the voltage over the full resistance
>>>> +of the divider. Likewise, measuring the voltage over a resistor is
>>>> +often a way to get to the current through it.
>>>> +
>>>> +Required properties:
>>>> +- compatible : "io-channel-unit-converter"
>>>
>>> Would this apply to something besides ADCs?
>>
>> Not that I can think of. At the moment.
>>
>>>> +- io-channels : Channel node of the parent channel.
>>>> +- io-channel-names : Should be "parent".
>>>> +
>>>> +Optional properties:
>>>> +- numerator : The parent channel scale is multiplied by this value (default 1).
>>>> +- denominator : The parent channel scale is divided by this value (default 1).
>>>> +- type : The type of the wrapped channel is modified to this type. The default
>>>> +     is to use the same type as the parent channel. Recognized types are:
>>>> +            "voltage"
>>>> +            "current"
>>>
>>> This seems overly complicated for just describing a couple of resistors
>>> on an ADC. OTOH, keeping the ADC node and what's attached to the ADC
>>> separate
>>>
>>> Perhaps the type should be part of the compatible. For example, if you
>>> have a current measurement resistor/circuit, then the compatible should
>>> be based on that.
>>
>> Is a compatible like "current-sense-circuit" too long(ish)?
> 
> No, that's fine.
> 
>> Is a vendor prefix absolutely required?
> 
> No, it can be common.
> 
>> Sure, I can use "axentia,"
>> because we "implemented" the circuit this time, but it seems like
>> the list can grow very long if we should add every vendor that
>> may use something like this? Something more generic would be good
>> for something as simple as this IMHO.
>>
>> I propose the compatible "voltage-divider" for the other example,
>> but I have the same issue with the vendor prefix. Even more so
>> in this case.
> 
> "voltage-divider" doesn't really say what the purpose is.

No, but it says what it *is*, which is pretty much what the compatible
is all about? If you have, I don't know, let's pick some regulator, you
don't expect the compatible to give any details of the purpose. Not
other than regulating of course. But a voltage divider pretty much divides
a voltage, much like a regulator regulates, and that's it. The node name
should be what hints at the purpose, no?

>>
>> Then the above type can be inferred from the compatible. I suppose
>> I should write the above two bindings as two separate files?
> 
> One is fine if the only difference is the compatible.
> 
>>>> +
>>>> +Example 1:
>>>> +The system voltage is circa 12V, but divided down with a 22/200
>>>> +voltage divider to adjust it to the ADC range.
>>>> +
>>>> +SYSV        ADC       GND
>>>> +  +          +         +
>>>> +  |  .-----. | .----.  |
>>>> +  '--| 200 |-+-| 22 |--'
>>>> +     '-----'   '----'
>>>> +
>>>> +sysv {
>>>> +    compatible = "io-channel-unit-converter";
>>>> +    io-channles = <&maxadc 1>;
>>>> +    io-channel-names = "parent";
>>>
>>> parent doesn't seem to describe something about the h/w.
>>
>> Extrapolating from your first question, you are thinking "adc", right?
> 
> I don't really have any suggestion. With only 1 channel, there's not
> really much point to having a name at all.

Right, I'm ditching the -names line.

Cheers,
Peter
