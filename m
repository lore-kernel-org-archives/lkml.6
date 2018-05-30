Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeE3Sob (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:44:31 -0400
Received: from mail-dm3nam03on0072.outbound.protection.outlook.com ([104.47.41.72]:60255
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753442AbeE3SoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:44:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCHv2 0/2] Add new SEV commands
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
 <20180530162819.4xbwb3jbbx5dey24@gondor.apana.org.au>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <79caff3c-1002-9fea-1ab6-954062435633@amd.com>
Date: Wed, 30 May 2018 13:44:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530162819.4xbwb3jbbx5dey24@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0036.namprd05.prod.outlook.com
 (2603:10b6:803:40::49) To BN6PR12MB1443.namprd12.prod.outlook.com
 (2603:10b6:405:10::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1443;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;3:cMV22JPYGO+cYx+ynpDLr2eFkqvNZVlu8QM9aNqWaAPJtIOwqYidnVIp2P38WH6U0MVXZMWy0HbAnOlzKB7nDmsG0iEQqhU2dHtN5iDDehYJBtc+K9cP7EY7hZjV8n1BZH7IrTP5NQU54pjePHonnGPzE7EKU3cWMbUCVe0KdTf6NORiPHbUADLIANQ24pDSHatUTZ/NEaVf2+llpsq7gxZnn8O739/2HZJP5GMLi1SqvOoGU0eWCF02KSrcs4l+;25:b92xBBKzX07/TO7aA07se4We+JtoXJQ7jBVbQzn1G4UO8KxVgjOSksFB85c79DLOFbAi8NytWbVQdJKB3L5BFad3M7d0QvC8P8/ZLzKbTNT8yqGdxcck5SD/dJq7b+58H3c+zAR4tRuTml43AUHkXIokS4fPsZoXEuHjwG7m9EMRlt7JTYefDe2ouuBFK40Pho+6tjatGAv55jcnVkE7SEin/x2syTOMDt7Ym20egOMvAUNqUNSh8JBcX+A95GfE7ZW96LinSpn2fX04eqrNRC+w8yedhiszXQeGG9uqxA6ypS9/abFEgaNc8QSivaoH/PgDPsVm0O1DUECBqSJfkw==;31:beF9mtiRDI0Hn4ZvIXi63Uqw0AE4aZpOhZ5/if+E1E0Z3f6plbzYbyzIAUmHvjaGA3xz0ARsiLbMDeqqafrczIAWC0EMNi4sXXiztUpdp/MI/hUWsjsE35hVlOXlUzWpyEE2cihrFuYbCV+O5pl7V/HThacvrlo44G+8nb0fIUCUYQZKuliFjoMU8d1RlTfz0BEBypYgyKffdVCHLrhTLLIvuhdNLC/LWjXTmvtnZ5Q=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1443:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;20:q1zajrzwVM5c5Hwl7Ju4CL0Z0qcr9TJF0GPrrJ+iCOM/usxyOjp3VWUIcxyI888PpO9ff/BbJ7aODHbt81iipua2r443U9+YZUah9zR8q4xpgiWqNCKuo0yrskTSEh5MCwVzHFnyqDqM2lO+FXt3KfMfSIBIoMqV6KUzsmn1qXojQKWMEHsEXfFOlxPB8JpT7eGafmGRQ6DPvRBKnOvjJ1MO9Qo8tPcGTHzsqb5vHpr1lfuq3TJzwVmh6T3Dbf+waDx8lh52WUd/4jIA2tWpXSLOENQ+lBXwVAUwV1Fj7HQkMfHprNdQiL7jt3fEAap86VqGCdKK9ac69WZbD+cNejOh/9HxQLanF/iGgOsX874BWfSPS+pvv6GZBOp5WRPX8us7bTOnVepIMMIYYYxQKRWpVQjnAHqdcBeNjlAfNk4TD0IVQgF1ssQ3C2JcARwHgHXtfNHbvTgIR7C9BUh7/hnW/SCI28zmUbNlAF3BPIwDn/a7MgFdBwPAuJXEwlV8;4:puiWj0abwD/P2Aoypw2hdlLQLRDJJaGigQqQl4ZT1UYFkIQ+Iujb0ZmSMD1fNbIGCSLXnOwafL79m1lTw67uc58Bmz463Eu21OXzrB4s7LNzE64q/lZ+X23AUyaK7fIiMPGX2ujx0jIC3sBNpUxlHEgrTbH/Y0mu3q3jvm7mCqywMPYQZ+/ct/LD0x552J05blF4RlOR26KwR57UfZhn3N3UDb/jwf1NicJyo3tZwBxxQsA0PguUksKOmNOCrXBh8u1PPz0ovvWFhUbdh2UYiQ==
X-Microsoft-Antispam-PRVS: <BN6PR12MB14439B7093A776DE4C606E40FD6C0@BN6PR12MB1443.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1443;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1443;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(346002)(39380400002)(39860400002)(376002)(199004)(189003)(7736002)(305945005)(36756003)(31696002)(86362001)(76176011)(8676002)(8936002)(81166006)(54906003)(229853002)(25786009)(16576012)(5660300001)(65826007)(6246003)(110136005)(81156014)(316002)(66066001)(65956001)(23676004)(65806001)(6636002)(52146003)(2486003)(47776003)(6666003)(386003)(478600001)(72206003)(58126008)(67846002)(53546011)(16526019)(105586002)(4326008)(68736007)(186003)(52116002)(26005)(53936002)(77096007)(106356001)(230700001)(3846002)(6486002)(6116002)(2906002)(11346002)(97736004)(64126003)(486006)(50466002)(31686004)(446003)(956004)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1443;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNDQzOzIzOnVTVmhQQ09CWndybm51ZzVab0o3VGNBYW9X?=
 =?utf-8?B?bkQrc0MyczNPbUQ2ODBaZTlWUWRXWEQzOC9kRGdaOWlyTVRpZlRyVENhbFIz?=
 =?utf-8?B?Q1lIK0ZTSDdaaVc0TGl6TTh6c0M3NEpjUURXdWxldmhaZUExTHZ6MHg2cy9G?=
 =?utf-8?B?ck1KcnBuRHJBTnJqYTRkVTRMYnRESkx6eTFqZi9OMzhHdXU1bTNPcW9vVVZj?=
 =?utf-8?B?cEhRbTQzZ0ZManRSbU5yQmwyN1VuVER1UUdiU0FUK1VwY1ZFeHl6Q084Z3pH?=
 =?utf-8?B?aHZET2NmZDM1UGZRdVI5Yks2Y1hkWWJmaTBqeUJVcDh2UGlBbU1UdU5OZGQz?=
 =?utf-8?B?T3pySEFZZkFrQWUrZEFaOUtEZ2pJWklJUUJhR2Z1V216U1I2SWJLNzQwWkVw?=
 =?utf-8?B?TWhRQkxRdzgxbW9wUFlYSmR1TW80L0lBKzRUdmE2dTkveHFsblJkUnJYK2ow?=
 =?utf-8?B?WFJvREZMNEw0ZFZ0clFHY2c5NUw3a1NnSy9LN0VsNERwM1NudGVHTGgwZjhS?=
 =?utf-8?B?Z2NCVEhKSkQ3UHJsRVIzZ3FZOEF2bm8wREo1b2g2Uy9QYWFCaFFzd3pPVmFB?=
 =?utf-8?B?ZFQrVFNpamd0TEVRNjA2d2h4U29xQysySEJmQUg3c2RlRUk4QWtLWS82TmU0?=
 =?utf-8?B?WXEyNENxaGQreTgxWkNVbklFWGZQY0xTclVNd09WTEllcGEwaHIwWWFFTzl6?=
 =?utf-8?B?azNDSnRXK2N5eG9FbmlYS2VyQnZhcFdlVFI0U2d5bm52N3NVSjlKU2E4UUFa?=
 =?utf-8?B?V2JCUUI5RlJTM1oxMGFNY3U3U1R1TER5OUc2cTd2aVlaQ0N5N01mbTdQUEZL?=
 =?utf-8?B?NVE4cmxvTk9aVklYR2VGbTN4VGJ2ZkRzMlpJb1JHM0hBSHhseFl0Rk9teG5X?=
 =?utf-8?B?cmErMG9DT0lNYVFuUXR3Rkw1WWdSZG5pUUFTY05qUHQ4bUd0aEM3NWlUZ014?=
 =?utf-8?B?UzBsbytUTGNDa3RvOURXemMxS0lEYXA0UGJueE5IdkFFU3BZRzVySXpYNXlm?=
 =?utf-8?B?MFdHWVRBb2phV0dabkxLYnN2UUsydXpkaDJrQVhwQlllS0pENjJBRVZPci8x?=
 =?utf-8?B?TzZSQ05WVTBhV3dPaWdpVlBNVEZvQ2JRVDVwYVhWSXJmZUtiRnhzbUI4a3Rs?=
 =?utf-8?B?R1JhNkQzRnltMjNIdlI2WGxleW1TQkQ5TlpKZFo2MzBBS2NQcWNvNVBPekNa?=
 =?utf-8?B?RENMOWxVMm9sT0x4alFHVGE2VUQzY2thbWFDTnplYTQyaGpIV0ZFR016cmNl?=
 =?utf-8?B?eVpkRGhKVy8zUHlUejVxejRsaGdIUUVSUmxOU0swb3BpR1R3U3VkUFJFRWl2?=
 =?utf-8?B?NUpqN0Y0QlVwb2JacnJGVXBhVzdSODZ5eFQyZDhlQ0tWRnl3ZVIzRlNpbGNG?=
 =?utf-8?B?NWdzT2tMT0RybCtLSzduak1lSUx5WHA5NUpPMXNWUUFKd3BweHA3UTdxcmtM?=
 =?utf-8?B?WThNbit4dUdxQmJiTkc2dERoaGJTVitQeW9kWmt4cm51RFNYVFNWbGdSMDBi?=
 =?utf-8?B?Z1ZUamllQll0V21OR0U2R1hOYXcvdDJIVGZnTEVNelQzZVR2UTFqbFQzNHZ2?=
 =?utf-8?B?N1pPQjlhZndwZHdZYlVYeWlsc0gyc3JLUzlUUUduTnRjaEwvRFYrb3dOZTZt?=
 =?utf-8?B?NlJBTFJqQ2R1Q2FlRmYzWmtFZ1p6R0pENjlneW54QUR2eEZjM1BXeW5kWnBy?=
 =?utf-8?B?YmEyZHJCUWpRUHJDMFMxRlpQOGN5cWx3bUFqeUZ4V0FuaUJRZWhjeTZVOVZl?=
 =?utf-8?B?NnZzRTdNWFEvcUxpL1pYS0ZLcHBhdkgwaFJkaUJvM2xkTDJ0N0NtSURWSk9O?=
 =?utf-8?B?Tmg2T0NJYXZIb1c0SHg4OGdIVG5EalNpS3hiWC9nMHRJVnB2aDBIQ1hrK2JI?=
 =?utf-8?B?Sko1aEYyaG9abWVudyt3LzRZWmlBWnoyQ2xLejQ5alJOMlBDMDV2YUI0UkVX?=
 =?utf-8?B?b2dTcklhT0VwaitiU041OGJuaG05c1VNWWxXZ3ZyOGJocHFiazZPbDBiR3B5?=
 =?utf-8?B?YWRtNTAxRUlvd0pObm9yQzlyaGcwVllRZmxZaEdOWEJCdTI0WE00d0JLUkw5?=
 =?utf-8?Q?0OJE=3D?=
X-Microsoft-Antispam-Message-Info: hD5nrwvJWjxxmt7b3yNf6YEBngheFpgEBySj+uqkTAHy5Xa3e9y+wBZ2TX5uMV+Tk+RTucPJ+xYl9MoDWaP5doEqYKOswU8eRA65Vk4mJ10QHj4jtxiFLtx2mAIv8RlXE2gzOOVcP3gKOdfA9R2KvkyIhAN0NgfD8ShO5BU9AiJJ45vbSbMj6R0xejT4RYKX
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;6:+NturVrwi8/BH0Ysjx7ZMN/2vgAVj8dUluvL5hHIlOVubF3Xej2WStTgKwRY6iM+Xtkx7wlzX7a7VCERLc4U0vhOkcC2tP/1V8NyjAxsIFLHBPj6ioFNCK5RLLdgV4gWf6pLkSzqD94Ed148HHetGVwM2HALeFes8xMw/i4pAhpRpsnUanBGAEoKswkqCv3rHtOxpKH1TGrmo3F2p/snQgVa7rNY/TzPYYzuftndkBdqzUjtmyBpX+Iz3lxbh5BUl0Q+5Q6H95i0qkFxICDYF5DWe/i/oNFoHbtvpI2W+AjLdTZrTKaJuQWp7KRhbggTF/PldAffufGjtrOupCNN1pCStK2H1GBB5+VXlxAmSd1eDQ4DBRLHZx7CPw66fgPB8DYMWIZ2qby7Kb2C2EJXEjOTY4Xw4JwnogPDn4fRgjJArcpEn4tj9Bq+QscjhJ5CdqDRhEFLQgb2fblPcJ6n/Q==;5:FPRXW6aPw/V3o00Xo63NMKYbRp7XoLGEJnh4xVmSwgy0/pwrUPKfvoa31Jc1jbEZihJuupzSCi0dYh9SwmPZ9+KuEOLia+fbmPUYiKT9YGkx3mxIelix5jlUMEBfBSL/VanG7Ndem9/STDKW7HAqTeM1geEKXo4Kyws8lBPxRIc=;24:KnD5Puq7fyM4h/N3UYt6n+tBhOyvzyNW3P/GKsqy3sxVCiuzIruhQEBiUYl6BnCsD6cgaU9cBaeTkZbS2oN5kTtYbVdpVi4eyQC8r1XSHWQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;7:Rq56hMZTsn9j9PLCtaRgmSfG/W34saf9v1bLyO10fA4mTHd+1/1kZc518nBX0uRN8B9e3gQQ7uGZX+//ZdYTRp3enrVdqmdoyYBG1v8HTSJV1Hw8Pl72fUf2PsLrjObRzJCL1077LQzEiMFNfNCabj2eGyhTK33cTd5oVxpTkLOc2ou7BAoJdsyOYgBSuFxE4GIuTjDYHf8lPsaUxfwh9XpcgygPaChyBYxzAazyKDYO7JRekaTu65cs8+x/19Rc;20:If5plOegfmPIjcBdodGKVWiciW2/0A+ZSAqejxeEEBdPSvEYVvwZG+HzGuH8hiHHSvnyZ0+6QJQiV9nqzM+7sek4VOcibXo+hW3o0FTRu45zD7PpiGD30Wezuttuz4abBpF4RaXQIRek7JDS1jq9/Rkff0DV/a00w+GsvPu0JfaIzXLNdOVZk9m56OAzLlMNCCd6iFoYlDj7zd7Nkd0X58PpDI/6u6apjR8BF80I/j9RlhP9/6oxUQeSYtQHLym+
X-MS-Office365-Filtering-Correlation-Id: 3073ffd2-1e7c-4f34-33c0-08d5c65d5be4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 18:44:21.3599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3073ffd2-1e7c-4f34-33c0-08d5c65d5be4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1443
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 11:28 AM, Herbert Xu wrote:
> On Fri, May 25, 2018 at 03:23:28PM -0500, Janakarajan Natarajan wrote:
>> This patchset adds two new SEV commands, introduced in SEV API v0.15
>> and v0.16 respectively.
>>
>> * DOWNLOAD_FIRMWARE allows the SEV firmware to be updated if a blob newer
>>    than or similar to the exisiting build is available.
>>
>> * GET_ID allows to query for a unique ID that can be used to retrieve the
>>    Chip Endorsment Key (CEK) public key signed by the AMD SEV Signing Key
>>    (ASK).
>>
>> v1->v2:
>> * Added cover letter.
>> * Misc changes based on Boris' feedback.
>>
>> Janakarajan Natarajan (2):
>>    crypto: ccp: Add DOWNLOAD_FIRMWARE SEV command
>>    crypto: ccp: Add GET_ID SEV command
>>
>>   drivers/crypto/ccp/psp-dev.c | 143 ++++++++++++++++++++++++++++++++++++++++---
>>   drivers/crypto/ccp/psp-dev.h |   4 ++
>>   include/linux/psp-sev.h      |  23 +++++++
>>   include/uapi/linux/psp-sev.h |  12 ++++
>>   4 files changed, 172 insertions(+), 10 deletions(-)
> 
> All applied.  Thanks.
> 


Huh. Without a Reviewed-by or an Acked-by?
