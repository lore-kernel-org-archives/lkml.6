Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeDELmg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:42:36 -0400
Received: from mail-by2nam03on0080.outbound.protection.outlook.com ([104.47.42.80]:16483
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751392AbeDELme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:42:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
Subject: Re: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
To: Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-2-git-send-email-drawat@vmware.com>
 <20180405073525.GP3881@phenom.ffwll.local>
 <b87e222a-610e-05de-3ba2-7261831af5ec@vmware.com>
 <20180405100319.GT3881@phenom.ffwll.local>
From: Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <b699fce8-4c76-c997-f989-7406cc3d4c92@vmware.com>
Date: Thu, 5 Apr 2018 13:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405100319.GT3881@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: VI1PR0701CA0047.eurprd07.prod.outlook.com
 (2603:10a6:800:90::33) To DM2PR05MB768.namprd05.prod.outlook.com
 (2a01:111:e400:244d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd7fd6a-52dc-40d6-3c40-08d59aea50fc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR05MB768;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR05MB768;3:pf0/zCw2QyzsxwAxwrDbPCnqwBTZwsyWRFfp+PJP2E3Jix3Zd+hNHmUl3npcLBGKRIVm0Ua5VdtryFavgLiABDNw939vmNmxmBD9DnbjHh8K7oDw7GUHFzSlyJCI/kuru1bMFR7mwZgpa2ApynrL98kS9jc4qC2DhVOj999zlN+/nn4vKvwcrNPJYoIWup3be4IFetFg5St101PSAu3GREiX+u2BmMHju99vUzAzBerptpqlspEPvKTZjhSiFIjS;25:f8TrUrwXarnKwJjCAPvyjRZBEFaUh6ex3dEMB3uspBaw+Xj1zPqIoYkmuohSUzQ4YqD1ADbNoz1i70jrNBe81CJAiSo6bqi6EOslDL11gpRi7D+P0lgcqI8nT36u2gVZ+/LilPc5I0c/O1v04vaxEfVhZsWuorTBdATSgbSvBF8MtcaxMKt3P509JfnHA9mCzqMpve1uQ70IYRCsVNqK7idnhuNL+zvFIr0DzMo7UqM2eeaOm+ybY+2U6uBSbiuiMHmoTxfBaR8mdjB6l0xCuQ4VjvyamL7EhFG6TVMB1Cfr+TTG6Sihmrvd6rLy4CKBNmCXs3kWJJkSuIiz5OwFQQ==;31:tPh1UEltpXloiQ/1VTsPERg7lNZqp+mw/LsbAh2g1H10tfZWa1QHRJT5qSv/G5wtoEp9pnICPyEzSPOEy87e2iKL9a4fwKujRWjhAp6kv06vwQY4roRUedjexaWEXW0BjF1//9Eb8L4ToWeW+5Z2Vklu+dnUyrHb9YjZGWKbl4f3XwGU1+K90gIZ/yJ7wDbw2MJ0ckke+f6LbLQxjTolv02cPHOA8VxUBseyXliQVCk=
X-MS-TrafficTypeDiagnostic: DM2PR05MB768:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM2PR05MB768;20:4/VuL0VcQc9bHiEYdMWZjDbCl0Jx0TvQXM51stc/12ii9lEjITdUtZjWgKRG/Vd22cixmCUrCxzqSlY78TCydVEkYwe6fkS6ECmmBA6BTVTYSPVpbXcnRV4180hK65dozc9oinAbbxL8h1f5v+8w40o/qrE4bZOaXyaCOLPf9gw1f1xoGxzsEH2yhdoYmkZY8ELLAS/eiN1yNITjWKU0pjjSB/xwO9U4O76GCxlFSZHQ0J1te6DcsLr55te8r5kHEyP9dGNXB7Qrt52P6ZHphuU/0zc3XLzDG9VaztfvAI9OVD+HsP05UkSelJ6ZRhNiUGdeXonydVOehmA7I9shBaOxmOqy0toSZTnBPLuhwutRC/bVaArx2YwTuIJexQ3FPN5Nt6xv71O3sLQ4GPMf3/x2p7KqQf/VapaeAGcP2VO8U+m0rVm6JNEmNpwTgNDxwdMUQNzOON5pXwpQeI37MXzsZDWHVkcKDTYbVgVdYjHNFlB6xuSAd+WwegUDELlA;4:cHK/Vf68k/CcYuLdhNv1mDuuxEX5RyTAiZtRqRM0w4l49+tI60wFVzMFt4C/gPVlKe7lFPHjZDW658DOknWzRddEocjajaGNRZ/EyWsQ1keP6OnoHPVVKyVD005TbWx4HB4VwmIDyR9ECNAN7SLzcZqI5jjysYKn6NBU+hF7Q8yXGGYX7d/Db9pUcILgw5oICI9hkNRJUbH67QfusnlG30HO4O+Q654tMrjTOvWBwfmJIf+S4unAgtlCHnQtOkW0d6vqljRRpP3Ov5EmD174qa3t8bUjxfVCqrspId0s6ADqjW5CkOedvbicETNtns0ckjG8lFvYwYo1OQvjK92JBQ==
X-Microsoft-Antispam-PRVS: <DM2PR05MB768308DB2FBBA32C1F041D1A1BB0@DM2PR05MB768.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR05MB768;BCL:0;PCL:0;RULEID:;SRVR:DM2PR05MB768;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(6506007)(53546011)(6512007)(386003)(106356001)(86362001)(575784001)(31696002)(76176011)(93886005)(36756003)(6306002)(16526019)(53936002)(6666003)(966005)(97736004)(186003)(486006)(26005)(66066001)(5660300001)(65806001)(65956001)(25786009)(47776003)(58126008)(68736007)(50466002)(64126003)(23676004)(2906002)(52116002)(2486003)(52146003)(316002)(67846002)(65826007)(3846002)(7416002)(446003)(6116002)(476003)(8936002)(105586002)(2616005)(6246003)(6486002)(230700001)(11346002)(956004)(31686004)(8676002)(7736002)(305945005)(39060400002)(229853002)(81156014)(478600001)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR05MB768;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjA1TUI3Njg7MjM6M0FaZzErMm52MDM5ZTIvMXUwSXZyMHIzd2Fx?=
 =?utf-8?B?R282WWdqaERLb1dRa0xKVkJvakE4cTVpWnQ0M0tHOC83ajc3ZnpYTjdKc1ha?=
 =?utf-8?B?emRuMldac3pLKzh6QUVJNFkrUEpZYW1MWGtNaUZaNkR2TDIydTJ0UWxKVU02?=
 =?utf-8?B?b1lIUHJwY0Mvb0VnWGZvVytKbzZmZGtvWmRFSVQwdTh6T2k1SEpDdytEeldQ?=
 =?utf-8?B?TWlyZlQ5TkNuNEhmM2QwQmpyV3lqTDF4RVFQK2g2ak44eHhtd3VIbU9aYTNu?=
 =?utf-8?B?UVNpTndyUm1CWUxaMWI5d3U4VzVqQnZEd0JZeEtGeHdKaWF2d3RMYXpoVkRH?=
 =?utf-8?B?VENwYXNBZjVneXh3QUdYT1ZxdzBSS2RJMTYxRnZwSGhFaE9KTm15MjZ2emFo?=
 =?utf-8?B?aGZnSm9tcHFrRk1hTmltQzU4OG5qQ3laUW1Demh6bUo1dU52Wml5OEVCazEr?=
 =?utf-8?B?VnNwRS8valVwTXBvNzMxOGkvc2t4Q25uMDdoRlE1aGZvOGpjR056KzBlcTdH?=
 =?utf-8?B?d21XK1lLMTZQdUpZbDNKempUT2NvQWxzaklBOGFJTHJrd29CN2JzaDZrMUlY?=
 =?utf-8?B?QXFxMDRxMmhFd0h2YlNGUTBlYXJNdThIWjBwUUxCd3JYRmx2NnBTZFNSTzlY?=
 =?utf-8?B?TFd3YW1TVjAwTnZEbW9rdXlkc0cvY2t1amhhVk9vdjVYTDJzYTdKLzFTeXVa?=
 =?utf-8?B?YVVLU0YrV3RySUZoZmtxTnh0WE5hVzFLclk2elUrd3NtSW5PVkw4cldqN2lj?=
 =?utf-8?B?aGkvTGpITk1yWStmRDFsc0wybGNMTVNGY29zeUtwckgrRld5NU0xbWZOeTNT?=
 =?utf-8?B?Y1p2MG1qMDJjUllRcWx0Yk1wd3gwR3VGeUJxVHVMbHZLcjVTckE0TVN1SzNI?=
 =?utf-8?B?TVZ0d3czdjlJZldWT2F5WkN4S1lkM1NjbUs2M01TNmkxTVdBd3RXZUJDOSt6?=
 =?utf-8?B?akxwdFViYnd2anVvZVV1ZDgrWkFQcll4R3laenBHUzJlQ2FrMEFzNi9pVldI?=
 =?utf-8?B?SW0zYmFBV2EwemNQczdXZ0g4TmhZZXVkeXFnYXh0MmR5Q2wrVTA3TVJweVpl?=
 =?utf-8?B?aG13RDBzdXpRZTJuSzl3WDNybStHK3A2OTZ1RkovVzZrVHJFZ3poRHZsVndo?=
 =?utf-8?B?SytJVmI1M0tubGM3Ukx5SGhCSXk0L0ozT25rQldKeUl1NUtrMGgvR2MyTklu?=
 =?utf-8?B?ZEszVzJwYmdVYzhqakl4cGh6UDVGa0V5dm5NNUZ2SjdCNWJUemw3VTBCaTh5?=
 =?utf-8?B?aFpDWmk4NVBlaVZ4aC9CdEJOeDh6bEJqQ0JhZlBQZnpqUjJWV3B4aFUvWm5U?=
 =?utf-8?B?TWl2dDdmclZtWjBFQzNpUzFzazJVcHZkQmFLZjFPOWVnZUFMRFl5bVRkbXRW?=
 =?utf-8?B?TUV6elBFMzE2czN6Vm0rUzNXRGp3dll0bzhZa3k1NFh1SXBFYzM0R2FxVVpM?=
 =?utf-8?B?ZGdKUjVvbDVmRjIxVnlyRzA5bkpBVHcvN2hZVTFQdmNzNGtJSGVQcEllTSs5?=
 =?utf-8?B?NmRWTUlEZFR3MXBsOEZvMXpRVzhsN1V2YmM5WjRhT0RMRm5xeUdiVlVXUVZ5?=
 =?utf-8?B?SFVkUW44U3RZNExGRFNzd0tlWklhOTJGTmNYalQzN21RdjZ4QjRuMVBhYWNm?=
 =?utf-8?B?SnI3UDZSSExhOElxUzV3YmRNeWRsMGQyb3pHSWpXbGtPSmcwZk1jWjNkNWV3?=
 =?utf-8?B?RjNnQlZkbUtqNjVKc3UrekV1RzdXUC80cHZ2V1lQZkhnY21jd2Z1NDFhNjFU?=
 =?utf-8?B?UmhabFFmcjZpMEErZ2xNVlB1a1Fvbml6WnpFcWFzNFpvSi9nVVRnd0x4QnBC?=
 =?utf-8?B?QktHU0xWM3BwWXJDZ0NGRDhTdkxaZUR3VTNnblVTa3d2cG1kRmJ1cktucUpp?=
 =?utf-8?B?SGluL3NUVFVkUHBsY0xkbWtVQ3lLVldCTExlYVBtTDNtWjNtY0YxQ0xiMDVL?=
 =?utf-8?B?RkQvZmJTQmNGSGs2aHFJQm1TbldiaWxmcXZtcGF2NSttdHhYVlVJay9RbW1C?=
 =?utf-8?B?d1JvVit2MS9PT2NXaDFlTy9YYi94Ti9XOXpQblBoQkxQc28rMlEvelVOSnQx?=
 =?utf-8?B?VG5aNnduUHZ3Z0svelQrN3lST3BFUU1ra2t2R0NZUEFrQUxkSDdqY1VsWmZB?=
 =?utf-8?B?QT09?=
X-Microsoft-Antispam-Message-Info: grvpXj5XtMn+1kEeVYqKzQKKaxxOjlOH96vw79DWU0bRVPx8JL2IiaQLwtvM/3kGoVBUROCcjiu6FxQRJ9oXLLoZ9gSlW6R8ElwF5oTy6fv1Cghm4YGCW0LCmXbQ8A1Usq2j28qjay/hzetN+k3iqOhJlCo4nMH1uNizWqyNLA1q926R7eiy1D9Yx8nNVF9T
X-Microsoft-Exchange-Diagnostics: 1;DM2PR05MB768;6:dlCPTqRd7w/ofFkcz45NWkeeRkLJM16VUUGr0e5OFBfGTEMxQ3WrBvyw+dPFljrhkk7EjubpWoz6tX0C33tWzYtty4QpqpfEEDCI2pij+2Xs7Fn3isU6VP12lqyuocE0zHi08GBrWpB7mFTysDzqcOdmrEQLguLmed0RWd3zNenCfJ/FGjoHVkpB4BoJhLUwVGRTlmjM57xUsQw7HOvzVNLNLKvteMlfCKmQ2GbIC7qC5qecsd2AbkoQo/pouzK+ZiJK3L2YYh4au++WGz9zOqkjnpBrAarnr78jZBCOWkQ4C16Ymn6fYrbeTLYVs3vihqWI2Dcj8yoiQrgPwhrVAXg+GYM1JHmZfcCDg3kyo3yQ+r8vVPSAU1mjwi2cLWfCIkkcj+aPdVMNVs7nUrY7zmZaq1NtqUnLoyXJCKqui6Li5FC/Rb2AiMyY2l7MIqH+XqsBxlui15pj6GFXOTZ31w==;5:0ozPs7bVQYuPojNKdqxZ5s4fATVOHCDzOrx9TNN9HBHg62TvncPyReWTiMeqjDylofDQOFfsYIbSs7xPo3wPCezkbFWsQMos2fMuxABat1/SoK0b0XeLzryxBFP65MIX+ZkwMDkyfuK924470vWwPtiFBkDC5u4hlLdOJOyox+0=;24:E1QIplrwSRTrAz39ThC6rJoYar/wgOelBNfcgpIUM7s+QuAj8we+l413624Uh2Z9WezyDh0xT6APKInm7YL16p8sAE8GkKASTzSOeYIduC0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR05MB768;7:rkAnspt+RXTD1+E7KsYW6w+yHVyawsZwoS1MFruaPekKgqcDzOPOTI1A8tu7YZIjKVOBnxTplX12z7qjfzTKXHX2I124dSvPcCKxKps3ZTLFqufoKohZ5/os4wVY3T7ibbvPmQKaX+5EPPmlhLTOttYI3BCg3KZfJiGKG4iz/VVDHJjlfbl7jajUEbCLDphtT2OsH3cZPqtaaaKaEsMdJY0rVbM7xdY1aFjqD32TOyZKPefs8NTIKHmAUfdnTd1n;20:uugqDfcXDbcv7T0LQrgF7VvvZV4Ov2vg6wvhhCKw/NZVFWqbGwtXYyR9LB+ie42osvZ3rtb3P+0AYpcNcmDzy318v8WGgeUShzICG3K7YSEMTlXOq1ecyzGo4tUobNsc/IC21d9IBzVwLnmBU7jVpuSGf0J55xN1QmrZzQKjjT8=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 11:42:28.9525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd7fd6a-52dc-40d6-3c40-08d59aea50fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR05MB768
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 12:03 PM, Daniel Vetter wrote:
>
> On the topic of input validation: Should the kernel check in shared code
> that all the clip rects are sensible, i.e. within the dimensions of the
> fb? Relying on drivers for that seems like a bad idea.

I guess we could do that.

There seems to be different needs for different kinds of iterators, but 
otherwise
I was thinking that an iterator could just skip invalid rects if found. 
Then we
don't need a separate validation step, but OTOH user-space won't get 
notified if
that was intended.

I'm not 100% sure user-space would do anything sensible with any error 
information, though.

/Thomas


>
> That could be done in core code in drm_atomic_plane_check().
> -Daniel
>> /Thomas
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.freedesktop.org_mailman_listinfo_dri-2Ddevel&d=DwIBAg&c=uilaK90D4TOVoH58JNXRgQ&r=wnSlgOCqfpNS4d02vP68_E9q2BNMCwfD2OZ_6dCFVQQ&m=JV7fhQ4zTiyiKsY8M0Zlf81l7szYePUke8kwSvQv1T8&s=HEcbr-8aoWqRvWGY6RcL1QeAtEyxMRLHbsOtdJFk78I&e=
