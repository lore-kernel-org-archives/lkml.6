Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeDLSWq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:22:46 -0400
Received: from mx143.netapp.com ([216.240.21.24]:32343 "EHLO mx143.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753128AbeDLSWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:22:44 -0400
X-IronPort-AV: E=Sophos;i="5.48,443,1517904000";
   d="scan'208";a="252816183"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com;
Subject: Re: [GIT PULL] Please pull NFS client updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <176ac3d9-dc2a-0a90-b41a-eb8b5cf006f5@gmail.com>
 <0ab8f251-0df3-558c-6c27-9c1a813dcfd4@Netapp.com>
 <CA+55aFzmAR+csQxR-M=MZhUd=1XqOjOcmPWjq_5iGcW_r7YDXA@mail.gmail.com>
From: Anna Schumaker <Anna.Schumaker@Netapp.com>
Message-ID: <705fb303-6e00-00b0-6085-574a394d44ab@Netapp.com>
Date: Thu, 12 Apr 2018 14:22:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzmAR+csQxR-M=MZhUd=1XqOjOcmPWjq_5iGcW_r7YDXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [99.9.112.69]
X-ClientProxiedBy: DM5PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:4:9d::47) To DM5PR06MB3164.namprd06.prod.outlook.com
 (2603:10b6:4:41::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR06MB3164;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3164;3:g3w7JqC66TFL1++91L3WwUlsG/etGbBMqnPwqnkZO2Dgv8Ii/AhBbPiYeKz1c1Vwv/cRRNU9eie7pyt5FNWzk8M+7nmLayqvAHE/pe2rNADG+fzjDxMoNbaPlwNFSq9Py7T3IA6Me6K8FhNqIUMlevde/bW0B8ja6s5DYVxGjrzBy0Cjm+F+4BUf7gMj7DPxDTq8Occ3OGnCL1RfO72Aym4s2kotbu4N7vxtBfnJw6szOIz0LMrXLJmbyWdUg5UI;25:t3xOw2U+fg9l0xc/F6sr2qqh1UpCJjoFmRQHLwSJXmBWx+kJbScConbLbMK7BOKBtbMfOo60+TLWJZXN1qDo3pX8OmoJ2LWKMqAu3SEYvyzd0pJ5Sv3SLLSxU0kEQt46mCjpvny+TtyfTeQAWk8w6b/cJge75o8SBvLcikYhofUP+AJ4jqo40qrshPXGLnrCI9dObCnYyHtAZkLKgcoCo1+HY50j4B2BQqEgf0JLdjPlRLXQhvzrsDFPTSKYGp+deUgNuv2i1SJFKo4nBbog3Asi6yAtMhxEUGTxcA8+xZ5cNFbf1KzUIYnr51YW7F/ksmWI5du2UGSsa6KwTv4Jyw==;31:+PU2L495TwFIdU+8AtAtXWr6yt2SJEqD2xTsOIdH9XDtpRNLnDAE2Uoj1XlNJ125K0OCF32t42rpvOZBiKadZOjx91BstmxPjaIikbqpcWIIvySu0VEbbMCLOVa00TltNEcEqc3mOX6faZyBXyQTClY7gTYYQcZLSBkRJinPseqm6khRV3kgTxNc6GmEhLE7OYkD0LFUANoeYw2R6DSL9Hi0esxaLQ7W12w6vfo8OvA=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3164:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3164;20:7B0IoSy5s/ga9g3RWOaePdpRzFcxa18jUYqT/XlnVlZUp51qeEwu39EAKmZ7AWnr6okXgR0KI7hGEQwjlRmPflwEQu6EKUqROIexVCKATI7NaEwDEKI8fVnjO+Cm6A6ZYia7vbjG9EDpvhvHfRv0R/HfeONHOPB19A86nGjGEdA7OOeNwezSxVT8MHI5U6rVkxLp62pE4MxRfLBk7NdMUNqQYPa5KuUcckOzoWhQV66WGE0eS8spJrbfWEQ9AiH08sXq8nEtajSZGP41Ja4yHSd3/cG96YgdCA5mmoZgvqtQ2HPBhAQWJfA301CSjPwI3E941Kp02pQau4VMkzAlLKDP1eeJO4vThK4bnZHjoPi4WPoyyYGOA73o3vaXgBDX8dwjznHxEkUcCfrl+muYr98X8ckAgZdf3RAodJCebngMHM6A28lg31R8jB/5tRn8uQxw64rplky17VyedMxWlnChl95TSH9QzcUhsSbvMDU7OLa4nSpd7LmMn3x6/7Lh;4:MXZtVYpIcnnSohV5pPyLtdk/5++uKM4JEnvI1I8cAnu5HM5LJjQVL/eg+z+GK5g2EpRENexz3p1v6YdKJQm0/QwTP+hloNb7lU49+PaKMN78/tPQahEhc1ygc8dXZsAziM/CrHpgDtWg0Cfeovuii0gDPqPGaG3/aSZUpX5s5cbTPV8ihv/4pWkTf2G7VfobHTeZJN+NReJDIw68N8Tcsfkt6K9ALboMKfLzFVkUh4hY4NdDR8nsHqMACIOSHvViuXK28j6GOy2M+VCyw6KM6Q==
X-Microsoft-Antispam-PRVS: <DM5PR06MB3164A0DC9D992D7E70062607F8BC0@DM5PR06MB3164.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR06MB3164;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3164;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(51914003)(189003)(199004)(59450400001)(478600001)(305945005)(86362001)(476003)(72206003)(105586002)(6506007)(81166006)(8936002)(6916009)(6666003)(386003)(81156014)(53546011)(6246003)(58126008)(6116002)(3846002)(956004)(64126003)(54906003)(106356001)(15650500001)(23676004)(50466002)(97736004)(69596002)(2486003)(316002)(52116002)(76176011)(65826007)(4326008)(6512007)(5660300001)(31696002)(229853002)(25786009)(2906002)(446003)(36756003)(52146003)(11346002)(486006)(65806001)(65956001)(31686004)(66066001)(16526019)(8676002)(53936002)(68736007)(230700001)(53416004)(26005)(186003)(7736002)(6486002)(47776003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3164;H:gouda.nowheycreamery.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMTY0OzIzOjJPRW9QaVgzTXRCY3VHQzcrbUVkZTNyVS9B?=
 =?utf-8?B?MWNycHcxa0dUbTVPWXdvT2RxMDE5TFFGVDZyOXZVcWVjbUdTVVlKeFBoL1VN?=
 =?utf-8?B?WFU2MFJwK3FaSFk1Z1hTRExaSkJJUjJmMWJBVU9SdysrNzNWNE5hYVVLeEZZ?=
 =?utf-8?B?WTRnY1VXdGVQNzB4WDI1YmUwNmVhWGl4L1FJM2lEZVZaZm83cHRXWHM2bDUz?=
 =?utf-8?B?ZVpmZjg1aXdxZnU4VXp3TVdabEJWYzRJNDVoUmJDTXhncVBDZnhSUW1BaGoz?=
 =?utf-8?B?bVJ0VklLTmhXQ050STlOUTBNUElkK3VZQVhkNWUxWU5EOHdEbGNjeVlkSU41?=
 =?utf-8?B?RTRPc1VOcWRPaktJN29xNWRTeTl3djZoS1hKNGUyckhRaGdxamtPVkdQbUZO?=
 =?utf-8?B?TW5Ud20vVjBKb0FzYkUvSWdvNHY4UDBMbE5pdC9VcDQwWHU3OUlvZFFxcDk3?=
 =?utf-8?B?V2oya04vVWJlL1VXNVdoTFB3WGdReTIrVzJWN2ltQjYrWHllQmJTSENwUTU5?=
 =?utf-8?B?SkRwbVdsRGx5MEZSUjhQYWtRYytMalJLRGhKcXJyMzhRQXJTUDBJK2FQOVB6?=
 =?utf-8?B?YjhJZ1AzclBESXFRTmx1ZjJ0aitYTWJMMERrYmduT3ZnQzNUWGN1cVZRblJ1?=
 =?utf-8?B?VGJmOCtTenBGdGdMb25NT1M2SkVBeGdTSGtMeWo0UEtDUnV5NWwwWG5wSGlD?=
 =?utf-8?B?d0Joc0s0SlRiMFN2UjRpay9HejllS2RnY1VHaXJ5bXpUbzZCZ1IrR05NalFt?=
 =?utf-8?B?dWc5dmpFdDlzbm93WUVVdGxHYzB6c1Q5bHlxc2tSb1FYQXdITFBkOVM4MXRX?=
 =?utf-8?B?dml2bW1CRVNhZFVPSlpkblllcnJpQnJZcENrNFZGdG9EOGloRjRhWjl3RUt0?=
 =?utf-8?B?YWh5WWlhdzNscFhhUENzQmFPWnI2R2grTTRXdTVFaDhubTlZamx4dVJLdkpC?=
 =?utf-8?B?R0N6L1VTMUZ4Ukh5d1JVdGlFSUNBc0pKVHRRMmpCSExhdFJ0dUo0MG5udlJz?=
 =?utf-8?B?b205ZDRQNWtlajFpemZyNE9oRVVpQzdMYUEyVUxVNEZ5UEVlczcxenk2SEpH?=
 =?utf-8?B?WENubllkMnVqdmJOSy82OW5oU2JMei8wSUtjbm5wcUpTaHdmYzdrTUptb0po?=
 =?utf-8?B?aCtGWmdOZkxJWGw5UkpTVXVLTzkvRVc2M2hMVnlKY0JMQ1lQUVlnaWFlL1g4?=
 =?utf-8?B?MnhxclRTOEtaWHdleGJZa05vbFpjeTVBbXA5RHZPM1RlM0hBVC9udERiTXFm?=
 =?utf-8?B?amN0bkxPNTBlcS9NdEVnWExEeFRsZHhIK29kZWV4Umd3QmtJVHZHTU5Ld1dC?=
 =?utf-8?B?Wm1OZm1ySjd2ZXdWZHBOcmFHanNPUWdKeGFuTUZSdURTWjQxd0FyVDZpQmI1?=
 =?utf-8?B?cmI2NklOWmhQNkhIRHhKZkxScDYwVGNIbzdjcXZORzZkUFplbkdoQklZaHcw?=
 =?utf-8?B?bFh6MUVVL21Lc2ZtY2xQL3BHVmthTk9hVkdQMEltZFBxL1VOekt0VXZHM1Y2?=
 =?utf-8?B?MGtQMUNOV2NBUVl6djhueW9QRkh0NmFPaTdabjBPdllVUUp1c3ZzSUNvcnlU?=
 =?utf-8?B?ZlhHbmZJUWlGcTY4elRQRm9qZzJza283SEJaeENlaHZvQVR5aGsyYzJydkFE?=
 =?utf-8?B?bGZiSmpVek9qNmhtWE5FVjZ2K3dBbG9WRnUrUmJ4T1FVeFh1WlMwbzBSR0lr?=
 =?utf-8?B?WWswUm1Xd1dCR2dhYkdHbFAxSW50TGc2ZS9lY2JJWTNiRUlGclNLcjF4NGtF?=
 =?utf-8?B?b0RnMFhmei9MRE9rSlg5aGVScmlNMWlKaXNkVHhSb2ZsU250eko0RFN3WVRm?=
 =?utf-8?B?MUdMVEx2YVhxWllEeHY0Y0FiWkY0RUNVSjhyWDZsS21oWCtMOXpiMXhYUjZ0?=
 =?utf-8?B?UFlSd3dsWDNXTDhuc2xWSUZtZ2ZEeUxnbklUdDZhMWJCWFRTc1M2M1ZUTTls?=
 =?utf-8?B?YW9JK2RmZ05jZ1FQQ1BvakI5aXFSNVpKUEVHMnVobVg3ZUc1K0lhb1paMlpZ?=
 =?utf-8?B?OFozMWdGRDRzWGdQelk5VlMwRWVUUTdDTkdRYmlKd1dYb2k5NXJuTVQ2Yy9V?=
 =?utf-8?B?RVZvQS9ueXNzdWZJMU8zVTJQaERWWEtCdmxndndRcm5MblE2Qnk3UDlUaWk2?=
 =?utf-8?B?dVE9PQ==?=
X-Microsoft-Antispam-Message-Info: Sdiqp9euE9rV7t4K1c/PHcPzGyP2Zn9Zp2A5hOKssvbPxrmRg6SVRrUIxdG+UKNyMHavaqq5fhU2yUtl5ZYM2IGDY3vbpE+VwUzVpEbmCsUUso6NMt5HgbTDajRFBbumH6g+2FQUHMBuF6ievGjwq8BDCcCp8Bah4sjHJBLLob/fgHYSt+0gKCPlod6WYXVv
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3164;6:FJ6C4Bu90vHR586X6ITXWZGJG3jcMPjkmTnX/oo2qkJnwKs97bZy//dG1nVjklkeiXPDnAJ1gOLhm6CWTD3iK9yvMIozuD/lfVvEtK2lIxB2rGXd0STORYqY2j2evmFr2U7HjjxSLfwSDOI750WleUMbSXSfhEVzP2K2u/ceAVD6Are99OZnJbJu+25P5A4+poCygux+9irhXFUhDUqa83OEQOXIVDIfiEoz/n+CMwF2/v2042/b75gpCyipOSSK5bKELSi6KLCDesC7KWA6h4nCJ/GCqlNwyrjhqeYMcjRS/O8H6AiX5uuFAZFWn6tED28cN71C7zzX0UrbVOeYSdKVPs1lo1u8qayMQaeyS9GtQsMIpHrZai72YjDpWK+w8xbS/oCzeicOQQTY46xHJtv7NuaXKLc/PDLaJexM3s+Bjbgsfhb3CXvo01739gHiNVY+Jz2dtRmAit4RqZmqDA==;5:va+kI70zFi+ChztowhSTJaM/bxloZz6ZWjzoMsCPcnZDWuz1npqkmAIY191K30sI2+iV3DRlxY+wh3NRLtTkxozXeXDre7tSPo1fYchudStb/pX0v/OFYa3F1aGGbCtMTStZ8ZJDKdqiGZy04QKYKLmyr9r+XoWEHA9gaYdEac4=;24:KUT9L4kjE83EF+6vx2e1S0/93hhj/bAqhOl5M5sZfCrMbjqA6fxwOmulQfsWObJ2XhdtaX04q0WR98LVYAU21tX0YdDnMjXdXIFR7l02Mjo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3164;7:DBgsQ0qFFdFmtFKNsN/rOuQsBxHh2aD95aGTDSCZeE16Rxrhg91B7AOlkcbCPIFpb0wUv6Y0zjwrP7B+VBS+W7IGhZN8YIdr/ctxrQa8Me3/bnYr3mqiqb+jj/MVesQzkqivLB1amtahHkI+5yAelmWZ7XKfzuxS48AZ9r/Kg+7CHhDA9egH20hcQPBa6J0HkNV9YhXb1WGxA8jVBsfqnfXpWPIQK2J42UsAVYvruQazOXV9MNUjkPg4sjLnovdt
X-MS-Office365-Filtering-Correlation-Id: 1fbb068a-dd34-4eb2-255f-08d5a0a260f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 18:22:41.1452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbb068a-dd34-4eb2-255f-08d5a0a260f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3164
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2018 02:19 PM, Linus Torvalds wrote:
> On Thu, Apr 12, 2018 at 11:13 AM, Anna Schumaker
> <Anna.Schumaker@netapp.com> wrote:
>> Hi Linus,
>>
>> What's the status of this?  I don't see the NFS changes in your tree yet, and I'm worried the pull request email got lost somewhere along the way.
> 
> No, it's still in my queue. I do my pulls in batches of mostly similar
> stuff, and the nfs pull just came in after I had done my last batch of
> FS pulls, so now it's waiting for the next one.
> 
> Which will be later today. In fact, I think I'm done with the "fixes"
> batch, and filesystems may be next.

That makes sense.  Thanks for the update!

Anna

> 
>                   Linus
> 
