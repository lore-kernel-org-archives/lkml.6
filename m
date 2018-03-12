Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeCLR3Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:29:24 -0400
Received: from us-smtp-delivery-194.mimecast.com ([216.205.24.194]:43334 "EHLO
        us-smtp-delivery-194.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932588AbeCLR3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:29:22 -0400
From: Trond Myklebust <trondmy@primarydata.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHTuiem8oVclLgSAUeFl4zeyvA96g==
Date: Mon, 12 Mar 2018 17:29:17 +0000
Message-ID: <1520875756.12462.1.camel@primarydata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.49.162.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1835;7:4kcv/pmhj1zYNYAg10cDW79rqOWDY8pk+C3Wvfm396EuK+EDeJagtr0YWs8I1rBQiQArVA4GdyXJazm7i1x0DzFS7hRgAq15CDbnqrUax6r9nSz7IOwEWREIYxp4WRx8EdU4F7WAq8uwB/H82qM0zibmQjj+zAwYxk60nevD+8v/1qz1e/PToi1AFUrvO7n9gYHb7cLb1QVXkzHKzEEvfUBf0BIkLunyqGCqdtYSZbuZftbRP2LGAQr0HP0FAj3C;20:X9tJkMG/jFtsyKKauNxshiiG1mHiD6oWsOKUIdOci5aOTp6Lm37S/VgBM6zMOmesSHZB3wIPDbKe7aWKnOqCdCN2VE1qR+pE0GX31qn5Y4WWn+p/5M5r42D0cGl0PbWdy06pdOfGpQxnmIYMAdUpt9dmuar3vs0u7hz7Ri84BY4=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: af7edaee-3c0b-42cd-465d-08d5883ec89f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1835;
x-ms-traffictypediagnostic: DM5PR11MB1835:
x-microsoft-antispam-prvs: <DM5PR11MB1835D2D3B0397FB12822E4F4BED30@DM5PR11MB1835.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(5213294742642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:DM5PR11MB1835;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1835;
x-forefront-prvs: 06098A2863
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39830400003)(396003)(189003)(199004)(377424004)(1730700003)(53936002)(316002)(6116002)(2906002)(2501003)(6512007)(5660300001)(8936002)(2351001)(99286004)(36756003)(54906003)(8676002)(5640700003)(6436002)(6486002)(3846002)(106356001)(7736002)(81166006)(81156014)(6916009)(305945005)(68736007)(186003)(86362001)(97736004)(4326008)(2900100001)(26005)(66066001)(478600001)(5250100002)(103116003)(6506007)(105586002)(3660700001)(14454004)(3280700002)(25786009)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1835;H:DM5PR11MB0075.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: vHP89J32d1SIR37/Caxx3GdPUinQ/rhOruIvQoHfpAMYAXtBswWDzSbps2DufiBzIf4n1KIjnbWQWvPT6R9+cPcsSGVBTsshOkW8HcXUt+ZpXMhKarE3/MODZxS5WpEsky+owuvP6J7u1LcfMwL8CKmQZyNG6TxNOil6Ux54aHmWgOto3LN/+G7cO3DyD98MDS5pqY1078lgvmW5WWruTORL6P73u5JRqxt6T2ScxHGNNXd3zG33hNsl6d9G06ex2oMHhA2SMBpevqnfzw/d1rAgvRlDk642MlPsSQ0xXTLUYOSY3wW8bpwW2wyZOImarH2XziUKiusK30m7mCEn0w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <5114BCE98A8A79489F80A4ED1184D125@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primarydata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7edaee-3c0b-42cd-465d-08d5883ec89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 17:29:17.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03193ed6-8726-4bb3-a832-18ab0d28adb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1835
X-MC-Unique: cDvqpZ7KNket5S1gL0h4Ug-1
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2CHTTD0003381

Hi Linus,

The following changes since commit 1b88accf6a659c46d5c8e68912896f112bf882bb:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2018-03-07 17:49:33 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-4.16-4

for you to fetch changes up to c4f24df942a181699c5bab01b8e5e82b925f77f3:

  NFS: Fix unstable write completion (2018-03-08 12:56:32 -0500)

----------------------------------------------------------------
NFS client bugfixes for Linux 4.16

Hightlights include the following stable fixes:

- NFS: Fix an incorrect type in struct nfs_direct_req
- pNFS: Prevent the layout header refcount going to zero in pnfs_roc()
- NFS: Fix unstable write completion

----------------------------------------------------------------
Trond Myklebust (3):
      NFS: Fix an incorrect type in struct nfs_direct_req
      pNFS: Prevent the layout header refcount going to zero in pnfs_roc()
      NFS: Fix unstable write completion

 fs/nfs/direct.c |  2 +-
 fs/nfs/pnfs.c   | 13 ++++++---
 fs/nfs/write.c  | 83 ++++++++++++++++++++++++++++++---------------------------
 3 files changed, 54 insertions(+), 44 deletions(-)

-- 
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com
