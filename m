Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEBRuk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:50:40 -0400
Received: from mail-ve1eur01on0080.outbound.protection.outlook.com ([104.47.1.80]:57600
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751495AbeEBRuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:50:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Wed, 2 May 2018 11:50:21 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@oracle.com>
Subject: Re: linux-next: manual merge of the rdma tree with the rdma-fixes
 tree
Message-ID: <20180502175021.GC5972@mellanox.com>
References: <20180501101017.517b38af@canb.auug.org.au>
 <1525136135.11756.94.camel@redhat.com>
 <20180502102237.GG20375@mtr-leonro.local>
 <1525269652.11756.134.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525269652.11756.134.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: DB6PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::33) To DB7PR05MB4459.eurprd05.prod.outlook.com
 (2603:10a6:5:1b::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4459;3:KAFeLk8G6TO0G/fDjMIuUaf7iN6Ud9yP8Uh6if6Qy8LIC/7I9BLG4AfsHMicqCvwYyDR0xMP9Arz8wyDqeJB/bROkJbE270I9mcx0Q3twoUftUbkLrLophpc6nT0FKN650aY6iMhdehkeRRqlPaWOiRlRntInzJcZwSlPQZpFQWIcg8epOIE2H4z7N/Q5ssT06HTe4phJTi1ZpMFX23/QD55+xAHijzaX0tEMVQhfPVJB/hIqPZ2zIMinLu2yOuQ;25:ovjJyRHNikYBfV/Tz2T3493HSsuLNv1KigSjRhxd5mzT68W3QLHiy0EApn3NuhFAcZRn/KECmm7TvFUt4yyhSf7QMH/UAOtK8os7/6KVEqbYtoMkZ45kEYmmgjZ9XgK3K+1MflzvzF+KAOoe2dxxCQRT4RtTsdb8Bd0xlU33soSHCNmx4ZjkLhhPDQ28YJW8ljGhHr6VxplJPFFumYm+rQOaRQMfa2EUUtPA2qAUOdXHkE4bBCSz/1wG7jLzQyCOB+/wcMDsX0v4dyvO1dB/8ymYgAAw96u4fIY82iUl3xWHrOS/7Hmip36dNWrzAaf0RrAwGT/C7PoscXRtZ4imPQ==;31:QwuNO8B/4KMDAla1EDMe3hiZnOuxffLc5mqtS7gtOIXT/ZyYtOUwiZNR5pjMdJmYDSn8DLgl40pTILg+OLAjq88mZvvmoWe9D8ANWuQpoRxjfjY9oH4mWqqmT7/hGQJrurKB2bLjDCRzNuDH6hCsOFlHYdvnNRhny3waX411t78QQjh5kHA3Jwt0WlYr7FvrAuZUZXxXKfA5etrrf4EM7MtUaTN+CO33TkkAOE9m3q0=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4459:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4459;20:rlkKT2b+m0aqRmc+girDAyLBpc8a6S7TCgsjApntmOeIgTz8OvDJHo2UiyMTKbsX/Vc49tHk3Euvn/MxjFXRCXZE0LGHNl7Cw3JwfoM+J8YX0g1mok7VgiX19UkXfOEfsv/6IAnteMI1YbVzLst9SvjEiU0lAKjaEXA/Seqm+4sNbxH0OsmnhyigLXj196Wb2ZwtOc6Mi5YRpamUEBLGzYOkO3KEr4WM+FCFVsnmNvrnDe2G6lzT4/VK+Ng3/aCDWIqVpiafqW9yLyodoPLAfwWnMHqdMjylrLAFn03PohguRfU4QjJ/1iazby5caTHUuCBjpAfeJVDUpi1LZ4ANLZUcDfHO2Ab/NFIFFVVXOPhgIlCBFUNLgTBZXMmq0tDRpKc+GxleRNXHjo7+3FQjc91Bd6PBDo5HLWCp6SJHuqEggzT9Lr2oSLR0K5O4XTCKusAF9MuwUzgP7c8+wF1+4WAj7xpZRDQazSyyNLjW5W2oet8GLHJCzTPGYO/xKQD3;4:18n73D4z7IWslecpiM1haaXAttSZcOT6IGmu05m0XdE5iP+6RElroxQCnt+KRe/JcDi60WZKlOLlMCBhl1NY/QXJDW5pTfC+zX0zHxEO8Ios7+5xkTjZFqrt+DDOwilFpahS3g7rCGIzQRIyyDn1dNib68nGlwAaVTAu4GabZrouOwnV6A3C3yS9hbTsAkxuT7JZMeXm1NCt6jqg8Kh+0cUtp/pzY7uHBA/Ja/6N3QaHJekRHC6+MDyB6TNmAJgILghbUo0erd4YeCP2/vrO7w==
X-Microsoft-Antispam-PRVS: <DB7PR05MB4459601D918012C0EBC086E4CF800@DB7PR05MB4459.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB7PR05MB4459;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4459;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(39840400004)(366004)(376002)(377424004)(53754006)(189003)(199004)(8936002)(52116002)(50466002)(9786002)(53936002)(68736007)(46656002)(81156014)(8676002)(76176011)(6116002)(3846002)(4326008)(26005)(66066001)(86362001)(2906002)(122856001)(229853002)(6246003)(23726003)(9746002)(36756003)(81166006)(1076002)(305945005)(486006)(7736002)(83796002)(57986006)(5660300001)(6916009)(2616005)(446003)(54906003)(316002)(97736004)(11346002)(476003)(386003)(33656002)(186003)(69596002)(478600001)(59450400001)(93886005)(47776003)(106356001)(58126008)(105586002)(16586007)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4459;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4459;23:84ZtAKbpXdEPmJiwFeztrF7SVc6GwMxdZPf1gXF3D?=
 =?us-ascii?Q?HfxkqlgfWnLnDKm+HCxhuH+CXK9SHcKoZYEfxB7IpMAR1kQXtokja9pOSSZo?=
 =?us-ascii?Q?9ddOFZb17cEU0dSiUYbwM1JdFhfs4xZG3J708xh5eYe1F9W5Q/q2EOZXJx5M?=
 =?us-ascii?Q?VJNmPnA+utLhO1PwtJgYjAr0fXOeFBhyqfFAWFALWAow5GbikflCFFotuVaE?=
 =?us-ascii?Q?z3uYxjIg3RwitcXOitN0Xmjvrq2M+RSj9JpKBaNna5zPq3HqenH2IZWIssmy?=
 =?us-ascii?Q?q6IXkUtt9ICW9+T+3ylNv5fiDuxZlNPXa8hW8qMe3QhlxzAcnPv2/RVuVKLD?=
 =?us-ascii?Q?mIey2ICUR77Xs46UyfNS1IrNshl9JtHJdIbM1sbsLqrGTU9YXGGF6W69T5w6?=
 =?us-ascii?Q?V55Le9RBicq5oYpmdwgQFILx4n0ioHUaJ4Dl+jwKGlXCW5Zr0iLbwkcc6iA5?=
 =?us-ascii?Q?Wbxj62ceyh5Fb4BMZw0ZbRgrnWJJamxkP8clNp4M7gQuxyIeTz+0f1+vr4IU?=
 =?us-ascii?Q?6W7MUgnJB8lXbum8Uu7gtxgJ28m4DNkTYA4Ar9r41ZOVDvd7PKglZNrArrUd?=
 =?us-ascii?Q?IJoo4Da7mvfxUvxKZeMMSGK/77P9K+FGsxMdmdCJJJp1l6zpRPTLdYj5tl9y?=
 =?us-ascii?Q?JwT4Ha5+cRmcDD0xf+FfQ0QJmSHb1hb1xX3hqEJfh/PIQHo4XoJdnEaszY+h?=
 =?us-ascii?Q?F2foD4Z2+e/Ef+FtLhOmmjTS49wgh3IJYYz+mtrcMjdN300D5g/F1dJByvDM?=
 =?us-ascii?Q?g1mEyUnr3ah+86RyvTgWV4e0AFskaahyQXQxzZgDMLLfoH1UDyQ7BF5Qy580?=
 =?us-ascii?Q?i9cNvELzghtNqlNBkSbTikpCnLdOXTIRPkt7fKGWUBWL/47PLc9CIP5S0Ib7?=
 =?us-ascii?Q?YWH0OfmGU0QzJvDdCgUOPhuFf6yAVVE0NfiOCxQKLGBJe+fkB2GyKl7jl6qi?=
 =?us-ascii?Q?76lALc7XAeqaJBGVG/SbNQK2OrnflOczd9f71ZKyFKZM3yeTYomgJNUoQm/a?=
 =?us-ascii?Q?yJED7E6o6JjHAODAjN6qdr40UAo07kunZTOHrGU2Z6F5UqkjVAtovAx8Fza4?=
 =?us-ascii?Q?ZgmJV/3Qa6fYwKeNWUDfzgLh3m4AKlnuLu2erbCfY8N0TJRPNwCxwpf5unQr?=
 =?us-ascii?Q?tkN4HURrsHrExO2WGQMl1yFNii66CFSRNWoX58EDVb3E57BL45sNh3g7tdvv?=
 =?us-ascii?Q?cxrphwKxVmJ3LTd18JSARCkFXqayitqLQRBgN42UYKXk1KZFoU21cIPuosz5?=
 =?us-ascii?Q?eacQ6ibhbJKRYTNp4aW0YTpbmW6XDE+iY3DOPunNokWs5V/gZO/woq/0mMbV?=
 =?us-ascii?Q?o/d1Uc15g59wN8uWD06P+jwNvZVkxRVjU0ivVsmYjR0bnUZmzJb6nEAUAvHY?=
 =?us-ascii?Q?zQSClNtJfS22Lwt5jlxKWWbkNAjCmKLf1W1H2Cewgp4NNfRBwqFV0e0zwhoB?=
 =?us-ascii?Q?x6lvmyVFND4O5gijjqbtbNx1Ba+Wbs=3D?=
X-Microsoft-Antispam-Message-Info: lShQMlp9Ty2Aw06wwKWs+66AzE1F7dvXvwQLc6/Y/cV0zmCn6r3tzjkLxmyp83ctTQKf9jp7mR0oStd5EUoeQR9kGUyPrLFj6ENFMuo9OvdbcxHOi8M32U0wBlXBKwdd9GC6KEudZeJ3HVISh2gmtEEXYeM9I27njQxjsH0FXNyip8occi42H5LdWHs5m0DU
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4459;6:J3L/JFvKVyDDxPSrdS9FB1H39PQqAa4GpJRVVTOCmQncXcb3z56GFMX9eUFekBCk7e/6XD+8xPr5cH5jh4OoXY6cDtZai8PunpyDe7ye2jL70/mBRuhIk7Y/yTGMpe1ZdjbIFDARI0Fz+uIi3eLtwHTzwvGZ2S45MyOzXgn9OB5iQ/MkEZ50WUglpgMV240we2OJaEEeV9fOwPX10+AItovgnzOROlAkoDffuSHXb4czNyKqDD4r4ZAvL9QLP5+1Y9yld6PN1GO1XPeXqOOihK5QUo1IRom0m97Z3zW6ONygMtB87OQ5OAutMeEL7cV9+D5RrtDgnMm3mu6ClmZE58w0qVtjFWGni2TFiBPlF89vG5DLc5R/A++Iu1gAtGe2WJG4XEoPkBt/86einckqJCW1VJadt/ZJPvvMN+nOqp4WSZZFmPz+c2ySN9OG9nm91QVx7SMeE/SFX4vZV2ru+g==;5:YODgL+g/Ag64ADc5Lma99S+1PF1zQn6oRnOeCkdnuobZ8aVQFSL3SkXqO0yGgJ7fuIUnSWtmRHDjEZ3tNlgMmaHtcQKh4xStIFoKmuWHclBG8Kn2S7B96ay30q62xcg5LlUEzA32AmCxKPRkfGQjkGvN/kF9e4Nf5WFARHCt0Tg=;24:RxBVMjFDpkEPnYnQ4Sj/M3vHNhbKYzrcnQHpN8kaMp5CGg1q86rOnMr9AdgJaLaV2I6rTQumHqd5/qkCEJJLVR6WTRIOZ+9UWPfdWZJzgR8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4459;7:RU3bm6Z0SPeHYQAQez5mWqWLWxZfV5dcGDxjGVVPqQ2tI3J/OCYegaWAH1rSpNPG9vTylglnpCp+itHLK5dsYgE1M3wJQm0j6owMbn2SeAhhVLTbCwWPNNUkI8erRPzKRZ1bj4WWL0INRgdJFZOHw21WsDTrf8hUnXs7wCjaoJ8Ls4+XTpzdD0CUw00MYXfhRYTUytodeJrHoDSdCIFX5fettwwlYTdfMqHsGIkAvDYmTgCsfdruBzVwqq4JOjOi
X-MS-Office365-Filtering-Correlation-Id: b4298a65-a8a2-4845-cdad-08d5b0553110
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 17:50:28.3124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4298a65-a8a2-4845-cdad-08d5b0553110
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4459
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 10:00:52AM -0400, Doug Ledford wrote:
> On Wed, 2018-05-02 at 13:22 +0300, Leon Romanovsky wrote:
> > On Mon, Apr 30, 2018 at 08:55:35PM -0400, Doug Ledford wrote:
> > > On Tue, 2018-05-01 at 10:10 +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Today's linux-next merge of the rdma tree got a conflict in:
> > > > 
> > > >   drivers/infiniband/sw/rxe/rxe_resp.c
> > > > 
> > > > between commit:
> > > > 
> > > >   9fd4350ba895 ("B/rxe: avoid double kfree_skb")
> > > > 
> > > > from the rdma-fixes tree and commit:
> > > > 
> > > >   2e47350789eb ("IB/rxe: optimize the function duplicate_request")
> > > > 
> > > > from the rdma tree.
> > > > 
> > > > I fixed it up (I think - see below) and can carry the fix as necessary.
> > > > This is now fixed as far as linux-next is concerned, but any non trivial
> > > > conflicts should be mentioned to your upstream maintainer when your tree
> > > > is submitted for merging.  You may also want to consider cooperating
> > > > with the maintainer of the conflicting tree to minimise any particularly
> > > > complex conflicts.
> > > > 
> > > 
> > > We will probably merge the for-rc branch into the for-next branch in the
> > > next few days, at which point we will do the conflict resolution
> > > ourselves and your need to carry anything should drop out.
> > 
> > Isn't "rdma/wip/for-testing" branch intended for this?
> 
> Not really.  It's there to provide a pre-merged branch for people to
> test.  But, I've rarely seen a release cycle where, *sometime*, we
> didn't get a patch set in the for-next that depends on changes in the
> for-rc area, and in that case, you need to merge for-rc into for-next. 
> If we don't have that this cycle, then you're right, I won't merge for-
> rc into for-next and for-testing will be the throwaway merge branch.  On
> occasion, if the merge fixups needed between for-rc and for-next get too
> difficult for a non-RDMA person to sus out, then we will do a merge of
> for-rc into for-next simply so we can provide the right merge fixup, but
> I doubt this merge fixup rises to that level.

What I've been doing is storing the resolutions in for-testing and
then when the PR is made I create two branches
  merge for-testing, for-next, linus/master
  merge for-next, linus/master

Then I directly diff them to ensure the merge resolutions are all
matching properly.

ditto when merging for-rc and linus/master

Basically for-testing becomes a place to store the merge resolutions
that we can create when the conflict comes up and people still
remember what the right resolution is...

Jason
