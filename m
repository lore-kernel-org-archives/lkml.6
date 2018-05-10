Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeEJTQs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:16:48 -0400
Received: from mail-ve1eur01on0118.outbound.protection.outlook.com ([104.47.1.118]:20736
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752070AbeEJTQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:16:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/2] i2c: exynos5: remove pointless initializers
To: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20180509194532.28929-1-peda@axentia.se>
 <CGME20180509194552epcas3p4777026e41c7b34663eb11345e4f3d82d@epcas3p4.samsung.com>
 <20180509194532.28929-2-peda@axentia.se>
 <b69f6656-3831-86ea-5f13-fc805d86b288@samsung.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <6a6f56f7-7a85-b784-e847-f23a8ae41391@axentia.se>
Date: Thu, 10 May 2018 21:16:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b69f6656-3831-86ea-5f13-fc805d86b288@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::14)
 To VI1PR0202MB2782.eurprd02.prod.outlook.com (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:W9ThtaVCbm64AuE1GlxNPggQKXLya8rcFP4zm4IHLEKNL9K7cHq1NKSb2Q71U289wVb9sOCP/qgWkPxFoS+mI09ZsTKbr+C7WPIVnp29zYcm+uKZWSGivoqCv0KSKu89/y+avDk7FEATSMuVybHLaork7Wtvuw7XfNQr5jtYRfrW1IXlTUZhvcaakIf0c44oebSeVb6ON7tXT758OFkT9YEXSlDZ53I3y6dRGexntm/s02zhF0H38xilVQauOEpf;25:hmHyWCxAY2YfQa5zxHbqjWkJ3Gw4acgylNA5yljp4MGoJvm7yL6Ob4JY3uJydQWrc0CK33KCR8UwMucmy3fDlwWA/EEIStaI32IbcWD4pRPF6sj0dawvMNDQemP9h70Pnp3do3CEPMV5a7bffipro9WXLuIhdB1T4mRdRMWVpKZtSzjDc6RKdrybraK57dzU9T6jZczsmt6Acth+/g8dQTbdXQD9c+0QSfvfc0vyz0siedtofMEsHzX4hrdhCOULIVzwH0BuqdnEMiRwxJo/RQs8f3GDgbb8Lol0sj0Bx8yH71iONRmW0ipXiysO+19324ECm95FgjoZvGtTduAKsA==;31:EafGQ9ucHpRxIL6su8ahb5Iiz7W4O/ub4qslGr6YRlZOUy5LIaGGzpgoDM2OoV8JmGOMpBNOFtsNovNwkLMGSAGZCJ28Z+YJ9UbVF2d0ApRoZ11XxNTAO0o7cCRFoG31JoCWU8oxDInD6ITa5Z7Yasv6nbLXFChCx2jCSieRei0d8ojsxemkJ+9AnKRzDDK2mievkCuBEdOwSQpNagZE+yT6TENYB2Ic8jU2nzwmhmk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782E755BCCEDB9758590F01BC980@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:Re5aopB1gnV+69RzztwnhTDkH27AHtx5JuHugbz1BFFzKCiZGZktNDUvlYGZFbtcdgeacdO+kRuyaB1+7C1N2Jih95dVSX5ymYze2nGq0dY2NAWlLHpa+oG6BCPkS+mebibS3/M9mg838OzMTkhDWaBWlqFUooe6CaTS5RBqq7wPKqHNSfstp1imOhhhTtLuKpQev3zV/Te7CIFd2EbTs9WPzRvTJJQqlAEZKeTdlD29bpeah/ajLYEeK//fXlideSsL4H4lHVgdlfkpA2gdNQ==
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(376002)(366004)(346002)(39380400002)(377424004)(189003)(199004)(316002)(74482002)(31686004)(65806001)(16576012)(66066001)(52116002)(65956001)(58126008)(2906002)(54906003)(93886005)(53936002)(6116002)(3846002)(86362001)(229853002)(76176011)(2486003)(105586002)(97736004)(106356001)(6246003)(6486002)(386003)(64126003)(68736007)(53546011)(59450400001)(31696002)(47776003)(52146003)(36916002)(23676004)(77096007)(16526019)(186003)(26005)(5660300001)(65826007)(476003)(81156014)(81166006)(8936002)(7736002)(305945005)(36756003)(478600001)(7416002)(230700001)(956004)(2616005)(50466002)(3260700006)(25786009)(11346002)(4326008)(486006)(117156002)(446003)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODI7MjM6aFNlOFR3M1Y1Zkp2Sk5GeG5PMiswbXlv?=
 =?utf-8?B?Vk5HNkdBclpzT1J4RGxpdmxDNjBOTE9aSlBOUjh0b2JHQjJESFRXMWI2ZlUz?=
 =?utf-8?B?Z1RlVUI0ZjhFeXF3WjZZWEZEOThOM1lHZ2NJY3h4aDNSNXNpMFk1ZjhmbE9y?=
 =?utf-8?B?WFNJdWtOeFlHOXhDbGxhNWowdkozZHdENGNQRTFQZTk5ZG5Yek9yclMydVVw?=
 =?utf-8?B?Qm5jOHB1dDRjbld6VDFSMDUvZERST1lXRnVZSWN3d2xqZ0kwUnJCQnNBK3NU?=
 =?utf-8?B?TmF2MGV1UFNFemNZT2VHZ1Y3YVN2T1NBU0kvTUlETmFvenkvVjJWLytBV1lT?=
 =?utf-8?B?MzZLdGw3d1ZoRy90dEMzeHp3bWp3a3N4Z3JsUElkUW1nWEZlSVAvS1FMd3Iy?=
 =?utf-8?B?dEozUkFoRVg1WW1rQUJBdjJxZW9yNVFOdUo5dlNHQkNFWHI1UWFyaUEvSVgy?=
 =?utf-8?B?TmhrQVJ2c01uVllQc2RaRU9zRTEvMWE3U2Q2bnl6aVVJM2Rad2tZRGhXZUlx?=
 =?utf-8?B?SHN4T2ZSOXdvc0thN2krMUY4Rm1nWkFTQVlyWkZmQXk3MWQxTWJJTERNYnQz?=
 =?utf-8?B?ZnhaR3Bvak1qSE1hN3JsSFJmSHg4Wm54MlptSzE2L254citDMWhGUnpweTRl?=
 =?utf-8?B?UlB0dlNEQXJFbVZPWTZ2MUszQ21veTB3RmYzbUs1ZWZ2S0V1eUpqeHVsbldM?=
 =?utf-8?B?em16OXFpdGZSMDNNYVNqT2YyN0FkQit1TTV3RXc4QndscGl0Uy9EaWp0eEVq?=
 =?utf-8?B?c1VHMHFHNlZWeS9Fdi8wR0xFR0EvWUdOU0dhWmZqbGIxYkJOdHdHR0J0eW96?=
 =?utf-8?B?ZUJsTm44OW12YkZqUCtXSkdBMzF0c1BwN1RXMFczbjdKM1QrWTVrbHNJUDNa?=
 =?utf-8?B?M09HaUJXT0JUdUNUQzNDb3RJMGhITDhKSTJweEJQT3oya2JodmU0WndsdlNZ?=
 =?utf-8?B?Y3hGQVE3UzBrY0dUbmorRkpKbHVIeFpSMnliSHFoUk5Cd2o4R2k5ekwvZDRj?=
 =?utf-8?B?MzFySlZPdnNlSlhINjFQMThENlBhNUNySkdZOGhrZnErU0xleklpa0s0K0sy?=
 =?utf-8?B?bHhnbjRuekVncm5ZTmN1Mkl3aGtPMzVkL20rSnFXaEptbUcvZWlmZHd4Vmg3?=
 =?utf-8?B?QkFBTGFnRXArK3F6SjFrQ1gyZUJKdXYvN0I5MExrZkd3TXNUWk9CTXlLdEt4?=
 =?utf-8?B?Nm03dnR5ZW1nYkZOVmllb2ExenFZdXhSVEVKUmQ3cGx1eUZ1bklQQnIxcGVN?=
 =?utf-8?B?WU1yQzFXVWVDU2sreHFMWmRvMG5saVlFbzNLbzUxU0FJWFk3NWljb0NWb0pt?=
 =?utf-8?B?VU5UZmF0ZzJ1YmJ3dkJ6bHVPSy9ldEk0eXZMSkp1Q1hTVS8weHNEYVdwdWND?=
 =?utf-8?B?OGxGK1FnK0ZHdTNhVDBxQ1NOSVI0Wml4elFyVE4xV0d0ZGNIK3grNDlhTTJo?=
 =?utf-8?B?VElaamNwelI4OUJMWExKaXRhRDdzYlVPRnBIRmlaZHdWU25CeTRvcEpLeWdn?=
 =?utf-8?B?Z0wwV3dOVUxuRWxQWnZoVXRvNVV4K1lyZk1ORnczeDQweGlvck8wZFVuWG5S?=
 =?utf-8?B?N2M5Y3pnVk9DbG9jMEtqQnlvRi9CNVNPRzNORFFSV1BqeFg2MFNGb0MvWUFz?=
 =?utf-8?B?RHhiWFFxdUppYURkbkZ2NWhuU1FsRk12T1ovQ1NEZ2hoYmRJMjlwTm9WN3Ns?=
 =?utf-8?B?VkZsdHhmQ25sR1IxejJzU2J6REs4WVQ1bkFZbDN3bXcrUGtENG9QMm1jS1pQ?=
 =?utf-8?B?L09uejNKV1l5eUIvZ2lMcHBTQ0pleVpaYkxTZTdjZmMvdDB3b2pJRFZ5bVIw?=
 =?utf-8?B?YnljaUlmU3VGRkRQVnA5SUdyZGFsenpOdFl5cVQ0Z2V4Zm5GTklmQVpabFhZ?=
 =?utf-8?B?VmV4a3p0di80ais4cHdYZ0hILzRDVkVjb3pNaFZjUXc0Q1JDVW0zNGMrR09X?=
 =?utf-8?B?UTRxZ1dQYjFhN2xCQUQxWWtiLy9PMml1TFg0R29INGpkTUU3OUJMN21nNGdm?=
 =?utf-8?B?aUVvZXJNYWlUYllKdGRjWGpyK25MWDF3UUJQbFZ3VXNPTGxheUZMajhxOSsx?=
 =?utf-8?B?WnkzS2lVeVpNUFJMcm5LZDkxdmVWbnpLcDRkanljdkJ5UHhibjR3QkJmMkJr?=
 =?utf-8?Q?6O3vJXrvWOH8IkmH0EGye7g/0ybwwIhkVx/RtDlMcuYLdz?=
X-Microsoft-Antispam-Message-Info: dVUi4U/vxtUoDeQBoQjL27vlRoNl1Nf4Rrcef0ZQ/MepTU0p/kpV55AChPRNksDcOfwOWnZvCpiQdK/1ZPZTp2/953iMoXRM4VfiVMyqWTHv/BqpPH8jRfjiVLd1aU80jc8GgGA4cGg5tiiEDBpLME1XCH6nWZKSGOeNW72H6WQ3kAfu7vRKqlYNMuS5Hu4Q
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:cxKPzwKoolopAlbj8bxSKVlGKq8P1R2cqn7MM7Hct9h671nBti6gcii20gk4DhPePkMnrMNlLfQP54okTQ8vhUZbFL5XYWZ4dJqd+A3nCLoAezD+fxiHLutDlwB94XcInPmXFWx1tRrnAJyt4CCZVUu4IHt5pnZP3pPncU0LL7KNEXmhdsY8Qa//nHhLk1NCazR/gM6GbO5Wql/jordmxnQmNbkQNLx3BvgEFp9Jeh83z3j2oDaiDXBYx9aFWQprB2rbGtw2lDkY/5PRUl3/okYS7AkcXY+gcU25MJ5GEG8U7J8bpJn1ie2amJNar/9PbcAs0snUTvivPV6qZmfHTHzGLl9Kxp8T4CMCCv5bDoyak0HxIgxmz3IBaXXSXTdKIaFVPyfH61vwuDkjO2ZaNcWswHHKEUqL2Uvmk2YQHCxki+SyObL9Jm5Eo+SQq4wmboPEPtb1jni0D5FvH2TFBw==;5:isbkLg5qDzqEpdF3L6YcFFEGUa1uXhshuk8y4QtoYr6XolkP9tdaAY8Qn05pxArdGj/bD9Mg1XVgfML7EXuSuPC7SdW9sRmlwXZxl+HLhjQ/DICbIdsCzjRvYJaoyUL8ZuYHeUAJhnkpSgyXDnTW6RmvVNsuStO3lBx0mQBrO0c=;24:TNeV1UjT0MH0GwzE0KHjmjKi0bxm6LS2qceqZNO5oWBxr2sJvrDlBpa7GfBIpAD5S23pbj7jNS5K6QXx8dwm+fyDqyWNbTYhHhIIX3jHWIA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:1tpB3W6jUzOBVEz2twB4TCPaL8YLy/rwNVbEFz62FCOmDF37ZydEVBws4jztzYNmkkXVhMi1NwGYUv7ZtiVLI/amoAvUhjceXAdavwtifAZ6hC4v3UnanCPkmKueTCwN3ax7ibqO2tx0TbrV1ZASLIEbF07mO6CftRHVAM+QRJoUU3bXUnEvQUgvCMM1PzGIvtraN3ZTlk2TybMP4VQdd1vkOUPrpaBJ+R9JvV8/FdXJp3wsreyA8yWbWqXBjVMS
X-MS-Office365-Filtering-Correlation-Id: 3d0ece87-238c-4adb-c8ed-08d5b6aa8cc9
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 19:16:35.7398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0ece87-238c-4adb-c8ed-08d5b6aa8cc9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-10 10:44, Andrzej Hajda wrote:
> On 09.05.2018 21:45, Peter Rosin wrote:
>> The variables are always assigned before use anyway.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/i2c/busses/i2c-exynos5.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
>> index a2cbc779c33a..185fba37e830 100644
>> --- a/drivers/i2c/busses/i2c-exynos5.c
>> +++ b/drivers/i2c/busses/i2c-exynos5.c
>> @@ -707,7 +707,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>>  			struct i2c_msg *msgs, int num)
>>  {
>>  	struct exynos5_i2c *i2c = adap->algo_data;
>> -	int i = 0, ret = 0, stop = 0;
>> +	int i, ret, stop;
> 
> I hope gcc is smart enough to not complain in case of ret.

I think any compiler is smart enough to see that; you must have missed
this line:

	ret = clk_enable(i2c->clk);

which is the first to touch ret in the function.

> I think you can merge both patches into one.

I could, but I wanted to make the patches totally obvious and easy to
review. The patches do independent things, so I prefer not to squash.

Cheers,
Peter

> 
> Regards
> Andrzej
> 
>>  
>>  	if (i2c->suspended) {
>>  		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
> 
> 
