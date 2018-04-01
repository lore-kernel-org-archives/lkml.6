Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbeDAPDI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 11:03:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29778 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753947AbeDAPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 11:03:03 -0400
X-IronPort-AV: E=Sophos;i="5.48,391,1517846400";
   d="scan'208";a="74996181"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "wakko@animx.eu.org" <wakko@animx.eu.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lduncan@suse.com" <lduncan@suse.com>,
        "cleech@redhat.com" <cleech@redhat.com>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Thread-Topic: 4.15.14 crash with iscsi target and dvd
Thread-Index: AQHTyTSBb5uvLpZh0kGvcKoLkXFdJKPq6GkAgABbqICAAIUdgIAAOXMA
Date: Sun, 1 Apr 2018 15:02:59 +0000
Message-ID: <44e142c66ee48606a877af37077f9a6dd8a522dc.camel@wdc.com>
References: <20180331015903.GA29398@animx.eu.org>
         <CAFLxGvzbA9XzXLsH56iyqYkitrSnBbOzD977u4266=w5zw0jNg@mail.gmail.com>
         <20180331221252.GA25573@animx.eu.org>
         <b68bf187c9cde1c36489fc5ab2187ca8750a1292.camel@wdc.com>
         <20180401113721.GA8471@animx.eu.org>
In-Reply-To: <20180401113721.GA8471@animx.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1166;7:ptL71nDedA8Zuj6XFcNK8bMlO6UY5gxdKvjXI2h+ZV0K5oGkZcEsRKt8CtzZkvGQTGO7M5CedrmJSbdy538lhzGOlHksuCSg5pt/aV2u1ihHvFhaYBzfHgvAE3QzVIFqwMHizBzrJ4KZL+SSZBsfZ5H4bMLYZKRfJ+DDlbeKp2rUK/bEUhsy/otA7HtGbRGPlog7eva3X3jYRIkLdp+b5ZHcWBF7a86WvLZ6xgVaChZQmaqwao1YfyFMOIMtQfIz;20:ClexSqZ4Z0W59QGd7yQ5nJJ5qciN+d/pNMukpKMvZXnLJq0K+cInV8aRZruL89VUxXvnnzCrI7gc3QU1TJFu6r4vIkSM+TBOW+at3LJxvot9UuN5IjIvvNOJX9ODxfSV4pYYlG6K72tFv/mHs5p8JWGF9t4/ArL8hXR3a8zV9LQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85766057-4ded-4f23-d464-08d597e1a8b0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1166;
x-ms-traffictypediagnostic: MWHPR04MB1166:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1166148728425B88A42BD73298A70@MWHPR04MB1166.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1166;
x-forefront-prvs: 06290ECA9D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(39380400002)(366004)(346002)(51234002)(377424004)(199004)(189003)(2501003)(6116002)(5890100001)(7736002)(66066001)(53546011)(6506007)(486005)(5660300001)(59450400001)(106356001)(54906003)(5250100002)(68736007)(3846002)(6512007)(25786009)(53936002)(186003)(72206003)(45080400002)(105586002)(486005)(476003)(76176011)(2906002)(99286004)(86362001)(102836004)(446003)(229853002)(8676002)(93886005)(97736004)(81166006)(81156014)(53946003)(26005)(118296001)(1730700003)(4326008)(8936002)(3280700002)(2616005)(39060400002)(11346002)(478600001)(316002)(36756003)(14454004)(305945005)(2900100001)(6916009)(5640700003)(6486002)(6246003)(3660700001)(2351001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1166;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EREvYdzVFy8HECGPFJT4NZ+gFz76IYFKIkEhWcSN5yaGRui1vGyEpVE5neWOnyk01Rvx7ic74tmagz73avtFcrJx04zgpwmE8PtNAZvnUG35abHsGVm9udL8Tt6qRPCLOWvHEpzVQDZIrFU4m9HS51mecsjLyVzbOMmis3dZ4Qu8QBLg/3luhKuupNlBSFy5p3KlJple0613DGWpnEocXJhuxZqqIBL3EyEFhbT1n6p+zyZbqJ+ilBwgRmhEp02sXSkHoIpEG3gR1BUq9/bsXsCu91Mzzdxd8pEIkr/S4jU1HlJ7x7DLKYPRNeI9dkZbweGeapxwHZ4cL5rH7ZfdDemWLIF8jQtyEOV58VS1q1fsubmOuYoH3YQ03Kfai5FrPkX7TRq2RDFgmgw5UnPmA+GZPIzWX4kIX1rRHi2YFU4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <305260EB71EA83469E22F196B76EDCF9@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85766057-4ded-4f23-d464-08d597e1a8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2018 15:02:59.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1166
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w31F3T6A014395

On Sun, 2018-04-01 at 07:37 -0400, Wakko Warner wrote:
> Bart Van Assche wrote:
> > On Sat, 2018-03-31 at 18:12 -0400, Wakko Warner wrote:
> > > Richard Weinberger wrote:
> > > > On Sat, Mar 31, 2018 at 3:59 AM, Wakko Warner <wakko@animx.eu.org> wrote:
> > > > > I reported this before but noone responded.
> > > > 
> > > > Because you're sending only to LKML.
> > > > CC'ing storage folks.
> > > 
> > > Thank you.  I wasn't sure who I needed to send it to.
> > 
> > Can you share the output of lsscsi? I would like to know whether or not you
> > are using a (S)ATA CDROM.
> 
> From the target:
> [4:0:0:0]    cd/dvd  ATAPI    iHAS224   B      GL05  /dev/sr0 
> [5:0:0:0]    cd/dvd  ATAPI    iHAS422   8      4L11  /dev/sr1 
> [6:0:0:0]    cd/dvd  PBDS     DVD+-RW DH-16W1S 2D14  /dev/sr2 
> 
> From the initiator:
> [19:0:0:0]   cd/dvd  ATAPI    iHAS224   B      GL05  /dev/sr1
> [19:0:0:1]   cd/dvd  ATAPI    iHAS422   8      4L11  /dev/sr2
> [19:0:0:2]   cd/dvd  PBDS     DVD+-RW DH-16W1S 2D14  /dev/sr3
> 
> I tested 4.14.32 last night with the same oops.  4.9.91 works fine.
> From the initiator, if I do cat /dev/sr1 > /dev/null it works.  If I mount
> /dev/sr1 and then do find -type f | xargs cat > /dev/null the target
> crashes.  I'm using the builtin iscsi target with pscsi.  I can burn from
> the initiator with out problems.  I'll test other kernels between 4.9 and
> 4.14.

(+Lee and Chris)

Hello Wakko,

Although I'm not sure that what I ran into is exactly the same as what you
ran into, there is definitely something wrong with what I encountered. What
I ran into with Linus' latest master branch indicates two issues - one in
the iSCSI initiator and one in the block layer:

scsi 3:0:0:1: Direct-Access     LIO-ORG  FILEIO           4.0  PQ: 0 ANSI: 5
sd 2:0:0:1: [sdd] Attached SCSI disk
sd 3:0:0:1: Warning! Received an indication that the LUN assignments on this
target have changed. The Linux SCSI layer does not automatical
sd 3:0:0:1: Attached scsi generic sg8 type 0
sd 3:0:0:1: [sdf] 128 512-byte logical blocks: (65.5 kB/64.0 KiB)
sd 3:0:0:1: [sdf] Write Protect is off
sd 3:0:0:1: [sdf] Mode Sense: 43 00 00 08
sd 3:0:0:1: [sdf] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
iSCSI/iqn.1993-08.org.debian:01:3b68b1b3d2eb: Unsupported SCSI Opcode 0xa3,
sending CHECK_CONDITION.
sd 3:0:0:2: [sde] Attached SCSI disk
sd 3:0:0:1: [sdf] Attached SCSI disk

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
4.16.0-rc7-dbg+ #3 Not tainted
-----------------------------------------------------
kworker/6:1H/155 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (&(&session->frwd_lock)->rlock){+.-.}, at: [<000000007eb678ec>]
iscsi_eh_cmd_timed_out+0x6b/0x5a0 [libiscsi]

and this task is already holding:
 (&(&q->__queue_lock)->rlock){-.-.}, at: [<000000003c5841ec>]
blk_timeout_work+0x45/0x220
which would create a new lock dependency:
 (&(&q->__queue_lock)->rlock){-.-.} -> (&(&session->frwd_lock)->rlock){+.-.}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&(&q->__queue_lock)->rlock){-.-.}

... which became HARDIRQ-irq-safe at:
  _raw_spin_lock_irqsave+0x46/0x60
  ata_qc_schedule_eh+0xb9/0x110 [libata]
  ata_sff_hsm_move+0x114/0xb10 [libata]
  __ata_sff_port_intr+0xec/0x1a0 [libata]
  ata_bmdma_port_intr+0xef/0x160 [libata]
  ata_bmdma_interrupt+0x160/0x2e0 [libata]
  __handle_irq_event_percpu+0x72/0x460
  handle_irq_event_percpu+0x66/0xd0
  handle_irq_event+0x54/0x90
  handle_edge_irq+0xe9/0x2d0
  handle_irq+0x17b/0x210
  do_IRQ+0x6c/0x140
  ret_from_intr+0x0/0x1e
  native_safe_halt+0x2/0x10
  default_idle+0x1f/0x200
  do_idle+0x1bc/0x1f0
  cpu_startup_entry+0x19/0x20
  start_kernel+0x47f/0x4a1
  secondary_startup_64+0xa5/0xb0

to a HARDIRQ-irq-unsafe lock:
 (&(&session->frwd_lock)->rlock){+.-.}

... which became HARDIRQ-irq-unsafe at:
...
  _raw_spin_lock_bh+0x34/0x40
  iscsi_conn_setup+0x239/0x320 [libiscsi]
  iscsi_tcp_conn_setup+0x14/0x80 [libiscsi_tcp]
  iscsi_sw_tcp_conn_create+0x1f/0x24a [iscsi_tcp]
  iscsi_if_rx+0x13c9/0x20d0 [scsi_transport_iscsi]
  netlink_unicast+0x299/0x330
  netlink_sendmsg+0x435/0x580
  ___sys_sendmsg+0x447/0x4d0
  __sys_sendmsg+0xad/0x120
  do_syscall_64+0xf3/0x2c0
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&session->frwd_lock)->rlock);
                               local_irq_disable();
                               lock(&(&q->__queue_lock)->rlock);
                               lock(&(&session->frwd_lock)->rlock);
  <Interrupt>
    lock(&(&q->__queue_lock)->rlock);

 *** DEADLOCK ***

3 locks held by kworker/6:1H/155:
 #0:  ((wq_completion)"kblockd"){+.+.}, at: [<00000000116fed84>]
process_one_work+0x387/0xa50
 #1:  ((work_completion)(&q->timeout_work)){+.+.}, at: [<00000000116fed84>]
process_one_work+0x387/0xa50
 #2:  (&(&q->__queue_lock)->rlock){-.-.}, at: [<000000003c5841ec>]
blk_timeout_work+0x45/0x220

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&(&q->__queue_lock)->rlock){-.-.} ops: 5585 {
   IN-HARDIRQ-W at:
                    _raw_spin_lock_irqsave+0x46/0x60
                    ata_qc_schedule_eh+0xb9/0x110 [libata]
                    ata_sff_hsm_move+0x114/0xb10 [libata]
                    __ata_sff_port_intr+0xec/0x1a0 [libata]
                    ata_bmdma_port_intr+0xef/0x160 [libata]
                    ata_bmdma_interrupt+0x160/0x2e0 [libata]
                    __handle_irq_event_percpu+0x72/0x460
                    handle_irq_event_percpu+0x66/0xd0
                    handle_irq_event+0x54/0x90
                    handle_edge_irq+0xe9/0x2d0
                    handle_irq+0x17b/0x210
                    do_IRQ+0x6c/0x140
                    ret_from_intr+0x0/0x1e
                    native_safe_halt+0x2/0x10
                    default_idle+0x1f/0x200
                    do_idle+0x1bc/0x1f0
                    cpu_startup_entry+0x19/0x20
                    start_kernel+0x47f/0x4a1
                    secondary_startup_64+0xa5/0xb0
   IN-SOFTIRQ-W at:
                    _raw_spin_lock_irqsave+0x46/0x60
                    scsi_end_request+0x199/0x310 [scsi_mod]
                    scsi_io_completion+0x3be/0x980 [scsi_mod]
                    blk_done_softirq+0x177/0x1c0
                    __do_softirq+0x117/0x5f5
                    irq_exit+0xe8/0xf0
                    do_IRQ+0xb6/0x140
                    ret_from_intr+0x0/0x1e
                    native_safe_halt+0x2/0x10
                    default_idle+0x1f/0x200
                    do_idle+0x1bc/0x1f0
                    cpu_startup_entry+0x19/0x20
                    start_kernel+0x47f/0x4a1
                    secondary_startup_64+0xa5/0xb0
   INITIAL USE at:
                   _raw_spin_lock_irq+0x3b/0x50
                   blkcg_init_queue+0x97/0x1c0
                   blk_alloc_queue_node+0x41d/0x4b0
                   blk_mq_init_queue+0x24/0x60
                   virtblk_probe+0x633/0xfef [virtio_blk]
                   virtio_dev_probe+0x259/0x380 [virtio]
                   driver_probe_device+0x469/0x680
                   __driver_attach+0xef/0x120
                   bus_for_each_dev+0xe4/0x130
                   bus_add_driver+0x24c/0x380
                   driver_register+0xc6/0x170
                   ata_generic_init_one+0x5b/0x260 [ata_generic]
                   do_one_initcall+0x79/0x1b7
                   do_init_module+0xde/0x32d
                   load_module+0x3964/0x47d0
                   SYSC_finit_module+0x176/0x1a0
                   do_syscall_64+0xf3/0x2c0
                   entry_SYSCALL_64_after_hwframe+0x42/0xb7
 }
 ... key      at: [<00000000da510125>] __key.53375+0x0/0x40
 ... acquired at:
   _raw_spin_lock+0x2f/0x40
   iscsi_eh_cmd_timed_out+0x6b/0x5a0 [libiscsi]
   scsi_times_out+0xcc/0x3f0 [scsi_mod]
   blk_rq_timed_out+0x2f/0x70
   blk_timeout_work+0x1b0/0x220
   process_one_work+0x446/0xa50
   worker_thread+0x7b/0x6d0
   kthread+0x1b7/0x1e0
   ret_from_fork+0x24/0x30


the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&(&session->frwd_lock)->rlock){+.-.} ops: 1985 {
   HARDIRQ-ON-W at:
                    _raw_spin_lock_bh+0x34/0x40
                    iscsi_conn_setup+0x239/0x320 [libiscsi]
                    iscsi_tcp_conn_setup+0x14/0x80 [libiscsi_tcp]
                    iscsi_sw_tcp_conn_create+0x1f/0x24a [iscsi_tcp]
                    iscsi_if_rx+0x13c9/0x20d0 [scsi_transport_iscsi]
                    netlink_unicast+0x299/0x330
                    netlink_sendmsg+0x435/0x580
                    ___sys_sendmsg+0x447/0x4d0
                    __sys_sendmsg+0xad/0x120
                    do_syscall_64+0xf3/0x2c0
                    entry_SYSCALL_64_after_hwframe+0x42/0xb7
   IN-SOFTIRQ-W at:
                    _raw_spin_lock_bh+0x34/0x40
                    iscsi_queuecommand+0xef/0x960 [libiscsi]
                    scsi_dispatch_cmd+0x1c7/0x550 [scsi_mod]
                    scsi_request_fn+0x823/0xaf0 [scsi_mod]
                    __blk_run_queue+0xc5/0x160
                    blk_run_queue+0x48/0x70
                    scsi_run_queue+0x475/0x5d0 [scsi_mod]
                    scsi_end_request+0x1cd/0x310 [scsi_mod]
                    scsi_io_completion+0x3be/0x980 [scsi_mod]
                    blk_done_softirq+0x177/0x1c0
                    __do_softirq+0x117/0x5f5
                    run_ksoftirqd+0x2e/0x50
                    smpboot_thread_fn+0x314/0x410
                    kthread+0x1b7/0x1e0
                    ret_from_fork+0x24/0x30
   INITIAL USE at:
                   _raw_spin_lock_bh+0x34/0x40
                   iscsi_conn_setup+0x239/0x320 [libiscsi]
                   iscsi_tcp_conn_setup+0x14/0x80 [libiscsi_tcp]
                   iscsi_sw_tcp_conn_create+0x1f/0x24a [iscsi_tcp]
                   iscsi_if_rx+0x13c9/0x20d0 [scsi_transport_iscsi]
                   netlink_unicast+0x299/0x330
                   netlink_sendmsg+0x435/0x580
                   ___sys_sendmsg+0x447/0x4d0
                   __sys_sendmsg+0xad/0x120
                   do_syscall_64+0xf3/0x2c0
                   entry_SYSCALL_64_after_hwframe+0x42/0xb7
 }
 ... key      at: [<00000000df8f47b5>] __key.68290+0x0/0xffffffffffff6300
[libiscsi]
 ... acquired at:
   _raw_spin_lock+0x2f/0x40
   iscsi_eh_cmd_timed_out+0x6b/0x5a0 [libiscsi]
   scsi_times_out+0xcc/0x3f0 [scsi_mod]
   blk_rq_timed_out+0x2f/0x70
   blk_timeout_work+0x1b0/0x220
   process_one_work+0x446/0xa50
   worker_thread+0x7b/0x6d0
   kthread+0x1b7/0x1e0
   ret_from_fork+0x24/0x30


stack backtrace:
CPU: 6 PID: 155 Comm: kworker/6:1H Not tainted 4.16.0-rc7-dbg+ #3
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Workqueue: kblockd blk_timeout_work
Call Trace:
 dump_stack+0x85/0xc5
 check_usage+0x6e7/0x700
 ? check_usage_forwards+0x220/0x220
 ? find_next_and_bit+0x51/0xe0
 ? cpumask_next_and+0x20/0x30
 ? find_busiest_group+0xc94/0x1010
 ? class_equal+0x11/0x20
 ? __bfs+0x62/0x2e0
 ? class_equal+0x11/0x20
 ? __bfs+0xfb/0x2e0
 ? __lock_acquire+0x17aa/0x1af0
 __lock_acquire+0x17aa/0x1af0
 ? mark_lock+0xc7/0x770
 ? debug_check_no_locks_freed+0x1b0/0x1b0
 ? __lock_acquire+0x583/0x1af0
 ? mark_lock+0xc7/0x770
 ? lock_pin_lock+0x160/0x160
 ? debug_check_no_locks_freed+0x1b0/0x1b0
 ? lock_acquire+0xc9/0x260
 lock_acquire+0xc9/0x260
 ? iscsi_eh_cmd_timed_out+0x6b/0x5a0 [libiscsi]
 _raw_spin_lock+0x2f/0x40
 ? iscsi_eh_cmd_timed_out+0x6b/0x5a0 [libiscsi]
 iscsi_eh_cmd_timed_out+0x6b/0x5a0 [libiscsi]
 scsi_times_out+0xcc/0x3f0 [scsi_mod]
 blk_rq_timed_out+0x2f/0x70
 blk_timeout_work+0x1b0/0x220
 process_one_work+0x446/0xa50
 ? pwq_dec_nr_in_flight+0x100/0x100
 ? worker_thread+0x177/0x6d0
 worker_thread+0x7b/0x6d0
 ? process_one_work+0xa50/0xa50
 kthread+0x1b7/0x1e0
 ? kthread_create_worker_on_cpu+0xc0/0xc0
 ret_from_fork+0x24/0x30

[ ... ]

------------[ cut here ]------------
kernel BUG at block/blk-core.c:3267!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
Modules linked in: sd_mod crc32c_generic target_core_pscsi
target_core_iblock target_core_file iscsi_target_mod target_core_mod brd
i2c_piix4 sg virtio_balloon i2c_core af_packet button ib_iser rdma_cm iw_cm
ib_cm ib_core configfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi
ip_tables x_tables autofs4 hid_generic usbhid hid ext4 crc16 mbcache jbd2
sr_mod cdrom ata_generic pata_acpi virtio_blk virtio_net ata_piix xhci_pci
xhci_hcd libata virtio_pci usbcore scsi_mod virtio_ring intel_agp usb_common
intel_gtt virtio agpgart
CPU: 2 PID: 151 Comm: scsi_eh_1 Tainted: G        W        4.16.0-rc7-dbg+
#3
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
RIP: 0010:__blk_end_request_all+0xda/0xe0
RSP: 0018:ffff88006192f980 EFLAGS: 00010002
sr 2:0:0:3: rejecting I/O to offline device
sr 3:0:0:3: rejecting I/O to offline device
RAX: 0000000000000001 RBX: ffff88006818e780 RCX: ffffffff814065a6
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff88006818e838
RBP: 000000000000000a R08: 0000000000000000 R09: 0000000000000012
R10: ffff88006192f588 R11: 000000005e4786a3 R12: 0000000000000000
R13: 0000000000000000 R14: ffff880061280160 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88006d280000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1fcc53f010 CR3: 00000000666fc000 CR4: 00000000000006e0
Call Trace:
 blk_peek_request+0x1ff/0x5f0
 scsi_request_fn+0x48/0xaf0 [scsi_mod]
 ? lock_acquire+0xc9/0x260
 __blk_run_queue+0xc5/0x160
 blk_run_queue+0x48/0x70
 scsi_run_queue+0x475/0x5d0 [scsi_mod]
 ? scsi_io_completion+0x69e/0x980 [scsi_mod]
 ? sdev_evt_alloc+0x80/0x80 [scsi_mod]
 ? blk_queue_end_tag+0x10a/0x210
 ? __list_add_valid+0x29/0xa0
 ? do_raw_spin_unlock+0x91/0x120
 scsi_io_completion+0x6a6/0x980 [scsi_mod]
 ? lock_downgrade+0x200/0x2b0
 ? scsi_end_request+0x310/0x310 [scsi_mod]
 ? scsi_device_unbusy+0x3b/0x60 [scsi_mod]
 scsi_eh_flush_done_q+0x1a6/0x210 [scsi_mod]
 ata_scsi_port_error_handler+0x794/0xb00 [libata]
 ata_scsi_error+0x168/0x1a0 [libata]
 ? ata_scsi_port_error_handler+0xb00/0xb00 [libata]
 ? _raw_spin_unlock_irqrestore+0x59/0x70
 scsi_error_handler+0x1b5/0xa40 [scsi_mod]
 ? scsi_eh_get_sense+0x3b0/0x3b0 [scsi_mod]
 ? __sched_text_start+0x8/0x8
 ? __wake_up_common+0x9c/0x230
 ? mark_held_locks+0x1c/0x90
 ? _raw_spin_unlock_irqrestore+0x59/0x70
 ? scsi_eh_get_sense+0x3b0/0x3b0 [scsi_mod]
 kthread+0x1b7/0x1e0
 ? kthread_create_worker_on_cpu+0xc0/0xc0
 ret_from_fork+0x24/0x30
Code: 85 c0 75 02 0f 0b 48 89 df e8 b3 99 eb ff 4c 8b 23 e9 6e ff ff ff 0f
0b eb 82 49 8d 7c 24 20 e8 9d 98 eb ff 45 8b 6c 24 20 eb 8c <0f> 0b 0f 1f 40
00 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 
RIP: __blk_end_request_all+0xda/0xe0 RSP: ffff88006192f980
---[ end trace b9c2429e31acedb4 ]---
