Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dgVlZAVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B0D96087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeFFOop (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:44:45 -0400
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com ([104.47.38.59]:22259
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752047AbeFFOom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:44:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>,
        Gabriel C <nix.or.die@gmail.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
Date: Wed, 6 Jun 2018 16:44:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM0PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:208:15::26) To DM5PR12MB1724.namprd12.prod.outlook.com
 (2603:10b6:3:10f::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1724;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;3:lp0L7M89/fzImcXVs2Q6QS6omPbDdpQDe/TnfMAx9jM8MfD9u/OKsKcIu5z4Q6w3b3s57fsO11oOnzUXDpdBZTC1U/e5LZ2nnyaHbjpl/ihfPVeZVhjBSnQ3tdbX3UrYhfTGUU+YV1dUX91ljJxxN7lzFhvXY37yU0q4MOw2tWlVzWBCCzCD2AHzfx5SlNVYtjno0MkzX1kQV9Ag6Pp+oQmQF5V0OtUdlikpjSlc1I1hfOC3pyy4bIxcvldBsfrO;25:GAx2hUc72Gge5lKfMBPx7927fnJGfgaM8aEC8YLUTCw5MBo301EQhZpe5cd13wKAANvEJP95zDo15T3Ju3zMvIJ+pHVqnnPmShG03PT5n4ln9frgGKd6AjJp5zCToRWzuWd36EE1XYUkPV2ePEk92ZJC8FRBQPzVATlorwKDS+gUeWX8H4bMmGaKuoGBkpWDrjRtJnVaVxeevtPGRUY539SJSM02zV+kRLzJabrSK5JUQA9mAP9Fc8JiQKv5+isP+f8in7GSLoBYsBjOQsJ/+ObZjQu7zDP/h6//o7ptBVk7EeFwEKKQRlHOvd9eTjaskijx8jCxzObsWil/maQjaQ==;31:/tIqTaLeNfZcgisQ5MKVdt9yt4iU35VJgy9rvRbJ8K3cSuPM7gFQdHGZ5b4j7HC6V4xbXmrsznkhsuNDbR00RQb9gx+1/iEd75CLrpOBjoEMD4zRLIoBflnl2+OsXPBXvX7KpRfMPlRgylGVTAScvDHZBZWHtbxNQvSUAoX/bzKSgYbsRCHKEQ8cuHRsNYxjRtrNKvfxXAw6+vU/6jI4gtObguAS59zUZJiaQmsRHQ8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;20:HmTCSN1sIZNKjZwd4SaeqwIzxK2ngBDSwuYlp+CeTnAtoiNeeOJm0Vjq+gJVq01p32rFxF3z++0kJkMnvBVvI5WsIK66juZc06+q0qvdE8/hav9VRUK1HwxNl1EJvegiT2s9lLougovmnnmUBeR4V7GtN6oJAzJsg5R4bO3BKFzutbg4Ypl2G1hc6Okipeggcgl+uU6a2jOuMXlyzvQ8A5C527sRG5TeKxjsCdn9CrHGiUwf4JvNYt9XeC7/V+gQZS9w2uKEF5vSEjdepke5dSwH4HuKyK+wKcFwej0zz/ePxPnD3Q+O436fjcHDMQwLDLiWSQMT6TXvTqTIBTIcnZbhsulcvgqbCB9Msgo4pOXvrgq1S33y+NUxvDJwlL9LskYv5Yf3zztMPTGF2TvLngtBeqM4C2YgTeSG6IkN+Ex4HinGvQaY+Kb0BvvTut77pTxVBmuy4sxg0qW7Tq7plwxcUKt9YKsrtzZXVYGW4Gi5aVaYXGmFQN1MK69dxMND;4:onuxbmzGdWFzQ0ym90aioWDuTeGfEudFtZpy9Jr7MrdNrRjeImP6AmeOa15N7ObwmrtiGDg/y7+E+x3kROt7EVQkuE8nifKMWEFL3eDJ6fphsZSVdwuXZCF/yKegEXTtOB1RwDzHguvVPkqeVBLVWWMpHKvaTh8zJgdiEK6nZI//LVaj9iR1+mCaYkZcm/UJYxQ16Sn/woh1xjCo3d+PfZESV0Av+7anGvbyv+TFghkof/9Rl0zvjBTubx9GAP5wQlU0QiT6TR3zsJ/JgxgXe5vAQjSfbky0UpW2iKJ+QzTWYxmXSVi+EHUljlPgI2ZyzD9jIue2hFIm7Xr+UEH+9aVlS8HM24QvG8M2qJajniPporyEJNud4rYTxXMpWchA
X-Microsoft-Antispam-PRVS: <DM5PR12MB1724E6DD09712E301490B0F883650@DM5PR12MB1724.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(85827821059158)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1724;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1724;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(39380400002)(396003)(189003)(199004)(229853002)(8676002)(2870700001)(305945005)(2616005)(476003)(2906002)(8936002)(6246003)(46003)(36756003)(31686004)(52146003)(106356001)(81166006)(39060400002)(316002)(2486003)(23676004)(16526019)(4326008)(64126003)(186003)(11346002)(67846002)(68736007)(52396003)(81156014)(7736002)(1706002)(105586002)(6486002)(6666003)(52116002)(54906003)(110136005)(446003)(6116002)(6306002)(72206003)(486006)(58126008)(76176011)(478600001)(65806001)(65956001)(97736004)(47776003)(86362001)(50466002)(31696002)(5660300001)(386003)(25786009)(53936002)(65826007)(53546011)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1724;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzI0OzIzOjhreENmWm5HRkg5MmVVNTd4WW91cjJsYnpL?=
 =?utf-8?B?Y3J5TzU2dGtQSHI1ODEyMm03MXptNDg4RXUzUFJmTHBaWWFPSjRjSkRPS3J3?=
 =?utf-8?B?bTJ6Z1FkcWFPQyt3Z3RsWjBYN0szTlM1Y2lyU3BnV2hWaHNNWDlRak9Mb1lP?=
 =?utf-8?B?R2ovaVk5VkFnZ2ZKS3hKWk4yaTEyTlN3Vng5YzRtbHQ5dlg2ei9LU0RZV0x4?=
 =?utf-8?B?KzRWLzVkdTBNS0d3MEZkOVF1VmRoRy83RjY4S2V1alM1Q2RNMWFESnVzMk5Z?=
 =?utf-8?B?QjJwRUxuMzNqSEpyeUMyQkJtUEZ0UDduZXNjaDJqSXRsZmdRY2ZudTQrVGZR?=
 =?utf-8?B?OWZneGI3SkxIWWZXamthSmxXQmkvN3BVYVZ3Si94ZVVWM1REczRvVzRPTXpU?=
 =?utf-8?B?eWkwemg0QmtoQmY5S1EwT0w5RElzdGdnZTN0eHBWdXlMVU5nbGFHdDZkZXA0?=
 =?utf-8?B?RFJBZHhhUGphY2t5MFpIUDk3dHErK0RVNmJ6N2VUMWpNVjY3MXFHWXRSdzRi?=
 =?utf-8?B?T1ZMZFkzbWFwNjUyV0V2Z05obUdlZm81M3dEcVlaU1ZQNHFNcHRRZ3RtM1dE?=
 =?utf-8?B?YVJCdzBreFNOTDBhYnAreUFPMzZ4Z1k1VjdHTVRTT3NhbC95aG9pSDdldEh6?=
 =?utf-8?B?NFIyd3NndysvaFY5aHQ3ODBVWDhEaW5yK0pYa3M3Ny9yU1crQXAySkNLR3A3?=
 =?utf-8?B?TEhMckIxQTBDSHR2V0k3S0RZYmJvY2FUL1FBUHB4QXlDOSs0QTF4TWhvWE5y?=
 =?utf-8?B?OUV1NnVyTzBpQzdYblBaRk54d1FmRlNmN0Z3SDZydjFEa3lWM0l4MGJrYzlp?=
 =?utf-8?B?MThKcnczUnRPWE9kQlRMSloycjhlT2JsbitsVkp2a29WdGpmSnVFYTNWc2l2?=
 =?utf-8?B?V09tYVBoYmYrSnNUN2Y2T1BudVVpM0NEMlVHR2d6b2JwM1ozSE1Xc04zTjND?=
 =?utf-8?B?THVrUUEvblNvK2c1dVoyaExBVHhjNnZxNVY5d29rbEIzU2Y2R3R0ei9oaTNu?=
 =?utf-8?B?WXJoL2ZWcDdtKzZwYVFiN3FBam9jR0pSSTM2NklLMGIrdHhURXVOc2tLMmdI?=
 =?utf-8?B?M25iZnVYcmZ4Mm5QdDE2NmpsVTJqL1hKMklVU2ZwdldDOXEwVkJEUkRjZnpw?=
 =?utf-8?B?SXpMdnRnaDRoenRrelVIRVFoSmMvUWw5Z044czgyL0U4VGxoSDFLaHZNQlFM?=
 =?utf-8?B?R0xYVXo3a2tZR3gxT0hMSnRvZGgrMi9Wdkw4eG5vcHlrRTkwTkJiL25NVmNk?=
 =?utf-8?B?RmFkV2Q5WTZUQ1dkN2VyY1l1RVFIT2VibEp1ZGp3ZEhHQWZzTTRtQmJqaGFC?=
 =?utf-8?B?dXVWYloyem9ENll1SVRqRTZlK0JOZUNhRlBZS1loWm41U1RTZDBYRXlvM1Vz?=
 =?utf-8?B?YmVaL3dnU2VhQjlrTGMwQThLWE45QmpNZVVLdm1iWVZMT1k0THJPVmtlR3ZS?=
 =?utf-8?B?aVBKZ1pqcUd6alBoNElFdHZjTHN5c0I2aXBrTGtZVlBGNjk4Y0dEUEJzM2VD?=
 =?utf-8?B?RUpBekVORlR4dUhYeWVoQTVxU2VrbGlMWlpCTzh0VU1aUWVQODNHcHZHZDV5?=
 =?utf-8?B?M1NlcWVROGZ0d1B2QUxhV2F4VHRvR3VsM3FMTWlvZ3lNRitzMnZqWnM5RVN0?=
 =?utf-8?B?amZxY3pDMVZBSC9Vc3NHbk5jUG9NMm1DUEVKWWRsdlFEOUg5eWZTd1Jlc05J?=
 =?utf-8?B?VVppM21vSVQ3cFdhY2NSUGFhTGVhWDFhMm1lZ0sxNm1uTnhFOTJjVEhHc3Iv?=
 =?utf-8?B?Rnd6TmxCR0FPQnFLR3VVQ2MvL1FlVWNMR09WaU54dHdNRkRSd3V3VHYvak9Z?=
 =?utf-8?B?MnFuS1dlbWJYU2s4S2JGUGhHanFnenI1a2FPMmFRRzYvRnRFbWRYeEttVkxh?=
 =?utf-8?B?Q2w2N1YraWpSakFzbFBVOVlwaUY3cUZ1Z1pvMjZwMWp2b1k3K2JyQkdBd2xH?=
 =?utf-8?B?dGVBUDlTM2UvZTBuYXkzVUt1cGRHM1FVMnN3cUlVdzlobEt4MEhLS3A5bEg0?=
 =?utf-8?Q?kMEJnc?=
X-Microsoft-Antispam-Message-Info: ls4qJACFptQouv5/jS286xWoThGnx35FcnYbAFln0vpxMQZZ9vOSS3ktMuIx5tF1mANW6QIoiIRAGRpTcxRrhNf6Nn9XqvZmyZcmnIrzVxUO6h1d7Ce8Gz/cN1obiO4UsentEyjsWibDcsZ3oOLoDIJvMWN3ug/CouIwlvaIyplyeJuTuAmyQ97GG1iMMFko
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;6:I2iIHHJAKGoRkT5QzpuG9LSqfztxJc/Bnzc6q2PMcuA+SPPslZpmXDMP2aEoDcXPXBJ0F1ZxER/qH/UV6MZFJLPGGVnCbQurmD/rq1cy/l6UJoVcdZhcIy8bsG+zr+DcoL78OlWBCg4H3WwIgBsypDWY1iJk55pcsdSezXobkzwnVWETlQHeR2Up/qxcR6zku2rpkYeScuaGx/IuTISDMRCVnZUiDm7tsSFXBQmDLJCJRBHuZnOU2x20Dt3ZCyP9YA4iY3j9Ga7ej0vInrIqdHGrD/3rMw7FBjd6Xool3k1tmSEcp9vRtYyzwZ8bUbJh186kNtIwfPx03VW1Ul6FtByRm2VPvhphUBBTyvwkr/uVLw/c4wY9a8ktyKAKhz8/QK0W6N2v7Yw3+9ipm4VOpsTKmYvKkJZmVMFEpkwXY7p79KKgWWzC65A3+Xau2CgPrXnr6Olervdpt73LhLbsIQ==;5:9RB8eZCahgPd0B8qa+5OEu6UUMNGxAK/Z4T8hriwSumNy/fFUyn0tOzDZVOYYFqwuLdHqQ5CmVACiXfLCyTxxqEx1n5RI+EY5z1dXoL+xHmGI2jYXk4d8kRps+qbpUXNxytLlODF2RIqAC22vis2QgIE7eEXhe17M601GAzcT5A=;24:yqrZVskm6eeMoL/FpyVRJy68TgQOxiXfmm0M6ycB24lwx9t+OGTOJ/sELCrWDgEmI7ksv2nnyXiw+8BETFKIq3lIhQoKGQ0JbR5GPa5dEZ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;7:VQtZPK870VHK0u+rmSH6F40hWo4jRecazc2qvVKwjdxncPXpjBM68A/Im4SE1/Ct/5V1mGEUtqqGL0mwyfG98T4zryL2lIE6tlxBEDFN/FUc2rFobazQPzKvOmQ5BxdyZleLmcH3Mbzbk9rsr6v1KIyOle7Xb2h3i/qG1swiJqIs+wNm55d1kg1XX6/0crJ0cGoSAxeRq9W5gzNvxp18Zq+DjKWd5D4B/otm+6QfH7PNJU4eDPfs+C2V9aNWZUM+;20:venSC//xGwx+0szQFF3X+wGVbkEaLaYH6GS+ROGp1CVxF74u+5RmHBvlYCsHUHW5RSkRgxIXwGA35tTvYk8BLiO/Crhuhg5zrIPHGjxH6F28B3ShfZNB0l/PzZdB9DXtruU4B3gDd4G2qcENAkXYEF4vSl/wa5WZokua0IQO+7QoAveCVL/QQ9Dtci93DXKCjJNqGx0fONpw3Rhe49a9W6ZiIWDpB+6fPZHzLBD8bRFvU+vLdG9macmSVq7zqUQn
X-MS-Office365-Filtering-Correlation-Id: 5c077c82-f8e4-4870-34ca-08d5cbbc08f0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 14:44:38.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c077c82-f8e4-4870-34ca-08d5cbbc08f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.06.2018 um 16:12 schrieb Michel Dänzer:
> On 2018-06-06 03:33 PM, Gabriel C wrote:
>> 2018-06-06 14:19 GMT+02:00 Christian König <christian.koenig@amd.com>:
>>> Am 06.06.2018 um 14:08 schrieb Gabriel C:
>>>> 2018-06-06 13:33 GMT+02:00 Christian König <christian.koenig@amd.com>:
>>>>> Am 06.06.2018 um 13:28 schrieb Gabriel C:
>>>>>> 2018-04-11 7:02 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>>>>>
>>>>>>> [    6.337838] [drm] PCIE GART of 2048M enabled (table at
>>>>>>> 0x00000000001D6000).
>>>>>>> [    6.338210] radeon 0000:21:00.0: (-12) create WB bo failed
>>>>>>> [    6.338214] radeon 0000:21:00.0: disabling GPU acceleration
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>> I have the same Issue now on final 4.17.
>
> Please file a bug report, and ideally bisect which commit(s) 
> introduced the issue(s).
>
>
>>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-off.txt 
>>>>
>>>>
>>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-on.txt 
>>>>
>>>>
>>>> Also nothing else changed in that setup just testing kernel 4.17.
>>>
>>>
>>> That has nothing TODO with the driver nor the original bug you 
>>> reported. The
>>> problem is that SME is active and that is currently not supported at 
>>> all
>>> with a that hardware.
>>
>> Ok .. so are we playing now kernel an AMD Hardware roulette on each 
>> release ?
>>
>> SME was like this in kernel 4.16.x here and all worked.
>
> If that is true, again please bisect which commit broke it.
>
> All the reports I've seen before this indicated that at least amdgpu 
> has never worked with SME (which BTW doesn't mean it's never going to 
> work or that we don't want to support it, just that as far as we know 
> it's currently not working).

At least in theory it should work when we use the coherent DMA allocator.

When that really worked before, so the most likely commit which broke 
this is:

commit fd5fd480dd8fe4910546e7b080b3ae345e57fe9f
Author: Chunming Zhou <david1.zhou@amd.com>
Date:   Fri Feb 9 10:44:09 2018 +0800

     drm/amdgpu: only enable swiotlb alloc when need v2

     get the max io mapping address of system memory to see if it is over
     our card accessing range.
     v2: move checking later

     Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
     Reviewed-by: Monk Liu <monk.liu@amd.com>
     Reviewed-by: Christian König <christian.koenig@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Currently looking into how we could somehow improve this detection.

Regards,
Christian.
