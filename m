Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeEGRTL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:19:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751976AbeEGRTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:19:09 -0400
Subject: Re: WARNING in __mutex_unlock_slowpath
To: syzbot <syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com>,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        Cathy Avery <cavery@redhat.com>
References: <000000000000170595056affab1c@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <59d3e273-293d-7597-7d69-b5278318a026@redhat.com>
Date: Mon, 7 May 2018 19:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000170595056affab1c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2018 19:00, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> bf8f5de17442bba5f811e7e724980730e079ee11 (Sat Apr 28 17:05:04 2018 +0000)
> MAINTAINERS: add myself as maintainer of AFFS
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=35666cba7f0a337e2e79
> 
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5686569910403072
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5767017265102848
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6346308495343616
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=7043958930931867332
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
> WARNING: CPU: 0 PID: 4525 at kernel/locking/mutex.c:1032
> __mutex_unlock_slowpath+0x62e/0x8a0 kernel/locking/mutex.c:1032
> Kernel panic - not syncing: panic_on_warn set ...

This doesn't make much sense, unless it's a "generic" memory corruption,
but at least the reproducer seems to be simple, just (in pseudocode)

  ioctl(kvm_vm_fd, KVM_HYPERV_EVENTFD,
        { fd = some_eventfd, conn_id = 0, flags = 0 })
  ioctl(kvm_vm_fd, KVM_HYPERV_EVENTFD,
        { fd = -1, conn_id = 5, flags = KVM_HYPERV_EVENTFD_DEASSIGN })

Roman, Cathy, can you give it a quick look?  (Reproducing the reproducer
link: https://syzkaller.appspot.com/x/repro.c?id=5686569910403072).

Paolo

> CPU: 0 PID: 4525 Comm: syz-executor809 Not tainted 4.17.0-rc2+ #22
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  panic+0x22f/0x4de kernel/panic.c:184
>  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
> RIP: 0010:__mutex_unlock_slowpath+0x62e/0x8a0 kernel/locking/mutex.c:1032
> RSP: 0018:ffff8801cf31f138 EFLAGS: 00010286
> RAX: 0000000000000033 RBX: 1ffff10039e63e30 RCX: ffffffff8160b82d
> RDX: 0000000000000000 RSI: ffffffff816104e1 RDI: 0000000000000001
> RBP: ffff8801cf31f2a8 R08: ffff8801d9042180 R09: fffffbfff11b0974
> R10: fffffbfff11b0974 R11: ffffffff88d84ba3 R12: ffffffff8a713a20
> R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8801989d6b08
>  mutex_unlock+0xd/0x10 kernel/locking/mutex.c:614
>  kvm_hv_eventfd_deassign arch/x86/kvm/hyperv.c:1434 [inline]
>  kvm_vm_ioctl_hv_eventfd+0x1ea/0x24b arch/x86/kvm/hyperv.c:1451
>  kvm_arch_vm_ioctl+0x155e/0x2690 arch/x86/kvm/x86.c:4563
>  kvm_vm_ioctl+0x246/0x1d90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3100
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4401f9
> RSP: 002b:00007ffcd5727a48 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 6d766b2f7665642f RCX: 00000000004401f9
> RDX: 0000000020000140 RSI: 000000004018aebd RDI: 00000000000000ee
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401720
> R13: 00000000004017b0 R14: 0000000000000000 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
