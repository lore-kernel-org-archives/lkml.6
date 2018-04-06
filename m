Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeDFIEF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:04:05 -0400
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:55623
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752012AbeDFID4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:03:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Jean-Marc Valin <jmvalin@mozilla.com>, airlied@linux.ie,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Felix.Kuehling@amd.com, labbott@redhat.com, akpm@linux-foundation.org,
        michel.daenzer@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
Date: Fri, 6 Apr 2018 10:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0701CA0009.eurprd07.prod.outlook.com
 (2603:10a6:203:51::19) To CY4PR12MB1718.namprd12.prod.outlook.com
 (2603:10b6:903:121::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da184ee0-1501-4db7-2ba1-08d59b94f0cb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1718;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;3:TaNNcTXLquSC38+FCErQnbmt/bX1IEh0MMix4Nwzyv83cydciTzhK1EljbgK1iScJ7T+eWEJlWVVeqsz6ioXsPv0VUnIF96CHBhgI2OX1Q5IfQATuY3d6lDLUhb3/CPSuwY5A3v17ZBzxTG/9xpJNiP9DHJJAD5eH6xsS8qpbQIaMj15PglADOw4Gpiy3oBFrg7KZa+yTZBRCfGSo+Vl8Q6VSuEdUnPkm85UfDFdfapxpNwKLNcGZQt004EmXzn0;25:ZXz9L3VNgnBiTSpMFH8GP7Nvk/NwZvd5RpxyeVRV+EY3NBdkwANDeByVzFK0Sr5TAZcPL0ID+KcASaOffbPodJVCvZhP3NJhe7mCF/NEZJubmPfx0vLIrTUVSE+gXZXZmEkvvvr5qWBNs38ySmSmVTf/IZaua8+sYZ6GpEZez0Izk9hMYOcvr9pxRJYV9L9CutsYTDiLys+XJzG7Zo4dbEA7P9ovBhl7P9oJi3xKiLKaaXfPVxioeaZ2I+0KF6OXvrJJoE5O+qNsMnjW9NZnvk8CRCmXPK35e/SacEodUHqbnq7Dd0WCM3xPYMysgBD7HyMHDlBZVnGe2d42npqcxg==;31:B5Ejd22OjJPoXj5JLehYuthz6Ss+N89UfJzfK30Q1lA1kHD6NS8vMf1MKFgKgzNTeBDa7ednwDjnmCDSKcM6qOqk3K809ftF5STFC2cKG+u06xA+KXBimsMHvt0w8avK2bBHswYQdiWZtAcTacDFTdbqeKIUrkHKASFw1AQSCMX69KJ8I0US+VFxJONMcLfk46EqrIeD/2hkstdXzJ6Cp2fNFPxLf2lCBluDhoPM/mI=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1718:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;20:VbNV5GO8mP7V3b1tOBQK9IZCGhwimdPMBYdZHFE0PYiG3osG4F0whHJLBtAj6FtO0GcLKUM9lYCobWONfyWxMiHmO+3N/Dt0TXnpvrv2xyFzQj5z8ppinr95U1Wqd6V9TtjDArsPZjNHUyw7DDEBy+U6W/aQQc0IfuzQkmoq+y4jC8uAjYOMhQl7HvLGEFNf0AR9/TVmuBhs2ilXyPhBReLvwMAtgrBYe0hkoxN7VMsgs/UxLJEKIDRp7mjmLa1H6dMYfIqUk5wqnHmafCfeZRiGsdM6rV5vq4/3+ZOzszEHcH3m6g9dX24uUNN4IdRKEAB0eP3jre5S462i/P1rdKlig5wfwgJuAlgl67vFbx7CF1HGavzV2Hlbfdibw8x2EU8jjHOA7WKHrtMW6NP6rDO3300bC/xVpJCPNSkFTqQVQYayLY57E0dEUeUqGdof2UGQdZyB1HMlje+DeI35ZdsXZthtKecAnBsdsDFWUvqOlkZIhmEW4m8vVCU4wDVb;4:EF72b2X5EYRk8aNX1O6pM3F7qkhBN/1rArLTTtXD03VrVYqYytXh41zFw5B17Zt8y4mY0tv6ohI6AASJflzKFMRQNXNJu6uPCXiYgNfzkPFCpjfLQdnL8kY1apfT3R7rkL8SJurbO/+PvH830qIfPBCiu9iu7Npcw+p8RgYhp1zUN3drk/sv2DOf3lyfoqUxAjGmPS/E+h4MP0nQto9DEm6+Yk8TPOUqqTZYnNK50WWlwyrfDk0uN3uRlUUGFCT4ot9HhamSBApF40YT/rWarJWWoabyjLcJYjDcZjPq/d0IznbVsf7NcPBlqjZ4vMQ8NJXAl8NWiom5bN/HThpEXg==
X-Microsoft-Antispam-PRVS: <CY4PR12MB171858F54227A82CCA68E13483BA0@CY4PR12MB1718.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR12MB1718;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1718;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(376002)(396003)(346002)(39860400002)(189003)(199004)(64126003)(2616005)(67846002)(5660300001)(11346002)(7736002)(2906002)(47776003)(229853002)(6306002)(86362001)(6486002)(58126008)(52116002)(36756003)(105586002)(2486003)(316002)(476003)(52146003)(486006)(52396003)(23676004)(76176011)(386003)(446003)(31686004)(305945005)(97736004)(68736007)(106356001)(478600001)(65806001)(6666003)(65826007)(1706002)(8936002)(16526019)(186003)(72206003)(966005)(31696002)(6246003)(65956001)(53936002)(2870700001)(50466002)(81156014)(6116002)(25786009)(81166006)(8676002)(46003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1718;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE4OzIzOmw0QzVPY0R5S21SUzh0TkE0aloxK2xibG9s?=
 =?utf-8?B?Z2xkSDhNYmNkdFViY2JXTitGZDk5L2ZzOU5LWmV6UGRHZWd5eXdTcmtCR3ZP?=
 =?utf-8?B?V2tTKzdGZGVveVdBK3NPK0I3YjUxa2FXSHY3YTVtRWt0TGRFeW9nWmVaQmU1?=
 =?utf-8?B?SG9xWGpvUmRIOWFlMVFMa2tuVWh2YllRRUdNa2dvYWlpMFo5bTFMdit1SEJV?=
 =?utf-8?B?bmYrT2FWR3FpU0RSVSt6QVI4OXNhOExVRWJmengybkRwWG14ME9ySTBLam1K?=
 =?utf-8?B?eWR6TW1ScGxSSEFZdExHRUtpU0Q2ZjIwYkJubWd1TmQzZFAwdk1FejRudk5O?=
 =?utf-8?B?dGsyM0lSQU1NVkdBNTg2UGhDUWdMT0Y3ZVZvU3U2Zlk5TFlIcHE2QzBHbHNS?=
 =?utf-8?B?aXFBbHBLTlgrSUx5UGRjWldrSXFBbGE1VE5KTU9wVXN2TTFJVjYvYW9MUlVw?=
 =?utf-8?B?c0dNeUg0d0k4ZzU0SGZqY0o2clJ6cEhldVNicEh3cWMyZUxmaEpCakIzSDd1?=
 =?utf-8?B?OUgvWVB1YmJjcFlhOTZvTG9pZ3I2dStGbXM1akxKQWRQUjZUYWV6R0JUV0E1?=
 =?utf-8?B?VGFYb0lrUTZzOUQ4S0Z6UnVrUmpUTHliZk1Ub3NWcThiVm4wTnhPNWxlV1Zt?=
 =?utf-8?B?S0ZDRkhrZEMyNGwyelpTZkJTMnIwcVBFbHZ3MVQzTk04bkxGUkp0ZmdnLzZn?=
 =?utf-8?B?NisrMnZlSzdnRk1xZW4xd0JudnU0NWxtR255UEw0MVZTMGEyV0VhS0hsS2wx?=
 =?utf-8?B?Yi8zTW9hdUhyY2Y0akZEd2p3eklrTTQxT3paVTFKdDlNVENhd21aMjFlUW92?=
 =?utf-8?B?RGhuVGtyRzQ2MXdsb3VtODc3Skc0NXE1TURsaE1wR1lURmxKc3h3eWlVSTdI?=
 =?utf-8?B?V3U4SUVMRVo0RDZDalhUK3pSWmhMNGlmaTdUT05FTHJaaDJWb05vMXZqeE5o?=
 =?utf-8?B?NkZ5ektKYlpWWSs0VnhiUThrd1ZlazZ1S0Rib1BRdUY1alp1NytiVHJsdkd6?=
 =?utf-8?B?b1hzTi9kZWlGa0RrZDIzTjRZWThiZzZtUVFVRDluSU9CY3dMNk1HRFpoVVNC?=
 =?utf-8?B?UGQxREZoUFh3YWRSTVZYWStvdUNzaUdzdU9WYjJYNVlSeU9TbVE2TEZBcGcw?=
 =?utf-8?B?cG9tcW1WQ2o0ZGFvS2l2SGJEVVFqTU5BYXRxZW1jbFZOY2JUeE4wUmRyZk9n?=
 =?utf-8?B?TTJQMHgxd2RMWmlpQmRrMy93clNTb25xcmh2M2JQaGdzL01lMlNFODhPYzZU?=
 =?utf-8?B?WmJHNUNKR1M2ZndwTHl3MWxQZENNU01pTTNOQyt4a3F3WDhCWTJJa3NZZGFE?=
 =?utf-8?B?N1V2NHEwN1loM3BSTmJEVm56RUpkeUlybGx6WjBoRlBzZjhncXlWN2hJTlRV?=
 =?utf-8?B?YkhMc1RrVi92QTBKZmxxeE1UL2RzTFlaM3JONVJDZEdGbGg3UWU0ZDdPbUIw?=
 =?utf-8?B?cnE3WWsyYnZmbDFNQ3Z4bmJxNW5wTjJCN0hUYndXL0w5ak5IRHpoMnIvVlpX?=
 =?utf-8?B?ZzRpaU1SMnBFZ0FoUVBvUVFabVJlL2YwbkQ3cjNERnJtRjRzb3dOMVlGZDND?=
 =?utf-8?B?dDl1R2p6N2JBeWd4aDQxcTFGN1dnY0l6MUpTRndXSlp2cnFiVnQ5YTZNYXJa?=
 =?utf-8?B?T0ZXNzVNQ2lQeHlsN3FiLzlSU2psN3dHRUhvQytIRVFldWtiSlU4V1BBOHdk?=
 =?utf-8?B?dm1iSWVldW5iVnJxaVR6ejd2MUxjMVhUc1FlcGI2SlVpaXF5U2p1ZHZiR0th?=
 =?utf-8?B?bXhUUE5EeEtDUUczYUMvRkpPMXZPU2h5NTVORG9PdzRKbk1IaHpvdXRLclAr?=
 =?utf-8?B?dS8wVXA1Ujl6dENSdk9vSXF6eE9hdnJJN2ZGQTJ4MGZGaS9GV0VqVDhOS25W?=
 =?utf-8?Q?F4hdMJ+wiyZ+iSiF3K6Xo5F9aeHlWOe6?=
X-Microsoft-Antispam-Message-Info: wghyARfx/x41mrA0I1jcOF5GqPL6ZpAvdds01qnULJtfIysnCjxCxzU45E7EfhYwGYww4lTjMyN2WrCizjyEJhb3RDoeMxJOSN9aOcMiUUQlrOWBl71HI6NyEmneFujWtCOG7iAFPzoPoNyUfUpd71sUgzSpDC11zbnU6BBgcw+3sh3wX5nvqcX1LJ1p+lPA
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;6:pR57WwLVX0TYvSpDe+CGDWijN9B4ZODHXuA1ntq4ImfQcbiBV//H1rgnYexq4Pven3N4Y5WwzawOfZWZ7Hnvpsv/B0AMOoYzOzvoWJoj2aHpe5E3rwi/1+sk3Q3venV3Gwz6PpvT5RSUo9sC69hZlkuFeuEU1p+wd3tgqO/GTQVPFUzSYVmhxFtC5AkDsf+kx2vrnI4ZZBZ/e0CJbZQ8w75CMfpdkgL6PLokitqVGblu1Rjb4zDhXTa6BNvc3ZKQjSHVlGiahbHaS6G4BSq4eBF/jSO2ClWAmUAZheRjWqFkdG3Q8cEUQsna1EdDF8NpfwpNZLcIM5JSDzPJ5AYGj2qIzUkD4ecJ02iqFjORsajaNjyQa6HEZ8sg3mfW/4cKQlLRtrxOQpvgUb71GndZMas16ZOWYa3yKFjWl9gE50+8yhlra5p4a7Uw5jeCBWeB6LBXVP6yY3+9HfqZhEPSYg==;5:J/scIxI9jkvohdATfl9b1RYd2A2Q/YOanHpRtmCFNQw7w5hJFZ6Jjn4ZY2hoOdgMXCVf4ImKcLALrQcUaxmTTJFRTKuT7Uo4oAxSPDKM+oevNOXho3hMOGkf+QTJv5EKhmYzDgdsIdvJ02ksI5pBsns7wPnwRhHE87IvBA+YFpI=;24:uulhzwKkL2BOCFqTB7cpCmQh7KlOsWK19QJABINKgJ0wGYJIrO0np0eXje7oaU3MZdRJDjRB/a/dOTqGRcjFvXKp8aAAhsfS3N4ttpnckDQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;7:P+hCts/IGYznuC78YWlVflni10JhjNgzhI6fc0Yf4A0VRT5oX3Ie3CWbxi7G70GLG/EovSkG9IoJobQCosiat+kySIstdrm81EftqEOV4FxH/c3cYmtNggbaNexZoE4lIUQZYXDJkXdWbHnbRnq95GYne6XxzINV1x2fWG5/FRdxBAVd4MTGwGEWjsbaV8LjtgMLenVxRQROTKsJNlzQKIt9FPSj6NXLyhcc+PIPGi8gbEVVq/FRvzQknezEV5+q;20:FBMKYLSBumtixeF/yRyzMrobdg5+bLfx7XCxsvNZwCWCxTAQ6M3y6shFL54scN5YPwwLfLRkdbwzCDMqvz1BHqW4Y6w+fwTBQ35KBXm4Sl6l9FhyjG32cnH1s7KAHVq2wq0AofR9IVWATqAq/2lxt5ommxXclJRy9TFmzs3NOwPOpHar4AuuD1SB4q950QSVXWQlpELCo2zqIABJBswVEvW98l2X3o1x15O74N+zxzKtRzp0ERVhPX96bPcaSiU7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 08:03:52.1980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da184ee0-1501-4db7-2ba1-08d59b94f0cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1718
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

yeah, that is a known problem. Using huge pages improves the performance 
because of better TLB usage, but for the cost of higher allocation overhead.

What we found is that firefox is doing something rather strange by 
allocating large textures and then just trowing them away again immediately.

We mitigated the problem by avoiding the slow coherent DMA code path on 
almost all platforms on newer kernels, but essentially somebody needs to 
figure out why firefox and/or the user space stack is doing this 
constant allocation/freeing of memory.

There is also a bug tracker on bugs.kernel.org about this, but I can't 
find it any more of hand.

Regards,
Christian.

Am 06.04.2018 um 02:30 schrieb Jean-Marc Valin:
> Hi,
>
> I noticed a serious graphics performance regression between 4.14 and
> 4.15. It is most noticeable with Firefox (tried FF57 through FF60) and
> causes scrolling to be really choppy/sluggish. I've confirmed that the
> problem is also there on 4.16, while 4.13 works fine.
>
> After a bisection, I've narrowed the regression down to this commit:
>
> commit 648bc3574716400acc06f99915815f80d9563783
> Author: Christian König <christian.koenig@amd.com>
> Date:   Thu Jul 6 09:59:43 2017 +0200
>
>      drm/ttm: add transparent huge page support for DMA allocations v2
>
>
> Some details about my system:
> Distro: Fedora 27 (up-to-date)
> Video: MSI Radeon RX 560 AERO
> CPU: Dual-socket Xeon E5-2640 v4 (20 cores total)
> RAM: 128 GB ECC
>
>
> As a comparison, when running Firefox with 4.15 on a Lenovo W540 laptop
> (with Intel graphics only) the responsiveness is much better then what
> I'm getting on the Xeon machine above with the Radeon card, so this
> really seems to be an AMD-only issue.
>
> Any way to fix the issue?
>
> Thanks,
>
> 	Jean-Marc
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
