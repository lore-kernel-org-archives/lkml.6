Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756038AbeCHQTB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:19:01 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:7072
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752059AbeCHQTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:19:00 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 8 Mar 2018 09:18:45 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
Message-ID: <20180308161845.GC6773@mellanox.com>
References: <20180308164058.2ad5a158@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308164058.2ad5a158@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:300:4b::24) To VI1PR0501MB2861.eurprd05.prod.outlook.com
 (2603:10a6:800:9a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f555ac77-153a-4526-38e3-08d585104b3b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2861;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2861;3:whzZtCVOs2qeUtM0LI+rVN7eBKuRMPBM5giQIJoD29n9LyG0KbQ5QHjae9PF1JydvYwZ+/n7aXn6UIBBYqYQA1qgvrdHe5ShMwz+OPn/xL+Jt+Kr8SiHjnVQHFvPLfzlt63bVyou+FVsipBbvfuToOILeAmjDnpFPQhB1e+6Q1nisvkEGdfnPYl1IgpJGUaqwZhEi+iaYt2dlUoLbkqx1FERFyncJsIaylDldY3fyWM6fr9hfSVqChGGRD49HhRR;25:HwNsgpm72Qfs0VWquOaAD4bl/tLLioqxRk3/bT04/6JoBv6dmhlAgO4VLQoJe2AyJva1M/xO5y1yxsMcsZfdLeKU9MhVMfNJXATxWqTrY6qFwvtcbRLkIGmnHniysUZH8WI2zJxOZhzP5a30nYN55Lsuu5vwkTOlk3xtKumbnZ1q3UFauIy2NTu9oK6pIHKTETg+4BGHhi3xL898pLn6vzqnFspBksOuAayf/UbTf3FiIdBviivlQONUh3Zq8mRPTzqnl4SFhpm9ZzTmCRJ/jWS1hPFLmuw7fMx5MmW6rBAt15OXF58nM0DZcn+0qo4SjqbrDfS5RgBA15drohW7Uw==;31:Jaryh18ageW0XPIZ60AqoZjplBUKKsaTK5oF8KdYwVRnhWinMLmLiPn1lqU8CIYTfCN2OwJ3KWRvJt9Setxt5FLVzFk3mq6DJyJL46yBxseEX8ZVxjvRNrIIYRi02IuGmKK+6QSAU5uvUPNbvxP1f3hLgrioZ9S5yev5eRNqcrQSHECBfMVgH9w6Tol9/mOvzVXtnPZNXCxY4GCh+z9MnPZhHhieGeiJUpa7S5aUV9I=
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2861:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2861;20:QkClhlbLXXQzWXqoztvIAKtLMnT1zWH1Id6ltN7ih112DB/pHhBJA5AZSaKELq40d44WtwYExYpePjyAq+AnnP0ZtdYcVcWURHZcPqEhze111nkBWnhl1DCtgrDMocSqefFOUSMa7C7V8cf0bZLG5pKL2apg9crmiESL8r7T+fEorEa1EcFrcEgyMxqKfGD7mH9rV5Ecm6yoa6VVLf6QJ28RkxlqesqYueC2SA2WjSq+tylCCOZucBMGemhbN0mvdDuxPp91ugCtVDQj+pCzu/v//LbTXKj6UEFcokvIw2ECJAU+XEYeBvp3ZrgJOHIuPYfJaprTwLJMd+RBk+Ts8/5Flu6IRR+82Mtatk6SYTUamWVV2/TFe4+90axLWTDt59DtBxk+8LOsc762Dv6F8KfUA2kor+Qtj8ORsjA/SGZnjJDxfhFCo6cJUluTRUN+SyruxmrJvP+PcHKZDXS88uyXIo5kgCBcDqo96bMq4pxRENy+bmfSa19hJOM8OBcz;4:AnM9Kp79UQpBL12K1O8A/5xyOFxl4k+dAxaCaIAkX2DBYerfs0Ehn3CZRx5/CitZegGDEATXtbKLD+0HXvUeTDX9HD26zi/2wxFaZoo0Bp9sAry8wFZNieCx1OpUSQVSj+d508E/SkBiZJfsYOI4aX3MtSoaVkVaJQ6WOXyS/Wr6/kECpu0pFwhaGMB4sDPlH4lBoxPVF2nMWqB5zjptycggDP/YWMsJ8kDJXgzZkl3oAu/3ay/B17p1/hg38dRtQ1T6kplwDAMpKj4qLyBIrQ==
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2861AB68102AF9166DB441ACCFDF0@VI1PR0501MB2861.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0501MB2861;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2861;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(199004)(189003)(53754006)(47776003)(105586002)(68736007)(83796002)(57986006)(2950100002)(33656002)(107886003)(66066001)(46656002)(53936002)(9786002)(9746002)(7736002)(478600001)(305945005)(8936002)(6246003)(5660300001)(229853002)(4326008)(575784001)(86362001)(81156014)(8676002)(81166006)(26005)(106356001)(186003)(122856001)(2906002)(76176011)(386003)(16586007)(58126008)(110136005)(316002)(69596002)(3846002)(54906003)(36756003)(97736004)(52116002)(50466002)(23726003)(6116002)(1076002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2861;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0501MB2861;23:mWf/ZhlWCmh+3DwIqJ9e1TXek0ahKw+Kbbr5Egz?=
 =?us-ascii?Q?ChfqrhTDZ/aOansb/jD3whLrujGwqMuV2JKECm1p/LMnZxEm1Discpuw0Btg?=
 =?us-ascii?Q?N+FROX0U3sjaDtxI5OPNtmRSZavvQ8/Gc8si87BdLn1pZ4IZ60OSyyGCRv9U?=
 =?us-ascii?Q?lS9CeAFyHlRHXmXTKspBbFBz083cQPB+UcCfiiGGegSgUQz5kdpP+/f50fkZ?=
 =?us-ascii?Q?LcfnE0xBXbqmfyELhD2Fd2SYPitHNAmVvkzmiJBysDQcbKjjr22YL4yhz20O?=
 =?us-ascii?Q?D8pWJJNGDhMjQ7b4CdGK0x2WF9ZiWDuxHhRl4Z0y7zOZZj6pKGB+2gKH5WiK?=
 =?us-ascii?Q?jY/YmladNqAPMcZGFv07YpNw5VwhZtnKRVlFHQ32XMbfCZT+zs8CYN6FWR2a?=
 =?us-ascii?Q?38HCeASvo5DWNcVSEH1emy27VSYThVax03WySSpEHlz+pEebCCNsIFX3WIHQ?=
 =?us-ascii?Q?MSUDI6N88UEv7Oc9HdeiEXzovtRL/1W62KhTeWs6pdW95tEjTRlk0g9rB1WC?=
 =?us-ascii?Q?zdqp6SzGXdiJBpK2dRAmX8l8ZOe8Kc9UJ74806vhgjQ67kO/1/M0tD+nvRQr?=
 =?us-ascii?Q?Ip/bFR/bdLPc2cO8f8rKQOXGPWv/QxrOL6M3tbhIWpfLtvcEz9btkcaNf940?=
 =?us-ascii?Q?E79E90RsP1Tq7alPNNPZ5g6nHoPJobj/9NbBUUZxPP2hf+xARw91JxGq7rFq?=
 =?us-ascii?Q?RaITqEQJ3c6Fkj91pK8b/SiqjkZbKU71M4gO58Cle9u+B0JtesYax2wT1USq?=
 =?us-ascii?Q?xMonaoSRxvjODSfIn7KWelcwrLpHazheZUZjk5pZ76/uvFMqB9XQ7XlFav3b?=
 =?us-ascii?Q?iuErDCT7eWTklzeic4deo0hasHW2zpmrEQhSFyuntctyWAwjQbD3QXS2FfSs?=
 =?us-ascii?Q?jRjfUJHvJarKkA2yldpC+EG+1KDamTM30ofoiAHPwWfeyH8OGb3q3Xh8jw7B?=
 =?us-ascii?Q?NwzbsuxI6IsPdNTWjQkP4/TcSRf2ZoBqBGtXWBxcM3Xi1EiGdDtaDkS/U/f/?=
 =?us-ascii?Q?ZNCIg0dowWnWDEexxAZPo9UxidhJfLdJUN6plGJfJZdWAYE8SAiO8XdtEO31?=
 =?us-ascii?Q?qzN1PMrwVlL2FPIqAvpI6PM9yBPJiF4SEFsnCerkVb6AJDaazX0HOEl48+HK?=
 =?us-ascii?Q?DnfG65n9eY+yFdnLybuMabycceIUCA5Oj2NSwMwRm9vwQDRZ66wp70F9BFCT?=
 =?us-ascii?Q?K8B8ngHQJl+APkGEcNkkdIBNRuxaNr2DnFh9+91W4njcLpgYtDq0JqnyLx5O?=
 =?us-ascii?Q?VMkRn7wp+RACMp6o9jlPxrsDnqRr7sI7kO5O0CWX53yCZfuyDA827aBYtGLp?=
 =?us-ascii?Q?ybNzbswn/KXkoYFGHbkFWOEe1EBuAX2z/upZ1MurKBNbIxjEG0y45QAjFw2q?=
 =?us-ascii?Q?M4Qctiw=3D=3D?=
X-Microsoft-Antispam-Message-Info: AuVojrss6/OK2suz73chSDR9TZ/BR13glTE9DDqvGUGAq66mcW8i9QdAGddT++3Gc5cLsYxRHcUaPE5F4zHyJ+UO16ngewcwIJZeOjkiI2kp4sgauIW0Y/5iuUMfo2WwbVTGIel6DDl7rpKL4e/sLkcrqrjfcQ1jJI2VTf5gbJ0gtq/+I6WEX8gqelnCnUn4
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2861;6:vSm2QFZVj+xLj/zEEo+qIy67+bskwKu2FS6+a4ase9Asv24UqnzaqVXiUPYgJSDKiZnhgaIUjNfYuW9Zbrez3SWfqaGXE5e68qpzRLTw67pjGuNDKkDUwrL2bIJ422vxGWugeqPm6EGA7d/63W3JJsj3rr72ZDfMuI55dnjsMdSXs0WfIh5zauGvWd0RzJH1RrwLqWga+aCfFVe9AHFFIwiR2PPzZuAjCG/NhJAOpLxQ9VsoZp2UOMNqugl4O8v0i94A2pohGgMJfHAeKG8AROfUYxfku6K1XcIa7ZzcKnv6s6nSPnUhoXh4rq1Km39mIGTrMDXZZ7s0Fcor+anuvyKU40xy9aW5RtGTVkrAluQ=;5:O1sEq3X17mD113N6FRgjV7md2bS6KzZNoc6bBvzYwXs5arU8GpV4jd48PbDiaywt9kWn9MHq/jN5o5K05Zv3fHN1eDjMyMMk4o1zd7nMevbnV+va6woK6+I5ekmwreNSWstzbt4TGcasf71/db+j4P2O1HiNglzuKyKPPKJdMWk=;24:CPQw4bZAvsBqC7e8oJFZ+Wnel+mWqS2wmmYG/MWZMsiv+555Z7fRPrpOcqA+2B76iAVhR/96WxMNVd1KmTSnhCjXcUA88iLRRLEZYqUPAgM=;7:G5Ct+ddmDPzA/dN1SyE5DVIpvoyKgKWVJcH2TYZULC9dkqM4jApERGqTemmHTor/j7/boG9Xgmk8BPGC2hflLrFcdJFIyavVlqmKfzmg337EjqNcpNM7VXoVBXTq+PodY2z1Qb/c1j7rDLySNKkqxEGm1+GgmcBt5zGSFLh2s8eZ4Z5A4vqCmQRKPRoYvgCbWstGeQTWK+rzDQy7Gfi6nLpLnTzIuxFLerqMuS2ap4GzzcGMY8hNWKXNPEQ71d+8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 16:18:56.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f555ac77-153a-4526-38e3-08d585104b3b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2861
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 04:40:58PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")
> 
> is missing a Signed-off-by from its author.

Thanks Stephen,

May I suggest to the checkpatch maintainers that checkpack should look
for this too?

Thanks,
Jason
