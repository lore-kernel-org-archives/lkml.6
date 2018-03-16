Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeCPGyQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:54:16 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:18912
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752984AbeCPGyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:54:13 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma-fixes
 tree
Thread-Topic: linux-next: manual merge of the net-next tree with the
 rdma-fixes tree
Thread-Index: AQHTvMHLLwQHqiMXw0CPQoBP7Xiv+aPSD70AgABd4wA=
Date: Fri, 16 Mar 2018 06:54:08 +0000
Message-ID: <1521183244.19648.27.camel@mellanox.com>
References: <20180316115610.3d7f232a@canb.auug.org.au>
         <1521163082.18703.191.camel@redhat.com>
In-Reply-To: <1521163082.18703.191.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.26.3 (3.26.3-1.fc27) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [2601:647:4000:4586::b0b9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR05MB140;7:mfat4j1Y7R+ra7o16TWTd4NvLxURgLTbo8FytrZDTnVlatp3faYTAcUVYLAti6JSyh1xPeYW1diXLbblcce3izDDMFTNo5mRoQQ+oyGHAykeZvWeCeWEBGWhQZLEBevFzIzArOOqFLvcvvPM/rwajxJ+ZWQRgOGXniO23m3MOCeYslDIPV96aMdOGwFV+Hc9aRIS09qQ6+vvFmeU0dvuQ5JnP+4PbIJD470I1+i8mj+6v+q+1ImjjHD2EbYDC8tA
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66886f6c-2433-494a-4187-08d58b0ab79a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR05MB140;
x-ms-traffictypediagnostic: DB3PR05MB140:
x-microsoft-antispam-prvs: <DB3PR05MB14026530921270D669EDE13BED70@DB3PR05MB140.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB3PR05MB140;BCL:0;PCL:0;RULEID:;SRVR:DB3PR05MB140;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(346002)(366004)(39860400002)(43544003)(76104003)(53754006)(199004)(189003)(377424004)(46003)(2201001)(3280700002)(105586002)(99286004)(3660700001)(316002)(97736004)(36756003)(2900100001)(5250100002)(6246003)(4326008)(81156014)(86362001)(76176011)(107886003)(53936002)(81166006)(8676002)(5660300001)(59450400001)(7736002)(6116002)(68736007)(305945005)(110136005)(2501003)(6436002)(229853002)(6506007)(6512007)(25786009)(54906003)(50226002)(186003)(8936002)(103116003)(2906002)(2950100002)(478600001)(14454004)(106356001)(102836004)(6486002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR05MB140;H:DB3PR05MB0859.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PepcEeeE5QspMwXUJtBNRtyH1FIXpgSWRXFDI1jbb8Tj9VmpuH49UuClJExAMsVcYaA38mNy8XJaBWS2ap0uZXRPVc85Uduz+I6r6E5JfI1kIwrTGw4TYExcPo/qsDYFy67uPFdwJJUpI+zA4s9f1OrHSDKL1BtESoQ4saa/sGh3oY7WhRvAXxr3ViiZj6uUYZNJeUrWqkab/0Tu0oA3HuiuOSVaKVFdf2RFHGeg8AHugf/CedPObJ0jioat+pgLrqZkHJx+RCX9AlSGyf9IJgywWF+vyk7LGo8rfoMnwBiLCyT/llOU87lYM958Z6lg2Jlk2y8yYBPapY/5noiVag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <074BBDE3EFF2A8468A576D311AF8B046@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66886f6c-2433-494a-4187-08d58b0ab79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 06:54:08.7191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR05MB140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2G6sKKS024233

On Thu, 2018-03-15 at 21:18 -0400, Doug Ledford wrote:
> On Fri, 2018-03-16 at 11:56 +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the net-next tree got a conflict in:
> > 
> >   drivers/infiniband/hw/mlx5/main.c
> > 
> > between commit:
> > 
> >   42cea83f9524 ("IB/mlx5: Fix cleanup order on unload")
> > 
> > from the rdma-fixes tree and commit:
> > 
> >   b5ca15ad7e61 ("IB/mlx5: Add proper representors support")
> > 
> > from the net-next tree.
> 
> We are aware of the merge conflict.  This is a result of the fact
> that
> code had been submitted to the for-next area (the representors
> support)
> and after that an issue was found by the syzkaller bot that deserved
> rc
> fix status and which conflicted.  The fixup you list below is
> insufficient to fix the merge conflict.  The full fixup can be found
> in
> the rdma tree from where I merged the for-rc branch into the for-next
> branch and created a complete fixup of the merge conflict.  The
> problem
> is that one patch change the device init stage flow, while the other
> patch duplicates the normal device init stage flow to the representor
> device stage flow.  To resolve the fix, you not only have to resolve
> the
> contextual diffs, but you have to duplicate the changes to the normal
> device stage flow into the representor device stage flow.  It is very
> far from a trivial merge.  We were planning on talking to Dave about
> this issue tomorrow, but you beat us to raising the issue ;-).
> 
> Here's the commit (from the rdma git repo) with the proper merge fix
> (although it also has other minor merge stuff that needs to be
> ignored):
> 
> 2d873449a202 (Merge branch 'k.o/wip/dl-for-rc' into k.o/wip/dl-for-
> next)
> 

Dave, Will you be able to take care of this? you will see this once the
rdma fix gets submitted to linus and you back merge rc into net-next.
after that we need to verify that net-next merges cleanly with rdma-
next (from mlx5 point of view) to make sure we won't run into trouble
in the next merge window.

I would like also to avoid such conflicts in the future, since now
rdma-rc is active we are more likely to run into such issues, to solve
this maybe the right way to go is to avoid touching rdma/netdev from
mlx5 shared code pull requests and keep mlx5 core stuff clean, the idea
is to run a pure mlx5 core incremental branch in parallel to netdev and
rdma, this branch will include all pure updates to mlx5 core, mlx5
netdev or rdma patches will be sent to netdev and rdma branches
separately they can be based on latest mlx5 core branch or not.

This way you don't need to pull in rdma stuff from shared code and
Doug/Jason won't need to pull in netdev stuff. it is more work for me,
but for you and rdma, you will see only clean mlx5 core stuff from
shared code, the stack part (netdev or rdma) will go only to the
specific maintainer respectively.

What do you think ? I can do a sample run in one of my next pull
requests and see how it goes.

Thanks,
Saeed.
