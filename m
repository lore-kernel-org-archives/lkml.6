Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeEJTQq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:16:46 -0400
Received: from mail-he1eur01on0137.outbound.protection.outlook.com ([104.47.0.137]:61264
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751948AbeEJTQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:16:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/2] i2c: exynos5: remove some dead code
To: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <CGME20180509194548epcas2p25579e969e21707afe2435b1f568ff005@epcas2p2.samsung.com>
 <20180509194532.28929-1-peda@axentia.se>
 <b3915e40-895f-2a72-27a2-dcffe504456d@samsung.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <fa946b32-99b2-c59b-e4d0-7188fdc7bfc0@axentia.se>
Date: Thu, 10 May 2018 21:16:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b3915e40-895f-2a72-27a2-dcffe504456d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::12)
 To DB6PR0202MB2775.eurprd02.prod.outlook.com (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:bBuWjs3xaP2mFcplNvB9StXCPK45mjJy5G7cmlntpaagispZcwcuzAQJyoMeNBlhxu6DSuVBFlaplX5Efsych35VwHOWA64kudz2MKAJb8J9qenPfYRfWKbnswGNSNbiMmqoc41jPqZL8AqfyNpB9Zy3YWPklDRc+edmygNGZb6OOLZ+g78qq5n9iN6MIMR3CM83qJmDlX7mPnzihEmRQFkgO5MSw+UOEnuZ/Y8e2K69VdFhrWQq+ZTHjYQizAoP;25:p843vVS6HJ/s5AbWN/yCViQM32e9ljjIiag4z8zv9tSKHNgxiPG2JXlrVDHVp8kMA3TY5xxVso+JKJagKUvpDP7OftkYmeTAk33NzMgV/41MONQUaQo//DFc63JYqLACw5gbUkbQ59R754tQ5w3JhJT0SMp20n9XYavtesLY3xuhaI5C6TOHC3d6V3mDzDNIVT/7fMps+s0qnSOJkFKNO12g16nnXumNCIM0bNqq/iVP3gPU24dSi3JmX3EMQILPkWnAjkoRdKR/TL3O5N7BHO0p7je+W97IDo+z2X46Mmr1sqfj1QUwZLQ4UlG9Zaz5bLAgGb05Cew33/kLUFfCXg==;31:IzopVl3E2OpzmU0SCgx3kn9D5GzQIyxWTR8Sxh8QQqgy2+HUKJGRvGku+Zfl25FSb/+ozCn6NejkEKKw7NCvJpJQ0Y+yYoZJ/pKX8gimcD5OYCsCK3daB6HU6eAS8di3iFqNB6e5aClAbPpOxREYnILTfKBb3QzA5euPegjErgu7CN3xOrq9nAoNsLmgnngAULxZCUlxv2iHpSVoz9JzEbxHLEt3sc9PXzuVKFhr5AA=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27753047A9F7BF7F99234BEEBC980@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:VUkArMfXGk0l1VxpvIzebReyT/7XsaoqEdWcS95apE6IWMs46KfyCgc6eAE3dpxJE6yMnAj20qve4jkkkzINMmoIQlBH5g0srLyyvOM/H4Sx6fHvXbhM9lv5EDVv00aiJKZKCtbZQD94wVTSFRJjZusK43OP4OJVGOwN+7tsZQ16GdgjNhgavkVQnYieKwW9oRBJoQPGcuAW8mDEuEBvmRpJpFMH8v0/I2FAuZU83cDzl7mzEDZty9KNjVorf50qEWvoJEu3NQB/RZIQvs8ndX88k4BDZnB+0sxwjTUrByS/SuRdgd7VQlFHx9yGWUc3
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(366004)(39380400002)(376002)(346002)(377424004)(199004)(189003)(51444003)(58126008)(25786009)(36756003)(16576012)(117156002)(3260700006)(54906003)(76176011)(305945005)(7736002)(5660300001)(23676004)(2486003)(36916002)(31686004)(52116002)(316002)(64126003)(65826007)(52146003)(26005)(65806001)(50466002)(7416002)(77096007)(229853002)(105586002)(16526019)(59450400001)(47776003)(65956001)(53546011)(2906002)(386003)(66066001)(186003)(68736007)(106356001)(31696002)(86362001)(81156014)(81166006)(478600001)(4326008)(2616005)(11346002)(446003)(476003)(956004)(8676002)(6116002)(3846002)(97736004)(6246003)(6486002)(74482002)(230700001)(8936002)(6666003)(53936002)(486006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6WG5WRTM1c1ZxbDNMSERXWUxRcy8rYTI2?=
 =?utf-8?B?WXJxdStBVkhaZG55WTk3ZjN6aTJReGE5L1JKRTI0RGFWemFLSC9RbjVZYWx3?=
 =?utf-8?B?K3JvcEhIKy8yb0lITWRqRHVEMmk3QjBkYzFRVU1qU1IzRU12U2VJUC8rVlFa?=
 =?utf-8?B?S2tqMWxWVktvUVNiNlowODg2Y1dFeDVnM0tjc2dVYVNFbTk5cVY3TGVSMHFZ?=
 =?utf-8?B?NzdLb3VCSndCQUszQkM5bTE5VEJuWG1TK3NRcVZTV2R2OGM2eEh0Tk1WcEd5?=
 =?utf-8?B?SDQ2djVxczMrL3FheUtSN3k1VUxxSUxLMkNkbE1BRGtyRDg3ZFhMclhORHA0?=
 =?utf-8?B?QUZrV3hGUHA5VTBvMkxGbThKVHdYUE0vKzlxV1A3aGJEMjkvcXJNcHhKRWNX?=
 =?utf-8?B?YjJBTk52eEtrUFlZWEdWMU9yTWNqRmdaM1czdElqTjl4VFdEYlc0UUFURE80?=
 =?utf-8?B?TUdpTW9xSFkyaER0ME5VR3VNS0tMdFRvWmlPR3dLL0lNclFOSjJkZ3RaZjht?=
 =?utf-8?B?VEtodzQ5NEVWbEVDOXpXUVNZUXYwSE9TZVU4ODlCRFJaaEtnZjBHMmpBN1Rn?=
 =?utf-8?B?TGtiUndYNzU0UC83RW9aQm1CdkFTMWpheEp1WVhJdThJUVN3OUw0OGRCWmFK?=
 =?utf-8?B?SWpUOWZjY2RvL09FVWVqaDMyTVIxUURvL1dTbTd4SGNUU0VibVF0OENoSGEv?=
 =?utf-8?B?VmJBOVpqUkhKUmMyNjJkekJjSk9VRVc4MkNHVkN1Y1hhMWhmL2dxM1djY1hh?=
 =?utf-8?B?SE81Nm5oaUhVU1B1Z2o3alpMUXQ5ZkN2ZG96WUd2RjdrcE0reUFVdHVxU3JZ?=
 =?utf-8?B?V2J1d2FUazhpWGRlenl3Nk16ekpib3VNNFVQZWNleld6bk1LZEpqMWZFTjI0?=
 =?utf-8?B?UTRrMWZUSnByK0Y2TUExVUNBK2U3MEQ4UHUzKzlMVzdkZ0NQTG5VSEFFTmFN?=
 =?utf-8?B?aHJaQXVMc3hoRnhXZ0FQL3o1clE3dnVSZFE0RGdOVEFSTHA2Z1lZWk5IQ0F0?=
 =?utf-8?B?RWFQVkdYSU5tZXZSM2orM3RQblZhYUlTMDRhak9OTWJWdXdGVVZlMm9Wa25p?=
 =?utf-8?B?RFdFVGQ3UTNoUXZhNTViN3BBbXljenZ2OUNKZ1RHZTAzR2ZvK1R2L01kRkc3?=
 =?utf-8?B?aGY2b04zWFdvYitDakhjS0psYzF0SFVrWFl6NERSUVhIZkxTc3JkYmZzZ01y?=
 =?utf-8?B?NkprT1ZrRHVOY05MNVdYaEQ1b1ZOdk1JNWt2TVZROWhlb1F0c0NjM2tHT0F2?=
 =?utf-8?B?cStMQ0x4ZDBZbzNkeHFyNWZoazZhSThFQTk4UWVtSEE3cHoyeHFsbHRZUUE4?=
 =?utf-8?B?aThmZVhERDUxcGhKaU56MUdVV3NJVjJLbjJHdWptaGI1dkZUbnh2NTg3cElL?=
 =?utf-8?B?WklWdS8vZEpCMWNOMHV0Z3pkQXE5T0hWeG9tcE9rSUEvM2txVnpuNFdMdWRp?=
 =?utf-8?B?WEEya3VqMXpXWFBVbU5WZTJyb2ZZbzlUeWRaTjVaNzJZV210VkxlOUlSUkNl?=
 =?utf-8?B?bkRCSkpRM0Q4UDViWkFUcEliZjlGZEd3RHJCREhkbUR1dU94NzJFYnpXMEV4?=
 =?utf-8?B?ZjhaWW5QemF3U0h0Tnoxb3p2QVdLS253S29YMEVZN3Z6QlhOV2pqd0hVc1JR?=
 =?utf-8?B?VE1NM1BiNzB1NXdUcS85Z25QaldDV2hQTW4zakZYbHNmMWxMMEtSZ1piVlBO?=
 =?utf-8?B?MWFsRDZvcXEraHdwN1ZmZk5ieCs0R2R6THNXd00yemROeCtmL0dEblVveDk3?=
 =?utf-8?B?c0R0Qi9Kbk9FY0MzenkvQURrRUxVd3F2NE9tMXBxY3YvTkxjMnVoeTdNSWtX?=
 =?utf-8?B?ZEh5djhUQWpQM3pZSWJSa2VMQTRzSUJ4NFo3NDlBVHlIQ2F6UU92c2xWcm1p?=
 =?utf-8?B?czJLaEJxRHhSbVc3MGNxaWthUHZmd1JGeXBYTWRLSll5ckhzYTFpOVNKVStl?=
 =?utf-8?B?ME4zRjhBNVpKdnNGQ2gzdE9kdlppME5VMHpRMVRwTHltMWVJOW1VL2dMR1lP?=
 =?utf-8?B?ajZHVkZ5K1NjdlM2UlBjMURnY2N0Zm1GSllBSXdCdmF1bUlYaXNCaWFnTXht?=
 =?utf-8?B?UWZJd2loY3ZvTjgrRE9XWjhSaWpRTUwzcythWk9wbmQzYjFKRSt0STNCSlho?=
 =?utf-8?B?QzRkZmdjVXlLbjNUK3BtbHM4NnRKR3cxL3lVR0U4WVlMOTJYQWtPczZyWndx?=
 =?utf-8?B?eS9Ec09Hc0dwMVNFbkdQR2lUNGVWZFE9PQ==?=
X-Microsoft-Antispam-Message-Info: 4RTp6RU2Yk3Cfi9Nbfy9h7vMu3BlQW10LQe+nCyXIs0UPHmWWWAbD9ZQGAf5PQzhEXNBHFe2qmRWvKr+/eycl/IAmaT/JClGt0xAyHaS4SCrvKCugF8mrBwMFdc148tv8pHOhxXYEScDcVfICXp6TThFex2MQug4qkq4AJUVHhtVaMQ5n9wu+dFS5gRBtQJS
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:c1uXNfnQfJsJwW4DajbcnRYZk6Z0AgRtJ8pdjB+JY3irtCRfqn+KkGwmyMXpGHka9X8S5287rv7YKw0NMYWxRLman0lLGp6rNcJFth0WL8VAoi/4fy34iXNK6E8c3eNF31eWi9L8vorVQuONs1hXXoBAzU6pTROxjYfKgqtY7OnY1BwSjwEoR1u8CvM8Ql2utkfR898P1gRsdwLuBlYNLkrRJo4oQqWGCeq1kSjvcsF4E61IQyRE0WGt/RBUVGGlRp9FK8VYYB6WojJCJIqSkbmOpDjooh1Phk93fybfP0rIJeBE5Ifovrlq+5WG++5E0kGqk+PeKshpMAu5fH6jiX/ukJ+tYuYolIB5rld6+X6Wf0lQK3qhucdJE5duXCmHHoIt6v5HxkqpnnqbKb1XrPBDrctoErzWlytY/rwlf1qC5qP4nKV9+LU37LwBMUpULvnmd3l7kVZYMRy5UB55Pg==;5:EBr5rurv5SvR9YehZ6xFzHUzh+Iedzt4Tffk6ormx9mXcA3Hz54ZHAMkiUib7YeRISLwfkhuXHfIecSAt6K4qdN1nB1Xr7T7vp9kteJ1f+ioGsR/n7YFmwV4p8nO7R4uPEhEsbw92DQIvYpr8cp92dpHhLxN0gDkNZGtQyLLwgw=;24:hZ9X3RCEShZVpcT8K0W1bSLQpyA3Owyvcrx0jlVlLJ43+thTGPDTpBfsV+xpHkHjmwJSo0LDU67EtugOvRbewdIaoud8QHCX6HTgPEB9c9s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:NedEsZp178pSSWk5lQhBYggzvXI3+CZNTDOrOFuRbHxQ0aD6iZn7Bhj57bQMSAXQCnxNM1JmAKQCl6FO28a+Lz/H3ApIWwCz4L9cueeWRfiiS9PUlLWN78M4zZ5TONLskE9QY+zV3AO5JKt3EZm2AbcT162Jt6k8OV212HBOkMp6p3f0p24Rc7MqIHlcAfgs9xHlmR/j2GEAFJrkYjc23KrTE+eQaabA6WpuLEHQtZw1ME8Gzat7i3bdjx1SLrBp
X-MS-Office365-Filtering-Correlation-Id: ec961203-8cbd-4c3c-7e8d-08d5b6aa8b07
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 19:16:32.7106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec961203-8cbd-4c3c-7e8d-08d5b6aa8b07
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-10 10:36, Andrzej Hajda wrote:
> On 09.05.2018 21:45, Peter Rosin wrote:
>> The else branch cannot be taken as i will always equal num.
>> Get rid of the whole construct.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/i2c/busses/i2c-exynos5.c | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
>> index 12ec8484e653..a2cbc779c33a 100644
>> --- a/drivers/i2c/busses/i2c-exynos5.c
>> +++ b/drivers/i2c/busses/i2c-exynos5.c
>> @@ -727,17 +727,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>>  			goto out;
>>  	}
>>  
>> -	if (i == num) {
>> -		ret = num;
>> -	} else {
>> -		/* Only one message, cannot access the device */
>> -		if (i == 1)
>> -			ret = -EREMOTEIO;
>> -		else
>> -			ret = i;
>> -
>> -		dev_warn(i2c->dev, "xfer message failed\n");
>> -	}
>> +	ret = num;
>>  
>>   out:
>>  	clk_disable(i2c->clk);
> 
> You can go further and remove "out:" label, use break instead, and at
> the end use "return (i == num) ? num : ret;" or sth similar.
> 
> With this change you can add:
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

But then the patch wouldn't be so obviously safe. If I would write
a function equivalent to the original function, I think I'd write
something like:

static int exynos5_i2c_xfer(struct i2c_adapter *adap,
			    struct i2c_msg *msgs, int num)
{
	struct exynos5_i2c *i2c = adap->algo_data;
	int i, ret;

	if (i2c->suspended) {
		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
		return -EIO;
	}

	ret = clk_enable(i2c->clk);
	if (ret)
		return ret;

	for (i = 0; !ret && i < num; i++)
		ret = exynos5_i2c_xfer_msg(i2c, msgs + i, i == num - 1);

	clk_disable(i2c->clk);

	return ret ?: num;
}

And I think that is safe because I don't see any possibility for
exynos_i2c_xfer_msg to return anything but zero success or negative
errors. Since I can only compile-test, so I do not feel all that
good about going further than I did.

But if you or anyone can test the above function, feel free to make
a patch out of it. I don't care enough to make a bunch of iterations
on these trivialities. I just spotted dead code and dumb initializers
while looking for other things. So, take it or leave it. I.e. it was
just a couple of drive-by patches.

Cheers,
Peter
