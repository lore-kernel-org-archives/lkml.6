Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbeCHRDh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:03:37 -0500
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:21855
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752087AbeCHRDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:03:34 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 8 Mar 2018 10:03:17 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Joe Perches <joe@perches.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Whitcroft <apw@canonical.com>, Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
Message-ID: <20180308170317.GE6773@mellanox.com>
References: <20180308164058.2ad5a158@canb.auug.org.au>
 <20180308161845.GC6773@mellanox.com>
 <1520527178.11634.9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520527178.11634.9.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR10CA0023.namprd10.prod.outlook.com (2603:10b6:301::33)
 To HE1PR0501MB2858.eurprd05.prod.outlook.com (2603:10a6:3:c1::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e741f01d-5d21-4672-5586-08d5851684fb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2858;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2858;3:jC2SAAS2gawvFsA5CrnJ6ODkfQVTp5FIwC/tyMMzYz8fTIoK8z4mgOLKAdokLvBMV6s56zCmTvCeCKwpNx7GBxvPlL+vbRSe0toJMKux2b99xSoBWGqY2H+tNFF3mfrBVq4DMvBnu2TZUGXotTXFGkkkLkxnXR9mPyHaqdv0XORBgP2yobD6oiimNbj1BtWqWmqLn8KZ57g0NB2L6a8uoAzzg2oZzXyRVfjMbXPyb+m8qzuD0o/2R8qnPYrM0LOh;25:a9aDNQjNJwdXFnZINIkdezmlB/X3Adex4q/PHw0rD6ypyV7IefmpdRqesyVcD+qDB730V9x4XuY+CA2qScPJG6pwBs/hJ3BY51kvcp91V+efpkVKll9Wgwr+P9CsARJb/PiXS5W+TtJt+I0clz0nC3sopz6zULASJmK1CfpYvc/ijz6viXtjxr4QWSHH4TEzGxJY7BYXagx+RUC30Lv2EjmbjvzQs3URNvUrXV/OMgTWv+a8ZFFgMayQc56U4F/bsLxzVZ6yfScrh9jCvofRcp9BPbb+c8P0Hg+/Hceiembs/LKrE5h4o6NhCnlHteFkkKvhvRy2jT6Ngu9DnOHu1A==;31:HAvq1ooktq6U/eer1a+F3TaeqKy1ZRjgWtg9+qt3GU51p0dhau5s/i+asIOORI/pVcELB2MLLxxikEt6PjIkh1s+C4hj802S6kFi5CUjkqGbMy2iv8dpKSZSMEr9DGc9OdO0YrqcLcISkf6yDtmWoMsGhCnVq+IHT2CwFDXGsA3eBjJR/ErwpWQShu92IAKKK+3YQ9E0XEPld/IqPuw4zSwS7ES/TPKJjIaUNNgZC/8=
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2858:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2858;20:UOTyOxyBbKJCEZUYj49T7X7JtYuXiPgxwhGZ0ArSR/FbNfOzsHQadDg9CTWA/y4RFyMQOoH4rZ/hRG8IcYC7mBmRkpCvPub1D0+WT7d65k8FXqt4NLPBKQkH/EHwfQpRLahmqVdHeBHUK2Cq03dc9QSggInLBzjE7rm1+L65bk7GbkP8baAUeoTZJwhPo5mgS2oyS2CXnPDYUsw3E8WA4XzO2H2BA4w2WoF8niDlVkaZlA6gOsGYu+g8jPF1+QHBPo4dR+6JJ0BqNYt4ETDDlB/0mZBAQ5Yt06IgQoNFMYfVvoiMsayK8HH5P/tT42jUQjg0Oqmd721T4yCprK6UG8q5zcPIORbSJ5SCQLm5AdNTHwovkWWWe2MaonuObz2vJiMTqniaXHcLRZun712uecSEsTYK0OBpYSP8coppaambT32TrSZmlYgyf6ltZ4VYhQ33A4PodWX5IWf/JkSUyP14Xz+8fh8IMwrxonkL0JcirCvGo+a4RIWTlBdxhx9Z;4:anxVf+LN2TlRcGpb02RamqTL9DMPTanVSGc/Y78izftbbUPhUnuo1VcOlvLqaRSdhiivYP7UHQAyzQqnq0ROA4VNDA0wXBEXC5Q6xqR+IURXQ2pVUYeoImNNG6FNRnpsv02lshTfd5C3BSLOnBFOzhjQOZGafHRSUFoxprluJSfKdn6Mkx6exbAoPOM8D+mmrSwViVWZ/ujOKSTv7lM/fmKo4HCRG2X1i/+Q2EP8Qj3Xajmi0yHhkVMT8qmsYMF4muvRe8nI8n88+mYRc7o0biVSiKxZVC5NewvvOh8JZOPUlnnd34vEPzJRGwPRzmOs
X-Microsoft-Antispam-PRVS: <HE1PR0501MB285885A3BD6A3C487922F9C3CFDF0@HE1PR0501MB2858.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0501MB2858;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2858;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(396003)(376002)(366004)(377424004)(199004)(189003)(53754006)(58126008)(53936002)(54906003)(186003)(26005)(97736004)(52116002)(4326008)(105586002)(16586007)(2950100002)(6916009)(6306002)(68736007)(2906002)(57986006)(76176011)(33656002)(5660300001)(386003)(83796002)(69596002)(575784001)(106356001)(47776003)(9786002)(9746002)(86362001)(305945005)(8936002)(229853002)(66066001)(46656002)(6116002)(478600001)(7736002)(3846002)(316002)(23726003)(50466002)(966005)(6246003)(8676002)(122856001)(1076002)(81166006)(36756003)(107886003)(81156014)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0501MB2858;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0501MB2858;23:eB2UNHw3WsTzaAbVa75Ded5lkn1KHvaNP9RXqT8?=
 =?us-ascii?Q?V8UZx6v6Gvt1A4HpWEtgc8wrbHt7ADrS6cRKTKtksP8pYjg1Km++OXvbpnqe?=
 =?us-ascii?Q?qG7JjeMjzZaUprsRHKsp9Dw/lDkqioMJWcoH86t9Iu+bHNrMLC12Gg8WYEkc?=
 =?us-ascii?Q?IeuA+9kZU3SH2b1IRP2Rzaaw5f8sE8DuHoBo+omy1S1coLXhwYOP9E86dxlp?=
 =?us-ascii?Q?5LkySHmQ62cyQtCNTBTH1Yhb2XfjoNV9ngfEJgMD39RHWXQ7wR0hhDMhuLTz?=
 =?us-ascii?Q?Da9Dpb2Ltiyv+BD8soAHQuqzk7zZyFlvrwF+D3SP47pKAWyUw460NKMzBODo?=
 =?us-ascii?Q?uyb8Fm5LyNiHiVPa1bHCwFXzH+ShX3mXuwn4uMTppDnInLRFOL+iaPtLYvId?=
 =?us-ascii?Q?g4tn91YjD94bdRZBh0E9mypEm9qdlvhkKp4qMPv+q7/J7melRQOAWSUtlGW8?=
 =?us-ascii?Q?Dd5QARqUeSmW9gLETPJXKi6XKrYBO5mhg+4o1vFdadCDKIKs1kZyRdqkfeix?=
 =?us-ascii?Q?tDQEH12h7dRY9vrFeu3p4J/oZwIXlUThQK3v2hn0sTtzWOEbnZh9pFj1s25h?=
 =?us-ascii?Q?qgBy0MuQ//F11RnY4b137W/XIqggmxQrcAAH488gYcrqk2V+7QDknj4Sq2v0?=
 =?us-ascii?Q?C2BBJX4g9I/VE3KyvIyDX7xg4cBaapfkQnZoe8DWqj0d7kxz2GBBoFXRojX6?=
 =?us-ascii?Q?ITxUEBb1xw9XwckpHfe4MlU1D0HA5deHXWciVccTRHpsUPVepCxRFzEdsiLb?=
 =?us-ascii?Q?htzOmpEumbYFUm1DGqZqdXkFQFOC/7p3lDOZGwG0GAYzFA2XgtPjLzgBZDqR?=
 =?us-ascii?Q?1SowyMIvbeXQMJ6xcWTx1ScSAHbo8FJqZcRuVmNHam0eFEgarxeP66zn8wV3?=
 =?us-ascii?Q?gJTQxF1RFEP84gTknO3nBkOGsKH1+/a17aVBzlMzwaWf9s7dX/parJFTDHZe?=
 =?us-ascii?Q?0WdAwBEAFQOe0lSjS1TfJnkKuyjaEzbl/9r5Se+4+SoctIUcIYZ37i/onnRE?=
 =?us-ascii?Q?nz4/1r/osfKdD1bJBrMxI1lLbKeBpUs+cZiTz5IyXtTWPvZ+Hzp915+r1haV?=
 =?us-ascii?Q?OC247bbYgodaLIEO59rqcPBaN7oOL/h0SRKHKwJg0fdbqzPDq8s+cSYbySP+?=
 =?us-ascii?Q?Hg2w9/LABhiU0sfhRW7iFBfkqB/kozQTU8nnmF/jXSAHQSbklZcQqS107eNF?=
 =?us-ascii?Q?fKdo+MnTIGdlRmwtLRKXrPDzK7Y40voH1upbC8d8OnIIbh6XZXslEuxcxJRK?=
 =?us-ascii?Q?IGBVkQtOEl6TC/NSVo2VhiwzstNYSMuYTxK2XFLDQBVnVhfZB7fOGEYgss+P?=
 =?us-ascii?Q?MdPZ5VobEEDzt+enCP8cS1b8vYESRM+bSNTDe2dEYhThSjGjZQP0oV0aKmw+?=
 =?us-ascii?Q?Uidtb29p3MSgx87bDD+I7NxiVv3pc4swE75gBS++GP9rEB/P0lRWVdnmO+Jz?=
 =?us-ascii?Q?GsaxQcCl63g=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9VAQhNSaf1zbD0O2g/aymJQ20VbfVrbvO4PjKXwZNJ0RZCEdRWcNF2pzfwerSGRTpwBpudL7ec//aKP5MjTjivVD4cVHVNpX3KIQf8yHHYlJF2n+12zyiTMS/l8C9vQOJ2N8UAIVEz02sGXQ1yhXvSS7HVCNNAKxb0HORSjzO63KE4SgIqkabG1D+5MkMdbF
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2858;6:a+En1C5SjB9U+gop2EXKrAh0hRR8GaNwYJ7oKLVUz3QUhihEgqSba5KTg+yU0KIidHkP0JMEcW9m+JKx5076Q1H1f5g6c0hsg1t/cr83AB/7zCOg4PAiMLgR1JyDPjogSM/BZTiDt3Klh+OsQNv5MqLMDDcQ0VyC539L5GQq+Re2ZF4+A31eZlFrN067gN2RbOqn4utxXEMIqtLzpmmmjf78w0MhwZlg6sYgououdolVbThPBfBI1HOFGN4uVAnkhOg+4/fclWPos0aB7HoeS/iQtRJyU0eIn/P0wZ7BciAq8rFeUhH9GNGIGOWiffTtKzEWcuz8a4A+x3dEdiRinnRsVHF3odAlRIPMRWgiXCQ=;5:exKv42NlX2f94ctquoLRzZDcgg/ho+u000osU9QQjO5RTVRPurjpgYVeyEKbzLmk++IwHnJTlQMsKkvsWCbZJO/rzDG5VjxbMHACVQiQweLHhkLn7xuDnaX9kkIERCkYTB7N7QAu2jAYwy+hcTRTWeUYx9irV8sB4jpvqUT9kcY=;24:b3pTZ8phBj97ihlzZrX8dNK4WEdi9pU2vHj0jPxHaDBJropwpX4DqyKlo5XHa3OE27hqHZgEHzgnqRrMGkh4aYYWDrCaulZTwwaMROxOQoU=;7:MQBWOsGDp2Qo61kQtDyoR3m2PSqxnPWHdYTVyoHRBdYuFYVP9t9tiNfYzSMh6tMjTCgbOWuV6OIneIH2Oqgzw37gnOyCMfhAr9gjJuNqIbkW6Cjbcl5V1GuaRcdQJS/CulyEEFY0oiPrR/wG279pCtc+9ww1rm67k1JP4w69sBBLReGLC0BItpmQo35PixPuNr10vbk+K4dube+6sZcm0GZX8/nTKoVPgAsdVpO77uwLQk6Nyp/BGBmyrmRu4spm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 17:03:30.7444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e741f01d-5d21-4672-5586-08d5851684fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2858
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 08:39:38AM -0800, Joe Perches wrote:
> On Thu, 2018-03-08 at 09:18 -0700, Jason Gunthorpe wrote:
> > On Thu, Mar 08, 2018 at 04:40:58PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Commit
> > > 
> > >   aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")
> > > 
> > > is missing a Signed-off-by from its author.
> > 
> > Thanks Stephen,
> > 
> > May I suggest to the checkpatch maintainers that checkpack should look
> > for this too?
> 
> No such commit in current -hext
> $ git status HEAD
> HEAD detached at next-20180308

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-rc&id=aa0de36a40f446f5a21a7c1e677b98206e242edb

> checkpatch doesn't try to match email sender to sign-off
> as the email sender doesn't have to sign-off on a patch.
> 
> It currently does:
> 
> 	if ($is_patch && $has_commit_log && $chk_signoff && $signoff == 0) {
> 		ERROR("MISSING_SIGN_OFF",
> 		      "Missing Signed-off-by: line(s)\n");
> 	}

If I were to suggest an exact check it would be that the commit git
author and commit git commiter both have signed-off-by lines, as I
can't think of any cases where it would be appropriate for them to be
missing?

Jason
