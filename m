Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx49lB3Qf6O7w9qem0efZTjC2GoMr8K60fdHdBEZ17Py47hAEZUP+un2PYg+PlK6cBZEjwZds
ARC-Seal: i=1; a=rsa-sha256; t=1523272351; cv=none;
        d=google.com; s=arc-20160816;
        b=lHu2DEGrlA9J0TDALk59hqlK9oIm5+Ms3sHKNE0XRUTHpy/5h4MXp8dBY6V1Rzg2iz
         0Ra8xrvomxMWWA5wpb91LBsOhJF1F6PccUxG27SfPNvFjhrjSY8szkrg0AdTTARgf+JG
         vEib4og5D1KdU9vIzf1r0vf3nHeE4AQHpM4iTGKQbWlCcuN7efQ69cMaI/Tasj1NnMLO
         DaxMlcS1qKCzDI/loXi0mKjehO4x+U+UCGnTY2ENfBBw3MzKfebtwDprwmk+mIlvxP7A
         ypxgKPAWJBZQZz4oGq/8TAxLseWv775BUOR2+LIEtxwIq9KmXhRR40vIHVrtKbYVChvH
         a6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=vn+hkzDsdIpId7urPG/5gRESBKNQMb8HhMRehVsl0j0=;
        b=raw1QhiUO1J+E2jIDBTInaA3gcRqPqAvxBZAWkkEV6KFTJB8L0tR1XCffVP9L5DA89
         AiNII8wdz3IwI8lAQJO8ElMnyeexZolzCpTPf1obPvBRWY3hD36Rv587w/zji0nE8t6l
         U2qfJcZ+STDU8ev93S7RPecJtqe//88tDa6DjMFvC56BZBkx6HF6nlQee0nTg3Af77/G
         O3QUw+RWNGhBCbtGKHCGerANujDd27tND3DMvKyI+ZpRnMrtYZTFN9LR+U5KyoRIRuXi
         riUKBV6sWl+OvCeUqbicXc2Pa1Ykn2T1WfKsfzZlYTzSIzL35UPnM4Y206bVqHOcluj2
         Urgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=LER4UdFd;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.109 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=LER4UdFd;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.109 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: afe: add current-sense-cuicuit
 and voltage-divider
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180403153635.8228-1-peda@axentia.se>
 <20180403153635.8228-2-peda@axentia.se> <20180408175031.4945e2d7@archlinux>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <bee99a81-b7ad-8881-f5dd-647ff16a300c@axentia.se>
Date: Mon, 9 Apr 2018 13:12:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180408175031.4945e2d7@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::24) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bea1c55-7ed7-43e9-a9dc-08d59e0ac689
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:EEtU2u0jmA8cMW1/EZlFHpwaJNEVL+yiNMtRfGbXsaaSZPGwai1gTv59VuZnKKQXluvRQ1lA/eAc0y4U5yjEfxdsHEoyUhO+MPjZNQilzRCP/ySBmTIP8hd5QznPl6l1zRCCIGZBeJvoRYlIOknP0BdLEhh28eG3TIa4prXEYFO0tL5E8ZV2ngZ7sU/WbXWiL0a4twfXagqqBYzk80mbxPCYoOrnxWu4oE3YtKJxYDkKHUIussTz0UvPh2E2OSfr;25:JE3wZTh7l5xPr1okLSPI6Ikrlp0+BD+HMWGGWo7ZiZXrC6UUA9wG81BbTxAdJKfNIoc6kR0vEK/RS3CiYd7wfHu0l9KG3Tm9enuj2kj77PNhzT+OIuntUqrrlerOSHwkrdP218NtAyYdZrnL+acEJYBqHeeM2KN0hgwxSNPUnFJ3fuaGLoJewcixU5kUnoDlvKqlNdy5BDhd6ptCA9Fn2n6hYEqZ58BbIzMUbqCs7sjfYh3BZWukL63+8Hw34mWVbSqKYb36mE+Cv/yiKjr2DXS60i2oXXHQbsQI5G4jhwxMi6aG0bo4jaO/rQoHHMV+eCzIdMqjsBQNPlcjmA4/iw==;31:zTZdiCmm0YSyjyae5KzGGoLdIYlKsGenAoJ00GiCvYNgS8zD8qb9vnzura0jbhHjNwlIga93CuuKAA/ikNA80eHnWv49+Exu3+9UILlXSwSZXRwhE544grvPUbW/a3izU6cvYEvUJs7OCfCfi2V5r/wJs/RDqphKq1mgY8sAHaQfh3/t5hRybh7lpvIbUeaS/5nesGpLvI7fhGHv29j8Z2m273Ga8USLburFKaVxvqE=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778C59E07D5B595C6EE68B2BCBF0@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:IH4XBw3BQ+QXCsCLThWM81Rm9l90xdcwCuceGX9FuS+Y41Cg1R0KHieZpfH6AL3lhFu9oPY1qCtzmMl/v3018hzrO9kDuF+U2X1LvTDz1nY++4gfA+2W63cyeQDW9WKbCE6QAvOi50ggnbxRU9i70FPVtHAD99p/PXYWo8jmNn+8bS96ceTMJaRym63Emu66QibcNqSstBfOm5m+2ySJEPHsRoKPss7P2Axjgfs/jN3wEvx+6BCNRyOg8z6WfhfIf+NI8XB/K/5e0dbju61K2FkRHl0/WeqIHQ7M/LZMchR6lC8zbfSj2y65dstBu2IMafLEm7puHBLOqaHGhjavMyDeHqAweRa+GBSsiK+DYDk=
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(39380400002)(346002)(396003)(39830400003)(52314003)(377424004)(189003)(199004)(23676004)(36916002)(76176011)(386003)(53546011)(6246003)(52116002)(52146003)(2486003)(74482002)(7736002)(81156014)(81166006)(8676002)(486006)(53936002)(68736007)(7416002)(8936002)(305945005)(5660300001)(966005)(65826007)(59450400001)(36756003)(186003)(47776003)(97736004)(4326008)(65956001)(65806001)(66066001)(50466002)(106356001)(26005)(77096007)(230700001)(58126008)(316002)(16526019)(16576012)(54906003)(478600001)(105586002)(229853002)(64126003)(8666007)(3846002)(6306002)(6116002)(956004)(476003)(86362001)(6916009)(6666003)(446003)(31686004)(2616005)(31696002)(2906002)(11346002)(117156002)(6486002)(25786009)(3260700006)(15866825006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6dTBlUXBMaHFZMTgyY0xiaHVaQklKY1hL?=
 =?utf-8?B?bU01TzhxT21sSGV4d003SEViYzhEcUo2TGdFN1FkZ29CZW1OVit1RkE2TVFS?=
 =?utf-8?B?UWMwcVFmbXYySmRsTEE2dm5ZUlRkQmtaR3VUTHlaSG9CRWNhanBDeVExSGk0?=
 =?utf-8?B?UGkya0lPaE0zQ1l2cXZiOUZnT3JENVRmcytSbFBPMFJIM25QMnJzaGl2Nlh0?=
 =?utf-8?B?SlBMZ0l4VUZWbXhNYTllZWlGL0hxOVNnWlhNaFN5Y0ozQ3hXb1l2MHgyRGl1?=
 =?utf-8?B?OFRNK1VjRDVpb1dvRUMrTGNDWFlCZXVsSXRZVGsvck8wZklrNnlobVdHeU1R?=
 =?utf-8?B?UHBHZ1FLTllaYVRBaGFjRFRXOHhQdHRXdjB0SHEwc2t2a2pIMktVc20xZEQ5?=
 =?utf-8?B?bktBd3BUMDRvRUpCelhaWDRmNEhtbmNtRkpGSXlmK0x6b0cvMlVvOG5QSGV2?=
 =?utf-8?B?ZXRHK0FHaVNtMVNuRjZyRmpiV2lOS3pUTDFteWlFOTlSaTgyQ0V2Kzc4WFFi?=
 =?utf-8?B?aE9GaTA5cHI3a244NEFyVlJoVjB6eU42bmxKeDg4UXFnUUFTRHhtV3ZjekRN?=
 =?utf-8?B?ZVpmN2UzajRJanloK1cwQkVZNjh5YkZaWVRMbWtFY2QzMWlxeU1XdXRkK1R5?=
 =?utf-8?B?czZTRStiZ05XMFJTTCtza05QYjhvaTRuTzlyVWxmOXoyYitvN1owMTJlMk1N?=
 =?utf-8?B?d250Q1pJRStkNE5PY3hWbzJmNVpOS0gxMUtSeWQ1VlBvUTlSdTBNdnBKRWM5?=
 =?utf-8?B?NTNCNGs2dW9PN1ZEWXBRQWZHc2htNjRNcy8rclI4ZURrRmxPUjdtWDU0TFZ4?=
 =?utf-8?B?LzhYbXhseENrcWIvc0EybTUwaHJ3UGdZU1hYSHBXbm9EbFQ0REgwRHFIc25s?=
 =?utf-8?B?M2lsM3lZQUJuMnQ5Qm5pRGZYdTRud0xZRVNpbUdKQlFJSVNBMkF4UitnRUZH?=
 =?utf-8?B?VjJQNEJtdDlEWXE1c1RtZmJESU5WbVJ6YWJSS3BPNXRCajhlejBkK3dhaldp?=
 =?utf-8?B?Z2x1ektwQnp6QnExNm9HajlENUZrYVZJcEJ5U0FXZm9XM3RwVTREamh1Q285?=
 =?utf-8?B?YUllcEt0b1JsejRFQWZSczBpbTRQeU9UQmFFR0gwTGMvbEt5ZVBWMFpTL05r?=
 =?utf-8?B?RFpDRnA1U0JKS0dIUVMwS0RxSmhielpWZGs1UXVrTlU1SHZoU2RXZHMzUVFL?=
 =?utf-8?B?NTZkc0dtbEpsRzlkN282ZlB5b1d3ZG9EMDJqZmpNTVZpdVpmdllWcnNOcHdX?=
 =?utf-8?B?VThLV2RGaHc1UjI3OWVQU0ZPdklGb1g1MWNYclgwV0pYQ2tyMmYyMytDeW42?=
 =?utf-8?B?M1pxcFVPaTV1T0pESnFCZnJpa0Z6SEVjdlM2cHRHN0dWaitRL1huVTVjUTk2?=
 =?utf-8?B?bFZXUkJhd3FzaGxZUjJOMjc0MTJDc0d4eXU2cVVHMHRZdUVMVzkzTGcrb2th?=
 =?utf-8?B?UTVUSGFqZTByUW9mMnlVY2doY1MxZ1lOZ2xmRmpWK2lyb1lZZDBQQWhBR0hF?=
 =?utf-8?B?Ri9BaXFVNi83U3RWZitLRERXaFJLRElZYW5Uc0p2cmRESmgvWWQ2VERpUlVX?=
 =?utf-8?B?QytyL1V3V0JPZ2cxaE9oV0l6UjZ3bzZuWTdpZEFVdTl0QklBZjljcmZGMTk2?=
 =?utf-8?B?WXhJR3VKbFVwZUJrOTdnTFl4WWlEVUIvZHpsc2hqQTlTcEI2WmRLL2Y0RFJC?=
 =?utf-8?B?WHVVQWNUVWtjTkx6dkpMU1ZjZHJCTUNoOG5JU0FoWFhLS0lVbmxmbVdBek1Y?=
 =?utf-8?B?bWxnRkY2dndIZWczWUd6K0htTjk5enBmeS9BNWNsMGlvK041TVdUT3dLU2x5?=
 =?utf-8?B?a3dPcDhUWjhYUEVpSkdvWk5oMmNpNzB5YklzNHJybHFoWWRDc0xBR09aMk9L?=
 =?utf-8?B?RVZIYTVlckl2Wkx5ek44b0JPNytRKzgyNXQxYkVoUnFhS3h4aHkybGVjT3dy?=
 =?utf-8?B?QTRMblNidXZBSk9keDJFTE13RW9lUmpySDhpQTJOZlhjaDZRZVNXRzRSRG9v?=
 =?utf-8?B?bDVBOGcxRUcxY1pPNnpaam5zUnFtSCt6SXBkNGRONktSa3hBMCtkZTN3N0Fm?=
 =?utf-8?B?ZExsRGlZeFdjbzUwQVhHTmc5cE5WeVVWQytpT2xndlQ3ZEVod2w1SlpwcE5w?=
 =?utf-8?B?VDlNaWlFeU1vd0cwbG50MU5jUlNza1YzU05tbEsyMkpGTXlWalpQeVIveWk1?=
 =?utf-8?B?TlludVNQS1FLVDZXbnZIWDJoTE5LaUhraW51Z01LN0dKMVV5b1NoYzdvMWkz?=
 =?utf-8?B?MWowT2FzRHk5L25hSTQ5QjU0Zk1QKzQ0eWdmSXdxbXZKYmg5WWNEdEJINndB?=
 =?utf-8?Q?hcSLS6/ekVRe414BPQgr40JeHThN5e75pqYKUW9?=
X-Microsoft-Antispam-Message-Info: lhwpMlbcLHEwh/EHiSEmNyUqqGt4A2fH/1i0V7BpYdfJZzXioGC6/W0IOD4ygdWSwvRh+euRzFJeZCeNEMv4ihQvyNq4ZwNLdKzgRzEkyOgL3e7CM4Z2eXbrtVlkPA/lmv+gZQuqptdHtOjIhjU3hVNLleOGrzjOpcbxXlU5Z8I20y+9sQtYfc3LLenanoAD
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:RjPiyaJuSNBAnrclO2vY8sLON4YOOJiQrQj7C7/ivtkdhuKwg4Omjhcpni2RrvFQib/fqpCgXRMpYgqNoxFWZwjL0tTMyX/qTfuTH3R83VMuH9j/wG2LKrCtYWLxEeXcE5o3cKwW7uEsEAkc0oW2+zGUYuSFU5sM1SkF9SUp94XoNgJLHqfDIZC6jl/yfcz9HIM45aWfuBmIy8fEkbTD1dNq72noAYy6RmFqjkqJe2QfdiisbQ0c4WbQDK+/nJYHUoPV0F58vCIRgylIBCLwRxP+6sw8HVWFwHHDPWkxynCEjVUuBwTLBq1dkenlmGxtPS2JpCofk6wMYgxq8N2j42hcryceDjesspbVv25Ze0zRltTLLrJbTXSuH2Uv/o0SvUlZMuxN9JN3BH1yOfK1hE5RCF0KHUUszqqgSWxeIKNm+B9VR9Jp4/TNgHFjgp4A0PzPWQyPQ+imvlM+h/xJzw==;5:zXcbdF277Tn113wQ81LQnoHizyfqVEMjRWLWKq+tPMDWv9fDnEAXKfkXapiZQt0PaC4LAIC6CX0er6fBM07XSJVkjLhfG2m2UHGpQpdr8zVpmplBY6L2bfdSze85AFhu2al/k8llnV3tTLpHWgpVBV6ys7S6PqeaBL6E9qbl1vg=;24:WBn8gZ4GR4q+GWxiRjUHCgINY6xVX443mCHbSOasrFQw3vSb0OtwDyGxhbGK1+m0b/DWXz4byhuY3Eb33Ls2AAeHR4v9SMlXPie5cAoH9rE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:v3SzRNoTcJtQ6Lq3YG1Mp2uBJcrHHtzl5qPKCuyL1WGzU+4j5P8bOirA+Yg0LAl1Zf2J/ZcS/OlzcCaIwI+tDEvZ5rEUaJmGNiqNxmGW9h7RtyaIlIIjCB7EGEITS/ewSbWDK7azbC6+l2kowi3N+QYU/oWn/Bui4WuSZCzdTXaWv1PTlxdVxZrqSZy4MMR+cDkMaAm7IweDZ/8f6cb6BfkaYRKRg+hFf2g9Cbq/+MhT578qjfBgsnWiWwkvFeO6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 11:12:25.3534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bea1c55-7ed7-43e9-a9dc-08d59e0ac689
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739881382169628?=
X-GMAIL-MSGID: =?utf-8?q?1597266829157211522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-08 18:50, Jonathan Cameron wrote:
> On Tue,  3 Apr 2018 17:36:34 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
> circuit in the patch title is spelled wrong.
> 
>> An ADC is often used to measure other quantities indirectly. These
>> bindings describe two cases, a current through a sense resistor, and
>> a "big" voltage measured with the help of a voltage divider.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Will definitely be wanting wide opinions on this one - Rob in particularly
> for the binding side.
> 
> One comment inline. What we have here is nice and generic, but is
> it what would be 'expected' for current sense circuit?  Should we
> also be more specific in the naming.  There are lots of options for
> current sense circuits and this is just the simplest (current loop
> for example).
> 
> One option would be to use current-sense-shunt perhaps?

Heh, I'm obviously happy to not use anything "circuit", because I fail
to type it correctly most of the time. I don't know how many instances
I fixed before sending and there were still a few lingering. Anyway,
I have fixed those locally and I have also locally removed the error
message on registration failure in patch 2/2 so that will be in v3.

But I'm holding off that v3, since I expect more input on the naming.

> https://en.wikipedia.org/wiki/Current_sensing_techniques
> Gives a few that I didn't think of beyond current loops etc.

I'll give it a read.

Cheers,
Peter

>> ---
>>  .../bindings/iio/afe/current-sense-circuit.txt     | 45 ++++++++++++++++++++++
>>  .../bindings/iio/afe/voltage-divider.txt           | 45 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  7 ++++
>>  3 files changed, 97 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
>>  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
>> new file mode 100644
>> index 000000000000..0bc7d89387c0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
>> @@ -0,0 +1,45 @@
>> +Current Sense Curcuit
>> +=====================
>> +
>> +When an io-channel measures the voltage over a current sense resistor,
>> +the interesting mesaurement is often the current through the resistor,
>> +not the voltage over it. This binding describes such a current sense
>> +curcuit.
>> +
>> +Required properties:
>> +- compatible : "current-sense-circuit"
>> +- io-channels : Channel node of a voltage io-channel.
>> +
>> +Optional properties:
>> +- numerator : The io-channel scale is multiplied by this value (default 1).
>> +- denominator : The io-channel scale is divided by this value (default 1).
>> +
>> +Example:
>> +The system current is measured by measuring the voltage over a
>> +3.3 ohms sense resistor.
> 
> Hmm. It sort of feels like the binding doesn't really reflect the
> hardware as directly as it might.   Should we be explicitly having the
> resistance in this case?  (with some more mapping logic needed in the
> driver to figure out the scaling this causes).
> 
>> +
>> +sysi {
>> +	compatible = "current-sense-circuit";
>> +	io-channels = <&tiadc 0>;
>> +
>> +	/* Divide the ADC voltage by 33/10 (i.e. 3.3) to get the current. */
>> +	numerator = <10>;
>> +	denominator = <33>;
>> +};
>> +
>> +&i2c {
>> +	tiadc: adc@48 {
>> +		compatible = "ti,ads1015";
>> +	      	reg = <0x48>;
>> +		#io-channel-cells = <1>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		channel@0 { /* IN0,IN1 differential */
>> +			reg = <0>;
>> +			ti,gain = <1>;
>> +			ti,datarate = <4>;
>> +		};
>> +	};
>> +};
>> diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
>> new file mode 100644
>> index 000000000000..fd4a215d9e6d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
>> @@ -0,0 +1,45 @@
>> +Voltage divider
>> +===============
>> +
>> +When an io-channel measures the midpoint of a voltage divider, the
>> +interesting voltage is often the voltage over the full resistance
>> +of the divider. This binding describes the voltage divider in such
>> +a curcuit.
>> +
>> +Required properties:
>> +- compatible : "voltage-divider"
>> +- io-channels : Channel node of a voltage io-channel.
>> +
>> +Optional properties:
>> +- numerator : The io-channel scale is multiplied by this value (default 1).
>> +- denominator : The io-channel scale is divided by this value (default 1).
>> +
>> +Example:
>> +The system voltage is circa 12V, but divided down with a 22/200
>> +voltage divider to adjust it to the ADC range.
>> +
>> +SYSV        ADC       GND
>> +  +          +         +
>> +  |  .-----. | .----.  |
>> +  '--| 200 |-+-| 22 |--'
>> +     '-----'   '----'
>> +
>> +sysv {
>> +	compatible = "voltage-divider";
>> +	io-channels = <&maxadc 1>;
>> +
>> +	/* Multiply the ADC voltage by 222/22 to get the system voltage. */
>> +	numerator = <222>; /* 200 + 22 */
>> +	denominator = <22>;
>> +};
>> +
>> +&spi {
>> +	maxadc: adc@0 {
>> +		compatible = "maxim,max1027";
>> +	      	reg = <0>;
>> +		#io-channel-cells = <1>;
>> +		interrupt-parent = <&gpio5>;
>> +		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
>> +		spi-max-frequency = <1000000>;
>> +	};
>> +};
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 36a28e979e9a..9dbe5019c6bd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6889,6 +6889,13 @@ F:	drivers/staging/iio/
>>  F:	include/linux/iio/
>>  F:	tools/iio/
>>  
>> +IIO UNIT CONVERTER
>> +M:	Peter Rosin <peda@axentia.se>
>> +L:	linux-iio@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
>> +F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
>> +
>>  IKANOS/ADI EAGLE ADSL USB DRIVER
>>  M:	Matthieu Castet <castet.matthieu@free.fr>
>>  M:	Stanislaw Gruszka <stf_xl@wp.pl>
> 
