Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163082AbeBNTgP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:36:15 -0500
Received: from mail-dm3nam03on0046.outbound.protection.outlook.com ([104.47.41.46]:17728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163042AbeBNTgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:36:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com;
Subject: Re: [PATCH v3 00/13] gpu: drm: amd: remove unused headers
To: Corentin Labbe <clabbe@baylibre.com>, David1.Zhou@amd.com,
        airlied@linux.ie, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <3746a404-0811-0529-1e6a-faab5aaffe2e@amd.com>
Date: Wed, 14 Feb 2018 14:35:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.95.38.236]
X-ClientProxiedBy: DM5PR03CA0032.namprd03.prod.outlook.com (10.174.189.149) To
 DM5PR1201MB0073.namprd12.prod.outlook.com (10.174.106.15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27fc6a90-1579-42d3-96b1-08d573e23230
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR1201MB0073;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0073;3:YsTWikzQLrNkZDBV5RFk0rRk1LJBoi/l3P9LMg+Cu6rLyUPVpCHM7HAyGhTvEa1/Zo65BVYZc8CvT+U8ti1xlDm48Cb8gO25x7YlZjbU5oHvg6V0n+Spp5ouRz9WKUNe09QxcT4DOIrnsnn3VVVDJNQ3P9Do+cTyKmJkUQ+uM1mf59hjc9Ri2aBG3o6foq0qwczTe7GB5kf8sSRzEpZ1W3FpAeQ/8W3O27U9bTBAKA6erG/ul3KAnMPM2rwoqaHY;25:NUIxh38+gqt/DVWw855ase1nwX3P3Lyh2KQUZtnvZKQOBqcU9s+4l2vZa3FcqsASFqapieBU5ODPi4PsugwGrFrBWxuz/7PY3+BN3F3TrcVP84eKl8ri+gblzjMX4SQUNwSf8nHEy2K+nboAKxBLUU2HQS3ObIGKfc7T8VUguPtF1OPII/5OEgw3TYx6HsDPboXuUrO8F03Y9gkVcTvdC1ecRajo0HXuf9kSuBfvKJH5Lqli7UIIin55IKK/359qj5QrIKRMe1S0VwiKQiNiawDEraAQWGajmEiN7MaHzivhpikzC+VOYeOKP8UJTTbAfYb6AUjSZD6tEDsJKQZpWg==;31:04tfFk0ml26OPhuNxn7eMc7sXQ4+nOlw7sJVE2pQv/tbW2iONj7tDD6v81jO15bXBQjDnFN7n/mlAMnyrc/zJpV1aP1ZQGQ/RmQ/AMep33QEq79CNcghMWmnvbDKGb4BCFIu2V1Cj9n0RMtx7UI0dDndPygLNOL0l0vBy2ZCWDlj7Ul6jJOD/hkHIAGZjj4turf19/7E55bFhQBFiVlbDfx134zL4Ex6ZTYtUII8SIs=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0073:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0073;20:PjTwpXmFotPZRr2OZcy69ORxMJsX+mYJ3a/cqnFzXwNGIcjvq7V4tKP2VRRJyNzCVQ1iqaM+a7rO6USURLmka9Tk7ApAYksgv2s0fqXBcaRNQxal4dnhLHLmJcuQ3TKbCEH1z9aN0KckvpkzndyzTYlqsJYDstp9BXV1sI3pGOQW68k9jssJ3qAnpo2GdmSWmsvSF3oMactwG3BnL7lRRbwhawH3D5tK8swA5BhUKzRYmEwuH+heSOaE6OOpbcdn6ERi9u2n/BhBwEP+jNxzJujOhWquy9KxWVK8WgA+wNaW25/uFS/yIMLtG8351ULhJTatoXSiGvIEE+cPQibDrNs7dIEOdMV5NDc2RLbhvGJtLfovtcBnsePWx2XSPFq19L5OCd1hE/qZy8D1hNmWoiGY2dTg+qhEfE+7kZEavjGWE8ahWJL9pJVuTqZFOut0Ycn2rXCikAYoYalrdJ2MbVKi/WwT7Pmgnac8728YfHfI6hv3R0SOot3Xixsgp+xK;4:cFsiO64pWXZImEYNATkNTxOlhZCa0jO7JhWXoweOmaCeYOZTvEZaVyt2hgjaH5TOnOlBbwQ7QTDMQDXCS5FWYOm0sx5HROgWrVrdzF8ETAT8brzdD296mAPLGXknOeBRHdnymYamWzd+6g1I9bZXgF9mFz04nJEtci71qhpWZX6LlMi8B7kI/uwxQ857GlRKgd7A5gURLNgj5stylunRGF7h5L7TssBqokHdK7hB7UtOM6crFXi4D11bB9Xt/EoJfOmq5UK40mzwOUnCtEH+xg==
X-Microsoft-Antispam-PRVS: <DM5PR1201MB007386410A6BBC04FEA45325F7F50@DM5PR1201MB0073.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR1201MB0073;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB0073;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(5660300001)(53936002)(23676004)(64126003)(65956001)(52116002)(68736007)(86362001)(478600001)(65806001)(2906002)(65826007)(2486003)(52146003)(72206003)(36756003)(76176011)(66066001)(97736004)(67846002)(49976009)(7736002)(305945005)(229853002)(31696002)(6246003)(28096004)(83506002)(47776003)(3846002)(6116002)(31686004)(8676002)(6636002)(53546011)(26005)(25786009)(50466002)(16526019)(186003)(6666003)(90366009)(6486002)(16576012)(58126008)(8936002)(81166006)(59450400001)(230700001)(2950100002)(4326008)(386003)(81156014)(106356001)(316002)(105586002)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB0073;H:[0.0.0.0];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjAwNzM7MjM6WFdPWU4rdS9QZlR2ZDhNZGpZa25lVnJO?=
 =?utf-8?B?RjdTekdLeHVadTRldzhVUVM3Yk4xSjhsTFoxNFdKUVVqMHBLRFVRNFEzZUMv?=
 =?utf-8?B?NnpFTkdwbFNESzRiV1h4V255a1ZiaW1jZnUzOTFjN2FsYVVrYk5PV0piakpr?=
 =?utf-8?B?ZnFrMnpsYS9jaW16bHBtcjFRVUl3RDJ3RzZ1QncyNEFVeGFrMWc0QXJYUmE0?=
 =?utf-8?B?Z2Vkdk5BbjlHTStDL3hEbXB1TjBGWnVnVnUrVU1TZVQ2VjNCL3NMUDkxR1Zq?=
 =?utf-8?B?dlRvcVA5azF5cXVoYU9nRFdGYStOWFVBQk9VZ3R6eVN6Y3JPSmtVdmdSaW9P?=
 =?utf-8?B?R2pWWE9aZS9qVXgyMFRrY1hGdlNUVy9KTGVpTDVnUk11MjNpSmhlS3U2ZWZ5?=
 =?utf-8?B?RG55eWg4MW5aWHRRc21TMS9mbEY4aVNnN3pUK013eTNXSG1HSk5jWmJiTVox?=
 =?utf-8?B?Q05MWkhBT3VsYmRiZXRBVHEzakpVYTlnK1A0Ni9oUW12Mm4vNGoyYmI2V0ZO?=
 =?utf-8?B?aU95M1pWSEhKWkJwM3hySW5Ya0FZV1VPRUI4bmFUN2k2ZlRpb0IxWDFCcDhs?=
 =?utf-8?B?MUIwMWFlc2s4b3FaSEVnMVFDbU1hZE9iMXVEZEh4Q2JnNVMyVU1vVEl2UGpH?=
 =?utf-8?B?UFk4ZmRzV28rdmV5QTlqbDZyOGptN0p0Sm1QZXc1eTFDRjZIRDUxNUZhbks0?=
 =?utf-8?B?U3BiOXlVZlNSdlVYRFFZYm9Xb0I5c0ZlbWVmWGpPY1NHWTlFUzVKeFd2N2ha?=
 =?utf-8?B?NDJvei83VkhvQWFDQmtvZFBwSmFVbzhSUFVhT29EMTRzVjh2czNTRm13Njc4?=
 =?utf-8?B?cHFTR1N6QVdkZjRSZnRVMmpPamI3Uktzc1lzMDZsUmpYYk5QTDUzb3F2aXpv?=
 =?utf-8?B?ck9YajFCd3I0UkVZRmJHNXFWb3N1VjQ3L3NKTDF5RlptY0F2VXdCK0t3cm9s?=
 =?utf-8?B?QkczOGtUam1ZWjNGSmM1Nk5VN3dEK3AwZU1QSWxGQ3EwMlBpQW41aWFqUUVV?=
 =?utf-8?B?NTZEQnFqMkd2a1l1NzdZVEdwYkxucEFONS83WUFZd290bzZCUUpYZzNqZ1I2?=
 =?utf-8?B?aUVVR2J2djdlV3ZEUU5wL1BJRmJFdDZNb1BBNkFkOTRZa1FYcmlrVkE2emE4?=
 =?utf-8?B?c0hMbVFMS0VjSUpLektzaUN3ZWxUYkNnY2gwa1NMa2p5cktDcUpRaExlU3o0?=
 =?utf-8?B?MDJPcFo1MjF2Qzl2Vk1QTnIzOG93cUxZMFl6dnFGdlEvTjhhT2poTlNDc0Y5?=
 =?utf-8?B?dTdYV0E0S21YQk9JQTFLWjBsY3Fra09lelJqWnpqdnJyRWNWOG5ka3RtNUlH?=
 =?utf-8?B?RzBLN3ZwTzRPVzlwcCtzYmVwOWN4Wk5jdjI4Qk5oOHNpSXlqVDdPNllISjhZ?=
 =?utf-8?B?dW9sampNUW1LZVUzR3JYNXBOb25KUzlaRXJsa3ZyZWJya29TbUJUN3M5dEZR?=
 =?utf-8?B?cWNZbklIc1ZrL0VVcE0rV0ZoQWZ0THFEemlCcjVoa05wK0lYMlJ6UHV3M1Qv?=
 =?utf-8?B?OVZ1Z2FzSHRqb29UQlludmJkN0dUeWZSR3NrNkZLakp2eFVTdzRxU0JiS0Vl?=
 =?utf-8?B?OWVGMWJjbldQWTRGYUpVcFI5QzgrMDFxYUd4Wnh2SC9LM3p0bHVjcVFtaU42?=
 =?utf-8?B?QVVJRXYxVEU2TEd1Y2RJRmhuNjlqTUErVW9PeXl4OHFzY05uV2ZWVkY3cmVy?=
 =?utf-8?B?RWZWVktxdDVldG1QNmdmYmtHNS9vVWNJRHlLam43TzRtN1VlRkxSSUc3bkdS?=
 =?utf-8?B?aGs4a2VETk5OZUhsTkZxY3VBU1FsbUNQK0Zoc0FheXdHYytORGFEa051QnJ6?=
 =?utf-8?B?Mmlsa3pTczhTdTVyTStsVVlrRzFLZ0Q4VnlDTlZ6UTRWOE10K3dZK2RGSFFn?=
 =?utf-8?B?VzVIbkRmaS9rOHNLb2k3Wk1WTmtpTGVqbkJDc3hCQ1NRdVRnUEtON0FXYkRZ?=
 =?utf-8?B?WTFlZ1QyMFRwOXdzQ1FWN1lMYitsdzAzT01TSFZXTU9RYnFTV1daak0zb3ZH?=
 =?utf-8?B?bTJQYkI5OWErdUozU3d3NXczMnkrM3JGcFYwSnN3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0073;6:eJs3iSnxkoTK2ZGabmoLLod5sNAX2IeYw/I2OZYh1cTkqE+a+WZXPJHe2085eX6CjRBf4PGs5So+EoELKQg9vj5hYkEU8svN/SPcmAYz0iBGXbzXvRR+nYHaN81Y6hPoQ9XxYSqy3hP2mNs+/cad6+yZ2mrfYqoEnHLzpczQLtbT81kPkw0c2ONTEZoE1Z639br5CqaCTKvR62BostWcE7KYr5na8zSlxPR77og+JenKN6sBcBW7VHPM0jLc2tc2wcgDn6HWURlaPNPq+xMCzA0qGzlQ9BqtfQ6mqcfzPjiVsqWBBljHU+bgei+vnCURq7XRAKqiKngguya5Pfl6IUUtSeeNn/4OVsB1P8I6PBU=;5:z1WN9BsB3jIma+ThWDeGiAyyMZ9Mg4YDk/iipLayOYQlkMN23Jx+/BpKj/sMPoUs4hTcZezT2+EpXtwIbHsNRrgnpYB7pmSeIUQq6JtlU93xQhXNdwVnvF1yOD+Y9bgsNqi8cMS71sRsnts4loJGbttnbw7kjER+s0x73EVgOPw=;24:IPfkfSyp6/eERjwF1XhgdB2e+Wjn3Ug+ry/4AZWAFmCXy9c4n2UoqzRjYEgYYS4xj/QQEhucgKbLJHYNNdHkdr+vlRIiH+x1unT8AYronOM=;7:v14usI+i6lBlauUHFjrGdbtmyeZda14NInvsEZ4nBvtSmVp4LJye+tKfe5yhD2BPRSsj4eftjKaVuZ96rP/JGgGCeoFmNv7sLyPc6uSMO4OcdVv84+LM/KuOxMWCj+RHU5ooqa+bgai1avTIu9HRLeotv6wOQSXJ5p7XAqZyPEKpnnR9j5n1ZJaVoG+2qYb0qiWLtPE8D9b2S07AEoC9qd0hDChXajt55MMYLCaZ1Jul5b/UXnbdlPnnls33lWE8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB0073;20:JiNpvD5GcqEEBFtjiB2+hCmR/spoFqfhIs4V2IopwWSDK6tTS8vDOQ5pNUj/yPRqYoe1UQCxyrpqHWUsiixmHFqyCMUFRkswoGQ5oM9P4+z5+nAwZLES3wF2CK/sKD5hLWgT3jALFxakhK++flXoUuboS2oegPgcvvfmqnAK/Feqxtx4V+CyQ2oBbVuvn61UJ6KJZvixL22GY3YsXngMOScZIKq39hnWZ51IZVxAQWhUpjiUYczTY2Rx4ibXNnEd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 19:36:07.9328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fc6a90-1579-42d3-96b1-08d573e23230
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0073
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will break umr since we source the headers from the kernel.  The 
kernel might not use them but the different IP blocks have deltas that 
umr is aware of.

One might argue that we should then publish the headers somewhere else 
that is public but the kernel is our vehicle right now.

Thoughts Alex/Christian?

Tom


On 14/02/18 09:46 AM, Corentin Labbe wrote:
> Hello
> 
> This patchset remove several headers which are not used by any source
> file.
> 
> Regards
> 
> Change since v1:
> - splited in multiple patchs
> 
> Change since v2
> - Use --irreversible-delete for format-patch
> 
> Corentin Labbe (13):
>    drm/amd/include: remove unused asic_reg/oss headers
>    drm/amd/include: remove unused asic_reg/bif headers
>    drm/amd/include: remove unused asic_reg/dce headers
>    drm/amd/include: remove unused asic_reg/gca headers
>    drm/amd/include: remove unused asic_reg/gmc headers
>    drm/amd/include: remove unused asic_reg/smu headers
>    drm/amd/include: remove unused asic_reg/umc headers
>    drm/amd/include: remove unused asic_reg/uvd headers
>    drm/amd/include: remove unused asic_reg/vce headers
>    drm/amd/include: remove unused asic_reg/sdma headers
>    drm/amd/include: remove unused asic_reg/nbif headers
>    drm/amd/include: remove unused displayobject.h header
>    drm/amd/powerplay: remove unused headers
> 
>   .../drm/amd/include/asic_reg/bif/bif_5_0_enum.h    |  1198 --
>   .../drm/amd/include/asic_reg/bif/bif_5_1_enum.h    |  1068 -
>   .../drm/amd/include/asic_reg/dce/dce_11_2_enum.h   |  6813 ------
>   .../drm/amd/include/asic_reg/dce/dce_8_0_enum.h    |  1117 -
>   .../gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h   |  2791 ---
>   .../drm/amd/include/asic_reg/gca/gfx_8_1_enum.h    |  6808 ------
>   .../drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h | 21368 -------------------
>   .../drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h    |  1198 --
>   .../drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h    |  1068 -
>   .../amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h   | 10281 ---------
>   .../drm/amd/include/asic_reg/oss/oss_2_4_enum.h    |  1340 --
>   .../drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h  |  1464 --
>   .../drm/amd/include/asic_reg/oss/oss_3_0_enum.h    |  1497 --
>   .../amd/include/asic_reg/sdma0/sdma0_4_0_default.h |   286 -
>   .../amd/include/asic_reg/sdma1/sdma1_4_0_default.h |   282 -
>   .../gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h   |   148 -
>   .../drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h |   715 -
>   .../gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h |  1344 --
>   .../drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h  |  1191 --
>   .../amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h   |  5648 -----
>   .../drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h  |  1205 --
>   .../drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h  |  1246 --
>   .../drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h  |  1282 --
>   .../drm/amd/include/asic_reg/smu/smu_8_0_enum.h    |  1072 -
>   .../drm/amd/include/asic_reg/umc/umc_6_0_default.h |    31 -
>   .../drm/amd/include/asic_reg/umc/umc_6_0_offset.h  |    52 -
>   .../drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h |   795 -
>   .../drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h    |  1211 --
>   .../drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h    |  1081 -
>   .../gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h   |    64 -
>   .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h |    99 -
>   drivers/gpu/drm/amd/include/displayobject.h        |   249 -
>   .../gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h    |   412 -
>   drivers/gpu/drm/amd/powerplay/inc/pp_feature.h     |    67 -
>   34 files changed, 76491 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_2_4_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_8_0_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
>   delete mode 100644 drivers/gpu/drm/amd/include/displayobject.h
>   delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
>   delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h
> 
