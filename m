Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDKJiA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:38:00 -0400
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com ([104.47.32.43]:51289
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751961AbeDKJh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:37:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Gabriel C <nix.or.die@gmail.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>, Dave Airlie <airlied@linux.ie>,
        alexander.deucher@amd.com, Felix.Kuehling@amd.com,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
 <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
 <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com>
Date: Wed, 11 Apr 2018 11:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: DB6P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:2f::37)
 To DM5PR12MB1723.namprd12.prod.outlook.com (2603:10b6:3:10f::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1723;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;3:qbqs0RpJG0/cbJsJMRUzvC3oh8tUwZM56ZlRfFVYgsotPkuOa47gVZww7mwx+u/DLUw9L03Lhk+bTm7jp8BKBbyjx0i5rsH/3LQj74uWpJnIUHPnotPC6kvQxb6Sud3GaBtyQnFvgQ1nAFwsbeWBfECeME4O+sWYYgQ3yh3gCK3vdJ5ddMiwcGCG8QQDWVoXEZXs+A3nttuFB2ZpeqL/E/Xk7yza2xaLdAIFTDyNE9QpcBKReuNSCNFzQUeX6kYZ;25:Yejp/ppPy+8/stp10qqfUh0PkYJPoJ+U0bnNDCSYLa9rEEI5CLH8lOoaTprD5exPhvtThjiT3f123bJxBtrOpNJb1QOFavNjVW0MQ1vqhWQkiK2EbPtHgu/h07AGUCbilPL0tICY7uAi/iKVG5TSRWf616wQRYXrMSbJyvImtPvOjSuqKBpLnpg+Z4S0wZMyhaCduELqWvB2CZ02BxgF/CHj+aSvOKndY8nhGVoMf53SnEpcLTMKqstlJ0zPOUb7ZDDTwhoE6RW+KkUhghZNzzDfRyfxSFA0W4z2+F6X5+bhw8z69D5ZuDXySyoFf72sEEkfNN29oCTe9uoELsYsPA==;31:tSM8JDw0wrUblqdAf4ldmW3lv2USMseREmWeZgnDd+M2TaNwZysqxwygaSlEe740p/o1hnT44Zk+j9T5R8lC/loHVBDdO1m/j55yMqw3fmw2TVxAHaEvPpI11J3AKd3wzSE+80n5JMAt22gZVVDkXCwmTiMTDjavX+QLwzRwZlWJpfiaKNOqvDM1IUXMFXC9bREJncSoQ2qMrauPk3wMhoTOpp/zTZB7v0AFqDGcSq8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1723:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;20:DqYv9YGVzeRwwkhy3h9qwPJxfwLENeUnmN7K1wU8FFZJgsEkXg7OEMX/Rd4NWyAa6JR73ynQBQkrVF7kBvhWOhFovRFqkEqNgObuVPTyOxNQOQk4JNXfEPkmu+Q5vk6iM9wgTo0XW8KOPur7Swn4mGZs/DgutwwFdfJ5jdIaSFpxWXQw09QURnl57e8WGx+yBzki7AWKFgicH01r3Kek9vBVskZgmhev0d+GCVUqnlYogDLgzveH6grAS/YYrFC0lJh4YQatsPWalTrURUT1edY6JlcrhFqzwMSa9ggwmKuYMbajDN5NejiQuXfu5OAvh1wdIvro8mzXLXL+PTg2oIYn6IO+8UW2V28wJANlG05ufVs2V6BwMr4MJgQQ657XtMfEYyZ0OYh7BkFt0mDND+i8wipG7IJRFXFBWnzGfOcKGL3pyzvi9Sj4iUNT3QeC9gpwSmM+9M9Y1tgrhVz+jztjXd130J/PWWdYpYX2/IcTEu11vQE+sBkZFQWt/Vhe;4:++/kIsbs/JA6SRKtSZHGMCMVv2nRcIQxVq0WnzM6knB2gEoqwI0RIbrx9Nj/gCN81MhTj0JpEtDt2eQOmICdwkzdEaJnL5iprwcLH+bh31FAPUDrn71G8aap5d2fDEiaaNAruzPLR8pnryamI+sDAKwWvwVKfvLnsK4C1sdJxVMlN+t8RbnHt5HVqFyk9HP1q7lywDe0iB28IDMQPXibqguxnigMJxa7acYAHPht0WupxB/8RdJ0mEPc338+gEzJjZqXWRHto7GMuAzDO+wnnL+6iLijjQC4H//0cGoeZ7/KKKSIFkl6rN+YNT/R220EioYiuRdutlSbV4xp9LMukK9/noCh3Og5haHzNsCSGzOJfjRmGsPz7iy0HEo3lNtd
X-Microsoft-Antispam-PRVS: <DM5PR12MB1723F4DED4821279D527526583BD0@DM5PR12MB1723.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(126947320029983)(15185016700835);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1723;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1723;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(51914003)(377424004)(69234005)(54906003)(229853002)(97736004)(31696002)(2870700001)(966005)(2906002)(72206003)(305945005)(65806001)(53936002)(486006)(7736002)(6486002)(6306002)(6116002)(1706002)(39060400002)(6666003)(65956001)(6916009)(186003)(64126003)(58126008)(46003)(16526019)(8936002)(316002)(81156014)(68736007)(93886005)(36756003)(478600001)(106356001)(50466002)(52396003)(76176011)(52116002)(47776003)(81166006)(386003)(8676002)(6246003)(11346002)(2616005)(446003)(31686004)(575784001)(86362001)(105586002)(2486003)(52146003)(25786009)(23676004)(476003)(65826007)(67846002)(5660300001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1723;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIzOzIzOlVmM1FBaEw1M3AzUUJHQkpuaUcxaS9kenp1?=
 =?utf-8?B?djY4czlxRzZKRTg2cFJLL243THg5dDg5WWN1UkdPSm5OakI0ZHFGQVEyQW1n?=
 =?utf-8?B?ZEtSUkVlSzQ2WUF2Mlp3alBNSFpVbUNTalppUzFhUlZuT0RIamVwVEVmQWR6?=
 =?utf-8?B?cGxRMnZSaWxZd2U4Uk5pd1RYT0pHWFhJTVFYSlJDV2djRDI0WURuV2dneVlF?=
 =?utf-8?B?SXFmRWlVQk1MQXFBNEsxTlVrRE95V0cyUE9BL0RLeXpFZXhVNE92UkExcjhD?=
 =?utf-8?B?UDc1Nm85allWQzcyb1ZEN3pJUk9uWkluZXNoRXZucHVWa3A4YWxyYkZ4aXkr?=
 =?utf-8?B?d1dqYXgxZVpKYlUyNGRIOVVsaC84Y1lrSmIwcmRvVlBCSzlWWjhFK25YRm5r?=
 =?utf-8?B?THZXOE5Bd2E4WEtEekpSemFkMWhmelNMM3RFZ0RyaU1pTFR6S0paczRPcU12?=
 =?utf-8?B?eTAyTWNHS2RSQWZtZVVUMTFRNVBxRUdwTjJtTHQwSndyKzByd3BFbEFnb1Rv?=
 =?utf-8?B?aFBzOWNBSDdsbkJLT09vbFpySlYrTHVDcHhnckd3OE02anMxaEkyZVhabVVT?=
 =?utf-8?B?ZVlHVm9GbTN5bkhpblB1Z2M5ZkNNUW1nTjlHeVdMWVRVMlJQZEZvTzR5MTRG?=
 =?utf-8?B?eE5uejBlTjlIcXRJWHQ1Q3F4QWxsMkNnTjRpcTRmcmZXOGExTVl6MzlsenlE?=
 =?utf-8?B?cXF1WTcrZklpbXp4TlNSeHN0UU5qMHpLNXJYMWE4U2NPK29VRVlDVWxsQ3Zz?=
 =?utf-8?B?MDNhbUs3U204Qm5pL3FzWlhTQmtyaG54QUZNOHNEZm5pT3NLWStEbUd2aHRl?=
 =?utf-8?B?U2RiVVlNVTR5dWFUbXVuMnBpRkdaVVI5bFo3M1RLeGhzc3paUXZBdHFUVTBr?=
 =?utf-8?B?ZUJUYTFQMCtnQ0ZlUGhFaFVsY0FIZ2xRanA3Y3o4THlGSDF0ZW9TZzBEUHJQ?=
 =?utf-8?B?ZVlNOUlqSG5RTXdpdnNIU2MzNU84eEowY0x3RkluTW56bzcvMllBSGFvdTly?=
 =?utf-8?B?WDE2SkJnZlBCUlBzK2V3U0I5ZEdFSzk5bUlrWk9MaVEzZnNWekRMbVBiSG5s?=
 =?utf-8?B?NExSRHR5dW5oREpxbkdWMVA0VEt6Q1JjY3RyckNoSWFTT3ZmRy8yRG9mOG1B?=
 =?utf-8?B?MkREalBmcEpjT1JXUjJzV1JTSlhxd1d2RFNWUUdXN1NPUjNtdENMb2MzbVlP?=
 =?utf-8?B?MTh4UURVL1JNOUZUcEF3cFd5SS8rMEtYK0N4U2tGTndBd1FJZy9JamNhN0Jt?=
 =?utf-8?B?VFUwV2djVWN4TDFzTW0xOVFYcVN1SXlPQUhaVTJ1OGxzbFV0TGcxWm9UOG5L?=
 =?utf-8?B?KzdPS0RtRTlQaHFIcEVzbVc1RjZpRE1mREQrZTFqVjd0OFhRR0Z4N29Sa0hO?=
 =?utf-8?B?UUVsd1RETzVid0hSME4xY0M0K3djRWV0Z3o2STlsUzNuVlV0RzRKaXhFaGdw?=
 =?utf-8?B?eks2QlE2bGNrd0tBTnMrSXNlRUZma0FTekpZbDVicWxaL3VuVHpLWXhIZ2pQ?=
 =?utf-8?B?S1NiNDY1eldiNThMd0lKSm50T0FZcnAyZG1uZFoxQnFWK1hISTFNcjJMZDdG?=
 =?utf-8?B?RnBYVTZINlMyVzVOazFjQ3VLWGh4WkY2WlhWSForOEFtMStaTWxNMWxRTzNl?=
 =?utf-8?B?blZSY2NQQXY5WGtvbzk4TTB1SU5IWGdXUlVrUkxmMGhacDNFc1Q1UVVNNGdX?=
 =?utf-8?B?WnYyMEtKMTNrQzdpaGR3N2NIU0p1RVJFYUwxejQxSDlKTy9SWFVpSDF3VVo2?=
 =?utf-8?B?ZHo2M3NHZDBoRDRaWVpkQmYrcUtqVnc1SmM3NS9SM0M3TVdvNjBhNmlkbUds?=
 =?utf-8?B?NXd3RlZZVitReS8rcklEc1FnLzJGRWNaL0ZJTlMxSnBBdnhMSkIxWFFNbXhI?=
 =?utf-8?B?dTEzU1ltTmR5RHI2Tzl5eDlhYURwQTR1U0djNlVOcytxODhNcmNYalhydzEr?=
 =?utf-8?B?RFcxOGdLcTRKSzV5S2tKTndEcHZ4Mk5PcCtwUld5TUVVVERjM3B3OHNqQmpq?=
 =?utf-8?B?dEE5RkFjdkZ3S0NOVDZJWWh5bWJPeXZyNHZLYWtqNGsvL21iUWhtOHJjV1Vi?=
 =?utf-8?B?WEpIK2Y4aTFiTFpwYnhKMTZPMStSUXZjazcyMVlrWExkamxaZzNxTnovSnoy?=
 =?utf-8?B?NEE9PQ==?=
X-Microsoft-Antispam-Message-Info: qg7GpwcVrxcKW49G6/1e6kcNDe00VKyvOZDCHfBLy8KM0xxN9dgOn2Sr79Ci/cUMHWPHL0E38a/q7ziucCypmCo6cPD09+h39aImgA963a8BI1shrQBWj6VOUf9s0MhhbrqcB3pvMaiwdUk8ugRsZNsV6pPAwnAT2pxjr3UWU650YcM/j7WLI+fxXdbrLo4z
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;6:QvqGEsjhHAlUKAk9vzagvWK6rFmE/VGBV6oCa2gfiVejnIKmwnkX5v+J3vixZ7QOlH/ywM/C7oLabcuxGM/kMLeLTUeKpa1GWWD7lPT8ePbbZRJi2rOjpqKvKhtiXGXw4Z9A8eYIP/aC5/NOWPzVnd2kj2hd7c+4MBzNVhOx5lRIxqpeNwEOZ0PFRaP3WmG2OKATLQPAMiORh+vxHUmEOHTMYbWVczQZ3Sq8SJDM+esDtF4UNj6D9oMylcUBcPEBP7xH/4T8oZYJAQNsFaCYxxGvVC4vlG+Is870RbebN/HsJ0732HK69KppOGtH0pg5lxKLA3AlS3zz5ZmypgIRErHLDSXBrUH32hsa9ND4LKutdfTj+bp8pAux5gFlJwkPzCUa1zu6fkcmbusZE1Go1owRxzyYFFlSEYgX7cBkCaYFAaGXEu+agcyhX15+nvX4OZ/2dMpg0pZsng0kZLNvKw==;5:agf+tn13NLchoczVpYVdeva2V70HrqO8S/0xfJ+3+D3ZiEKjdq9ZZMIduyRUhMSVOjFzgNhhnndrL0elGpy44nlUcmz1QbzurNkHXYwy7a0uftCCvd7I1qO2j67minO+DHNa1eirc7nJIS9xVh1FhXDQL/frhOX50vQQ9ALrB5o=;24:r+zgedn9RlG7tkJub0Wj8jSilzL9LS3/jpdyYRsf64uG8C0xi0g/A7QiK92SJl+zfHKIlXghT+sqIC8pNRAUY+/X5y22/uMTTGF2qtu/xbk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;7:VPeor5YMRKZxJPreJyQ9YhNAP6y8VPtchx2Xrav8Xy9OoL1T6MvtlHwBroxyjmrXncvLr9uGcjA+zS3PdQGulrAuUuWRg/VU62sfzHd8exwgaU9Ug7NUiPfdig2bvOG+VSL+CYZXZQvLw/tWo1URGM6MhvlrsTHztPTVcGozonGY1HJPFA1RV9/3THJh1pWVW3rjyE4MNt7QgELGSKMkUcMB62akKSx0t//4kXfL6QrNL5nZi2Fs1cGeKNO0fkYB;20:8IPFnJi27HWLB7S4/N48V+8HeWu/qnJRFfBvqD4gMjT3e/i660aiNSPmHrOkGvPX+6vU1LdKv1GHYDKP4v4cZAbzHGWa9Zv7SxjxnxTzG6zx1+ioAe5WYZ/1xEqlOYjCguHNU8psgDT5mFK289ccRsmPJweVx167sppeqHAJVCFEm+dvgEqdu8AmCHd6rmjDsiVEyNs+0xbBWG/EX/MNWf08nSV3uszX+L+MeU12B3sbFHcClzXmaxnieyeAVsy/
X-MS-Office365-Filtering-Correlation-Id: 195cd2c0-91eb-4ee1-0592-08d59f8fe804
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 09:37:54.4354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195cd2c0-91eb-4ee1-0592-08d59f8fe804
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.04.2018 um 06:00 schrieb Gabriel C:
> 2018-04-09 11:42 GMT+02:00 Christian König <ckoenig.leichtzumerken@gmail.com>:
>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>> Hi Christian,
>>>
>>> Thanks for the info. FYI, I've also opened a Firefox bug for that at:
>>> https://bugzilla.mozilla.org/show_bug.cgi?id=1448778
>>> Feel free to comment since you have a better understanding of what's
>>> going on.
>>>
>>> One last question: right now I'm running 4.15.0 with the "offending"
>>> patch reverted. Is that safe to run or are there possible bad
>>> interactions with other changes.
>>
>> That should work without problems.
>>
>> But I just had another idea as well, if you want you could still test the
>> new code path which will be using in 4.17.
>>
> While Firefox may do some strange things is not about only Firefox.
>
> With your patches my EPYC box is unusable with  4.15++ kernels.
> The whole Desktop is acting weird.  This one is using
> an Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] GPU.
>
> Box is  2 * EPYC 7281 with 128 GB ECC RAM
>
> Also a 14C Xeon box with a HD7700 is broken same way.

The hardware is irrelevant for this. We need to know what software stack 
you use on top of it.

E.g. desktop environment/Mesa and DDX version etc...

>
> Everything breaks in X .. scrolling , moving windows , flickering etc.
>
>
> reverting f4c809914a7c3e4a59cf543da6c2a15d0f75ee38 and
> 648bc3574716400acc06f99915815f80d9563783
> from an 4.15 kernel makes things work again.
>
>
>> Backporting all the detection logic is to invasive, but you could just go
>> into drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c and forcefull use the other
>> code path.
>>
>> Just look out for "#ifdef CONFIG_SWIOTLB" checks and disable those.
>>
> Well you really can't be serious about these suggestions ? Are you ?
>
> Telling peoples to #if 0 random code is not a solution.

That is for testing and not a permanent solution.

> You broke existsing working userland with your patches and at least
> please fix that for 4.16.
>
> I can help testing code for 4.17/++ if you wish but that is *different* storry.

Please test Alex's amd-staging-drm-next branch from 
git://people.freedesktop.org/~agd5f/linux.

Regards,
Christian.

>
> Regards,
>
> Gabriel C
