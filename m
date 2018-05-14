Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeENSDl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:03:41 -0400
Received: from mail-db5eur01on0083.outbound.protection.outlook.com ([104.47.2.83]:56980
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751402AbeENSDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:03:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Mon, 14 May 2018 12:03:26 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: linux-next: build warning after merge of the rdma tree
Message-ID: <20180514180326.GM21517@mellanox.com>
References: <20180507094454.4a71f8a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507094454.4a71f8a2@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::32) To AM6PR05MB4453.eurprd05.prod.outlook.com
 (2603:10a6:209:43::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4453;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;3:mXnkrVergkZKF+2+oaa4HCzE2tH1wtxaMt9B6nHq58i13feIk2PXufdRb67/6jHHY7QEYdXfMJHkwUucl2AjvLWX8VpsCrfv/UGOi26ri7iXQkSbpujFRnJAs8kUXTkugaGXEU0ZGgNF2LUj5K6qjtCs07V7BKAhtSKyPnaSobBb6p9iJm7zvmmb+2bouFnalTI8PETV/9lIvGoxY2kBekC67CuEZ7ZDNqOdpuQOPu+RJzCaovdRuLjyRIpGT5D2;25:hAeejpY8JZLsxprViOoZeaTo2d10NyFTRfNqmu2pLZL9Ap7KtwJA3vkuSovO3zajhsLYNwTccg14FqfteCMikVFMGgp1ehicgwFMAnVIdOp+yRjJyOCGHf6s8CCZlN6i34SckUOjPmiEWrOA99qIyD7G2TiKjPCYrZDMs0wwWnsqz2LpNzcxp1DGukv39H6ikB0DIQI3bD5qBC2Dy7kMVeUBXqgIrXFtZsh5TnOzavpUBMIJA71UlF0Zz5HnPnIPJkJQCTexnSqC3koEdxVdjuqQ12Yw8PK5655T8UQakxkQud2kNxbM3jKk3nWaCyovFJ+zDAqW9hlSx5svFHBaMA==;31:e6/fdxgaBmV3okXvqtp4MdZcuas86bsogvhRPu6gTaJVnDuo28lsC3caumrVDJz7v7w4dzD6ZnGjbmXeIOaWYc9Uu/IrGi0tX23tWLIx9epkblGc+IRsPlmwOSkggM1yXJE4z9n71ATnrVvJBamTQe9E5V4xwddQajLgW03HpoiWe4OVdy10KDwlIjbumw3Rt1dJCDcmuaZtt6mEkugPjPgCnK69XsO9l3WIaRNiIDA=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4453:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;20:NXTkDvSAJV8zVpz93n1BnN4Vfxf9WbtW3F9YuZF+mVH22kHqaA+2jTgpoSXC23WXdcPo67WoNPFcEnmLj6XdPgoq4gRmU31qEHocbGi9fLrFCiDH5QkpuGVS1iFXpYTYHbGCFXdwp42R+roVow4gtvKksmNifDQXcWNWFKSPjJHwQ2SfROYQ9rJEwWKUSY+vCUeqUUtXtaI4sDEWM1UYDWjKC27MFcPJhpUv1zKyeFMhe+Aw4TF5Vu+xPF/tLS2ncWgbVTcbjFMcp91ltDiAz+HoEt70oJ0D/vsUH3SeK/uyVUYEvqhG/ZXhEVeTCi6Hg/pb4RKl6hEWJWK+0xqKP0M+D/gwTQqObYJKwYcdHx7JLKmWN3J5iZrlLfyCgsq5rYdb7h6LMld+Wku9dSCd6JSXWiCOEsPEfjqgLiN1kUaqq/QKikSYl/rDFT++GK+qS2SmwjkUS95DxUpEZ4ByeYx8Fl/4Av0qE3hk81E4dNK1ZqRE4IXW0d0U5M31XEBi;4:cCdFugFdBLgBdmeCtwkqZ3ExpPiEoTdg834uNxVuJmWic1Z7cflWIIdVO0pIXgUxDMv/T/toQoKd08Z8vEoahA3HAg3FAE4pdUBRfdCMPjlFTzZXbRR1dCVE5cBHafpA1/rlbEPRqKRV0ZM3lriTbbwUTifQYyjtmGD9ivEHVoaPxqH++7MVQIGZH7863RHBdD1D3vJ68Z09yYA8IL4RoHUpgkbrWZ9EmCyz0j4SiSueqOQwMZDGTZtzrETgUf18z/lVH+M0ji4FMzkgvYYp9g==
X-Microsoft-Antispam-PRVS: <AM6PR05MB4453101CAD229B5157A15EFDCF9C0@AM6PR05MB4453.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR05MB4453;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4453;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(396003)(376002)(346002)(53754006)(189003)(199004)(478600001)(7736002)(33656002)(83796002)(186003)(57986006)(66066001)(16586007)(46656002)(58126008)(105586002)(6116002)(3846002)(50466002)(54906003)(316002)(47776003)(106356001)(53936002)(81156014)(81166006)(305945005)(36756003)(97736004)(4326008)(8676002)(6246003)(8936002)(2906002)(26005)(52116002)(6916009)(2616005)(5660300001)(9786002)(9746002)(122856001)(486006)(76176011)(476003)(59450400001)(1076002)(69596002)(86362001)(229853002)(23726003)(386003)(68736007)(11346002)(446003)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4453;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4453;23:HUwbWajKR9IfvAgMNh0Iuqt+SnQxzXohaIdYzTZBV?=
 =?us-ascii?Q?8fMcBvLEu8wQwR7dk5ASi4OZEgJTnFwfD4QF123y32MtpZiKSp91w+1bx9LJ?=
 =?us-ascii?Q?wA3kPzP8VhCkIB4TIemZNyWN2OXowb1vOZof8nSbKccaW7VV/veeGbBgcDit?=
 =?us-ascii?Q?VbpubZxT08twRm854oO4CfrtlwfiursCL5EXnyJq+Pfx+1y0W0+XUULuzH94?=
 =?us-ascii?Q?xooUv7gF1R4wDtAdmCAlRW18LfYfpJBwdBCZ81lE2zAkARVI/3QP9kScnL1A?=
 =?us-ascii?Q?LmCt6LJ/f8bllWAC8VDkFz9AMizgbYyV1bfxzrvw8lOWnrwW/jflpqDa/jSz?=
 =?us-ascii?Q?9ME1wZqPdJSbAnRwuAWZVn+GyKX4quCtBxd5RMp91jOEhA/atKwBIieTxLMw?=
 =?us-ascii?Q?q+b3rL1O8Mv89hBkdthmn6d9WHs9Hrt5BlUrVLfSX0a3ZLNBOdvWXVK//OUp?=
 =?us-ascii?Q?gEPO80wNaHQd0vFzrb2HxH5HLMzle9w0rKpkBbJw7Ksm9NSY0qrDRFdPHtor?=
 =?us-ascii?Q?dYVAmaorIusxQIM6zZPNK92WUB/abKezNJy1G4PxddTIc2l6tQOx8/7dYMj6?=
 =?us-ascii?Q?oRWVsSMWc1N6+f+98fNP/F/q46QyNezmoqnoTK2xoADKJ/Nj1xnKXBQvdmvO?=
 =?us-ascii?Q?yD9zLBR+qDbZd8ieMTptgo2NqSBdBN+I4yK1jwdUG47sfTxOxujzBwJv5HEg?=
 =?us-ascii?Q?VHV3WkYhagkGEzhH/JNilJaVJ+ldlGuPloLmzj/mhbRggTMdHvOsytvGKp23?=
 =?us-ascii?Q?UZ2X+/x8IgRN/q3skaH1DJF+gkxMGisem0qt2ZDI5MaCnC/98CqcxQArUXq+?=
 =?us-ascii?Q?ezDBgisoO0cy2K/KuUUTTQsGvOEAaUNTAKAH95KTOpJa/D3lPi3IIHaLiGif?=
 =?us-ascii?Q?akNoLa3Yu2teqFRhbnKJ7Rmn0iTqxHwXtUoRYt/mXSf8qecAxKXyV9eQ0LVJ?=
 =?us-ascii?Q?UVF4MDO6L0R/l+nzA1H4JzyFxShwkvr/KzqFlBIch/ZiMHhwgCHt291rBBYp?=
 =?us-ascii?Q?rhDvx7BSiCXkwBk4EEBf5zDmDXtzEHCAZ0g8GD6j5LckJLDo/6u0gEn0FmzL?=
 =?us-ascii?Q?qrBX38XBOfGSaqk/5l1pluvnhNf9ZuIwWiSAaubT2p19wQBoj6Vcrk17Z+IO?=
 =?us-ascii?Q?sIAp1rBRzugqyRzGqZvFIjKiZbwotYHabeavujBcpiWvSHnrNBSbJbe7hYdT?=
 =?us-ascii?Q?sQWFCRfAUd1m/07FOyVrZ3/G4k+EqO6PTCaXa+YPw2DKlwjbkdIlzRemTlcE?=
 =?us-ascii?Q?ysj6hjnzMl4IIMG3CtxDBcPn74sYJD96VVtbks0IMqPcWhvHJcdlYYRvNZYe?=
 =?us-ascii?Q?fWtJF2J1aG7qkMvoRk66mAqM4MW+7l6hcD+MbMNdqU+erJd2ZDZoeYutPwlm?=
 =?us-ascii?Q?bpJ2+tBc5VsYAzNo3PNSKeqhWx7+GJ7pf8HDwn9U0dl+v0O?=
X-Microsoft-Antispam-Message-Info: fKuqX4nFcRYfULCcst2OW/7EDNgsyJLxaJ+4R4WFPQX4DUrqOO8RqnbozXyuBH6BrVcnxb0nvilNc7Xvh5rFUGMgR1knvYoD7RyC1Fqto6cF8z6/1iBJ7Xi9vuF6u7cOJqtW/aykkS8L+Ud/M1gumzzHyISp9a6N97P0A3kHGT9LmYP37j9h3qOEtqQCou77
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;6:n1Zmrtw2XelfuLqH25z58epEaZcv3V3mzwhyhQuR9Z5GN3VcQnwKgCw7Sf4wCFnBc87Oczj4CdRgRaPxUMFPVFopYC7l2VNEm3FkxJ2SWDFFSpXH8mqqODSc1cEtMyKvEhhMWgEaR8G3e8OpIaI/beQTzPyZ6y3uJoJ4Waqy80r/TEPKIR7LpjyFXyKnqJDR0Lgks0P9qa11s46lZABg+JPFC6Iaxmhyq7l93Ft7+2oSS5mXumOpli6E3o1gUDu+H/ao3Jiz2Zhxj5k46Lnrija9ffWPeRXDHe0DhMelhzY342pUUDb3JRaGLuagmDqJsL6q//8UO293WQ9g5LwXJN7n7afq80ei7iKHWMfr0SFhj281GVG4xKVKWNeOZ/AbYvW8Llm8MH913HILxqPZNeY++RENmE1HeNHPMBgeL4erBivdHUHFLxcPu1bz1WmaH8w+I6643FgkQbhFOKJhaQ==;5:9p7Hy+VVJPGhr5lUH4g7lgiOW4vJT5uFhKAA0T4+Ql/S7sCz13K8Bf1MVxNtZMzx174zGrTrEEj9Jh24FNIoR1L26ifLoHqIMzYP49/tuhO0KEsqZuVF2v5WLpjEox/ySU90HgS/pm5/yyuCiEo3ZrpQ978/OLHkhafGBG7rb2k=;24:aRo6r86fRMRxGPNnMsdc0UamywOed0yZ80MKV2EwpKq+C12DlZcTAVYX9Kbs7zQyGJ/iQC5ZyPfmPf/k+/oREtjd1F23rvXbEsKsnWK2VSU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;7:BvWHm8EDEO9okUJNHm0Vlar7iHIc6g8N8EMn9yGKyDPy0xz/3HYpg/3p3cVKO/OhDH5KSFUgWSF6CYfSZPEZLKYJ09MCFkMfVChnriypeD5wU/BcenP+W92wwDcACG7mOcqdu0hPixzeUgUIRuQ6wpeTz4b7PtIaDXtSkyDKkXgHi9kKDx3ysVSDL3ew4pGaw9EKa4JdsrghPDsY8wfKYR5u+3IsWwVxmX4tMci4HhmQSzM47oih8PkHzPUz1tJq
X-MS-Office365-Filtering-Correlation-Id: f7df9f9a-702e-4724-9cbf-08d5b9c5023a
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 18:03:33.8165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7df9f9a-702e-4724-9cbf-08d5b9c5023a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4453
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 09:44:54AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/infiniband/hw/cxgb4/restrack.c: In function 'fill_res_qp_entry':
> drivers/infiniband/hw/cxgb4/restrack.c:140:6: warning: 'last_rq_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (rdma_nl_put_driver_u32(msg, "idx", idx))
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/cxgb4/restrack.c:180:20: note: 'last_rq_idx' was declared here
>   u16 first_rq_idx, last_rq_idx;
>                     ^~~~~~~~~~~
> drivers/infiniband/hw/cxgb4/restrack.c:140:6: warning: 'first_rq_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (rdma_nl_put_driver_u32(msg, "idx", idx))
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/cxgb4/restrack.c:180:6: note: 'first_rq_idx' was declared here
>   u16 first_rq_idx, last_rq_idx;
>       ^~~~~~~~~~~~
> drivers/infiniband/hw/cxgb4/restrack.c:228:6: warning: 'last_sq_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (fill_swsqes(msg, &wq.sq, first_sq_idx, fsp, last_sq_idx, lsp))
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/cxgb4/restrack.c:228:6: warning: 'first_sq_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Introduced by commit
> 
>   056f9c7f39bf ("iw_cxgb4: dump detailed driver-specific QP information")
> 

SteveW, is there a patch to fix this that I'm missing?

Thanks,
Jason
