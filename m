Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbeCHVjY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:39:24 -0500
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:5536
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750783AbeCHVjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:39:21 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 8 Mar 2018 14:39:06 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the rdma tree
Message-ID: <20180308213906.GK6773@mellanox.com>
References: <20180309075119.7b536dcd@canb.auug.org.au>
 <1520542871.3126.116.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520542871.3126.116.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR22CA0071.namprd22.prod.outlook.com
 (2603:10b6:300:12a::33) To DB6PR0501MB2855.eurprd05.prod.outlook.com
 (2603:10a6:4:83::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edb17070-4a84-4a88-a6bb-08d5853d0bd6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2855;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2855;3:rhS7783FsfwzVZEjIcD5Tiz49lXWfTahg/GrVe1Cjv73XIr88ReuVahnTbKaVBGOAWxMGEeKUC1taQzZrmHm1nNtzwDl7gW3Guw4WlmqNijO/LF5/OqA0ICRDUdvLX5TuNaiFYFXmHmkHNixoA8s9MFUQ46QY3trrHphWsxQ730Ugf+bG24EczvzgRGXj0p8HTqRHoj/+zJsWcKN489iiOqW+/GdEhvEYMMcSayqxarVjDlvY+pqPrLhnFDhS7P3;25:cdITKYY3OMYi2s7ZR04KwGxEKaap4hzSo42fPR6foqniw9XgYfchF6waK86f8vDk+UcOWqsV+38DCwFNXnwuT3QIYOroJjPZY/W4ZbuAFoRWc649wL3X8WrYax3/Wakgao38Rne6CUedsjrR/qbXv3sORaBkHJjS04awPhIJV71WZShrttLpF+R8UK67E/PwmY/sUhzeg6WYls4TJVr3xiJFQ8pfVr7sq9uiR0sxrAZ68CBQghviNaxroA7AHYtd1y9jwOWZWkIJhDn3zKIGD76nt8HMzc+mJEf7OW02xPI6c9faCCnP3gVW7klk+5W5OD9xeXjznINcvOxH3bdhwg==;31:/WizkSiDLg6E2DdHLDOfJPBNXOqBP8wnDmjyQYbJn/9ezqn90wv6421LekodG0dSx7J+yWpD+QPQUGMvKGaIR3PXqUZY+xIaHYDG0Vk3ud6dyoR9FjY7xstVKtPMvD4D+cB7gZCO6mMvO5xKWdizB7oe4mYsTxBsqJQQrM3BkdB1emHys75mZ+Rr6A+/2Ny33LSkMfqZ56jgMR302CLPJKD5K7Pnikmoj9l1o8QLlgY=
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2855:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2855;20:WhOiRnil5To3MDouA9Ayd4zSXtaJX5MpXASfVvnWeQ9N3grnUjgIEMpds3+5IrCIhMX6dqHzWxe27EiExYd1D/d3W4j6iZVAbF6b4yLqNbHwsDwabNfUF1/P1Ka9oDs6t0A718HiSkTp5iObCbgolUSxgs90MpLUG8SJQNqtCaGa2vPb7BkMpHInYxs9uZbUtTkK2Ar6C/t2aB33G0ydK7ot4sNXJlMrVuHjuyeFeW+NwqeQYeV2SAewGPeBs6K1Td0UH2Qk4qpD0+A9qMA+Bb8QfY/fte47+pPChLhBsP57jTp1ljBFNFqoqV4vuO0d3l8SjLdDknU//2Xo3CC+z1Pq0SK3R8SWunlIlEuGCWh34zjIRkK8up0iqUhEoBftkcgTeVAahCAI+OEQHLvw89Bug2fx5+3ix+yf+bxHnzAqUQlD8ajCTMpevysGyDBai/JBHp010zxHcv2r6qJVZdnYQm6hLjj26jONhFLvQUnOvBcjVkQ8n5ewpAyxNrmI;4:UK5kKAbdANVVDONEulNEVepb/+7vJDxu1P6BdNt+xgCBUKYbOQUelTyzgG7pMvdh6boxomiXtDvAL3ckOczcsB8H7Ti/Bw3OpENPiVX8emwphJTE8iOdg4K4fqzLdbfJVzVNR5sbH3DNWHRGvRkZPzTdtiCCp/PRin7pmadAsqxS/k9hjF5HXKFJL9MwykjKDoZmxB+jBlVU1O2CQK1n+6IbY/yazp3OpmYbrEXQ3y73PlavI4n1tJm2/V+bSOWYAPy/kMwgrSNcXq4YwoGm4g==
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2855D4D023AAABA56ABB430ACFDF0@DB6PR0501MB2855.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0501MB2855;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2855;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(377424004)(199004)(189003)(53754006)(1076002)(23726003)(7736002)(105586002)(6116002)(3846002)(386003)(106356001)(76176011)(69596002)(8936002)(5660300001)(229853002)(305945005)(2906002)(81166006)(9786002)(8676002)(81156014)(6916009)(86362001)(2950100002)(478600001)(53936002)(9746002)(4326008)(186003)(26005)(58126008)(36756003)(47776003)(122856001)(6246003)(316002)(16586007)(57986006)(66066001)(52116002)(83796002)(97736004)(54906003)(50466002)(33656002)(68736007)(46656002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2855;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0501MB2855;23:szEwQ1WhfcjalI+pvynVargAQMK/Uzdjwru3MnM?=
 =?us-ascii?Q?+O0X0gFU4bGB29UpeAreECvJgvCeBoDHYr+p6aOHjgdXfI3O6NbMeW2wjMXO?=
 =?us-ascii?Q?vvAhSspjVmcTNZf7ahX9SZquBWfvzw/Gyvs5uTasUQ0I6X1RdltABowKswgB?=
 =?us-ascii?Q?APMgHHt9yY8j/FeDEkip+ArSj2KaljFlpOEHZfpHYg26L/jtw04sffjSY5Hm?=
 =?us-ascii?Q?u6JH0PuOUG3lpMj81PcH2Io5g3Ka/OIGXUfwc8bTBrMUneG5dBLugxyJJNRk?=
 =?us-ascii?Q?tb/I9XzGjp5FdoBYtFITNyCfOjKOVumZOXMbpAY1J0vXZoSS4YUPZv99XNM/?=
 =?us-ascii?Q?TqUhoNRBbLRig0SuDr9OvuMts6MDxHE4Cl6tzenz7APVP68UC1E3Se2bvHST?=
 =?us-ascii?Q?lnyAI0pzC6Boy3lyId9CwX5FvHR26cNHKRM0mWJcVxuYtITGjpKqeaFIrckl?=
 =?us-ascii?Q?eQxPkdgo3P/ZtWE5rPhkKResBL6Bmb5TMTNAjyy5DXwMuv4//AutEqL3bQeo?=
 =?us-ascii?Q?E9r/dhKcRTEUqG50KqImr4i+AIQsnGcpGaMXYpHEM6J7u7+K2bMjb8L8GmoL?=
 =?us-ascii?Q?G9PmbRwH3wuV0IsUk8EzziJjaP8+ViZbUGc5qsgnsjcUYWSE6K6BhUJutd9N?=
 =?us-ascii?Q?9rh02ujsLCciEU9ZkyEjew4ixkRV0hVGAAl6T2UR9bAamQ/iGS8CqTWSc4Sh?=
 =?us-ascii?Q?q3ZryLJAoktK7NnD2pO9G0qI6plZSVSSGv9SVkEptRmsq1Uux97pgpdf/zns?=
 =?us-ascii?Q?uhaSincE2Qx+WtqU4Xul7GTVBM+RYIQzuC/pJxss3daozeg15U5iP+5oGxxt?=
 =?us-ascii?Q?SnE7pdv538Zevcvt/PzYLvVAsQpxaF8s3MHYIr5shRmCiQ20VEQNbGudXLmD?=
 =?us-ascii?Q?sov+cwd0EweU8/blzLb2p0rVJ2+IpgF+n+VAAioGcpObV8Hbhetef7mS4bYn?=
 =?us-ascii?Q?xsQ/E9ANTcUqyfqSu618wKNBcFKph9kkbQac3G8lsv4x10dI9dLjT1WsebZg?=
 =?us-ascii?Q?xaEjyzXAYT007Z/ujaTeBEDQzU38pK3Albhvc7Xwys8w6yjLJTLKuMbQRtxQ?=
 =?us-ascii?Q?uC8upm2x3Q41mPq4ejsnrV4rfAJDMHBNrKqIqtCrOvHhyW5vGFqqfpNybzGb?=
 =?us-ascii?Q?n0HHTHcqZyhpa81n6ykg0/gpEqXNFreFplWNo5DYO17WcqzAUBFeOORH6qil?=
 =?us-ascii?Q?CvbhEyp8syF/Dt3P3Emf6IU0XzJr64mPEDgvgxXtw8oyPGZrH/D/RZ8lYqcr?=
 =?us-ascii?Q?5dnBoKa759zAJzFLSrm08pfFMGcHFzocDarW+tybx0nnzHu3VORviCJ6XrNj?=
 =?us-ascii?Q?5cP7ml15Ov+/K1iZESY4tNqsf9rhzjLg3fcpeEs0UQdLp?=
X-Microsoft-Antispam-Message-Info: DJGtAUtdOwVkrdR1eKzWMTe1ZdPzZqzvv+mD62X/EhH7BxiappYNO+zN0/BbW4s46MmShXhllwBc9uDkRBgsamnARZKDkoEySfCI43mwj1KE+KpmzxDSrhP8E/hYQnhtov4maA2uw0O29dxy+QK0qJ11tJzoLV21ZEAm9pbZXeVWBeSks9yp6/3Go8tpXcJB
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2855;6:M9tveZpbdgVvlx+VsKS/LL6P8DMWKIwM0aQfUgMADwKFFxx1YLUTNU4Se2uQLMMurZ2q1bWZ2ZhLQtAWR8SOQVc9R0kXrfgEfQKNVKq6aH70kTh7I6sDzw+GjUumvQv2DGXxG0m/RI2TRWYb6O1MokLaej1Va+uYA3gy0fdLbOkfjmlubdCKzuL1PmzxTcdKub8XbASaFQhmWhH/cgqxsjJtyMADTVy3Hx4QSi6fMZMiFYO95mmjqh8nHvFQoOgKHlSvhR2TNdmHA27+tRxoPpIGB3PjBVPDUiToGeX3ywARjrl6fzFc110SCVsVme8kHCuwsGhxf/A6zkq5Nq1r1tGaM1NwRHKUFKUewcJaqvM=;5:Mrh1FdveQZj+rizLMyqRv2sMclhSmh3NjFbZhgoRKurQ3qnufTmIw6NElYUIK+krnXldDRs+Qwa/gQx/YYNN3duZh8Z3el8Nn2AGVtxeqdKdRM6jkSOFSoDKH1kpj3bSPW9QhP80+TT8jUPnY5GqZo9Moq7o7m54L9IUbtrTzPY=;24:WsvVlACQjnXxX5beMoL6fESLP5Jxpts2499OqW285SExRu0pv72JR6IpCikKbJU4NgrAjgQFLiMF/TFizUV9Yq7KSKTYzVNkvsEXjAni0EQ=;7:EujBAsL3SYHcv2TU2gvBWZCUQ2aaSlWf6802heGE5My6qQHwbFWfLokCrSLj0mEs3ekVq2AgE60KRpDH/eK4pbmSrDEI1WMIhBcFSrLU/rbm+MKTcSq+JWa6wcW5ATV7JqVS3XYuXTDguneknyTTbDvWx/pJmDsorjv9RHHf7JNYH76vbCOtpO9WaLCmR07qgTd33Io7dtO5bCn73tGbfRVNHyxasa3Zk/ucusjH7a+FutS5MgWM1NU16T7ndonY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 21:39:17.9190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb17070-4a84-4a88-a6bb-08d5853d0bd6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2855
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 04:01:11PM -0500, Doug Ledford wrote:
> On Fri, 2018-03-09 at 07:51 +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Commits
> > 
> >   63cf1a902c9d ("IB/srpt: Add RDMA/CM support")
> >   86af61764151 ("IB/rxe: remove unnecessary skb_clone")
> >   31f1bd14cbfe ("IB/rxe: remove unnecessary rxe in rxe_send")
> >   befd8d98f230 ("IB/rxe: change the function rxe_init_device_param type")
> > 
> > are missing a Signed-off-by from their committer.
> 
> I originally committed all of these and my SOB is there.

This is my mistake, when I fixed the conflict in our tree the committer
was changed to me by accident.

There was no change to the diffs so I didn't add my SOB.

Jason
