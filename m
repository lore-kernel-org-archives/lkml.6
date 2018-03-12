Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCLXLH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:11:07 -0400
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:53152
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751333AbeCLXLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:11:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re:
 linux-4.16-rc5/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1723]:
 (warning) Possible null pointer dereference: pipe_ctx
To: "Li, Roman" <Roman.Li@amd.com>, David Binderman <dcb314@hotmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
References: <HE1PR0802MB2331D43DAFA4EDDE964F0CC69CD30@HE1PR0802MB2331.eurprd08.prod.outlook.com>
 <8b55ac58-ae20-7662-10bb-c446701cd67e@amd.com>
 <DM5PR12MB1211B9CFBCC532003F5FEDAA89D30@DM5PR12MB1211.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <2bf3f20c-cbbd-525b-5bd4-61e6d2d8a677@amd.com>
Date: Mon, 12 Mar 2018 19:10:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB1211B9CFBCC532003F5FEDAA89D30@DM5PR12MB1211.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To CY4PR1201MB0117.namprd12.prod.outlook.com
 (2603:10b6:910:1c::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbae963e-c67d-42d1-9036-08d5886e863c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0117;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0117;3:FvH96x+Ic0frhU8JgmdcWRneFNoOXQ6W4vBOYAo+Sto47j3Mj3N/A3DxfSaddlKg4PiZ3Bz3MSpi6dTbbNNYZ5yA2mljADCu1j5WFEulbKmzwVynMrJuiST1YclJO9+3Y0+GyPUApXemKPE5dZ26xfz2ivsaf2EEnfuOBDH1ucC6LZLr1Y9IjywGLv07p/vRt97X98TSCwWgftC7cb14lxaaweMzfeYnApNGIsmNd46k7KOfw7K/LtUpA3pTNfwz;25:AmcHtmZOqleaK6qFjT5NqTREU4bJeUtAs5hnUIOg2THbIFa3uBvVsGZg9v5mgklcq9CbCaYPD/E1oidsjOmVfVyLpTnopJkqY63dfTnUL/826Ep2L6sV3craxDA5FpRqAZzqZgJiHZZ49p+kqpD4USfHislwPlAJbCnZxfCsNDnjw9dwSZoouYHgQtmlFA7QEh4JeKyxGL+GOjCd6DNmv4o+MMloV0fd9YO+dttbDBLivyzRnQsa6+BZHX8rp3UDXFZlDfBddRIR4J+cZJ5eUbmrmdwiEZxSY8bgDofJRCs8tG3LlMrDsBzShwoqUlhwzT25YDtV2LnLMC1cbWd2Jg==;31:IlPJe7DVzfvqWnvq+LMKSjk9SboAvfqmntmNJsuxkMJgvNJXwAsOmls79ot50iYpuiazVPTOPa8pRectwS0hRM7Z9a3Mulbnm3RMpOTWETexFxhj9sPYamIeIAFlQsNLsAYzos9g92AyPK3oPwCTHvpoYS4iC8/pSqSmQauA2tL1bAiJzWM0cYoetZr3zcP7bhO+ITV/H2RfW6bH/Ma9M9+4qMk/Km+eyCmAdeZmF3E=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0117:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0117;20:JvTfD1ow1/D/7rdr6xzeKVR9BmY1mgIbL5o+CCni0BOobq7Dhuze+9x6Ff50kqTYM728ru7UOStXZih83C/6l4O4J1Zd/LFQSQZFPtLPhuDnrcEclFi7c6vZ+XcA0pB8eECG/LXM0nA+L05NWXpoy27LqEDhVev2J/waDey042dsS50YRf4Jp2pSF1c+N6IMlcEa+qarqY7O87EoWachgT5Z+uHQwwrTjFpx1ARAsbDfVySt9OdiNs7QgUjtflGr85EZIR4knKLMd1SPAu4khPIZQpAsia1UOSrz8rJnYd2V7mgTye+wixxSeJMDP7mzL63pDzXCwMlVKrD0Y2vo5scmghd+sxA/mVBAAcvdT+/CACOFPvdrYP/sM0HNX+f5ISDG5hOZYfzWIhdEgsw5B4goWRSLil+OP9R9e1jqnds4pZaAKKg53HP4jB5doNRUmN/ctloc2ZE6Kc2+0bfyEyXGxphAjggPg3eYlqpKfCH2+x9NMmdC4wni77uvv5sY
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0117F0CDC00D00046F6B2610EAD30@CY4PR1201MB0117.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(217544274631240)(130873036417446)(194151415913766);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR1201MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0117;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0117;4:7xHm/rADDw6gZNq3pDefSzvf9AkUrUFkcbrwxDQkXNqsHp+V1rOQOlqRu9MsKlBMKXl2J01HD21aT5ynSOdy5LvM46pGr7aNleGmieQi5TViJMpR5lQhA7IXLp50gxzIHRWSU6Akw0B46Ss84IIxvNmhfgyzUhA9I0Mc2/L2e1M55zKHZN32UkpSUZsnTSVuqf2ItnbZTCLlT8FTbR2OoCd2qyjlWuWwxTFDctYy9QyLVvKJ8XMT7utApAzGm8I8P6IiSKvAUvgFAhPXjxQUVq4ssl0Wvk4ler8qAvxbE5cCNFukyFzPj4hDU6Aj3MrqJdi7+O0o/Zb13Uf8PaDhVFlgUT67MAJYo2UFahlm1R8JHXnR4f2YhFsJfOTRthuh4fcwLiDLFJ1ltlj4wW30NLasTPK53i2I8okJTMS88IuqZR67oGk0JYc07g8FQ8fF
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(39380400002)(396003)(346002)(376002)(13464003)(199004)(189003)(105586002)(53936002)(23676004)(16526019)(67846002)(7736002)(2501003)(25786009)(8936002)(305945005)(8676002)(47776003)(76176011)(65956001)(81156014)(66066001)(65806001)(52116002)(81166006)(2486003)(68736007)(6306002)(386003)(59450400001)(31686004)(52146003)(6486002)(26005)(53546011)(77096007)(50466002)(3846002)(6116002)(36756003)(15760500003)(6246003)(2201001)(2870700001)(229853002)(39060400002)(2906002)(31696002)(316002)(64126003)(97736004)(6666003)(16576012)(106356001)(478600001)(6636002)(72206003)(2950100002)(5660300001)(58126008)(86362001)(65826007)(110136005)(45080400002)(966005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0117;H:[172.27.230.118];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjAxMTc7MjM6K1A2Z3dMVVovdG9ZWG9rMXFDa0VzUVNX?=
 =?utf-8?B?ZGJlOStrT29ldEdEWVlubFcvcXkvNTNnYmlQZlZPV1c2WmZUUjFQaG4vZG1Q?=
 =?utf-8?B?WmtsODNDM2liQm4xK0w3cDU5SzlYK3hwckpPRnNNdGFSbWxTQ29tUjJIdVND?=
 =?utf-8?B?WGJuNVY2R29yZ1hzaUhwc0VZMlFNYWNvNTdZSnF1SWJNZEFwaTdSWHJZTlI2?=
 =?utf-8?B?V2NIZDM3T0xmQUcrOEsyTlE0dTNzTXI0eXJMODlPa1RlVTRsVldBOCtYamlr?=
 =?utf-8?B?cStjQXlyR0wzY2ppTzlZZU01Tno4VCt4a201RjBmZFV0TlF1MVZzdFQ5b2oy?=
 =?utf-8?B?a1kvWnRhYkk4eUNwdmg4R1hOQWJPNUFyZnVINXFUenBGT1U3M1RnTVNGRlRC?=
 =?utf-8?B?Q1pCemp1U1N5ZXdSa2ltK3JsUGhHMnZKeXhOa0tGUFBwZnIwS1hrWjVOUFZi?=
 =?utf-8?B?dTFUK1BsNzBwdHJjQWxrd3ZnSHIzdVpnaDF2UFc3VnZBajgxckhQcjlIRWIv?=
 =?utf-8?B?cmJtd05yaTg3Q0Z1cXFodEV6YWtWeG1tNUVhZVZybEkwVWJDYUM2QmpKZ3My?=
 =?utf-8?B?L1BKcUVyRGZ4ZHdjc05MaFFReHMrcnN0d1JuWDMrSmlBOHpZUk1qMzJ3TUpH?=
 =?utf-8?B?eEdQU0VOWDY5MjdJV1dIMzZndkdQdlZuM0szczk3ZkFKSjFtZVB5QndDWllM?=
 =?utf-8?B?VVNGbHNKQnVoZitXZ1ZZeFFCR3QwL0toVWc5YUFCcmRxZm9aRjlmNlNOM3BM?=
 =?utf-8?B?ZEQrZko4V1NYcENzUjk0cXUzS2IzWFRMK25CMy9FalpjUks2cnFaNkxWWS8v?=
 =?utf-8?B?RFJHdjhlQmJ5eC9KT1EwMDFZK1NxNDFpRk9TTXkyWDFsWmxWWFJjazMyUm9Q?=
 =?utf-8?B?NGpsR2crQmpqSEVrT0FqVjZSQVZ5NmgvbXl4TjNLZGpNYlAwaDQ5enExaHg4?=
 =?utf-8?B?TzY0NFNOM24wYThjcjNSYmhFS2tsZ0l5bEQvV0pNejhMNkVvQ2JMV21WMnBB?=
 =?utf-8?B?dzVLZk53VHo2Zm44YkQ4dmUxUlBla29UbXJCa0xtZ3FCdW9ERm1HOXQvM2J2?=
 =?utf-8?B?UjhJTlpXSlMrZm5GTEZITm1TbEJLRkhSZDVTdms1OWttS3NnYmxjaklvV2Vq?=
 =?utf-8?B?UytUeFNSVzlWSnFQMlNHOHg1Rk5LSnFZS3J5Qnc0SlBVemlmdEV4RU13STV1?=
 =?utf-8?B?VnFzdTZGNE02RVp2a2VXU0R1bHZNWHMvVitVamlxM1VWUGo4ZkZUMzFVMFA3?=
 =?utf-8?B?OEZaZGFRSThQZlh1NWFtTWtqcFhWc1VOZWc3VTRWZmlobmFzLzhLV2JtNXJ5?=
 =?utf-8?B?a2ZnY25YajhqbnlYQkRnWXV5QUpjemE2M0pWNm5iT3FqQ3RTMDJnaVBnSFZ5?=
 =?utf-8?B?clZzclBKRHRnNDZKYmZGNTBlNDd0bEFQaENhd0pDWG1sQ2VUOEpIeTlmWWNR?=
 =?utf-8?B?UWMzVHFLVm5CQWZMcGxkZzFVL1dRN0xKMU1rY2g4L3d5dGlPRDlTNzd4SFRF?=
 =?utf-8?B?eFVvSHFnbHkrRWVLZmxEZngweVIyY3JmdkEzSnd3dFd1OWN4REhOU1ZyWHIz?=
 =?utf-8?B?SE5YSnRtOWNFZ3hzY2JNUUwwSUZXN2s0S1hiUU5lOUw5SGlZVXpQMDdqK091?=
 =?utf-8?B?c0RXQ2VpbnNGRVFwQ0Q5UVlwSzREU2YzUVVrQVpVTnlpa2MrMmVXcWtPeU5y?=
 =?utf-8?B?bTBxdnd3RUNkN05VYy8xcjFnUUwrZzBzU1JnL1BaTHpMSkRmRkNYaUxXaEpp?=
 =?utf-8?B?N2VwWFpDU3c0MGQ0d2VmMVQyUlh0ZzhTTGU4UW1IU2c0b3BURTBLOUpZWkVt?=
 =?utf-8?B?OWNHbG1FbVVTVEFPVXBwNjFRNUt0bHdkR0xtUTZtYXNVRjZiYWJVdFc3L2Vy?=
 =?utf-8?B?S0FSZXJ6K1N6c3ErUFFHUHZibmUzZVpZaXN1L2kxSXlqelFydzhlQTBkY1hH?=
 =?utf-8?B?UzVJM3VITS8xVTBsazNCc291cHZac1ZBOTRXNTVvd2Z4MTcvZUwrcEl1MVBO?=
 =?utf-8?B?cEk1Wi95aVVzcDI5UklPY2UrcE9JRXkzZm8yaXorS1ZOdldwWVk2TzE5WHNp?=
 =?utf-8?B?TXFzZG1JTWFUeTdqcVFrTXZUS003L293dURnRU02b1NQMjRCdnRvdkRPT3BZ?=
 =?utf-8?Q?2xBbTD7TWIflE98yRoypMZWYBSr4tFEJDrHLoAtXvcK6s3?=
X-Microsoft-Antispam-Message-Info: uM9YAfrQ6S88LfHV4E27fH4Tt8nQJAqMbAwA+8diIjmdXFqvMBSpLERCtNwIoNqLoUR5sme1e65ju0NnCaj62qdY6ZwXT5LMYtWeXBCwNfvsPdPyGoAoZVL8M8u4+7UwHm4v44iGhkiv0nWdtuB2SUZaNtGIJ51BnOWUiryZgEbpWno5IYR7Dxo1cJO1bQK/
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0117;6:OJvJMBh6LH5hkk/kJ2wOoItkmELWHM6JLn25/2J8TPyh+jOJSzQtC/3djQmxiRbHuZ41F/2PFST+53Rmc2g1hhtKdKooUDYZY+UUXjhD5xyrjQ3zBqXOLoI75zKoxS2MT2LazRCyfSyfpZVa98ndtz0MjuMQEizE/4/g0EF40ljxhYTqnYAxNgNCt7p3J8RPjXE6HNIwWspekjbbyjUQw3Zs3KCAy6Otv3AHemIB9eRE7giHESgosrPQoYovE0Hm3oBEEvxSKbjwAHe6SpepXhW0co+pe1Wg8TOuCSpNQO/sXUorilQAaQVr27LdltZzLg61duq1HTrMll4wquhLiQ==;5:mW5a6xE/qF+ed2K5kjyaS5TryuZ8+grZL9qiIa21y4K5LqvKv3m9RV7HdzLChuTM/ewDBFuN+fiToYsDdlfkHJlVY6gA592DuRwRNuV/zKg+9dhG62ti7ISnbL4ClNbuipOVdIif7dqpLfRrQS77zKKu0Z67DraCz4kNThd6lxU=;24:UTlxILxkv0gu+5Qfw/uifIlYZ00ZPYZr4xtS67KAz/t4kI0ZQt1myA/4ViWFaiLm9PjICBoEb+JXCE1C5VN3I952REvO5w7hRQVID7AlPb0=;7:gUnNYUtb1jqRxkr1KJWuUY/YLfEagTSGVxK1wcKP0CplPh8SfxuNpfc1JQ0BQTM2yj60l9uKOc/ZxNZfemL5Cdx1bP2TmEuTvJvIVvCYPdv5Lgrlw3K1KusV42wHiNu9VSz9QpoEgMwG4ZEpFiyeTVfJlvU+HuHnmTnyimaTT6yfrQ70ydYx7VwjPMFi25tdxf9wT/sleuRjiV5tnanYpvV9gZaQ+eTzwZIF7yLGohmpJosBZ8QOWJ/wPw7I753b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0117;20:Ys3lEZPJ0xy9qwN1ipRZSXjgaWGFkMwL4C/2b8hvPXZO9AVOFKFZoDlEFOwcnUcq64nELRGbi/b4VqO2Iu3kUDdg9HRj2G5k93I1/5sbOUNLMhid+1NxH+Xy23KRPP1uElwkONzYfYyaPvEEoCYbnOjFaguFj1iQCpSLAhZLv8hgDWIywFbUveR5b0ZFuFcLulXnDtsZyvGYIx+raNZLWqNa2wDEBauvzP79IGJ4zxSeSjtY/ddcxpFXLJv4W55i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 23:11:01.5033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbae963e-c67d-42d1-9036-08d5886e863c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check before alone is not enough for a case where there is another 
bug introduced so that

context->stream_count is not in sync with actual number of streams 
across entire resource_context.

At least assert indeed should be there.

Andrey


On 03/12/2018 07:06 PM, Li, Roman wrote:
> There is a check just before for-loop that should ensure pipe_ctx is not null:
>
> 	/* Only supports single display */
> 	if (context->stream_count != 1)
> 		return false;
>
> To remove the subject warning - we can rather add  an assert:
> assert(pipe_ctx);
>
> Thanks,
> Roman
>
> -----Original Message-----
> From: Grodzovsky, Andrey
> Sent: Monday, March 12, 2018 6:23 PM
> To: David Binderman <dcb314@hotmail.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; airlied@linux.ie; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Wentland, Harry <Harry.Wentland@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: Re: linux-4.16-rc5/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1723]: (warning) Possible null pointer dereference: pipe_ctx
>
>
>
> On 03/12/2018 06:22 AM, David Binderman wrote:
>> hello there,
>>
>> Source code is
>>
>>
>>       for (i = 0; i < dc->res_pool->pipe_count; i++) {
>>           if (res_ctx->pipe_ctx[i].stream) {
>>               pipe_ctx = &res_ctx->pipe_ctx[i];
>>               *pipe_idx = i;
>>               break;
>>           }
>>       }
> Indeed something like
>
> if (!pipe_ctx)
>                 return false;
>
> seems the right thing here.
>
> Harry, Roman , your opinion ?
>
> Andrey
>
>>       /* Only supports eDP */
>>       if (pipe_ctx->stream->sink->link->connector_signal !=
>> SIGNAL_TYPE_EDP)
>>           return false;
>>
>> Suggest add some code to deal with the case that the for loop doesn't
>> find what it is looking for and so pipe_ctx is NULL.
>>
>> Regards
>>
>> David Binderman
>>       
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
