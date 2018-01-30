Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeA3Oj2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:39:28 -0500
Received: from us-smtp-delivery-194.mimecast.com ([63.128.21.194]:44709 "EHLO
        us-smtp-delivery-194.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbeA3Oj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:39:26 -0500
From: Trond Myklebust <trondmy@primarydata.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client changes
Thread-Topic: [GIT PULL] Please pull NFS client changes
Thread-Index: AQHTmdgc4O2IW1+dRk+FegJLE5n9Rw==
Date: Tue, 30 Jan 2018 14:39:19 +0000
Message-ID: <1517323157.5412.1.camel@primarydata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [50.36.85.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1369;7:7V6E+ijDHKetsCFmCPncqbKIaCcAoO6eJCUqZJYtLEGKVyiqPPRtviN5EEAxRRvLfJqgUDoHkL312r5tZREzrqKrZdf/ql5z9aFxqn1MWrx1jA++ycX7QVa02s4jjNh3w+KyaET69jb5xjmqyTu31bEG/8akNBnsvxEU8r16oz5yQkUkLeeSfA8vyX9UKewxjREakVQ9eSNQpVMiOjsmjRLboiPuTFD/U8wC0mPxKjpU7cRQe9tL83bcAVqaxEKe;20:xi4z7HgBYl9MPhpXAd+MruDZtzFQxhlPBs50rg+HodI7WuM+abB5vNjzmAGORK5UUOC3gMwAJLl7Mj2+4xxbtDMwEBxpoSJV5waHrpQq0UE5B9R3BTwVpdl4KzMbSL8QBSI7wSY9hqtbJ5myOuN5Zrye0znbbI/MAfGctbL0zDg=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 6eff9e32-f414-4716-630f-08d567ef3f60
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR11MB1369;
x-ms-traffictypediagnostic: DM5PR11MB1369:
x-microsoft-antispam-prvs: <DM5PR11MB136919C4FE3FA28AD12FBC6FBEE40@DM5PR11MB1369.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(788757137089)(5213294742642)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6041288)(2016111802025)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DM5PR11MB1369;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1369;
x-forefront-prvs: 0568F32D91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39830400003)(396003)(39380400002)(377424004)(189003)(199004)(97736004)(305945005)(59450400001)(68736007)(316002)(2900100001)(7736002)(6116002)(3846002)(5660300001)(99286004)(6916009)(54906003)(14454004)(478600001)(86362001)(6506007)(102836004)(2351001)(1730700003)(3660700001)(2501003)(81166006)(106356001)(8676002)(53936002)(4326008)(105586002)(6512007)(6436002)(6486002)(81156014)(66066001)(3280700002)(26005)(77096007)(186003)(2906002)(36756003)(25786009)(8936002)(5640700003)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1369;H:DM5PR11MB0075.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: idTOpnvCHzB6/YxgjM3e2Hymuwx+gK3K90J/AYHUdNTrjU/RPLK+3b9klqF9kPAxU4VBriDWo+F0B/ImMa6VkQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <866E1CDA48D3214BA0DA77088AFEBAA1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primarydata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eff9e32-f414-4716-630f-08d567ef3f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2018 14:39:19.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03193ed6-8726-4bb3-a832-18ab0d28adb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1369
X-MC-Unique: CFRyuALyO-u5YcRC0XHBXQ-1
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UEdZW4010604

Hi Linus,

The following changes since commit a8750ddca918032d6349adbf9a4b6555e7db20da:

  Linux 4.15-rc8 (2018-01-14 15:32:30 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-4.16-1

for you to fetch changes up to e231c6879cfd44e4fffd384bb6dd7d313249a523:

  NFS: Fix a race between mmap() and O_DIRECT (2018-01-28 22:00:15 -0500)

----------------------------------------------------------------
NFS client updates for Linux 4.16

Highlights include:

Stable bugfixes:
- Fix breakages in the nfsstat utility due to the inclusion of the NFSv4
  LOOKUPP operation.
- Fix a NULL pointer dereference in nfs_idmap_prepare_pipe_upcall() due to
  nfs_idmap_legacy_upcall() being called without an 'aux' parameter.
- Fix a refcount leak in the standard O_DIRECT error path.
- Fix a refcount leak in the pNFS O_DIRECT fallback to MDS path.
- Fix CPU latency issues with nfs_commit_release_pages()
- Fix the LAYOUTUNAVAILABLE error case in the file layout type.
- NFS: Fix a race between mmap() and O_DIRECT

Features:
- Support the statx() mask and query flags to enable optimisations when
  the user is requesting only attributes that are already up to date in
  the inode cache, or is specifying the AT_STATX_DONT_SYNC flag.
- Add a module alias for the SCSI pNFS layout type.

Bugfixes:
- Automounting when resolving a NFSv4 referral should preserve the RDMA
  transport protocol settings.
- Various other RDMA bugfixes from Chuck.
- pNFS block layout fixes.
- Always set NFS_LOCK_LOST when a lock is lost.

----------------------------------------------------------------
Arnd Bergmann (1):
      nfs: remove unused label in nfs_encode_fh()

Benjamin Coddington (7):
      NFS: remove unused offset arg in nfs_pgio_rpcsetup
      pnfs/blocklayout: Add module alias for LAYOUT4_SCSI
      pnfs/blocklayout: set PNFS_LAYOUTRETURN_ON_ERROR
      pnfs/blocklayout: handle transient devices
      SUNRPC: Fix null rpc_clnt dereference in rpc_task_queued tracepoint
      pnfs/blocklayout: pnfs_block_dev_map uses bytes, not sectors
      pnfs/blocklayout: Ensure disk address in block device map

Chuck Lever (39):
      nfs: Define NFS_RDMA_PORT
      nfs: Referrals should use the same proto setting as their parent
      nfs: Update server port after referral or migration
      SUNRPC: Remove rpc_protocol()
      xprtrdma: Fix buffer leak after transport set up failure
      xprtrdma: Fix backchannel allocation of extra rpcrdma_reps
      xprtrdma: Eliminate unnecessary lock cycle in xprt_rdma_send_request
      xprtrdma: Per-mode handling for Remote Invalidation
      xprtrdma: Remove ri_reminv_expected
      xprtrdma: Remove unused padding variables
      xprtrdma: Initialize the xprt address string array earlier
      xprtrdma: Remove another sockaddr_storage field (cdata::addr)
      xprtrdma: Support IPv6 in xprt_rdma_set_port
      xprtrdma: Move unmap-safe logic to rpcrdma_marshal_req
      xprtrdma: buf_free not called for CB replies
      xprtrdma: Split xprt_rdma_send_request
      xprtrdma: Don't clear RPC_BC_PA_IN_USE on pre-allocated rpc_rqst's
      xprtrdma: Replace all usage of "frmr" with "frwr"
      xprtrdma: Remove usage of "mw"
      xprtrdma: Introduce rpcrdma_mw_unmap_and_put
      nfs: Use proper enum definitions for nfs_show_stable
      rdma/ib: Add trace point macros to display human-readable values
      rpcrdma: infrastructure for static trace points in rpcrdma.ko
      xprtrdma: Add trace points in RPC Call transmit paths
      xprtrdma: Add trace points in the RPC Reply handler paths
      xprtrdma: Add trace points to instrument memory registration
      xprtrdma: Add trace points in reply decoder path
      xprtrdma: Add trace points to instrument memory invalidation
      xprtrdma: Add trace points to instrument MR allocation and recovery
      xprtrdma: Add trace points for connect events
      xprtrdma: Add trace points in the client-side backchannel code paths
      xprtrdma: Add trace points to instrument QP and CQ access upcalls
      xprtrdma: Instrument allocation/release of rpcrdma_req/rep objects
      xprtrdma: Fix "bytes registered" accounting
      xprtrdma: Correct some documenting comments
      SUNRPC: Trace xprt_timer events
      sunrpc: Format RPC events consistently for display
      SUNRPC: task_run_action should display tk_callback
      SUNRPC: Micro-optimize __rpc_execute

Elena Reshetova (4):
      lockd: convert nlm_host.h_count from atomic_t to refcount_t
      lockd: convert nsm_handle.sm_count from atomic_t to refcount_t
      lockd: convert nlm_lockowner.count from atomic_t to refcount_t
      lockd: convert nlm_rqst.a_count from atomic_t to refcount_t

Eric Biggers (1):
      NFS: reject request for id_legacy key without auxdata

J. Bruce Fields (1):
      NFS: commit direct writes even if they fail partially

Jan Chochol (1):
      nfs: Do not convert nfs_idmap_cache_timeout to jiffies

NeilBrown (2):
      nfs: remove dead code from nfs_encode_fh()
      NFSv4: always set NFS_LOCK_LOST when a lock is lost.

Scott Mayhew (1):
      nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds

Tigran Mkrtchyan (1):
      nfs41: do not return ENOMEM on LAYOUTUNAVAILABLE

Trond Myklebust (12):
      NFS: Add a cond_resched() to nfs_commit_release_pages()
      NFSv4: Convert CLOSE to use nfs4_async_handle_exception()
      NFSv4: Convert DELEGRETURN to use nfs4_handle_exception()
      NFSv4: Convert LOCKU to use nfs4_async_handle_exception()
      NFS: Fix nfsstat breakage due to LOOKUPP
      Support statx() mask and query flags parameters
      SUNRPC: Chunk reading of replies from the server
      SUNRPC: Add explicit rescheduling points in the receive path
      Merge tag 'nfs-rdma-for-4.16-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
      lockd: Fix server refcounting
      NFS: Remove a redundant call to unmap_mapping_range()
      NFS: Fix a race between mmap() and O_DIRECT

 fs/lockd/clntproc.c               |  14 +-
 fs/lockd/host.c                   |  22 +-
 fs/lockd/mon.c                    |  14 +-
 fs/lockd/svcproc.c                |   2 +-
 fs/nfs/blocklayout/blocklayout.c  |  94 +++-
 fs/nfs/blocklayout/blocklayout.h  |   7 +-
 fs/nfs/blocklayout/dev.c          |   7 +-
 fs/nfs/direct.c                   |   4 +-
 fs/nfs/export.c                   |   5 -
 fs/nfs/filelayout/filelayout.c    |   4 +-
 fs/nfs/inode.c                    |  53 ++-
 fs/nfs/io.c                       |   2 +-
 fs/nfs/nfs4client.c               |  24 +-
 fs/nfs/nfs4idmap.c                |   6 +-
 fs/nfs/nfs4namespace.c            |   2 -
 fs/nfs/nfs4proc.c                 |  42 +-
 fs/nfs/nfs4state.c                |   5 +-
 fs/nfs/nfs4sysctl.c               |   2 +-
 fs/nfs/nfs4xdr.c                  |  64 +--
 fs/nfs/nfstrace.h                 |  22 +-
 fs/nfs/pagelist.c                 |   8 +-
 fs/nfs/pnfs.c                     |   6 +-
 fs/nfs/pnfs.h                     |   6 +-
 fs/nfs/pnfs_dev.c                 |   1 -
 fs/nfs/write.c                    |   2 +
 include/linux/lockd/lockd.h       |   9 +-
 include/linux/nfs4.h              |  12 +-
 include/linux/sunrpc/clnt.h       |   1 -
 include/linux/sunrpc/xprtrdma.h   |   2 +-
 include/trace/events/rdma.h       | 129 ++++++
 include/trace/events/rpcrdma.h    | 890 ++++++++++++++++++++++++++++++++++++++
 include/trace/events/sunrpc.h     |  12 +-
 include/uapi/linux/nfs.h          |   1 +
 net/sunrpc/clnt.c                 |  16 -
 net/sunrpc/sched.c                |  26 +-
 net/sunrpc/xprt.c                 |   2 +-
 net/sunrpc/xprtrdma/backchannel.c |  78 ++--
 net/sunrpc/xprtrdma/fmr_ops.c     | 157 ++++---
 net/sunrpc/xprtrdma/frwr_ops.c    | 329 +++++++-------
 net/sunrpc/xprtrdma/module.c      |  12 +-
 net/sunrpc/xprtrdma/rpc_rdma.c    | 162 +++----
 net/sunrpc/xprtrdma/transport.c   | 128 +++---
 net/sunrpc/xprtrdma/verbs.c       | 280 ++++++------
 net/sunrpc/xprtrdma/xprt_rdma.h   | 116 ++---
 net/sunrpc/xprtsock.c             |  36 +-
 45 files changed, 1995 insertions(+), 821 deletions(-)
 create mode 100644 include/trace/events/rdma.h
 create mode 100644 include/trace/events/rpcrdma.h

-- 
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com
