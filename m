Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDLSOe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:14:34 -0400
Received: from mx141.netapp.com ([216.240.21.12]:30933 "EHLO mx141.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752561AbeDLSOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:14:31 -0400
X-IronPort-AV: E=Sophos;i="5.48,443,1517904000";
   d="scan'208";a="266689380"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com;
Subject: Re: [GIT PULL] Please pull NFS client updates for 4.17
From: Anna Schumaker <Anna.Schumaker@Netapp.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <176ac3d9-dc2a-0a90-b41a-eb8b5cf006f5@gmail.com>
Message-ID: <0ab8f251-0df3-558c-6c27-9c1a813dcfd4@Netapp.com>
Date: Thu, 12 Apr 2018 14:13:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <176ac3d9-dc2a-0a90-b41a-eb8b5cf006f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [99.9.112.69]
X-ClientProxiedBy: CY4PR2201CA0036.namprd22.prod.outlook.com
 (2603:10b6:910:3e::25) To DM5PR06MB3161.namprd06.prod.outlook.com
 (2603:10b6:4:41::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR06MB3161;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3161;3:NweKw9gpLkLpnCUBbqlXn5txarD59vuy95pxjwGU3+dLBSmvVihRwnGJLIWciOseUN50mlYMu8RdrHdZY14YD65eXsNmIlR1FFOi1LgpBwut/rzIlILifgUYR0Kk3P+SK/m2WwEmzYqvuLFX6fAOtmWRpYj3EqjK6XW2goWp98tifSndNlsg+Ba7aIIheg+m0nb1OwAAmTe5gmP6ixVEex/mTdCBDwpkU4+rrEK7pwFOXtLK1j+/mJvLztHXgknM;25:VUO76ZiI4LH+d4Uhy1SdtpJZ7Bn435LALgiTSsvufof7EBHj0QuxP6x5uAeyHCGO1yhfHvI3OGx0g5lcHkxxYRZnDLpfsoibYHOuvnfY6frgaryDj6rL66txwQQrdtke+ZvyazhPZprcbGBpZSNAEJTuJLqjam72cIjJcD1+WWpWzPdEsLPWGEQYs9u+/LC7aqr0j4vm4tx0iDzyk/NcJ6MRma73xlzwrgWMWTE2Fx09qqiXeFy/AjsjsB44dc6BX0P69XULE8wHkEBLrTMeuOUGN7MXLtnuG1dfLbFBIklPL+L1NC+WZudBM7TfbnbUBlDV89Vzu6ERniEzRsaATA==;31:BWQEDL/60L3d98AibMQ6GewB7CA8JJJRpxXsa4957QVqszaSm6FoLOOQhZ5cq93YmGtKdOPmviTRQDHshqlMlTrFXguo7FQg38f1jH4/jcAqaFz0zlDL7alyzcHoBDOrNYakhR30crzD4bGnbyMBDm/6jOd1J53OxuZQH9nYrYChb7R4PQNozJWsP89gnLbEZvMowW6cy4Hb4S+uoNoOMQhGeP5Ign5tBaJ4D3oG5DI=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3161:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3161;20:t8cpfbb/Xwm4yo5agpZA8XlciI4RL2EN0jpSGhjAlFuBPALPFbSXx9+qYdMXprDXmoiowc3QYbQ8OgVJeZEQTpziF8xpPNKnQp9KqFc2GAo/SJYdEpVIRogNwqmA5Eqcau5wppDWdGUs1liDGxB7Yp5ZWpmBUgP9NLW4kacg3bF4gzIgQl6BzaWigbhjRqxUCqELC14NYpjzoL7pPRwI2U4Xb3dxNzKYlMGeio2xdOfJHxd2R/ClvsGk0BJqkiNT46VIVgBzrSeAPSRfd4mXdvVAeXo77wnRiBwwUF+V+CxnDU7QvgBSf0I/4N5qbCIROC3PEg+hC+hJ07zbwpRqnZwrT2XYo44+N3/ZKZzbFxwnYcxqynLasRRhefKkZ+e6taplXZQdy7AfA6MEra4TYCgHhcCV/XMdLZ70OZfUQIKFHFJ0zSuOt1QfTsSbAhNv+cUXcZ1ZoWoWjqf01+JP8AuTWsRybbdo2dyLQ9XAw9vO5tQvPrdFJiNIWQ4YKck/;4:rzA0C3mQfB5oTcJh4fDl81NfkdVy1xRjcg15WVSQwa7lWut3I9yqYWXXJvREgYGAMpraNSW7DCGF2sS43LwMmPQJVcQJKwV2GDhItMEcjMYlFQ4S+fT8v8bNCEGrIRE5PVbNIVG4GwelVngyjk5yQfxoVgfQscCgFQKdQrRDTnDc6pHxtNrHrXq8Rs5zm/ameYSjNkhaZIPv4LW5w0jfEIhkxgQO/Ci/YOPZ0s5w4bw8qqWzeniX49cg5y58XO3wzsuYfLonQcGrfEeQsIE10zq27ga3RHaCIyzFOtnZiWkS6Z67F/2Prx41dAmZYiKWw+ROsl7EiPHwXJy7qV+vZ1crDuZbFl0mL6Zfw2hhd/k=
X-Microsoft-Antispam-PRVS: <DM5PR06MB31618AC9F13DDB8FB8968CE1F8BC0@DM5PR06MB3161.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(5213294742642)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR06MB3161;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3161;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(189003)(199004)(377424004)(4326008)(31696002)(2906002)(230700001)(446003)(16526019)(11346002)(53936002)(31686004)(6246003)(6512007)(186003)(105586002)(26005)(53416004)(69596002)(5660300001)(97736004)(65826007)(72206003)(478600001)(305945005)(106356001)(7736002)(6486002)(58126008)(65956001)(6116002)(36756003)(68736007)(81156014)(8936002)(8676002)(25786009)(53546011)(52146003)(66066001)(386003)(65806001)(54906003)(6506007)(52116002)(23676004)(3846002)(81166006)(2486003)(76176011)(59450400001)(316002)(50466002)(64126003)(229853002)(486006)(86362001)(2616005)(6666003)(956004)(47776003)(6916009)(476003)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3161;H:gouda.nowheycreamery.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMTYxOzIzOjBrSmhuWlJsVFdneUZlZ1ArdlJKNGtCUE1a?=
 =?utf-8?B?NmEvdzZWUWpicU5BSkExalp6MTJTSFNkc2tqRDdtaHQ1ZW52Sk03OXpyekt2?=
 =?utf-8?B?dmorTVVWRjhzTTFyOFEzRGFRWCtYUlNGaDV6b1Y3c2g5YmNVWk1DOWlwTnJq?=
 =?utf-8?B?Q0NsbFo5KzVLejN3UnFWRHFOdDFYZGdFNkpYVjlyZ25HR1ZXd0ZyWjFhcVhF?=
 =?utf-8?B?MmZ3RFNWWTlraTErNGkvbWE2a21JTWxHQnM5Q0NjMGVHWEFZOFBUbkJKZSs3?=
 =?utf-8?B?cld1ZUl0bkp2UUkvYnNCK1hLTGlXaDFUOENnU245bjBBS3FRSUdBUkp0S1ZW?=
 =?utf-8?B?dlM1cW9CWFJUK0pCQUxNeHdrVnl2ZGMwVVNlY3NLbjV3ZWE5aWVuZnk0eUFq?=
 =?utf-8?B?ZXorQjdPdUgxNmpzcm9wRzFnekRiR2RVS0lWbkI3YVlWTXFPTkJIWjNVUnNL?=
 =?utf-8?B?d3J0N2hjQUpPVlpvbXpEY2ZIcUtTY3dVVHI2YXpjWStNcnZ1cVdpRVI0L1hx?=
 =?utf-8?B?MUpvdzBHY3NCNTUrYXJNT00xR0hqVG9kUHFyTTUvY3JuUE5uQWNmeGt3WCtV?=
 =?utf-8?B?UUhtY3NQQ3p2Y3lhcnFaRnFEeXR0ZkgwZEV4VEJqUmNGbUJPZ2F2LzlLUkVw?=
 =?utf-8?B?MUNaZVhoL3FtTHNsMnd6Qnc4eHVDTXVWdjU1dSt0Qm9BV2htWWFqc2JBVjY0?=
 =?utf-8?B?cy85S1hha0NLbVprcmQzZWdLcGVNeDhSUkNJUjdXK2hMWk5BRTQ3Z3BCcGp1?=
 =?utf-8?B?T2dZVGQvaFZLOER2L24yelFHNmZjaXU2SHl4V2gvQWxFNVFISHVlVGw3b1Ux?=
 =?utf-8?B?T2J0QmFGZ01LMDFCQVg1TUtsSVk5bG5KR3lzS2xvUnd1VlFwZUhFM09HZFAz?=
 =?utf-8?B?VGVmL1d5aGhJeEF1bHVJWXRJRUVSRU44bGlrQ3FMaVQzQ3VSSWdMNTZCbWxW?=
 =?utf-8?B?aUhLdW84by83d1QrK0JreTl5b1p2bjNTTnJ6WjNZSk9oQkpEVnhYU0hwVWk5?=
 =?utf-8?B?cE92SWZlbnd3NFEwb2FSeHA4SGdIeGowckVuMHgvS25HS05oT1E0akFFaDJ0?=
 =?utf-8?B?UUZVcVNoSmdlbHBybHdDL0lyT2hLc3ZLRDR0WlRNSEtJakFXUUkzQ3l2TDFQ?=
 =?utf-8?B?N05ITUNpdG5yOWZKYUd2MEhOS3FNaWQrV005N0pSZjlVa2NHSDlUYlB5cmQy?=
 =?utf-8?B?a3YzL1N1TWpIdXNDVHhlWWFXUDRvM1NKWXRzcllGTGQzRWVYSWdkbW5OenJH?=
 =?utf-8?B?UzJZY2lQT2hOVWZtdFZHU1ZGbS9vUkh3RjQ0Rk9KWDQwb3BocjJycTFhNThW?=
 =?utf-8?B?SDN4TFhsRzE2dytiTlVhVktVNGM3VGkyOUNFeE8rUnlFTThoSCtVeGt6ZkVa?=
 =?utf-8?B?UjBLZ1RxQ3QwS1JGbmtmUXFxRXdVR05EbWx1SUxlUWQ5WFh5M01yb2Q2dkNX?=
 =?utf-8?B?VzY0NW9ESFkrVVVTamhYMWhJSUYreEF4ZE5OS2NvTW5BbmY2K1V4ekhVMHpH?=
 =?utf-8?B?QzVhUUlqVlEvVVJCUkN4cURBcVRxc25NQk1DQjNudzlhVkZPeWFuMXdBUU1C?=
 =?utf-8?B?bjhxSis1TG9CcTZ4Y0pxTXBaWklIREFKTkZ0bVRMaDdISU9nUlZLNWJrU3Fh?=
 =?utf-8?B?bmRzMjh2OW5WWEtCeDN6L1BXc1lzSHhVSXFndHhZdGtxbU1sZ0dOSkhEb0Fj?=
 =?utf-8?B?Sng0ZklsMzFrSUNoY1dZQUtwRnF5OVVsVzIvd3VkWFNpaGVDdWdzbG9ZdHhO?=
 =?utf-8?B?WU12Q0MxRzFhY2k4UEN4bmlRbWt6L0thVFRtNXZwdVE0b3EwbWo2dlFIRm9l?=
 =?utf-8?B?b1FVQmViOUdYb2pWUTV3T0tRR3A0QTBGa1lTM1R3WVNIdWxkbzV0MU1LOHQw?=
 =?utf-8?B?ZDJpamo2aVU0QlNRd2E4cTgrSXc4OWhnWG85czljMU5nMjY1VE1HUmlvSCtY?=
 =?utf-8?B?YlZxVENoR2xmekVzTkw4VjFpaHZzdG04RWI4dFVQVkdPWUFyakREL0lzUCtR?=
 =?utf-8?B?YWJEaEl1L3FFOHp1cmNBZzdYV0FRN2d2dG41UUtYMkRTdjFxTmpQN0RXSWRT?=
 =?utf-8?B?Z1pyNDM2OHN2R2lCSkx3endYZmhOQmt4eEFJM2NWbHlRODM1QnhTaFhaYnQ4?=
 =?utf-8?B?bVE9PQ==?=
X-Microsoft-Antispam-Message-Info: MKKddv83lfYY8KMKwGvctOhAP7p0yxV+llZNwnmCEhzG9fLs3jmb9yRV9chXnd9voDYiTm8g9xi7SX40cXOqeAeSeKrOsw2ZYWXrEE7KPBjynqcWIjjS3558gHEzawhbEuqqaLpCRDDp2CRMeqDJPrdgrgkgzdVa1ggfl3NdoStqj3ur1RFvs2jCY5XuI+JC
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3161;6:OCbb8OFGda9hkn242mWfCjFz/x467NIY+PrWsyGCVmT1zHCsJo1JBa+Afw0EprsYGeVkX0t1rkFHRqeYbCy4DQT5Ut80KsEfSGN8It7HwHIVnajj1uyhjg02vwZXA7YAYX3Z60RhkyIWp81jc4EuXbbkP7SPwWoZ2/ULL+SBWesWkMsrdCx9Yec4XfnwxDtqZg0mmtzaVOcctqzf+sPRcbybHEJuMx9rQNOHEufgnHW516hUHJqq9PfKjHDc8gLnOxY7FfFLoyrCNJUpU4s755GTua2plfxHj6AoLZ2+aXK7f82lHLq29z5NlWFyZJus+MF+ev0+6kmFxBF2ozL354t+s3QzI2jDW637mmDtjHFD0+FcaYZ8aj3kWQgxlobPf1GNFfjb7IpvDdXx680uIhVIOmjZpHORXHmhXUKDWHpNcqnnXW6EI73LaMyVHZOO+VZnt6eQMIY/2vU8btAcsA==;5:ZR8g/uDilzsObuGvaW/xRkLFbzi0re3E1hiV5NtdN0nS0q1xKw6I12zur21VUwQs3L1QSQfHuJMtFEYm3b/L3Gzzah5FL/eaBCxLaVv8e3PAqy2AFfJQaCGIlsykpeUQS+PLqZXLPVBNV82+2SUl4mS+oF96pooFKGRsHGub6H8=;24:rBpZWt7mbkX/w/it2dDQdZxmwjbutfVQ8yOTO650/FBP1RbvcKWhtLMLHfsh2bqdX70Ttl7OLu3QJ+A81VioAU5TqjwgQ1m3Js+bk1wjUv0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3161;7:chXSVxVkyYvBTVbyIKp4sG858iIz0bXxX41/6mfHtFbjbcvZdyLczqIBZf5yzOxSJlBb250BxJJjAR92Tzn5c1P0XP01mvbQfyft32YmwQ2+h/fwz9Jhf5i569GN+pJGG+YQ+rrNVOWsx2WIK7eWZlDpVuBnXrUHYdoI8bM26177iNAwDIyyMbvUMjOsww6eABNWCKYR4G63zuXeVrztBIoKTo+Lek/8j4kx4rt+SfrsuIXBrn391q45Obd5WQqA
X-MS-Office365-Filtering-Correlation-Id: 83403500-f6da-412b-0266-08d5a0a131b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 18:14:12.2099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83403500-f6da-412b-0266-08d5a0a131b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3161
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

What's the status of this?  I don't see the NFS changes in your tree yet, and I'm worried the pull request email got lost somewhere along the way.

Cheers,
Anna

On 04/10/2018 04:47 PM, Anna Schumaker wrote:
> Hi Linus,
> 
> The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:
> 
>   Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-4.17-1
> 
> for you to fetch changes up to 98de9ce6f6660d02aa72d7b9b17696fa68a2ed9b:
> 
>   NFS: advance nfs_entry cookie only after decoding completes successfully (2018-04-10 16:06:22 -0400)
> 
> ----------------------------------------------------------------
> Stable bugfixes:
> - xprtrdma: Fix corner cases when handling device removal # v4.12+
> - xprtrdma: Fix latency regression on NUMA NFS/RDMA clients # v4.15+
> 
> Features:
> - New sunrpc tracepoint for RPC pings
> - Finer grained NFSv4 attribute checking
> - Don't unnecessarily return NFS v4 delegations
> 
> Other bugfixes and cleanups:
> - Several other small NFSoRDMA cleanups
> - Improvements to the sunrpc RTT measurements
> - A few sunrpc tracepoint cleanups
> - Various fixes for NFS v4 lock notifications
> - Various sunrpc and NFS v4 XDR encoding cleanups
> - Switch to the ida_simple API
> - Fix NFSv4.1 exclusive create
> - Forget acl cache after setattr operation
> - Don't advance the nfs_entry readdir cookie if xdr decoding fails
> 
> Cheers,
> Anna
> 
> ----------------------------------------------------------------
> Chuck Lever (16):
>       xprtrdma: Fix latency regression on NUMA NFS/RDMA clients
>       xprtrdma: Remove arbitrary limit on initiator depth
>       xprtrdma: Remove xprt-specific connect cookie
>       xprtrdma: ->send_request returns -EAGAIN when there are no free MRs
>       xprtrdma: Reduce number of MRs created by rpcrdma_mrs_create
>       xprtrdma: "Support" call-only RPCs
>       xprtrdma: Chain Send to FastReg WRs
>       xprtrdma: Move creation of rl_rdmabuf to rpcrdma_create_req
>       SUNRPC: Move xprt_update_rtt callsite
>       SUNRPC: Make RTT measurement more precise (Receive)
>       SUNRPC: Make RTT measurement more precise (Send)
>       SUNRPC: Make num_reqs a non-atomic integer
>       sunrpc: Simplify synopsis of some trace points
>       sunrpc: Add static trace point to report RPC latency stats
>       sunrpc: Add static trace point to report result of RPC ping
>       xprtrdma: Fix corner cases when handling device removal
> 
> Frank Sorenson (1):
>       NFS: advance nfs_entry cookie only after decoding completes successfully
> 
> Jeff Layton (3):
>       nfs4: always reset notified flag to false before repolling for lock
>       nfs4: don't compare clientid in nfs4_wake_lock_waiter
>       nfs4: wake any lock waiters on successful RECLAIM_COMPLETE
> 
> Matthew Wilcox (1):
>       nfs: Use ida_simple API
> 
> Trond Myklebust (25):
>       NFSv4: Fix nfs4_return_incompatible_delegation
>       NFS: Move the delegation return down into nfs4_proc_link()
>       NFS: Move the delegation return down into nfs4_proc_remove()
>       NFS: Move delegation recall into the NFSv4 callback for rename_setup()
>       NFS: Add a delegation return into nfs4_proc_unlink_setup()
>       NFS: Move the delegation return down into _nfs4_do_setattr()
>       NFS: Remove the unused return_delegation() callback
>       NFSv4: Don't return the delegation when not needed by NFSv4.x (x>0)
>       NFS: Convert NFS_INO_INVALID flags to unsigned long
>       NFS: Don't force a revalidation of all attributes if change is missing
>       NFS: Don't redirty the attribute cache in nfs_wcc_update_inode()
>       NFS: Don't force unnecessary cache invalidation in nfs_update_inode()
>       NFS: More fine grained attribute tracking
>       NFSv4: Ignore change attribute invalidations if we hold a delegation
>       SUNRPC: Add helpers for decoding opaque and string types
>       SUNRPC: Add a helper for encoding opaque data inline
>       NFSv4: Allow GFP_NOIO sleeps in decode_attr_owner/decode_attr_group
>       NFSv4; Clean up XDR encoding of type bitmap4
>       NFSv4: Clean up encode_attrs
>       NFSv4: Add a helper to encode/decode struct timespec
>       NFSv4: Don't ask for attributes when ACCESS is protected by a delegation
>       NFSv4: Clean up CB_GETATTR encoding
>       NFSv4: Fix the nfs_inode_set_delegation() arguments
>       NFSv4: Declare the size up to date after it was set.
>       NFSv4.1: Fix exclusive create
> 
> chendt (1):
>       NFSv3/acl: forget acl cache after setattr
> 
>  fs/nfs/callback_xdr.c             |  37 ++----
>  fs/nfs/delegation.c               |  52 ++++++--
>  fs/nfs/delegation.h               |   7 +-
>  fs/nfs/dir.c                      |  15 +--
>  fs/nfs/inode.c                    | 138 +++++++++++----------
>  fs/nfs/nfs3proc.c                 |  24 ++--
>  fs/nfs/nfs3xdr.c                  |   7 +-
>  fs/nfs/nfs4proc.c                 | 168 ++++++++++++++++++--------
>  fs/nfs/nfs4state.c                |  22 ++--
>  fs/nfs/nfs4xdr.c                  | 245 ++++++++++++++++++--------------------
>  fs/nfs/proc.c                     |  19 ++-
>  fs/nfs/unlink.c                   |   7 +-
>  fs/nfs/write.c                    |   8 +-
>  include/linux/nfs_fs.h            |  35 ++++--
>  include/linux/nfs_xdr.h           |   9 +-
>  include/linux/sunrpc/clnt.h       |   7 ++
>  include/linux/sunrpc/xdr.h        |  94 +++++++++++++++
>  include/linux/sunrpc/xprt.h       |   3 +-
>  include/trace/events/sunrpc.h     | 106 ++++++++++++++---
>  net/sunrpc/clnt.c                 |   8 +-
>  net/sunrpc/sched.c                |  10 +-
>  net/sunrpc/stats.c                |  16 ++-
>  net/sunrpc/sunrpc.h               |   6 -
>  net/sunrpc/xdr.c                  |  82 +++++++++++++
>  net/sunrpc/xprt.c                 |  34 +++---
>  net/sunrpc/xprtrdma/backchannel.c |   7 --
>  net/sunrpc/xprtrdma/fmr_ops.c     |  13 +-
>  net/sunrpc/xprtrdma/frwr_ops.c    |  53 ++++++---
>  net/sunrpc/xprtrdma/rpc_rdma.c    |  32 +++--
>  net/sunrpc/xprtrdma/transport.c   |  43 ++-----
>  net/sunrpc/xprtrdma/verbs.c       |  44 ++++---
>  net/sunrpc/xprtrdma/xprt_rdma.h   |   4 +-
>  net/sunrpc/xprtsock.c             |   4 +
>  33 files changed, 866 insertions(+), 493 deletions(-)
> 
