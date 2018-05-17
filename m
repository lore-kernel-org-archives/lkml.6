Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeEQUzD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:55:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9290 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQUzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:55:01 -0400
X-IronPort-AV: E=Sophos;i="5.49,412,1520870400";
   d="scan'208";a="181504212"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMA
Date: Thu, 17 May 2018 20:54:57 +0000
Message-ID: <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
In-Reply-To: <20180509013358.16399-1-kent.overstreet@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1073;7:+Am6YTCeZ0QlVTRln8OPvuJbmprK+2XDFja+N4Y/3UedGtM3vZ/ue1k8ulSqaIpw2kZ+ZMVnWoP3AX3AiXlN7Mr8Dct2afRvmo7YfVw0qGzqUc2N9+ekW2SSEFVKJ0nixpo6ri4qq1vt1mEEtEsTu/5Tt/rWDGgc+0koQC3yiZy556oQ4vD1eQS3gTeSBJkMjKrH0crwUzbFnQUbk2Xx6DT7dt+Jc8Q7C71Qxy1oxAkciWVnYcdZNwDmzNWrFEFc;20:FDKl2WgPDGBREVM2raYJc/SnJ1JS8SrKWTsQJp9IHEp1ew7yul3Z8st9Wq4FGHKMLXKKSrTvmfT0yii+cpGbkHkpAA8a8wuo71KLR7TCgvGhxS4TLzhsPHDJTnztga1/EQfIPBMMwyexCm4jRUIlfjapIp4HeceE++mguCa7rb4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1073;
x-ms-traffictypediagnostic: MWHPR04MB1073:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1073AC22EFE696D8622FFCB698910@MWHPR04MB1073.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1073;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1073;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(377424004)(6506007)(5660300001)(186003)(76176011)(229853002)(53936002)(6246003)(8676002)(2900100001)(99286004)(59450400001)(81166006)(6486002)(81156014)(66066001)(14454004)(26005)(6436002)(305945005)(8936002)(102836004)(118296001)(97736004)(486006)(7736002)(68736007)(3660700001)(36756003)(106356001)(105586002)(2201001)(11346002)(446003)(5250100002)(2906002)(72206003)(478600001)(86362001)(476003)(25786009)(2616005)(39060400002)(110136005)(3280700002)(6512007)(3846002)(6116002)(316002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1073;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tERfG3wj4nB3eB+Y+MzroWhGJDyX9Xe3+HMBnu117qvO30PbnSGUagJuaJqM/0+MyqXXj9IM/eC0bVsC7nokiR8YFTj1P/klAhywNChC1CP2FNI+l5qFSTwfPSik7Lousmp3pL5GWjG6m+Id9dLPvEacbXPyZ2kWKd8s4F09wicj4vGWioXlUhVfyOwp0Vdx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <887FC55360788849A1FEED2D5DF5ECFC@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4e0f0a2b-79ca-4e94-c521-08d5bc387341
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0f0a2b-79ca-4e94-c521-08d5bc387341
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 20:54:57.9111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1073
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HKt9H7010888

On Tue, 2018-05-08 at 21:33 -0400, Kent Overstreet wrote:
> [ ... ]

Hello Kent,

With Jens' latest for-next branch I hit the kernel warning shown below. Can
you have a look?

Thanks,

Bart.


==================================================================
BUG: KASAN: use-after-free in bio_advance+0x110/0x1b0
Read of size 4 at addr ffff880156c5e6d0 by task ksoftirqd/10/72

CPU: 10 PID: 72 Comm: ksoftirqd/10 Tainted: G        W         4.17.0-rc4-dbg+ #5
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
dump_stack+0x9a/0xeb
print_address_description+0x65/0x270
kasan_report+0x232/0x350
bio_advance+0x110/0x1b0
blk_update_request+0x9d/0x5a0
scsi_end_request+0x4c/0x300 [scsi_mod]
scsi_io_completion+0x71e/0xa40 [scsi_mod]
__blk_mq_complete_request+0x143/0x220
srp_recv_done+0x454/0x1100 [ib_srp]
__ib_process_cq+0x9a/0xf0 [ib_core]
ib_poll_handler+0x2d/0x90 [ib_core]
irq_poll_softirq+0xe5/0x1e0
__do_softirq+0x112/0x5f0
run_ksoftirqd+0x29/0x50
smpboot_thread_fn+0x30f/0x410
kthread+0x1b2/0x1d0
ret_from_fork+0x24/0x30

Allocated by task 1356:
kasan_kmalloc+0xa0/0xd0
kmem_cache_alloc+0xed/0x320
mempool_alloc+0xc6/0x210
bio_alloc_bioset+0x128/0x2d0
submit_bh_wbc+0x95/0x2d0
__block_write_full_page+0x2a6/0x5c0
__writepage+0x37/0x80
write_cache_pages+0x305/0x7c0
generic_writepages+0xb9/0x110
do_writepages+0x96/0x180
__filemap_fdatawrite_range+0x162/0x1b0
file_write_and_wait_range+0x4d/0xb0
blkdev_fsync+0x3c/0x70
do_fsync+0x33/0x60
__x64_sys_fsync+0x18/0x20
do_syscall_64+0x6d/0x220
entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 72:
__kasan_slab_free+0x130/0x180
kmem_cache_free+0xcd/0x380
blk_update_request+0xc4/0x5a0
blk_update_request+0xc4/0x5a0
scsi_end_request+0x4c/0x300 [scsi_mod]
scsi_io_completion+0x71e/0xa40 [scsi_mod]
__blk_mq_complete_request+0x143/0x220
srp_recv_done+0x454/0x1100 [ib_srp]
__ib_process_cq+0x9a/0xf0 [ib_core]
ib_poll_handler+0x2d/0x90 [ib_core]
irq_poll_softirq+0xe5/0x1e0
__do_softirq+0x112/0x5f0

The buggy address belongs to the object at ffff880156c5e640
which belongs to the cache bio-0 of size 200
The buggy address is located 144 bytes inside of
200-byte region [ffff880156c5e640, ffff880156c5e708)
The buggy address belongs to the page:
page:ffffea00055b1780 count:1 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
ib_srpt:srpt_zerolength_write: ib_srpt 10.196.159.179-24: queued zerolength write
flags: 0x8000000000008100(slab|head)
raw: 8000000000008100 0000000000000000 0000000000000000 0000000100190019
raw: ffffea000543a800 0000000200000002 ffff88015a8f3a00 0000000000000000
ib_srpt:srpt_zerolength_write: ib_srpt 10.196.159.179-22: queued zerolength write
page dumped because: kasan: bad access detected
ib_srpt:srpt_zerolength_write: ib_srpt 10.196.159.179-20: queued zerolength write

Memory state around the buggy address:
ib_srpt:srpt_zerolength_write: ib_srpt 10.196.159.179-18: queued zerolength write
ffff880156c5e580: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
ib_srpt:srpt_zerolength_write_done: ib_srpt 10.196.159.179-24 wc->status 5
ffff880156c5e600: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
ib_srpt:srpt_zerolength_write_done: ib_srpt 10.196.159.179-22 wc->status 5
>ffff880156c5e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ib_srpt:srpt_zerolength_write_done: ib_srpt 10.196.159.179-20 wc->status 5
                                                ^
ffff880156c5e700: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ib_srpt:srpt_zerolength_write_done: ib_srpt 10.196.159.179-18 wc->status 5
ffff880156c5e780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ib_srpt:srpt_release_channel_work: ib_srpt 10.196.159.179-24
==================================================================

(gdb) list *(bio_advance+0x110)
0xffffffff81450090 is in bio_advance (./include/linux/bvec.h:82).
77                      iter->bi_size = 0;
78                      return false;
79              }
80
81              while (bytes) {
82                      unsigned iter_len = bvec_iter_len(bv, *iter);
83                      unsigned len = min(bytes, iter_len);
84
85                      bytes -= len;
86                      iter->bi_size -= len;
