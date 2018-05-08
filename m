Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754740AbeEHRIe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:08:34 -0400
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:10238
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754099AbeEHRId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:08:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v5 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
To: kbuild test robot <lkp@intel.com>, Gary R Hook <gary.hook@amd.com>
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152572332370.3235.16541462864315443906.stgit@sosxen2.amd.com>
 <201805080700.Jm8moLQz%fengguang.wu@intel.com>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <a9600652-f087-5d8f-ff0b-80200d570591@amd.com>
Date: Tue, 8 May 2018 12:08:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201805080700.Jm8moLQz%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR0601CA0079.namprd06.prod.outlook.com
 (2603:10b6:910:88::20) To CY4PR12MB1446.namprd12.prod.outlook.com
 (2603:10b6:910:f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1446;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;3:vwOHtvo6mNqeKAwcp9rSiwE7y+AnY8yPuCPFhLYv17OUjk1dnj5yhS1AyKxnc088nRn6//9kmXUE/MMReAPBNgWeDYRE0UtRD+zBP1idi68D27xmrD4ePR5zc2xM4qpXkofBp56y4oL2AWr1UoMRBFASMSY44E/j3uZoxM9jYkgxoY9awLdaCRiuGOMtU6PHolaIWkE0lSGlCGrM4YNWEfpsayagZxHOA6nDzW47mBi1jWdiiT1elqW1Pxz91XI3;25:g2Usuy/dZh1jDBMXJAr6NBtamQdPf/kpm0vXMy7tF1vATevPNrNqosZSRcABY0/dCcwHc4t2dUuKbdp5A6d5VnP+OG8iBF84jG3vpaT8GE1OrYESzNhJwqWjL5ShtEK1h+iH3crlPnLmcXK5OANWDGHeBLAcRbPyUrEo1+QuOMqN9AIXOzSgztPh0Vfjy/v4fqJWPhAa8+bhQE8yb6FFbBgfpk5jO0XFB8N29mZRE+CFyitZiOoeFVUT7+JOvqhhYrAX4FlD/WRcehL152tx0Ds1xQq0QWOJdLHZS85qtS/6h1OQvfW2eCxxDUp2sQjpT2XL8V0kQ+nY3TLpUNe8FQ==;31:piQ+NziybK7xRTLZ5Xxjf8ivN12Z6Pik75/7UYQC3r2y0oYY1zWJF15D6M4IozT7r0SbIKvBjOaDL0w4NhxpjzYd1domjrvvQFyjgBDWZO1wpbaE2FViZ4VPp0wmG1KVIohWE23IiLU3ci43MxPp4vzrbZ8nO5cyu+VoFYyBuboBirpp2u4cNgHGDUJPsSGi0g6V1y+0eRRpMGg68SdqvMFgCuTd2rlE8JmtKEr7YQo=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1446:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;20:rnKVEsoDf9gI3eget0o+aqUi6LJa3972slkuH9ph5tMguLjOJFYzclzd8rQPxwA5+5bL3U3JQXkN1g4eVRhuPw0oGpJMApJ69jPYU9ZEbVk3lTrWZNywMqq6LA2ozApW4nprwOG/NFIJgZGR1HwtTnEcvR5IkM593Z4vF2RWItmootDFjBcd0sdCYc4sjYHep72PU1NojlWr/R1lJk/XOInNfBapKsgOLlySs0dYuL1TUDQA/s2kwRjzUvrCHGCeQWeq5AAQDKcDcWKu4EHZZ3dMebamRgil1BzCOwqv0Url/A2NTyop1odhl81/48WaoAGNGPAkMoHkPBVcBXRWfreJJ7oAw/GygnUoQ2swaUSsGY5tdfD6anRYgIcppmjsyIHRH+54CBpew27i38/ZKYG0/72oF+dlfdRpijYMF3A3vYyQfy7mAQ6eMfft6YoYPn4vN4hbqqKhfS10tyT05HB28G6RkON72q3Ait9c57xishhhq+veaZMqSGSKzQAL;4:MIouCHgJ6ddPNaU738EIi6flAu5Fmik2s3pZDzCURypaxW1Bfa6VC3HK1AySbj0Bc3ztUKDXIcswgqK6inNM0b6zWZGzQ4iBkOKcx47SuVeVvtMmfKCm3dILghSFj4vjvZ/+HDT1DdF+yiNjkNCYLvHvJUMGJui1ycmKu8lXH1eE/47S4aClxFxTuaM1JY/jC9MAMrQcWiMmvr/5MKldoOG9vJP0Ipmxc3Vpj3Ro43wFA38DIKM4+WbQzzVodHXGy3edkXapN3aYrrT3gpisOUDzMJPCTf2De5nE/m/hpgNZWtWwrS/X9S/tVdQFxngbtIa1NjgL6wogS0mRUfTJoEbI+Ir13Vg23R3On0xz8NY=
X-Microsoft-Antispam-PRVS: <CY4PR12MB144617C31596D36EC5C9EDA0FD9A0@CY4PR12MB1446.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1446;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1446;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39380400002)(39860400002)(366004)(346002)(396003)(189003)(199004)(106356001)(77096007)(53936002)(26005)(105586002)(65806001)(65956001)(110136005)(6666003)(6486002)(6246003)(478600001)(72206003)(66066001)(229853002)(966005)(47776003)(186003)(316002)(52116002)(31686004)(6636002)(16576012)(16526019)(6306002)(58126008)(7736002)(23746002)(305945005)(67846002)(8936002)(76176011)(8676002)(64126003)(68736007)(345774005)(59450400001)(97736004)(2906002)(31696002)(53546011)(3260700006)(386003)(25786009)(36756003)(6116002)(446003)(3846002)(5890100001)(5660300001)(230700001)(4326008)(486006)(476003)(81166006)(81156014)(2616005)(50466002)(956004)(11346002)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1446;H:[10.236.18.126];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR12MB1446;23:259fHr6kN8Y9Tm8Y0jDn+acmt22yD3iu9wRsM?=
 =?Windows-1252?Q?47Vv5BEwlJHzo6j9a2jTxvXjXWtDj/gvWcIhxp3bcgqvqD9XWKM9OxEG?=
 =?Windows-1252?Q?sXJAsLOaNtViiFk6bqsSBAuRnsbfsrJEnllkOXGdaKnuW8tJpQD1TA7a?=
 =?Windows-1252?Q?SwxlgwaP7xC+0prPIFCH+XZBnzNZqRHUDYbyOKBE+aQVagzz5wkwMuLj?=
 =?Windows-1252?Q?v/Lov2uxJxTiKj6InFKdPcCKrzu25UNZ9rTAEIet8oFOGhP1PshyvXX1?=
 =?Windows-1252?Q?Ed+LY0JKIfOmuK5QXjqjbqpyJAMXtD50aJrHiNNA8QFKi6m1dqpnpir0?=
 =?Windows-1252?Q?Lz3bGfdISuarNwFqsfiWRb2fffcpIQTBTH488Hw6EqxcHHshworJBnzW?=
 =?Windows-1252?Q?0h6GDIFukYbx8AgLuYYhqMq5KsuV9F8Tre5YAqxIdZ0+qwa7RlQJ0rNf?=
 =?Windows-1252?Q?rpWcdUa7/KJg3ELIo+VMF0nncdM9N9LLN4Gr3GP7B/REL1CQszouUw5Z?=
 =?Windows-1252?Q?8XMF6CjRA8zWcgYgLpjnhxi9cGQ4eyyebT4oiwjZNryJfQuXB/tYPXxl?=
 =?Windows-1252?Q?IQ2+QDm1W9rmClOOXxkolyu7hcGH5OE9GtvBYCnVNmU59VPq41eoCWBj?=
 =?Windows-1252?Q?Os2UewfwOSp1wr6/h050zQAiDvYaN5bu7FVpHa0WvBNvG8l4TAbNUQBl?=
 =?Windows-1252?Q?q+ZyVcvzhgdicny+J/TiJJ79gNprqkHnR0R0vqKJ522c/L3vEqEr6ice?=
 =?Windows-1252?Q?fOtlaBivoJngjCelNAKzrobn8sqxa+QPo5koesLysAgdWIsOYeqgWbLF?=
 =?Windows-1252?Q?R5eJJZstnVqUX0lpDzj09BAuFKzsktEg64+aWcBSpGDxKuLX4ILXjfGL?=
 =?Windows-1252?Q?USIoyXolGs2DP7wP1lVlQ6a+oktdhVx5BaHWJMMLEnMK2LyOMjJYAGSC?=
 =?Windows-1252?Q?ZOzeJcLKl2XarB4zvls9L/AthesvA7nuxVq4WDHk3XgRFrQMyTD1tO1l?=
 =?Windows-1252?Q?ESa5bldGavtp2my3si/KdWIelg7ZoPKLGRrhr2En+tEYsuF4+qNE5NYT?=
 =?Windows-1252?Q?ZHLH9QAQI1r40GLsN/pgU7kFOU3t39jxnxgkqMuKqmBr/yTozm+n6qwH?=
 =?Windows-1252?Q?KV1k3Shk8USuViH1KOFEjNbSMt6KVO9I82bCwDLvEAl75G95tMJwlNJq?=
 =?Windows-1252?Q?BbDO8Bns20zFK+N5jJqSw1ReNVNlY35YOG4JD7/q30SU+g2p97a4e2/h?=
 =?Windows-1252?Q?8BYqk27xCvhAvgbAzBnQgosy875WFFVLO8HtOJRmdt5N4wqhRnhqtaSr?=
 =?Windows-1252?Q?sykt4rQGg8lcOKSTQ7SGfCaPAOqTI5O4g/UgdKuLGzsUc6e6wEo/KZGn?=
 =?Windows-1252?Q?ascxZhkkCdrXb+Zj/vuYjCfgJuoD3WNRoDJFOfF5gNcaubfnIc2Fs6NR?=
 =?Windows-1252?Q?GF5aS8pC2sn0xQ8stjrOGp9JnlGrW142kn6JFyBKLpQTCr0BJl8U8oni?=
 =?Windows-1252?Q?YoZZuOzAZQ59CfX9F7POanQxAwWZTLhlWOjScwESxvzbRTsDlxDTwYcT?=
 =?Windows-1252?Q?2xnFv3rVGmlbxfy9TwHKMVXkyEF5kmnX9qsWj1U0GNkh6Ze2q8Erl/Qz?=
 =?Windows-1252?Q?GuHjBquQjFxsLaSzPLyoLO+TK9iAyZGxS3wwB+mSKqm6iZeXX2nH+NCE?=
 =?Windows-1252?Q?/6Fn/j3yQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: i6Yf6+ecoKQLQFbBIA2kyuG05wPu/eGeUOCwF4rDkl9+qNnBZVvO8R9B28AvaJ2Id8u2550kV1B1ETX7K9QFIAlKALBbwLR2S6XOFaYLFuB1YAvgFR95QvHsud3yiQSt1txKgntotfQRA4rlAlqNoTmjX1zKnKLEoq3z21iC5XPRfUAin/VM7OCNaV8VCHTi
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;6:VNFFe8YHQSniZZUa1gbkRgmiNgg9HtsBl0Jwm7k5Usu9hjaOMP9DOxx1LWLSZGbM3KpZR8F3UfKpKa+9lcuiES8hExziEwVaPXPOVEfViel/rNgnfh0kZol+qLs8LLBkJxARnkXZdeSMMdBTRxKE5b2TzwX9/+B6pe+tSs/DejTy9miHF34UVFFD7+e8C7ugLMpwvijSxfU5B8cWUiaalcgMk1c7G9kxpeHe53a0sbdtr21dlVQzIMU2Oc58BqG6e5NjVAGuP/iSJOjIqwhTe7tolfYEYueVK5YFTk9FFijlXYIKdvCDay4sdXFj90pmTzmPVkjTTUisywc9ciba3LrZTOknDBny88Wq8I6G7vG7GW5umqF+mnjWzpogWzPhumZ9FskxUHBYvrh7V5r2kS2P6WTn1KXL8pPqgmHtDWyO+b2p1f1W2VexgoKVsD0Fzx3FqsHBcOgKjWDOG203RA==;5:v9SwhVnCu5sxVoyKXa6OCesLUCfWp7LAzXbjayBGYWfuF9JxhuHUaPwzDbas7pXU2UEYEALT0O3RVMNf4tMnv5482Ijb4Uye/h1DntwzSROoPbjw2gApXxcpP3yCydNbEc+M+zhfHDxpoftJYSwV+g4qArMcwkufUx55fmbx+r4=;24:o8jyDezIzkk5rBrPTurQJIbRSk5UgjdEAO+Yd28FH1IIHPhgE1/4C8S7CSt/vJEzG1bHzosJTCTLEm1B1Cp/qPVwNK76nnJVVsKCCvog/wE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;7:AyeGVYSVg/duE37kCB9vmdhUKZSvcEqh2EE7g0fZp/jT6GnbfJ4qBXdfUq1Aqrkl5ynGDpm5QvFd5JnqJqFLe/jBSJf+Q3kuds1NZHjNOO+FuXgwvB5Es8UoThTF9fGAN8LDtJTqpulfTNQEsFcPkXcn9ppN/c7hrOFANQRi01hPdzDm5ipOrsg8mK9koDKh6EWL6r1mqo8yCj7r+C82rDBOshH8A76e7knVhJmyWK/sCrntIEdHJZLKSEfeWGSd;20:J3g2ZlPVYkrTghEtKTaavzk5+845TXbOnL/ryfo3YlUkQzHYeEJyk0co/wnsSP+oq5v/Fb+LqWZEvNSP1MGS1twxZzYPibvpTncbOB4I6+zV3YB1l0PjKRFGhMCi0Cb711CIb+B//fQEG45V8LwjviP61wLnwXJQbwLGmt90atEgAYbWAz0ccK248AUqsj6ZKwzcwCL/+DxGE+4q6UzQ1IyaVFK4+S7rbM8OBfcwUZVg3bbUe+//Dz0I3YPJQPuA
X-MS-Office365-Filtering-Correlation-Id: 419a21fe-db22-4676-fba3-08d5b5065326
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 17:08:30.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 419a21fe-db22-4676-fba3-08d5b5065326
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1446
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/2018 6:47 PM, kbuild test robot wrote:
> Hi Gary,
> 

I imagine these questions have been asked before, so I'll ask for
forgiveness up front.


> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on iommu/next]
> [also build test ERROR on v4.17-rc4 next-20180507]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Gary-R-Hook/iommu-Enable-debugfs-exposure-of-IOMMU-driver-internals/20180508-062918
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: x86_64-randconfig-x016-201818 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64

Is the gcc 7 compiler now a requirement to build the kernel? Or only to 
run krobot tests?

Is this the earliest version of the compiler that can be used? I'm still 
using 4.8 and 5.4, which seems to suffice for the kernel.

Googling about this has been fruitless.

> 
> All error/warnings (new ones prefixed by >>):
> 
>     In file included from include/linux/intel-iommu.h:32:0,
>                      from drivers/gpu/drm/i915/i915_drv.h:41,
>                      from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
>     include/linux/iommu.h: In function 'iommu_debugfs_new_driver_dir':
>>> include/linux/iommu.h:706:8: error: parameter name omitted
>      struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>             ^~~~~~
>     In file included from include/linux/intel-iommu.h:32:0,
>                      from drivers/gpu/drm/i915/i915_drv.h:41,
>                      from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
>>> include/linux/iommu.h:706:8: warning: control reaches end of non-void function [-Wreturn-type]
>      struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>             ^~~~~~
> 
> vim +706 include/linux/iommu.h
> 
>     700	
>     701	#ifdef CONFIG_IOMMU_DEBUGFS
>     702	void iommu_debugfs_setup(void);
>     703	struct dentry *iommu_debugfs_new_driver_dir(char *);
>     704	#else
>     705	static inline void iommu_debugfs_setup(void) {}
>   > 706	struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>     707	#endif
>     708	

I have no problems with adding parameter names. But 
scripts/checkpatch.pl doesn't seem to check for this, nor require it. 
Should checkpatch be updated?
