Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755062AbeEaMnZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:43:25 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:11520
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754801AbeEaMnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:43:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCHv2 0/2] Add new SEV commands
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Gary R Hook <gary.hook@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
 <20180530162819.4xbwb3jbbx5dey24@gondor.apana.org.au>
 <79caff3c-1002-9fea-1ab6-954062435633@amd.com>
 <20180531064534.ldi2ysuhh2omex5d@gondor.apana.org.au>
From: Gary R Hook <ghook@amd.com>
Message-ID: <8210dfee-3370-743a-6e9e-96df0ceadf11@amd.com>
Date: Thu, 31 May 2018 07:43:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531064534.ldi2ysuhh2omex5d@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [47.220.174.129]
X-ClientProxiedBy: BN6PR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:404:f7::15) To CY4PR12MB1446.namprd12.prod.outlook.com
 (2603:10b6:910:f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1446;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;3:/VlKoQtDm0SUR/adtRqIHrhR+Tma49zv2heyK600NxN5/j8iTKvraJ2dj0LazfDptK+8G9cK2+GaVxwPwngk2MjhgA0x1DllVySCFHiE55MqpR+g+2mQ00GsKTM+9OGNTvYJvfDNUwWpE/77OzgHDdRsA/AFh3eQF14xRJ8mCYlV7xkrDjkt1fml2ufd6LMfs+l7uAze0ZQkgv7zcfeBTTym1Ngy2V3iyBl71HYLiVs9/pqf6bgftxT6knmjXogn;25:6drvLkMvjl8VgWhB9UjFT4h2T+QO97rDlFZ7+IdEoGEo3/+tJv147y9X8I83LLSCUkQp7DulEwXKla+q2bRFLF3whCLM5TjWSwZ67FIEXuxJNewcSnRhdRIiGvIIAOyAan5RuN0Z5PnrrVBrtjd21dfW0DMwAvCk8Jc5RzR/Dmo5jWXObK3tYwKPFO1tbFqKXyeNy14wLp2/DKr+SFMAgHtYmKUdSq2ZAWpejiWsHgN3FZnYeivms8DKhSa1Bo0ol9yQY/4PM04G9K4LRZ93ixBp2wIaO6tmVFvQlzhZ9G9ohJLbMbieERgTpakWiMr3BshV2sweTekBd79DCIVtfA==;31:OI62YgAM4OTrvwJCeHT6ui+Jn26C3ZDRfnVhHGTv6WxMSf8Y0evmpBZHHkR/4orTMe0pAe8ugBp05BU+JNAnrmpFyMnSNLZuRO2xXB1CVooBzCluMFbAiKH3yn8Jq10ZzBT/12KObXc3DLrGAIKAafiBPMKvOF3r0/TwuLZd7mKOvAmpfcUwGex1w+clfIJJX6c9tPi8SgS39VMUN5jnD/bLWSLbOWFurDQa8ZlIZAY=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1446:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;20:MnMTrs8SPjt9WhQI8IbWp0NHqKrNVnnRgZUgcRdnVjQ+LBgo0UI/FtHcjj1NZbXK61ESDpGG68+nS06OZiAhNyQAm1jZOrPL+c7V/HD8C+DK2Cgq4jnCKaZBpf/05qDEZEBpvT9MZHybYf3TXw2YbbA+FR0kVs+N0drRZaH1LI9Tt9rhntxggMFTUMPowlFWBAyLCTS9+65eSajn0CehsyVaEefZB57pQfgE1E8JMyw387Xa4+FszcnADCEYLCflQ4LiLbsQXHiwSsdPKPiJhASlXjUM8k1LJEPHSMz1NMQI/pPY+n3Irz/HySxCnE0Hi0Lm4NwpVHDS7R6WtqwynbWUDxZzCsqpfJ4lgIZu9uMAVLLxu0SxT2q5eV3LfwCxHjkvQezVMSkru7vs+Ilnu8Pg/q9wUV5rAcz+xnYdyQar/9767Y6/ZgnjG4b4CERDFyNjSVWlgWoz6K6IhmXxovX6RdLUy0s+Qs5dCVdJec/ecMt2OaMONYlzljBoCWRn;4:jnqh0p1VyuLDK4Zj+tIpb/jHetHURJJY5zerxfYNc+iSeCEjOvS2gZ6GKrF4h0vtqFUY0AeJwzRhkTqNyJvK3CuLJJMJmV1fheYaSMfzhAatUP4Qp1pP5O7QkxiuvXudcW4wHiDdtOYVIk0ZYxWZt7tpTbsU+KzasL5VLHYv1mrYXSxbRNDZjgW+MS/1KPIQMu8XN3ftW/NqKGrOOD/KZpQBN0aIil6ifrneLwafsbFhNR30lAIUOIuHWtZTWc9ZH5+whrRJtUdJh6oK+3uG3g==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1446AFEEF03805264C7EA5B5FD630@CY4PR12MB1446.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1446;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1446;
X-Forefront-PRVS: 06891E23FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6116002)(65956001)(53936002)(67846002)(6246003)(8676002)(97736004)(65826007)(6636002)(5660300001)(229853002)(6666003)(68736007)(81166006)(6486002)(81156014)(31686004)(8936002)(486006)(956004)(476003)(11346002)(446003)(2616005)(386003)(28096004)(76176011)(72206003)(49976009)(478600001)(36756003)(230700001)(16576012)(7736002)(2486003)(52146003)(93886005)(52116002)(23676004)(106356001)(25786009)(105586002)(58126008)(110136005)(316002)(54906003)(16526019)(4326008)(305945005)(2906002)(186003)(53546011)(66066001)(47776003)(65806001)(64126003)(31696002)(3846002)(26005)(50466002)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1446;H:[4.3.2.106];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ2OzIzOkRNcE5DSzl0R3k0SG9YbG1Ka1Q5MGdVTWV0?=
 =?utf-8?B?VXh4aWgzckZXc1d3VG5Ndmx5MWUwSFVVaU13VE9WZGQ0L0pBd1FWSnJzVERE?=
 =?utf-8?B?MDEzbWpwWkl6UitCU1UvRmhYcTBuNzFGMVJzVHVBZE93ZStCdDA2YlNvZUE2?=
 =?utf-8?B?dUtQem1nZ3ZFejJ5cjlUclhScTRmRnBhdzlkNlZQbGt0S1NyODkyeU8rU2lC?=
 =?utf-8?B?VkNjMG9wVGo3cXZOeUxXbzI3ZnJ4RFFWbkxEdWRFNUlhZ09sQ2FRZkFYTkZo?=
 =?utf-8?B?LzRSM1pXZHhPd0xiUHRFanFoY3d5YnZkSU1Vb1NGdWxrdzlIWlhUT01hSzZQ?=
 =?utf-8?B?bnJaL1RLTDJQbThQeS91NjhNbTNqZVFZZnc2dEdLUnJaRXo5c3F4R3pDTlhZ?=
 =?utf-8?B?Q1hCdGRWL1kvMm9QUG5lTGFpaWQxNmJXMlZIcjlSV1ZBWnExL244bWMzNHFB?=
 =?utf-8?B?V1ByOG1yUzJOUk54ZVN1RGxFbWFSamMwdUZtTnJPY1pMYlk0V0hMaDEvOGpj?=
 =?utf-8?B?VVJRMzlDZlB1aFlaN0RKLzVNWGlBd244NGIyVmg5TWx4ZUlURExVVFU4cDBn?=
 =?utf-8?B?aG1zSzhta3V3SHAvL3pJNnFmN0I5VmJteE5uWHN3TTNJREVZcFJudGY4c2tV?=
 =?utf-8?B?TDBUaTVPUWtnL0JNSFg2SWpnckkwSnNEK3FzNngyVUE5dTZsNmNHcmx4RWpD?=
 =?utf-8?B?akhybDNLMnM1MHpNc1FnTTl4czluSmVCeEQ4TGZ0Y25XN2dNamNaTnNlcno4?=
 =?utf-8?B?Z25LdzY1Y3FmWW5Fb1FyU2laQVpCNTdtZi8zUTIrOVBwV0Y5U2x0MHVIVGhX?=
 =?utf-8?B?V3p4MUlYVlN5Ym9wWkxLL1lHaFhzb3I1TmlmRXdHa2hDRFlZekx5YVYvclBJ?=
 =?utf-8?B?MkpOQTdnVkptRVdnZUkzc0ZsakNsOFRYUTR3aUdFSUV4aEpSQ3k1R3FaU2lo?=
 =?utf-8?B?NFNoUUFVNzI1UDVEMW1YZ1BZOTY4TXRBcElRdytXcnFRQzVaQVJGNXdXVzJh?=
 =?utf-8?B?OERzOVdxeDg3QjM2WGFCYmk4SktydFdFVmtvQzJ2R0h6SmdYdVRrM204ZXY0?=
 =?utf-8?B?ekFzL1dVMDJVcTlISGFqY3FtYnhMT0h0QkRONzNJNTBsV2xwWXlPRmpQOGw1?=
 =?utf-8?B?WGlaSXc1R3VDR0xpWFZTR054MzNOQ2ZaTlRXU2gwQnk4RTNzdjVxRVRRbWxO?=
 =?utf-8?B?bGxwQzh4a0pUSXc2aFVCRnFaMkJmYUxhNWU2ZlZSbFI5MUZEVEJhQUUxK0NT?=
 =?utf-8?B?d1VvbEFreXhDY21VRDJHMEw1RVhSR3dvRXpBSUsvdnhycVVEOHpQSUNWaEdM?=
 =?utf-8?B?dlFxS3doOUJoT0k4bmFxbFBQajh1U0dPaGxzR0VTMS9UaFVWZWVGNk02ZGxM?=
 =?utf-8?B?OXhUUGZleFhwampRaW83YnRFanZuMTNKQldXcEsray8wY1lLV2lRYWdyaUlI?=
 =?utf-8?B?dEZIODF6UWwvYXVEUVFzdEw4Nkt0ZWVDckdaV3lzcXNWZjZKWjRDSHNXTElW?=
 =?utf-8?B?L2cvbCtCcUVPbFArd1hERlFkV1kwSkp6OHlTRnNLaUVjTUpkRzY4aGM5dnZV?=
 =?utf-8?B?aW1NZ1QwK2N3NEV2OUJjNXJ6V1Z4dVU4Zm5XNThUMmZwb1JPVzg0VmdrMEQ0?=
 =?utf-8?B?MTI5aFNyTzQrbjErdmxraldQck9LSnRVUWR3RVZMcTN1RHk4WFlYcWdQWU9o?=
 =?utf-8?B?WE1QM3l1NG5CZ1B4cU9WeVZjSzJ6TFZFbzExcGhxTFNiS2tHSU1pTjdNM01O?=
 =?utf-8?B?ZTBENktDV0MxVUhBQ1U3ek1PSzJaVGZKS1JvVjFIYTJpN2kxd01yVmdaWHla?=
 =?utf-8?B?WEZWYUFSTEp3UWZZMkJTSjlVcGZadGY0SjVLcHVCSkRDVVVDeHJKdWMzUjhQ?=
 =?utf-8?B?M01vNU16UVl2UlJKNk8vMnFtbm5qb1g1RThnSnpTVE9iSjRFZktNdVc2QmRk?=
 =?utf-8?B?Sk1md25PSVV1V3NRb1BVQlNwaGxLVXpQTEI4VndWMkJQWEk5bG9BQkdJb2x4?=
 =?utf-8?B?ekxieTVsSkhEMFhXYmF5MUxydFJLVWJKSVlISXJpVjZNU21PdElUMkJLelBH?=
 =?utf-8?B?blZCS1VaWWo5YjZzWVFHVmhLbkhKTkRyU3NKZGlUc1B1endpelVKdkFLcGtF?=
 =?utf-8?B?L2c9PQ==?=
X-Microsoft-Antispam-Message-Info: f4kGtsnF/KWTWSrTKeTQoc20v1U2VmZXkh0kWmrxOAnTQh+1AIHcNp28+daQMhi4eD/RV7TV0ZzTxsAOVdSu4qI6LL/cJCYcrCQE76yZV+u+T9ibdr4K7SLwfWHSpYOA++GAjoY11ZxtLZLr64j3zR9pKS1Zwgy2xPtImG3YEtimD3lcddeV9pVuDND93SdA
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;6:2ozHZKBeysAa3btemQLOzw7V/OiNjitVkpPRk23+pykodqzZIXp9rmuUgQ+lw8XvYNZL07Yi5IQVjXe8E2I13nzZOrGllYApsliJPZaxJIF2wxe5v9OdxOgvWGubar3gm/j608ZoENekCK8YdcTgeQOzp2oIBYKjkJmfhDgIhOp/DyCKWI6jp6qv7MC+W/cBBzR+DMNWVQ1BWZuzQ9USo6Uif6IcbrVzee9c00XJ+9j8u47+ck08rLh/UMOTEhAQ3M55Z/lGS8Iy2xRcOalbm4n4iEo5RZIDzhdomTl627Nu4yFozRUAIUn40Xto31/0uYTDBW6p8DgqlrzLjocr+iWhjRuM52TtfixFxDBroifbPGa77THiTuyPWllTCIbwliEZLxhjn+8pDw4pGLgDEDYL7XfjIpKjBGMxBA9ZXQGHEV1ckJAu4o0VbHS3GIaxW0DmaexqiR7KvuYWBTP7mw==;5:88rCuYJPbSjNFrQf7001s6CH/orT0hmRWWwfjfpPh/WSIFRnOOUH1Gyq8x+U8UBZpXLQAbiBOwAOMymhmgtcfBG7uo4c1KolUumnfkFHw9fuxzzAMgRBT/qXku5zqiGmYkpWDA1eAF+bL1xriksjGC66535+zyLEgWA7780ligU=;24:8+v90TCHju6qphqVnWoF4uwJjgUnxcl8Us2P82x5HRs5WInIKnModdh5dtWneHEM1qOZbT7i1tiJl0T5nb65j9DZcDta8FjmJAmkLXKWNRs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;7:GR2j6Dtr4ddWzlKrbNcQHX2m5Tsvb7X1FdwrQZpjkMlk6prKBXGzXXjn5+kUdO/IFFTCHCTaDrWgULyx9fh8L93Z4V4jK9FjYoqZjKxu3X74asv6tZleIDfHIuyx7WWoKHO9ka4wVlPEPjyOSiysBhd1huRE2Xq3vG5n15VpxqiSMWkxisFCJY1oJfGDsyGCRZCRzQlRglrV2tha5kPOVUeuh+jozZhtiP9H9kbvxmebB0wujBkAGAdTTH6Ej4WB;20:Ak4w0mXxOKsMd15y9pg5Q074+MlXEjyj/kP82d4Gk7OegIk3gH1InGAX0pP+mAbyzd8PP//bmhSyz8r8NutkcoS8+9OOXAjklyoLWAdl2qjVArF2W5K9U3v3nzVn/PXjOcN3Souh0L+YM71tmP3Rg2ggC1ibIms/XagGe8MWy1YfSmTzs54QDSST1ZRAyOYyi2/WZdmEGz2rmFFCAAOCBiZxr5RxgNpRkCjRVAscS4ES+4Mo164Oti/UPMVjR0vE
X-MS-Office365-Filtering-Correlation-Id: 5119fc21-fabd-4742-f1db-08d5c6f415e4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2018 12:43:17.2719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5119fc21-fabd-4742-f1db-08d5c6f415e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1446
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 01:45 AM, Herbert Xu wrote:
> On Wed, May 30, 2018 at 01:44:12PM -0500, Gary R Hook wrote:
>> On 05/30/2018 11:28 AM, Herbert Xu wrote:
>>> On Fri, May 25, 2018 at 03:23:28PM -0500, Janakarajan Natarajan wrote:
>>>> This patchset adds two new SEV commands, introduced in SEV API v0.15
>>>> and v0.16 respectively.
>>>>
>>>> * DOWNLOAD_FIRMWARE allows the SEV firmware to be updated if a blob newer
>>>>     than or similar to the exisiting build is available.
>>>>
>>>> * GET_ID allows to query for a unique ID that can be used to retrieve the
>>>>     Chip Endorsment Key (CEK) public key signed by the AMD SEV Signing Key
>>>>     (ASK).
>>>>
>>>> v1->v2:
>>>> * Added cover letter.
>>>> * Misc changes based on Boris' feedback.
>>>>
>>>> Janakarajan Natarajan (2):
>>>>     crypto: ccp: Add DOWNLOAD_FIRMWARE SEV command
>>>>     crypto: ccp: Add GET_ID SEV command
>>>>
>>>>    drivers/crypto/ccp/psp-dev.c | 143 ++++++++++++++++++++++++++++++++++++++++---
>>>>    drivers/crypto/ccp/psp-dev.h |   4 ++
>>>>    include/linux/psp-sev.h      |  23 +++++++
>>>>    include/uapi/linux/psp-sev.h |  12 ++++
>>>>    4 files changed, 172 insertions(+), 10 deletions(-)
>>>
>>> All applied.  Thanks.
>>
>> Huh. Without a Reviewed-by or an Acked-by?
> 
> These patches have been out there for weeks.  If you were going
> to object you should have done so by now.

Oh, yes, agreed. This was a question about protocol, not the patches 
themselves. But if you're happy, I'm happy.

Thanks.
