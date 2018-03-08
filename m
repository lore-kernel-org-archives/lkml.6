Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935985AbeCHRpD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:45:03 -0500
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:3056
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932087AbeCHRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:45:01 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 8 Mar 2018 10:44:44 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Joe Perches <joe@perches.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Whitcroft <apw@canonical.com>, Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
Message-ID: <20180308174444.GG6773@mellanox.com>
References: <20180308164058.2ad5a158@canb.auug.org.au>
 <20180308161845.GC6773@mellanox.com>
 <1520527178.11634.9.camel@perches.com>
 <20180308170317.GE6773@mellanox.com>
 <1520529792.11634.12.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520529792.11634.12.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:300:12b::34) To VI1PR0501MB2864.eurprd05.prod.outlook.com
 (2603:10a6:800:9b::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 192a8ccb-bf5e-42f1-267a-08d5851c4f3e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2864;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2864;3:BQ7qmztVcG83XhQJwC0qKjcwvoTmWOFtQbmPvzN77PytkFeP0A35VagwoQgJ04n4lOEg/pCkghxiKdDIRxhL0FCcNgjfLjfO09PbLOQncL8/P5MoOpQae4H1rBn3ryWlSz412kIcst1XTFqUY8+qd4w4o0wVrAFBwOTw1Vk/iAT0EAaFFLvbzZ3bm28J1IIAvcwTfVXwiprj0Zfi43SqqsEnVVBm0fjwMco/szu/TIYVRpsZNoth9rX0jJ65zKBP;25:nG1ugPG/denZ4WuQuvLRjnvtsBuB+KJRZRHRGYCaxbl9f1TEQKASeuEAtQYQo+z+63QGoy9kWb2fqKGpfefwfcaPUdRmYqLMqIrp95lbA+JYPWYF7hDIot2wPb2Mp1efWocuPzwkoJmpBOTCiLmSbFf69ote6oCQW3saoioNlxHVKY3PoWLJNTDzlkOGmMEt2QYx0YqJtiaxt8MX0Cx0FB4lp6t5Xx9+rTpTN19dV4Rb5KUh259gSLSnJoU7PfWIpb8wNniU4hVlIOPNllHGuzAtVXEktBqXMhUslWkvGKvsCIYT5DA6m1Wb4x9ePXC+RNCzjeuYkIrjsnxuWqFJGg==;31:VtgOYmpfLrDh4Dgj/y0UCZJikaoMFwEh9TEw87Z8Pa88DgacTq7KcXrU9qN4TAnRBnTx56IkQ3kuBo4CFpoGQwCkIL/Sc+be70xV6TlcrRgqFlxwPWDc+5MB0Uu6KXxTiqFeoNaBtvuucMTAeZDLV9Ww+Y2a/63P0CryxGrUM6JoFIkNME1Wqb+ZP10ajtLlG+iwHmDcfWimv0YQvdMCPrR6z2xx0nso4a8ZbAEt4D0=
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2864:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2864;20:Pol/8OZejvEN5KfwFYd+M+j/bNRYCyPW4ykJLDMCJtPQhJkFgsMr76+s7AbnWZHPErW4YLV8I//usd3R26hDScTlfK+cdSxJUeFZE6jtNQgzCnVFbmeVetr0xsFFMutqsHN8SdQmJBR/5Mqhrv9GfBmvguHVbzx0mZBVLydhcXUrMTWZBdkRtNhi7SKk65bWDWB0DoDGXNjFdj0iBo6YZ4xEgbNPVfr2hBE4k0aOHZX0UxnPKxXRvk1yaUp2OJXRtbJ/0Y4T67+XJQabcRtEy0rc6J2H6EFdbPlqzU/Q7xnmaBMf0fkzXVQLnV5/AcQKCr8cra731ciQBC5CKUHaaIa85cZkBCcXsMdnbAt2DHqBNXp9FQkV7tMi6JBANcdqRkSOq8kwdzHLRXyJ/Lq2ubB7HslYCZbzeWhiLWn94Gx0buTxZGDBnEjz/qvJuU17PsnPwZnROyW9qJxdrV7DzbZy4Eq6Wn5WCEwh6G2PryACiX+gylU8WzNCIGGlYrxk;4:lZs5f7WzQB+A5fvV2JOhtQw9z678yOnmCrtb1aFurd38xLrhH3H2ziFNb1Y9N1xgii1w+GUXqVHQcl5h+9y+ZDXFhyM2nhfqVGbq+sSA/AH16jKejNQlgneO2tK6LSxk523OkfMoSbO76tJRlsJLxaxNQX1d/n0rQFc2A8I3t1PlSYkzVvYaDSBo8W8tYSsIECVQ+wqvoNyFJbVxHTgXVrL/P3SS+296mBfQNx1hir4EDrSWVuDaxNAkrNLMTkweNy0EuyKiw0tZJOgcf8/79weW+dWfKI1pqdT1lWDmqLeN7l2zCWxC1h0BwsCfxAvXz6TqzJQclNEglNDeO0hxrqs40Nziy4fUpWq9aIn4qzQ=
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2864B186B090C80AAA54A4F5CFDF0@VI1PR0501MB2864.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0501MB2864;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2864;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(366004)(396003)(53754006)(377424004)(199004)(189003)(81156014)(83796002)(229853002)(76176011)(105586002)(57986006)(52116002)(66066001)(50466002)(46656002)(7736002)(966005)(305945005)(5660300001)(2950100002)(6916009)(16586007)(26005)(186003)(386003)(47776003)(8936002)(316002)(58126008)(9786002)(9746002)(54906003)(575784001)(8676002)(97736004)(81166006)(86362001)(53936002)(69596002)(478600001)(107886003)(6246003)(68736007)(6116002)(1076002)(23726003)(2906002)(4326008)(122856001)(36756003)(93886005)(6306002)(33656002)(3846002)(106356001)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2864;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0501MB2864;23:DAkijNLKK5ejgOiwAJW6oSzO7333tMFp5rfHcES?=
 =?us-ascii?Q?AqojMb6kwfi6YVqYUxM6+CfUZAL6GYMjxByu+rW9Ptzec+oYlqbgDKqXdDtZ?=
 =?us-ascii?Q?ky7s1oNUyeUBufAdnV0f6bWU3T2v4bFodmCwSCLPJfTRMaBkL83mBo3Q/mYr?=
 =?us-ascii?Q?kOZbOhfhPWLX8N5/dO1IXxWqIwgsKAqz+N/2IzQmU64y7lasTasg34wg6ahb?=
 =?us-ascii?Q?wuCkHnp4NUjFTg4Jp8UAEkux5OA8JxE/SpOY/iqxTYID52xNcBGdoFLnmbaR?=
 =?us-ascii?Q?fUQPCqHpsrWx5CNOT4GRBrkifiop38CaNjjcPOvPtLqR86MF2MoTbxptLBXP?=
 =?us-ascii?Q?CkX4aOsk5EbDq2SbKr/8F3B6Otz5jDPYqz9J+SVcgGw92KEqbeYxNXHlVv0X?=
 =?us-ascii?Q?8GRowvvTPYS35BazKmWj0JNByNCaJtbn87nawBrHsy0KRw+WVbripLVBiAKE?=
 =?us-ascii?Q?bdrQkrABCCury9oUR+knlCrKSln1dPimbJaKSrow29/HbvutAOmNvb5T0C6X?=
 =?us-ascii?Q?t+reNz28dJQX+x0e4ChBq78IVAdf14TYaONznor1QARAW0jmHzRehXitCBOJ?=
 =?us-ascii?Q?jxrwjWCrhN4s6awgYYAHiErFgsKQtq5O0VVwSJvYQI4NNE9ZJCBRAzZxSkvg?=
 =?us-ascii?Q?8rOd2EFe13sgf+ju9931P+kEnypFVwLNWRcmzl14Zl2ptTDkerKbA2YCxa6e?=
 =?us-ascii?Q?cERgmFuzufRSU4K0YtPsRK07HQDoh8vUZibuCy2FfuJDzDRUhEmdPsdzE/rL?=
 =?us-ascii?Q?hOIpVNnQDjr0lNMxJuTi53TOhNfED+cdrTFdfTkLbO/P72vKC+nfh9QAOiFw?=
 =?us-ascii?Q?6MHf9KMCKiPNA5IYSI9RfCNMA4ZEn1uorbl13vhTzkjBF1b3xb4+HapWFLGl?=
 =?us-ascii?Q?gZim+m+WYkg6WPcOF4KdZ/jQ9IexS/jx8nHpYoBb98ZD8pSk5g3/74Zhmi48?=
 =?us-ascii?Q?3Xjx1+EyK9D8p7OX+Vh2pRgpIeXJxu7rIBd4ZjvOBZZ4jOlHY/8kDVLR5xyV?=
 =?us-ascii?Q?VzgYJ2IThUmdwn5MkPEBTYSOcBMylDkH6dZu0VSSV69P8LQMHP1o63j/oLqj?=
 =?us-ascii?Q?CEvwui36UFWptXXdDQ12W9mCXiemhgaOGyYv7U5L7dUf0GXrf7wFFbutOhxf?=
 =?us-ascii?Q?p+oUbdH0TPuimaSzKbvA6xcHJRwyzSQnvwJV0gKGf0MGWGl8gwLc4oFK2dcS?=
 =?us-ascii?Q?U6kJYxAyJlVDAOkFmdT7fkgymVSGrCjUKgRSjaHRGxadkUwc7tx/lSNJp805?=
 =?us-ascii?Q?7Op7qqxoX8KE5YraAdxBG/OknC83NpJHxc3dCLYTUo3pdQBcawFrLU0M65rH?=
 =?us-ascii?Q?/Yl4S1lMwAIP6Er5Yv9s0hMxVwwqB19Wv+ijU2PgeqAEKfEyA6VDbYVNljPm?=
 =?us-ascii?Q?0ebcUw7Dq+sSlv2GVpIMlGcqntX0mn7d24EXRDdzkWYFFOLbKG5yK5ahVrFX?=
 =?us-ascii?Q?Q/QNNICAq+4nQDL/ZRGo+HLcIDEk9w48=3D?=
X-Microsoft-Antispam-Message-Info: D4uRs2g3uNMEVtqalYbBX1rP/TXGdyH3FtSSwt6DT14/x8tQbuEOwrMxfV9P4J8ki7Qut7RzTKlwjIXn1lyxr+DLomMpFr9LRuS9nftnl/rSxWxjOf4sdJSBgugqPlohEF6HfLU4POb6j5GHabzShHz3w6D586BvqLn1ZXq2n0Sf+tUu56gQChHK2VXmXIiS
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2864;6:j+/74VtpxvR5qRjbK/y+8Pg1QwQyXAMuUXHkcaVjni+dU1c21ijRDx0v1BW/AZufF2BReg1rjmrIz+B+sN0pwDlp6tsmay+lUNh95LDbS3cNUiJYZGx8nVqL9xnvKJsRXAbwghXLEV4mxDubpAeDg+MHR7fAzcQONCZaPvmYY9b1I9eRySttlLm3oZO4UTvXjBKzuUTP3rzZ4+IsO6m9uvGfoXf0G8GIrfFJsoPuGiaxOQcvGwp1Fs6z3Klgnhtvs41kLzFlXyjQzMa2VMqtyJR6WsMb+siTmc5EeOhqh3nFF8c/fZxfNclnxG5/r+SOgMji35F8efQ5BKXWAXEYPhgA3tSqdRUGCGb4ElmEY+Q=;5:X/QF6rgljCZAXiyQfd5dVXlu1LmJRKOXrwi6IZzY5SeAtiSzv372BtwIXnjFTpC+Y9SeAs5S0d9IPH0jJMlZtVV3aTUFo3KSljpvhQPZSC6nBTBzHIJiHrBvNMJ2b1bC4mtB5f3e72Wf5mdSod1RFhH5rYWT5rXlOfll2bzEt7Y=;24:Nd2uWjygD2/rpWCYn6TDROnTaF3fGEHkDl++L41jLzxMQ7kPEH1LeEk2vKds9Ihpl8KUcU+UzNZpwISpCUwNph6ILlZArDlFFJKhXr+wq3s=;7:44wjDPUGH1kPfJw5xGreyuHm+wrySaB6B56sfkC8V1B/HX3sMov5Zn5uiMP9mCJ5Iqj1mSIdHlgcSdCOel8gVBWsGsAeuPalaQEs5zUKfb7C4OJuGS3SGFVBLdT1sTupUW56qMYrEugTeBNvvKTzpoiBuHK45F9CECuR9qB9BNK4qcbpxzodkWaEyDRPZe5wUXwa8juhAacmG7us3EOIqdzJ4JyhAnRobZVL095gL7MvVjKl/doPIi/WwDE1a3rU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 17:44:57.5813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 192a8ccb-bf5e-42f1-267a-08d5851c4f3e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2864
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 09:23:12AM -0800, Joe Perches wrote:
> On Thu, 2018-03-08 at 10:03 -0700, Jason Gunthorpe wrote:
> > On Thu, Mar 08, 2018 at 08:39:38AM -0800, Joe Perches wrote:
> > > On Thu, 2018-03-08 at 09:18 -0700, Jason Gunthorpe wrote:
> > > > On Thu, Mar 08, 2018 at 04:40:58PM +1100, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > Commit
> > > > > 
> > > > >   aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")
> > > > > 
> > > > > is missing a Signed-off-by from its author.
> > > > 
> > > > Thanks Stephen,
> > > > 
> > > > May I suggest to the checkpatch maintainers that checkpack should look
> > > > for this too?
> > > 
> > > No such commit in current -hext
> > > $ git status HEAD
> > > HEAD detached at next-20180308
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-rc&id=aa0de36a40f446f5a21a7c1e677b98206e242edb
> > 
> > > checkpatch doesn't try to match email sender to sign-off
> > > as the email sender doesn't have to sign-off on a patch.
> > > 
> > > It currently does:
> > > 
> > > 	if ($is_patch && $has_commit_log && $chk_signoff && $signoff == 0) {
> > > 		ERROR("MISSING_SIGN_OFF",
> > > 		      "Missing Signed-off-by: line(s)\n");
> > > 	}
> > 
> > If I were to suggest an exact check it would be that the commit git
> > author and commit git commiter both have signed-off-by lines,
> 
> The git commit committer can't be known by checkpatch.
> 
> It just looks at patches.

Well, it would have to extract the git From line and look up the
commit ID in the local git to find that information. Obviously not a
work flow for everyone..

> The original author of any patch can't be known either.
> 
> There is a mechanism to add a "From:" line that is
> supposed to represent the sender of the patch, but that
> person may not be the original author.

Well, I would be happy if checkpatch computed the author the same way
git-am did and used that to check the signed-off-by ..

If I recall, git am looks for a 'From ' header at the top of the body
to override the email header?

I only ask becuase I keep seeing these reports from Stephen and
usuaully by the time it gets to him it requires a disruptive rebase to
fix..

Jason
