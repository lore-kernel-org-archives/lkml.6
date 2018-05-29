Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965871AbeE2SrT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:47:19 -0400
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:58368
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964830AbeE2SrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:47:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCHv2 0/2] Add new SEV commands
To: Paolo Bonzini <pbonzini@redhat.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>
References: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
 <69cd82ba-d60d-d3f8-37ee-ef4cd769f611@redhat.com>
From: Gary R Hook <ghook@amd.com>
Message-ID: <a434513f-9ffb-9d91-8832-50bf4995227d@amd.com>
Date: Tue, 29 May 2018 13:47:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <69cd82ba-d60d-d3f8-37ee-ef4cd769f611@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0801CA0006.namprd08.prod.outlook.com
 (2603:10b6:803:29::16) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:LF14X6LCYgMIZAjivz3lgYUMcoVPDiievIAujAUojh8L4NGmuV6aj32xPX41hXKcmcYgzPWYtqXzLOn5wDgRUudCMTilCA7k9tfFQJLHkGrrzYJF2lLiQXMYNcj385dqvmr8VqrPq5nHLoOmkVTBbz+p+/WzsC7Kwo8rjeJgmQphVI7Xt+xPkRvGIkv/lErNeV5Vv9NBpYp9hOJ8AYGJJi7mgiQ5ADLgTffHWhLahTEg6ne1gB4fUODLH97w1Xnn;25:B6SSl1BA8CfMO0eCw3X1T1FhbXrEMCyrZnQjqgbRcDEmnzQocEjqqxG+YTGYaZBwQuk8bSQbV+DzKUjhPHjgzYuzvHiO3pPo1PzAwqym3yaRKtGa6kHQeUWhJLzx1m4DgxfQyN1YxsjEbEh+cn8YDJ0sXetcEyMrr3121wiHk3RGbCxCP09Gm+s8Qk8GMPGfE9k9kGuoIxiok0WodFRxvS4yAn1Ih/ogkzrRZFM0dMVHIz4K4eMeHE/I+Azwf0FdtijVunh4AQIxr5IOIMdkxNb9zychixAcOXuCZ5v0nnEvyMsAeswyYV8Er5BvI5PbvnpAhj5TE5r6DBiPMTfzcg==;31:7egfdOQZCrsH2kXRm7GFxTdSNCvbzUnN9iit14Rxwam9sSgOCwDwhsbsWSnfHrCxg4pqJxDp0BMf9nj1gpwDdn2xWEocUzuAVjEo5qTNaq6aXEouS5nM0dIpCaZbGLfsPKclQnoQ3XqRY5vrNikijSOH1AT4hKJx1Fqny7b6pwZWRtneaOKdzHTcrMOS9pINIb4Ah+LpzSf9SHmlxIbyOXQTpDU3Nw2VV1ZmtRWdsT4=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:VwkX3DryGkHnFxv1U5lJaEa+D+VR359rdzutJataX2vX6sRie0owShHsrplPJXm1/zr9Vu2WR7ZZmTMxck+CGBbh11wp13e6GPOoK3x7GfGoYX4vbNgtPW41g8J28N+QRT+9SoeADfCIszR5Cdw1XLAKMgbc200XVXmUBbqLAuhljW5wp/1+b6pdKdE2kuUD+Dbkx6IaQvzBjV4ljvo0k02FMtMSBSA5NnPa8pOR91VJpHMtKBvOvZ/iTpAiGqgED/5BiGh2CJ0D2zr4MEQD8RdXw2GD8HJlpZ6Og50ruOXww+GSRr+lRu0FedUd/Y9U6e4YLfSIIBa115ox0aw8boRXfKLOjRGBaamgHIN/mMohqMVXV9J9+3CCkTwjHfSOi4MMYpxrOSZHh3fQUQnhC5hD4xyYHEg2cSnbvejGr2fTZ4MkjQbOxWR1KHlKxJuWu34Qgt9am4F3nHf1cQkPmi8s0Lgj7px5IsrieK2LiBbQlywJxeV15W71JHRrM5JY;4:bKNhxi6W4aq/8cLgmOzekcCoKsXzPH01h+loqlulxr4/xMc8DfGfhDsnjm02Ak1ob+O1971mJfwO7b0xWQWJLDl/LnsIfrRXlvqPwCkvx70Hb1CBKH4fS9x/hNbt4ULzi3SgWXd0hmdzcv7bBw4NJ8omU8TC9bw0r+2nyOAsVpzrogVjA7+cLpwnKAEznoHIATWrRYSC8q7GeG28u1Nw0o55CVhzn10ZWBiK6c0byjy1CGHm3ry6dunSduMeGMVAx5GikaOKA8mEgY16C+11ug==
X-Microsoft-Antispam-PRVS: <DM5PR12MB14499B90BB3863842260C491FD6D0@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81166006)(230700001)(97736004)(8936002)(67846002)(72206003)(52146003)(2486003)(6246003)(956004)(16526019)(53936002)(50466002)(52116002)(2616005)(25786009)(11346002)(68736007)(446003)(4326008)(486006)(478600001)(64126003)(476003)(106356001)(2906002)(105586002)(3846002)(31686004)(6486002)(229853002)(54906003)(110136005)(16576012)(58126008)(53546011)(316002)(6666003)(5660300001)(65826007)(6116002)(76176011)(66066001)(47776003)(31696002)(77096007)(26005)(7736002)(305945005)(8676002)(81156014)(186003)(65806001)(386003)(36756003)(65956001)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:[10.224.11.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOmRqMGtOZzIwWU9kbHFBQi9xTDhpdVRnc2xt?=
 =?utf-8?B?WE1GNkh4dFdSdEF3K2ZRT3lTRFBadU1Pcm8yb1kyZWIxL0JDclFRUlNXNWIy?=
 =?utf-8?B?Y0E3LzR3SVhYeXFqSXlvbXVOMktMNlRZZFpnY1ZYa3V1MENkTzFXZThTdWRh?=
 =?utf-8?B?ZVpwVzdmZC9VdGJiSUp1SmNWTHdjQjA0SEFEb1ArejdyS05pbWM4VXVVOTdk?=
 =?utf-8?B?Wm1zN2VpVlRXM0ErdkMwd1BhdFVUT2lnTmpkdHNRMDZpejFzbEtzb1J1QzNl?=
 =?utf-8?B?WEdQUjVMY0Vhd2RPZGpwWXV6MG80YS9mUWNTQ3ZlSXZZaXE3N2NDZE9UeGNa?=
 =?utf-8?B?NTY4R21VR2I2cG5VQVJHc3Y3bEk0SVQvZ2o2VTRkK2dLUzJTQ0s2TEFZcXgv?=
 =?utf-8?B?K2JOSWJIVmF6WGNkNzhKWE53SW11T2JmSzZBbEowVjRXZ3IvMU5SNjh4RXFz?=
 =?utf-8?B?cVNnRXZWZ2c0RzhYN01PSkZrTEhoYmozZXVnN2NqVzVNZXd3dkI4ZENkNGha?=
 =?utf-8?B?NU5pUWo0UFNoRVdRQmRLWGdWczFKRmFCVUVvSklvQTVYZWU4NENJWW94a3B3?=
 =?utf-8?B?V29iU0R2allMMWVNaU1jZEZIMkV3NnlLbk95dE9ncjRYOGU2aExDN0tCUGVE?=
 =?utf-8?B?eUNpTFFXZUxXWmhueHE2S0c5SHNiM2tRMHFWYU1ycjdZZDdjTkF4ZmRLU2V0?=
 =?utf-8?B?cSs5T3cwNXlaVk90Z3FlUDMvbnRzaitTSG5KR2tRUWdmdmRFN08ydUs2a0ls?=
 =?utf-8?B?cVF2alJqZVhseTZBcU1DbXljV3dFeEV3Wi9ZK3cwK01TZ1lBazc4UWwxdnBn?=
 =?utf-8?B?RzFvMzBlTlFoUk9wZDlQRTQ5OTF2NS9yL21uZ28vdWpFTEkvQ3BrbmFZVGYz?=
 =?utf-8?B?SmZQamRZT1VCUlBmUDZ1RWhQTldHellPcjNCbzExNk9obDdmaXVwRml0SUdj?=
 =?utf-8?B?UmxqVEVzOUxIUEdxZUM1aG5vTUN5UFJaZWthZlh0ODI1Y0lZbDVFRGVMaGx2?=
 =?utf-8?B?RmVUN0FvQjhpOTFlZVJ3MDRHeEV0V2hxdHNiaGVYakNjTWhEZjJhVEYveXlW?=
 =?utf-8?B?c2xYWDUvRGFTZ0FOMUs5bFRpSjlzQjNacmJzcFd0bEZlYVJrYkhSM3R2ZlFk?=
 =?utf-8?B?bWNLZFdqbjlDaVY3dks5cll4clVkRWZqZ2hOQkJBNWpTN1oxVXhNM1lORVBS?=
 =?utf-8?B?RzN2YWxUU1NFeDFBVjhZc3NxZk9zVWh6VHdMTWdoRjBZNDgzZVRDSStoKzBv?=
 =?utf-8?B?UFpTNHhYaXMzNzFVYkw0NnZDSk1LRUdCN3RhRDI4SldSWjRXdENDSTJIWklx?=
 =?utf-8?B?UDh6TVRJVXpTek1DcVpOVThQTDdJcVI2Tm1TcDRSTFNrOVIzZkt2cWF3RTZs?=
 =?utf-8?B?d1JBUHdUTVBsNllhckRIVG4rOVB6T0NFL1N4RjVTbTdIM1BRdHF5MWFpYTV1?=
 =?utf-8?B?c2N3ZTRLeW1YcW12eVYvRXVQYW1oSWphUEx0K3hvUjN5eU9rYlg3a2p3dHFz?=
 =?utf-8?B?czZ6ZFh4MjRhZDd1RTNtbEpUamN2U24rYlloWE1idEVGenFLY21QTVQ4c3Bk?=
 =?utf-8?B?b2oraXNCdUZXMUlNVzhDdWtUUldWaU1KMjVkVDNsUVFtS05xQmZwZ3Z2SG1s?=
 =?utf-8?B?UXFMN21UN3VxSDdqK3BXOStnM2NFT3B6SmdCUkxYUmxqS200S1VYTzdmVG5F?=
 =?utf-8?B?VjdrRXJHd0d4YnhrZjRic2tUaVpFbFJnVmhlMlYyazdxRmxWL0J1RDI3WERk?=
 =?utf-8?B?ZmRVMktiLzgvc1BxcDVCdWdrZDlMRTd6UGE5UDJpZERyUWwzVmdycUYzS0pi?=
 =?utf-8?B?RHF5SGNTMXRJc3Q0Y25FalFnMkpVeHMwaGc4RlN3LzRvdC9DaS9FZzk1eGZa?=
 =?utf-8?B?TURkSGEzSlNzYVhGQ1FGcjgxM0lSWU1BVTB3NGxaY3JCVFlYdFgxMXVTUzVh?=
 =?utf-8?B?VmNUd3lsb3oxbmkySHA5UnJUSW50OE56YlVNaG1TT3pXWmduOTRmZlpiZlZl?=
 =?utf-8?Q?doXZ9c?=
X-Microsoft-Antispam-Message-Info: F7j8rubFlHcctoZK66mHkxrCkVdkOZQdKH3ZBmQchuFbZNSJKv7BFi5mLfTP4eGXOO77DNRbj70v7wwecTS0fhmm76fr27aiLIUAw0/4qbETPAETwtyrFsUXZfzZQVNvNv5LA9WYH8IRALN9ZQ3fG5MaV/eOOyR36aC05LD+ARazMuRs9qA67QUfwOnV4Nq9
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:VtC+MCSCSM9zH9Gvin7IHY3KgurF5vGK4MMnf6mtg7pumBMU3xE+Jq7ugezD7OpFYyE1eVuXdFcX6ryhv6ZHWKiNVOuLTwI3u7NbcbefsbtsaFOMn9NlZd5AhuRyK0+BhxFonzIHdYOeJSWAwo2g5Qgqqb2Y9rDxScEXmGbV9m7XWbA0zCZVLROXJVfxow4pAM7fQoYj40STi1lJsq7byDDhQiAlbEeRZ00VQMHyuICsCE/R285faXiyZKu+KYMP1HIpeQ7iFle3K3FW1KggNjdV6WM40tCLfCQsPliyeI1UtqVzFpDgsxMXGV6UcDi4nNvAVttTuJ+m3w29MU9rd5Q1Lzqji5StZ3t+FGEkf8LO2qJM4XoGlfM+wVvPOs+kBqWoNV+AgNwORyOnhN8KaPMVPFvt8W3PyQnjNBWVQHtbaPxACQmTZRmCuu7JrQjlj+48A3k1mBh02Vxu7cxm5w==;5:uIBk/52Oq2Hge0LWc5JzExMRjja45UYJmWEDuLQ/08JBmLlxCpTO0lhHfPU6AaHThOO2szVV2bIB3EazbRqiCsdj1pk5drTc9jJkWwUSwDlMEAoOIs0MB0qP1eJrtmRm5PO7XbZMq0Xe0ALSZx1wSpr9fIDHSQo38R7hDZOMSNQ=;24:gil++6CPOZ32QENez1zWT6cLqHDk9swh9gJXrFy2O+UyO0cSpwbbhZ3yQLBODJtHGvM/eC4NEqxVIGVKS9964ZejavV+AxDbo4LU6ybzJ3U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:OYlC9I/LEEZEEshmLN4/6yO2b/esy+elHEmztg0Mgud4yZ43Bb4pj0vUnmMc8a9pN3GGbKiWw+1vc8yugzLNUp0/f64KMrF6Rf3RKHISXbcuC5xetC1luMLHTP1nojKvjJ3erhVzxo2h9JfksIt1CFZcHLcTN8ahk4zhPou1mDQCURM8sy46RI7nIK5B4DF56pbme1qlzi8MX7j7YxSbnVV4QXeXBhUAntP2VEtb+30DKvaDJ/MuhfcmUh9bdxyR;20:EXI6u8lOHbckaKXtaoTNlT4a0pZOJwvGhiYH29fD2rYfNhf2ACXv6bSEgMNqc+vpDKfnHf0k0f7IDR4nfyoL0GDzE0rvHzrHlu/5ut5cK2qdekSXymFz+bfqxJ1HQENItakrjb9NpvAgy8M6J73/2abxVRutkeyycW2um96uw9IidCdV6N9vFejyaixWDj0PFp8H0bDd/NjBam+to8b5Xu1CFkzBKb6agdYaV7d5I43W/LvL56dQCRub/ZZG/1ex
X-MS-Office365-Filtering-Correlation-Id: 7ab1f605-9697-46dd-d529-08d5c5949868
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 18:47:13.6569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab1f605-9697-46dd-d529-08d5c5949868
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 01:46 PM, Paolo Bonzini wrote:
> On 25/05/2018 22:23, Janakarajan Natarajan wrote:
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
>>
> 
> This is not going through the KVM tree, is it?

This should be going through cryptodev, AFAIK.
