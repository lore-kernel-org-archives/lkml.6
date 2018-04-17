Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeDQSHM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 14:07:12 -0400
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:39859
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751270AbeDQSHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 14:07:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
To: Robin Murphy <robin.murphy@arm.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
 <1523663790.2747.4.camel@intel.com>
 <10e422dd-a3ca-8ecb-50fa-e7f131a55a12@amd.com>
 <80b1e9e5-3048-391a-6d7d-adeeece1bf46@arm.com>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <e5e8c59f-ebaa-1b87-713a-ee9ab9c3b5d1@amd.com>
Date: Tue, 17 Apr 2018 14:06:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <80b1e9e5-3048-391a-6d7d-adeeece1bf46@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:3:103::26) To BY2PR12MB0694.namprd12.prod.outlook.com
 (2a01:111:e400:52df::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0694;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;3:uk4MhdI3aYELXSkLrcC2PYOr3W4GFmIW4WVf2z8H2phLCP6nHTXGAEpPSyX081yhK8sOO4OdzFjqf3gNNtLB6oJaUcABc76Z32GBPf3W5hOV6OVio+8Y27yNBLX2OuENF8mEyWVtxHHQPXcb90CgO9ujgAF/qHYEFjNmNO72CdBpT6IyytbtVP4GiUO4cB1RTRk3dh0SRDOGxqYAFp18/j/xqIckNaKU0RVXUbocKiaZ3wwduzb56SzgcOR+FoNw;25:nLYuJunhokIW0TvX81R+NBWugg0J8jI7/soDIniC4KpQm7ilDFhrnFta98BsGsfMRRZKJwSHDh5JT+VClX9AWVuxY47CXCXs+HVUbGw7cmL4hxsxaDaUFqkU2/39Fpip2z4u/S2P8ttQQRF08mp3T9Ez8xfMT3EnwRn4Gv0mmWaGxFDDU6fYviZRxBbRrVjnlajVsC6NtDhvQYJA5X7pC0/1EjwjeR4SU8GosBVAhWRRf9XOSP2NvFrP0sNO4CxMktc5W6PPwF2ZJDjKys8XI8gJMslsXYCzVeODIlAs9tJvp9UrsoRSaDerZin6cSx5dXJ3yu6VoNTDai+xr9kbjg==;31:FVQDDAQjE640q5coMSNUmBFEKGShT9eRvv+dEf3QODkui0lxtYJPiKMAJeZ5ZcjeY1ODCBLGPG2HaEu6EPE9kgku1k/EN96KrO0RfVqpZ6O/hehpbHIPoDhA3VtEfQIR4aIRr5DFTy+GkJDqA4qJ7G2g4pvN872Ym+0s9AUc2E+h4M4130s+P1yEI0HPpT6VR+xfgfEY5rE7PlGUSlfATRI2kuYtfQ7R5ph7nHjkvYI=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0694:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:RqTl0FOT9UWvcebV5p0G3QTcY7mfDLy7wHD/YnOyK68cp+NZse+nbAV2ea/dlHvuDo+JV7LTz5eF6I9Q8X8tCPgNqMeYMj40x/UUHgCyDCPk5yAFqMggnV58JGKCYJOQqE+yW6330jEzjp1DL16ZFq2+N1H77Dx8qi6o2v8PZNYrYn6rCy4B7OT53DwCHVzoD91u+VLp81M6JEoXPbMF6mxM3jdF1S1lpdTyQWniX4Ia/Abwzy+/CVIycFSwKG2NN9BpyQ4hHLU0bqfGtUREd7K+11lCyLyMPKRaoTA4Cdy/j+pN0DNU0Mopf2bbEhNYgqzpOrynxMhFwRA3PBtKpzmXm+guGIYwdivs610xfRB0sQLZ91kncd7qd7uh5vT3gYaVdpIqJ9vOb0/MrGSUsa4KZgpSyVhskIDtlWCZMY37bl0hr7nE5BrshwvVAPx01xwyxPKj0pYFy5t1HfJ5gA3m+PvNXu3Uj2gvKVsTjPk9Fon/qehZfNWi+oQQCyqg;4:2dSKwpm2o6tQDeq6u79JUZXoNO9hnAnFgi82858D4T+8BYNqHjQvTBYZ7A0Bq3CrpYFIp4FwsqwIVI4J2hPWWblG4gqOKC/COrIRBaiB2zRfrw/4Z8x0jQ9dVDqwGjnKzmNVVpSVhzy7ZwVo5pd3tCc3AKa4h4eY0+4/0JyckvlQo0b8sjk5Xz7mfax4omeMXjTOPDxvjNQQgnXmnHpvg72EVa+6HpCHgVnG9+SPvBr//c6jejBFMRC7ttQpOws12YSaFpu/JEceHiXW0eaScA==
X-Microsoft-Antispam-PRVS: <BY2PR12MB06940F560224060D4AD55F33FDB70@BY2PR12MB0694.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0694;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0694;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39860400002)(366004)(39380400002)(396003)(189003)(199004)(377424004)(486006)(36756003)(7736002)(25786009)(50466002)(4326008)(2616005)(3260700006)(956004)(72206003)(2906002)(966005)(476003)(67846002)(76176011)(52146003)(23676004)(52116002)(2486003)(8936002)(59450400001)(386003)(305945005)(53546011)(6116002)(64126003)(3846002)(81156014)(81166006)(105586002)(2201001)(478600001)(8676002)(65826007)(5660300001)(31686004)(106356001)(2501003)(31696002)(6666003)(6486002)(229853002)(316002)(16576012)(110136005)(68736007)(58126008)(77096007)(26005)(6246003)(97736004)(65956001)(66066001)(93886005)(16526019)(11346002)(446003)(186003)(6306002)(47776003)(2870700001)(53936002)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0694;H:[10.224.10.182];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk0OzIzOlNxSUxsRlpra2dWd0UzL2NaelduTkh0Q3BN?=
 =?utf-8?B?MVE4U21DTXNZZWRLb0hKQWpsOWRYZVVBYVVGQlkzcTdVWERCWGl5NXVVWFIr?=
 =?utf-8?B?aDg1TEMrbU1SajRtaXAxS1IzZ3QvSC9UdE4xWUtrOFFjYXZpODJnTUI3dWI1?=
 =?utf-8?B?TVJ6RnBNdTBnMk43ZUNXTHoyaXdxTTF4NjdiZVlBN2FaYm9haG8wT3cwNTZD?=
 =?utf-8?B?MHBoUEZFSm00YTBjU2Y1Mkc3UFduK3lVSXlUOTN3VzhMOEgrMWF3QnRIcFEv?=
 =?utf-8?B?c3FONVFOWk04OEJrWWlFQTYxdUJRVldSaHRLR3pxRndMR0M1L3BESU9Jd3pL?=
 =?utf-8?B?N2xGZ2IrT2lxN0g5WG5WbnI4c0lsSTNCVVZYOVFzMkplR24yMTE0RW0zenk3?=
 =?utf-8?B?K25wQnR5RlF6RTlMWkszb2xwTGR3aUZRNlRPWjA1TWRYcHNCTTFhWERGWDRO?=
 =?utf-8?B?K0JMWVN1UFkveE9CWWRyWjVkVkM2eGFVSXhMNlBreHB3bUYxNUZ3V3dvVG9T?=
 =?utf-8?B?enYzY2FKbTZvM0xoWFRjZ05CYU94bGozODNkSFp5UzNZTjFFc3RMODFmaG5Y?=
 =?utf-8?B?aEx0emlZTDRGYWVvMUw4R3FMeWg4V3NEbmZNVFM5blMreGtmbWVEYWRhUkM0?=
 =?utf-8?B?TVE1b3BIdzFlUkRrRjVDRnlQcXVMQTY2VitvS0dIU3A3UHc3clczQXp3cjY2?=
 =?utf-8?B?eVFOVkNxdXpNTGhMZmR4UDFhTVlISFRYa2VTUkU4UFNPbnhMYlNxcEFMdE0w?=
 =?utf-8?B?TFlpK0lFMTUzM001ZXRjdnRza1ZzNmFsdkI1b0FLKzlueXVCelNWWXdRSmhw?=
 =?utf-8?B?a1JHbzdIcElzM09zbnRSaTB5ZHNvOVlFQ1VPVGRqQUxRSGEzWEpXcU5ZeTBz?=
 =?utf-8?B?MTAyMnVjd05vMVg5SHRna2RVZ21RZVl3SkJ1Zk1YSXc1OHYyaWZ6TURPRC90?=
 =?utf-8?B?dFRWOWN4RXkwMGZUamhYK1E5QktPQnpjcjlndHZUcHFPNENtOTJmU1RoK1Jq?=
 =?utf-8?B?ZVN0bG56WmJxaUJXanRlQW91YXhkRGh3SHQ1OW5yQ20zajFaNXhCbVZwYlFQ?=
 =?utf-8?B?TVkwQkFHV1dSTDdyR0R5OU5HVllDd0NjRkEyNG1hS1FlLy8yLzV2a2Z4UnpD?=
 =?utf-8?B?V2JiV1J6ZVVMRXpWWWp4SnllbVgrUC9VeHJaUGZqeXV2ZE41cmtXbVBvS2JJ?=
 =?utf-8?B?Vzk1V2JIM0EraTJheU5uc0lzbm9ZNEhMdDVRK0FmOWhBUUF6ZkkybWJVYWJZ?=
 =?utf-8?B?eHN5aktaMlpweVdxZU9SRTVHRllvMGo1OTNGMTNJbVpVZFBrLytIakhUQmxE?=
 =?utf-8?B?L2xIV2pJblNNU095YlNqSjdybERlY0IxNCtpT0NRUlovdjBOSzJha2c0aU9L?=
 =?utf-8?B?VFB3ZU9SQnpJUHNGb0NXaEVnWFJhTktYcVpIQldwUkhPb0hWN3lSYkZhSWNV?=
 =?utf-8?B?MHNMOFkycTNOYzRyMnF2MXF0WHE4R1RxYmVBa1NCTTYyR01xM2VuOXVKVzU5?=
 =?utf-8?B?Wm1IaEZ2NzhLbTdUSXpnTk9yOVk2Y09NaDUyNGxuYlpWd25MZjJNVXZpcmxC?=
 =?utf-8?B?bk4yeFBxcm5mZlRQckFpc0lKd1pxWjUySzNkS0J1NkdvQnZmaE0weWlPbk01?=
 =?utf-8?B?aHVDblVvUmJrbG1ERFROdC9aNW82R005ZGhlNm9TdGNSUmxkWm1tbXg5Snk5?=
 =?utf-8?B?bU5ucHh1SUUzZFJONXd4dmFwQUxXQXgremRCVkxkcW9MNExVWnBqMm9KM2VD?=
 =?utf-8?B?NmtoWXdUeW8vWU1PUUNObWIxZU5DQlpuVGFXY0h0RlhlOS8wTXAyTGVlTnZI?=
 =?utf-8?B?VUtQVEdMVm01ZEI3Wk80TlVkZVhsK3pHWWJIMm1LemorWWtKZ1VyK0h6Slhr?=
 =?utf-8?B?emVBMkwrS2d4WlJoWWtYUmErNmYwOWhaMnB1QmlvbEh1MHhnMXhQTUN3Tzdo?=
 =?utf-8?B?aTl3MVlpS0RCSXhGWlV3QkVGUzR0akhLTTdSNjkyR2dWNmorbkwxbmJZbVZP?=
 =?utf-8?B?eE5QdlVnZUZHa09FSU0wbVptMTIwai9rMUZlMVBTZGJ6M09UT2h1RHA4dXdC?=
 =?utf-8?B?M1dGaE9QWUYrZVJ6YTN6bkVHTnVNR0lrY050ZGtZYnpZUjdmMXN0VVNzMnZ1?=
 =?utf-8?B?YkNwZG5FeU9pVk81UGlIengxZ2pjWGR4aWNIQjYvT2VmbTdtSjRlMWVBZjF5?=
 =?utf-8?B?dHU3NHVaaHRnYWhwZSs4NWlFenRRPT0=?=
X-Microsoft-Antispam-Message-Info: RHkml+e+6K1GL3tKsmhSfYtSvy6vuhnbd/98JTkhYE/v3A8lw9WBHypU6415PbBVKJAcCi+9MzUPqbK0DZhjuMZFcvesUU1yeaMtrM8ky2zYX54h4PYR0xdPMwzcjIrfBWYPojru6lrtq0RQYedxFYyHF9CkhIqtNv0ZEZkOPIb38zmuk30AZyc7YfO+S19T
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;6:5Esvl9ad8tKyMTK3csO6keahEzgDiKUDNVqd4JSHsHopQ7zTiOmaTGZuNv/8mqT8CQk07lSeo5BWFVUtZev4vIwB6Mkxh0WNjNXHK4euIx2o1uEXa6UU393zh7Z71BMVElWLdUXoluhkQ7nRdjzB8RyQ0pvDBv2WnjZGorN2dqtgUyj0x2lT53Gda3+X43nqBI7+CM8+olv6SccqZtAH9yZjTeWaZJtkGiItgGoOCllUdcsGe5HQoxH0HhiBHZYHo8xHSzF4jDE63cBHVdB+hNCOl/LSG+12sc+gqjoOFT77v9oDaMDt6wPlF0oT3dPkJjbZHJ+Q/PIWRpNJQ/r+bIU1hczSYpIsf5pbB3NQ0maOaLzwbGoMiMSnlQIj1tor3Y1rH76htF/sFdc2xZXvNkhEH5VoZoP5i9CCCIQcPXkYqMM/42/SwgCll30L+aIv3NsgLFdW7/i22pOvSlN+Dg==;5:i64pmeFIZ9EzC7XVqYFkdljatW4rdSmBZTKdIIeXfQKhOzi5KDnFFt/FlART2Eaf/wBE+EYecFGpygx/vUZUnsSiqVqyQ8OSn6Dc6TCVcqd30ewZZuOnGrFqE7fP1s9ny5vg4xo1oQ7qiKYH9ZNciSi+NK/FEUWwT/yV/ONctvE=;24:+Apf1cPNjsSV28sxxlYH2pNmFSZLr2m7xq4shSs/Ynn71WT6egPWA2G+uJW+I1IP4Re80KzlpOmVe6N5Akiem8cM+AMmFGR8hiqj2NzvC+A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;7:LKCETMv3/ddYWNE2Z6EprPjRgg47KZtBz327aPPgDh8C+z/b/pjssnppAGYsqwTlqhdgir7jixEn+Zqz7+PSEAsFdCwIfAw4WLk/nNSZBsHkdCP4hOPux00hwyH3caJvCNxFv+JWgITJYwnkibelgKCUR664ThuGPWzRa0bfGWvHRlRXQxkoHJ5JMzKqMMQ7iDopggcDkCZh4HWs/AK3KHiWen6MacSDKAM+hlQrhUIPyVxd8yEzi/REQibmU+p2;20:xBquxJjJG6XI7BazLzARMzURfGUC5OVwftbqlhz2WCrHpx5/kFFn4r3gwBc+TCzx4vFaXQOJywDzPCrdd1KgBvyLv93U7Iy3YbQQlDuJXDrLd3cLXBaaBpJ+5LUwFOUHp5lVoV/eR/zhScbIgn5oBDt+qvTB3inM3E8M6ZAZT1lRHLT04jcIcF8plKFkewWlELXnYtX9z4AP7pVWIjjfRARrq3JkGkQ4X3shLLAC9dSoNEKVeNQm1j1ljjueGuS3
X-MS-Office365-Filtering-Correlation-Id: 6b322943-f6aa-431f-8f3c-08d5a48e0802
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 18:07:05.6989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b322943-f6aa-431f-8f3c-08d5a48e0802
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0694
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/2018 1:55 PM, Robin Murphy wrote:
> On 17/04/18 18:36, Hook, Gary wrote:
>> On 4/13/2018 7:55 PM, Mehta, Sohil wrote:
>>> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>>> +struct dentry *iommu_debugfs_setup(void)
>>>> +{
>>>> +    if (!debugfs_initialized())
>>>
>>> This check is probably not needed.
>>
>> Ah, so it isn't. Thank you.
>>
>>>
>>>> +        return NULL;
>>>> +
>>>> +    if (!iommu_debugfs_dir)
>>>> +        iommu_debugfs_dir = debugfs_create_dir("iommu",
>>>> NULL);
>>>> +
>>>> +    if (iommu_debugfs_dir)
>>>> +        pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN
>>>> ENABLED IN THIS KERNEL\n");
>>>> +
>>>
>>> As this gets called for each IOMMU, do you want to use pr_warn_once?
>>
>> That works, yes.
> 
> Or I guess you could just roll the pr_warn() into the previous if() 
> condition, i.e. only warn when the singleton debugfs_dir is actually 
> created.

That makes more sense for a code path this isn't going to be hit more 
than a few times at most.

> 
> Robin.
> 
>>
>>>
>>>> +    return iommu_debugfs_dir;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
>>>
>>> -Sohil
>>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
