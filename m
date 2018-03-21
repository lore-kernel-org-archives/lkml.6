Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeCUFxY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 01:53:24 -0400
Received: from mail-ve1eur01on0108.outbound.protection.outlook.com ([104.47.1.108]:63968
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751459AbeCUFxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 01:53:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/3] i2c: mux: pca9541: namespace cleanup
To: Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>,
        Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au,
        linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-3-peda@axentia.se>
 <b472b2e4-8360-6f5a-b753-fa8fc7083d04@mleia.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d683d542-3def-9156-2628-2fa1c1830a12@axentia.se>
Date: Wed, 21 Mar 2018 06:53:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b472b2e4-8360-6f5a-b753-fa8fc7083d04@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0401CA0019.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::29) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8713f7bc-9f95-4298-4c76-08d58ef00aa1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:cU1NVPWIv5dw2Foz93juc458XCK1K0O8WoETEnebLkuOMz7+k4o8V84HjLKHlgY6rB9I0SDhID7Nk/ODbRErXOq0wmcxmCSDioSZjunsD+XrHy5nZWCHL6SqMC808zT0ORmuWtQjr1gt63ULgfwZSeN5lXFw2qxZKISQhi5njo31ZXY8f4caf/gTMJEB/1jXyAGzJlJeE1SdePWjFq6J+zvtn5tN7PCE8AaWZXi2HPVdaiE0IeiAg7YLM6TJcvnp;25:U5zPzgWww4xVJY/mWCqQrWvu+a6zBm1QGdRMKjwii/BqUOXLK4V7B12uVLvhMsOYEypNjtyCjtbp5JThgqxCbTHKSJtT+ctNhp6CkXsSCVsOetWJE8IaEJvy6/HiNNik2p5/kWdDG0YUDmY6xc3v9jSikVnL195ELzRJLFgUqv14UFY5m2dROUe3ZMRiqRvKjusCsNetQ9cAmp6hn0WBEW9IsoE53fOmY33rWenM14CmTVrenB3N0c2l253kgGCBlvzAskdGb/5aFCnXS+TQpjFvyCAaYqaKFKHngmbcVzqj3csfQJFqNs5ALTY/gLNf/vm0Jiymfyk8JqoPYPjUUw==;31:xmG2GObuVk6Z290lplW9Kb5EVZ9fn1qSZTVzZl5IqL4v2xXHz3jfrMt28DW2ix6Bt21z5D0Muetdlp8DGg4gATn8NmGA0d0VYRTTi1F4de0cvTrrlntGzPq8IqaEfdh3GIcubiDGHh1MvoQRqHKhd5QfF98xyDNEq1CgvOWFQW6gdpY3KkjkvdGJdkEAeEUXLZUL9edh8DUBDZhbFh/cySnDJPSkJBY6I/jkGxROe5k=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27808BA1B145F79FF31D1343BCAA0@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501319)(52105095)(93006095)(93001095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:L16EZWha3OQrBSuMGToUzD6x8YalBTX9vUk82lVcRnXQsjSbHfuoSJsNMN/zOyuJYqYd2bY9OmrYLuhMFMxYsXv6WUClqsTz5ZA4VAL9zxPqs4mEwoQUAmpzr5LnhS2cq/xn65ZkKH/Ia1rtf/ZZMv20a//2kT08fvoTsCYtXShMYPXScBE/Wv4CTj9zhuRT6JXgZrL2DVFHyLJ8G8kyhoqmaYcLh7NsDwsLGEfT0NAZ9N7vTJ9zpuWr+1N+SBA0Fbz1SdE732VWRW8dMb2ZpvUG5NpbKXI0GMaTv6986FRVGYsU/LHt7gMAZ3YYQnq+
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(39830400003)(366004)(376002)(346002)(396003)(377424004)(52314003)(199004)(189003)(16576012)(74482002)(2950100002)(68736007)(31686004)(4326008)(5660300001)(25786009)(3260700006)(106356001)(117156002)(7736002)(8936002)(8676002)(50466002)(81166006)(3846002)(81156014)(53546011)(386003)(6116002)(105586002)(64126003)(2906002)(305945005)(230700001)(6486002)(36916002)(52146003)(86362001)(2486003)(575784001)(23676004)(186003)(26005)(229853002)(77096007)(16526019)(31696002)(65956001)(36756003)(6246003)(66066001)(47776003)(6666003)(478600001)(93886005)(53936002)(76176011)(58126008)(65826007)(65806001)(97736004)(316002)(54906003)(52116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3ODA7MjM6cjRQME1EWENWYWFOQmRvU1dkMXA0bnkr?=
 =?utf-8?B?U3NSRTFGazlZenkxdStnc3QwdThFMEl2bnJLNUs2WkVFRUpsamo0Y3V2SGxO?=
 =?utf-8?B?eWpHSnlTeU9ET293NlhzeG9rOE1POFJ2NWxiaHYxdlFjVmcwbFBsNm5xZ2Ir?=
 =?utf-8?B?a3JUcm5FUUQ5UGVlYU9zTUNKZHBnSWNNOHU2dDFKeERpR0V6UEZtdmJwNGd5?=
 =?utf-8?B?dkZqNFJoU1J4a0JsZFNacUN2Y3NpeTdXVm14ZkFLTnYyRGtCdkh0Skp5RmxR?=
 =?utf-8?B?dUgrd3VOM3pIOFVtU3E2V2czcmYvZUR6Q0JKNGRPUU9kNGgybU45Mks2ZXVP?=
 =?utf-8?B?aWJIbk9EOVBCdlRzTDRMWUlwbStLSkdMTkQrZGY5b3ZYN3dPTXhEMnVxOEEr?=
 =?utf-8?B?QUhpaWdtbitiV0RFMWVnVmRDOTJISHZ3andzT0RvTVJ4aGk3TjhNckkzd3Iv?=
 =?utf-8?B?NXRtVWdDY2xzbTFhZktLZHZrdmxkbGpid2hpMG5GZWZOZTdlTDJZZWhFSjJM?=
 =?utf-8?B?R3VsbWJjOUlvS1NkRmZ4Zi9GTEhrMmZLTkszOHgyZlRZWHQvUXQvcFdCVTdY?=
 =?utf-8?B?NndNbCtoUlBxWlpmTkVuMHBpY1VMK0MyeW1vVG9FTGhNRkpSUlI2L0tlVE55?=
 =?utf-8?B?ZTUvWTB0M3hnbU8yTm1pNzlJMkxBalAyK0k3VVE5TjI2Sm52S2hyMXNkMU5n?=
 =?utf-8?B?STF3TnRhUWxPV3I5LzBidGhOL3ZJK203UFEyS0h0eGliTTQyTUF5MG91T2Zz?=
 =?utf-8?B?NkZBK3ZYc0FXdkxDaEhjODkvZ1BtOXJ6elZ0VkNJdnZJQmExT2l5L2FXKzM2?=
 =?utf-8?B?K2ZuQlBrQ3NPSHRUcjhzN0ZlT3I0QnRwOGdkWVpIcDhhVHZqaTlUbi9vellV?=
 =?utf-8?B?SVVhZU5hb1p0ZWZiN014cXBybkxyYVRKQnJYR2ZVMlZyNHc2OWZSYXEybENh?=
 =?utf-8?B?eU9qSzVwQzFJRm5lTXRpRndwWGl6cTNPWmxEbnBnSmlsV0F2Rml5MGRYSVR6?=
 =?utf-8?B?QUhqZzI5VXRGYjBRRkU0Vjg2NFI0SDM5bFgvaGlhdTkxSUdHeTVXMENIUkEx?=
 =?utf-8?B?QW1MYXNzbHkzVWdQUnQwNThNeHczNjNxbW90OTRyTmFVWG51UlZGVURFam9i?=
 =?utf-8?B?S21YN1I0RlQzdXQvMUExN1FCK0tvQjZpTUZYWWJCWmFSa0hXZXhiNW1VcG1l?=
 =?utf-8?B?REtBa0o3Tk9MNUt2M21BeGttckNtZGZnWURQMnZpK2Q3VnA4WEdxRUM0cEhK?=
 =?utf-8?B?NTNVMUdLRStjUm10UzgwZjc2d2QzYTV5UWZyVGJGSGRrWmJJSUduZTVGbVBH?=
 =?utf-8?B?bkR5YTU2eHhjWEVWekd1MTFERXhVZzdaNVVkV0RRU2FITEpSWEV1OWpEb01X?=
 =?utf-8?B?MktkcVE3NkFpNWg5SlA5aHgwdHRla3NBM1JkRTEzanpWcjk1bmoxSTlVZWM0?=
 =?utf-8?B?ZmRPNk1sVWY2L0UyR29WMUFKVVlySy9zcW5XTVZzK3VjeHVKeDhGSnZiTE9T?=
 =?utf-8?B?WVBaQ1VnSGMrZ0VNWEE1MGFzTkMyYmZsQ0lMK0JZdy81clRNNGtwRENDeFlZ?=
 =?utf-8?B?MWNrN01uU1paVjU0UHgxOERYOGxsa1duTmxiRmFzM1c3dzhuWWVHZ2gxZnRl?=
 =?utf-8?B?emVtRXdhTmtnR0hqMTYreUVYOEJrelNyRDN1a3UxeThOQlpGKzMxR2MvejBF?=
 =?utf-8?B?L0xlS1hwSGJTTW5hSjFnZ2ppTCsrZ2E0Rk1jZnFBdkw5Rms0SnNkTTF4K3ZZ?=
 =?utf-8?B?T3ZYVmxPbXByN2Y3dEpETlRrTnlkZFJNbENmd2I0RW9MTm9wZkhSWEtqRStG?=
 =?utf-8?B?Sk5LTlJON1FHSGlOK2YzWkh1SVNndlJVRTlmdjMvRGR0eFo2eERoMjVoSXVL?=
 =?utf-8?B?OUIvV2lNN3g5UDFDNTcxdVdIWTNRZ0V6bzd1ZStIQXNnSXRBVXZaNW5mTW12?=
 =?utf-8?B?VHBaT1FEYXdLOEM1bDBjQlU3cEtEZ1FOQWtxMW1KSmVJVk1wcnZGaTBxWkor?=
 =?utf-8?B?UW1lMVdJM2tJaEFEcm05cUQ4WnlkOHNRQzNkZjMvUEJnMC9KdUNLQmd0RGJO?=
 =?utf-8?B?bnozejNMcE9jb0pnTzlSM1ZBc0ljT0s1QmNST3NOK1R6OGhHVnl4azhJRFE3?=
 =?utf-8?B?ejdOUT09?=
X-Microsoft-Antispam-Message-Info: 0oXhQ7yybNYuQ5ZEgPK8eNKD6npNS1JVldv0eAvHACf0bwlcvXzAln00ExRoooJzjgTWKMwdrsQVszJuBUp7bcofhtNYIgMttbpXmJ9SBGEfEtVAe00wBtO8y+FQKzR4s8YebVROg2K/XQyc0+NCeFagKV5vZ7Ky5Isj53GIvGsROCvX0YgFHhmJaiq6cQBX
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:Powq4JbyfY0P6yOuRc84xN0E/pjslw6ou8omESVmDzOLotAmBsy7GVw2F0SpdNGllTeOmcYe54xIPEnAkfl+bvCsVR3tDsTXWZcmaTpkHt2aUm5rlsJjZOUVwIFNZdyD9yC1rI0RHwm5yoePFhe722oM15afWSaO4yLh6Jia+tkylt0OvjntsQXnoE3dwJZq+7VlnCoHiQeS1GitIbpw12En4VoK7n3NAGqkeia6N1n/aAzsrKyAJycQwEVl2r7lIN4oKF6rL9hvVT6n4rFY2aC+cjOfAY0jQo7Yj9HQCrKFtVsthBYq9AfNipUNcOYbgZwj2ySVfiSs97PV2tEZAsTV5dQCIK5ZeNj3hq7I+0w=;5:SBdJqgqDAhB/N1yvEhKCIbOgKPkajkCi4iw2AlFVQwuCBtIs8IIGJmCwarthlIXXQJ25rCaJL1ngBchu60SRZE0Mwq14K36/9AbMLoWx0dW6aGtt7N70ErVmVdbGM4z/e0lwI8FP6Dqg7wSChhAKy2aj8E/in8wP+F39lT3S140=;24:Zkg46qIlwHrIJwZDZpCRre7hsk7ZcvlYI3Nyh8tRitLHpGTxGrC4efIrfCn7n/vcxhOtbL0zrnG48fppJBuBUVaaKjQjsjy75LMmPXwjxSc=;7:ZMFW+QMU6blLINQxoL9fQfazWoE9wlI/qGs5IJCCMXCHOmixquABg01pGrT30IG610KpCV3Po7a5Zs/NX1ABAImHKdKyqR3K8XUO2UGTkr8kScqtxcqgJat5cptGILmcqRB0N4uSs6qnf9oyc0WNQmCDq056Iy36UQjv8i28chO9DchrBfz98CtSd7ertAbXxzpiOUJ+9LFD5W9D8IK6fJ8YIrA2wu6sKNULAjZwlzDu+rT2SSceE59A+9Mo6w5u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 05:53:15.6619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8713f7bc-9f95-4298-4c76-08d58ef00aa1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 00:24, Vladimir Zapolskiy wrote:
> Hi Peter,
> 
> On 03/20/2018 11:31 AM, Peter Rosin wrote:
>> In preparation for PCA9641 support, convert the mybus and busoff macros
>> to functions, and in the process prefix them with pca9541_. Also prefix
>> remaining chip specific macros with PCA9541_.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/i2c/muxes/i2c-mux-pca9541.c | 26 +++++++++++++++++++-------
>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> index ad168125d23d..47685eb4e0e9 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> @@ -59,10 +59,8 @@
>>  #define PCA9541_ISTAT_MYTEST	BIT(6)
>>  #define PCA9541_ISTAT_NMYTEST	BIT(7)
>>  
>> -#define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>> -#define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>> -#define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
>> -#define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
>> +#define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>> +#define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>>  
>>  /* arbitration timeouts, in jiffies */
>>  #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
>> @@ -93,6 +91,20 @@ static const struct of_device_id pca9541_of_match[] = {
>>  MODULE_DEVICE_TABLE(of, pca9541_of_match);
>>  #endif
>>  
>> +static int pca9541_mybus(int ctl)
> 
> static inline?

No, "inline" is only used in header files in the kernel. The compiler
is free to inline whatever function it likes anyway, and in this case
we do not know better than the compiler. We don't care either. At least,
that is my understanding of the situation regarding the "inline"
keyword.

> 
>> +{
>> +	if (!(ctl & PCA9541_MYBUS))
>> +		return 1;
>> +	return (ctl & PCA9541_MYBUS) == PCA9541_MYBUS;
>> +}
>> +
>> +static int pca9541_busoff(int ctl)
> 
> static inline?
> 
>> +{
>> +	if (!(ctl & PCA9541_BUSON))
>> +		return 1;
>> +	return (ctl & PCA9541_BUSON) == PCA9541_BUSON;
>> +}
> 
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

Thanks!

Cheers,
Peter

> 
> --
> With best wishes,
> Vladimir
> 
