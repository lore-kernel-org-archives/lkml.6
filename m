Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeDSHZi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 03:25:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeDSHZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 03:25:35 -0400
Subject: Re: [btrfs_put_block_group] WARNING: CPU: 1 PID: 14674 at
 fs/btrfs/disk-io.c:3675 free_fs_root+0xc2/0xd0 [btrfs]
To: Fengguang Wu <fengguang.wu@intel.com>, linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Liu Bo <bo.li.liu@oracle.com>,
        Jeff Mahoney <jeffm@suse.com>, Omar Sandoval <osandov@fb.com>,
        linux-kernel@vger.kernel.org, lkp@01.org
References: <20180419053240.b65vnukgdkt37qmd@wfg-t540p.sh.intel.com>
From: Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <30f55a19-1a20-b3a0-89ef-72c2df965a68@suse.com>
Date: Thu, 19 Apr 2018 10:25:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419053240.b65vnukgdkt37qmd@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2018 08:32, Fengguang Wu wrote:
> Hello,
> 
> FYI this happens in mainline kernel and at least dates back to v4.16 .
> 
> It's rather rare error and happens when running xfstests.

Yeah, so this is something which only recently was characterised as
leaking delalloc inodes. I can easily reproduce this when running
generic/019 test. A fix is in the works.

> 
> [  438.327552] BTRFS: error (device dm-0) in __btrfs_free_extent:6962: errno=-5 IO failure
> [  438.336415] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:3070: errno=-5 IO failure
> [  438.345590] BTRFS error (device dm-0): pending csums is 1028096
> [  438.369254] BTRFS error (device dm-0): cleaner transaction attach returned -30
> [  438.377674] BTRFS info (device dm-0): at unmount delalloc count 98304
> [  438.385166] WARNING: CPU: 1 PID: 14674 at fs/btrfs/disk-io.c:3675 free_fs_root+0xc2/0xd0 [btrfs]
> [  438.396562] Modules linked in: dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey dm_mod netconsole btrfs xor zstd_decompress zstd_compress xxhash raid6_pq sd_mod sg snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ata_generic pata_acpi intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_intel kvm_intel snd_hda_codec kvm irqbypass crct10dif_pclmul eeepc_wmi crc32_pclmul crc32c_intel ghash_clmulni_intel pata_via asus_wmi sparse_keymap snd_hda_core ata_piix snd_hwdep ppdev rfkill wmi_bmof i915 pcbc snd_pcm snd_timer drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops snd aesni_intel parport_pc crypto_simd pcspkr libata soundcore cryptd glue_helper drm wmi parport video shpchp ip_tables
> [  438.467607] CPU: 1 PID: 14674 Comm: umount Not tainted 4.17.0-rc1 #1
> [  438.474798] Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 1002 04/01/2011
> [  438.484804] RIP: 0010:free_fs_root+0xc2/0xd0 [btrfs]
> [  438.490590] RSP: 0018:ffffc90008b0fda8 EFLAGS: 00010282
> [  438.496641] RAX: ffff88017c5954b0 RBX: ffff880137f6d800 RCX: 0000000180100003
> [  438.504652] RDX: 0000000000000001 RSI: ffffea0006e93600 RDI: 0000000000000000
> [  438.512679] RBP: ffff88017b360000 R08: ffff8801ba4dd000 R09: 0000000180100003
> [  438.520644] R10: ffffc90008b0fc70 R11: 0000000000000000 R12: ffffc90008b0fdd0
> [  438.528657] R13: ffff88017b360080 R14: ffffc90008b0fdc8 R15: 0000000000000000
> [  438.536662] FS:  00007f06c1a80fc0(0000) GS:ffff8801bfa80000(0000) knlGS:0000000000000000
> [  438.545582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  438.552157] CR2: 00007f06c12b0260 CR3: 000000017d3de004 CR4: 00000000000606e0
> [  438.642653] RAX: 0000000000000000 RBX: 000000000234a2d0 RCX: 00007f06c1359cf7
> [  438.793559] CPU: 1 PID: 14674 Comm: umount Tainted: G        W         4.17.0-rc1 #1
> [  438.802152] Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 1002 04/01/2011
> [  438.812108] RIP: 0010:btrfs_put_block_group+0x41/0x60 [btrfs]
> [  438.819364] RSP: 0018:ffffc90008b0fde0 EFLAGS: 00010206
> [  438.825378] RAX: 0000000000000000 RBX: ffff8801abf63000 RCX: e38e38e38e38e38f
> [  438.833307] RDX: 0000000000000001 RSI: 00000000000009f6 RDI: ffff8801abf63000
> [  438.841230] RBP: ffff88017b360000 R08: ffff88017d3b7750 R09: 0000000180380010
> [  438.849133] R10: ffffc90008b0fca0 R11: 0000000000000000 R12: ffff8801abf63000
> [  438.857047] R13: ffff88017b3600a0 R14: ffff8801abf630e0 R15: dead000000000100
> [  438.864943] FS:  00007f06c1a80fc0(0000) GS:ffff8801bfa80000(0000) knlGS:0000000000000000
> [  438.873793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  438.880320] CR2: 00007f06c12b0260 CR3: 000000017d3de004 CR4: 00000000000606e0
> [  438.888226] Call Trace:
> [  438.891454]  btrfs_free_block_groups+0x138/0x3d0 [btrfs]
> [  438.897569]  close_ctree+0x13b/0x2f0 [btrfs]
> [  438.902618]  generic_shutdown_super+0x6c/0x120:
> 						__read_once_size at include/linux/compiler.h:188
> 						 (inlined by) list_empty at include/linux/list.h:203
> 						 (inlined by) generic_shutdown_super at fs/super.c:442
> [  438.907801]  kill_anon_super+0xe/0x20:
> 						kill_anon_super at fs/super.c:1038
> [  438.912223]  btrfs_kill_super+0x13/0x100 [btrfs]
> [  438.917598]  deactivate_locked_super+0x3f/0x70:
> 						deactivate_locked_super at fs/super.c:320
> [  438.922757]  cleanup_mnt+0x3b/0x70:
> 						cleanup_mnt at fs/namespace.c:1174
> [  438.926879]  task_work_run+0xa3/0xe0:
> 						task_work_run at kernel/task_work.c:115 (discriminator 1)
> [  438.931205]  exit_to_usermode_loop+0x9e/0xa0:
> 						tracehook_notify_resume at include/linux/tracehook.h:191
> 						 (inlined by) exit_to_usermode_loop at arch/x86/entry/common.c:166
> [  438.936226]  do_syscall_64+0x16c/0x180:
> 						prepare_exit_to_usermode at arch/x86/entry/common.c:196
> 						 (inlined by) syscall_return_slowpath at arch/x86/entry/common.c:265
> 						 (inlined by) do_syscall_64 at arch/x86/entry/common.c:290
> [  438.940717]  entry_SYSCALL_64_after_hwframe+0x44/0xa9:
> 						entry_SYSCALL_64_after_hwframe at arch/x86/entry/entry_64.S:247
> [  438.946507] RIP: 0033:0x7f06c1359cf7
> [  438.950798] RSP: 002b:00007ffc6a59c608 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [  438.959137] RAX: 0000000000000000 RBX: 000000000234a2d0 RCX: 00007f06c1359cf7
> [  438.967056] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000000234a4b0
> [  438.974937] RBP: 000000000234a4b0 R08: 0000000000000005 R09: 000000000234b510
> [  438.982801] R10: 00000000000006f4 R11: 0000000000000246 R12: 00007f06c1865e44
> [  438.990695] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffc6a59c890
> [  438.998600] Code: 2a 48 8b 83 e8 01 00 00 48 85 c0 75 2c 48 8b bb d8 00 00 00 e8 c1 1e b8 e0 48 89 df 5b e9 b8 1e b8 e0 0f 0b 48 83 7b 50 00 74 d6 <0f> 0b 48 8b 83 e8 01 00 00 48 85 c0 74 d4 0f 0b eb d0 0f 1f 00
> [  439.019082] ---[ end trace 9263ab2c46fd437a ]---
> [  439.030057] WARNING: CPU: 2 PID: 14674 at fs/btrfs/extent-tree.c:9898 btrfs_free_block_groups+0x2a2/0x3d0 [btrfs]
> 
> Attached the full dmesg, kconfig and reproduce scripts.
> 
> Thanks,
> Fengguang
> 
