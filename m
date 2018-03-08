Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935874AbeCHPLB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:11:01 -0500
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:2525
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934924AbeCHPK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:10:57 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 8 Mar 2018 08:10:42 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Leon Romanovsky <leonro@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
Message-ID: <20180308151042.GA6773@mellanox.com>
References: <20180308164058.2ad5a158@canb.auug.org.au>
 <20180308060920.GQ15340@mtr-leonro.local>
 <1520515725.3126.88.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520515725.3126.88.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:301:4c::18) To AM4PR0501MB2852.eurprd05.prod.outlook.com
 (2603:10a6:200:5c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca981680-8f4d-4228-8f3d-08d58506ca2e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2852;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2852;3:nStS2TC8j4mzjlrji+dtAWOenTuf83m4Y6zcxB8wtYYwHOBLukej5Gd4cHKR7GLdcLAxBx0DkGQiswk5MZXaFAioHRqLzkI1rSYlQT6No5LVV8o/2yovBMCc+wgurABkfarsBuU41Nmrkt+X1KjDRayvgeCUdsHJ3MVJdxahfmc/65ytxIieEFuGP5O7MCFhA8IE1XC+rePhpibQ3eyRLgQkO3Xr65mwwvQL3iyUjJobYatqXWLiZ0e1rvcLSkSo;25:3XbVZRQOa4vNgteY6Ns/yyCP91szRbD8JiTjl7FzqoRj3DnVZpKsZOsswmfGDAx2FE26ppm+m5Myn9kJYDpggENWMW6gGvhRHkaRZrWgb60/mFMG373jP8C1YRNERJHr+whaIsilFcfZheAcJgdff7nOkGfhlMotCsCLSmCEL5b6qLIKsxzD07BljdDpS8v34sIfR1oBMad9bCva48kkrKfg1da2jzr8npMqzUO456yRj1AGe2QnbVwmhkIn45LRIb/nJ9XEEFqmjbGQIbfCx5I+wSORzIhaCmnNIfQp8GJ2hoDoztQI17PGoJR5iUoi1FFjEzXJpG9nEbrp4ddmWg==;31:r/RMyl0D+XA4sMGFkJu3r+9kOzY0ScRlpez+E7/5FVu5F2O5POCh8EqgkKDioCYUnCvjLAOtMI+IkaJIZF7w8QqSiV/Ufx8sS/AXRC+yOtOrmT5Q+iUctSMEuWdwFJBz6Jfq4pGWt0ikg7VjtT7jvlN+aADg+vFCC/nEHgZy4/3DQ5Op0paE6Z+a+WP8d+ZGthBburEVqLiW3O55iTB+ZJXjJBmNRX9K32q+keF3kb4=
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2852:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2852;20:0w4NQCL3DI0BES4RVtSH64VMi4HiG0trXePSwJ1mGeLKwqGUeBxfWtUYlu+3iV1nqjaMiZOznZNwpM6Mm3cR+Z0itd0MOQ2tMM4TEghuso96WcxfjJntgxNcId5CPg2RTZ/OfN7u5iacEDTt2L1Fhp7ikVnwoBKl8izZDt+8DTXg7h2MPfjYGMtvIgkpbtxDhp5Qb/r1YoMO7KOViQxuK8eEA1Yiv8HpZXhIFaRdUyneXGHNs2MmXkNjDDYxoHgWSz4JVCyveM205/mmwOAZjPBAN05z23VnayzP6m5++zkI/gXPBBiWCZPLDKN60vqoicCSw2SwD3XadYmxV7kUM4CrLksBOsuitJvElpAZVBwm4MKZIXbEex1qNew3Emat8vDvtT40ZmUIpjB79L1LiChii+wn92YfbJQwS/eb09Z0IWw2k2hCuvrBlzDhmetQZwexrxMLMoBy5Y5Jyu4q/A0jLqUzzumZjpLmJiDhUxrwsAOrzSGWKAEfWqsTadmh;4:XoAwblTphQu9QYB8X25wuaK5gypX43d/cLtsdsjgYyQsDcpotgUQKnLU13TD7i72NlXZga82O3LKgp5Ao57ydZW6VEpCP5nsysAaTCs81dpYBZjWKWM7Q+xWz80NtKUBJS6joZ3q3zfVB9QasJJCADIWQMYi0BoMi/H/yYbb1+djl8AYDKGs6ONfWWh0Nuc8XnGbJHeLXbsTiSW6RC7jXhObLtbshHy8MaE20mSmpygVuIhzUPqzTteULyxomaaiK3Lwe7aZJl/gX+Gi001h+w==
X-Microsoft-Antispam-PRVS: <AM4PR0501MB285259CE385E1669CF0E3301CFDF0@AM4PR0501MB2852.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AM4PR0501MB2852;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2852;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(376002)(396003)(39860400002)(346002)(52024003)(199004)(189003)(52314003)(36756003)(478600001)(52116002)(386003)(2906002)(86362001)(6246003)(58126008)(69596002)(53936002)(16586007)(76176011)(47776003)(2950100002)(316002)(81156014)(81166006)(4326008)(8936002)(33656002)(97736004)(50466002)(8676002)(54906003)(186003)(6916009)(83796002)(57986006)(305945005)(105586002)(122856001)(106356001)(5660300001)(68736007)(229853002)(26005)(23726003)(7736002)(46656002)(1076002)(9786002)(3846002)(6116002)(9746002)(66066001)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2852;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0501MB2852;23:6+Kztv0MxaHOfL51/XgqeWiSJoe/OI+UJdI2e0I?=
 =?us-ascii?Q?T4TOLVst0IFzPDJf2hia4zJOWxZcKdaSIKOyXJ7MNpJTPaXEGxPCOEkdyatH?=
 =?us-ascii?Q?KKYM5QqZZFJ5p6HYsX4YOGGTfT2VfCNFbgejR8UyI2Ph10A/JVvDYj9pqATi?=
 =?us-ascii?Q?gv+A6khq+TS9UrON7ifhTcpftQWbpTVSjaZ7txo4Ghk4BShswfhLGH7lSIJ4?=
 =?us-ascii?Q?MtJNb9nyenJtBT+FJ4CmyDGEduV5cxLkFbkkkORYjP2Z/DUZuTTcwbb4d/mE?=
 =?us-ascii?Q?9vSmETOu+2QsYXlYZukGzLO90akzbevdFlx6wL+6ptTQXLPw87mKXALVrw7B?=
 =?us-ascii?Q?oZOHVHEogV8MVpSIV/SyGNtGdWO5x+uZ8h0Xa6iSi7KG/hYmgfBVUx/tJnua?=
 =?us-ascii?Q?mChXZe4X+BYuOi6hbHhVmOBudzLyzY5X4aDOAD//+LoE0sharpIHG7UqtTzP?=
 =?us-ascii?Q?aJIIUEiSGyMi8lNeAgvotleRJwxH0vNxd6sFyBKQ7x33rc1fZdGV4wThNV/H?=
 =?us-ascii?Q?aQ0ZfP6bNZLHDHyqmqr3ORMmf6MucWymzC+ldZPwHT1bzkdV0naWWk/f0L2n?=
 =?us-ascii?Q?ocw9Qz18eX0OcLFLwr6zgDDjWez22iyZYMxJ3X98YsHMkLPpbPGAeyFlvl6R?=
 =?us-ascii?Q?MNTR/7Lr4m+J+sfbRsW3WNK5JeviSZi12WNLB59Ic0qLm3c2GLmUExlNcWLs?=
 =?us-ascii?Q?B8OM+qrJpCCwPrg02ew5vbGdt7k8uo1kQF1qP18CL948YwOEcFPf++6PVPfI?=
 =?us-ascii?Q?JI7MENOsfbRDl6ZzZWRUL2jlXjrPdTv6jY0ntDx5Ouz1G+KtjqrrRJqdLdrd?=
 =?us-ascii?Q?qEHCV2dGDemCbQuSs4T0/TDi4EwrteyUgqj+L1N3UQIC6Gd07au5ifqYQ4B+?=
 =?us-ascii?Q?LHp+oE2WpE7dsNKuXBOu/MrPKusdMokDaY1I58PDu7McdQsXt077Aolono24?=
 =?us-ascii?Q?3csoq2AliMDsw1nLXOY/Uz2UsrCrRS2Un3RnLzOXZumajYf45kFajRbvUFSp?=
 =?us-ascii?Q?rPyvE6t3FtbDl11vKmoAwBRqaWD9PtybQ5lc4BhdGs6YADbuqo6+7AE2mjk3?=
 =?us-ascii?Q?YCGNujBjGTP1iIv4l77Seupy+es+XDX8bzdmBxSpXXhJSjep0nLEqAQY6Cyd?=
 =?us-ascii?Q?L827qQuFJyWinNmy9yHQeb+yKITSvEiV2vXKz1CfJpzRSL/a6YP1TUk96nqR?=
 =?us-ascii?Q?V4LnHsuZwLtU8bx2p13SUHPAtRGMBY0Ueo0P+3R0riEXggH/YmoZlPSeik6p?=
 =?us-ascii?Q?Lh46Cc4/XV3rS1ESDBxsgfeGqdQrQ0b/2+rx3SW0pD+Q6zk0UIlKrl/DUplp?=
 =?us-ascii?Q?pT6G3FRDIEgSTNH6jXA5ynG0bJi9fzAbJ0WEyweHNtFXx?=
X-Microsoft-Antispam-Message-Info: qFc0qBHFoieSJpFm6I3weQT/6AwO2ivK1lm4xYcFCdqVUvEmCnSENxTFng803yvHWtwJHKC9HFFf49r3Z3X3inFAUXNblmG9X/5jZ+Mm0TjrbHgp8rXd5eNWtcARfab0p9re89b+bsTZ+RkegaTVL3hD4Ao8XnR1iH2GhuFxo5UppNcaIeG51ozMibWYc7S6
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2852;6:ca1dTmZJiSCIKVoQI0YzTihued+o3wExrfx3AvUtSGepVEdPWJCgu2IM/LhphQQlUri2shwXZ3N403BWVx0YNkE/3J5pKXwImj83s/HLVBykFjzsSYAxQpcAc060CP5JnoCEqnNQVzwZ09Aq2duxrchWzsnsR3UMLRmFMeD3X3zbtyhh+2GYEC/ZEXR6VPrXx9eK+qv3XAknaLpF+SxHd/S9g3ICzNx5NycTJ6LCHusjZLUDX8bxKipgUCoWale56HRXl3QtL9S6swJT/bSzKQ6LMhV3TXvvtz1Jv23Vyonz7I+mOprEEfQJJ1tLGd+iXhRnHUx5A+F8j5oGoFjYo+4aaztjTVi3XbjCwWTupsk=;5:U8yi9cT1K5+I7rMb8e7F/ZlUlWJ+g/TSML1/JRvEZmtr16T20VF96J5hQacOKUGYlsYmcMrJzvBrfb9gYkBvcJG09yMIQTT78fpJaKKl37DHdPUAO+ZcXYHqW9IvLs/HbhTnDeLnE+bg7NhBgXqmkIxgTbDDkuK8Bb+IPZ7O05U=;24:YiTyW748JZ0Lu0oyxiyuP4pedmtR3va9keq+YjHdPmSCmVqw64ffjFlZmpAU4eSFSuTrSrC7bcILpHje4c3z0H8+JsPxsEmCTA7/hwMv51g=;7:zaLEkIJkjjrKkT8TyZ7z/jDSZEdA+uNXKSfZcSsdF0ymaI90r9YbZuCfSmvA7olXGWCdiybPV8fva23jZG+gcv25QdnOFSN6de7NOYmUeunawnTDm42rCcxa2RFUSD1jbNDJ37bFPpNwE0Zr/1xTv2p3Lu+phq/uXigYR48jmB7wUBdFWyKh6NZ184R4F08zsvSMa3sun88dK6wjQspoGTdoOKt6RkhRtRkbbiTYC5VlKMGBGX3Nvz5qlia5vPht
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 15:10:54.9265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca981680-8f4d-4228-8f3d-08d58506ca2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2852
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 08:28:45AM -0500, Doug Ledford wrote:

> Anyway, I've hand edited the mbox file and I pushed a rebased version of
> my wip branch.  However, during the night Jason must have moved my
> wip/for-rc branch to the official for-rc because it's there now, so the
> only way to fix this (that I know of) in our official for-rc branch is a
> rebase :-(

Yes, to get it into for-next so we could send to linus soon

Jason
