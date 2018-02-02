Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeBBX1C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:27:02 -0500
Received: from mail-bn3nam01on0070.outbound.protection.outlook.com ([104.47.33.70]:10112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751669AbeBBX0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:26:51 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
Subject: Re: [PATCH v4 3/3] x86/kvm: Expose AMD Core Perf Extension flag to
 guests
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
        Len Brown <len.brown@intel.com>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>
References: <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
 <201802030310.MucL4Uiq%fengguang.wu@intel.com>
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Message-ID: <49f7c379-87e9-bf01-1590-63dcd7726d7d@amd.com>
Date: Fri, 2 Feb 2018 17:26:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201802030310.MucL4Uiq%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR12CA0042.namprd12.prod.outlook.com (10.172.49.28) To
 BN6PR12MB1363.namprd12.prod.outlook.com (10.168.228.21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69d07e73-8239-4856-665a-08d56a946f04
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1363;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1363;3:Rr3lN5mwkO5RKX/ba5EMfRaDsCP4LDX3oj0tDJAnAwWd1hsL81ZfG47MAKFM6IqOdTeZmqEvlIpi592yD3TMdJjkN4kDPJxpDyXZZTaNIyorD+5Kh1OFQSpVlGNf8w/jqCAzULtYhjYGnUqpErQ6RuprAHcktN+zqxrXAEn2fWKpGZ3hStBrtOJS2rmHBbZwrTEP94gRs42UtV1GXCvD2YQWmCUzE0RhNG332CQ09GyIyAginoLFc3uKjdGhHJDF;25:AvdNbG/SHvRFOgdcpRyEOS117AwvWJvSIIpyHDKzWKyzq9f5pyTfsxqiw6/dCmNv8VMvGW0l0wvGSsuwXwUvTgL3IEO96l8IWWxH+RKu2Yd2W2xYofA9gaIN5PS1/1NHe5e5a7HuiIAA/adcjWR2TUpHK3eeiCf0YJMEAn2H+OhODS7hUUGX0aSJOaE9HR4AyA9KmhJIz85uTgnb1daJ2d5OexvxiPF/CQ6vWfmCys/GBSL396I8IPnp+forOlHZOvOMZ2KLNOW2eVMrXcPIfOhVNDehz3Gub30V/FTb3GS0hh11FddE8mCZr1UZG2pxHfVEov896hJbJgJ3OvDOOQ==;31:+yHy3lTCPmGvaxWGMIpLl5WHYQZ/r0DK7maEulcLNHL/mv0krYONwmpgL6E1ABIvfCWAD6Dm+i9xgNHu9iy8xtgFljrovuf8n8V67Qr0IL1D0ZOgEdAfoIjE+u90UqvLY78QPzpr01wYFx4XeOfGWXYqhbKO6vB0mV+BZWAKd50WeMp+nQKiNROgf3kf9v1dbuLvqDS+KIbHmn0A2Jblh7cYvuhhrDwO88kC1/9TSjg=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1363:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1363;20:z/zRYIKz6DezB7InEr/TS7HptPhLezaH4I2WosIKIIedITjk73+3VQk0f95htLg+1nucw0UZxRchsIA6LxG4GCjgfBTDpoYwidbLdVOmDsEeAHnK4ukZt6WjOa+I08rjdMun2kxOnz/94/HWWo/ISxEBS84+taqjK/yweDTyC1GffL0Jdh5ZbRZgtwk7taesdbF8qE8Z+6py92bYFRbeQhNbc2G45+apVy9eKs6aBKdYyKU3Zz/tix8Q973sAPtPf1qptoxTv3UOyuzWkibtv/S/xSLm3N0G7lH9zUOb7a1P4n9IukmPXHtoqmIdfh8gCZipyVoOI2q4DPXVv7BO1mCajOitJ86e6aUhFKW6veGwZBjHrtNWkXry7XWSmoK0K+9Kw50sXIkOAjaa0/9KEmRXtBmBnE2diFv8oTG9ABx0NCwbUotPVHJtc0LcruUmD59GDxCvIxpk/0xsVgJr/JzzBnuKMrzid+XFiqqAJrqI0lIG2IxD1o3uctAqlKRn;4:SK6XxBurIaXmI0p4sazmNpghDigDr5BBeHDG0fMqFM0bVltgNa36EOG1M2+C2uvJELkkEZL+JNJfdloG+Z3Ou3smIyMq4iwEuI+Jqqza7FqD+7mvxrxQswLvw6DOWO2ofRYbiZDuDGYsm15pvp5ZcZscUQ/TfiLmfsAb+Z6L9OYIVyJv7MWllxM97FTam7gbRRVQTdd1gLTfcUeRfsqC/GYUjWQ+I+4HFoNzlqT/+lUYfO9S7ckoBNS2NwnzkpAxQlu+lFuxzHEEuQb/xjhVyjbCPyFn4gBgxMUzKlf9u2wYXO6y/7j/JxNR6PQdf9tdG0ovLk2DutIP+3w4fR1l62RblRMcTYvSTspWZn9HplQ=
X-Microsoft-Antispam-PRVS: <BN6PR12MB13639B675A6518A5E6611BBAE7F90@BN6PR12MB1363.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(162533806227266);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1363;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1363;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(39380400002)(376002)(346002)(396003)(199004)(189003)(386003)(67846002)(25786009)(230700001)(53936002)(52116002)(90366009)(86362001)(6916009)(5660300001)(50466002)(16576012)(54906003)(31686004)(72206003)(36756003)(47776003)(186003)(2486003)(65806001)(68736007)(478600001)(345774005)(52146003)(106356001)(58126008)(65826007)(966005)(77096007)(16526019)(65956001)(26005)(23676004)(66066001)(4326008)(64126003)(8676002)(229853002)(81156014)(59450400001)(97736004)(6246003)(105586002)(6666003)(81166006)(8936002)(76176011)(6306002)(83506002)(31696002)(7416002)(7736002)(305945005)(2906002)(316002)(53546011)(6116002)(2950100002)(6486002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1363;H:[10.236.18.253];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMzYzOzIzOnJ3bDVQdVNOZnZyODNLVTNaRjBVanBHQkFm?=
 =?utf-8?B?UHpQTWhkazlVL1dwTjZMNXg5UUg4NGlwSVA3NDIyak5DMFRzOXp1WmdPM0E2?=
 =?utf-8?B?TWFhdU1lYlRTZXlyV2JnSGNnc2Y1SCtINTNLQkhGbUZIWXNxdUlmdUFHdW1T?=
 =?utf-8?B?L1VXUklJWjZDWjlpdmJ5V0RTdUNwVlB5NTg4bFpWWUY4a1MxY3J3RGZNTG9a?=
 =?utf-8?B?K1lXankySkQxbmIwbnBpWFNyQ1NrK2E4bHRMY3pKa0FIZXZWYU53UmNDZyt0?=
 =?utf-8?B?aGd5c1BTV2oveXFvdHQ1Rk5KUWxWRDQ0dGFLOVlQNVdKS01Cb3UvbVZDc3c2?=
 =?utf-8?B?RjNPL2ZzZDd6dE5ZNkFxWnNlZzhlUWNYdENjOGdDQ0x0MHlFN3ZEYXMrd2Fn?=
 =?utf-8?B?Tkk1enJ2RUUvLzRNc3lyaEpwMmQyODc1TnNBRFcySG1qK2JUVkc3UkVPMjdn?=
 =?utf-8?B?VVZWaFduK1hzaTFYU0EzYUFmeDhCMmxMNXk5THNKM2VMaVQvUXB5eUVWUnUr?=
 =?utf-8?B?Lyt2N0pkMGFGRFdJUG1aSjJ6dHZjYjRHVktYRWNsbzVlT2pwTVdIUXd3NFhO?=
 =?utf-8?B?US9OcUFSSm5VM3ZjMlFvZytYTkVaWWNWYWt5SFlVT3ZyMHpQY3RVY0ZJQjRN?=
 =?utf-8?B?dFZzNWxRUnNVL3RJUHB2c0xDUXdBNU1mRktGeVJkT3plWjNSeDdUazZHall3?=
 =?utf-8?B?aVA1K3NuMHZYZWI4SVVCMDF3UFE4YVhCSEZpUitqdHNkdGhZZ1dLSzI1dG4x?=
 =?utf-8?B?M2RodGNEZDM0OG9Ib1ZCU3NaYnFJRFcvUE9ncXY5bnNRSmlSM0U0WEQ5NDdq?=
 =?utf-8?B?NU9iNll4bXRKdVBENDUrbHA0ZVJYWSszdEZPZjNKRG1CcVo1SUoxZ3Rickll?=
 =?utf-8?B?cVlQRDhJVUg1VC9ROW9wOHlnZUp1eXpOQUZta2FyUzJXSDF0bVRQTWYySnVi?=
 =?utf-8?B?Um9pdEJQbktHamw4QjF4QlVZSEhWQW5lL2VVM1N5UzhPNjFvNlp3ZG9kVWIz?=
 =?utf-8?B?M3FtVkRLUjlzQ3RqeVhjdjlyYTRwWmZkQ1F2VGRrVU8vZnMxcjRHOGFGMDR0?=
 =?utf-8?B?N2pLTnNKQkNONk5LNDVBUEJ3eTBNOHp3OTdvRnhnN0x3b1VLSDVSVWZIMWlq?=
 =?utf-8?B?L25FcW9XYTVGMFdJSUx0QW9mQnNpUGRXS1lBZ2NKYi9PbzVjWW4ycm1OY2hS?=
 =?utf-8?B?R3ZNVEp1dEVydkpSVFhiRFl0OVdwZTBUM2dudUhRTFdZdzlwZjBsOEt6NmNG?=
 =?utf-8?B?VFdpTzV5dXltMFVzTXk0azZBaEJUVjg0cDdnQU5HcEI3aXYvWFZRS3RnZXcv?=
 =?utf-8?B?SXJKa2M3OU44cHNhVnpIbTVaZ2txeE1wbnMrSk83T0p1bi9nNUpJaFNQN2ox?=
 =?utf-8?B?ZC9uaTd5UGtFMm85UitNbFhwRmxyampmT3ZJRElKOGNjZ2lFRDMvdStHOVRU?=
 =?utf-8?B?NWNEREN2TDV1M3RFNVB0aVNudUpsWVVJYk9Uc25YMUVpbGNqVUViZW1pMnpG?=
 =?utf-8?B?RWhyM3pCSXRzTHpwcGJ3NVJQL2dBMzFGdEV3ZWZ5Zm9Wd2JmTzV2UDFUUXd5?=
 =?utf-8?B?YXdIeElHVzZleDlaeFJtOGpHc1Q2VVlZcjhOT2EwS1VmNW90U1hkbUlNYkRy?=
 =?utf-8?B?TlNjY3VRR1RLeC84Y2V0b0hqalVYMEF3bnNmY29BcXFib2E5MVl1SGZqc3JO?=
 =?utf-8?B?aWplNlVSYTlONGpCVWRqT2FUNUN2L09mSWx2OVBlNFFIdXMrTlFRek5BNnVT?=
 =?utf-8?B?Y2ZOTEpJU2djKzBWR21yUTFoZGwxZUo2dHQ1KzkxemJ1UEl6aytQSGoyVWpr?=
 =?utf-8?B?UW1EZ25qdVI1RVVVS2lwc0tScXJpTU1iOS9TRk13N3NNNHh0WkM4anQ4VTJY?=
 =?utf-8?B?YlNqZTZlbDBZbVU0bEZuOHdMWmJOWFpNOFdBRENGRXMwRTFSN3dQR2FyOXJ4?=
 =?utf-8?B?c1g1Q2FuU25MQ0t0bzFMam5UbDk3anYwelh3UktpbFI2WFpVb3kvUkZCNHZ2?=
 =?utf-8?B?Rmo5SlArNU4vV25JRkZHMTg5TUdvNHZuMmpwUTdPQ3JrY3BQaGt5bUNtZ1ph?=
 =?utf-8?B?N2w2b1orMm1mbkMyUG41K0V1YWsya2d1eHlJRm5vZlBqM3gxaC9vQmJHb0p6?=
 =?utf-8?B?SEE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1363;6:txyCW7BsWE596EIZafFDXBzDEUsDvPaxjFMZaqdqXRRKjHn2SSRB0ygeTwGRaJa30eOSYsEoY5OQobs6aOLRVkGgcLwey3zBHfte0Ua40xCbgBb+0ihPIStgO3WhZPnNsfrqQx3zQsZbCA7pEcqBV8QfSGP0rMtATRaAN7LOWdC8QzwrOV6iaHFu1nxDScAsbkkkI069iAmyK5ZLpkGvnqrkfSTkeV2jL9Ugm/MC/W5GAO+9WBQbiZ87dSI8TctV1L61/uvXEsazpkiayA4NQCyx7ytJpembA3si+P3fjx7X90ApYV69Phb+XJpmay5NykGRJkYFDDyqemrVAxeL5ZLc1+ekO0P1uaadZtWaljk=;5:CG/rFKiB7OMbudAYZGE1bQ+DjeixybNBF1eURGaA9NDk8P0J93b7uCPUUBBltn2OI8lAT4LjOTyAlg0f6sdGrJmTHWRNkHremXrARKy+zvWj0PI/YZipbYSvfVzEeB50WbkG6LI8uTm94hQVKiH/65TvQYtjHuhLNszxgVNVDqc=;24:nxUzV5qecw2Zvc0LPagvBimvqc03f8mt3/jNw1LNdoJ3q21NkKZeTcoqdaWz7/NQi5lugI5rQZnO1dptSsOy7EV6PxSmsRG0eFSSMVcJGyI=;7:bZhv6gq3jsMj+KAgMOwUoN4ftgmeaDR/XImB9LNQmE/NvVacxA9VRapGxe/rgdpNNI9RSyVqXzZig+yQO1P8wdQ0wG25EOCTJ883g6ovriWnFFhboqiJXviNb450ZjwJ7lnnAsGluLPgSrHN5COyKo9ZCcgIYf+RlGiOIr7ngSRa5+4HGZ2iSgyKB4vw/GSDNzdLYTVLYILvUjEyLj8SGxnpUo00YKuWDd+kEmBy3rDES5NQRsDw/HoBujevvL0g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1363;20:3HHG7e7No8fJkDC/sOJb0YvSwSfeFpbHSCGVK7h3Ko5adh5y9E3pV5lTRXXGQq+euo0kAbbPibqU2SSTdNWuySf0kHkv2H0xFQTBMqC0mRHiZ70fIyTF4HGTYE+M0Y2XMpcxQOsKkCVCW/APw+AEizzbhCn3mjHp2dnmvB4mJk+K22FMR7w9fEIiCB2Tvcpw/GCrPpvxUnkD1UIexPcF0R7fBk+YtyHkxIvpY+MmLGBy9Cfhy3NXpRo8L7dFGZ6h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 23:26:47.0477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d07e73-8239-4856-665a-08d56a946f04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1363
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/2018 2:03 PM, kbuild test robot wrote:
> Hi Janakarajan,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on tip/x86/core]
> [also build test WARNING on v4.15]
> [cannot apply to kvm/linux-next next-20180202]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
This patch uses functions defined in commit 
'd6321d493319bfd406c484e8359c6101cbda39d3 KVM: x86: generalize 
guest_cpuid_has_ helpers'.
https://lkml.org/lkml/2017/8/2/811
>
> url:    https://github.com/0day-ci/linux/commits/Janakarajan-Natarajan/Support-Perf-Extensions-on-AMD-KVM-guests/20180202-231344
> reproduce:
>          # apt-get install sparse
>          make ARCH=x86_64 allmodconfig
>          make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> arch/x86/kvm/cpuid.c:58:6: sparse: symbol 'perf_ext_supported' was not declared. Should it be
> Please review and possibly fold the followup patch.
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
