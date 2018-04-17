Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeDQRg4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:36:56 -0400
Received: from mail-bl2nam02on0079.outbound.protection.outlook.com ([104.47.38.79]:43456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751230AbeDQRgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:36:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
To: "Mehta, Sohil" <sohil.mehta@intel.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
 <1523663790.2747.4.camel@intel.com>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <10e422dd-a3ca-8ecb-50fa-e7f131a55a12@amd.com>
Date: Tue, 17 Apr 2018 13:36:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523663790.2747.4.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR1801CA0024.namprd18.prod.outlook.com
 (2603:10b6:910:74::37) To BY2PR12MB0693.namprd12.prod.outlook.com
 (2a01:111:e400:52e0::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;3:Fii1OmMwPN+R3uHUSkzYo2L8UipQvjYofXQ/8L01SwV+vy4Ivhn3/y1DWbsb9K9AnppbXh3KGtbq/Y2dNuPvKBeAVScluL9IYpp2ytG+2/WhlKnQrkKaR99e2LPbTJ4na0iOQcIxqaeXrOsUtilsom2q68Ifw4/t52BNyH3W2X2k94eaEmyLaoUvzBjTsDYySoogM9rc7hXiih5l85YpHo8kABpf9QRlKgSaIw+u2Wa9+O/12Mx5fxM3Dro1E17y;25:JVpmRe2f7pk3/rV2soh++IwAEqepy/PTH5R9XcTpSmYBZ7T6ps2FlKlZQWbSMVXRm2Q8NV29ICzptwcHBbqGBTI8a1UJnGAUkm0g6Bh08BuQBVHK31j0bKXc5ESsRltTDzKoxQx+0PioMEI50TVQkf/JcypzBbAyDrBMtMBL8INUM9Oedp7ZSIU8PKwHim0XZmN6uNgovXhqxfBuW2lGD9heoXa2TJLWUY79eYFLGItmxl0//JngA2DUgStUGn8+efbGxE3rKGbwiE/ZudrV2pfCk639sOkl5w1rkdn0LL5sQH9DDI0l0ZtxN5In7gsln03bX/gOP2SBcFX7LrFwBQ==;31:FnCcQ4nbEFpP9NKJUIEcTwWBN1FSNalqa/n6eXb2f2Kb5jB3l4zlgxF/06mtw5lThw0wO9vB0qtO6KqE015KOjYtBrlitbLGZkLoScoUm+IGvbc8aIpOoVpnI+xW4ocYdJ93gIt5xTKP5YEDgt+LKBZ0ZrcO8AMxQQsxS34iZ35LSWI2vkEtSzktKRwOK7o9Gkis26Bmcf0u+q/IYcUasL7CuldZusaVJbRqgvitAMc=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:sbOh10sUwfixc0jGw+Erkdsjf0XrYKOTEb41xOq0xpfbMfdDxmo9IxDbL3pUA3RTh+Yc7NEe3yAoMY4mPZsH3qlFmha5JMjFd6GejN6pM/2lSEloI8rg/rZNdjmeJ0ctUnCAg7F1qSpCEOKgIRFDyne6AEhnMvfInGtdMx4Rdmf6OLKn/AXMxZjHy/OUjpKHPCyWYP8htzG6pP1EItfgOn0ocQ2UnvveA9c+T+jryhRoNHxB/6uxsv6idZ9SE2oAQ2IuMT5TswHum/rN9SqlFx+l5HAkkD14CJfYW/BGmv4SVBdufbuzKwuhoysyds02YrBZ6V3etgdT6QMhJ11YdKcaI26yRqtLTGraR9SqUm7yyAAo5PZMv/w9fuD4ATbyTZTIA0sQSEev9t8/CaJLtKbUiRSipxyAklFHBm7J9PDxDYmei3fhRjTFaqlrNLyrc6aQFHiD5o5k2At6fXRnXHjp7RanvdxjQs867L9Pwrm9/6rRQ+IS7EqbE89TZ7Rc;4:phlD6SnJYYa3YfrSKDvQHW+3Z1/Xc/fULOPZovyusdWzHUZutYuVvs0k+rouy4jKjRmzmK3ha3zJIGTIyH1R+F9/h7K9vQ0roIWcrqH6/oz/JQQ11T75hqsntbvUEYSv/K2PaCpkcDniZYoUkpzk3SKBuLf28UnRFdzf449STnfstR4Ma61sQgq7vQ/LWzxg8MU8XFubDVE2XOuIAWLsaZAb4vrZx1PKwjEGsGVAGxso/wuaePlIHljVwQCCdzTHPSNO/8vJZpjiFRaxtcyL6g==
X-Microsoft-Antispam-PRVS: <BY2PR12MB0693B355199A7B29C570122FFDB70@BY2PR12MB0693.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR12MB0693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0693;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(377424004)(67846002)(11346002)(6666003)(66066001)(16576012)(47776003)(50466002)(229853002)(7736002)(2906002)(486006)(31696002)(53936002)(81156014)(36756003)(64126003)(2616005)(25786009)(81166006)(65826007)(26005)(956004)(6246003)(65956001)(4326008)(316002)(5660300001)(58126008)(65806001)(72206003)(8676002)(8936002)(446003)(3260700006)(110136005)(230700001)(68736007)(2201001)(186003)(6116002)(476003)(2501003)(478600001)(23676004)(76176011)(52116002)(52146003)(53546011)(386003)(97736004)(16526019)(305945005)(106356001)(59450400001)(77096007)(2486003)(6486002)(3846002)(105586002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0693;H:[10.224.10.182];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjkzOzIzOnZnSVdzQzdnSVZIZlFyV202Q0M5QzJGbzdj?=
 =?utf-8?B?Q3I0cHREYjh6cGFNQzBIL2k1M1lpYm10UEhpMk9uaUdUVkM0WUV4VUE0L0ZM?=
 =?utf-8?B?UGptK3VVY0kwNzB6OHBxUHpvSGJ1OUlwa2c0WjJ4MEhoOEJaY291ZEU2dVJu?=
 =?utf-8?B?aFNCbUFBamU3QlZEK3RjRzMxTHNUYUIzeUoxU3g0Q2xXaElEWkpPYXV5NU9U?=
 =?utf-8?B?S0N6UGkzR3FNaCt1WkxtanFnSit6eGJyMngyZmc5Qk1NaDR1cE43SzM2WXlj?=
 =?utf-8?B?OFkwT2dWWDZ0cTlrRjdFWjc4c1JGVnhJRDM2T2ZhRmVpYkZtZStiR2xsczFH?=
 =?utf-8?B?NC8wdndLVUYyMlhaMjBxakVta096MG5JTWhwL0EvTld6d3J6RndSdWNQZDFu?=
 =?utf-8?B?eHZQUkNZdVhmdW1uQnlKZXBwL2owSy8rRXo1V3lnS3ZIaEpERnlMVnVJU0FO?=
 =?utf-8?B?VW4vZ2JHQksrRTBHZGtzZlF2TGVOVkhTVUZVWkVxRS9PRE1wNmRublpqbmQv?=
 =?utf-8?B?SWt3WTg0TUNXVElzNFR3WFJkTVBrOU82T3BzOERuRC9LNFJWeFlrTWlDWUEw?=
 =?utf-8?B?N3BRMTJaS1dDOFd6TTRYT1RQbm1CcE13MklDSHVVWmVtTTR1OVN6elF3YlMr?=
 =?utf-8?B?b3hqSGVuZjZ0bXRvRWthM0oyQjF1Q1dVeDdDRXhrTGtJNGQycXhRNnVGZXlt?=
 =?utf-8?B?ckllK3ROY2t3OXpZUVZOd1o0a2N2QkpYMXBRL2NVVmh6eCtEdU43YXFPMUxw?=
 =?utf-8?B?SHFmVWIrajUyR2JFblVjNy8yZ0xMNVBNRXFVZGVsUGcyUTI4ZUdKcU94b0xh?=
 =?utf-8?B?aUd5QmMyMHpvcEhHclExMlJZR1R3Tis2U0crSzlpNElnejREak1tb2dudFR4?=
 =?utf-8?B?ckx5SFpVQ1lPR0JmWVNScHNtTStKVGVSdjB3U0JKSjU2Y2pwSFEwUHA4eGp2?=
 =?utf-8?B?Rk56NW5hQ3lTSVNaeXBFOHAvak41Q0RPYlpLSXVPMCszY29RdnFqZHVyeG1i?=
 =?utf-8?B?SHJVUnFjQWcrcGtpcC84aEVFaDdaUWQvN3lBY0tGT2owR01XSmxJSTFQUlcw?=
 =?utf-8?B?eUFuTXFmcjRPZmpYMDdlSjVVL09WL1orT204eDZGUGJ3S1dlVXhOZTdvazdQ?=
 =?utf-8?B?ZTk5bmVXVWJHOC95eDZsZ1oyRUorK3RXRWRKTGxxTnZhR2FNSEUwSmJwcnpp?=
 =?utf-8?B?cWoxNEtjdlBrMkMyWEphd1BpZTZFQ2xWMm9aeS9Wb1Z2anROWEI2N214S25M?=
 =?utf-8?B?MVYxVEhnZDZ1MHlVSEJKcnZQZkJlS1oyejBxWUVTSEFxZFkyNi9SNTB4ZjdJ?=
 =?utf-8?B?NWdGbDZUaXZzLzFKS1R0WDRnU2Y0Wm9wWnl6S3lvdnpUQzk5RDZHaWd2aFhT?=
 =?utf-8?B?enlRYkcxYjhEUXdzTEUzYUxhbnl4OWlLdlZCOFUyMnhHMUw5MG53MlJEMWgw?=
 =?utf-8?B?M2c1ajRsVXQ0VHE4SXVQbTdWNUxRVjF2M1Z2NzlTYWE2c1J6TmJZL2oyMEtP?=
 =?utf-8?B?UkEyREJHc1ZURk9yaVdTaXBWeDVyVGNiQVA4YVBneElzb3NZMmYzaG1sa3Fn?=
 =?utf-8?B?aGdOdStrWEFZN0YyZkRCeXRYcGNmRjRBZ2pROGZDbURHTndsY0dSa05yNnBV?=
 =?utf-8?B?UkZFaWo1eFcxOEE4SFVvSDAzWnA2MmF1bmpodUtKVFlkQUY2NGJ1di9QYVMw?=
 =?utf-8?B?R1FiR2JWUXdpaURqc3dVR1VMTTZNQkZQYkt1WEx2STFNOXVxZjlyVG5GU3Vm?=
 =?utf-8?B?UmpyY1RUbko5NzlYL084a0xUSEh0aUppYXIraTh4cWVLVXNaaWZTWnNSK2Zy?=
 =?utf-8?B?ZThxRWgza2lQR0dVS211K1ZxdnVFZlBCV1BmK25rTWtubi9uejZsM1B6Ni9w?=
 =?utf-8?B?NlcySzlxQnprbW9SVEh5WGltWDNML2JPWXE1QWhyQUxwOHo5UnhWOVpPaUlL?=
 =?utf-8?B?NXkrOTFmTUE4VzlCcjdmRSt6Mk45b214NXh3QTlEWnRjNnNGMTkxTHVUclZa?=
 =?utf-8?B?ZzB3YlJzTkZjeXdpRVB5TExTUWdmYVVrMDdLQjRWcTg3Y3dnMjgzNFlnelNO?=
 =?utf-8?B?T2d5cXBERWU4OE9XZm5MTGIxOUFuMDJTeGttNXZUczhyYS9WSVJVNHQzcW13?=
 =?utf-8?B?UUE9PQ==?=
X-Microsoft-Antispam-Message-Info: FZ6PMmr1vt8WBCEYIjkXx2Gys0dD2c5L7dacKL13eBSO7U3gwu5M1nhWNcb4K1mv/D5gVV9tJzpFBvC2/KZxsKANbWtnANFgkPEshx0RcxSH90kNzVtnKSTBurlWT2g5GSQSTVLDlAPMphLVRplBlOJJQN/vDvixY06cdcv9+AxxW6rWokA3MbVw0MfP3nFV
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;6:mxQaviRwYU9Ts41rw/cQjyorkqMoHKFTZCGGTywhs2KyL/1rn0uBfu3Zv/vflX7d3QC5rOJgmpnFHQfMQPr+8kRXwC1aPuKmbHgjvXKFr6wgyQ6Os/TJR9laTCNMfqbXBxVaKOJAyelcTkG9p9jkv57Cz+13EfuIuGOavtZlReuucIEoLseUZvzX2TqXcYjaQv9+1EDmKdOfdUC6uqguHEkZ5VNjOj2/qR6bZ85DPoa/RAbuMtoxblzih5qBCucAaTBsfiVPcMLCjzz6Ee7bZo6TuDpFSPdeJjMYILny4dsB+o65DeYmAW8L2u6KZVtcX9VU3/QCxVmqu9tcOobLUgAIzMbDwB4UKC4APpcjghcmblvZqQjIT5Bnc/UjoLRKMFqVTyhTZsKKpF5b9EXsRZxGZq5+mlGVmFqBqwYp/+2KWPXUh6L8J15pK9L4i+PkJ43INJfBWLiCbLN76GR9Zw==;5:4+VDB8YdC2IY9pIgx+HJhEAng+aJoic7dPG9wmWwbdplIi958V2xv/3doFhpaDw5RCcBmCof5SFdFPq/6viVrHyuY2NvXUhVvLMSgPamLDMs9NIW4zz+puplNkZzj3eCCZzc7Wig+jyeXr6NY836ccJKVAXRf27p1Hi0SlTzCwM=;24:4Ri3BJ31djDej01XvMSkquAS7p26T/YgQOxODRO3V833q8M79bLxErY5sNc1RmjMXNXkNkt5xlkZbCAchyrmMJryym/m5ODRZ4WsMNdLO1g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;7:lauzgjXTfobKOI+n0rjexCRi6cu717K/HKj6hoyJJU3UFo4qEJJrYlef3ts9GtiznMmNuUxgYDncfYDTdaJgqnbibg6ciFnvKPp3nP2SHwhug8NQgioV+3SqXNsHiNFFjcVb6iglUndFApPJTJKMAwd4y8vPYwT0O7ktRlSELH67PVjebfh8VB5wrxxsth2FbnhuDy0HsCO+rDJvR3sdf0T+NeA864JLZr2afk8Diaj/BtBlYCYxVN3xwRxWRaFE;20:aP1/6aZH3e0hvYNaqbx2XtkaDPl544P7dbXya0YVEJD1TaQqqyfepboTi+GLuFXVkEjkD0Ym0gp8Lmq5Hxqlr/dfl9sP70HOR9VH5bghC87R1fM/IOsn+xifp75LH64+ysKB+tetd9BUzlT9pmKGvAw7q5i4TtAk2PMN8RLkgSQbYnI61VoerhRSlWrUhCmHNimxkANS6UFvKWNlPETrvqk7sSweqFFxc4Y+N0d2N/eTOhvQW3Dp5gRIPkT6KxuU
X-MS-Office365-Filtering-Correlation-Id: 8195d6ac-ae5c-40b6-35a5-08d5a489cee8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 17:36:52.3623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8195d6ac-ae5c-40b6-35a5-08d5a489cee8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0693
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/2018 7:55 PM, Mehta, Sohil wrote:
> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>   
>>   
>> +struct dentry *iommu_debugfs_setup(void)
>> +{
>> +	if (!debugfs_initialized())
> 
> This check is probably not needed.

Ah, so it isn't. Thank you.

> 
>> +		return NULL;
>> +
>> +	if (!iommu_debugfs_dir)
>> +		iommu_debugfs_dir = debugfs_create_dir("iommu",
>> NULL);
>> +
>> +	if (iommu_debugfs_dir)
>> +		pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN
>> ENABLED IN THIS KERNEL\n");
>> +
> 
> As this gets called for each IOMMU, do you want to use pr_warn_once?

That works, yes.

> 
>> +	return iommu_debugfs_dir;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
> 
> -Sohil
> 
