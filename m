Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELvndS0G+f9uRbi2oq+GY7NP66pYE+bpp9S1iVDfGb+Prf1+eVHO+EuwdOx6fCO9XAySMbM6
ARC-Seal: i=1; a=rsa-sha256; t=1522137697; cv=none;
        d=google.com; s=arc-20160816;
        b=qcVC+g7by+bwDzp/tX+0SVmPTm+7TfWlTgwi9jUA2GWKDCa7zfyAx7vKoNksNSeq3n
         AEzZ/8IX4kcrk4guAUFXGUEK7/X9V7UC+1pGJOSqDXekf6tbiyqIGgrU/PgbsumGvuvg
         7EewkFBKPPm5UGxHV0XtZm3yQVHRospibTT+f47fuz3Unby+XB9dzDs4IvC7dqMw/Gq/
         ndk27cydR1RdjQrtqmUkScGcQ7QezqrTBTxbb9rGp5laKAtrBR8nelqqUib3+quH70Yp
         f9kZbO8+9iUzG9gfqJSBLlKfNKtD3nYrtXG5ceqX7kKyJK6MC8NmAYHiYEBZYG2AWlt+
         Ve9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=sXLM6BKDi5OV4K2omXRvxob0MsxUQ50sjE9//LeCiHI=;
        b=bWyHC6br+3e7VuID3C6bog5v1CFKYp1YGdKaRGH9D8eCg61bSyqiqvI0FYzEyO27lU
         nH7OuB8V3zzdFpKhszg36yyiHCbeG1LfEH31Sx1bF+DxhPaOoE/Pua3ASG7R+ttrM9yR
         H74Gg+M4JusHAsf5fklsgFpx8Q0MiGk7hfuY626Q72FFdNLTbKCUJbjNRHSz9bAvy0R7
         lgluJyCDppkfj3YkHPCsIlS5wzkgdRBGRlQZSEylmR5FjImSFKDZ69PWVASnB6MlUD5y
         q/A+byEbl2+tB/n2br3K6+HzdRcz38dHSXuc/s6Y2dkHPmy/IsHu79+Dpg7BdiFO4OnK
         FvcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=cbKEHhz0;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.138 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=cbKEHhz0;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.4.138 as permitted sender) smtp.mailfrom=peda@axentia.se
Subject: Re: [PATCH 2/3] dt-bindings: iio: wrapper: add
 io-channel-unit-converter
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <986a7404-e157-6a1b-0610-07d1e127465f@axentia.se>
Date: Tue, 27 Mar 2018 10:01:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326222326.sxdeawy5x5bjkla4@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::21) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd3af20-2f6c-446f-6c65-08d593b8f49f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:+zT63om5JeW7ie0IR/gkUxv5xIjGhOztRfWuU9YiDmxjHkLHo7/1EkL0ZK9pJbCG7Bv8k25PlXL+IUuBCy2JTJTIxVeyv5JAxzgAaUtdD72YqxMy+vOBL7Yl9tFGAfaXQLXsO6BnlAUkn/T3gh+usdJa4yWEw9vjKTf5HImDMiqKaPr4wj1h30wqXZ2xqg9rX3ai9QoJqbmd2LvfzQcLfdyH+5SgUAA6+3Q+ZJeFMPOKTkfbGTFLOHEuI1SW81Fr;25:xHfGxTRyopUhJRnrrfJ6Nor9bPngsNgtXeJzZfQ8233vox9Q9OhMB3Mp5uu4rifICPUFwrXljfGwKgf03m4Ilz95BvRXN15X5fBcRbd4ydttKilOPRKfKPNMiriMqO7XMLroQ5jCs+zwCdLvlEwyLqs0KRKdmzrUDsfDAK551hinH4TmMJZZvKHH6wRD21qOvpZUiKL0vwig2JZpeFDNqVjucylgkcnbfTvWPMePOGO0PvCpxY8EhV8jBMM6Qe7o1VNKQDGJkMBSLSc59XkZL9oJ7zctUyE76OI4Om7NQ6hUWTwEhMOTm13pVfcvp0J5gXzbvKrPVsuZUxly8I3tdA==;31:x54wbchsHI1zA/4vEpYTudP+AJKTjNtU02MEaBgCxPB4EosmO51MZHQJYxHLHf8MAD1NGZvYTbxsZtke8tvwg9xeE6HLtoinT9gjfTHnro3DdrVCp7ET120VSxhbZgJJtlsCXdCYmAWD26YoG/Cz4SutjyK1fuw0ogh+8onno1rzefZCiw7PIcX6kr2K+EtXB0yLmmvbckAxJAtjCV2GeCUNVK9FBsqhM12+DtJMbek=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27764EC5C2CEBE53593B15B6BCAC0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:WD735xceBxMM3paZnI8IRZG9InrzyzL1qxx2NvDsjF1//RvSCki3Kpwm//hs39WKhJeOlG7wX/1atRSCvpuKnfXKAJbepXES4cgIm9FMQTmz0PqRAv9PUdotglvNMPVkChPp6lGkiJsV4NrSXlSDITnAHX6O5Hq3WqlmKDwxAoNp9rZAc7eHJDAYnc3uuteOIUIKH0vynaE/9dsSZ57/bJCN7qp9An8sxGFKxyPxM2/wIR5Eis7hqG5Iv8Uaz+zYPef1h+ww4zbC+fm4cxPWO0ExJ4yy7d5CmxyKRFBeFM7hh04stZG/QXb5Pr42aFAyxTrUWF3WZnaDflhZVUkYejsQlLTCxUP75+rzgdgoAUk=
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(346002)(376002)(39380400002)(396003)(366004)(377424004)(199004)(189003)(85664002)(6246003)(77096007)(230700001)(52116002)(23676004)(6666003)(36916002)(31686004)(3846002)(50466002)(2486003)(4326008)(52146003)(26005)(478600001)(6116002)(3260700006)(2906002)(5660300001)(65826007)(25786009)(31696002)(6486002)(486005)(486005)(76176011)(7416002)(956004)(2616005)(316002)(74482002)(53546011)(117156002)(6916009)(16576012)(386003)(11346002)(64126003)(8666007)(53936002)(6306002)(7736002)(5890100001)(68736007)(446003)(65806001)(97736004)(66066001)(47776003)(36756003)(8936002)(86362001)(54906003)(105586002)(65956001)(81166006)(8676002)(58126008)(186003)(966005)(81156014)(229853002)(16526019)(106356001)(476003)(305945005)(15866825006)(42262002)(422495003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6RG55NlYyeWVRQUc0UlB3dGNUUnoyZUlL?=
 =?utf-8?B?NDU2N05PczdzeCtVangzNTJOQUhaRU1MVmRXdTFoS2p0OEh1YUsvQk5qRit6?=
 =?utf-8?B?NFRNM2k3ZXhPSHh1VllxRWp4akJ0bWZ4Y0MramQxaW5UVE5TeTBWM05TbzY0?=
 =?utf-8?B?c0FHVkJ4bWdVTGR1VG5CbDJhNm9SSkFaSnNHcjQ0V3JlUEQyeWJJNmgxNFZ3?=
 =?utf-8?B?ZDIwOXNRZ0ZuYk5kMDk2RmF4N3lJSEo0MkUxTVNTZVgybWMrWHcrcTlEQXZC?=
 =?utf-8?B?N0hkNk04bVpyejBPblNrUFFqSFhhVDQxVjVFTEFycno0bUIwSDFuemFLVks2?=
 =?utf-8?B?amJ0VE12dDhuVVRLbkcycGpZa3M1MHZYTTNoc2Q3UkFhU0pGRG01RkYyc2E3?=
 =?utf-8?B?Y2RBK0VDSGNMQk5zbng2d1BFZ0xCeWZzVE0zQXdEVzZLUGpBUlpEdU5VWFJZ?=
 =?utf-8?B?WlkvdUxHLzFYKzFlZ1VpN0lXajVuR3FTbEM4ZTRZNG1PYkJOeENwZFMxeFFK?=
 =?utf-8?B?N3U4L04xU0NyaFh6OGFHczNmN0szTW1McmlpMmQvQXZNNjhZRXlZcWN6amlJ?=
 =?utf-8?B?WUhlSE9jYUZuT00zcHBSelYrYTY2UnBpUUxJWWlZaDBRajZrRklNMmEwaHM2?=
 =?utf-8?B?MTJlclJYTHdMS0RWSnp4RGF3U0VJQkJTUEhjL1N3T2dzYU5FdlFlMUxhSXpv?=
 =?utf-8?B?NkhPWHBHc0VFRWt3ZzYxWmQ4RGM3S1RvQjJCeUJIY1cvM2R3TDZpbHBqeFZm?=
 =?utf-8?B?eVpzNWNUdGVJbzRwWGhuSHA3REFRWGtVWmZ0Ujc3b3EreEFyTmk1eFJzTnI3?=
 =?utf-8?B?UGNVWHI5VVRrUkpza1NRUUpuMzY0bEpCUmtLL0kyZDhlRUJFRHMrUHREdXV1?=
 =?utf-8?B?MUFGTVdBRzh6L3AzeGVjNVh5SmdKbTlvUDlPYmwyVldVQnBURXFidDV6UUdH?=
 =?utf-8?B?cFpyMlZ6aExKdi9yK3pSYzRpSGVsL2RKdFpUbThZYjBXMmhUYjc5SEE4WWx0?=
 =?utf-8?B?bXUzL1NycHNTY2V0WkVZdGNNZjJDdU9PVnJ0WXFSd1VaRDZLK2JsTTNHakxO?=
 =?utf-8?B?SkNXZC9PWHQ2ajJ3bHp3eDN4UmpPVmhQOUFQeWVOOGQ5ZFZGWHRVM1ZSbm0z?=
 =?utf-8?B?dTBaVUNaS2dGeGs3U01TU2I4bHFOV3BMQnlUajBQU3VHSkRsM1RnbDUwdXdy?=
 =?utf-8?B?SEhEanBQSCtVcTV3eVRZdHVZa0tDRFFCNlZWaFpvc2ZQa20rZnh0VCtKU2dl?=
 =?utf-8?B?WUNIczM5eW1wWW45bUJ2aUt1NDFzaEd1RGhnSk5JN0FOWlUzUDBEbUpIdUFv?=
 =?utf-8?B?U1RjNTNtUjlnN2tYTS9kbjV1NmtJVnJFUzhBdHg5b0oySGVEeGNURGNpUUlj?=
 =?utf-8?B?VVord2g3L1hOVjRTK3R0OU5RdG9oQWNTZ1UvTHZlSFZYbW9LRjgrY3dHc3JH?=
 =?utf-8?B?ejAvRlFFSHlEaTE4WWVnUmE2ZXlPdWJPT3NHODUvRHgyU0RtKzd1QzlDS0Rz?=
 =?utf-8?B?RTBuMStwem1tcVRWazFLTWtWNmllai9sNTA5QXJPWnpDaTQ1QktlcENydXFk?=
 =?utf-8?B?MDJENTZ2QUUvMmp6M3pOdkFPM1FhMUgyU1RobTgrVlJPOHR2UkdTMzRxUmlG?=
 =?utf-8?B?dXpXN2QxcmRaYzF6TExLSlA0dlhBYXJSWXB4WHZCMmZQVmdzUDNCWUxSZGZs?=
 =?utf-8?B?T3o2TTI2U2dLSW4xUCtoZE9IRzByaXFNb25mREFacU9kL1dyTTc3RmwwOGsr?=
 =?utf-8?B?a2dydXhjNU9VWEdxcjhHb0xtWVRnQm1PVVBkRjh6dGRwUHJ2Y2luaWh0TlFY?=
 =?utf-8?B?aTFkRms3bzl0dytrc2ZXSkFVUzY0bmxLbUgxaTRjSlJyOFh6L3loUnF2WUx3?=
 =?utf-8?B?REZ4aTZjK3ZjaXJ0NVZOUlEyUW84M09rMnJ6OEltMnBNaDdlQjl4MEJRRkx5?=
 =?utf-8?B?dXp6ZHRoQWl6UitpZjgvU21zTE8rZTdEalBBN1RKamhVZXk4WHM5a1MySU9o?=
 =?utf-8?B?NXIzSjk3OXJFSXdQQk5YR0FnckJmUXpVNlg2aTgxaS9BSlgwSytYUmpGRk1H?=
 =?utf-8?B?VGl4OC84R1FPOGN6bE5YT29OYm1kWHMvdHc1cjk5OGpMcVUvN3FXSEoweUpo?=
 =?utf-8?B?d0p2UTFpdGhVSitsNGdmeXdDVytERlp1bGF4YWNhbk1JVzhuRkdIOTRyZmdJ?=
 =?utf-8?B?VTJNdTNtOFVkMHdGclZqVlhtNGU0QnFObEY4SXAydnRhaGh1V3lKdTBUMDNR?=
 =?utf-8?B?SWp0VEFneGJweURibVhGVHg1K2trRGpMbmNUQ2FmYktrTm8wT0ZsN0Z1VmFM?=
 =?utf-8?B?Rkw2d1FDSmFhck9DMjdEdHRtV2w3R3UvVEpYRmpoNDRGZFkxazkzYTZMYm4w?=
 =?utf-8?Q?HyOBWZyApwNx3ivvEcCXaUrihNknyPaEmg6/E=3D?=
X-Microsoft-Antispam-Message-Info: aJfG64u1+ZpA6AaOP4cLN1qKJWH3mAplFwlzfQQyjSSKoVNWDx8w8/dIECpIzsMYi0OwCP0ZjjDyctGZIVRYnkv4heO777C0AUhEkgMNI8YIsmIgVc/vb7Vwtz9jhsPW9Ts+fO/lnGAzNqbOjInJJk23JVIuuKEVx8bAPsDrQdEAHOWtW0iQHoA8xbbhtnqD
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:eBePYfiAItrgmVgKL8PYjmpoQpyDRyy+84kxyHqj722E8RJ1gx339lrgxQE5r+kykNGmR6iwdByy4BMfoXwIwF1SaWB1PSPPcqHOe0jqC9PqiFvJieqLi9IQlX6dH8w2B8LWZ/yUUihQk1g6bvw/9X1ZaN53kN6Eo40y3EEnbEpMW47FOyb94l6v5Zv+Q3bZE/D+XJbWau7FpTlUdOfc7bnOpGltYPIefviyW58KHTO/uqM98ww2kTPSEGSoogWkRLzeWI51yB28mNDdVLiYFdXjgpAILIRv1UiAij3V3Dr7EHc1UZwCyqR1g3dKyn7EFnQjVux3ak0QALkNABluc5ds7q4jMuSBKt6fKawryKSaBQhSD+Rv8uZPyh8dkACgWCTnCcgepEQqyLk+190JAukRkpKm7jaT4LoV+6/EESUdeysUeHSOkNEVk02tl3E4tXt3t6rV3lYS6LeB5s+lFQ==;5:pehvCslEdbz0h+F+M4ETA+uS88q/X7pRUKL5shbMsGHMQXzukmyBOGlJ5uQae595W4QXg+sTD/H6csv4qIQ8WKZvVrhdDMrFdWJgJCGL5r6yxcQ7hBBjjVh4T0ceVp89NeULvkRVg6x3jDpjIonh9JdctnPkHDtGI7sxQ6AhdwY=;24:RiA9p2u5EXx1gi0q5lBQrs8Y/1PFmLaIauIJUAqwFBpgIA+O8xkhCKqLaENt/7OIc6+uSUUfoFAOY5uYi625olXaWV96wwrlXctkzKxtBXg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:k8/gxTXGGlbObHsNf1MubXDrruGI3N6Ce4sZ8AtiJp5lzNruhLHYz7pjwKfgb8zZPucnI3fkIRvFC7+QbIPa2se3q9v/czpcrIOM66Wsd9vtTV1aEfHLpgpEGkz7sW4JzzApbTl/6ZmxTfo9cKnnCt7sHGMjZs4pUgbxSneU8FkfIhLWZtf41uxKvMIewzpy8JJJm5ew8lQT5dRBtZPk1pRyDTtxoYGUXxtOSDNV25SfxlX1aJHiwtRLwga+Qu5Y
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 08:01:31.8741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd3af20-2f6c-446f-6c65-08d593b8f49f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386352511078978?=
X-GMAIL-MSGID: =?utf-8?q?1596077058947952262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-27 00:23, Rob Herring wrote:
> On Mon, Mar 19, 2018 at 06:02:45PM +0100, Peter Rosin wrote:
>> Allow linear scaling and modification of the type of an io-channel.
>>
>> When an ADC channel measures the midpoint of a voltage divider, the
>> interesting voltage is often the voltage over the full resistance
>> of the divider. Likewise, measuring the voltage over a resistor is
>> often a way to get to the current through it.
>>
>> This binding allows description of such hardware which is external
>> to the ADC.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  .../iio/wrapper/io-channel-unit-converter.txt      | 84 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  6 ++
>>  2 files changed, 90 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>> new file mode 100644
>> index 000000000000..23af661abe32
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>> @@ -0,0 +1,84 @@
>> +I/O channel unit converter bindings
>> +
>> +Allow linear scaling and modification of the type of an io-channel.
>> +
>> +When an ADC channel measures the midpoint of a voltage divider, the
>> +interesting voltage is often the voltage over the full resistance
>> +of the divider. Likewise, measuring the voltage over a resistor is
>> +often a way to get to the current through it.
>> +
>> +Required properties:
>> +- compatible : "io-channel-unit-converter"
> 
> Would this apply to something besides ADCs?

Not that I can think of. At the moment.

>> +- io-channels : Channel node of the parent channel.
>> +- io-channel-names : Should be "parent".
>> +
>> +Optional properties:
>> +- numerator : The parent channel scale is multiplied by this value (default 1).
>> +- denominator : The parent channel scale is divided by this value (default 1).
>> +- type : The type of the wrapped channel is modified to this type. The default
>> +	 is to use the same type as the parent channel. Recognized types are:
>> +		"voltage"
>> +		"current"
> 
> This seems overly complicated for just describing a couple of resistors 
> on an ADC. OTOH, keeping the ADC node and what's attached to the ADC 
> separate 
> 
> Perhaps the type should be part of the compatible. For example, if you 
> have a current measurement resistor/circuit, then the compatible should 
> be based on that.

Is a compatible like "current-sense-circuit" too long(ish)? Is a
vendor prefix absolutely required? Sure, I can use "axentia,"
because we "implemented" the circuit this time, but it seems like
the list can grow very long if we should add every vendor that
may use something like this? Something more generic would be good
for something as simple as this IMHO.

I propose the compatible "voltage-divider" for the other example,
but I have the same issue with the vendor prefix. Even more so
in this case.

Then the above type can be inferred from the compatible. I suppose
I should write the above two bindings as two separate files?

>> +
>> +Example 1:
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
>> +	compatible = "io-channel-unit-converter";
>> +	io-channles = <&maxadc 1>;
>> +	io-channel-names = "parent";
> 
> parent doesn't seem to describe something about the h/w.

Extrapolating from your first question, you are thinking "adc", right?

Cheers,
Peter

>> +
>> +	/* multiply the ADC voltage by 222/22 to get the system voltage */
>> +	numerator = <222>; /* 200 + 22 */
>> +	denominator = <22>;
>> +}
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
>> +
>> +Example 2:
>> +The system current is measured by measuring the voltage over a
>> +3.3 ohm resistor.
>> +
>> +sysi {
>> +	compatible = "io-channel-unit-converter";
>> +	io-channles = <&tiadc 0>;
>> +	io-channel-names = "parent";
>> +
>> +	/* divide the ADC voltage by 33/10 (i.e. 3.3) to get current */
>> +	numerator = <10>;
>> +	denominator = <33>;
>> +	type = "current";
>> +}
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
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 96e5503bfb60..5dd555c7b1b0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6884,6 +6884,12 @@ F:	drivers/staging/iio/
>>  F:	include/linux/iio/
>>  F:	tools/iio/
>>  
>> +IIO UNIT CONVERTER
>> +M:	Peter Rosin <peda@axentia.se>
>> +L:	linux-iio@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>> +
>>  IKANOS/ADI EAGLE ADSL USB DRIVER
>>  M:	Matthieu Castet <castet.matthieu@free.fr>
>>  M:	Stanislaw Gruszka <stf_xl@wp.pl>
>> -- 
>> 2.11.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
