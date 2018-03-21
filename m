Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeCUHfc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:35:32 -0400
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:44752
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751847AbeCUHfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:35:23 -0400
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
 <d683d542-3def-9156-2628-2fa1c1830a12@axentia.se>
 <93631639-eefd-cd1c-48de-451662ce8de7@mleia.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9e7acbcc-f9e2-581d-d02d-3c026e52b3ed@axentia.se>
Date: Wed, 21 Mar 2018 08:35:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <93631639-eefd-cd1c-48de-451662ce8de7@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:7:29::25) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 084408cd-6379-4733-594e-08d58efe4c26
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:MMb6AfC8DToVPZau8HhEnQuiq4AtF27mtAtuKbIPoAd/O/n01S9uIYF+2QEroFPf2lHOh1fQ/3csHX6N94e2/I/7OeKwDS+d8l0t7giDE4+BRwwlznbQwWnlMv4f6WblU1hImg121n/rOcJoZ8qWoCv6ZBgRNS2FYcgwtRRukqPhkvjQmGTIDtv9XMElz1Wk0L6CBeCmv9eT4rGH2VdGuuFRHm1wTPwW/vobX+2jgx9q+q2CwFlvG9U7PMszU2gN;25:mgArqR6vvaeubrnCurmQjr3RZXRZo2WA8fBW4T29LymPUkkbIdFEwwghYJmo3C6pEYvpNWSOJ2JWY7yPvShZoTufdlKljWxLvI+1eUSdomnWz03/RLRq8Ft/+gBkAKTKLPgltUzNgC4J/r6cb5dbejrdzCFfVceLrge9eVs7fxJk7o74ZG4qXzbuMFhVA+2Lb2Sgul9YwDCpiuwQkKSYOXpxXaMpepyoqkzh0HFNdFBAvZXHtz/oBlHLaQuN7eIY/5BA7dL2Dzc8CnLnRrOqx2xNzkl/DVh2IZVP+oi/afWBBp5RIrcY6rbMpE2VE8rPhFbAH1fKYlu1jbZTYHBVNQ==;31:ifLyK+523zHRUMLi6yzewM0n6Go7yjzzOr4gMCG728BoyTr1NgVVcV81iVHYYSoUuOZr78TOstigRZ7jF5g+VDyx8GAvGlkjVzADvmhyE40SLk5m5FwUMUPI1AgvkXggQxq+BPzgp7pSwHwgl7UJgHGzGSOt3m0zyyyO3zgYX+t1pWPCqeT6+h7QU491o3+XS5v2FmGV3GRw/yMdQL/H1RObaSGjqNlXp961OE/BmKQ=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27771AF49D7DD341128D3040BCAA0@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501320)(52105095)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:VVgGS4N8VxzRYpXIOCt8HhbWZ0JgtObT0pyQ5Jt3RQQlwkWr0cLO/NmZ6zq25iLdXFEtTugoNO65qCNLz725V9Cw1jUfsM4+IEHwFVc9CGbLiSghXA8g3wkSq/iBDLXouxQmn9JEULdXmY6j7mLOV+LnPKiC8ZD0y+sOc45DmVjlUKW0x5aniEWpXL3n4qD6YX3GzUTEPFbWMqmQVJy00AxRuX3gPyWRRFn0rDbf0UUNp4ezKFr5cM1Y7RqR7V77AjIaO6dy4TIY4sKjGtp+Vrr2RNVrkps+hMT/1OBwS+iJpzcPdpHD879RTEmhq1f8
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(366004)(39830400003)(376002)(39380400002)(189003)(52314003)(377424004)(199004)(26005)(6246003)(36756003)(52116002)(93886005)(230700001)(76176011)(2486003)(36916002)(52146003)(23676004)(58126008)(54906003)(106356001)(50466002)(2950100002)(81166006)(6116002)(229853002)(81156014)(64126003)(65826007)(105586002)(8936002)(3846002)(6486002)(53936002)(74482002)(478600001)(4326008)(305945005)(16576012)(2906002)(6666003)(97736004)(316002)(7736002)(65806001)(5660300001)(65956001)(8676002)(47776003)(66066001)(68736007)(31696002)(77096007)(186003)(31686004)(3260700006)(16526019)(25786009)(575784001)(53546011)(86362001)(386003)(117156002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzc7MjM6eTc1Lyt5TG9DS2FSakx4WWY0c0dTanBz?=
 =?utf-8?B?a1I0NnE1cFFnMjQ2b1B6NlNVY0lOVEd4U3BNZzVtTTdwL2l5NmVRbHlUSGRZ?=
 =?utf-8?B?T1c4UXpsaU16Rm9qbGFKSytZbTFxeXYzQTJ4dFZKYWIrclc4bXNySmdTVXgx?=
 =?utf-8?B?VjQ1MzF1am9qV1dwaVh3TFdNbXY0OHY5OSs0YXZpdStpOHh2VCtFQnpYQjJo?=
 =?utf-8?B?aTV3cnBEMHVlOENoaWJ6SkN5OC9sNjZoWFVVMU90dUF3aklxOG51TUtvTGln?=
 =?utf-8?B?dE5wZVoyMFVxSjNVVTE0WUg4REtjaDRWVTcwUzhNNnR0elhMYmF6dFppMmRO?=
 =?utf-8?B?WmJNUmFSNmV1S2hOdUl4alVCaUtnOG9FS3lxUUdGZnBmcytMcElFdVdQL3RQ?=
 =?utf-8?B?QWVEdjNYcDFaVTVWdWkzcytRenpHUFJYWi9RK25nTm5YOFVieGkyZ1AvTnox?=
 =?utf-8?B?VVArU2xmUHIwakE3YXE0bTFheUxUZWdXSis4MktnYjJCd1NhQmhjMW55N1NT?=
 =?utf-8?B?QWRkTVFWd0lJT3N6Zk5iRzNKcGxyL3JwbGg4R2ZndWxndUs5Q2R0UVBoRGtL?=
 =?utf-8?B?dk5MTGp3KzQzSmNnZDZab0VqZnlPTGpOTUsxRUNlNjdySjdwV2ljRHYxODBs?=
 =?utf-8?B?RTR2dkVLdmhvSDdETVdTZ3pZaVJya0s2TlFUTVlReWxHbDhOeS93ckJsS2hM?=
 =?utf-8?B?aEh4K204QTNlUEJnUXNKejQwK2lHTU85OVp1bjN2NFYwV09zVVhWVlErM1o0?=
 =?utf-8?B?Q1BKbHg1TmtQdXlLejF2SEtDV2s1elRjcE9XRGY2RnpxU2c1WHZoL2R1MEpp?=
 =?utf-8?B?QlBKRWNTV1VKMm5Wa0Z5UW1GWnZqWTZYZUVVdC9ha0xNU1BENjNlMHhtRkR1?=
 =?utf-8?B?SndxcWpCbDJ6RWtJejZvYTlsdzVmYldOVEFtWXJsSEJ1UWJtVzc1dWdDcGFj?=
 =?utf-8?B?SlF0UDJjSlYydUlyZlA5Uk5Ea29wV2IzcmlmYy85cTBMWXE5QllvbG1WUStU?=
 =?utf-8?B?TjQvTnhRaTNpTnI1L2M4Z1EzRVovZ2VuQXdORVlIUmVjdG9uYzZsZWdFR2th?=
 =?utf-8?B?K3lqSFNkV056YWVSbXBGYWNRL1FFZEp1bWtBWjM0eXdTdGwvRjRuVytNNzg0?=
 =?utf-8?B?RmpCUS9FVHQyZkN5K0NTellaUDcrSFFyWlBMdzAzd1JOOXpMTUFXRnY0bFhC?=
 =?utf-8?B?amUvVUdaSGlGOVFjNGFrVTFkYjZJdUp4aUhXZW9mQm56MlYxdTBPUFdmbEpX?=
 =?utf-8?B?UUNwWmtoNVdkWXh4Uk56ZGJPNDIrbjV1V1RDTkFOK1QxVWREREFnc0FhdHlT?=
 =?utf-8?B?SWMwN0txRlJUZ3BsSlNIYXp2Y3hLaURoZXVoTk1uQWY2c0pRcTVONzNISkMy?=
 =?utf-8?B?MFhPQy9rVys2aVlVQ1ZRNlpad2J1c0hJcmlmc0oydFIwS3o2UFVxRHNFQ3JP?=
 =?utf-8?B?NkJMbXVjVWRZenZUZ3RENUl2NXdVdDVHVlBQbjU5TXlnTm1MQVp1UC94N3hK?=
 =?utf-8?B?cThha1JleW9iZElZK015K1R4THNYMXh0TUJKUkVGNTc5VHgycjd6K3pBUnJR?=
 =?utf-8?B?dXVFcjVBbS8vdXlRV016VFFSZG1RMjNuSHhRK3FSdlBCMkFSTHROTXZPZWJp?=
 =?utf-8?B?dFliaXoxbVBqb1c3bTZjWTV6Qkg3dzVCQTVCTExkUWduUG1QU2hRMXFMUHBx?=
 =?utf-8?B?clZ5WWdrRXNXWVY5UzF3OUV1d2VnTlVhUUZnZjc1ZUVPcGp1YkVnQ2ZMSjdW?=
 =?utf-8?B?TjZqNlBFZHhZRklMNjU3TnNoUmV3U2wwdG8yUTdjS1djTytRSFBWeUlkZjlu?=
 =?utf-8?B?Z1l3YVQ5b2QySlZjMVdoclZ2cTlROHZFUFp5T3pCVlQ5Yi9tb2wxdDg3S2lE?=
 =?utf-8?B?WFJMS0prUlcrb1V6S3FEWnI3WVZDUDUwR1pQYm40V1FXUjNtWEswc1A5UGJr?=
 =?utf-8?B?SVVWUExBSXFRdW42QytOMXNoOW1EUXRVcUdVM3EwdVdiSDNlcFluVlpvWTBy?=
 =?utf-8?B?NjdqVmhlKzY5V3IzbXpIMHZDM0VTWENtNExrRjhIaGVveStIZEJRdjBNdG1a?=
 =?utf-8?B?RGxaZGtrQmQzZlJPSTFRUWNRaEVad0l4MTRhR1NYK3gyc0RJWnB5SmJoSDNn?=
 =?utf-8?B?ZzZMdz09?=
X-Microsoft-Antispam-Message-Info: f4fyojbfVSPvcBEVctOwWi13wIcsXBG7ubqEFC5RTtvXmcJ1YgI3Wg/E+LAcEfbcgUvn3YqrhT8HEmrjMT+aNopjSkdXoX+twJTFv+PEJe0lcNdzdzPN49Mcs3e38oWj90XmuynUEBn9i2v7lLcu7lSSxem2itaxuxOBaxLS7q7MG2/7jIA8OW6M3lxjMYZ9
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:X3Qd2Z22Tm557xyCLASH4yvo1ixNegQpf9VyRtq5sWqn7juSlUCWZt/9qt5NuXRNwUl2huxecxJmrS/W8Nni6cVdhNquoHmPirKN73KjyVRGJItPf2r0VfQ4DRPEE1Fw1ngNTjBu8/3Vx88unaHGtb8h3FA7stljv35xWLD3UGAXpG7klbOyD5QtOTMw8KvrhxnGbM8bWChlT0Phui2HKV0x+za2/pa6uaHAzS5twZ86IA+KOJPmlQG4Jn5mbzgu3yg9Oq+KV7c2UVjMjkC9YFHVlLztfbgb7TSvd+/jVNe+7xMZE797JsPyuv7WT7cFL/t2emYtNHhNTEMlVEgNZ2BrZtOlCpRNq2F9dMPwYbA=;5:IgHkfG24e/4yIPp5n2PeK1qZdYQWng+3PmZW8KXsKVhocSrYGvq9RdHPCKCbSZTLpPr1rdp1ugCNDvVD1s9dUfxTzo5PM/86iqrCii3MY04fwNFWpZqGt7wdHLnzZ27/gDVsoOkmNLmSDy/GfVirSC+/zbsD4pyX5ElgxuQkQhw=;24:zAjUfXbI70cVdjkO0y8ipbjYtVTK1jmycrfZSl4DbRaQqMVrKcDeexX2E62Lt9vXSt5TAtkIz3S3amK18R9ROFzI3nsy6HGQ2c9bqIVud2w=;7:223nXTheNNQbYSpq8mOn2QvHmrndbSDGRn8t/WW0dclbqTCGuMCwwOj9NjiLsNUImeAvKnIA02vUW8DZYSM0gtUReEc6H7VjjgzVsksRgRLLa65ki+/vbJPoYSe3fJWFttcreIyHfQQqoXRtUYBvDBM9H+LFXv+olSCmvrrX5pVmwU0CeZm21PuELGnDrUcglmH9xDKBD1O630/gok8uOFXe2/RnoQtnUbOL/jQawYlDRdgNvdiELlHNmgZOXK38
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 07:35:19.0868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084408cd-6379-4733-594e-08d58efe4c26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 07:54, Vladimir Zapolskiy wrote:
> Hi Peter,
> 
> On 03/21/2018 07:53 AM, Peter Rosin wrote:
>> On 2018-03-21 00:24, Vladimir Zapolskiy wrote:
>>> Hi Peter,
>>>
>>> On 03/20/2018 11:31 AM, Peter Rosin wrote:
>>>> In preparation for PCA9641 support, convert the mybus and busoff macros
>>>> to functions, and in the process prefix them with pca9541_. Also prefix
>>>> remaining chip specific macros with PCA9541_.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/i2c/muxes/i2c-mux-pca9541.c | 26 +++++++++++++++++++-------
>>>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
>>>> index ad168125d23d..47685eb4e0e9 100644
>>>> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
>>>> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
>>>> @@ -59,10 +59,8 @@
>>>>  #define PCA9541_ISTAT_MYTEST	BIT(6)
>>>>  #define PCA9541_ISTAT_NMYTEST	BIT(7)
>>>>  
>>>> -#define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>>>> -#define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>>>> -#define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
>>>> -#define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
>>>> +#define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>>>> +#define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>>>>  
>>>>  /* arbitration timeouts, in jiffies */
>>>>  #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
>>>> @@ -93,6 +91,20 @@ static const struct of_device_id pca9541_of_match[] = {
>>>>  MODULE_DEVICE_TABLE(of, pca9541_of_match);
>>>>  #endif
>>>>  
>>>> +static int pca9541_mybus(int ctl)
>>>
>>> static inline?
>>
>> No, "inline" is only used in header files in the kernel. 
> 
> No, it is an incorrect statement, you should be aware of that.

Yeah, that was sloppy wording on my part. Let's say I meant useful
instead of used. My point is that inline is quite useless (in a C
file), the compiler will do its thing anyway. Rhetorical question:
what is the point of having both noinline and __always_inline?
Because plain old inline is overridden by the compiler, just like
the register keyword.

>> The compiler is free to inline whatever function it likes anyway, and
>> in this case we do not know better than the compiler. We don't care
> 
> That's a candidate case, when we could know better than the compiler.

Could we? Maybe for specific compilers and architectures, but
probably not for all cases. And the future is in the cards etc. And
we don't actually know even for current compilers. Also, quoting
Documentation/process/4.Coding

	More recent compilers take an increasingly active role in deciding
	whether a given function should actually be inlined or not.  So the
	liberal placement of "inline" keywords may not just be excessive; it
	could also be irrelevant.

> But "don't care" argument is still valid :)

Yes :-)

Cheers,
Peter
