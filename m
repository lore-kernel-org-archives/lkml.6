Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeBIWtW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:49:22 -0500
Received: from us-smtp-delivery-194.mimecast.com ([63.128.21.194]:27528 "EHLO
        us-smtp-delivery-194.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753047AbeBIWtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:49:21 -0500
From: Trond Myklebust <trondmy@primarydata.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes and updates
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes and updates
Thread-Index: AQHTofg2MgVkD9rx80OMR5qgt7o79A==
Date: Fri, 9 Feb 2018 22:49:16 +0000
Message-ID: <1518216553.12826.3.camel@primarydata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [50.36.175.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1977;7:Q7ws22JTesu/JIDX4Z4zvxhKdTJbcLmZewvvlSDGKrS7RxvZH1oYOlPn3s8DnPAz76fCik3ShbEttpU6c8Ya1G7Tp1ne0svtMfm0ETqL+rrsLiKDr0E58hKjiazmKhOV+tYlz/ypy6y/r4PISY8Qxe4Uhvj4AMJywrHPr4YzZeL3+WvqgNd/8SVz5/LeLB3Jz++kxTSjZgi8N7tw6zvx9i68MFXz4378jtT4EgoH+NqDrtN4+LbVELY5sGI3M04n;20:5exiVmeHYR2NMZMzcxiiuEvEFym6dBOTxALzZdhPJFlb/lvadbvjvm88sLwbSO2U6mCV4j3PCUq3dlb/5J+ar7K8JQhTM5q/gpYwR7ZxX0E+mvCWeOqc/em9MPnYOCSoUPMBaVffp81nhrRCNv8FnYOTlcIxJSowBQN2tC1Ik34=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: f0e4bf3c-8efb-4518-4777-08d5700f5966
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR11MB1977;
x-ms-traffictypediagnostic: DM5PR11MB1977:
x-microsoft-antispam-prvs: <DM5PR11MB1977EACA179B465B5F1634A6BEF20@DM5PR11MB1977.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(5213294742642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6041288)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DM5PR11MB1977;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1977;
x-forefront-prvs: 057859F9C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39380400002)(376002)(39830400003)(199004)(189003)(377424004)(103116003)(3846002)(6436002)(105586002)(8936002)(7736002)(186003)(2900100001)(305945005)(6116002)(4326008)(59450400001)(77096007)(478600001)(2501003)(25786009)(8676002)(6506007)(2351001)(2906002)(14454004)(81166006)(6916009)(81156014)(6486002)(68736007)(106356001)(1730700003)(102836004)(54906003)(99286004)(53936002)(97736004)(86362001)(26005)(5660300001)(316002)(6512007)(3660700001)(36756003)(66066001)(5640700003)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1977;H:DM5PR11MB0075.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: k0dwcqVqxtwadBP6hqey+1Y8LBPSY2xearLvkthOA/TbW7gRYibde/8Vl/J7WYe72bRgTK81Yo4KAGInSXVLhA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <D17F54ACD76FEB4EAF7900A03EF2E407@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primarydata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e4bf3c-8efb-4518-4777-08d5700f5966
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2018 22:49:16.8863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03193ed6-8726-4bb3-a832-18ab0d28adb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1977
X-MC-Unique: GaIUdzhTPs2sIo7p4KfasA-1
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w19MnTwK014801

Hi Linus,

A few bugfixes and some small sunrpc latency/performance improvements
before the merge window closes:

The following changes since commit e231c6879cfd44e4fffd384bb6dd7d313249a523:

  NFS: Fix a race between mmap() and O_DIRECT (2018-01-28 22:00:15 -0500)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-4.16-2

for you to fetch changes up to 0afa6b4412988019db14c6bfb8c6cbdf120ca9ad:

  SUNRPC: Don't call __UDPX_INC_STATS() from a preemptible context (2018-02-09 09:39:42 -0500)

Cheers
  Trond

----------------------------------------------------------------
NFS client bugfixes and latency improvements for Linux 4.16

Highlights include:

Stable fixes:
- Fix an incorrect calculation of the RDMA send scatter gather element limit
- Fix an Oops when attempting to free resources after RDMA device removal

Bugfixes:
- SUNRPC: Ensure we always release the TCP socket in a timely fashion when
  the connection is shut down.
- SUNRPC: Don't call __UDPX_INC_STATS() from a preemptible context

Latency/Performance:
- SUNRPC: Queue latency sensitive socket tasks to the less contended
  xprtiod queue
- SUNRPC: Make the xprtiod workqueue unbounded.
- SUNRPC: Make the rpciod workqueue unbounded

----------------------------------------------------------------
Chuck Lever (2):
      xprtrdma: Fix calculation of ri_max_send_sges
      xprtrdma: Fix BUG after a device removal

Olga Kornievskaia (1):
      fix parallelism for rpc tasks

Trond Myklebust (5):
      SUNRPC: Ensure we always close the socket after a connection shuts down
      Merge tag 'nfs-rdma-for-4.16-2' of git://git.linux-nfs.org/projects/anna/linux-nfs
      SUNRPC: Queue latency-sensitive socket tasks to xprtiod
      Make the xprtiod workqueue unbounded.
      SUNRPC: Don't call __UDPX_INC_STATS() from a preemptible context

 include/linux/sunrpc/sched.h   |  3 +++
 net/sunrpc/sched.c             | 16 ++++++++++++++--
 net/sunrpc/xprt.c              |  3 ++-
 net/sunrpc/xprtrdma/rpc_rdma.c |  2 +-
 net/sunrpc/xprtrdma/verbs.c    |  8 ++++----
 net/sunrpc/xprtsock.c          | 27 ++++++++++++---------------
 6 files changed, 36 insertions(+), 23 deletions(-)
-- 
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com
