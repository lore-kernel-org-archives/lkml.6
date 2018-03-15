Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeCOTyf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:54:35 -0400
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com ([104.47.41.54]:3112
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751729AbeCOTyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:54:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH] Documentation/CodingStyle: Add an example for braces
To: Jani Nikula <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net
References: <152106609844.18780.6843553697430932588.stgit@taos>
 <87zi39ljni.fsf@intel.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <2c16cde9-6f20-e49e-f2ad-db2984fd910f@amd.com>
Date: Thu, 15 Mar 2018 14:54:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87zi39ljni.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0121.namprd05.prod.outlook.com
 (2603:10b6:803:42::38) To BLUPR12MB0690.namprd12.prod.outlook.com
 (2a01:111:e400:5951::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d8cb934-2310-46f4-6bee-08d58aae9115
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0690;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;3:mbRX4+vp2IA+DzZrJKdKLDFDv7xFnwbuZw4+SpKI1Gp26FmEl8+Mlf0iFtf8F7zb+sku6/xSRxu5ejPo2FMz1JnUzHRuelSUQWe4c55lEn8uRGpllMVJR96qJb/qYlOe77fzZARCdvQTaGunRtWBo77jirep8E+SUiQgpt8pAstWiWhiz0sMnF5aEzbwApzrU+AV5h9a5ZRwWahupX5OLjns8FBWUIgw+pCE5Z492fAFQo2t7E7Iz8JThsdJ6dcK;25:ouE8OeC5RWEZ6cVeoMQEglmLJB8lsLz8Nva5Sl+d5zuTQc0hkNJEg5lpKRwM0MobQmPagQnsFY02dw31xgA3O70XvJzh+Fb1uDfamW107Zo1XwhMBJto1uE9i6C0GRSB9RBqacBVDSEnjX45rwbTTVhzb0yKYqqduwm56RTbisLE5MGki+c5pSZzLEwlMAc+r6hrlVhXn+RT9R8dIVmvNYbGaw1uWECkXkTUsKkReg8QJuDACmh8XBDQHZ7CFFdcsAks+2kKg5huCHgTVpyp/1YeiSCOAm3H6KkQHD52d5kgJinb6kpyImY80kdfovOh1xlAqZpbHiu6G3jyftAr/A==;31:CerS4EldDolhaPUQLP7Dg5qH4r0XDFdzlbooAaOkCsda+SukLMZNkvB9S2K/azMx8Dmw5P4j7VK62Mp845bitG88yIVW8T1Mobe4oat8jEPcfkf5uBcL7Z5UFekkNgfsGG0LJcxAVZNbJ7meLo7N8AWvH1ky3JSfqynNGlhkbulXp077nPLCU7Prc8MfWg85tjJR+43sj6GRm/zuJ8EdhqP78e2ULYKMDNy8Ad0MriU=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0690:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;20:0OfCdBnBeKmYcCelWnrLiMJKeEO1GAwMbawOh/5goTNhyJRo4R6vXdEVehP/hShNIJmBFq5t1MDSKn+bdsXK2pLZ7UQ7i0m3WLK3w1EKORRvVab+YMWe3DOgJ1/VZ8IeOEGi1F1OPaKS0T9EoEj1/KNq+ROvhuVKVg8kKMHT4yE+opQk6XLJe0w5SPxiXRuDbbSgTUHrI2Neshfwkj6CgCDmBaIwDAEJ0KsdW2vK6j7R7LpK6q7/NM8ifNMqropy8QxJxYQP3XL74iSCzw1jki8KIRm1QnvsJwgfLxNNM80Afh2TgYtqZubl0rrtcDAhEoSImBVvr0TieYOSDsNEoBZzZ9SVCfQvl8Lb45NHvk+0yMkN6P96Lt/EHt41QV/vBXs0vNYHtyqBvBOEEKlk85WFm5b10qoRwpoelp0QK7MLOxkqcMIjX3x8ZfLVJ9IUfhsw8AzxbJVhO79KbyYGVC9Gymvq1xoEnRje/mqsYyf95lHh3teHnmYB+4AZDoXI;4:n3NxkkMo8FJneBhMHB+UWjG06OF2mfryENkqJ9qoOLoWOKaa9aMj1sSkcxy5lgbPdTCJa3eeuO1lx1LvDpbo10QntxBv4vYwmqd4LfNr+18Z8bqd7v8Mze8DQ8gmv0QRHRl4IEbFeH5WhVSjeYE7BKiJE/KBYfWiAOYbBpVhp+lpW6N5/kiUZQPakfeekpzt6mJ0ycfGfunCDsZbQAEFHf3An9DW6zYTq7F8EiYmXX613UxDMh0AGwRAEzb+w1uQLqFIpGbwlRArgqUgee8EEtrVEtsgebxBf8HD25CARMbWFS3allxhJCWZBQLUfg7x
X-Microsoft-Antispam-PRVS: <BLUPR12MB069075A289A5F32C7769F503FDD00@BLUPR12MB0690.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BLUPR12MB0690;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0690;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(366004)(39380400002)(396003)(376002)(51744003)(189003)(199004)(229853002)(6246003)(65806001)(6486002)(2486003)(6116002)(65956001)(66066001)(6666003)(2950100002)(5660300001)(53936002)(2906002)(36756003)(64126003)(77096007)(31696002)(53546011)(23676004)(50466002)(186003)(52116002)(25786009)(4326008)(65826007)(386003)(16526019)(67846002)(59450400001)(52146003)(26005)(316002)(8676002)(16576012)(106356001)(47776003)(97736004)(305945005)(68736007)(8936002)(86362001)(478600001)(105586002)(72206003)(7736002)(81156014)(230700001)(3846002)(345774005)(81166006)(76176011)(31686004)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0690;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkwOzIzOmQrM0VyMkl2TVNzWmtQYUl6TWRUNFhIYTdF?=
 =?utf-8?B?Ni9yc2lqV01yK05ZUlQ3STV5dlF1Z2RSRnkyS3NZaFlKMlZFbVBjSGxndGlJ?=
 =?utf-8?B?dkdLS04vZ3kxTmkxTitHOEpEUTdLQ3ZWWmV1YVhqbVRPd0d5OEx0MHc4a3BV?=
 =?utf-8?B?UWY2U2xJNmw1T0xJWG94TDF6WEFqaFVtUGhOUklySFBWaFNLOEdOUU1GYy94?=
 =?utf-8?B?WVNBTHkxK3BTVEVTc2VOWVZxZlVpaEdPck5LKzltSEF6NzN1MUtnNnIxR2M1?=
 =?utf-8?B?ZUdCNkY4MU1oSnd5MGNyaGRsY3J3WXpWMGNXVExRaUI4RUl6dS9ZcUJac1Jy?=
 =?utf-8?B?Y09YOEpEdGRNTjNqL3BwV3VjYnlESmM1RnlwNS84TVdWcHp5dnNXb0JFYSsx?=
 =?utf-8?B?elFvampnbTRweitRVmZLRWdmUEU3dEFzNWhlOUVtN0dEYXJ5SmRpUjAvTnVv?=
 =?utf-8?B?QVpuMm9GZm9wSHo5cldWWk9qTXVzOUVzWWM0U1pQdGhPUFd3U1pqZVZMTDZs?=
 =?utf-8?B?bHNxRFBwK1d1WU9zZXlHZWozUVlVOGZUTDVlRUphd0N5Y1FTSTVhTysxb3d1?=
 =?utf-8?B?YSsrbmMwU3lSQzkxLzU3ZEJJWXpQSHhJQmI2dkNQYnRKRDRqR3hNaDBiUTQ2?=
 =?utf-8?B?YzVqblp5Tkd5VGJPdzFvajNVOEpsdERNc3JuenhzbmtnRCsydFZYMllNVEdT?=
 =?utf-8?B?S3BsUHRDN2RVbGxFbjdDVmJpeTBPR293NVUwV1JjV1BqVFlXeW5LVElpMnVv?=
 =?utf-8?B?b243UzRnVlFnV0hMNXdxTzNuT09qSzB0YTlVVjZaTXRESmt3VUFESnhXbEY4?=
 =?utf-8?B?Q3ZrblYyeWVPK0dYcG9WNHhxWE5DTFdBcmIwc1BPSFpvWElvT2hxYy83ZTNt?=
 =?utf-8?B?ejZzb1dVSGJFUHNvNnlpcVQwdSt2Mm5YYUxXTmpNWloyVEllekpzSjQ5aGZr?=
 =?utf-8?B?SXhkZzhJcFUxa2ZBTWo0bUxMa0phdmtNelZxOW9PMS95N0xHTnhlUXdoYThD?=
 =?utf-8?B?dlFFZXFJbHgyRmlnN1krbzdRbUlvdldiQW5abGZ1b1cvNlRGeVgvR1dvRlBE?=
 =?utf-8?B?ZkJCZWpUdWFoN3JCNExlcGcxZTk4Y1IyOXB1UGJLT3g3bWtGV295Z0Q5N2p5?=
 =?utf-8?B?QWxPaVRmRDJTbGpJbHJJU1FpenRDWmkreCtySUFzTmlsejAyYzFkYkhoRHpJ?=
 =?utf-8?B?elcwVHJNV1NJdzJvUDJxUUEzdDBSamJyVGJtZVhhNGxJUXQvOWxJSlhkbnVI?=
 =?utf-8?B?VU5aWE1YR0dkWGtOb1B4bHlRL3h0akYrNERTOEdHRmwyOGtRL2VDMTFCNmpw?=
 =?utf-8?B?OHpEY1NaZ1pYelB1V3krcHBGNGxEWUdpUXVhdGpPV0NBZ2kvTTVmakdlVWk1?=
 =?utf-8?B?Y1NuenJ3NEpNT2NUU240R3BqWW9jM0gwVytrWWwzbUtLckR3RE5CRHZOeWdj?=
 =?utf-8?B?TCtMdWtISnFXUFVud2ZBU1ovamxqOWZUQU5TSmdjZUJtZzN5TlFPSjFwVWxt?=
 =?utf-8?B?K3d4Y29CdjhqczNPcjl2WlRjTXZrV1ZhU1lyV01WeTRFS051eVp6QlF4Znkz?=
 =?utf-8?B?UjZWaGdMd1Vkd1JnWlBSTzlOTkczUnlUU2JuZUh5dVg0dTY3T3lnN3N6cVJJ?=
 =?utf-8?B?d2N2Z0g5NlVFVGtJcndxTDduVmRZRlRvRUpSeGRzTEhVQzhXUCtMM29DSWEy?=
 =?utf-8?B?N0sxTklpWStzWXJGb285UVlPdVlxT3NURENsMjZYTG9ZRkRYbGFuenphYjJ0?=
 =?utf-8?B?ZXpLalgydEwrM0p4SGVManJWdkxqSUFZeGwrU3pGQnN5NnRyVGUxYVh5b0VF?=
 =?utf-8?B?UkUxMDZ6U3pLT0poQk5IUkRxN3lubVl1cjVxK0xrTHBTOVhCTWY1bHVTdDJM?=
 =?utf-8?B?ZEJyWWN2OUFQR083Y1ZlbStsM01xanpTYjhQWlUxbnl4dFM3cWN3NUw1ak9t?=
 =?utf-8?Q?euAluaeBzYhGA0qP4XKXu47y+w0hYs=3D?=
X-Microsoft-Antispam-Message-Info: EPgUiPcUVVJCs+NkGDaXppKaW0s6COG6EA4119dF+IDWyd5t9Wx5+ATBJG9/ebq0Ue77Rv/nwbdmG5QeQKXHLrb/nYy+tCHZy8vvzTS5CZPqDk5eMx+SNPGoXygJtOiz/09XxYauYfMJ4BthCncGM+Y9e/ZbOOkCKqQhV1+ncKIXSVL6TnW2uOiQrpNhTJ+g
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;6:54ChLGZAECsbqelgK15SbQTMZsDYPsVgr6b7yf7UqqQ7thl7UPJziNXJg8bwknlUzs0THDRaMzLXyxh+uL6eqVETrXFR6p7RuCA2NWdagMLbMaXBtRsxi0l++s5L/SEn+DRpUQ3wncs9j7gESNYLuDbEUhohNQs8Alv2mf+y9Snvip4pfhJJgMav8Wm16yPjnrgbHanFKwG4665ITq1XVALp5ulUxQRGlld7RYB+FMFKTO5iC0PulfbLOzRkGb7ACkjq+l+OpHDZlRaZ6I7v4U0sH5lVkexoY6wZjUY1KUeAQoxx82A6OCaSCdb7GBLZCG5nCwdaZ4yuavWWL7CjjYSNvdXryYjsuwFndTPVL7A=;5:QfZB+qwT4m4XGMTXusIeMetjBlSCeulX7svulthBD5o17T+HzEtE9uBzTO88TbyLg0suxZeJw6+AoidcLV/XcGHxMO1O3pmpjW4A+iHB5UflyUG6BgMfeZNwKMv+O7E8jvGzGz+O7WlY4UHJNTPkq1wjn+mwbBdK5FgdO19a1bE=;24:TfWt4W+WluwTudzj1CO3fiLB7oEPcoo3XIM8uscseA8WJGSBy4Q1WaazgFEA3Wgoyjyd8pddY21JLWG8XZ3bsQLrdcBEHx6OshAKlbVU1Mk=;7:U/lKP0puEVFzpLaTyZnKC9Mni+2UmOC6GGs9iazG1ofgpH4CI1l4IurJP3gD2Z2JTJkemkfaZ6MrZUX10h4grX91AV9+qZnbXbcGgS5faLmZF0UR2yM51jFCpzJBEOcU1lcB4d3IV/74GmgJdb/aGGLChMvg2Vf/6jqfXE3n+2WjzJDSfpkJlmc+80sz+NTPr4TdWYYVmgelbo/st2u8DEHxs5nz79kaXoQxpiSwGU/7vnQOZN8Fh/ilXcOc+8gH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;20:6IlDfkgFdO33zxXswJdOYnvm4rzmnBc5K41zYtVnyDqJnDpc0AOubJWOujRTUGkrAUqiRk/JmcKXPBC1bH85OPiJtfT+e6I9Xs5perKUIqQOO6REmoEf0/bP5OGtajYTymGCcxq0V09pilkSbyslFS6idC2EeZFsfi3wP323wAZEbOV/RfkVN+5UM2iBA07cQr1zVYJ1HH4RrrHoWEpAYqEgUnoBHw5BKWI1i/7wnj9XQALvso2yfsHCBrCQyagm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 19:54:30.2710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8cb934-2310-46f4-6bee-08d58aae9115
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0690
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 05:26 AM, Jani Nikula wrote:
> On Wed, 14 Mar 2018, Gary R Hook <gary.hook@amd.com> wrote:
>> Add another example of required braces when using a compound statement in
>> a loop.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   Documentation/process/coding-style.rst |    9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index a20b44a40ec4..d98deb62c400 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -200,6 +200,15 @@ statement; in the latter case use braces in both branches:
>>   		otherwise();
>>   	}
>>   
>> +Also, use braces when a loop contains more than a single simple statement:
> 
> Personally, I'd not limit this to loops.
> 
> 	if (condition) {
>          	if (another_condition)
>                  	action();
>          }
> 
> You could argue the existing rule already covers these cases by
> excluding selection and iteration statements from the "single statement"
> in "Do not unnecessarily use braces where a single statement will do."

Define "statement"? There's a school of thought that uses semicolons to 
indicate a statement. I'm trying to eliminate any ambiguity by calling 
out compound statements as "more than one statement". Sure, semantics,
but in the interest of clarity. An additional sentence and example 
doesn't really cost much.

Thank you for your time. I've made some changes, and a v2 to follow shortly.
