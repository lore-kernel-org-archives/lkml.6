Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeEGN7R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:59:17 -0400
Received: from mail-eopbgr40106.outbound.protection.outlook.com ([40.107.4.106]:34336
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751943AbeEGN7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:59:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/3] drm/sti: do not remove the drm_bridge that was never
 added
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d378241f-7420-bbaf-c447-18cdfd4f9dd3@axentia.se>
Date: Mon, 7 May 2018 15:59:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507133929.GG12521@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::30)
 To DB6PR0202MB2773.eurprd02.prod.outlook.com (2603:10a6:4:a8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;3:0u92xtDnHmStSk4+YvDB1qzE7AQGMn/brxb9tlLRHXGumoH6CYGR6qa7SnhcwBYY3qp6LrVXmi0CJE/VZd8LMxK8ZZR7juc3Q5dqSQr1Ed8fR2YCg5RM2CgtrUd4Dw580dnPmR8V0WoIr0H57o/3FNc6pqjm2IgGyYZMBapBplaSUmBZJDPWukxUubpUbspkV7QFB2Z8/sGaun9B4R+DJAeXN2S7HnM8vWWAixUkMdwvTs0jdj7TeN73wokRjLAv;25:CvKJt52dSHf4JfgXQmgM95MuusSN4GCWBQYqkNUaupHyW2/Pv1mswbEskPrNBNiqGkxTvfSpFfgme8SMH8qcUNeE2prYCkatn3X1BMIvoTvW4R1s0PDCbBnOyBqxV5Y4PBojRpd+RzB5I3RrB3AvCLpvMZuLCPXjqN+EndcGN2zNHMizjZa6gZ065tX73fhUGmviy6sjuQ/zw6CFzkSAmds69mnIP/Ondlq4RHizmTss2V3je6b6kXwzQ9DOgzgyzPDYi4c7/8T8VkQQQ6RO9x6vwJcksvuz//KFELw4EaAErLrfHprrsHSztzt20YVGWAKzhfCnQFhYR06nkhtWJw==;31:TvmTztXFdIdmaVVidTBfJjQm67qsEIceKDz4P25FMZb5UNyR58ErO4TI/3vOXqqr6eql9R9OgsUgRqlzHlK6mMQnAA1tpQFNdiH6ZHyv47SJB3UCNu8U8mVHsKMA0OJftqhM6tKKM8taVXPLDmozuiT9HNC1Usr/rcpQWQWJt1A1TsezMyoUmWqLWOisnNoTZfcvFHcK5nA1siEY5bdO53bz1hi5za+Fy4CoWvNcMTw=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2773:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2773D50DE69AE2554529EDC6BC9B0@DB6PR0202MB2773.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2773;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;4:1B3Grh0/IGgsj2sWItJbtwo7Nz/1Tq78784UlMJbLhmU/i+XwFK1F37QBjy4d7Dt0KsgndID1t9imMSv/J4Pybbvd33wheA64D9cgU3j18cFqoE2bKiX4wJYhWX4W0S9ILjyBO/D3d3n+DxmkaazGGTlwwx5uHJLl4TEeUCjZvxdbO5W9rdFvEHOMKIXsQYq5yLLClXyEGagxvGF+Ex5O35Dtk3nIXws5hETyeAdkYuQ636t7CvxR7bpaaPX9B7DAp02XCFZgL5SgAoruaUNsP2bADEykX2Uy3k9Cjh/ylKfz4NSo0IQyQ9gFsqQemMvjLYJ6qB2kJmUIiUKhNF2WFnGjXXvrQJi/eOHrk14k9k=
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(39830400003)(366004)(396003)(39380400002)(377424004)(199004)(189003)(53936002)(25786009)(8936002)(7416002)(117156002)(5660300001)(2906002)(5890100001)(6306002)(6246003)(476003)(3260700006)(2616005)(956004)(11346002)(446003)(31686004)(97736004)(74482002)(68736007)(486006)(230700001)(6116002)(3846002)(8676002)(47776003)(478600001)(66066001)(65956001)(65806001)(58126008)(316002)(77096007)(26005)(36916002)(110136005)(16576012)(229853002)(6486002)(86362001)(6666003)(65826007)(7736002)(81166006)(81156014)(31696002)(386003)(53546011)(93886005)(64126003)(36756003)(186003)(16526019)(106356001)(305945005)(105586002)(23676004)(52146003)(52116002)(2486003)(76176011)(966005)(50466002)(921003)(1121003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2773;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzM7MjM6RVB3bGVyMVl6NHJ5ei8wcFA0cklCK3Qx?=
 =?utf-8?B?ZHpWY2lkcjBNc3lUVWZyUWV3cUVGWEpnMWFMeEp4MjlUdHRUWis3RXZwRUZF?=
 =?utf-8?B?SDhlNno1VVRIZ0VUSmdFUkRRbXFCbVhpSEdycWx0cVZUYnFXL3J6MmJ5ZTIr?=
 =?utf-8?B?MDBUblZjcTNaU0xLNWd3NmZwN3lGYk1SeWtOWWJscFk5eExYbldjakdXbUZF?=
 =?utf-8?B?VFZzQmJNRmJjR3Q0emlYVXBVN2ZCQ2psdkZJTWtDbXRTeUNuOFpkZENOcGJz?=
 =?utf-8?B?Y0gzQmQwNVRHY1dhOURITyt4MUZwSUo2NVIydEZsNHdHaUU0WmdEL1oxQzlO?=
 =?utf-8?B?QmYzMXFCeXhwN0NMeHJrSHZDSEJxSTVmZEV1YXNGTmdOMkFBR1cwK2hoQ1J1?=
 =?utf-8?B?dFVVMFB0bnV5MFBtT09CM1FSRXloOVZIakZTNG5JK1FTWWNNUkNjMGJ5WU9Z?=
 =?utf-8?B?VjZPUUdkRjRkZ3FDSWVVeUt4a3BFQnJnUXF3YUVCVjlwUERWcjFqenVVeVAr?=
 =?utf-8?B?N0xQNU9hNlZZSmlYTVFHYjhVMm9OL1AvR1dRVmc3TmY3L25RYUdYQWk4SklD?=
 =?utf-8?B?Qk93bHJjUkVYTWhqZkdROVYyc2xOZ1pyWm5tblcyRndVUytDeVY1WUIyc0dW?=
 =?utf-8?B?SUIzaXJaeVpFODEweC9PK0N3azd2TUkzODVYcjBVR3A3NkdGVk5NajIzaVMy?=
 =?utf-8?B?SW5hTVN6Z0U2WXhQWWp0N2ZodEtHOGRxVUYyQVFKNldOeHN4U1ZSRjIycUEx?=
 =?utf-8?B?MlZVcGt3MnRSVmEzSUpXOUVlMEpucThnRlJBNXR0d1BIVm4vWURXT0JOZmVI?=
 =?utf-8?B?YTlMZjc0SUxaTVV0VGFESGFNWVJwdkNmMGN6dkh4TDRNME4zaW9ITkw0aC81?=
 =?utf-8?B?Sm9oUmhlNzJpdXpXSDByY1VObjRWaCthZDJjb2lkWVR6Tjg3RGJTaDl2YXJm?=
 =?utf-8?B?WnJFQmsrblJlbiswN3dBZGVXMS9rZ0NjM0JOTzhXUzY4S0crNWdmdmhUMGJk?=
 =?utf-8?B?WEZqWkFReFJTZ2t2STJMdW5lbzMwZlpOenM4RlJEQU9HWGU1OWRvRGNkUTh6?=
 =?utf-8?B?NVJuNGZ0NWU1QW9wa3BhM0lYakNFU242ZHV1OHlQTUcxa3pRS0NPb0Q0WUZS?=
 =?utf-8?B?aDNZcFR6NVBJaS90bHB1K0hNcTgzODd6T1g5VkZuRG1PQ1pUc29yaVpWTjdP?=
 =?utf-8?B?dmMzdWl5Y1ZMOVE5WkxXUkxkY1kzQlZVazB6TDF6ajkrNWVyNmEyeStLQ2pT?=
 =?utf-8?B?YVFPMHNlblZnR0dKaWlrdzFtMG8xMnQvb3NEZXB6cnhyMERrZEpMZ0lBU3ZN?=
 =?utf-8?B?TmJlaCs1Zi9BcjZLWmV6ZlhPMHY2d3JkMHVYMVllbmd3a1JndGI4WWV5dDlF?=
 =?utf-8?B?YnJVZ3poWnJsTXJQSUFvUVJ4L1lXZnZCbTlsUE9nZVBxRjgyalIrcTd2emFZ?=
 =?utf-8?B?bGgvUnV1bSs4djFNMGJtWFZ0WFdBd0FUc3VraGtSL2U2Y1kxS05BTGNnLzZM?=
 =?utf-8?B?dnpvYVJjZk9NZFhNbmVHYW1pZFIrUE43ZU15OVVIK2Fhc1IwREJUQW5PbEdD?=
 =?utf-8?B?cGdGbThrTGhxSno5UEt1UXJ2MzR1UFJTdkhhYlNMTDdlNlFGbW9wVEJ3cEZW?=
 =?utf-8?B?ZURKSlloOWpVY0NrSldJVUg0NWNVdTl6eUdxNXRoVDVXcmpoTitKMzJwQXNN?=
 =?utf-8?B?TGNSSUUrVWNLWS9VVFlsN090M1JNZ3pzTS9RZnhnMHpMNEJRZWc2MndSd0Zt?=
 =?utf-8?B?TDJrNEhkbkViWDEzLzVaZVlrUXc0L3AyUHZQblhodFZTd2JGVHpSdzkwdnEx?=
 =?utf-8?B?eHFmbmxubUJid2R1YldGTEtNUy8yYjFTL1ZkSUFMbkdBeklBRlNDZXVHN0Zt?=
 =?utf-8?B?bEJaUE1aMEhxTDdYU3pPSW9odHJUcU5JMFFhRUVUZi9jNHYzaHlaY3ZZbk5S?=
 =?utf-8?B?aUg5REZYWE9QVGhPZHpIVXgvb2d5MHdYblBsYnd3d1owZXR2N21FV28xcm80?=
 =?utf-8?B?QUFEMnMxUFlvZ0JVWFAxMUdqNm5tY1dhZEh3YjI5OUdIcjEyNlRXTk1mVjVK?=
 =?utf-8?B?dngreFpqOXJLdGdWVE51a0RpWlZzcGNlRkNtNks4dWV6akkyZVIrNnBvRE9x?=
 =?utf-8?B?WGJ3QjFLT0tJM214UTBNaEc3aENQTktyN0lkaEJsdEZIM3BKVFRTdy9ueVNr?=
 =?utf-8?B?ZUtuRmJLKzA5VzFqQ3RqdEUyV1p1UGlzL0NwM0lXWGR0TXN4V2pMNU5EVGRr?=
 =?utf-8?Q?C2bBs9YoKDcS+3XpeXao?=
X-Microsoft-Antispam-Message-Info: w8BH6ZVHVZOo/VfYiG38h2L9PL/jBIS+fPjA5UrXqQNAy63BYCjIXiH2B9fJhPSHXeLJHoYdpwHOYwylFzFX3upXyaseloAv8vEDE7tW+bxDnVvsovWcy0QW+Ny6OVKG3GRant3yQ0tzpg9dR5lp8nVmWFt8njZ3vks3Ex0rS1bhLqd5DrgtNJHTJYwD/q8z
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;6:kvgu1NjjIhAIwB8cHt3wP/nMtRso81QbmuS5226gEtOErRwGl8B9pN6pvKEMsE016/FN6xlOuw6KkFbEYzUi4CshfcIQo/0DPR981mnPaa03KT0S9JX6GCY40MgEaDCosbXmI6E99h0yUHchbKDnpgRHgEfaMiGlBj1j666TBuSItOhI9hORHLx2Yvmfuhha/Aa2zEJb/5j4YbrtgZu2ti+ftlNLBSks/0AYyczLD6yxBRjOqUFDsV7/hTaMROs903WEOi5jW5ZyOUcmcNiYkCIidOzU9k68iYu30bFQBoBDdAyI5CN/BV+65MkNGpdFpvOv5XOJssinZ+Etg1bC4Bztf/2VPnIJwFj/maWDA4lTcrDP9M17BbQuevy7fa1PRdz/oTB29iKg4Q5/PEf6BfxCnv2yzn6MEiWh/zstQyR3meNa4WIRLcsHlM1uByAN6Y6SzpO02S0t2BspTR8WXw==;5:GVFc5Xzj8QsWh1BRmp8C3pOxBckhiDaw0HBn1J4zj65dSVu1V640G8LiywXtaavTyZViAMfcOyLLakMrtgtF7EfrkDtBkdf+d8Gbb33eTQNhGk3Guh5sG1MEEIkV+Rc9yFwfZXnvyERcJvFD7klVrXclwn4DirHCmpX6Pg8PEIs=;24:vr2SolWcayaGgG4PhpQPznzm3J9X4HnKED85M5xOGS0l60pvTjZPvZJmBhvESYlsRIP8ndVowULDfbLA63N4CzUB00IgekCvkaCwsRPscgw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;7:tZfyi737X8rFzhMeM9YY+cOCHEc9r15Pt+3Gm6hGyRg3OKJk2X/ppKxGBIKquPc3tbxeWTGGiTLP8pDC1Ce6IQjC56TM2i8oR10NJYPmbMZyFK8RBh48dIeVT0yWO/6L4aCaxhvaFM1KmEtsVfU7D/b9Sz3T1osVqUhiYn7AA+ougr5+dpi40ziblAwo3Uq6iKmO2Na9WXtHEnDX0lxPpNjRoaZY7fLSymElU91BVImWsbfX3aWVFc5p2NWK2qr/
X-MS-Office365-Filtering-Correlation-Id: 379144c6-8b44-460a-56f8-08d5b422b433
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 13:59:07.9038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379144c6-8b44-460a-56f8-08d5b422b433
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2773
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 15:39, Daniel Vetter wrote:
> On Thu, May 03, 2018 at 11:12:21PM +0200, Peter Rosin wrote:
>> On 2018-05-03 11:06, Daniel Vetter wrote:
>>> On Wed, May 02, 2018 at 09:40:23AM +0200, Peter Rosin wrote:
>>>> The more natural approach would perhaps be to add an drm_bridge_add,
>>>> but there are several other bridges that never call drm_bridge_add.
>>>> Just removing the drm_bridge_remove is the easier fix.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>
>>> This mess is much bigger. There's 2 pairs of bridge functions:
>>>
>>> - drm_bridge_attach/detach. Those are meant to be called by the overall
>>>   drm driver to connect/disconnect a drm_bridge.
>>>
>>> - drm_bridge_add/remove. These are supposed to be called by the bridge
>>>   driver itself to register/unregister itself. Maybe we should rename
>>>   them, since the same issue happens with drm_panel, with the same
>>>   confusion.
>>>
>>> I thought someone was working on a cleanup series to fix this mess, but I
>>> didn't find anything.
>>
>> Ok, I just spotted the imbalance and didn't really dig into what
>> actually happens in these error paths. Now that I have done so I
>> believe that the removed drm_bridge_remove calls causes NULL
>> dereferences if/when the error paths are triggered.
>>
>> So, I don't think this can wait for some bigger cleanup.
>>
>> drm_bridge_remove calls list_del_init calls __list_del_entry calls
>> __list_del with NULL in both prev and next since the list member
>> is never initialized. prev and next are dereferenced by __list_del
>> and you have *boom*
>>
>> I recommend adding the tag
>>
>> Fixes: 84601dbdea36 ("drm: sti: rework init sequence")
>>
>> so that stable picks this one up.
> 
> I just wanted to correct your commit message text - the correct solution
> is definitely _not_ for sti here to call drm_bridge_add.

Ah, I see what you mean. Do you want me to respin?

>                                                          It should call
> drm_bridge_attach/detach only, as a pair.

Alas, the attach/detach functions are generally not called from the same
level. After the bridge has been attached to an encoder, it is detached
in the generic code shutting down the encoder, i.e. the bridge consumer
is not explicitly involved with bridge detaching.

> I didn't check whether you instead have a _detach call missing or what's
> going on here.

So, even though there is no _detach call, it is still not "missing" as
it is not supposed to be there...

Cheers,
Peter

> -Daniel
>>
>> Cheers,
>> Peter
>>
>>> -Daniel
>>>
>>>> ---
>>>>  drivers/gpu/drm/sti/sti_hda.c  | 1 -
>>>>  drivers/gpu/drm/sti/sti_hdmi.c | 1 -
>>>>  2 files changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
>>>> index 67bbdb49fffc..199db13f565c 100644
>>>> --- a/drivers/gpu/drm/sti/sti_hda.c
>>>> +++ b/drivers/gpu/drm/sti/sti_hda.c
>>>> @@ -721,7 +721,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
>>>>  	return 0;
>>>>  
>>>>  err_sysfs:
>>>> -	drm_bridge_remove(bridge);
>>>>  	return -EINVAL;
>>>>  }
>>>>  
>>>> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
>>>> index 58f431102512..932724784942 100644
>>>> --- a/drivers/gpu/drm/sti/sti_hdmi.c
>>>> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
>>>> @@ -1315,7 +1315,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
>>>>  	return 0;
>>>>  
>>>>  err_sysfs:
>>>> -	drm_bridge_remove(bridge);
>>>>  	hdmi->drm_connector = NULL;
>>>>  	return -EINVAL;
>>>>  }
>>>> -- 
>>>> 2.11.0
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
