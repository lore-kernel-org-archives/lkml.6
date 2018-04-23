Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeDWJBr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:01:47 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47028 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752987AbeDWJBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:01:35 -0400
To: linux-fsdevel@vger.kernel.org
Cc: sil2review@lists.osadl.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, spruce-project@linuxtesting.org
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: System freeze and NULL pointer dereference
Openpgp: preference=signencrypt
Autocrypt: addr=khoroshilov@ispras.ru; prefer-encrypt=mutual; keydata=
 xsFNBFKH4j8BEADaBc6wgzXbMVgm8MPHJbeRgccBjuehRYN9GlXJeiFiA8IYFFe/cfxwVQDY
 vJ+5CRvkhturqOrDWRQzW7B6nrRxL/lCVqjtk7PegVQm1zIbNc8QpkBZpVDXd7G5v9dk+RvA
 qqmAqeKSpEdD2FW44Em5Oqu4PNUiWgHLpJBpJAQbH4SpzRXrvm+KI0VkgWDssa0P79/NyFon
 2zJ7/Tap3ldx2AC6TeYd1xHHgmM5VC/E18z0erScNX9R/dzxFAH6A+wv1X0Q1OxrRg1yiB/u
 UmDWbpdNhd/Cv8hqzgGnYKii0OUi5Hl8UIrSueBF6VkJomHBxWKYiUNm4HmrR0YLUhvqAVsd
 aYrlY2PPYMlMW0FxbsJm55n8KyIxB5OXUoAh2ENJrWUO1p3burXifIF7EGEMN9YnHAKM19fc
 6whJiThh9q0OgPw3aVlt9MSxDb2B3udodYRTvItEZr0Q8ZsDrgcWmE3lGXYcFPaRw7aVYdeO
 0LRKDWA+Tv/WSJPr1Hbpdmyn9PZFRVQ5K0geau5E495FRTzCXKgAwUOavvkC93c9ssIWMoyx
 qxwv8FfAmeU2nrokvrSCEMzrBZSvml4yN3Cd010JVjJ7SKRKeDLNXPkeZ7KIlNL+DFgI7esz
 aklZob57trrnBtjVR4sLfiyCWdWxEYuqMvv0EuaR1JdazYMn5QARAQABzVhBbGV4ZXkgS2hv
 cm9zaGlsb3YgKFJTQS00MDk2IGtleSBmb3Iga2hvcm9zaGlsb3ZAaXNwcmFzLnJ1IChTUykp
 IDxraG9yb3NoaWxvdkBpc3ByYXMucnU+wsF+BBMBAgAoBQJSh+I/AhsjBQkPCZwABgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRA+FwKs9pGJM4ksD/wMzYIEyeoHKFhUFDg7ZTj9ykG7
 Abkd19iVvaELYO4e0RkmtsiZ7ouP0ifu3DHEBDDkk/RhnGWPxD8qbNBCejOAH0zfduyNat4S
 sEr25HNXi58ozVRbwyROdvbWcXfCEpJsey5bdqQOq63rQR5cH+emgTif4NQ9cJmUWiN9DWN/
 /kIG+0CGtTOEO6ZIniJrv/TIpFGkHkbeLT2qynOaj2s8ALP3k+ZZAQiqHquWJNi1F9jV8CI0
 yAoaCWlVxcaGWV0QJaD/j9BsziZXCjbLW5elKyCPYrEWtvS+4CPoJDk92LPE0v9rgrZWqNY/
 9YkkY7+ka7So81Uf+KuKPLLcHGib2tul88bdxvvD32Fi+5IlXAGckRQR8gMR/2eTkPF3Vgd/
 ePtmGZenA2k63yT0fazT7lXCw8lOZGVSuLZAfkPHg+/Hg3lbxE5LGOHYMJ/5NgxP1stO6hkU
 8q8yFiMArAz0W3HAT3f9pg9JMciwBDF4AxsDU/WtLtu7ZeD+eHSJ3HRcwQTfqWkfbPo7Ovey
 P/QzYph/UwfzcUQV6wJstmZ6hop1x2SztMf27Ib8XZXsf1EIvc3qwyuiMCTDI1XQpOy3jFjd
 tX4dnc6pa+yMwc9VUghrbpWXEHW4wv9FnBQVSpF1jUiRm7XrzyqPaCUU0vzr8g/aKikFysYD
 JOepltpTT87BTQRSh+I/ARAAoyOJV+bAUIw6lTzijZWg5LlnBXCFGDbitLHSkirEN3sPBAbd
 5uOeKjSUv6/GtLNrzdn6Bjx6ajm30hebsMNbjRJ4FKz1kiMMZMPzy/yOop+Yd1eiEYk3uaeS
 xuUNV1IQrFfKutyGBbRkFp6OovNcgh8KJVgMMdgSJNtn+0ONy5H3wd0Sqoo7qHUA4p9oo2AY
 Tn1zGRG4ov4lyNtpDraAi3Chhc2HCoqLwAQtvVrYywggqV8JljBIO5JKm0ie3/cvd7+vLRC8
 1d7Fu+3RVWXUs9w/+tdycV04b10wml08srvFjOAyruWxiJ437eKB8AgHFuXxxZFusL5vbP5G
 W+a+cgBvHLc9s4yNXpegWktefD4v2RZt7HSVvu8w8BqBz2Sj0WEOFaw8EQIt1ioz2Ua4pQMW
 GwwbuD35NNhjQ8fXKoaXV9DYdQOs8Pj43/G7eXJXRJ+yBeLK2Jr3CYSG6bepx5xJyZXbzomt
 Zb0c91x7K1OLG2clTAUrGCUf8oU19qDabbF/Lwi82ml4630m4hkYRL2yi7jQX6HzDv7OXn5H
 P0UXCyx1Y3p82Saq7mJJoDPrBQGBDXllKhdFnfYBSmuobRepvpLE5HR50bJdHfuZIFH+zgVU
 7zD0glQOpBg0gUArKhMzutJb/WfB/dOdrTPIMJykFhz+E/2V+zjbYliD7XUAEQEAAcLBZQQY
 AQIADwUCUofiPwIbDAUJDwmcAAAKCRA+FwKs9pGJM8xMD/4ut0hsvUPjheBEqavEjCVhvVsR
 aojbEDhvp40Qp7zb0/Vg+0VUoLjQQq4FSaXdG72S9AyguHR0VbUZUxmlSnPInM1joE9dQqnc
 ruN1t+NzOoJTPA2yxXgNbZH8IrvG7cEffo7A1N2/KuQ2PjS5Aur9O1zX8aZGjlK4aPy1wjSO
 lSI4xEzkGYC5jMfN7oO2PzD/ibN18ya580fPBtmC3RFgkTi5V24jp2cNxU3M4KJIX5j4Jguu
 vooCjMqhhVRQNg+vKcaY11gnhGOkrfcAfyiXxzHd8IjvlPs9u/A57wUHUNlfJ7VbGMFDht5F
 cvNOz4NF70OoixpDyoK2TwH5t/Fo89Azx8HA3VrAqtZQqoKdUu8i6hT2dGZb12Qcr3iW6jRx
 nOkoZApTNXwomssj4vhtTtjnOe0EsyO8Z3RO/nTdRsMra7v2rFZBQlyyWJedA0oQRZSD+efm
 yIKgTiJlEScUZ6kLyBtTimdBSDguFnHGeCRQ6VQVp6whzyfw8UenGkAG0QzXxVlNF8EKGrE4
 Fdj1RijQyTM61YVS08ZqD3xWkY/SbwlwARL07WH+QWHUpuLSvNfd+RTn1/1+7vHwEOrhbC+c
 WPUSjG2uBL1zqJt1At2Cm8LgIjze/eN81mfZ4OtOEyTE8BiyK6ys7tIUhvcekMO7pkHxqaWd
 NoYGZfNAuA==
Message-ID: <71d196d9-ccd4-490f-1426-c10259581b0e@ispras.ru>
Date: Mon, 23 Apr 2018 12:01:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2F98B52CD204307F268FBB46"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F98B52CD204307F268FBB46
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

Syzcaller has detected a system freeze.
C reproducer and config are attached.
This trace is obtained on commit 85848b0f4074f04ab606f1e5dca296482033d54
from Linus tree. The problem was seen before on several versions from
Linus tree starting from a few commits before 4.17-rc-1.

May be induced failure is NULL pointer dereference in allocation from
getname_flags(). See log starting from:
[  451.883708] BUG: unable to handle kernel NULL pointer dereference at
00000000000000f8


[  144.369213] ata1: lost interrupt (Status 0x50)
[  144.370773] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  144.373062] ata1.00: failed command: READ DMA
[  144.374463] ata1.00: cmd c8/00:00:00:00:00/00:00:00:00:00/e0 tag 0
dma 131072 out
[  144.374463]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask
0x4 (timeout)
[  144.378903] ata1.00: status: { DRDY }
[  144.380243] ata1: soft resetting link
[  144.538671] ata1.00: configured for MWDMA2
[  144.540142] ata1: EH complete
[  205.809190] ata1: lost interrupt (Status 0x50)
[  205.810939] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  205.812959] ata1.00: failed command: READ DMA
[  205.814191] ata1.00: cmd c8/00:00:00:00:00/00:00:00:00:00/e0 tag 0
dma 131072 out
[  205.814191]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask
0x4 (timeout)
[  205.817971] ata1.00: status: { DRDY }
[  205.819199] ata1: soft resetting link
[  205.978227] ata1.00: configured for MWDMA2
[  205.979392] ata1: EH complete
[  246.752242] INFO: task kworker/u4:3:978 blocked for more than 120
seconds.
[  246.754698]       Tainted: G        W         4.17.0-rc1+ #2
[  246.756495] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  246.758798] kworker/u4:3    D25576   978      2 0x80000000
[  246.760429] Workqueue: writeback wb_workfn (flush-8:0)
[  246.761938] Call Trace:
[  246.762727]  ? __schedule+0x6a4/0x1a80
[  246.763856]  ? __sched_text_start+0x8/0x8
[  246.765066]  ? prepare_to_wait_exclusive+0x10e/0x250
[  246.766447]  schedule+0x77/0x1a0
[  246.767364]  io_schedule+0x17/0x60
[  246.768324]  bit_wait_io+0x12/0x90
[  246.769295]  __wait_on_bit_lock+0xbc/0x1c0
[  246.770423]  ? bit_wait+0x90/0x90
[  246.771360]  ? __brelse+0x74/0x90
[  246.772313]  out_of_line_wait_on_bit_lock+0xd2/0x110
[  246.773706]  ? __wait_on_bit_lock+0x1c0/0x1c0
[  246.774934]  ? init_wait_var_entry+0x1a0/0x1a0
[  246.776174]  ? jbd2_write_access_granted.part.10+0x171/0x2d0
[  246.777714]  __lock_buffer+0x47/0x50
[  246.778671]  do_get_write_access+0x794/0x1010
[  246.779812]  jbd2_journal_get_write_access+0x5e/0x90
[  246.781101]  __ext4_journal_get_write_access+0x5c/0x90
[  246.782432]  ext4_mb_mark_diskspace_used+0x19c/0xdf0
[  246.783717]  ? ext4_get_group_no_and_offset+0x13f/0x1e0
[  246.785064]  ? ext4_mb_regular_allocator+0xee0/0xee0
[  246.786356]  ? ext4_mb_use_preallocated.constprop.28+0x50/0xd90
[  246.787860]  ext4_mb_new_blocks+0xb04/0x3250
[  246.788982]  ? ext4_find_extent+0x633/0x950
[  246.790044]  ? ext4_ext_search_right+0x40a/0xab0
[  246.791172]  ? ext4_ext_next_allocated_block+0x10c/0x2b0
[  246.792452]  ext4_ext_map_blocks+0x1ad4/0x2f70
[  246.793553]  ? ext4_find_delalloc_cluster+0xb0/0xb0
[  246.794733]  ? find_get_entries_tag+0x870/0x870
[  246.795842]  ? __put_compound_page+0xb0/0xb0
[  246.796894]  ? ext4_es_lookup_extent+0x30a/0xa70
[  246.798041]  ? lock_acquire+0x10b/0x350
[  246.798947]  ? lock_acquire+0x10b/0x350
[  246.799900]  ext4_map_blocks+0xb48/0x15b0
[  246.800897]  ? ext4_issue_zeroout+0x140/0x140
[  246.801938]  ? jbd2__journal_start+0xf4/0x860
[  246.802937]  ? __ext4_journal_start_sb+0xf0/0x3e0
[  246.804014]  ? ext4_writepages+0x1310/0x30a0
[  246.804979]  ext4_writepages+0x190f/0x30a0
[  246.805928]  ? update_curr+0x26e/0x840
[  246.806800]  ? select_task_rq_fair+0x300/0x2e50
[  246.807848]  ? ext4_mark_inode_dirty+0x780/0x780
[  246.808907]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  246.810071]  ? update_curr+0x36c/0x840
[  246.810913]  ? ext4_mark_inode_dirty+0x780/0x780
[  246.811970]  ? do_writepages+0xfa/0x2b0
[  246.812868]  ? cpuacct_charge+0x266/0x410
[  246.813784]  do_writepages+0xfa/0x2b0
[  246.814594]  ? page_writeback_cpu_online+0x10/0x10
[  246.815635]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  246.816730]  ? __writeback_single_inode+0xd3/0xf30
[  246.817775]  __writeback_single_inode+0xd3/0xf30
[  246.818779]  ? sched_clock+0x5/0x10
[  246.819561]  writeback_sb_inodes+0x4a4/0xbd0
[  246.820491]  ? lock_acquire+0x10b/0x350
[  246.821346]  ? __writeback_single_inode+0xf30/0xf30
[  246.822398]  ? down_read_trylock+0x56/0xc0
[  246.823300]  ? trylock_super+0x1a/0xf0
[  246.824123]  __writeback_inodes_wb+0xf8/0x1e0
[  246.825073]  wb_writeback+0x72a/0xb60
[  246.825836]  ? writeback_inodes_wb.constprop.54+0x1b0/0x1b0
[  246.826967]  ? cpumask_next+0x1f/0x30
[  246.827736]  ? cpumask_next+0x1f/0x30
[  246.828508]  ? get_nr_dirty_inodes+0xbf/0x130
[  246.829476]  ? wb_workfn+0x526/0xe10
[  246.830264]  wb_workfn+0x526/0xe10
[  246.830949]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  246.831874]  ? inode_wait_for_writeback+0x30/0x30
[  246.832747]  ? process_one_work+0x9e8/0x1870
[  246.833556]  process_one_work+0xa95/0x1870
[  246.834362]  ? wq_update_unbound_numa+0x640/0x640
[  246.835240]  ? lock_acquire+0x10b/0x350
[  246.835926]  worker_thread+0xd3/0xf20
[  246.836617]  ? __kthread_parkme+0x16b/0x220
[  246.837480]  ? process_one_work+0x1870/0x1870
[  246.838369]  kthread+0x32d/0x3f0
[  246.838982]  ? kthread_create_worker_on_cpu+0xf0/0xf0
[  246.839952]  ret_from_fork+0x3a/0x50
[  246.840680] INFO: task jbd2/sda-8:1127 blocked for more than 120 seconds.
[  246.841965]       Tainted: G        W         4.17.0-rc1+ #2
[  246.843131] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  246.844584] jbd2/sda-8      D27568  1127      2 0x80000000
[  246.845655] Call Trace:
[  246.846165]  ? __schedule+0x6a4/0x1a80
[  246.846876]  ? __sched_text_start+0x8/0x8
[  246.847664]  ? prepare_to_wait+0x10e/0x290
[  246.848503]  ? lock_downgrade+0x5e0/0x5e0
[  246.849375]  ? bit_wait+0x90/0x90
[  246.849985]  schedule+0x77/0x1a0
[  246.850602]  io_schedule+0x17/0x60
[  246.851247]  bit_wait_io+0x12/0x90
[  246.851857]  __wait_on_bit+0x81/0x130
[  246.852542]  out_of_line_wait_on_bit+0xd2/0x110
[  246.853389]  ? __wait_on_bit+0x130/0x130
[  246.854122]  ? init_wait_var_entry+0x1a0/0x1a0
[  246.854911]  __wait_on_buffer+0x5d/0x70
[  246.855633]  jbd2_journal_commit_transaction+0x2ef0/0x5f90
[  246.856647]  ? journal_submit_commit_record+0xb30/0xb30
[  246.857614]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  246.858540]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  246.859466]  ? lock_acquire+0x10b/0x350
[  246.860185]  ? lock_acquire+0x10b/0x350
[  246.860873]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  246.861788]  ? init_timer_key+0x2c0/0x2c0
[  246.862504]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  246.863383]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  246.864271]  ? lock_acquire+0x10b/0x350
[  246.864928]  ? lock_acquire+0x10b/0x350
[  246.865623]  ? lock_timer_base+0x57/0x1a0
[  246.866335]  ? try_to_del_timer_sync+0xb0/0x100
[  246.867135]  ? _raw_spin_lock_irqsave+0x46/0x50
[  246.867898]  ? lock_timer_base+0x57/0x1a0
[  246.868608]  ? try_to_del_timer_sync+0xb0/0x100
[  246.869412]  ? detach_if_pending+0x3d0/0x3d0
[  246.870170]  ? kjournald2+0x1f0/0x7d0
[  246.870801]  kjournald2+0x1f0/0x7d0
[  246.871432]  ? jbd2_journal_init_inode+0x2a0/0x2a0
[  246.872275]  ? __sched_text_start+0x8/0x8
[  246.872956]  ? wait_woken+0x260/0x260
[  246.873615]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  246.874447]  ? jbd2_journal_init_inode+0x2a0/0x2a0
[  246.875246]  kthread+0x32d/0x3f0
[  246.875781]  ? kthread_create_worker_on_cpu+0xf0/0xf0
[  246.876631]  ret_from_fork+0x3a/0x50
[  246.877264] INFO: task bash:2661 blocked for more than 120 seconds.
[  246.878334]       Tainted: G        W         4.17.0-rc1+ #2
[  246.879292] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  246.880570] bash            D26672  2661   2659 0x00000000
[  246.881508] Call Trace:
[  246.881926]  ? __schedule+0x6a4/0x1a80
[  246.882576]  ? __sched_text_start+0x8/0x8
[  246.883263]  ? prepare_to_wait_exclusive+0x10e/0x250
[  246.884105]  schedule+0x77/0x1a0
[  246.884642]  io_schedule+0x17/0x60
[  246.885249]  bit_wait_io+0x12/0x90
[  246.885788]  __wait_on_bit_lock+0xbc/0x1c0
[  246.886459]  ? bit_wait+0x90/0x90
[  246.886986]  ? do_raw_spin_unlock+0x4f/0x240
[  246.887685]  out_of_line_wait_on_bit_lock+0xd2/0x110
[  246.888486]  ? __wait_on_bit_lock+0x1c0/0x1c0
[  246.889242]  ? init_wait_var_entry+0x1a0/0x1a0
[  246.889936]  ? jbd2_write_access_granted.part.10+0x171/0x2d0
[  246.890832]  __lock_buffer+0x47/0x50
[  246.891418]  do_get_write_access+0x794/0x1010
[  246.892131]  jbd2_journal_get_write_access+0x5e/0x90
[  246.892899]  __ext4_journal_get_write_access+0x5c/0x90
[  246.893737]  ext4_reserve_inode_write+0x164/0x220
[  246.894505]  ext4_mark_inode_dirty+0x132/0x780
[  246.895229]  ? ext4_dirty_inode+0x6a/0x90
[  246.895863]  ? ext4_expand_extra_isize+0x4d0/0x4d0
[  246.896641]  ? jbd2__journal_start+0x144/0x860
[  246.897375]  ? jbd2__journal_start+0xf4/0x860
[  246.898059]  ? __ext4_journal_start_sb+0xf0/0x3e0
[  246.898762]  ? ext4_dirty_inode+0x4f/0x90
[  246.899396]  ? ext4_setattr+0x2090/0x2090
[  246.900077]  ext4_dirty_inode+0x6a/0x90
[  246.900696]  __mark_inode_dirty+0x88a/0xfa0
[  246.901366]  ? dentry_needs_remove_privs.part.19+0x50/0x50
[  246.902212]  generic_update_time+0x1b6/0x2e0
[  246.902859]  ? dentry_needs_remove_privs.part.19+0x50/0x50
[  246.903745]  touch_atime+0x215/0x280
[  246.904319]  ? __atime_needs_update+0x900/0x900
[  246.905061]  ? fsnotify_first_mark+0x180/0x180
[  246.905741]  iterate_dir+0x435/0x520
[  246.906313]  __x64_sys_getdents+0x1bc/0x310
[  246.906948]  ? __ia32_sys_getdents+0x300/0x300
[  246.907645]  ? __do_page_fault+0x391/0xb60
[  246.908289]  ? __x64_sys_getdents+0x310/0x310
[  246.908972]  ? mm_fault_error+0x2b0/0x2b0
[  246.909612]  ? do_syscall_64+0x9f/0x470
[  246.910190]  do_syscall_64+0x9f/0x470
[  246.910721]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  246.911466] RIP: 0033:0x7f003f310575
[  246.911979] RSP: 002b:00007fff5541a660 EFLAGS: 00000246 ORIG_RAX:
000000000000004e
[  246.913125] RAX: ffffffffffffffda RBX: 00000000009c0008 RCX:
00007f003f310575
[  246.914175] RDX: 0000000000008000 RSI: 00000000009c0038 RDI:
0000000000000003
[  246.915213] RBP: ffffffffffffffa8 R08: 00000000009c0038 R09:
0000000000200000
[  246.916239] R10: 0000000000000008 R11: 0000000000000246 R12:
0000000000000000
[  246.917271] R13: 00000000009c0038 R14: 000000000098f608 R15:
00000000009861f8
[  246.918321] INFO: lockdep is turned off.
[  267.249199] ata1: lost interrupt (Status 0x50)
[  267.250888] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  267.252927] ata1.00: failed command: READ DMA
[  267.254274] ata1.00: cmd c8/00:00:00:00:00/00:00:00:00:00/e0 tag 0
dma 131072 out
[  267.254274]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask
0x4 (timeout)
[  267.258374] ata1.00: status: { DRDY }
[  267.259637] ata1: soft resetting link
[  267.418691] ata1.00: configured for MWDMA2
[  267.420153] ata1: EH complete
[  328.689200] ata1: lost interrupt (Status 0x50)
[  328.690997] ata1.00: limiting speed to MWDMA1:PIO4
[  328.692602] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  328.694831] ata1.00: failed command: READ DMA
[  328.696237] ata1.00: cmd c8/00:00:00:00:00/00:00:00:00:00/e0 tag 0
dma 131072 out
[  328.696237]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask
0x4 (timeout)
[  328.700688] ata1.00: status: { DRDY }
[  328.702112] ata1: soft resetting link
[  328.858518] ata1.00: configured for MWDMA1
[  328.859946] ata1: EH complete
[  369.632247] INFO: task kworker/u4:3:978 blocked for more than 120
seconds.
[  369.634329]       Tainted: G        W         4.17.0-rc1+ #2
[  369.636077] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.638447] kworker/u4:3    D25576   978      2 0x80000000
[  369.640237] Workqueue: writeback wb_workfn (flush-8:0)
[  369.641857] Call Trace:
[  369.642715]  ? __schedule+0x6a4/0x1a80
[  369.643939]  ? __sched_text_start+0x8/0x8
[  369.645229]  ? prepare_to_wait_exclusive+0x10e/0x250
[  369.646787]  schedule+0x77/0x1a0
[  369.647852]  io_schedule+0x17/0x60
[  369.648876]  bit_wait_io+0x12/0x90
[  369.649910]  __wait_on_bit_lock+0xbc/0x1c0
[  369.651130]  ? bit_wait+0x90/0x90
[  369.652135]  ? __brelse+0x74/0x90
[  369.653133]  out_of_line_wait_on_bit_lock+0xd2/0x110
[  369.654577]  ? __wait_on_bit_lock+0x1c0/0x1c0
[  369.655869]  ? init_wait_var_entry+0x1a0/0x1a0
[  369.657176]  ? jbd2_write_access_granted.part.10+0x171/0x2d0
[  369.658806]  __lock_buffer+0x47/0x50
[  369.659858]  do_get_write_access+0x794/0x1010
[  369.661072]  jbd2_journal_get_write_access+0x5e/0x90
[  369.662419]  __ext4_journal_get_write_access+0x5c/0x90
[  369.663827]  ext4_mb_mark_diskspace_used+0x19c/0xdf0
[  369.665188]  ? ext4_get_group_no_and_offset+0x13f/0x1e0
[  369.666598]  ? ext4_mb_regular_allocator+0xee0/0xee0
[  369.667907]  ? ext4_mb_use_preallocated.constprop.28+0x50/0xd90
[  369.669381]  ext4_mb_new_blocks+0xb04/0x3250
[  369.670474]  ? ext4_find_extent+0x633/0x950
[  369.671560]  ? ext4_ext_search_right+0x40a/0xab0
[  369.672736]  ? ext4_ext_next_allocated_block+0x10c/0x2b0
[  369.674070]  ext4_ext_map_blocks+0x1ad4/0x2f70
[  369.675218]  ? ext4_find_delalloc_cluster+0xb0/0xb0
[  369.676481]  ? find_get_entries_tag+0x870/0x870
[  369.677659]  ? __put_compound_page+0xb0/0xb0
[  369.678771]  ? ext4_es_lookup_extent+0x30a/0xa70
[  369.679943]  ? lock_acquire+0x10b/0x350
[  369.680886]  ? lock_acquire+0x10b/0x350
[  369.681841]  ext4_map_blocks+0xb48/0x15b0
[  369.682841]  ? ext4_issue_zeroout+0x140/0x140
[  369.683909]  ? jbd2__journal_start+0xf4/0x860
[  369.684963]  ? __ext4_journal_start_sb+0xf0/0x3e0
[  369.686095]  ? ext4_writepages+0x1310/0x30a0
[  369.687140]  ext4_writepages+0x190f/0x30a0
[  369.688139]  ? update_curr+0x26e/0x840
[  369.689058]  ? select_task_rq_fair+0x300/0x2e50
[  369.690161]  ? ext4_mark_inode_dirty+0x780/0x780
[  369.691288]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.692428]  ? update_curr+0x36c/0x840
[  369.693291]  ? ext4_mark_inode_dirty+0x780/0x780
[  369.694336]  ? do_writepages+0xfa/0x2b0
[  369.695236]  ? cpuacct_charge+0x266/0x410
[  369.696165]  do_writepages+0xfa/0x2b0
[  369.696987]  ? page_writeback_cpu_online+0x10/0x10
[  369.698074]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.699227]  ? __writeback_single_inode+0xd3/0xf30
[  369.700313]  __writeback_single_inode+0xd3/0xf30
[  369.701371]  ? sched_clock+0x5/0x10
[  369.702190]  writeback_sb_inodes+0x4a4/0xbd0
[  369.703187]  ? lock_acquire+0x10b/0x350
[  369.703981]  ? __writeback_single_inode+0xf30/0xf30
[  369.705029]  ? down_read_trylock+0x56/0xc0
[  369.705881]  ? trylock_super+0x1a/0xf0
[  369.706702]  __writeback_inodes_wb+0xf8/0x1e0
[  369.707652]  wb_writeback+0x72a/0xb60
[  369.708464]  ? writeback_inodes_wb.constprop.54+0x1b0/0x1b0
[  369.709644]  ? cpumask_next+0x1f/0x30
[  369.710447]  ? cpumask_next+0x1f/0x30
[  369.711257]  ? get_nr_dirty_inodes+0xbf/0x130
[  369.712194]  ? wb_workfn+0x526/0xe10
[  369.712939]  wb_workfn+0x526/0xe10
[  369.713705]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.714775]  ? inode_wait_for_writeback+0x30/0x30
[  369.715772]  ? process_one_work+0x9e8/0x1870
[  369.716655]  process_one_work+0xa95/0x1870
[  369.717510]  ? wq_update_unbound_numa+0x640/0x640
[  369.718469]  ? lock_acquire+0x10b/0x350
[  369.719280]  worker_thread+0xd3/0xf20
[  369.720048]  ? __kthread_parkme+0x16b/0x220
[  369.720869]  ? process_one_work+0x1870/0x1870
[  369.721759]  kthread+0x32d/0x3f0
[  369.722443]  ? kthread_create_worker_on_cpu+0xf0/0xf0
[  369.723474]  ret_from_fork+0x3a/0x50
[  369.724225] INFO: task jbd2/sda-8:1127 blocked for more than 120 seconds.
[  369.725565]       Tainted: G        W         4.17.0-rc1+ #2
[  369.726697] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.728187] jbd2/sda-8      D27568  1127      2 0x80000000
[  369.729236] Call Trace:
[  369.729708]  ? __schedule+0x6a4/0x1a80
[  369.730449]  ? __sched_text_start+0x8/0x8
[  369.731257]  ? prepare_to_wait+0x10e/0x290
[  369.732057]  ? lock_downgrade+0x5e0/0x5e0
[  369.732798]  ? bit_wait+0x90/0x90
[  369.733456]  schedule+0x77/0x1a0
[  369.734099]  io_schedule+0x17/0x60
[  369.734744]  bit_wait_io+0x12/0x90
[  369.735426]  __wait_on_bit+0x81/0x130
[  369.736152]  out_of_line_wait_on_bit+0xd2/0x110
[  369.737000]  ? __wait_on_bit+0x130/0x130
[  369.737769]  ? init_wait_var_entry+0x1a0/0x1a0
[  369.738627]  __wait_on_buffer+0x5d/0x70
[  369.739387]  jbd2_journal_commit_transaction+0x2ef0/0x5f90
[  369.740396]  ? journal_submit_commit_record+0xb30/0xb30
[  369.741357]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.742282]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.743216]  ? lock_acquire+0x10b/0x350
[  369.743905]  ? lock_acquire+0x10b/0x350
[  369.744621]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.745548]  ? init_timer_key+0x2c0/0x2c0
[  369.746298]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.747229]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.748155]  ? lock_acquire+0x10b/0x350
[  369.748836]  ? lock_acquire+0x10b/0x350
[  369.749558]  ? lock_timer_base+0x57/0x1a0
[  369.750299]  ? try_to_del_timer_sync+0xb0/0x100
[  369.751144]  ? _raw_spin_lock_irqsave+0x46/0x50
[  369.751910]  ? lock_timer_base+0x57/0x1a0
[  369.752622]  ? try_to_del_timer_sync+0xb0/0x100
[  369.753415]  ? detach_if_pending+0x3d0/0x3d0
[  369.754172]  ? kjournald2+0x1f0/0x7d0
[  369.754793]  kjournald2+0x1f0/0x7d0
[  369.755431]  ? jbd2_journal_init_inode+0x2a0/0x2a0
[  369.756266]  ? __sched_text_start+0x8/0x8
[  369.756945]  ? wait_woken+0x260/0x260
[  369.757597]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  369.758464]  ? jbd2_journal_init_inode+0x2a0/0x2a0
[  369.759305]  kthread+0x32d/0x3f0
[  369.759864]  ? kthread_create_worker_on_cpu+0xf0/0xf0
[  369.760754]  ret_from_fork+0x3a/0x50
[  369.761409] INFO: task rs:main Q:Reg:2544 blocked for more than 120
seconds.
[  369.762607]       Tainted: G        W         4.17.0-rc1+ #2
[  369.763582] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.764857] rs:main Q:Reg   D27088  2544      1 0x00000000
[  369.765768] Call Trace:
[  369.766214]  ? __schedule+0x6a4/0x1a80
[  369.766831]  ? __sched_text_start+0x8/0x8
[  369.767517]  ? prepare_to_wait_exclusive+0x10e/0x250
[  369.768348]  schedule+0x77/0x1a0
[  369.768877]  io_schedule+0x17/0x60
[  369.769460]  bit_wait_io+0x12/0x90
[  369.770047]  __wait_on_bit_lock+0xbc/0x1c0
[  369.770708]  ? bit_wait+0x90/0x90
[  369.771289]  ? do_raw_spin_unlock+0x4f/0x240
[  369.771981]  out_of_line_wait_on_bit_lock+0xd2/0x110
[  369.772805]  ? __wait_on_bit_lock+0x1c0/0x1c0
[  369.773541]  ? init_wait_var_entry+0x1a0/0x1a0
[  369.774295]  ? jbd2_write_access_granted.part.10+0x171/0x2d0
[  369.775244]  __lock_buffer+0x47/0x50
[  369.775802]  do_get_write_access+0x794/0x1010
[  369.776506]  jbd2_journal_get_write_access+0x5e/0x90
[  369.777305]  __ext4_journal_get_write_access+0x5c/0x90
[  369.778129]  ext4_reserve_inode_write+0x164/0x220
[  369.778857]  ext4_mark_inode_dirty+0x132/0x780
[  369.779581]  ? ext4_dirty_inode+0x6a/0x90
[  369.780233]  ? ext4_expand_extra_isize+0x4d0/0x4d0
[  369.780968]  ? jbd2__journal_start+0x144/0x860
[  369.781684]  ? jbd2__journal_start+0xf4/0x860
[  369.782387]  ? __ext4_journal_start_sb+0xf0/0x3e0
[  369.783149]  ? ext4_dirty_inode+0x4f/0x90
[  369.783780]  ? ext4_setattr+0x2090/0x2090
[  369.784439]  ext4_dirty_inode+0x6a/0x90
[  369.785071]  __mark_inode_dirty+0x88a/0xfa0
[  369.785730]  ? dentry_needs_remove_privs.part.19+0x50/0x50
[  369.786609]  generic_update_time+0x1b6/0x2e0
[  369.787315]  ? dentry_needs_remove_privs.part.19+0x50/0x50
[  369.788154]  file_update_time+0x2aa/0x460
[  369.788759]  ? current_time+0xc0/0xc0
[  369.789336]  ? lock_acquire+0x10b/0x350
[  369.789910]  ? lock_acquire+0x10b/0x350
[  369.790515]  __generic_file_write_iter+0x1bc/0x540
[  369.791271]  ? generic_write_checks+0x253/0x410
[  369.791942]  ext4_file_write_iter+0x503/0xda0
[  369.792620]  ? ext4_file_mmap+0x1e0/0x1e0
[  369.793247]  ? vfs_write+0x3eb/0x4e0
[  369.793781]  ? debug_check_no_locks_freed+0x2c0/0x2c0
[  369.794553]  ? lock_acquire+0x10b/0x350
[  369.795162]  ? __fdget_pos+0xb3/0xe0
[  369.795701]  __vfs_write+0x4b6/0x620
[  369.796262]  ? kernel_read+0x110/0x110
[  369.796821]  ? finish_task_switch+0x11d/0x560
[  369.797493]  ? mutex_lock_io_nested+0x1100/0x1100
[  369.798212]  ? __fget+0x237/0x3c0
[  369.798715]  ? lock_acquire+0x10b/0x350
[  369.799319]  ? lock_acquire+0x10b/0x350
[  369.799870]  ? vfs_write+0x3eb/0x4e0
[  369.800412]  ? rcu_sync_lockdep_assert+0x9/0xa0
[  369.801084]  vfs_write+0x17f/0x4e0
[  369.801581]  ksys_write+0xc1/0x190
[  369.802097]  ? __ia32_sys_read+0xb0/0xb0
[  369.802665]  do_syscall_64+0x9f/0x470
[  369.803226]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  369.803953] RIP: 0033:0x7f88345b619d
[  369.804495] RSP: 002b:00007f8832b57000 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[  369.805585] RAX: ffffffffffffffda RBX: 000000000000029c RCX:
00007f88345b619d
[  369.806610] RDX: 000000000000029c RSI: 0000000000d25a90 RDI:
0000000000000001
[  369.807642] RBP: 0000000000d25a90 R08: 5d3334323038332e R09:
73203a3161746120
[  369.808670] R10: 0000000000000000 R11: 0000000000000293 R12:
0000000000000000
[  369.809698] R13: 00007f8832b57480 R14: 0000000000000007 R15:
0000000000d25870
[  369.810741] INFO: task bash:2661 blocked for more than 120 seconds.
[  369.811646]       Tainted: G        W         4.17.0-rc1+ #2
[  369.812438] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.813511] bash            D26672  2661   2659 0x00000000
[  369.814288] Call Trace:
[  369.814638]  ? __schedule+0x6a4/0x1a80
[  369.815190]  ? __sched_text_start+0x8/0x8
[  369.815746]  ? prepare_to_wait_exclusive+0x10e/0x250
[  369.816448]  schedule+0x77/0x1a0
[  369.816901]  io_schedule+0x17/0x60
[  369.817401]  bit_wait_io+0x12/0x90
[  369.817875]  __wait_on_bit_lock+0xbc/0x1c0
[  369.818464]  ? bit_wait+0x90/0x90
[  369.818924]  ? do_raw_spin_unlock+0x4f/0x240
[  369.819543]  out_of_line_wait_on_bit_lock+0xd2/0x110
[  369.820247]  ? __wait_on_bit_lock+0x1c0/0x1c0
[  369.820847]  ? init_wait_var_entry+0x1a0/0x1a0
[  369.821483]  ? jbd2_write_access_granted.part.10+0x171/0x2d0
[  369.822273]  __lock_buffer+0x47/0x50
[  369.822771]  do_get_write_access+0x794/0x1010
[  369.823404]  jbd2_journal_get_write_access+0x5e/0x90
[  369.824089]  __ext4_journal_get_write_access+0x5c/0x90
[  369.824768]  ext4_reserve_inode_write+0x164/0x220
[  369.825420]  ext4_mark_inode_dirty+0x132/0x780
[  369.826037]  ? ext4_dirty_inode+0x6a/0x90
[  369.826575]  ? ext4_expand_extra_isize+0x4d0/0x4d0
[  369.827243]  ? jbd2__journal_start+0x144/0x860
[  369.827836]  ? jbd2__journal_start+0xf4/0x860
[  369.828438]  ? __ext4_journal_start_sb+0xf0/0x3e0
[  369.829085]  ? ext4_dirty_inode+0x4f/0x90
[  369.829626]  ? ext4_setattr+0x2090/0x2090
[  369.830187]  ext4_dirty_inode+0x6a/0x90
[  369.830702]  __mark_inode_dirty+0x88a/0xfa0
[  369.831294]  ? dentry_needs_remove_privs.part.19+0x50/0x50
[  369.832045]  generic_update_time+0x1b6/0x2e0
[  369.832613]  ? dentry_needs_remove_privs.part.19+0x50/0x50
[  369.833363]  touch_atime+0x215/0x280
[  369.833848]  ? __atime_needs_update+0x900/0x900
[  369.834475]  ? fsnotify_first_mark+0x180/0x180
[  369.835101]  iterate_dir+0x435/0x520
[  369.835583]  __x64_sys_getdents+0x1bc/0x310
[  369.836165]  ? __ia32_sys_getdents+0x300/0x300
[  369.836759]  ? __do_page_fault+0x391/0xb60
[  369.837329]  ? __x64_sys_getdents+0x310/0x310
[  369.837907]  ? mm_fault_error+0x2b0/0x2b0
[  369.838467]  ? do_syscall_64+0x9f/0x470
[  369.838979]  do_syscall_64+0x9f/0x470
[  369.839500]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  369.840191] RIP: 0033:0x7f003f310575
[  369.840668] RSP: 002b:00007fff5541a660 EFLAGS: 00000246 ORIG_RAX:
000000000000004e
[  369.841678] RAX: ffffffffffffffda RBX: 00000000009c0008 RCX:
00007f003f310575
[  369.842634] RDX: 0000000000008000 RSI: 00000000009c0038 RDI:
0000000000000003
[  369.843592] RBP: ffffffffffffffa8 R08: 00000000009c0038 R09:
0000000000200000
[  369.844536] R10: 0000000000000008 R11: 0000000000000246 R12:
0000000000000000
[  369.845479] R13: 00000000009c0038 R14: 000000000098f608 R15:
00000000009861f8
[  369.846437] INFO: lockdep is turned off.
[  390.129207] ata1: lost interrupt (Status 0x50)
[  390.131076] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  390.133305] ata1.00: failed command: READ DMA
[  390.134738] ata1.00: cmd c8/00:00:00:00:00/00:00:00:00:00/e0 tag 0
dma 131072 out
[  390.134738]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask
0x4 (timeout)
[  390.139136] ata1.00: status: { DRDY }
[  390.140540] ata1: soft resetting link
[  390.298828] ata1.00: configured for MWDMA1
[  390.300475] ata1: EH complete
[  451.569310] ata1: lost interrupt (Status 0x50)
[  451.570954] ata1.00: limiting speed to PIO4
[  451.572303] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  451.574418] ata1.00: failed command: READ DMA
[  451.575767] ata1.00: cmd c8/00:00:00:00:00/00:00:00:00:00/e0 tag 0
dma 131072 out
[  451.575767]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask
0x4 (timeout)
[  451.579606] ata1.00: status: { DRDY }
[  451.580807] ata1: soft resetting link
[  451.738673] ata1.00: configured for PIO4
[  451.740648] ata1: EH complete
[  451.883708] BUG: unable to handle kernel NULL pointer dereference at
00000000000000f8
[  451.885307] PGD 800000006c10b067 P4D 800000006c10b067 PUD 6c27a067 PMD 0
[  451.886598] Oops: 0000 [#1] SMP KASAN PTI
[  451.887377] Modules linked in:
[  451.887977] CPU: 1 PID: 2661 Comm: bash Tainted: G        W
4.17.0-rc1+ #2
[  451.889400] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  451.891179] RIP: 0010:qlist_free_all+0x32/0xc0
[  451.892023] RSP: 0018:ffff88006ba97c18 EFLAGS: 00010246
[  451.893024] RAX: fffff9e02c000a00 RBX: 0000000000000000 RCX:
ffffffffffffffff
[  451.894346] RDX: 0000000000000000 RSI: 0003800b0002800b RDI:
0000000000000000
[  451.895667] RBP: 0003800b0002800b R08: ffff880066d2c008 R09:
00000001000f000d
[  451.896968] R10: ffff88006ba97b50 R11: ffff88006cd4dc00 R12:
ffff88006ba97c50
[  451.898228] R13: ffffffffb938a2f2 R14: 0000000080000000 R15:
ffffffff80000000
[  451.899494] FS:  00007f003fc37700(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[  451.900922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  451.901942] CR2: 00000000000000f8 CR3: 0000000069a5c000 CR4:
00000000000006e0
[  451.903207] Call Trace:
[  451.903672]  ? getname_flags+0xc5/0x560
[  451.904385]  quarantine_reduce+0x166/0x1a0
[  451.905127]  kasan_kmalloc+0xc4/0xd0
[  451.905781]  ? getname_flags+0xc5/0x560
[  451.906484]  kmem_cache_alloc+0xd2/0x280
[  451.907196]  getname_flags+0xc5/0x560
[  451.907873]  ? lock_downgrade+0x5e0/0x5e0
[  451.908608]  user_path_at_empty+0x27/0x50
[  451.909335]  vfs_statx+0xe1/0x180
[  451.909943]  ? vfs_statx_fd+0x80/0x80
[  451.910615]  ? sigprocmask+0xe4/0x260
[  451.911284]  ? __x64_sys_rt_sigsuspend+0x130/0x130
[  451.912142]  __do_sys_newstat+0x81/0x100
[  451.912858]  ? cp_new_stat+0x5a0/0x5a0
[  451.913536]  ? __x64_sys_rt_sigprocmask+0x1be/0x250
[  451.914407]  ? __ia32_compat_sys_rt_sigprocmask+0x270/0x270
[  451.915401]  ? do_raw_spin_unlock+0x4f/0x240
[  451.916185]  ? _raw_spin_unlock_irq+0x24/0x40
[  451.916956]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  451.917762]  do_syscall_64+0x9f/0x470
[  451.918395]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  451.919255] RIP: 0033:0x7f003f337c65
[  451.919872] RSP: 002b:00007fff5541a4b8 EFLAGS: 00000246 ORIG_RAX:
0000000000000004
[  451.921154] RAX: ffffffffffffffda RBX: 000000000098c988 RCX:
00007f003f337c65
[  451.922348] RDX: 00007fff5541a4c0 RSI: 00007fff5541a4c0 RDI:
000000000098c988
[  451.923545] RBP: 000000000000002f R08: 000000000098c989 R09:
ff04ff2e6d68612e
[  451.924746] R10: 0000000000000008 R11: 0000000000000246 R12:
000000000098c989
[  451.925943] R13: 000000000098c98c R14: 000000000098c98c R15:
0000000000000002
[  451.927148] Code: 54 55 53 48 89 f3 48 8b 37 48 85 f6 0f 84 91 00 00
00 49 89 fc 49 c7 c5 f2 a2 38 b9 41 be 00 00 00 80 49 c7 c7 00 00 00 80
eb 1d <48> 63 87 f8 00 00 00 48 8b 2e 4c 89 ea 48 29 c6 e8 89 ca ff ff
[  451.930322] RIP: qlist_free_all+0x32/0xc0 RSP: ffff88006ba97c18
[  451.931274] CR2: 00000000000000f8
[  451.931875] ---[ end trace ebbb0bc718ce3e5d ]---
[  856.037070] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [sshd:2613]
[  856.037948] Modules linked in:
[  856.038345] irq event stamp: 0
[  856.038753] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[  856.039699] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[  856.040828] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[  856.041949] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[  856.042895] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W
4.17.0-rc1+ #2
[  856.043850] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  856.045043] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[  856.045746] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[  856.046712] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[  856.047615] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[  856.048517] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[  856.049422] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[  856.050326] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[  856.051232] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[  856.052256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  856.052988] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[  856.053894] Call Trace:
[  856.054227]  do_raw_spin_lock+0x15b/0x1e0
[  856.054755]  copy_page_range+0x977/0x1a70
[  856.055285]  ? lock_downgrade+0x5e0/0x5e0
[  856.055804]  ? vm_iomap_memory+0x150/0x150
[  856.056333]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  856.056949]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  856.057565]  copy_process.part.50+0x5be4/0x6120
[  856.058160]  ? __cleanup_sighand+0x40/0x40
[  856.058696]  ? lock_downgrade+0x5e0/0x5e0
[  856.059219]  ? get_unused_fd_flags+0xc0/0xc0
[  856.059776]  _do_fork+0x1c1/0xd20
[  856.060212]  ? fork_idle+0x2d0/0x2d0
[  856.060677]  ? __do_pipe_flags+0x230/0x230
[  856.061212]  ? signal_fault+0x2b0/0x2b0
[  856.061715]  do_syscall_64+0x9f/0x470
[  856.062195]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  856.062851] RIP: 0033:0x7f531b98bf46
[  856.063314] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[  856.064271] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[  856.065176] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[  856.066077] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[  856.066985] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[  856.067891] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[  856.068796] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00
[  884.037028] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [sshd:2613]
[  884.037907] Modules linked in:
[  884.038305] irq event stamp: 0
[  884.038705] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[  884.039653] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[  884.040782] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[  884.041907] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[  884.042844] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[  884.043804] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  884.044999] RIP: 0010:check_memory_region+0x16/0x190
[  884.045630] RSP: 0018:ffff8800661979f8 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  884.046583] RAX: ffff7fffffffffff RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[  884.047487] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[  884.048387] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[  884.049287] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[  884.050186] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[  884.051088] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[  884.052106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  884.052833] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[  884.053734] Call Trace:
[  884.054063]  queued_spin_lock_slowpath+0x48/0x690
[  884.054668]  do_raw_spin_lock+0x15b/0x1e0
[  884.055190]  copy_page_range+0x977/0x1a70
[  884.055718]  ? lock_downgrade+0x5e0/0x5e0
[  884.056235]  ? vm_iomap_memory+0x150/0x150
[  884.056762]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  884.057374]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  884.057989]  copy_process.part.50+0x5be4/0x6120
[  884.058580]  ? __cleanup_sighand+0x40/0x40
[  884.059115]  ? lock_downgrade+0x5e0/0x5e0
[  884.059635]  ? get_unused_fd_flags+0xc0/0xc0
[  884.060190]  _do_fork+0x1c1/0xd20
[  884.060624]  ? fork_idle+0x2d0/0x2d0
[  884.061088]  ? __do_pipe_flags+0x230/0x230
[  884.061619]  ? signal_fault+0x2b0/0x2b0
[  884.062122]  do_syscall_64+0x9f/0x470
[  884.062599]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  884.063252] RIP: 0033:0x7f531b98bf46
[  884.063710] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[  884.064660] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[  884.065558] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[  884.066454] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[  884.067355] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[  884.068249] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[  884.069148] Code: 0f b6 14 16 84 d2 74 d7 83 e0 07 38 c2 40 0f 9e c6
eb c7 66 90 48 85 f6 0f 84 7c 01 00 00 48 b8 ff ff ff ff ff 7f ff ff 0f
b6 d2 <48> 39 c7 0f 86 13 01 00 00 4c 8d 5c 37 ff 49 b8 00 00 00 00 00
[  912.037031] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [sshd:2613]
[  912.037930] Modules linked in:
[  912.038339] irq event stamp: 0
[  912.038756] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[  912.039727] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[  912.040884] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[  912.042039] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[  912.042995] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[  912.043972] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  912.045189] RIP: 0010:check_memory_region+0x16/0x190
[  912.045836] RSP: 0018:ffff8800661979f8 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  912.046816] RAX: ffff7fffffffffff RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[  912.047738] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[  912.048651] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[  912.049561] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[  912.050471] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[  912.051386] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[  912.052421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  912.053161] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[  912.054079] Call Trace:
[  912.054416]  queued_spin_lock_slowpath+0x48/0x690
[  912.055061]  do_raw_spin_lock+0x15b/0x1e0
[  912.055598]  copy_page_range+0x977/0x1a70
[  912.056134]  ? lock_downgrade+0x5e0/0x5e0
[  912.056662]  ? vm_iomap_memory+0x150/0x150
[  912.057198]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  912.057826]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  912.058452]  copy_process.part.50+0x5be4/0x6120
[  912.059055]  ? __cleanup_sighand+0x40/0x40
[  912.059599]  ? lock_downgrade+0x5e0/0x5e0
[  912.060131]  ? get_unused_fd_flags+0xc0/0xc0
[  912.060695]  _do_fork+0x1c1/0xd20
[  912.061137]  ? fork_idle+0x2d0/0x2d0
[  912.061608]  ? __do_pipe_flags+0x230/0x230
[  912.062150]  ? signal_fault+0x2b0/0x2b0
[  912.062660]  do_syscall_64+0x9f/0x470
[  912.063146]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  912.063812] RIP: 0033:0x7f531b98bf46
[  912.064282] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[  912.065257] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[  912.066177] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[  912.067092] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[  912.068016] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[  912.068935] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[  912.069856] Code: 0f b6 14 16 84 d2 74 d7 83 e0 07 38 c2 40 0f 9e c6
eb c7 66 90 48 85 f6 0f 84 7c 01 00 00 48 b8 ff ff ff ff ff 7f ff ff 0f
b6 d2 <48> 39 c7 0f 86 13 01 00 00 4c 8d 5c 37 ff 49 b8 00 00 00 00 00
[  932.076026] INFO: rcu_sched self-detected stall on CPU
[  932.076717] 	1-....: (1 GPs behind) idle=4de/1/4611686018427387906
softirq=5324/5394 fqs=18968
[  932.077816] 	 (t=76000 jiffies g=2337 c=2336 q=9)
[  932.078433] NMI backtrace for cpu 1
[  932.078894] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[  932.079862] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  932.081056] Call Trace:
[  932.081387]  <IRQ>
[  932.081667]  dump_stack+0xca/0x13e
[  932.082125]  ? lapic_can_unplug_cpu+0x90/0x90
[  932.082690]  nmi_cpu_backtrace+0x153/0x170
[  932.083224]  ? lapic_can_unplug_cpu+0x90/0x90
[  932.083793]  nmi_trigger_cpumask_backtrace+0x117/0x170
[  932.084457]  rcu_dump_cpu_stacks+0x186/0x1d4
[  932.085014]  rcu_check_callbacks+0x1a2b/0x1d10
[  932.085594]  ? cpuacct_account_field+0x153/0x2d0
[  932.086192]  update_process_times+0x28/0x60
[  932.086736]  tick_sched_handle+0x79/0x150
[  932.087265]  tick_sched_timer+0x40/0x110
[  932.087781]  __hrtimer_run_queues+0x2d6/0xb90
[  932.088346]  ? tick_sched_do_timer+0x150/0x150
[  932.088919]  ? hrtimer_cancel+0x40/0x40
[  932.089421]  ? kvm_clock_get_cycles+0x21/0x30
[  932.089987]  ? ktime_get_update_offsets_now+0x1d5/0x2c0
[  932.090658]  hrtimer_interrupt+0x24e/0x620
[  932.091195]  smp_apic_timer_interrupt+0xc4/0x4b0
[  932.091802]  apic_timer_interrupt+0xf/0x20
[  932.092333]  </IRQ>
[  932.092618] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[  932.093316] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[  932.094272] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[  932.095172] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[  932.096075] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[  932.096975] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[  932.097878] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[  932.098787]  ? queued_spin_lock_slowpath+0x48/0x690
[  932.099419]  do_raw_spin_lock+0x15b/0x1e0
[  932.099949]  copy_page_range+0x977/0x1a70
[  932.100479]  ? lock_downgrade+0x5e0/0x5e0
[  932.101002]  ? vm_iomap_memory+0x150/0x150
[  932.101536]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  932.102155]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  932.102778]  copy_process.part.50+0x5be4/0x6120
[  932.103370]  ? __cleanup_sighand+0x40/0x40
[  932.103909]  ? lock_downgrade+0x5e0/0x5e0
[  932.104431]  ? get_unused_fd_flags+0xc0/0xc0
[  932.104989]  _do_fork+0x1c1/0xd20
[  932.105425]  ? fork_idle+0x2d0/0x2d0
[  932.105892]  ? __do_pipe_flags+0x230/0x230
[  932.106426]  ? signal_fault+0x2b0/0x2b0
[  932.106928]  do_syscall_64+0x9f/0x470
[  932.107404]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  932.108058] RIP: 0033:0x7f531b98bf46
[  932.108524] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[  932.109484] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[  932.110385] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[  932.111284] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[  932.112190] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[  932.113093] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[  960.037020] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [sshd:2613]
[  960.037919] Modules linked in:
[  960.038324] irq event stamp: 0
[  960.038732] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[  960.039692] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[  960.040847] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[  960.041996] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[  960.042950] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[  960.043913] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  960.045128] RIP: 0010:queued_spin_lock_slowpath+0x48/0x690
[  960.045834] RSP: 0018:ffff880066197a00 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  960.046802] RAX: ffffed000cda7c02 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[  960.047713] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[  960.048628] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[  960.049535] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[  960.050444] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[  960.051355] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[  960.052387] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  960.053122] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[  960.054032] Call Trace:
[  960.054369]  do_raw_spin_lock+0x15b/0x1e0
[  960.054893]  copy_page_range+0x977/0x1a70
[  960.055421]  ? lock_downgrade+0x5e0/0x5e0
[  960.055942]  ? vm_iomap_memory+0x150/0x150
[  960.056490]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  960.057108]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  960.057728]  copy_process.part.50+0x5be4/0x6120
[  960.058322]  ? __cleanup_sighand+0x40/0x40
[  960.058853]  ? lock_downgrade+0x5e0/0x5e0
[  960.059380]  ? get_unused_fd_flags+0xc0/0xc0
[  960.059936]  _do_fork+0x1c1/0xd20
[  960.060378]  ? fork_idle+0x2d0/0x2d0
[  960.060849]  ? __do_pipe_flags+0x230/0x230
[  960.061386]  ? signal_fault+0x2b0/0x2b0
[  960.061890]  do_syscall_64+0x9f/0x470
[  960.062371]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  960.063022] RIP: 0033:0x7f531b98bf46
[  960.063487] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[  960.064459] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[  960.065370] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[  960.066281] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[  960.067186] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[  960.068095] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[  960.069009] Code: b8 00 00 00 00 00 fc ff df 49 c1 ed 03 41 83 e4 07
41 be 01 00 00 00 49 01 c5 41 83 c4 03 be 04 00 00 00 48 89 df e8 e8 66
36 00 <41> 0f b6 45 00 41 38 c4 7c 08 84 c0 0f 85 60 05 00 00 8b 2b 85
[  988.037022] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [sshd:2613]
[  988.037901] Modules linked in:
[  988.038302] irq event stamp: 0
[  988.038703] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[  988.039650] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[  988.040790] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[  988.041914] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[  988.042855] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[  988.043809] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  988.045005] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[  988.045704] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[  988.046664] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[  988.047568] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[  988.048475] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[  988.049386] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[  988.050290] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[  988.051193] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[  988.052221] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  988.052960] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[  988.053864] Call Trace:
[  988.054197]  do_raw_spin_lock+0x15b/0x1e0
[  988.054721]  copy_page_range+0x977/0x1a70
[  988.055250]  ? lock_downgrade+0x5e0/0x5e0
[  988.055769]  ? vm_iomap_memory+0x150/0x150
[  988.056301]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  988.056929]  ? vma_compute_subtree_gap+0x18f/0x1f0
[  988.057548]  copy_process.part.50+0x5be4/0x6120
[  988.058135]  ? __cleanup_sighand+0x40/0x40
[  988.058665]  ? lock_downgrade+0x5e0/0x5e0
[  988.059184]  ? get_unused_fd_flags+0xc0/0xc0
[  988.059740]  _do_fork+0x1c1/0xd20
[  988.060175]  ? fork_idle+0x2d0/0x2d0
[  988.060643]  ? __do_pipe_flags+0x230/0x230
[  988.061183]  ? signal_fault+0x2b0/0x2b0
[  988.061685]  do_syscall_64+0x9f/0x470
[  988.062167]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  988.062814] RIP: 0033:0x7f531b98bf46
[  988.063279] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[  988.064242] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[  988.065151] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[  988.066052] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[  988.066960] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[  988.067864] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[  988.068773] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00
[ 1016.037047] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [sshd:2613]
[ 1016.037941] Modules linked in:
[ 1016.038339] irq event stamp: 0
[ 1016.038740] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[ 1016.039680] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[ 1016.040803] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[ 1016.041932] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[ 1016.042875] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[ 1016.043831] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1016.045029] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[ 1016.045731] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[ 1016.046682] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[ 1016.047579] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[ 1016.048478] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[ 1016.049381] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[ 1016.050281] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[ 1016.051184] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[ 1016.052200] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1016.052929] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[ 1016.053835] Call Trace:
[ 1016.054170]  do_raw_spin_lock+0x15b/0x1e0
[ 1016.054693]  copy_page_range+0x977/0x1a70
[ 1016.055221]  ? lock_downgrade+0x5e0/0x5e0
[ 1016.055739]  ? vm_iomap_memory+0x150/0x150
[ 1016.056271]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1016.056885]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1016.057506]  copy_process.part.50+0x5be4/0x6120
[ 1016.058098]  ? __cleanup_sighand+0x40/0x40
[ 1016.058624]  ? lock_downgrade+0x5e0/0x5e0
[ 1016.059143]  ? get_unused_fd_flags+0xc0/0xc0
[ 1016.059695]  _do_fork+0x1c1/0xd20
[ 1016.060131]  ? fork_idle+0x2d0/0x2d0
[ 1016.060597]  ? __do_pipe_flags+0x230/0x230
[ 1016.061133]  ? signal_fault+0x2b0/0x2b0
[ 1016.061642]  do_syscall_64+0x9f/0x470
[ 1016.062122]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1016.062772] RIP: 0033:0x7f531b98bf46
[ 1016.063236] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[ 1016.064189] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[ 1016.065086] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[ 1016.065987] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[ 1016.066888] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[ 1016.067784] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[ 1016.068677] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00
[ 1044.037022] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [sshd:2613]
[ 1044.037911] Modules linked in:
[ 1044.038307] irq event stamp: 0
[ 1044.038708] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[ 1044.039653] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[ 1044.040788] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[ 1044.041926] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[ 1044.042865] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[ 1044.043822] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1044.045020] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[ 1044.045715] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[ 1044.046679] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[ 1044.047579] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[ 1044.048483] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[ 1044.049383] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[ 1044.050291] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[ 1044.051197] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[ 1044.052218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1044.052945] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[ 1044.053850] Call Trace:
[ 1044.054182]  do_raw_spin_lock+0x15b/0x1e0
[ 1044.054706]  copy_page_range+0x977/0x1a70
[ 1044.055232]  ? lock_downgrade+0x5e0/0x5e0
[ 1044.055750]  ? vm_iomap_memory+0x150/0x150
[ 1044.056280]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1044.056893]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1044.057512]  copy_process.part.50+0x5be4/0x6120
[ 1044.058111]  ? __cleanup_sighand+0x40/0x40
[ 1044.058641]  ? lock_downgrade+0x5e0/0x5e0
[ 1044.059162]  ? get_unused_fd_flags+0xc0/0xc0
[ 1044.059717]  _do_fork+0x1c1/0xd20
[ 1044.060150]  ? fork_idle+0x2d0/0x2d0
[ 1044.060614]  ? __do_pipe_flags+0x230/0x230
[ 1044.061145]  ? signal_fault+0x2b0/0x2b0
[ 1044.061644]  do_syscall_64+0x9f/0x470
[ 1044.062128]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1044.062781] RIP: 0033:0x7f531b98bf46
[ 1044.063244] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[ 1044.064201] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[ 1044.065103] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[ 1044.066011] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[ 1044.066911] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[ 1044.067807] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[ 1044.068706] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00
[ 1072.037029] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [sshd:2613]
[ 1072.037938] Modules linked in:
[ 1072.038355] irq event stamp: 0
[ 1072.038766] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[ 1072.039729] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[ 1072.040891] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[ 1072.042043] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[ 1072.043007] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[ 1072.043975] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1072.045196] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[ 1072.045905] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[ 1072.046884] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[ 1072.047800] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[ 1072.048716] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[ 1072.049632] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[ 1072.050558] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[ 1072.051481] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[ 1072.052525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1072.053274] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[ 1072.054198] Call Trace:
[ 1072.054544]  do_raw_spin_lock+0x15b/0x1e0
[ 1072.055089]  copy_page_range+0x977/0x1a70
[ 1072.055629]  ? lock_downgrade+0x5e0/0x5e0
[ 1072.056160]  ? vm_iomap_memory+0x150/0x150
[ 1072.056701]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1072.057329]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1072.057959]  copy_process.part.50+0x5be4/0x6120
[ 1072.058571]  ? __cleanup_sighand+0x40/0x40
[ 1072.059113]  ? lock_downgrade+0x5e0/0x5e0
[ 1072.059647]  ? get_unused_fd_flags+0xc0/0xc0
[ 1072.060215]  _do_fork+0x1c1/0xd20
[ 1072.060659]  ? fork_idle+0x2d0/0x2d0
[ 1072.061136]  ? __do_pipe_flags+0x230/0x230
[ 1072.061680]  ? signal_fault+0x2b0/0x2b0
[ 1072.062193]  do_syscall_64+0x9f/0x470
[ 1072.062687]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1072.063350] RIP: 0033:0x7f531b98bf46
[ 1072.063822] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[ 1072.064800] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[ 1072.065722] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[ 1072.066646] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[ 1072.067562] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[ 1072.068478] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[ 1072.069390] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00
[ 1100.037028] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [sshd:2613]
[ 1100.037915] Modules linked in:
[ 1100.038316] irq event stamp: 0
[ 1100.038720] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[ 1100.039675] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[ 1100.040814] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[ 1100.041946] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[ 1100.042893] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[ 1100.043854] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1100.045056] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[ 1100.045758] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[ 1100.046726] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[ 1100.047633] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[ 1100.048541] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[ 1100.049450] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[ 1100.050355] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[ 1100.051269] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[ 1100.052297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1100.053031] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[ 1100.053941] Call Trace:
[ 1100.054275]  do_raw_spin_lock+0x15b/0x1e0
[ 1100.054804]  copy_page_range+0x977/0x1a70
[ 1100.055334]  ? lock_downgrade+0x5e0/0x5e0
[ 1100.055853]  ? vm_iomap_memory+0x150/0x150
[ 1100.056383]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1100.056997]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1100.057612]  copy_process.part.50+0x5be4/0x6120
[ 1100.058203]  ? __cleanup_sighand+0x40/0x40
[ 1100.058738]  ? lock_downgrade+0x5e0/0x5e0
[ 1100.059260]  ? get_unused_fd_flags+0xc0/0xc0
[ 1100.059817]  _do_fork+0x1c1/0xd20
[ 1100.060255]  ? fork_idle+0x2d0/0x2d0
[ 1100.060722]  ? __do_pipe_flags+0x230/0x230
[ 1100.061253]  ? signal_fault+0x2b0/0x2b0
[ 1100.061754]  do_syscall_64+0x9f/0x470
[ 1100.062234]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1100.062885] RIP: 0033:0x7f531b98bf46
[ 1100.063349] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[ 1100.064309] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[ 1100.065218] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[ 1100.066125] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[ 1100.067033] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[ 1100.067935] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[ 1100.068842] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00
[ 1128.037029] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [sshd:2613]
[ 1128.037926] Modules linked in:
[ 1128.038327] irq event stamp: 0
[ 1128.038735] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[ 1128.039702] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[ 1128.040858] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[ 1128.042006] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[ 1128.042967] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[ 1128.043955] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1128.045188] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[ 1128.045905] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[ 1128.046890] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[ 1128.047820] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[ 1128.048746] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[ 1128.049669] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[ 1128.050593] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[ 1128.051519] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[ 1128.052558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1128.053304] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[ 1128.054224] Call Trace:
[ 1128.054560]  do_raw_spin_lock+0x15b/0x1e0
[ 1128.055091]  copy_page_range+0x977/0x1a70
[ 1128.055637]  ? lock_downgrade+0x5e0/0x5e0
[ 1128.056166]  ? vm_iomap_memory+0x150/0x150
[ 1128.056706]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1128.057334]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1128.057964]  copy_process.part.50+0x5be4/0x6120
[ 1128.058566]  ? __cleanup_sighand+0x40/0x40
[ 1128.059103]  ? lock_downgrade+0x5e0/0x5e0
[ 1128.059643]  ? get_unused_fd_flags+0xc0/0xc0
[ 1128.060211]  _do_fork+0x1c1/0xd20
[ 1128.060656]  ? fork_idle+0x2d0/0x2d0
[ 1128.061132]  ? __do_pipe_flags+0x230/0x230
[ 1128.061675]  ? signal_fault+0x2b0/0x2b0
[ 1128.062188]  do_syscall_64+0x9f/0x470
[ 1128.062678]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1128.063342] RIP: 0033:0x7f531b98bf46
[ 1128.063818] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[ 1128.064802] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[ 1128.065728] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[ 1128.066652] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[ 1128.067586] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[ 1128.068511] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[ 1128.069440] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00
[ 1156.037029] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [sshd:2613]
[ 1156.037918] Modules linked in:
[ 1156.038320] irq event stamp: 0
[ 1156.038720] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[ 1156.039667] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[ 1156.040811] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[ 1156.041959] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[ 1156.042904] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[ 1156.043869] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1156.045073] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[ 1156.045774] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[ 1156.046737] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[ 1156.047644] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[ 1156.048554] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[ 1156.049460] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[ 1156.050364] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[ 1156.051270] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[ 1156.052301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1156.053037] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[ 1156.053944] Call Trace:
[ 1156.054278]  do_raw_spin_lock+0x15b/0x1e0
[ 1156.054801]  copy_page_range+0x977/0x1a70
[ 1156.055330]  ? lock_downgrade+0x5e0/0x5e0
[ 1156.055856]  ? vm_iomap_memory+0x150/0x150
[ 1156.056388]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1156.057005]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1156.057623]  copy_process.part.50+0x5be4/0x6120
[ 1156.058216]  ? __cleanup_sighand+0x40/0x40
[ 1156.058749]  ? lock_downgrade+0x5e0/0x5e0
[ 1156.059274]  ? get_unused_fd_flags+0xc0/0xc0
[ 1156.059840]  _do_fork+0x1c1/0xd20
[ 1156.060275]  ? fork_idle+0x2d0/0x2d0
[ 1156.060744]  ? __do_pipe_flags+0x230/0x230
[ 1156.061278]  ? signal_fault+0x2b0/0x2b0
[ 1156.061781]  do_syscall_64+0x9f/0x470
[ 1156.062265]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1156.062917] RIP: 0033:0x7f531b98bf46
[ 1156.063383] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[ 1156.064352] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[ 1156.065257] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[ 1156.066161] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[ 1156.067068] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[ 1156.067977] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[ 1156.068889] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00
[ 1160.079026] INFO: rcu_sched self-detected stall on CPU
[ 1160.079719] 	1-....: (1 GPs behind) idle=4de/1/4611686018427387906
softirq=5324/5394 fqs=75834
[ 1160.080825] 	 (t=304003 jiffies g=2337 c=2336 q=35)
[ 1160.081454] NMI backtrace for cpu 1
[ 1160.081912] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[ 1160.082872] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1160.084077] Call Trace:
[ 1160.084407]  <IRQ>
[ 1160.084688]  dump_stack+0xca/0x13e
[ 1160.085142]  ? lapic_can_unplug_cpu+0x90/0x90
[ 1160.085710]  nmi_cpu_backtrace+0x153/0x170
[ 1160.086244]  ? lapic_can_unplug_cpu+0x90/0x90
[ 1160.086808]  nmi_trigger_cpumask_backtrace+0x117/0x170
[ 1160.087476]  rcu_dump_cpu_stacks+0x186/0x1d4
[ 1160.088039]  rcu_check_callbacks+0x1a2b/0x1d10
[ 1160.088618]  ? cpuacct_account_field+0x153/0x2d0
[ 1160.089218]  update_process_times+0x28/0x60
[ 1160.089763]  tick_sched_handle+0x79/0x150
[ 1160.090291]  tick_sched_timer+0x40/0x110
[ 1160.090806]  __hrtimer_run_queues+0x2d6/0xb90
[ 1160.091374]  ? tick_sched_do_timer+0x150/0x150
[ 1160.091959]  ? hrtimer_cancel+0x40/0x40
[ 1160.092464]  ? kvm_clock_get_cycles+0x21/0x30
[ 1160.093030]  ? ktime_get_update_offsets_now+0x1d5/0x2c0
[ 1160.093705]  hrtimer_interrupt+0x24e/0x620
[ 1160.094244]  smp_apic_timer_interrupt+0xc4/0x4b0
[ 1160.094847]  apic_timer_interrupt+0xf/0x20
[ 1160.095379]  </IRQ>
[ 1160.095673] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[ 1160.096382] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[ 1160.097344] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[ 1160.098250] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[ 1160.099157] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[ 1160.100064] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[ 1160.100970] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[ 1160.101880]  ? queued_spin_lock_slowpath+0x48/0x690
[ 1160.102514]  do_raw_spin_lock+0x15b/0x1e0
[ 1160.103037]  copy_page_range+0x977/0x1a70
[ 1160.103568]  ? lock_downgrade+0x5e0/0x5e0
[ 1160.104094]  ? vm_iomap_memory+0x150/0x150
[ 1160.104625]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1160.105245]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1160.105865]  copy_process.part.50+0x5be4/0x6120
[ 1160.106456]  ? __cleanup_sighand+0x40/0x40
[ 1160.106985]  ? lock_downgrade+0x5e0/0x5e0
[ 1160.107507]  ? get_unused_fd_flags+0xc0/0xc0
[ 1160.108069]  _do_fork+0x1c1/0xd20
[ 1160.108506]  ? fork_idle+0x2d0/0x2d0
[ 1160.108973]  ? __do_pipe_flags+0x230/0x230
[ 1160.109510]  ? signal_fault+0x2b0/0x2b0
[ 1160.110012]  do_syscall_64+0x9f/0x470
[ 1160.110492]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1160.111138] RIP: 0033:0x7f531b98bf46
[ 1160.111606] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[ 1160.112572] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[ 1160.113479] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[ 1160.114380] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[ 1160.115287] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[ 1160.116193] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[ 1188.037016] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [sshd:2613]
[ 1188.037963] Modules linked in:
[ 1188.038391] irq event stamp: 0
[ 1188.038800] hardirqs last  enabled at (0): [<0000000000000000>]
    (null)
[ 1188.039787] hardirqs last disabled at (0): [<ffffffffb8f05791>]
copy_process.part.50+0x1111/0x6120
[ 1188.040964] softirqs last  enabled at (0): [<ffffffffb8f05834>]
copy_process.part.50+0x11b4/0x6120
[ 1188.042154] softirqs last disabled at (0): [<0000000000000000>]
    (null)
[ 1188.043127] CPU: 1 PID: 2613 Comm: sshd Tainted: G      D W    L
4.17.0-rc1+ #2
[ 1188.044124] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1188.045393] RIP: 0010:queued_spin_lock_slowpath+0x89/0x690
[ 1188.046128] RSP: 0018:ffff880066197a00 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[ 1188.047129] RAX: 0000000000000000 RBX: ffff880066d3e008 RCX:
ffffffffb9022268
[ 1188.048070] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffff880066d3e008
[ 1188.048989] RBP: 000000000002801d R08: ffffed000cda7c02 R09:
ffffed000cda7c01
[ 1188.049892] R10: 0000000000000001 R11: ffff880066d3e00b R12:
0000000000000003
[ 1188.050826] R13: ffffed000cda7c01 R14: 0000000000000001 R15:
0000000000000000
[ 1188.051759] FS:  00007f531d6157c0(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[ 1188.052817] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1188.053551] CR2: 00000000000000f8 CR3: 000000006b03e000 CR4:
00000000000006e0
[ 1188.054456] Call Trace:
[ 1188.054793]  do_raw_spin_lock+0x15b/0x1e0
[ 1188.055326]  copy_page_range+0x977/0x1a70
[ 1188.055855]  ? lock_downgrade+0x5e0/0x5e0
[ 1188.056380]  ? vm_iomap_memory+0x150/0x150
[ 1188.056912]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1188.057529]  ? vma_compute_subtree_gap+0x18f/0x1f0
[ 1188.058149]  copy_process.part.50+0x5be4/0x6120
[ 1188.058742]  ? __cleanup_sighand+0x40/0x40
[ 1188.059272]  ? lock_downgrade+0x5e0/0x5e0
[ 1188.059795]  ? get_unused_fd_flags+0xc0/0xc0
[ 1188.060362]  _do_fork+0x1c1/0xd20
[ 1188.060798]  ? fork_idle+0x2d0/0x2d0
[ 1188.061263]  ? __do_pipe_flags+0x230/0x230
[ 1188.061798]  ? signal_fault+0x2b0/0x2b0
[ 1188.062298]  do_syscall_64+0x9f/0x470
[ 1188.062783]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1188.063432] RIP: 0033:0x7f531b98bf46
[ 1188.063895] RSP: 002b:00007fff4499b000 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[ 1188.064861] RAX: ffffffffffffffda RBX: 00007fff4499b000 RCX:
00007f531b98bf46
[ 1188.065762] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000001200011
[ 1188.066665] RBP: 00007fff4499b060 R08: 0000000000000a35 R09:
0000000000000a35
[ 1188.067565] R10: 00007f531d615a90 R11: 0000000000000246 R12:
0000000000000000
[ 1188.068483] R13: 00007fff4499b020 R14: 0000000000000000 R15:
00005634d0d6bca0
[ 1188.069387] Code: 75 27 be 04 00 00 00 48 89 df e8 d3 66 36 00 89 e8
f0 44 0f b1 33 85 c0 75 c3 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3
f3 90 <eb> b0 81 fe 00 01 00 00 89 f5 0f 84 0e 03 00 00 41 bd 01 01 00

--------------2F98B52CD204307F268FBB46
Content-Type: text/plain; charset=UTF-8;
 name=".config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=".config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4
L3g4NiA0LjE3LjAtcmMxIEtlcm5lbCBDb25maWd1cmF0aW9uCiMKQ09ORklHXzY0QklUPXkK
Q09ORklHX1g4Nl82ND15CkNPTkZJR19YODY9eQpDT05GSUdfSU5TVFJVQ1RJT05fREVDT0RF
Uj15CkNPTkZJR19PVVRQVVRfRk9STUFUPSJlbGY2NC14ODYtNjQiCkNPTkZJR19BUkNIX0RF
RkNPTkZJRz0iYXJjaC94ODYvY29uZmlncy94ODZfNjRfZGVmY29uZmlnIgpDT05GSUdfTE9D
S0RFUF9TVVBQT1JUPXkKQ09ORklHX1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNPTkZJR19NTVU9
eQpDT05GSUdfQVJDSF9NTUFQX1JORF9CSVRTX01JTj0yOApDT05GSUdfQVJDSF9NTUFQX1JO
RF9CSVRTX01BWD0zMgpDT05GSUdfQVJDSF9NTUFQX1JORF9DT01QQVRfQklUU19NSU49OApD
T05GSUdfQVJDSF9NTUFQX1JORF9DT01QQVRfQklUU19NQVg9MTYKQ09ORklHX05FRURfRE1B
X01BUF9TVEFURT15CkNPTkZJR19ORUVEX1NHX0RNQV9MRU5HVEg9eQpDT05GSUdfR0VORVJJ
Q19JU0FfRE1BPXkKQ09ORklHX0dFTkVSSUNfQlVHPXkKQ09ORklHX0dFTkVSSUNfQlVHX1JF
TEFUSVZFX1BPSU5URVJTPXkKQ09ORklHX0dFTkVSSUNfSFdFSUdIVD15CkNPTkZJR19BUkNI
X01BWV9IQVZFX1BDX0ZEQz15CkNPTkZJR19SV1NFTV9YQ0hHQUREX0FMR09SSVRITT15CkNP
TkZJR19HRU5FUklDX0NBTElCUkFURV9ERUxBWT15CkNPTkZJR19BUkNIX0hBU19DUFVfUkVM
QVg9eQpDT05GSUdfQVJDSF9IQVNfQ0FDSEVfTElORV9TSVpFPXkKQ09ORklHX0hBVkVfU0VU
VVBfUEVSX0NQVV9BUkVBPXkKQ09ORklHX05FRURfUEVSX0NQVV9FTUJFRF9GSVJTVF9DSFVO
Sz15CkNPTkZJR19ORUVEX1BFUl9DUFVfUEFHRV9GSVJTVF9DSFVOSz15CkNPTkZJR19BUkNI
X0hJQkVSTkFUSU9OX1BPU1NJQkxFPXkKQ09ORklHX0FSQ0hfU1VTUEVORF9QT1NTSUJMRT15
CkNPTkZJR19BUkNIX1dBTlRfSFVHRV9QTURfU0hBUkU9eQpDT05GSUdfQVJDSF9XQU5UX0dF
TkVSQUxfSFVHRVRMQj15CkNPTkZJR19aT05FX0RNQTMyPXkKQ09ORklHX0FVRElUX0FSQ0g9
eQpDT05GSUdfQVJDSF9TVVBQT1JUU19PUFRJTUlaRURfSU5MSU5JTkc9eQpDT05GSUdfQVJD
SF9TVVBQT1JUU19ERUJVR19QQUdFQUxMT0M9eQpDT05GSUdfS0FTQU5fU0hBRE9XX09GRlNF
VD0weGRmZmZmYzAwMDAwMDAwMDAKQ09ORklHX0hBVkVfSU5URUxfVFhUPXkKQ09ORklHX1g4
Nl82NF9TTVA9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19VUFJPQkVTPXkKQ09ORklHX0ZJWF9F
QVJMWUNPTl9NRU09eQpDT05GSUdfUEdUQUJMRV9MRVZFTFM9NApDT05GSUdfQ09OU1RSVUNU
T1JTPXkKQ09ORklHX0lSUV9XT1JLPXkKQ09ORklHX0JVSUxEVElNRV9FWFRBQkxFX1NPUlQ9
eQpDT05GSUdfVEhSRUFEX0lORk9fSU5fVEFTSz15CgojCiMgR2VuZXJhbCBzZXR1cAojCkNP
TkZJR19JTklUX0VOVl9BUkdfTElNSVQ9MzIKQ09ORklHX0NST1NTX0NPTVBJTEU9IiIKIyBD
T05GSUdfQ09NUElMRV9URVNUIGlzIG5vdCBzZXQKQ09ORklHX0xPQ0FMVkVSU0lPTj0iIgoj
IENPTkZJR19MT0NBTFZFUlNJT05fQVVUTyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0tFUk5F
TF9HWklQPXkKQ09ORklHX0hBVkVfS0VSTkVMX0JaSVAyPXkKQ09ORklHX0hBVkVfS0VSTkVM
X0xaTUE9eQpDT05GSUdfSEFWRV9LRVJORUxfWFo9eQpDT05GSUdfSEFWRV9LRVJORUxfTFpP
PXkKQ09ORklHX0hBVkVfS0VSTkVMX0xaND15CkNPTkZJR19LRVJORUxfR1pJUD15CiMgQ09O
RklHX0tFUk5FTF9CWklQMiBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9MWk1BIGlzIG5v
dCBzZXQKIyBDT05GSUdfS0VSTkVMX1haIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VSTkVMX0xa
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9MWjQgaXMgbm90IHNldApDT05GSUdfREVG
QVVMVF9IT1NUTkFNRT0iKG5vbmUpIgpDT05GSUdfU1dBUD15CkNPTkZJR19TWVNWSVBDPXkK
Q09ORklHX1NZU1ZJUENfU1lTQ1RMPXkKQ09ORklHX1BPU0lYX01RVUVVRT15CkNPTkZJR19Q
T1NJWF9NUVVFVUVfU1lTQ1RMPXkKQ09ORklHX0NST1NTX01FTU9SWV9BVFRBQ0g9eQpDT05G
SUdfVVNFTElCPXkKQ09ORklHX0FVRElUPXkKQ09ORklHX0hBVkVfQVJDSF9BVURJVFNZU0NB
TEw9eQpDT05GSUdfQVVESVRTWVNDQUxMPXkKQ09ORklHX0FVRElUX1dBVENIPXkKQ09ORklH
X0FVRElUX1RSRUU9eQoKIwojIElSUSBzdWJzeXN0ZW0KIwpDT05GSUdfR0VORVJJQ19JUlFf
UFJPQkU9eQpDT05GSUdfR0VORVJJQ19JUlFfU0hPVz15CkNPTkZJR19HRU5FUklDX0lSUV9F
RkZFQ1RJVkVfQUZGX01BU0s9eQpDT05GSUdfR0VORVJJQ19QRU5ESU5HX0lSUT15CkNPTkZJ
R19HRU5FUklDX0lSUV9NSUdSQVRJT049eQpDT05GSUdfSVJRX0RPTUFJTj15CkNPTkZJR19J
UlFfRE9NQUlOX0hJRVJBUkNIWT15CkNPTkZJR19HRU5FUklDX01TSV9JUlE9eQpDT05GSUdf
R0VORVJJQ19NU0lfSVJRX0RPTUFJTj15CkNPTkZJR19HRU5FUklDX0lSUV9NQVRSSVhfQUxM
T0NBVE9SPXkKQ09ORklHX0dFTkVSSUNfSVJRX1JFU0VSVkFUSU9OX01PREU9eQpDT05GSUdf
SVJRX0ZPUkNFRF9USFJFQURJTkc9eQpDT05GSUdfU1BBUlNFX0lSUT15CiMgQ09ORklHX0dF
TkVSSUNfSVJRX0RFQlVHRlMgaXMgbm90IHNldApDT05GSUdfQ0xPQ0tTT1VSQ0VfV0FUQ0hE
T0c9eQpDT05GSUdfQVJDSF9DTE9DS1NPVVJDRV9EQVRBPXkKQ09ORklHX0NMT0NLU09VUkNF
X1ZBTElEQVRFX0xBU1RfQ1lDTEU9eQpDT05GSUdfR0VORVJJQ19USU1FX1ZTWVNDQUxMPXkK
Q09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFM9eQpDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5U
U19CUk9BRENBU1Q9eQpDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UU19NSU5fQURKVVNUPXkK
Q09ORklHX0dFTkVSSUNfQ01PU19VUERBVEU9eQoKIwojIFRpbWVycyBzdWJzeXN0ZW0KIwpD
T05GSUdfVElDS19PTkVTSE9UPXkKQ09ORklHX05PX0haX0NPTU1PTj15CiMgQ09ORklHX0ha
X1BFUklPRElDIGlzIG5vdCBzZXQKQ09ORklHX05PX0haX0lETEU9eQojIENPTkZJR19OT19I
Wl9GVUxMIGlzIG5vdCBzZXQKQ09ORklHX05PX0haPXkKQ09ORklHX0hJR0hfUkVTX1RJTUVS
Uz15CgojCiMgQ1BVL1Rhc2sgdGltZSBhbmQgc3RhdHMgYWNjb3VudGluZwojCkNPTkZJR19U
SUNLX0NQVV9BQ0NPVU5USU5HPXkKIyBDT05GSUdfVklSVF9DUFVfQUNDT1VOVElOR19HRU4g
aXMgbm90IHNldAojIENPTkZJR19JUlFfVElNRV9BQ0NPVU5USU5HIGlzIG5vdCBzZXQKQ09O
RklHX0JTRF9QUk9DRVNTX0FDQ1Q9eQojIENPTkZJR19CU0RfUFJPQ0VTU19BQ0NUX1YzIGlz
IG5vdCBzZXQKQ09ORklHX1RBU0tTVEFUUz15CkNPTkZJR19UQVNLX0RFTEFZX0FDQ1Q9eQpD
T05GSUdfVEFTS19YQUNDVD15CkNPTkZJR19UQVNLX0lPX0FDQ09VTlRJTkc9eQpDT05GSUdf
Q1BVX0lTT0xBVElPTj15CgojCiMgUkNVIFN1YnN5c3RlbQojCkNPTkZJR19UUkVFX1JDVT15
CiMgQ09ORklHX1JDVV9FWFBFUlQgaXMgbm90IHNldApDT05GSUdfU1JDVT15CkNPTkZJR19U
UkVFX1NSQ1U9eQpDT05GSUdfUkNVX1NUQUxMX0NPTU1PTj15CkNPTkZJR19SQ1VfTkVFRF9T
RUdDQkxJU1Q9eQojIENPTkZJR19JS0NPTkZJRyBpcyBub3Qgc2V0CkNPTkZJR19MT0dfQlVG
X1NISUZUPTE4CkNPTkZJR19MT0dfQ1BVX01BWF9CVUZfU0hJRlQ9MTIKQ09ORklHX1BSSU5U
S19TQUZFX0xPR19CVUZfU0hJRlQ9MTMKQ09ORklHX0hBVkVfVU5TVEFCTEVfU0NIRURfQ0xP
Q0s9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19OVU1BX0JBTEFOQ0lORz15CkNPTkZJR19BUkNI
X1dBTlRfQkFUQ0hFRF9VTk1BUF9UTEJfRkxVU0g9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19J
TlQxMjg9eQojIENPTkZJR19OVU1BX0JBTEFOQ0lORyBpcyBub3Qgc2V0CkNPTkZJR19DR1JP
VVBTPXkKIyBDT05GSUdfTUVNQ0cgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ0dST1VQIGlz
IG5vdCBzZXQKQ09ORklHX0NHUk9VUF9TQ0hFRD15CkNPTkZJR19GQUlSX0dST1VQX1NDSEVE
PXkKIyBDT05GSUdfQ0ZTX0JBTkRXSURUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUX0dST1VQ
X1NDSEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0dST1VQX1BJRFMgaXMgbm90IHNldAojIENP
TkZJR19DR1JPVVBfUkRNQSBpcyBub3Qgc2V0CkNPTkZJR19DR1JPVVBfRlJFRVpFUj15CiMg
Q09ORklHX0NHUk9VUF9IVUdFVExCIGlzIG5vdCBzZXQKQ09ORklHX0NQVVNFVFM9eQpDT05G
SUdfUFJPQ19QSURfQ1BVU0VUPXkKIyBDT05GSUdfQ0dST1VQX0RFVklDRSBpcyBub3Qgc2V0
CkNPTkZJR19DR1JPVVBfQ1BVQUNDVD15CiMgQ09ORklHX0NHUk9VUF9QRVJGIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ0dST1VQX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX05BTUVTUEFDRVM9
eQpDT05GSUdfVVRTX05TPXkKQ09ORklHX0lQQ19OUz15CkNPTkZJR19VU0VSX05TPXkKQ09O
RklHX1BJRF9OUz15CkNPTkZJR19ORVRfTlM9eQojIENPTkZJR19TQ0hFRF9BVVRPR1JPVVAg
aXMgbm90IHNldAojIENPTkZJR19TWVNGU19ERVBSRUNBVEVEIGlzIG5vdCBzZXQKQ09ORklH
X1JFTEFZPXkKQ09ORklHX0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX0lOSVRSQU1GU19TT1VS
Q0U9IiIKQ09ORklHX1JEX0daSVA9eQpDT05GSUdfUkRfQlpJUDI9eQpDT05GSUdfUkRfTFpN
QT15CkNPTkZJR19SRF9YWj15CkNPTkZJR19SRF9MWk89eQpDT05GSUdfUkRfTFo0PXkKQ09O
RklHX0NDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRT15CiMgQ09ORklHX0NDX09QVElNSVpF
X0ZPUl9TSVpFIGlzIG5vdCBzZXQKQ09ORklHX1NZU0NUTD15CkNPTkZJR19BTk9OX0lOT0RF
Uz15CkNPTkZJR19IQVZFX1VJRDE2PXkKQ09ORklHX1NZU0NUTF9FWENFUFRJT05fVFJBQ0U9
eQpDT05GSUdfSEFWRV9QQ1NQS1JfUExBVEZPUk09eQpDT05GSUdfQlBGPXkKIyBDT05GSUdf
RVhQRVJUIGlzIG5vdCBzZXQKQ09ORklHX1VJRDE2PXkKQ09ORklHX01VTFRJVVNFUj15CkNP
TkZJR19TR0VUTUFTS19TWVNDQUxMPXkKQ09ORklHX1NZU0ZTX1NZU0NBTEw9eQpDT05GSUdf
RkhBTkRMRT15CkNPTkZJR19QT1NJWF9USU1FUlM9eQpDT05GSUdfUFJJTlRLPXkKQ09ORklH
X1BSSU5US19OTUk9eQpDT05GSUdfQlVHPXkKQ09ORklHX0VMRl9DT1JFPXkKQ09ORklHX1BD
U1BLUl9QTEFURk9STT15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9eQpDT05G
SUdfRlVURVhfUEk9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lHTkFMRkQ9eQpDT05GSUdf
VElNRVJGRD15CkNPTkZJR19FVkVOVEZEPXkKQ09ORklHX1NITUVNPXkKQ09ORklHX0FJTz15
CkNPTkZJR19BRFZJU0VfU1lTQ0FMTFM9eQpDT05GSUdfTUVNQkFSUklFUj15CkNPTkZJR19L
QUxMU1lNUz15CkNPTkZJR19LQUxMU1lNU19BTEw9eQpDT05GSUdfS0FMTFNZTVNfQUJTT0xV
VEVfUEVSQ1BVPXkKQ09ORklHX0tBTExTWU1TX0JBU0VfUkVMQVRJVkU9eQojIENPTkZJR19C
UEZfU1lTQ0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTRVJGQVVMVEZEIGlzIG5vdCBzZXQK
Q09ORklHX0FSQ0hfSEFTX01FTUJBUlJJRVJfU1lOQ19DT1JFPXkKIyBDT05GSUdfRU1CRURE
RUQgaXMgbm90IHNldApDT05GSUdfSEFWRV9QRVJGX0VWRU5UUz15CgojCiMgS2VybmVsIFBl
cmZvcm1hbmNlIEV2ZW50cyBBbmQgQ291bnRlcnMKIwpDT05GSUdfUEVSRl9FVkVOVFM9eQoj
IENPTkZJR19ERUJVR19QRVJGX1VTRV9WTUFMTE9DIGlzIG5vdCBzZXQKQ09ORklHX1ZNX0VW
RU5UX0NPVU5URVJTPXkKQ09ORklHX1NMVUJfREVCVUc9eQojIENPTkZJR19DT01QQVRfQlJL
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0xBQiBpcyBub3Qgc2V0CkNPTkZJR19TTFVCPXkKQ09O
RklHX1NMQUJfTUVSR0VfREVGQVVMVD15CiMgQ09ORklHX1NMQUJfRlJFRUxJU1RfUkFORE9N
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0xBQl9GUkVFTElTVF9IQVJERU5FRCBpcyBub3Qgc2V0
CkNPTkZJR19TTFVCX0NQVV9QQVJUSUFMPXkKQ09ORklHX1NZU1RFTV9EQVRBX1ZFUklGSUNB
VElPTj15CkNPTkZJR19QUk9GSUxJTkc9eQpDT05GSUdfVFJBQ0VQT0lOVFM9eQpDT05GSUdf
Q1JBU0hfQ09SRT15CkNPTkZJR19LRVhFQ19DT1JFPXkKIyBDT05GSUdfT1BST0ZJTEUgaXMg
bm90IHNldApDT05GSUdfSEFWRV9PUFJPRklMRT15CkNPTkZJR19PUFJPRklMRV9OTUlfVElN
RVI9eQpDT05GSUdfS1BST0JFUz15CkNPTkZJR19KVU1QX0xBQkVMPXkKIyBDT05GSUdfU1RB
VElDX0tFWVNfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfT1BUUFJPQkVTPXkKQ09ORklH
X1VQUk9CRVM9eQpDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElHTkVEX0FDQ0VTUz15CkNP
TkZJR19BUkNIX1VTRV9CVUlMVElOX0JTV0FQPXkKQ09ORklHX0tSRVRQUk9CRVM9eQpDT05G
SUdfSEFWRV9JT1JFTUFQX1BST1Q9eQpDT05GSUdfSEFWRV9LUFJPQkVTPXkKQ09ORklHX0hB
VkVfS1JFVFBST0JFUz15CkNPTkZJR19IQVZFX09QVFBST0JFUz15CkNPTkZJR19IQVZFX0tQ
Uk9CRVNfT05fRlRSQUNFPXkKQ09ORklHX0hBVkVfRlVOQ1RJT05fRVJST1JfSU5KRUNUSU9O
PXkKQ09ORklHX0hBVkVfTk1JPXkKQ09ORklHX0hBVkVfQVJDSF9UUkFDRUhPT0s9eQpDT05G
SUdfSEFWRV9ETUFfQ09OVElHVU9VUz15CkNPTkZJR19HRU5FUklDX1NNUF9JRExFX1RIUkVB
RD15CkNPTkZJR19BUkNIX0hBU19GT1JUSUZZX1NPVVJDRT15CkNPTkZJR19BUkNIX0hBU19T
RVRfTUVNT1JZPXkKQ09ORklHX0hBVkVfQVJDSF9USFJFQURfU1RSVUNUX1dISVRFTElTVD15
CkNPTkZJR19BUkNIX1dBTlRTX0RZTkFNSUNfVEFTS19TVFJVQ1Q9eQpDT05GSUdfSEFWRV9S
RUdTX0FORF9TVEFDS19BQ0NFU1NfQVBJPXkKQ09ORklHX0hBVkVfQ0xLPXkKQ09ORklHX0hB
VkVfRE1BX0FQSV9ERUJVRz15CkNPTkZJR19IQVZFX0hXX0JSRUFLUE9JTlQ9eQpDT05GSUdf
SEFWRV9NSVhFRF9CUkVBS1BPSU5UU19SRUdTPXkKQ09ORklHX0hBVkVfVVNFUl9SRVRVUk5f
Tk9USUZJRVI9eQpDT05GSUdfSEFWRV9QRVJGX0VWRU5UU19OTUk9eQpDT05GSUdfSEFWRV9I
QVJETE9DS1VQX0RFVEVDVE9SX1BFUkY9eQpDT05GSUdfSEFWRV9QRVJGX1JFR1M9eQpDT05G
SUdfSEFWRV9QRVJGX1VTRVJfU1RBQ0tfRFVNUD15CkNPTkZJR19IQVZFX0FSQ0hfSlVNUF9M
QUJFTD15CkNPTkZJR19IQVZFX1JDVV9UQUJMRV9GUkVFPXkKQ09ORklHX0FSQ0hfSEFWRV9O
TUlfU0FGRV9DTVBYQ0hHPXkKQ09ORklHX0hBVkVfQUxJR05FRF9TVFJVQ1RfUEFHRT15CkNP
TkZJR19IQVZFX0NNUFhDSEdfTE9DQUw9eQpDT05GSUdfSEFWRV9DTVBYQ0hHX0RPVUJMRT15
CkNPTkZJR19BUkNIX1dBTlRfQ09NUEFUX0lQQ19QQVJTRV9WRVJTSU9OPXkKQ09ORklHX0FS
Q0hfV0FOVF9PTERfQ09NUEFUX0lQQz15CkNPTkZJR19IQVZFX0FSQ0hfU0VDQ09NUF9GSUxU
RVI9eQpDT05GSUdfU0VDQ09NUF9GSUxURVI9eQpDT05GSUdfSEFWRV9HQ0NfUExVR0lOUz15
CkNPTkZJR19HQ0NfUExVR0lOUz15CkNPTkZJR19HQ0NfUExVR0lOX1NBTkNPVj15CiMgQ09O
RklHX0dDQ19QTFVHSU5fTEFURU5UX0VOVFJPUFkgaXMgbm90IHNldAojIENPTkZJR19HQ0Nf
UExVR0lOX1NUUlVDVExFQUsgaXMgbm90IHNldAojIENPTkZJR19HQ0NfUExVR0lOX1JBTkRT
VFJVQ1QgaXMgbm90IHNldApDT05GSUdfSEFWRV9DQ19TVEFDS1BST1RFQ1RPUj15CiMgQ09O
RklHX0NDX1NUQUNLUFJPVEVDVE9SX05PTkUgaXMgbm90IHNldAojIENPTkZJR19DQ19TVEFD
S1BST1RFQ1RPUl9SRUdVTEFSIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0NfU1RBQ0tQUk9URUNU
T1JfU1RST05HIGlzIG5vdCBzZXQKQ09ORklHX0NDX1NUQUNLUFJPVEVDVE9SX0FVVE89eQpD
T05GSUdfSEFWRV9BUkNIX1dJVEhJTl9TVEFDS19GUkFNRVM9eQpDT05GSUdfSEFWRV9DT05U
RVhUX1RSQUNLSU5HPXkKQ09ORklHX0hBVkVfVklSVF9DUFVfQUNDT1VOVElOR19HRU49eQpD
T05GSUdfSEFWRV9JUlFfVElNRV9BQ0NPVU5USU5HPXkKQ09ORklHX0hBVkVfQVJDSF9UUkFO
U1BBUkVOVF9IVUdFUEFHRT15CkNPTkZJR19IQVZFX0FSQ0hfVFJBTlNQQVJFTlRfSFVHRVBB
R0VfUFVEPXkKQ09ORklHX0hBVkVfQVJDSF9IVUdFX1ZNQVA9eQpDT05GSUdfSEFWRV9BUkNI
X1NPRlRfRElSVFk9eQpDT05GSUdfSEFWRV9NT0RfQVJDSF9TUEVDSUZJQz15CkNPTkZJR19N
T0RVTEVTX1VTRV9FTEZfUkVMQT15CkNPTkZJR19IQVZFX0lSUV9FWElUX09OX0lSUV9TVEFD
Sz15CkNPTkZJR19BUkNIX0hBU19FTEZfUkFORE9NSVpFPXkKQ09ORklHX0hBVkVfQVJDSF9N
TUFQX1JORF9CSVRTPXkKQ09ORklHX0hBVkVfRVhJVF9USFJFQUQ9eQpDT05GSUdfQVJDSF9N
TUFQX1JORF9CSVRTPTI4CkNPTkZJR19IQVZFX0FSQ0hfTU1BUF9STkRfQ09NUEFUX0JJVFM9
eQpDT05GSUdfQVJDSF9NTUFQX1JORF9DT01QQVRfQklUUz04CkNPTkZJR19IQVZFX0FSQ0hf
Q09NUEFUX01NQVBfQkFTRVM9eQpDT05GSUdfSEFWRV9DT1BZX1RIUkVBRF9UTFM9eQpDT05G
SUdfSEFWRV9TVEFDS19WQUxJREFUSU9OPXkKQ09ORklHX09MRF9TSUdTVVNQRU5EMz15CkNP
TkZJR19DT01QQVRfT0xEX1NJR0FDVElPTj15CkNPTkZJR19IQVZFX0FSQ0hfVk1BUF9TVEFD
Sz15CkNPTkZJR19BUkNIX0hBU19TVFJJQ1RfS0VSTkVMX1JXWD15CkNPTkZJR19TVFJJQ1Rf
S0VSTkVMX1JXWD15CkNPTkZJR19BUkNIX0hBU19TVFJJQ1RfTU9EVUxFX1JXWD15CkNPTkZJ
R19TVFJJQ1RfTU9EVUxFX1JXWD15CkNPTkZJR19BUkNIX0hBU19SRUZDT1VOVD15CkNPTkZJ
R19SRUZDT1VOVF9GVUxMPXkKCiMKIyBHQ09WLWJhc2VkIGtlcm5lbCBwcm9maWxpbmcKIwoj
IENPTkZJR19HQ09WX0tFUk5FTCBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19HQ09WX1BS
T0ZJTEVfQUxMPXkKQ09ORklHX1JUX01VVEVYRVM9eQpDT05GSUdfQkFTRV9TTUFMTD0wCkNP
TkZJR19NT0RVTEVTPXkKIyBDT05GSUdfTU9EVUxFX0ZPUkNFX0xPQUQgaXMgbm90IHNldApD
T05GSUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19NT0RVTEVfRk9SQ0VfVU5MT0FEPXkKIyBD
T05GSUdfTU9EVkVSU0lPTlMgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfU1JDVkVSU0lP
Tl9BTEwgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfU0lHIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU9EVUxFX0NPTVBSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfVFJJTV9VTlVTRURfS1NZ
TVMgaXMgbm90IHNldApDT05GSUdfTU9EVUxFU19UUkVFX0xPT0tVUD15CkNPTkZJR19CTE9D
Sz15CkNPTkZJR19CTEtfU0NTSV9SRVFVRVNUPXkKQ09ORklHX0JMS19ERVZfQlNHPXkKIyBD
T05GSUdfQkxLX0RFVl9CU0dMSUIgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lOVEVH
UklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfWk9ORUQgaXMgbm90IHNldAojIENP
TkZJR19CTEtfQ01ETElORV9QQVJTRVIgaXMgbm90IHNldAojIENPTkZJR19CTEtfV0JUIGlz
IG5vdCBzZXQKQ09ORklHX0JMS19ERUJVR19GUz15CiMgQ09ORklHX0JMS19TRURfT1BBTCBp
cyBub3Qgc2V0CgojCiMgUGFydGl0aW9uIFR5cGVzCiMKQ09ORklHX1BBUlRJVElPTl9BRFZB
TkNFRD15CiMgQ09ORklHX0FDT1JOX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FJ
WF9QQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdfT1NGX1BBUlRJVElPTj15CkNPTkZJR19B
TUlHQV9QQVJUSVRJT049eQojIENPTkZJR19BVEFSSV9QQVJUSVRJT04gaXMgbm90IHNldApD
T05GSUdfTUFDX1BBUlRJVElPTj15CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQpDT05GSUdf
QlNEX0RJU0tMQUJFTD15CkNPTkZJR19NSU5JWF9TVUJQQVJUSVRJT049eQpDT05GSUdfU09M
QVJJU19YODZfUEFSVElUSU9OPXkKQ09ORklHX1VOSVhXQVJFX0RJU0tMQUJFTD15CiMgQ09O
RklHX0xETV9QQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdfU0dJX1BBUlRJVElPTj15CiMg
Q09ORklHX1VMVFJJWF9QQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdfU1VOX1BBUlRJVElP
Tj15CkNPTkZJR19LQVJNQV9QQVJUSVRJT049eQpDT05GSUdfRUZJX1BBUlRJVElPTj15CiMg
Q09ORklHX1NZU1Y2OF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19DTURMSU5FX1BB
UlRJVElPTiBpcyBub3Qgc2V0CkNPTkZJR19CTE9DS19DT01QQVQ9eQpDT05GSUdfQkxLX01R
X1BDST15CkNPTkZJR19CTEtfTVFfVklSVElPPXkKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09O
RklHX0lPU0NIRURfTk9PUD15CkNPTkZJR19JT1NDSEVEX0RFQURMSU5FPXkKQ09ORklHX0lP
U0NIRURfQ0ZRPXkKIyBDT05GSUdfREVGQVVMVF9ERUFETElORSBpcyBub3Qgc2V0CkNPTkZJ
R19ERUZBVUxUX0NGUT15CiMgQ09ORklHX0RFRkFVTFRfTk9PUCBpcyBub3Qgc2V0CkNPTkZJ
R19ERUZBVUxUX0lPU0NIRUQ9ImNmcSIKQ09ORklHX01RX0lPU0NIRURfREVBRExJTkU9eQpD
T05GSUdfTVFfSU9TQ0hFRF9LWUJFUj15CiMgQ09ORklHX0lPU0NIRURfQkZRIGlzIG5vdCBz
ZXQKQ09ORklHX0FTTjE9eQpDT05GSUdfVU5JTkxJTkVfU1BJTl9VTkxPQ0s9eQpDT05GSUdf
QVJDSF9TVVBQT1JUU19BVE9NSUNfUk1XPXkKQ09ORklHX01VVEVYX1NQSU5fT05fT1dORVI9
eQpDT05GSUdfUldTRU1fU1BJTl9PTl9PV05FUj15CkNPTkZJR19MT0NLX1NQSU5fT05fT1dO
RVI9eQpDT05GSUdfQVJDSF9VU0VfUVVFVUVEX1NQSU5MT0NLUz15CkNPTkZJR19RVUVVRURf
U1BJTkxPQ0tTPXkKQ09ORklHX0FSQ0hfVVNFX1FVRVVFRF9SV0xPQ0tTPXkKQ09ORklHX1FV
RVVFRF9SV0xPQ0tTPXkKQ09ORklHX0FSQ0hfSEFTX1NZTkNfQ09SRV9CRUZPUkVfVVNFUk1P
REU9eQpDT05GSUdfQVJDSF9IQVNfU1lTQ0FMTF9XUkFQUEVSPXkKQ09ORklHX0ZSRUVaRVI9
eQoKIwojIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJlcwojCkNPTkZJR19aT05FX0RNQT15
CkNPTkZJR19TTVA9eQpDT05GSUdfWDg2X0ZFQVRVUkVfTkFNRVM9eQojIENPTkZJR19YODZf
WDJBUElDIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9NUFBBUlNFPXkKIyBDT05GSUdfR09MREZJ
U0ggaXMgbm90IHNldApDT05GSUdfUkVUUE9MSU5FPXkKIyBDT05GSUdfSU5URUxfUkRUIGlz
IG5vdCBzZXQKQ09ORklHX1g4Nl9FWFRFTkRFRF9QTEFURk9STT15CiMgQ09ORklHX1g4Nl9W
U01QIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0dPTERGSVNIIGlzIG5vdCBzZXQKIyBDT05G
SUdfWDg2X0lOVEVMX01JRCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9JTlRFTF9MUFNTIGlz
IG5vdCBzZXQKIyBDT05GSUdfWDg2X0FNRF9QTEFURk9STV9ERVZJQ0UgaXMgbm90IHNldApD
T05GSUdfSU9TRl9NQkk9eQojIENPTkZJR19JT1NGX01CSV9ERUJVRyBpcyBub3Qgc2V0CkNP
TkZJR19YODZfU1VQUE9SVFNfTUVNT1JZX0ZBSUxVUkU9eQpDT05GSUdfU0NIRURfT01JVF9G
UkFNRV9QT0lOVEVSPXkKQ09ORklHX0hZUEVSVklTT1JfR1VFU1Q9eQpDT05GSUdfUEFSQVZJ
UlQ9eQojIENPTkZJR19QQVJBVklSVF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUkFW
SVJUX1NQSU5MT0NLUyBpcyBub3Qgc2V0CiMgQ09ORklHX1hFTiBpcyBub3Qgc2V0CkNPTkZJ
R19LVk1fR1VFU1Q9eQojIENPTkZJR19LVk1fREVCVUdfRlMgaXMgbm90IHNldAojIENPTkZJ
R19QQVJBVklSVF9USU1FX0FDQ09VTlRJTkcgaXMgbm90IHNldApDT05GSUdfUEFSQVZJUlRf
Q0xPQ0s9eQojIENPTkZJR19KQUlMSE9VU0VfR1VFU1QgaXMgbm90IHNldApDT05GSUdfTk9f
Qk9PVE1FTT15CiMgQ09ORklHX01LOCBpcyBub3Qgc2V0CiMgQ09ORklHX01QU0MgaXMgbm90
IHNldAojIENPTkZJR19NQ09SRTIgaXMgbm90IHNldAojIENPTkZJR19NQVRPTSBpcyBub3Qg
c2V0CkNPTkZJR19HRU5FUklDX0NQVT15CkNPTkZJR19YODZfSU5URVJOT0RFX0NBQ0hFX1NI
SUZUPTYKQ09ORklHX1g4Nl9MMV9DQUNIRV9TSElGVD02CkNPTkZJR19YODZfVFNDPXkKQ09O
RklHX1g4Nl9DTVBYQ0hHNjQ9eQpDT05GSUdfWDg2X0NNT1Y9eQpDT05GSUdfWDg2X01JTklN
VU1fQ1BVX0ZBTUlMWT02NApDT05GSUdfWDg2X0RFQlVHQ1RMTVNSPXkKQ09ORklHX0NQVV9T
VVBfSU5URUw9eQpDT05GSUdfQ1BVX1NVUF9BTUQ9eQpDT05GSUdfQ1BVX1NVUF9DRU5UQVVS
PXkKQ09ORklHX0hQRVRfVElNRVI9eQpDT05GSUdfSFBFVF9FTVVMQVRFX1JUQz15CkNPTkZJ
R19ETUk9eQojIENPTkZJR19HQVJUX0lPTU1VIGlzIG5vdCBzZXQKQ09ORklHX0NBTEdBUllf
SU9NTVU9eQpDT05GSUdfQ0FMR0FSWV9JT01NVV9FTkFCTEVEX0JZX0RFRkFVTFQ9eQpDT05G
SUdfU1dJT1RMQj15CkNPTkZJR19JT01NVV9IRUxQRVI9eQojIENPTkZJR19NQVhTTVAgaXMg
bm90IHNldApDT05GSUdfTlJfQ1BVU19SQU5HRV9CRUdJTj0yCkNPTkZJR19OUl9DUFVTX1JB
TkdFX0VORD01MTIKQ09ORklHX05SX0NQVVNfREVGQVVMVD02NApDT05GSUdfTlJfQ1BVUz02
NApDT05GSUdfU0NIRURfU01UPXkKQ09ORklHX1NDSEVEX01DPXkKQ09ORklHX1NDSEVEX01D
X1BSSU89eQojIENPTkZJR19QUkVFTVBUX05PTkUgaXMgbm90IHNldApDT05GSUdfUFJFRU1Q
VF9WT0xVTlRBUlk9eQojIENPTkZJR19QUkVFTVBUIGlzIG5vdCBzZXQKQ09ORklHX1BSRUVN
UFRfQ09VTlQ9eQpDT05GSUdfWDg2X0xPQ0FMX0FQSUM9eQpDT05GSUdfWDg2X0lPX0FQSUM9
eQpDT05GSUdfWDg2X1JFUk9VVEVfRk9SX0JST0tFTl9CT09UX0lSUVM9eQpDT05GSUdfWDg2
X01DRT15CiMgQ09ORklHX1g4Nl9NQ0VMT0dfTEVHQUNZIGlzIG5vdCBzZXQKQ09ORklHX1g4
Nl9NQ0VfSU5URUw9eQpDT05GSUdfWDg2X01DRV9BTUQ9eQpDT05GSUdfWDg2X01DRV9USFJF
U0hPTEQ9eQojIENPTkZJR19YODZfTUNFX0lOSkVDVCBpcyBub3Qgc2V0CkNPTkZJR19YODZf
VEhFUk1BTF9WRUNUT1I9eQoKIwojIFBlcmZvcm1hbmNlIG1vbml0b3JpbmcKIwpDT05GSUdf
UEVSRl9FVkVOVFNfSU5URUxfVU5DT1JFPXkKQ09ORklHX1BFUkZfRVZFTlRTX0lOVEVMX1JB
UEw9eQpDT05GSUdfUEVSRl9FVkVOVFNfSU5URUxfQ1NUQVRFPXkKIyBDT05GSUdfUEVSRl9F
VkVOVFNfQU1EX1BPV0VSIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl8xNkJJVD15CkNPTkZJR19Y
ODZfRVNQRklYNjQ9eQpDT05GSUdfWDg2X1ZTWVNDQUxMX0VNVUxBVElPTj15CiMgQ09ORklH
X0k4SyBpcyBub3Qgc2V0CkNPTkZJR19NSUNST0NPREU9eQpDT05GSUdfTUlDUk9DT0RFX0lO
VEVMPXkKQ09ORklHX01JQ1JPQ09ERV9BTUQ9eQpDT05GSUdfTUlDUk9DT0RFX09MRF9JTlRF
UkZBQ0U9eQpDT05GSUdfWDg2X01TUj15CkNPTkZJR19YODZfQ1BVSUQ9eQojIENPTkZJR19Y
ODZfNUxFVkVMIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfUEhZU19BRERSX1RfNjRCSVQ9eQpD
T05GSUdfQVJDSF9ETUFfQUREUl9UXzY0QklUPXkKQ09ORklHX1g4Nl9ESVJFQ1RfR0JQQUdF
Uz15CkNPTkZJR19BUkNIX0hBU19NRU1fRU5DUllQVD15CiMgQ09ORklHX0FNRF9NRU1fRU5D
UllQVCBpcyBub3Qgc2V0CkNPTkZJR19OVU1BPXkKQ09ORklHX0FNRF9OVU1BPXkKQ09ORklH
X1g4Nl82NF9BQ1BJX05VTUE9eQpDT05GSUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RFUz15CiMg
Q09ORklHX05VTUFfRU1VIGlzIG5vdCBzZXQKQ09ORklHX05PREVTX1NISUZUPTYKQ09ORklH
X0FSQ0hfU1BBUlNFTUVNX0VOQUJMRT15CkNPTkZJR19BUkNIX1NQQVJTRU1FTV9ERUZBVUxU
PXkKQ09ORklHX0FSQ0hfU0VMRUNUX01FTU9SWV9NT0RFTD15CkNPTkZJR19BUkNIX1BST0Nf
S0NPUkVfVEVYVD15CkNPTkZJR19JTExFR0FMX1BPSU5URVJfVkFMVUU9MHhkZWFkMDAwMDAw
MDAwMDAwCkNPTkZJR19TRUxFQ1RfTUVNT1JZX01PREVMPXkKQ09ORklHX1NQQVJTRU1FTV9N
QU5VQUw9eQpDT05GSUdfU1BBUlNFTUVNPXkKQ09ORklHX05FRURfTVVMVElQTEVfTk9ERVM9
eQpDT05GSUdfSEFWRV9NRU1PUllfUFJFU0VOVD15CkNPTkZJR19TUEFSU0VNRU1fRVhUUkVN
RT15CkNPTkZJR19TUEFSU0VNRU1fVk1FTU1BUF9FTkFCTEU9eQpDT05GSUdfU1BBUlNFTUVN
X0FMTE9DX01FTV9NQVBfVE9HRVRIRVI9eQpDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVA9eQpD
T05GSUdfSEFWRV9NRU1CTE9DSz15CkNPTkZJR19IQVZFX01FTUJMT0NLX05PREVfTUFQPXkK
Q09ORklHX0hBVkVfR0VORVJJQ19HVVA9eQpDT05GSUdfQVJDSF9ESVNDQVJEX01FTUJMT0NL
PXkKIyBDT05GSUdfTUVNT1JZX0hPVFBMVUcgaXMgbm90IHNldApDT05GSUdfU1BMSVRfUFRM
T0NLX0NQVVM9NApDT05GSUdfQVJDSF9FTkFCTEVfU1BMSVRfUE1EX1BUTE9DSz15CkNPTkZJ
R19DT01QQUNUSU9OPXkKQ09ORklHX01JR1JBVElPTj15CkNPTkZJR19BUkNIX0VOQUJMRV9I
VUdFUEFHRV9NSUdSQVRJT049eQpDT05GSUdfUEhZU19BRERSX1RfNjRCSVQ9eQpDT05GSUdf
Qk9VTkNFPXkKQ09ORklHX1ZJUlRfVE9fQlVTPXkKQ09ORklHX01NVV9OT1RJRklFUj15CiMg
Q09ORklHX0tTTSBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX01NQVBfTUlOX0FERFI9NDA5
NgpDT05GSUdfQVJDSF9TVVBQT1JUU19NRU1PUllfRkFJTFVSRT15CiMgQ09ORklHX01FTU9S
WV9GQUlMVVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UgaXMg
bm90IHNldApDT05GSUdfQVJDSF9XQU5UU19USFBfU1dBUD15CiMgQ09ORklHX0NMRUFOQ0FD
SEUgaXMgbm90IHNldAojIENPTkZJR19GUk9OVFNXQVAgaXMgbm90IHNldAojIENPTkZJR19D
TUEgaXMgbm90IHNldAojIENPTkZJR19aUE9PTCBpcyBub3Qgc2V0CiMgQ09ORklHX1pCVUQg
aXMgbm90IHNldAojIENPTkZJR19aU01BTExPQyBpcyBub3Qgc2V0CkNPTkZJR19HRU5FUklD
X0VBUkxZX0lPUkVNQVA9eQojIENPTkZJR19ERUZFUlJFRF9TVFJVQ1RfUEFHRV9JTklUIGlz
IG5vdCBzZXQKIyBDT05GSUdfSURMRV9QQUdFX1RSQUNLSU5HIGlzIG5vdCBzZXQKQ09ORklH
X0FSQ0hfSEFTX1pPTkVfREVWSUNFPXkKQ09ORklHX0FSQ0hfVVNFU19ISUdIX1ZNQV9GTEFH
Uz15CkNPTkZJR19BUkNIX0hBU19QS0VZUz15CiMgQ09ORklHX1BFUkNQVV9TVEFUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0dVUF9CRU5DSE1BUksgaXMgbm90IHNldAojIENPTkZJR19YODZf
UE1FTV9MRUdBQ1kgaXMgbm90IHNldApDT05GSUdfWDg2X0NIRUNLX0JJT1NfQ09SUlVQVElP
Tj15CkNPTkZJR19YODZfQk9PVFBBUkFNX01FTU9SWV9DT1JSVVBUSU9OX0NIRUNLPXkKQ09O
RklHX1g4Nl9SRVNFUlZFX0xPVz02NApDT05GSUdfTVRSUj15CiMgQ09ORklHX01UUlJfU0FO
SVRJWkVSIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9QQVQ9eQpDT05GSUdfQVJDSF9VU0VTX1BH
X1VOQ0FDSEVEPXkKQ09ORklHX0FSQ0hfUkFORE9NPXkKQ09ORklHX1g4Nl9TTUFQPXkKQ09O
RklHX1g4Nl9JTlRFTF9VTUlQPXkKIyBDT05GSUdfWDg2X0lOVEVMX01QWCBpcyBub3Qgc2V0
CkNPTkZJR19YODZfSU5URUxfTUVNT1JZX1BST1RFQ1RJT05fS0VZUz15CkNPTkZJR19FRkk9
eQojIENPTkZJR19FRklfU1RVQiBpcyBub3Qgc2V0CkNPTkZJR19TRUNDT01QPXkKIyBDT05G
SUdfSFpfMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpfMjUwIGlzIG5vdCBzZXQKIyBDT05G
SUdfSFpfMzAwIGlzIG5vdCBzZXQKQ09ORklHX0haXzEwMDA9eQpDT05GSUdfSFo9MTAwMApD
T05GSUdfU0NIRURfSFJUSUNLPXkKQ09ORklHX0tFWEVDPXkKIyBDT05GSUdfS0VYRUNfRklM
RSBpcyBub3Qgc2V0CkNPTkZJR19DUkFTSF9EVU1QPXkKIyBDT05GSUdfS0VYRUNfSlVNUCBp
cyBub3Qgc2V0CkNPTkZJR19QSFlTSUNBTF9TVEFSVD0weDEwMDAwMDAKQ09ORklHX1JFTE9D
QVRBQkxFPXkKQ09ORklHX1JBTkRPTUlaRV9CQVNFPXkKQ09ORklHX1g4Nl9ORUVEX1JFTE9D
Uz15CkNPTkZJR19QSFlTSUNBTF9BTElHTj0weDIwMDAwMApDT05GSUdfRFlOQU1JQ19NRU1P
UllfTEFZT1VUPXkKQ09ORklHX1JBTkRPTUlaRV9NRU1PUlk9eQpDT05GSUdfUkFORE9NSVpF
X01FTU9SWV9QSFlTSUNBTF9QQURESU5HPTB4MApDT05GSUdfSE9UUExVR19DUFU9eQojIENP
TkZJR19CT09UUEFSQU1fSE9UUExVR19DUFUwIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
SE9UUExVR19DUFUwIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NUEFUX1ZEU08gaXMgbm90IHNl
dApDT05GSUdfTEVHQUNZX1ZTWVNDQUxMX0VNVUxBVEU9eQojIENPTkZJR19MRUdBQ1lfVlNZ
U0NBTExfTk9ORSBpcyBub3Qgc2V0CiMgQ09ORklHX0NNRExJTkVfQk9PTCBpcyBub3Qgc2V0
CkNPTkZJR19NT0RJRllfTERUX1NZU0NBTEw9eQpDT05GSUdfSEFWRV9MSVZFUEFUQ0g9eQpD
T05GSUdfQVJDSF9IQVNfQUREX1BBR0VTPXkKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9I
T1RQTFVHPXkKQ09ORklHX1VTRV9QRVJDUFVfTlVNQV9OT0RFX0lEPXkKCiMKIyBQb3dlciBt
YW5hZ2VtZW50IGFuZCBBQ1BJIG9wdGlvbnMKIwpDT05GSUdfQVJDSF9ISUJFUk5BVElPTl9I
RUFERVI9eQpDT05GSUdfU1VTUEVORD15CkNPTkZJR19TVVNQRU5EX0ZSRUVaRVI9eQpDT05G
SUdfSElCRVJOQVRFX0NBTExCQUNLUz15CkNPTkZJR19ISUJFUk5BVElPTj15CkNPTkZJR19Q
TV9TVERfUEFSVElUSU9OPSIiCkNPTkZJR19QTV9TTEVFUD15CkNPTkZJR19QTV9TTEVFUF9T
TVA9eQojIENPTkZJR19QTV9BVVRPU0xFRVAgaXMgbm90IHNldAojIENPTkZJR19QTV9XQUtF
TE9DS1MgaXMgbm90IHNldApDT05GSUdfUE09eQpDT05GSUdfUE1fREVCVUc9eQojIENPTkZJ
R19QTV9BRFZBTkNFRF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1BNX1RFU1RfU1VTUEVO
RCBpcyBub3Qgc2V0CkNPTkZJR19QTV9TTEVFUF9ERUJVRz15CkNPTkZJR19QTV9UUkFDRT15
CkNPTkZJR19QTV9UUkFDRV9SVEM9eQpDT05GSUdfUE1fQ0xLPXkKIyBDT05GSUdfV1FfUE9X
RVJfRUZGSUNJRU5UX0RFRkFVTFQgaXMgbm90IHNldApDT05GSUdfQUNQST15CkNPTkZJR19B
Q1BJX0xFR0FDWV9UQUJMRVNfTE9PS1VQPXkKQ09ORklHX0FSQ0hfTUlHSFRfSEFWRV9BQ1BJ
X1BEQz15CkNPTkZJR19BQ1BJX1NZU1RFTV9QT1dFUl9TVEFURVNfU1VQUE9SVD15CiMgQ09O
RklHX0FDUElfREVCVUdHRVIgaXMgbm90IHNldApDT05GSUdfQUNQSV9TUENSX1RBQkxFPXkK
Q09ORklHX0FDUElfTFBJVD15CkNPTkZJR19BQ1BJX1NMRUVQPXkKIyBDT05GSUdfQUNQSV9Q
Uk9DRlNfUE9XRVIgaXMgbm90IHNldApDT05GSUdfQUNQSV9SRVZfT1ZFUlJJREVfUE9TU0lC
TEU9eQojIENPTkZJR19BQ1BJX0VDX0RFQlVHRlMgaXMgbm90IHNldApDT05GSUdfQUNQSV9B
Qz15CkNPTkZJR19BQ1BJX0JBVFRFUlk9eQpDT05GSUdfQUNQSV9CVVRUT049eQpDT05GSUdf
QUNQSV9WSURFTz15CkNPTkZJR19BQ1BJX0ZBTj15CiMgQ09ORklHX0FDUElfVEFEIGlzIG5v
dCBzZXQKQ09ORklHX0FDUElfRE9DSz15CkNPTkZJR19BQ1BJX0NQVV9GUkVRX1BTUz15CkNP
TkZJR19BQ1BJX1BST0NFU1NPUl9DU1RBVEU9eQpDT05GSUdfQUNQSV9QUk9DRVNTT1JfSURM
RT15CkNPTkZJR19BQ1BJX0NQUENfTElCPXkKQ09ORklHX0FDUElfUFJPQ0VTU09SPXkKQ09O
RklHX0FDUElfSE9UUExVR19DUFU9eQojIENPTkZJR19BQ1BJX1BST0NFU1NPUl9BR0dSRUdB
VE9SIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfVEhFUk1BTD15CkNPTkZJR19BQ1BJX05VTUE9
eQpDT05GSUdfQVJDSF9IQVNfQUNQSV9UQUJMRV9VUEdSQURFPXkKQ09ORklHX0FDUElfVEFC
TEVfVVBHUkFERT15CiMgQ09ORklHX0FDUElfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19B
Q1BJX1BDSV9TTE9UIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfQ09OVEFJTkVSPXkKQ09ORklH
X0FDUElfSE9UUExVR19JT0FQSUM9eQojIENPTkZJR19BQ1BJX1NCUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FDUElfSEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9DVVNUT01fTUVUSE9E
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9CR1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQ
SV9ORklUIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQUNQSV9BUEVJPXkKQ09ORklHX0hBVkVf
QUNQSV9BUEVJX05NST15CiMgQ09ORklHX0FDUElfQVBFSSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RQVEZfUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX0VYVExPRyBpcyBub3Qgc2V0
CiMgQ09ORklHX1BNSUNfT1BSRUdJT04gaXMgbm90IHNldAojIENPTkZJR19BQ1BJX0NPTkZJ
R0ZTIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9QTV9USU1FUj15CiMgQ09ORklHX1NGSSBpcyBu
b3Qgc2V0CgojCiMgQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nCiMKQ09ORklHX0NQVV9GUkVRPXkK
Q09ORklHX0NQVV9GUkVRX0dPVl9BVFRSX1NFVD15CkNPTkZJR19DUFVfRlJFUV9HT1ZfQ09N
TU9OPXkKIyBDT05GSUdfQ1BVX0ZSRVFfU1RBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9G
UkVRX0RFRkFVTFRfR09WX1BFUkZPUk1BTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0ZS
RVFfREVGQVVMVF9HT1ZfUE9XRVJTQVZFIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVRX0RF
RkFVTFRfR09WX1VTRVJTUEFDRT15CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX09O
REVNQU5EIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfQ09OU0VS
VkFUSVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfU0NIRURV
VElMIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVRX0dPVl9QRVJGT1JNQU5DRT15CiMgQ09O
RklHX0NQVV9GUkVRX0dPVl9QT1dFUlNBVkUgaXMgbm90IHNldApDT05GSUdfQ1BVX0ZSRVFf
R09WX1VTRVJTUEFDRT15CkNPTkZJR19DUFVfRlJFUV9HT1ZfT05ERU1BTkQ9eQojIENPTkZJ
R19DUFVfRlJFUV9HT1ZfQ09OU0VSVkFUSVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0ZS
RVFfR09WX1NDSEVEVVRJTCBpcyBub3Qgc2V0CgojCiMgQ1BVIGZyZXF1ZW5jeSBzY2FsaW5n
IGRyaXZlcnMKIwpDT05GSUdfWDg2X0lOVEVMX1BTVEFURT15CiMgQ09ORklHX1g4Nl9QQ0Nf
Q1BVRlJFUSBpcyBub3Qgc2V0CkNPTkZJR19YODZfQUNQSV9DUFVGUkVRPXkKQ09ORklHX1g4
Nl9BQ1BJX0NQVUZSRVFfQ1BCPXkKIyBDT05GSUdfWDg2X1BPV0VSTk9XX0s4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfWDg2X0FNRF9GUkVRX1NFTlNJVElWSVRZIGlzIG5vdCBzZXQKIyBDT05G
SUdfWDg2X1NQRUVEU1RFUF9DRU5UUklOTyBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9QNF9D
TE9DS01PRCBpcyBub3Qgc2V0CgojCiMgc2hhcmVkIG9wdGlvbnMKIwoKIwojIENQVSBJZGxl
CiMKQ09ORklHX0NQVV9JRExFPXkKIyBDT05GSUdfQ1BVX0lETEVfR09WX0xBRERFUiBpcyBu
b3Qgc2V0CkNPTkZJR19DUFVfSURMRV9HT1ZfTUVOVT15CiMgQ09ORklHX0lOVEVMX0lETEUg
aXMgbm90IHNldAoKIwojIEJ1cyBvcHRpb25zIChQQ0kgZXRjLikKIwpDT05GSUdfUENJPXkK
Q09ORklHX1BDSV9ESVJFQ1Q9eQpDT05GSUdfUENJX01NQ09ORklHPXkKQ09ORklHX1BDSV9E
T01BSU5TPXkKQ09ORklHX01NQ09ORl9GQU0xMEg9eQpDT05GSUdfUENJRVBPUlRCVVM9eQoj
IENPTkZJR19IT1RQTFVHX1BDSV9QQ0lFIGlzIG5vdCBzZXQKQ09ORklHX1BDSUVBRVI9eQoj
IENPTkZJR19QQ0lFX0VDUkMgaXMgbm90IHNldAojIENPTkZJR19QQ0lFQUVSX0lOSkVDVCBp
cyBub3Qgc2V0CkNPTkZJR19QQ0lFQVNQTT15CiMgQ09ORklHX1BDSUVBU1BNX0RFQlVHIGlz
IG5vdCBzZXQKQ09ORklHX1BDSUVBU1BNX0RFRkFVTFQ9eQojIENPTkZJR19QQ0lFQVNQTV9Q
T1dFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19QQ0lFQVNQTV9QT1dFUl9TVVBFUlNBVkUg
aXMgbm90IHNldAojIENPTkZJR19QQ0lFQVNQTV9QRVJGT1JNQU5DRSBpcyBub3Qgc2V0CkNP
TkZJR19QQ0lFX1BNRT15CiMgQ09ORklHX1BDSUVfRFBDIGlzIG5vdCBzZXQKIyBDT05GSUdf
UENJRV9QVE0gaXMgbm90IHNldApDT05GSUdfUENJX0JVU19BRERSX1RfNjRCSVQ9eQpDT05G
SUdfUENJX01TST15CkNPTkZJR19QQ0lfTVNJX0lSUV9ET01BSU49eQpDT05GSUdfUENJX1FV
SVJLUz15CiMgQ09ORklHX1BDSV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9TVFVC
IGlzIG5vdCBzZXQKQ09ORklHX1BDSV9BVFM9eQpDT05GSUdfUENJX0xPQ0tMRVNTX0NPTkZJ
Rz15CiMgQ09ORklHX1BDSV9JT1YgaXMgbm90IHNldApDT05GSUdfUENJX1BSST15CkNPTkZJ
R19QQ0lfUEFTSUQ9eQpDT05GSUdfUENJX0xBQkVMPXkKQ09ORklHX0hPVFBMVUdfUENJPXkK
IyBDT05GSUdfSE9UUExVR19QQ0lfQUNQSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hPVFBMVUdf
UENJX0NQQ0kgaXMgbm90IHNldAojIENPTkZJR19IT1RQTFVHX1BDSV9TSFBDIGlzIG5vdCBz
ZXQKCiMKIyBDYWRlbmNlIFBDSWUgY29udHJvbGxlcnMgc3VwcG9ydAojCgojCiMgRGVzaWdu
V2FyZSBQQ0kgQ29yZSBTdXBwb3J0CiMKIyBDT05GSUdfUENJRV9EV19QTEFUIGlzIG5vdCBz
ZXQKCiMKIyBQQ0kgaG9zdCBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJR19WTUQgaXMg
bm90IHNldAoKIwojIFBDSSBFbmRwb2ludAojCiMgQ09ORklHX1BDSV9FTkRQT0lOVCBpcyBu
b3Qgc2V0CgojCiMgUENJIHN3aXRjaCBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJR19Q
Q0lfU1dfU1dJVENIVEVDIGlzIG5vdCBzZXQKQ09ORklHX0lTQV9ETUFfQVBJPXkKQ09ORklH
X0FNRF9OQj15CkNPTkZJR19QQ0NBUkQ9eQpDT05GSUdfUENNQ0lBPXkKQ09ORklHX1BDTUNJ
QV9MT0FEX0NJUz15CkNPTkZJR19DQVJEQlVTPXkKCiMKIyBQQy1jYXJkIGJyaWRnZXMKIwpD
T05GSUdfWUVOVEE9eQpDT05GSUdfWUVOVEFfTzI9eQpDT05GSUdfWUVOVEFfUklDT0g9eQpD
T05GSUdfWUVOVEFfVEk9eQpDT05GSUdfWUVOVEFfRU5FX1RVTkU9eQpDT05GSUdfWUVOVEFf
VE9TSElCQT15CiMgQ09ORklHX1BENjcyOSBpcyBub3Qgc2V0CiMgQ09ORklHX0k4MjA5MiBp
cyBub3Qgc2V0CkNPTkZJR19QQ0NBUkRfTk9OU1RBVElDPXkKIyBDT05GSUdfUkFQSURJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9TWVNGQiBpcyBub3Qgc2V0CgojCiMgRXhlY3V0YWJs
ZSBmaWxlIGZvcm1hdHMgLyBFbXVsYXRpb25zCiMKQ09ORklHX0JJTkZNVF9FTEY9eQpDT05G
SUdfQ09NUEFUX0JJTkZNVF9FTEY9eQpDT05GSUdfRUxGQ09SRT15CkNPTkZJR19DT1JFX0RV
TVBfREVGQVVMVF9FTEZfSEVBREVSUz15CkNPTkZJR19CSU5GTVRfU0NSSVBUPXkKQ09ORklH
X0JJTkZNVF9NSVNDPXkKQ09ORklHX0NPUkVEVU1QPXkKQ09ORklHX0lBMzJfRU1VTEFUSU9O
PXkKIyBDT05GSUdfSUEzMl9BT1VUIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1gzMiBpcyBu
b3Qgc2V0CkNPTkZJR19DT01QQVRfMzI9eQpDT05GSUdfQ09NUEFUPXkKQ09ORklHX0NPTVBB
VF9GT1JfVTY0X0FMSUdOTUVOVD15CkNPTkZJR19TWVNWSVBDX0NPTVBBVD15CkNPTkZJR19Y
ODZfREVWX0RNQV9PUFM9eQpDT05GSUdfTkVUPXkKQ09ORklHX05FVF9JTkdSRVNTPXkKCiMK
IyBOZXR3b3JraW5nIG9wdGlvbnMKIwpDT05GSUdfUEFDS0VUPXkKIyBDT05GSUdfUEFDS0VU
X0RJQUcgaXMgbm90IHNldApDT05GSUdfVU5JWD15CiMgQ09ORklHX1VOSVhfRElBRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RMUyBpcyBub3Qgc2V0CkNPTkZJR19YRlJNPXkKQ09ORklHX1hG
Uk1fQUxHTz15CkNPTkZJR19YRlJNX1VTRVI9eQojIENPTkZJR19YRlJNX1NVQl9QT0xJQ1kg
aXMgbm90IHNldAojIENPTkZJR19YRlJNX01JR1JBVEUgaXMgbm90IHNldAojIENPTkZJR19Y
RlJNX1NUQVRJU1RJQ1MgaXMgbm90IHNldAojIENPTkZJR19ORVRfS0VZIGlzIG5vdCBzZXQK
Q09ORklHX0lORVQ9eQpDT05GSUdfSVBfTVVMVElDQVNUPXkKQ09ORklHX0lQX0FEVkFOQ0VE
X1JPVVRFUj15CiMgQ09ORklHX0lQX0ZJQl9UUklFX1NUQVRTIGlzIG5vdCBzZXQKQ09ORklH
X0lQX01VTFRJUExFX1RBQkxFUz15CkNPTkZJR19JUF9ST1VURV9NVUxUSVBBVEg9eQpDT05G
SUdfSVBfUk9VVEVfVkVSQk9TRT15CkNPTkZJR19JUF9QTlA9eQpDT05GSUdfSVBfUE5QX0RI
Q1A9eQpDT05GSUdfSVBfUE5QX0JPT1RQPXkKQ09ORklHX0lQX1BOUF9SQVJQPXkKIyBDT05G
SUdfTkVUX0lQSVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBHUkVfREVNVVggaXMgbm90
IHNldApDT05GSUdfTkVUX0lQX1RVTk5FTD15CkNPTkZJR19JUF9NUk9VVEVfQ09NTU9OPXkK
Q09ORklHX0lQX01ST1VURT15CiMgQ09ORklHX0lQX01ST1VURV9NVUxUSVBMRV9UQUJMRVMg
aXMgbm90IHNldApDT05GSUdfSVBfUElNU01fVjE9eQpDT05GSUdfSVBfUElNU01fVjI9eQpD
T05GSUdfU1lOX0NPT0tJRVM9eQojIENPTkZJR19ORVRfRk9VIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX0ZPVV9JUF9UVU5ORUxTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9BSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9JUENP
TVAgaXMgbm90IHNldApDT05GSUdfSU5FVF9UVU5ORUw9eQojIENPTkZJR19JTkVUX1hGUk1f
TU9ERV9UUkFOU1BPUlQgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1hGUk1fTU9ERV9UVU5O
RUwgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1hGUk1fTU9ERV9CRUVUIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5FVF9ESUFHIGlzIG5vdCBzZXQKQ09ORklHX1RDUF9DT05HX0FEVkFOQ0VE
PXkKIyBDT05GSUdfVENQX0NPTkdfQklDIGlzIG5vdCBzZXQKQ09ORklHX1RDUF9DT05HX0NV
QklDPXkKIyBDT05GSUdfVENQX0NPTkdfV0VTVFdPT0QgaXMgbm90IHNldAojIENPTkZJR19U
Q1BfQ09OR19IVENQIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfSFNUQ1AgaXMgbm90
IHNldAojIENPTkZJR19UQ1BfQ09OR19IWUJMQSBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9D
T05HX1ZFR0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfTlYgaXMgbm90IHNldAoj
IENPTkZJR19UQ1BfQ09OR19TQ0FMQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05H
X0xQIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfVkVOTyBpcyBub3Qgc2V0CiMgQ09O
RklHX1RDUF9DT05HX1lFQUggaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19JTExJTk9J
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0RDVENQIGlzIG5vdCBzZXQKIyBDT05G
SUdfVENQX0NPTkdfQ0RHIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfQkJSIGlzIG5v
dCBzZXQKQ09ORklHX0RFRkFVTFRfQ1VCSUM9eQojIENPTkZJR19ERUZBVUxUX1JFTk8gaXMg
bm90IHNldApDT05GSUdfREVGQVVMVF9UQ1BfQ09ORz0iY3ViaWMiCkNPTkZJR19UQ1BfTUQ1
U0lHPXkKQ09ORklHX0lQVjY9eQojIENPTkZJR19JUFY2X1JPVVRFUl9QUkVGIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBWNl9PUFRJTUlTVElDX0RBRCBpcyBub3Qgc2V0CkNPTkZJR19JTkVU
Nl9BSD15CkNPTkZJR19JTkVUNl9FU1A9eQojIENPTkZJR19JTkVUNl9FU1BfT0ZGTE9BRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X0lQQ09NUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQ
VjZfTUlQNiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfSUxBIGlzIG5vdCBzZXQKQ09ORklH
X0lORVQ2X1hGUk1fTU9ERV9UUkFOU1BPUlQ9eQpDT05GSUdfSU5FVDZfWEZSTV9NT0RFX1RV
Tk5FTD15CkNPTkZJR19JTkVUNl9YRlJNX01PREVfQkVFVD15CiMgQ09ORklHX0lORVQ2X1hG
Uk1fTU9ERV9ST1VURU9QVElNSVpBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfVlRJ
IGlzIG5vdCBzZXQKQ09ORklHX0lQVjZfU0lUPXkKIyBDT05GSUdfSVBWNl9TSVRfNlJEIGlz
IG5vdCBzZXQKQ09ORklHX0lQVjZfTkRJU0NfTk9ERVRZUEU9eQojIENPTkZJR19JUFY2X1RV
Tk5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfTVVMVElQTEVfVEFCTEVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBWNl9NUk9VVEUgaXMgbm90IHNldAojIENPTkZJR19JUFY2X1NFRzZf
TFdUVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19JUFY2X1NFRzZfSE1BQyBpcyBub3Qgc2V0
CkNPTkZJR19ORVRMQUJFTD15CkNPTkZJR19ORVRXT1JLX1NFQ01BUks9eQpDT05GSUdfTkVU
X1BUUF9DTEFTU0lGWT15CiMgQ09ORklHX05FVFdPUktfUEhZX1RJTUVTVEFNUElORyBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRGSUxURVI9eQojIENPTkZJR19ORVRGSUxURVJfQURWQU5DRUQg
aXMgbm90IHNldAoKIwojIENvcmUgTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdf
TkVURklMVEVSX0lOR1JFU1M9eQpDT05GSUdfTkVURklMVEVSX05FVExJTks9eQpDT05GSUdf
TkVURklMVEVSX05FVExJTktfTE9HPXkKQ09ORklHX05GX0NPTk5UUkFDSz15CkNPTkZJR19O
Rl9MT0dfQ09NTU9OPW0KIyBDT05GSUdfTkZfTE9HX05FVERFViBpcyBub3Qgc2V0CkNPTkZJ
R19ORl9DT05OVFJBQ0tfU0VDTUFSSz15CkNPTkZJR19ORl9DT05OVFJBQ0tfUFJPQ0ZTPXkK
Q09ORklHX05GX0NPTk5UUkFDS19GVFA9eQpDT05GSUdfTkZfQ09OTlRSQUNLX0lSQz15CiMg
Q09ORklHX05GX0NPTk5UUkFDS19ORVRCSU9TX05TIGlzIG5vdCBzZXQKQ09ORklHX05GX0NP
Tk5UUkFDS19TSVA9eQpDT05GSUdfTkZfQ1RfTkVUTElOSz15CiMgQ09ORklHX05FVEZJTFRF
Ul9ORVRMSU5LX0dMVUVfQ1QgaXMgbm90IHNldApDT05GSUdfTkZfTkFUPW0KQ09ORklHX05G
X05BVF9ORUVERUQ9eQpDT05GSUdfTkZfTkFUX0ZUUD1tCkNPTkZJR19ORl9OQVRfSVJDPW0K
Q09ORklHX05GX05BVF9TSVA9bQojIENPTkZJR19ORl9OQVRfUkVESVJFQ1QgaXMgbm90IHNl
dAojIENPTkZJR19ORl9UQUJMRVMgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUQUJM
RVM9eQoKIwojIFh0YWJsZXMgY29tYmluZWQgbW9kdWxlcwojCkNPTkZJR19ORVRGSUxURVJf
WFRfTUFSSz1tCgojCiMgWHRhYmxlcyB0YXJnZXRzCiMKQ09ORklHX05FVEZJTFRFUl9YVF9U
QVJHRVRfQ09OTlNFQ01BUks9eQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9MT0c9bQpD
T05GSUdfTkVURklMVEVSX1hUX05BVD1tCiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRf
TkVUTUFQIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTkZMT0c9eQoj
IENPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX1JFRElSRUNUIGlzIG5vdCBzZXQKQ09ORklH
X05FVEZJTFRFUl9YVF9UQVJHRVRfU0VDTUFSSz15CkNPTkZJR19ORVRGSUxURVJfWFRfVEFS
R0VUX1RDUE1TUz15CgojCiMgWHRhYmxlcyBtYXRjaGVzCiMKQ09ORklHX05FVEZJTFRFUl9Y
VF9NQVRDSF9BRERSVFlQRT1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ09OTlRSQUNL
PXkKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9QT0xJQ1k9eQpDT05GSUdfTkVURklMVEVS
X1hUX01BVENIX1NUQVRFPXkKIyBDT05GSUdfSVBfU0VUIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBfVlMgaXMgbm90IHNldAoKIwojIElQOiBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCkNP
TkZJR19ORl9ERUZSQUdfSVBWND15CkNPTkZJR19ORl9DT05OVFJBQ0tfSVBWND15CiMgQ09O
RklHX05GX1NPQ0tFVF9JUFY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfRFVQX0lQVjQgaXMg
bm90IHNldApDT05GSUdfTkZfTE9HX0FSUD1tCkNPTkZJR19ORl9MT0dfSVBWND1tCkNPTkZJ
R19ORl9SRUpFQ1RfSVBWND15CkNPTkZJR19ORl9OQVRfSVBWND1tCkNPTkZJR19ORl9OQVRf
TUFTUVVFUkFERV9JUFY0PW0KQ09ORklHX0lQX05GX0lQVEFCTEVTPXkKQ09ORklHX0lQX05G
X0ZJTFRFUj15CkNPTkZJR19JUF9ORl9UQVJHRVRfUkVKRUNUPXkKQ09ORklHX0lQX05GX05B
VD1tCkNPTkZJR19JUF9ORl9UQVJHRVRfTUFTUVVFUkFERT1tCkNPTkZJR19JUF9ORl9NQU5H
TEU9eQojIENPTkZJR19JUF9ORl9SQVcgaXMgbm90IHNldAoKIwojIElQdjY6IE5ldGZpbHRl
ciBDb25maWd1cmF0aW9uCiMKQ09ORklHX05GX0RFRlJBR19JUFY2PXkKQ09ORklHX05GX0NP
Tk5UUkFDS19JUFY2PXkKIyBDT05GSUdfTkZfU09DS0VUX0lQVjYgaXMgbm90IHNldAojIENP
TkZJR19ORl9EVVBfSVBWNiBpcyBub3Qgc2V0CkNPTkZJR19ORl9SRUpFQ1RfSVBWNj15CkNP
TkZJR19ORl9MT0dfSVBWNj1tCkNPTkZJR19JUDZfTkZfSVBUQUJMRVM9eQpDT05GSUdfSVA2
X05GX01BVENIX0lQVjZIRUFERVI9eQpDT05GSUdfSVA2X05GX0ZJTFRFUj15CkNPTkZJR19J
UDZfTkZfVEFSR0VUX1JFSkVDVD15CkNPTkZJR19JUDZfTkZfTUFOR0xFPXkKIyBDT05GSUdf
SVA2X05GX1JBVyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX0RDQ1AgaXMgbm90IHNldAojIENP
TkZJR19JUF9TQ1RQIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRTIGlzIG5vdCBzZXQKIyBDT05G
SUdfVElQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0CiMgQ09ORklHX0wy
VFAgaXMgbm90IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldApDT05GSUdfSEFWRV9O
RVRfRFNBPXkKIyBDT05GSUdfTkVUX0RTQSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZMQU5fODAy
MVEgaXMgbm90IHNldAojIENPTkZJR19ERUNORVQgaXMgbm90IHNldAojIENPTkZJR19MTEMy
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBTEsgaXMgbm90IHNldAojIENPTkZJR19YMjUgaXMg
bm90IHNldAojIENPTkZJR19MQVBCIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhPTkVUIGlzIG5v
dCBzZXQKIyBDT05GSUdfNkxPV1BBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lFRUU4MDIxNTQg
aXMgbm90IHNldApDT05GSUdfTkVUX1NDSEVEPXkKCiMKIyBRdWV1ZWluZy9TY2hlZHVsaW5n
CiMKIyBDT05GSUdfTkVUX1NDSF9DQlEgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0hU
QiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfSEZTQyBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9TQ0hfUFJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfTVVMVElRIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1NDSF9SRUQgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NI
X1NGQiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfU0ZRIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1NDSF9URVFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9UQkYgaXMgbm90
IHNldAojIENPTkZJR19ORVRfU0NIX0NCUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hf
R1JFRCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRFNNQVJLIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1NDSF9ORVRFTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRFJSIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9NUVBSSU8gaXMgbm90IHNldAojIENPTkZJR19O
RVRfU0NIX0NIT0tFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9RRlEgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfU0NIX0NPREVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9G
UV9DT0RFTCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRlEgaXMgbm90IHNldAojIENP
TkZJR19ORVRfU0NIX0hIRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfUElFIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1NDSF9JTkdSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1NDSF9QTFVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9ERUZBVUxUIGlzIG5vdCBz
ZXQKCiMKIyBDbGFzc2lmaWNhdGlvbgojCkNPTkZJR19ORVRfQ0xTPXkKIyBDT05GSUdfTkVU
X0NMU19CQVNJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfVENJTkRFWCBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9DTFNfUk9VVEU0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NM
U19GVyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfVTMyIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX0NMU19SU1ZQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19SU1ZQNiBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfRkxPVyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9D
TFNfQ0dST1VQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19CUEYgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfQ0xTX0ZMT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfTUFU
Q0hBTEwgaXMgbm90IHNldApDT05GSUdfTkVUX0VNQVRDSD15CkNPTkZJR19ORVRfRU1BVENI
X1NUQUNLPTMyCiMgQ09ORklHX05FVF9FTUFUQ0hfQ01QIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0VNQVRDSF9OQllURSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9FTUFUQ0hfVTMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0VNQVRDSF9NRVRBIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0VNQVRDSF9URVhUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0VNQVRDSF9JUFQgaXMg
bm90IHNldApDT05GSUdfTkVUX0NMU19BQ1Q9eQojIENPTkZJR19ORVRfQUNUX1BPTElDRSBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfR0FDVCBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9BQ1RfTUlSUkVEIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9TQU1QTEUgaXMgbm90
IHNldAojIENPTkZJR19ORVRfQUNUX0lQVCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1Rf
TkFUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9QRURJVCBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9BQ1RfU0lNUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfU0tCRURJVCBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfQ1NVTSBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9BQ1RfVkxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfQlBGIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX0FDVF9TS0JNT0QgaXMgbm90IHNldAojIENPTkZJR19ORVRfQUNUX0lG
RSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfVFVOTkVMX0tFWSBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfU0NIX0ZJRk89eQojIENPTkZJR19EQ0IgaXMgbm90IHNldApDT05GSUdfRE5T
X1JFU09MVkVSPXkKIyBDT05GSUdfQkFUTUFOX0FEViBpcyBub3Qgc2V0CiMgQ09ORklHX09Q
RU5WU1dJVENIIGlzIG5vdCBzZXQKIyBDT05GSUdfVlNPQ0tFVFMgaXMgbm90IHNldAojIENP
TkZJR19ORVRMSU5LX0RJQUcgaXMgbm90IHNldAojIENPTkZJR19NUExTIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX05TSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hTUiBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9TV0lUQ0hERVYgaXMgbm90IHNldAojIENPTkZJR19ORVRfTDNfTUFTVEVS
X0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9OQ1NJIGlzIG5vdCBzZXQKQ09ORklHX1JQ
Uz15CkNPTkZJR19SRlNfQUNDRUw9eQpDT05GSUdfWFBTPXkKIyBDT05GSUdfQ0dST1VQX05F
VF9QUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0dST1VQX05FVF9DTEFTU0lEIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9SWF9CVVNZX1BPTEw9eQpDT05GSUdfQlFMPXkKIyBDT05GSUdfQlBG
X0pJVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfRkxPV19MSU1JVD15CgojCiMgTmV0d29yayB0
ZXN0aW5nCiMKIyBDT05GSUdfTkVUX1BLVEdFTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9E
Uk9QX01PTklUT1IgaXMgbm90IHNldApDT05GSUdfSEFNUkFESU89eQoKIwojIFBhY2tldCBS
YWRpbyBwcm90b2NvbHMKIwojIENPTkZJR19BWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FO
IGlzIG5vdCBzZXQKIyBDT05GSUdfQlQgaXMgbm90IHNldAojIENPTkZJR19BRl9SWFJQQyBp
cyBub3Qgc2V0CiMgQ09ORklHX0FGX0tDTSBpcyBub3Qgc2V0CkNPTkZJR19GSUJfUlVMRVM9
eQpDT05GSUdfV0lSRUxFU1M9eQpDT05GSUdfQ0ZHODAyMTE9eQojIENPTkZJR19OTDgwMjEx
X1RFU1RNT0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0ZHODAyMTFfREVWRUxPUEVSX1dBUk5J
TkdTIGlzIG5vdCBzZXQKQ09ORklHX0NGRzgwMjExX1JFUVVJUkVfU0lHTkVEX1JFR0RCPXkK
Q09ORklHX0NGRzgwMjExX1VTRV9LRVJORUxfUkVHREJfS0VZUz15CkNPTkZJR19DRkc4MDIx
MV9ERUZBVUxUX1BTPXkKIyBDT05GSUdfQ0ZHODAyMTFfREVCVUdGUyBpcyBub3Qgc2V0CkNP
TkZJR19DRkc4MDIxMV9DUkRBX1NVUFBPUlQ9eQojIENPTkZJR19DRkc4MDIxMV9XRVhUIGlz
IG5vdCBzZXQKQ09ORklHX01BQzgwMjExPXkKQ09ORklHX01BQzgwMjExX0hBU19SQz15CkNP
TkZJR19NQUM4MDIxMV9SQ19NSU5TVFJFTD15CkNPTkZJR19NQUM4MDIxMV9SQ19NSU5TVFJF
TF9IVD15CkNPTkZJR19NQUM4MDIxMV9SQ19ERUZBVUxUX01JTlNUUkVMPXkKQ09ORklHX01B
QzgwMjExX1JDX0RFRkFVTFQ9Im1pbnN0cmVsX2h0IgojIENPTkZJR19NQUM4MDIxMV9NRVNI
IGlzIG5vdCBzZXQKQ09ORklHX01BQzgwMjExX0xFRFM9eQojIENPTkZJR19NQUM4MDIxMV9E
RUJVR0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTFfTUVTU0FHRV9UUkFDSU5HIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTFfREVCVUdfTUVOVSBpcyBub3Qgc2V0CkNPTkZJ
R19NQUM4MDIxMV9TVEFfSEFTSF9NQVhfU0laRT0wCiMgQ09ORklHX1dJTUFYIGlzIG5vdCBz
ZXQKQ09ORklHX1JGS0lMTD15CkNPTkZJR19SRktJTExfTEVEUz15CkNPTkZJR19SRktJTExf
SU5QVVQ9eQpDT05GSUdfTkVUXzlQPXkKQ09ORklHX05FVF85UF9WSVJUSU89eQojIENPTkZJ
R19ORVRfOVBfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19DQUlGIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0VQSF9MSUIgaXMgbm90IHNldAojIENPTkZJR19ORkMgaXMgbm90IHNldAojIENP
TkZJR19QU0FNUExFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lGRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0xXVFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0RTVF9DQUNIRT15CkNPTkZJR19H
Uk9fQ0VMTFM9eQojIENPTkZJR19ORVRfREVWTElOSyBpcyBub3Qgc2V0CkNPTkZJR19NQVlf
VVNFX0RFVkxJTks9eQpDT05GSUdfSEFWRV9FQlBGX0pJVD15CgojCiMgRGV2aWNlIERyaXZl
cnMKIwoKIwojIEdlbmVyaWMgRHJpdmVyIE9wdGlvbnMKIwpDT05GSUdfVUVWRU5UX0hFTFBF
Uj15CkNPTkZJR19VRVZFTlRfSEVMUEVSX1BBVEg9Ii9zYmluL2hvdHBsdWciCkNPTkZJR19E
RVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19NT1VOVD15CkNPTkZJR19TVEFOREFMT05FPXkK
Q09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQpDT05GSUdfRldfTE9BREVSPXkKQ09O
RklHX0VYVFJBX0ZJUk1XQVJFPSIiCiMgQ09ORklHX0ZXX0xPQURFUl9VU0VSX0hFTFBFUl9G
QUxMQkFDSyBpcyBub3Qgc2V0CkNPTkZJR19BTExPV19ERVZfQ09SRURVTVA9eQojIENPTkZJ
R19ERUJVR19EUklWRVIgaXMgbm90IHNldApDT05GSUdfREVCVUdfREVWUkVTPXkKIyBDT05G
SUdfREVCVUdfVEVTVF9EUklWRVJfUkVNT1ZFIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9B
U1lOQ19EUklWRVJfUFJPQkUgaXMgbm90IHNldApDT05GSUdfR0VORVJJQ19DUFVfQVVUT1BS
T0JFPXkKQ09ORklHX0dFTkVSSUNfQ1BVX1ZVTE5FUkFCSUxJVElFUz15CkNPTkZJR19SRUdN
QVA9eQpDT05GSUdfUkVHTUFQX0kyQz15CkNPTkZJR19ETUFfU0hBUkVEX0JVRkZFUj15CiMg
Q09ORklHX0RNQV9GRU5DRV9UUkFDRSBpcyBub3Qgc2V0CgojCiMgQnVzIGRldmljZXMKIwpD
T05GSUdfQ09OTkVDVE9SPXkKQ09ORklHX1BST0NfRVZFTlRTPXkKIyBDT05GSUdfTVREIGlz
IG5vdCBzZXQKIyBDT05GSUdfT0YgaXMgbm90IHNldApDT05GSUdfQVJDSF9NSUdIVF9IQVZF
X1BDX1BBUlBPUlQ9eQojIENPTkZJR19QQVJQT1JUIGlzIG5vdCBzZXQKQ09ORklHX1BOUD15
CkNPTkZJR19QTlBfREVCVUdfTUVTU0FHRVM9eQoKIwojIFByb3RvY29scwojCkNPTkZJR19Q
TlBBQ1BJPXkKQ09ORklHX0JMS19ERVY9eQojIENPTkZJR19CTEtfREVWX05VTExfQkxLIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9GRCBpcyBub3Qgc2V0CkNPTkZJR19DRFJPTT15
CiMgQ09ORklHX0JMS19ERVZfUENJRVNTRF9NVElQMzJYWCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfREFDOTYwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9VTUVNIGlzIG5v
dCBzZXQKQ09ORklHX0JMS19ERVZfTE9PUD15CkNPTkZJR19CTEtfREVWX0xPT1BfTUlOX0NP
VU5UPTgKIyBDT05GSUdfQkxLX0RFVl9DUllQVE9MT09QIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9EUkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OQkQgaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX1NLRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU1g4
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQU0gaXMgbm90IHNldAojIENPTkZJR19D
RFJPTV9QS1RDRFZEIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBz
ZXQKQ09ORklHX1ZJUlRJT19CTEs9eQojIENPTkZJR19WSVJUSU9fQkxLX1NDU0kgaXMgbm90
IHNldAojIENPTkZJR19CTEtfREVWX1JCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
UlNYWCBpcyBub3Qgc2V0CgojCiMgTlZNRSBTdXBwb3J0CiMKIyBDT05GSUdfQkxLX0RFVl9O
Vk1FIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZNRV9GQyBpcyBub3Qgc2V0CgojCiMgTWlzYyBk
ZXZpY2VzCiMKIyBDT05GSUdfQUQ1MjVYX0RQT1QgaXMgbm90IHNldAojIENPTkZJR19EVU1N
WV9JUlEgaXMgbm90IHNldAojIENPTkZJR19JQk1fQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEhBTlRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NHSV9JT0M0IGlzIG5vdCBzZXQKIyBDT05G
SUdfVElGTV9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSUNTOTMyUzQwMSBpcyBub3Qgc2V0
CiMgQ09ORklHX0VOQ0xPU1VSRV9TRVJWSUNFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQX0lM
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0FQRFM5ODAyQUxTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVNMMjkwMDMgaXMgbm90IHNldAojIENPTkZJR19JU0wyOTAyMCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfVFNMMjU1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQkgxNzcw
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BUERTOTkwWCBpcyBub3Qgc2V0CiMgQ09O
RklHX0hNQzYzNTIgaXMgbm90IHNldAojIENPTkZJR19EUzE2ODIgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU1dJVENIX0ZTQTk0ODAgaXMgbm90IHNldAojIENPTkZJR19TUkFNIGlzIG5v
dCBzZXQKIyBDT05GSUdfUENJX0VORFBPSU5UX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19D
MlBPUlQgaXMgbm90IHNldAoKIwojIEVFUFJPTSBzdXBwb3J0CiMKIyBDT05GSUdfRUVQUk9N
X0FUMjQgaXMgbm90IHNldAojIENPTkZJR19FRVBST01fTEVHQUNZIGlzIG5vdCBzZXQKIyBD
T05GSUdfRUVQUk9NX01BWDY4NzUgaXMgbm90IHNldAojIENPTkZJR19FRVBST01fOTNDWDYg
aXMgbm90IHNldAojIENPTkZJR19FRVBST01fSURUXzg5SFBFU1ggaXMgbm90IHNldAojIENP
TkZJR19DQjcxMF9DT1JFIGlzIG5vdCBzZXQKCiMKIyBUZXhhcyBJbnN0cnVtZW50cyBzaGFy
ZWQgdHJhbnNwb3J0IGxpbmUgZGlzY2lwbGluZQojCiMgQ09ORklHX1NFTlNPUlNfTElTM19J
MkMgaXMgbm90IHNldAojIENPTkZJR19BTFRFUkFfU1RBUEwgaXMgbm90IHNldAojIENPTkZJ
R19JTlRFTF9NRUkgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9NRUlfTUUgaXMgbm90IHNl
dAojIENPTkZJR19JTlRFTF9NRUlfVFhFIGlzIG5vdCBzZXQKIyBDT05GSUdfVk1XQVJFX1ZN
Q0kgaXMgbm90IHNldAoKIwojIEludGVsIE1JQyAmIHJlbGF0ZWQgc3VwcG9ydAojCgojCiMg
SW50ZWwgTUlDIEJ1cyBEcml2ZXIKIwojIENPTkZJR19JTlRFTF9NSUNfQlVTIGlzIG5vdCBz
ZXQKCiMKIyBTQ0lGIEJ1cyBEcml2ZXIKIwojIENPTkZJR19TQ0lGX0JVUyBpcyBub3Qgc2V0
CgojCiMgVk9QIEJ1cyBEcml2ZXIKIwojIENPTkZJR19WT1BfQlVTIGlzIG5vdCBzZXQKCiMK
IyBJbnRlbCBNSUMgSG9zdCBEcml2ZXIKIwoKIwojIEludGVsIE1JQyBDYXJkIERyaXZlcgoj
CgojCiMgU0NJRiBEcml2ZXIKIwoKIwojIEludGVsIE1JQyBDb3Byb2Nlc3NvciBTdGF0ZSBN
YW5hZ2VtZW50IChDT1NNKSBEcml2ZXJzCiMKCiMKIyBWT1AgRHJpdmVyCiMKIyBDT05GSUdf
R0VOV1FFIGlzIG5vdCBzZXQKIyBDT05GSUdfRUNITyBpcyBub3Qgc2V0CiMgQ09ORklHX01J
U0NfUlRTWF9QQ0kgaXMgbm90IHNldAojIENPTkZJR19NSVNDX1JUU1hfVVNCIGlzIG5vdCBz
ZXQKQ09ORklHX0hBVkVfSURFPXkKIyBDT05GSUdfSURFIGlzIG5vdCBzZXQKCiMKIyBTQ1NJ
IGRldmljZSBzdXBwb3J0CiMKQ09ORklHX1NDU0lfTU9EPXkKIyBDT05GSUdfUkFJRF9BVFRS
UyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJPXkKQ09ORklHX1NDU0lfRE1BPXkKIyBDT05GSUdf
U0NTSV9NUV9ERUZBVUxUIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfUFJPQ19GUz15CgojCiMg
U0NTSSBzdXBwb3J0IHR5cGUgKGRpc2ssIHRhcGUsIENELVJPTSkKIwpDT05GSUdfQkxLX0RF
Vl9TRD15CiMgQ09ORklHX0NIUl9ERVZfU1QgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVW
X09TU1QgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9TUj15CkNPTkZJR19CTEtfREVWX1NS
X1ZFTkRPUj15CkNPTkZJR19DSFJfREVWX1NHPXkKIyBDT05GSUdfQ0hSX0RFVl9TQ0ggaXMg
bm90IHNldApDT05GSUdfU0NTSV9DT05TVEFOVFM9eQojIENPTkZJR19TQ1NJX0xPR0dJTkcg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NDQU5fQVNZTkMgaXMgbm90IHNldAoKIwojIFND
U0kgVHJhbnNwb3J0cwojCkNPTkZJR19TQ1NJX1NQSV9BVFRSUz15CiMgQ09ORklHX1NDU0lf
RkNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lTQ1NJX0FUVFJTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9TQVNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NB
U19MSUJTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NSUF9BVFRSUyBpcyBub3Qgc2V0
CkNPTkZJR19TQ1NJX0xPV0xFVkVMPXkKIyBDT05GSUdfSVNDU0lfVENQIGlzIG5vdCBzZXQK
IyBDT05GSUdfSVNDU0lfQk9PVF9TWVNGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ1hH
QjNfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NYR0I0X0lTQ1NJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9CTlgyX0lTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfQkUySVND
U0kgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWXzNXX1hYWFhfUkFJRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfSFBTQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfM1dfOVhYWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfM1dfU0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9BQ0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUFDUkFJRCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfQUlDN1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDNzlYWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDOTRYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfTVZTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01WVU1JIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9EUFRfSTJPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BRFZBTlNZUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQVJDTVNSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9FU0FTMlIgaXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJRF9ORVdHRU4gaXMgbm90IHNl
dAojIENPTkZJR19NRUdBUkFJRF9MRUdBQ1kgaXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJ
RF9TQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01QVDNTQVMgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX01QVDJTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NNQVJUUFFJIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9VRlNIQ0QgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0hQVElPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQlVTTE9HSUMgaXMgbm90IHNldAoj
IENPTkZJR19WTVdBUkVfUFZTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TTklDIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ETVgzMTkxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfR0RUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVNDSSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfSVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JTklUSU8gaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0lOSUExMDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NURVgg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NZTTUzQzhYWF8yIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9JUFIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ18xMjgwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9RTEFfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0RDMzk1eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQU01M0M5NzQgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX1dENzE5WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREVCVUcgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1BNQ1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1BNODAwMSBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1ZJUlRJTz15CiMgQ09ORklHX1NDU0lf
TE9XTEVWRUxfUENNQ0lBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ESCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfT1NEX0lOSVRJQVRPUiBpcyBub3Qgc2V0CkNPTkZJR19BVEE9eQpD
T05GSUdfQVRBX1ZFUkJPU0VfRVJST1I9eQpDT05GSUdfQVRBX0FDUEk9eQojIENPTkZJR19T
QVRBX1pQT0REIGlzIG5vdCBzZXQKQ09ORklHX1NBVEFfUE1QPXkKCiMKIyBDb250cm9sbGVy
cyB3aXRoIG5vbi1TRkYgbmF0aXZlIGludGVyZmFjZQojCkNPTkZJR19TQVRBX0FIQ0k9eQpD
T05GSUdfU0FUQV9NT0JJTEVfTFBNX1BPTElDWT0wCiMgQ09ORklHX1NBVEFfQUhDSV9QTEFU
Rk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfSU5JQzE2MlggaXMgbm90IHNldAojIENP
TkZJR19TQVRBX0FDQVJEX0FIQ0kgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NJTDI0IGlz
IG5vdCBzZXQKQ09ORklHX0FUQV9TRkY9eQoKIwojIFNGRiBjb250cm9sbGVycyB3aXRoIGN1
c3RvbSBETUEgaW50ZXJmYWNlCiMKIyBDT05GSUdfUERDX0FETUEgaXMgbm90IHNldAojIENP
TkZJR19TQVRBX1FTVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TWDQgaXMgbm90IHNl
dApDT05GSUdfQVRBX0JNRE1BPXkKCiMKIyBTQVRBIFNGRiBjb250cm9sbGVycyB3aXRoIEJN
RE1BCiMKQ09ORklHX0FUQV9QSUlYPXkKIyBDT05GSUdfU0FUQV9EV0MgaXMgbm90IHNldAoj
IENPTkZJR19TQVRBX01WIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9OViBpcyBub3Qgc2V0
CiMgQ09ORklHX1NBVEFfUFJPTUlTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU0lMIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSVMgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NW
VyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVUxJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FU
QV9WSUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1ZJVEVTU0UgaXMgbm90IHNldAoKIwoj
IFBBVEEgU0ZGIGNvbnRyb2xsZXJzIHdpdGggQk1ETUEKIwojIENPTkZJR19QQVRBX0FMSSBp
cyBub3Qgc2V0CkNPTkZJR19QQVRBX0FNRD15CiMgQ09ORklHX1BBVEFfQVJUT1AgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX0FUSUlYUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRQ
ODY3WCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQ01ENjRYIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEFUQV9DWVBSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9FRkFSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9IUFQzNjYgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDM3
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUM1gyTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfSFBUM1gzIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9JVDgyMTMgaXMgbm90IHNl
dAojIENPTkZJR19QQVRBX0lUODIxWCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSk1JQ1JP
TiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTUFSVkVMTCBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfTkVUQ0VMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTklOSkEzMiBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfTlM4NzQxNSBpcyBub3Qgc2V0CkNPTkZJR19QQVRBX09MRFBJ
SVg9eQojIENPTkZJR19QQVRBX09QVElETUEgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1BE
QzIwMjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QRENfT0xEIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFUQV9SQURJU1lTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SREMgaXMgbm90
IHNldApDT05GSUdfUEFUQV9TQ0g9eQojIENPTkZJR19QQVRBX1NFUlZFUldPUktTIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9TSUw2ODAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NJ
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVE9TSElCQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfVFJJRkxFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVklBIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9XSU5CT05EIGlzIG5vdCBzZXQKCiMKIyBQSU8tb25seSBTRkYgY29u
dHJvbGxlcnMKIwojIENPTkZJR19QQVRBX0NNRDY0MF9QQ0kgaXMgbm90IHNldAojIENPTkZJ
R19QQVRBX01QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OUzg3NDEwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9PUFRJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QQ01DSUEg
aXMgbm90IHNldAojIENPTkZJR19QQVRBX1JaMTAwMCBpcyBub3Qgc2V0CgojCiMgR2VuZXJp
YyBmYWxsYmFjayAvIGxlZ2FjeSBkcml2ZXJzCiMKIyBDT05GSUdfUEFUQV9BQ1BJIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVRBX0dFTkVSSUMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0xF
R0FDWSBpcyBub3Qgc2V0CkNPTkZJR19NRD15CkNPTkZJR19CTEtfREVWX01EPXkKQ09ORklH
X01EX0FVVE9ERVRFQ1Q9eQojIENPTkZJR19NRF9MSU5FQVIgaXMgbm90IHNldAojIENPTkZJ
R19NRF9SQUlEMCBpcyBub3Qgc2V0CiMgQ09ORklHX01EX1JBSUQxIGlzIG5vdCBzZXQKIyBD
T05GSUdfTURfUkFJRDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfTURfUkFJRDQ1NiBpcyBub3Qg
c2V0CiMgQ09ORklHX01EX01VTFRJUEFUSCBpcyBub3Qgc2V0CiMgQ09ORklHX01EX0ZBVUxU
WSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDQUNIRSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVW
X0RNX0JVSUxUSU49eQpDT05GSUdfQkxLX0RFVl9ETT15CiMgQ09ORklHX0RNX01RX0RFRkFV
TFQgaXMgbm90IHNldAojIENPTkZJR19ETV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RN
X1VOU1RSSVBFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0NSWVBUIGlzIG5vdCBzZXQKIyBD
T05GSUdfRE1fU05BUFNIT1QgaXMgbm90IHNldAojIENPTkZJR19ETV9USElOX1BST1ZJU0lP
TklORyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0NBQ0hFIGlzIG5vdCBzZXQKIyBDT05GSUdf
RE1fRVJBIGlzIG5vdCBzZXQKQ09ORklHX0RNX01JUlJPUj15CiMgQ09ORklHX0RNX0xPR19V
U0VSU1BBQ0UgaXMgbm90IHNldAojIENPTkZJR19ETV9SQUlEIGlzIG5vdCBzZXQKQ09ORklH
X0RNX1pFUk89eQojIENPTkZJR19ETV9NVUxUSVBBVEggaXMgbm90IHNldAojIENPTkZJR19E
TV9ERUxBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1VFVkVOVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0RNX0ZMQUtFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1ZFUklUWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RNX1NXSVRDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0xPR19XUklURVMg
aXMgbm90IHNldAojIENPTkZJR19ETV9JTlRFR1JJVFkgaXMgbm90IHNldAojIENPTkZJR19U
QVJHRVRfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTiBpcyBub3Qgc2V0CgojCiMg
SUVFRSAxMzk0IChGaXJlV2lyZSkgc3VwcG9ydAojCiMgQ09ORklHX0ZJUkVXSVJFIGlzIG5v
dCBzZXQKIyBDT05GSUdfRklSRVdJUkVfTk9TWSBpcyBub3Qgc2V0CkNPTkZJR19NQUNJTlRP
U0hfRFJJVkVSUz15CkNPTkZJR19NQUNfRU1VTU9VU0VCVE49eQpDT05GSUdfTkVUREVWSUNF
Uz15CkNPTkZJR19NSUk9eQpDT05GSUdfTkVUX0NPUkU9eQojIENPTkZJR19CT05ESU5HIGlz
IG5vdCBzZXQKIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIg
aXMgbm90IHNldAojIENPTkZJR19ORVRfRkMgaXMgbm90IHNldAojIENPTkZJR19JRkIgaXMg
bm90IHNldAojIENPTkZJR19ORVRfVEVBTSBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ1ZMQU4g
aXMgbm90IHNldAojIENPTkZJR19JUFZMQU4gaXMgbm90IHNldAojIENPTkZJR19WWExBTiBp
cyBub3Qgc2V0CiMgQ09ORklHX01BQ1NFQyBpcyBub3Qgc2V0CkNPTkZJR19ORVRDT05TT0xF
PXkKQ09ORklHX05FVFBPTEw9eQpDT05GSUdfTkVUX1BPTExfQ09OVFJPTExFUj15CiMgQ09O
RklHX1RVTiBpcyBub3Qgc2V0CiMgQ09ORklHX1RVTl9WTkVUX0NST1NTX0xFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVkVUSCBpcyBub3Qgc2V0CkNPTkZJR19WSVJUSU9fTkVUPXkKIyBDT05G
SUdfTkxNT04gaXMgbm90IHNldAojIENPTkZJR19BUkNORVQgaXMgbm90IHNldAoKIwojIENB
SUYgdHJhbnNwb3J0IGRyaXZlcnMKIwoKIwojIERpc3RyaWJ1dGVkIFN3aXRjaCBBcmNoaXRl
Y3R1cmUgZHJpdmVycwojCkNPTkZJR19FVEhFUk5FVD15CkNPTkZJR19ORVRfVkVORE9SXzND
T009eQojIENPTkZJR19QQ01DSUFfM0M1NzQgaXMgbm90IHNldAojIENPTkZJR19QQ01DSUFf
M0M1ODkgaXMgbm90IHNldAojIENPTkZJR19WT1JURVggaXMgbm90IHNldAojIENPTkZJR19U
WVBIT09OIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfQURBUFRFQz15CiMgQ09ORklH
X0FEQVBURUNfU1RBUkZJUkUgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9BR0VSRT15
CiMgQ09ORklHX0VUMTMxWCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FMQUNSSVRF
Q0g9eQojIENPTkZJR19TTElDT1NTIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfQUxU
RU9OPXkKIyBDT05GSUdfQUNFTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxURVJBX1RTRSBp
cyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FNQVpPTj15CiMgQ09ORklHX0VOQV9FVEhF
Uk5FVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FNRD15CiMgQ09ORklHX0FNRDgx
MTFfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfUENORVQzMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1BDTUNJQV9OTUNMQU4gaXMgbm90IHNldAojIENPTkZJR19BTURfWEdCRSBpcyBub3Qgc2V0
CkNPTkZJR19ORVRfVkVORE9SX0FRVUFOVElBPXkKIyBDT05GSUdfQVFUSU9OIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9WRU5ET1JfQVJDPXkKQ09ORklHX05FVF9WRU5ET1JfQVRIRVJPUz15
CiMgQ09ORklHX0FUTDIgaXMgbm90IHNldAojIENPTkZJR19BVEwxIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVRMMUUgaXMgbm90IHNldAojIENPTkZJR19BVEwxQyBpcyBub3Qgc2V0CiMgQ09O
RklHX0FMWCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQVVST1JBIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9DQURFTkNFPXkKIyBDT05GSUdfTUFDQiBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfVkVORE9SX0JST0FEQ09NPXkKIyBDT05GSUdfQjQ0IGlzIG5vdCBzZXQKIyBDT05G
SUdfQk5YMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NOSUMgaXMgbm90IHNldApDT05GSUdfVElH
T04zPXkKQ09ORklHX1RJR09OM19IV01PTj15CiMgQ09ORklHX0JOWDJYIGlzIG5vdCBzZXQK
IyBDT05GSUdfQk5YVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0JST0NBREU9eQoj
IENPTkZJR19CTkEgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9DQVZJVU09eQojIENP
TkZJR19USFVOREVSX05JQ19QRiBpcyBub3Qgc2V0CiMgQ09ORklHX1RIVU5ERVJfTklDX1ZG
IGlzIG5vdCBzZXQKIyBDT05GSUdfVEhVTkRFUl9OSUNfQkdYIGlzIG5vdCBzZXQKIyBDT05G
SUdfVEhVTkRFUl9OSUNfUkdYIGlzIG5vdCBzZXQKQ09ORklHX0NBVklVTV9QVFA9eQojIENP
TkZJR19MSVFVSURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0xJUVVJRElPX1ZGIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9WRU5ET1JfQ0hFTFNJTz15CiMgQ09ORklHX0NIRUxTSU9fVDEgaXMg
bm90IHNldAojIENPTkZJR19DSEVMU0lPX1QzIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hFTFNJ
T19UNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIRUxTSU9fVDRWRiBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfVkVORE9SX0NJU0NPPXkKIyBDT05GSUdfRU5JQyBpcyBub3Qgc2V0CkNPTkZJR19O
RVRfVkVORE9SX0NPUlRJTkE9eQojIENPTkZJR19DWF9FQ0FUIGlzIG5vdCBzZXQKIyBDT05G
SUdfRE5FVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0RFQz15CkNPTkZJR19ORVRf
VFVMSVA9eQojIENPTkZJR19ERTIxMDRYIGlzIG5vdCBzZXQKIyBDT05GSUdfVFVMSVAgaXMg
bm90IHNldAojIENPTkZJR19ERTRYNSBpcyBub3Qgc2V0CiMgQ09ORklHX1dJTkJPTkRfODQw
IGlzIG5vdCBzZXQKIyBDT05GSUdfRE05MTAyIGlzIG5vdCBzZXQKIyBDT05GSUdfVUxJNTI2
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDTUNJQV9YSVJDT00gaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9ETElOSz15CiMgQ09ORklHX0RMMksgaXMgbm90IHNldAojIENPTkZJR19T
VU5EQU5DRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0VNVUxFWD15CiMgQ09ORklH
X0JFMk5FVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0VaQ0hJUD15CkNPTkZJR19O
RVRfVkVORE9SX0VYQVI9eQojIENPTkZJR19TMklPIGlzIG5vdCBzZXQKIyBDT05GSUdfVlhH
RSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0ZVSklUU1U9eQojIENPTkZJR19QQ01D
SUFfRk1WSjE4WCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0hQPXkKIyBDT05GSUdf
SFAxMDAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9IVUFXRUk9eQojIENPTkZJR19I
SU5JQyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0lOVEVMPXkKQ09ORklHX0UxMDA9
eQpDT05GSUdfRTEwMDA9eQpDT05GSUdfRTEwMDBFPXkKQ09ORklHX0UxMDAwRV9IV1RTPXkK
IyBDT05GSUdfSUdCIGlzIG5vdCBzZXQKIyBDT05GSUdfSUdCVkYgaXMgbm90IHNldAojIENP
TkZJR19JWEdCIGlzIG5vdCBzZXQKIyBDT05GSUdfSVhHQkUgaXMgbm90IHNldAojIENPTkZJ
R19JWEdCRVZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSTQwRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0k0MEVWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0lDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZN
MTBLIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfSTgyNVhYPXkKIyBDT05GSUdfSk1F
IGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfTUFSVkVMTD15CiMgQ09ORklHX01WTURJ
TyBpcyBub3Qgc2V0CiMgQ09ORklHX1NLR0UgaXMgbm90IHNldApDT05GSUdfU0tZMj15CiMg
Q09ORklHX1NLWTJfREVCVUcgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9NRUxMQU5P
WD15CiMgQ09ORklHX01MWDRfRU4gaXMgbm90IHNldAojIENPTkZJR19NTFg1X0NPUkUgaXMg
bm90IHNldAojIENPTkZJR19NTFhTV19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUxYRlcg
aXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUw9eQojIENPTkZJR19LUzg4NDIg
aXMgbm90IHNldAojIENPTkZJR19LUzg4NTFfTUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfS1Na
ODg0WF9QQ0kgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9NWVJJPXkKIyBDT05GSUdf
TVlSSTEwR0UgaXMgbm90IHNldAojIENPTkZJR19GRUFMTlggaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9OQVRTRU1JPXkKIyBDT05GSUdfTkFUU0VNSSBpcyBub3Qgc2V0CiMgQ09O
RklHX05TODM4MjAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ORVRST05PTUU9eQoj
IENPTkZJR19ORlAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9OST15CkNPTkZJR19O
RVRfVkVORE9SXzgzOTA9eQojIENPTkZJR19QQ01DSUFfQVhORVQgaXMgbm90IHNldAojIENP
TkZJR19ORTJLX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDTUNJQV9QQ05FVCBpcyBub3Qg
c2V0CkNPTkZJR19ORVRfVkVORE9SX05WSURJQT15CkNPTkZJR19GT1JDRURFVEg9eQpDT05G
SUdfTkVUX1ZFTkRPUl9PS0k9eQojIENPTkZJR19FVEhPQyBpcyBub3Qgc2V0CkNPTkZJR19O
RVRfUEFDS0VUX0VOR0lORT15CiMgQ09ORklHX0hBTUFDSEkgaXMgbm90IHNldAojIENPTkZJ
R19ZRUxMT1dGSU4gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9RTE9HSUM9eQojIENP
TkZJR19RTEEzWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfUUxDTklDIGlzIG5vdCBzZXQKIyBD
T05GSUdfUUxHRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFhFTl9OSUMgaXMgbm90IHNldAoj
IENPTkZJR19RRUQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9RVUFMQ09NTT15CiMg
Q09ORklHX1FDT01fRU1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JNTkVUIGlzIG5vdCBzZXQK
Q09ORklHX05FVF9WRU5ET1JfUkVBTFRFSz15CiMgQ09ORklHXzgxMzlDUCBpcyBub3Qgc2V0
CkNPTkZJR184MTM5VE9PPXkKQ09ORklHXzgxMzlUT09fUElPPXkKIyBDT05GSUdfODEzOVRP
T19UVU5FX1RXSVNURVIgaXMgbm90IHNldAojIENPTkZJR184MTM5VE9PXzgxMjkgaXMgbm90
IHNldAojIENPTkZJR184MTM5X09MRF9SWF9SRVNFVCBpcyBub3Qgc2V0CkNPTkZJR19SODE2
OT15CkNPTkZJR19ORVRfVkVORE9SX1JFTkVTQVM9eQpDT05GSUdfTkVUX1ZFTkRPUl9SREM9
eQojIENPTkZJR19SNjA0MCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1JPQ0tFUj15
CkNPTkZJR19ORVRfVkVORE9SX1NBTVNVTkc9eQojIENPTkZJR19TWEdCRV9FVEggaXMgbm90
IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TRUVRPXkKQ09ORklHX05FVF9WRU5ET1JfU0lMQU49
eQojIENPTkZJR19TQzkyMDMxIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU0lTPXkK
IyBDT05GSUdfU0lTOTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0lTMTkwIGlzIG5vdCBzZXQK
Q09ORklHX05FVF9WRU5ET1JfU09MQVJGTEFSRT15CiMgQ09ORklHX1NGQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NGQ19GQUxDT04gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TTVND
PXkKIyBDT05GSUdfUENNQ0lBX1NNQzkxQzkyIGlzIG5vdCBzZXQKIyBDT05GSUdfRVBJQzEw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NNU0M5MTFYIGlzIG5vdCBzZXQKIyBDT05GSUdfU01T
Qzk0MjAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TT0NJT05FWFQ9eQpDT05GSUdf
TkVUX1ZFTkRPUl9TVE1JQ1JPPXkKIyBDT05GSUdfU1RNTUFDX0VUSCBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SX1NVTj15CiMgQ09ORklHX0hBUFBZTUVBTCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NVTkdFTSBpcyBub3Qgc2V0CiMgQ09ORklHX0NBU1NJTkkgaXMgbm90IHNldAoj
IENPTkZJR19OSVUgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9URUhVVEk9eQojIENP
TkZJR19URUhVVEkgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9UST15CiMgQ09ORklH
X1RJX0NQU1dfQUxFIGlzIG5vdCBzZXQKIyBDT05GSUdfVExBTiBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfVkVORE9SX1ZJQT15CiMgQ09ORklHX1ZJQV9SSElORSBpcyBub3Qgc2V0CiMgQ09O
RklHX1ZJQV9WRUxPQ0lUWSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1dJWk5FVD15
CiMgQ09ORklHX1dJWk5FVF9XNTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1dJWk5FVF9XNTMw
MCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1hJUkNPTT15CiMgQ09ORklHX1BDTUNJ
QV9YSVJDMlBTIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU1lOT1BTWVM9eQojIENP
TkZJR19EV0NfWExHTUFDIGlzIG5vdCBzZXQKQ09ORklHX0ZEREk9eQojIENPTkZJR19ERUZY
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NLRlAgaXMgbm90IHNldAojIENPTkZJR19ISVBQSSBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQjEwMDAgaXMgbm90IHNldApDT05GSUdfTURJT19E
RVZJQ0U9eQpDT05GSUdfTURJT19CVVM9eQojIENPTkZJR19NRElPX0JJVEJBTkcgaXMgbm90
IHNldAojIENPTkZJR19NRElPX1RIVU5ERVIgaXMgbm90IHNldApDT05GSUdfUEhZTElCPXkK
IyBDT05GSUdfTEVEX1RSSUdHRVJfUEhZIGlzIG5vdCBzZXQKCiMKIyBNSUkgUEhZIGRldmlj
ZSBkcml2ZXJzCiMKIyBDT05GSUdfQU1EX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FRVUFO
VElBX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FUODAzWF9QSFkgaXMgbm90IHNldAojIENP
TkZJR19CQ003WFhYX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTTg3WFhfUEhZIGlzIG5v
dCBzZXQKIyBDT05GSUdfQlJPQURDT01fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lDQURB
X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPUlRJTkFfUEhZIGlzIG5vdCBzZXQKIyBDT05G
SUdfREFWSUNPTV9QSFkgaXMgbm90IHNldAojIENPTkZJR19EUDgzODIyX1BIWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0RQODM4NDhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4Mzg2N19Q
SFkgaXMgbm90IHNldAojIENPTkZJR19GSVhFRF9QSFkgaXMgbm90IHNldAojIENPTkZJR19J
Q1BMVVNfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfWFdBWV9QSFkgaXMgbm90IHNl
dAojIENPTkZJR19MU0lfRVQxMDExQ19QSFkgaXMgbm90IHNldAojIENPTkZJR19MWFRfUEhZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUFSVkVMTF9QSFkgaXMgbm90IHNldAojIENPTkZJR19N
QVJWRUxMXzEwR19QSFkgaXMgbm90IHNldAojIENPTkZJR19NSUNSRUxfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUlDUk9DSElQX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JPU0VN
SV9QSFkgaXMgbm90IHNldAojIENPTkZJR19OQVRJT05BTF9QSFkgaXMgbm90IHNldAojIENP
TkZJR19RU0VNSV9QSFkgaXMgbm90IHNldAojIENPTkZJR19SRUFMVEVLX1BIWSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JFTkVTQVNfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUk9DS0NISVBf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfU01TQ19QSFkgaXMgbm90IHNldAojIENPTkZJR19T
VEUxMFhQIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVSQU5FVElDU19QSFkgaXMgbm90IHNldAoj
IENPTkZJR19WSVRFU1NFX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9HTUlJMlJH
TUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xJUCBp
cyBub3Qgc2V0CkNPTkZJR19VU0JfTkVUX0RSSVZFUlM9eQojIENPTkZJR19VU0JfQ0FUQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9LQVdFVEggaXMgbm90IHNldAojIENPTkZJR19VU0Jf
UEVHQVNVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9SVEw4MTUwIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1JUTDgxNTIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEFONzhYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9VU0JORVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfSFNP
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lQSEVUSCBpcyBub3Qgc2V0CkNPTkZJR19XTEFO
PXkKQ09ORklHX1dMQU5fVkVORE9SX0FETVRFSz15CiMgQ09ORklHX0FETTgyMTEgaXMgbm90
IHNldApDT05GSUdfV0xBTl9WRU5ET1JfQVRIPXkKIyBDT05GSUdfQVRIX0RFQlVHIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVRINUsgaXMgbm90IHNldAojIENPTkZJR19BVEg1S19QQ0kgaXMg
bm90IHNldAojIENPTkZJR19BVEg5SyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUSDlLX0hUQyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NBUkw5MTcwIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRINktM
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVI1NTIzIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lMNjIx
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUSDEwSyBpcyBub3Qgc2V0CiMgQ09ORklHX1dDTjM2
WFggaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfQVRNRUw9eQojIENPTkZJR19BVE1F
TCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUNzZDNTBYX1VTQiBpcyBub3Qgc2V0CkNPTkZJR19X
TEFOX1ZFTkRPUl9CUk9BRENPTT15CiMgQ09ORklHX0I0MyBpcyBub3Qgc2V0CiMgQ09ORklH
X0I0M0xFR0FDWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JSQ01TTUFDIGlzIG5vdCBzZXQKIyBD
T05GSUdfQlJDTUZNQUMgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfQ0lTQ089eQoj
IENPTkZJR19BSVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfQUlST19DUyBpcyBub3Qgc2V0CkNP
TkZJR19XTEFOX1ZFTkRPUl9JTlRFTD15CiMgQ09ORklHX0lQVzIxMDAgaXMgbm90IHNldAoj
IENPTkZJR19JUFcyMjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSVdMNDk2NSBpcyBub3Qgc2V0
CiMgQ09ORklHX0lXTDM5NDUgaXMgbm90IHNldAojIENPTkZJR19JV0xXSUZJIGlzIG5vdCBz
ZXQKQ09ORklHX1dMQU5fVkVORE9SX0lOVEVSU0lMPXkKIyBDT05GSUdfSE9TVEFQIGlzIG5v
dCBzZXQKIyBDT05GSUdfSEVSTUVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUDU0X0NPTU1PTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1BSSVNNNTQgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5E
T1JfTUFSVkVMTD15CiMgQ09ORklHX0xJQkVSVEFTIGlzIG5vdCBzZXQKIyBDT05GSUdfTElC
RVJUQVNfVEhJTkZJUk0gaXMgbm90IHNldAojIENPTkZJR19NV0lGSUVYIGlzIG5vdCBzZXQK
IyBDT05GSUdfTVdMOEsgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfTUVESUFURUs9
eQojIENPTkZJR19NVDc2MDFVIGlzIG5vdCBzZXQKIyBDT05GSUdfTVQ3NngyRSBpcyBub3Qg
c2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9SQUxJTks9eQojIENPTkZJR19SVDJYMDAgaXMgbm90
IHNldApDT05GSUdfV0xBTl9WRU5ET1JfUkVBTFRFSz15CiMgQ09ORklHX1JUTDgxODAgaXMg
bm90IHNldAojIENPTkZJR19SVEw4MTg3IGlzIG5vdCBzZXQKQ09ORklHX1JUTF9DQVJEUz15
CiMgQ09ORklHX1JUTDgxOTJDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxOTJTRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUTDgxOTJERSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDg3MjNB
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDg3MjNCRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
TDgxODhFRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxOTJFRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUTDg4MjFBRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxOTJDVSBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUTDhYWFhVIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX1JTST15
CiMgQ09ORklHX1JTSV85MVggaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfU1Q9eQoj
IENPTkZJR19DVzEyMDAgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfVEk9eQojIENP
TkZJR19XTDEyNTEgaXMgbm90IHNldAojIENPTkZJR19XTDEyWFggaXMgbm90IHNldAojIENP
TkZJR19XTDE4WFggaXMgbm90IHNldAojIENPTkZJR19XTENPUkUgaXMgbm90IHNldApDT05G
SUdfV0xBTl9WRU5ET1JfWllEQVM9eQojIENPTkZJR19VU0JfWkQxMjAxIGlzIG5vdCBzZXQK
IyBDT05GSUdfWkQxMjExUlcgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfUVVBTlRF
Tk5BPXkKIyBDT05GSUdfUVRORk1BQ19QRUFSTF9QQ0lFIGlzIG5vdCBzZXQKIyBDT05GSUdf
UENNQ0lBX1JBWUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfUENNQ0lBX1dMMzUwMSBpcyBub3Qg
c2V0CiMgQ09ORklHX01BQzgwMjExX0hXU0lNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX05F
VF9STkRJU19XTEFOIGlzIG5vdCBzZXQKCiMKIyBFbmFibGUgV2lNQVggKE5ldHdvcmtpbmcg
b3B0aW9ucykgdG8gc2VlIHRoZSBXaU1BWCBkcml2ZXJzCiMKIyBDT05GSUdfV0FOIGlzIG5v
dCBzZXQKIyBDT05GSUdfVk1YTkVUMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVSklUU1VfRVMg
aXMgbm90IHNldAojIENPTkZJR19ORVRERVZTSU0gaXMgbm90IHNldAojIENPTkZJR19JU0RO
IGlzIG5vdCBzZXQKIyBDT05GSUdfTlZNIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZpY2Ug
c3VwcG9ydAojCkNPTkZJR19JTlBVVD15CkNPTkZJR19JTlBVVF9MRURTPXkKQ09ORklHX0lO
UFVUX0ZGX01FTUxFU1M9eQpDT05GSUdfSU5QVVRfUE9MTERFVj15CkNPTkZJR19JTlBVVF9T
UEFSU0VLTUFQPXkKIyBDT05GSUdfSU5QVVRfTUFUUklYS01BUCBpcyBub3Qgc2V0CgojCiMg
VXNlcmxhbmQgaW50ZXJmYWNlcwojCiMgQ09ORklHX0lOUFVUX01PVVNFREVWIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX0VWREVW
PXkKIyBDT05GSUdfSU5QVVRfRVZCVUcgaXMgbm90IHNldAoKIwojIElucHV0IERldmljZSBE
cml2ZXJzCiMKQ09ORklHX0lOUFVUX0tFWUJPQVJEPXkKIyBDT05GSUdfS0VZQk9BUkRfQURQ
NTU4OCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0FEUDU1ODkgaXMgbm90IHNldApD
T05GSUdfS0VZQk9BUkRfQVRLQkQ9eQojIENPTkZJR19LRVlCT0FSRF9RVDEwNzAgaXMgbm90
IHNldAojIENPTkZJR19LRVlCT0FSRF9RVDIxNjAgaXMgbm90IHNldAojIENPTkZJR19LRVlC
T0FSRF9ETElOS19ESVI2ODUgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9MS0tCRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1RDQTY0MTYgaXMgbm90IHNldAojIENPTkZJ
R19LRVlCT0FSRF9UQ0E4NDE4IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTE04MzIz
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTE04MzMzIGlzIG5vdCBzZXQKIyBDT05G
SUdfS0VZQk9BUkRfTUFYNzM1OSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01DUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01QUjEyMSBpcyBub3Qgc2V0CiMgQ09ORklH
X0tFWUJPQVJEX05FV1RPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX09QRU5DT1JF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NBTVNVTkcgaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9TVE9XQVdBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NV
TktCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1RNMl9UT1VDSEtFWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0tFWUJPQVJEX1hUS0JEIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX01P
VVNFPXkKQ09ORklHX01PVVNFX1BTMj15CkNPTkZJR19NT1VTRV9QUzJfQUxQUz15CkNPTkZJ
R19NT1VTRV9QUzJfQllEPXkKQ09ORklHX01PVVNFX1BTMl9MT0dJUFMyUFA9eQpDT05GSUdf
TU9VU0VfUFMyX1NZTkFQVElDUz15CkNPTkZJR19NT1VTRV9QUzJfU1lOQVBUSUNTX1NNQlVT
PXkKQ09ORklHX01PVVNFX1BTMl9DWVBSRVNTPXkKQ09ORklHX01PVVNFX1BTMl9MSUZFQk9P
Sz15CkNPTkZJR19NT1VTRV9QUzJfVFJBQ0tQT0lOVD15CiMgQ09ORklHX01PVVNFX1BTMl9F
TEFOVEVDSCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1BTMl9TRU5URUxJQyBpcyBub3Qg
c2V0CiMgQ09ORklHX01PVVNFX1BTMl9UT1VDSEtJVCBpcyBub3Qgc2V0CkNPTkZJR19NT1VT
RV9QUzJfRk9DQUxURUNIPXkKIyBDT05GSUdfTU9VU0VfUFMyX1ZNTU9VU0UgaXMgbm90IHNl
dApDT05GSUdfTU9VU0VfUFMyX1NNQlVTPXkKIyBDT05GSUdfTU9VU0VfU0VSSUFMIGlzIG5v
dCBzZXQKIyBDT05GSUdfTU9VU0VfQVBQTEVUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX01P
VVNFX0JDTTU5NzQgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9DWUFQQSBpcyBub3Qgc2V0
CiMgQ09ORklHX01PVVNFX0VMQU5fSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfVlNY
WFhBQSBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1NZTkFQVElDU19JMkMgaXMgbm90IHNl
dAojIENPTkZJR19NT1VTRV9TWU5BUFRJQ1NfVVNCIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVU
X0pPWVNUSUNLPXkKIyBDT05GSUdfSk9ZU1RJQ0tfQU5BTE9HIGlzIG5vdCBzZXQKIyBDT05G
SUdfSk9ZU1RJQ0tfQTNEIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQURJIGlzIG5v
dCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQ09CUkEgaXMgbm90IHNldAojIENPTkZJR19KT1lT
VElDS19HRjJLIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR1JJUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0pPWVNUSUNLX0dSSVBfTVAgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElD
S19HVUlMTEVNT1QgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19JTlRFUkFDVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1NJREVXSU5ERVIgaXMgbm90IHNldAojIENPTkZJ
R19KT1lTVElDS19UTURDIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfSUZPUkNFIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfV0FSUklPUiBpcyBub3Qgc2V0CiMgQ09ORklH
X0pPWVNUSUNLX01BR0VMTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU1BBQ0VP
UkIgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19TUEFDRUJBTEwgaXMgbm90IHNldAoj
IENPTkZJR19KT1lTVElDS19TVElOR0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tf
VFdJREpPWSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1pIRU5IVUEgaXMgbm90IHNl
dAojIENPTkZJR19KT1lTVElDS19BUzUwMTEgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElD
S19KT1lEVU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfWFBBRCBpcyBub3Qgc2V0
CiMgQ09ORklHX0pPWVNUSUNLX1BYUkMgaXMgbm90IHNldApDT05GSUdfSU5QVVRfVEFCTEVU
PXkKIyBDT05GSUdfVEFCTEVUX1VTQl9BQ0VDQUQgaXMgbm90IHNldAojIENPTkZJR19UQUJM
RVRfVVNCX0FJUFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1RBQkxFVF9VU0JfR1RDTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RBQkxFVF9VU0JfSEFOV0FORyBpcyBub3Qgc2V0CiMgQ09ORklH
X1RBQkxFVF9VU0JfS0JUQUIgaXMgbm90IHNldAojIENPTkZJR19UQUJMRVRfVVNCX1BFR0FT
VVMgaXMgbm90IHNldAojIENPTkZJR19UQUJMRVRfU0VSSUFMX1dBQ09NNCBpcyBub3Qgc2V0
CkNPTkZJR19JTlBVVF9UT1VDSFNDUkVFTj15CkNPTkZJR19UT1VDSFNDUkVFTl9QUk9QRVJU
SUVTPXkKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQUQ3ODc5IGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9VQ0hTQ1JFRU5fQVRNRUxfTVhUIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5f
QlUyMTAxMyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NZVFRTUF9DT1JFIGlz
IG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQ1lUVFNQNF9DT1JFIGlzIG5vdCBzZXQK
IyBDT05GSUdfVE9VQ0hTQ1JFRU5fRFlOQVBSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNI
U0NSRUVOX0hBTVBTSElSRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VFVEkg
aXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FR0FMQVhfU0VSSUFMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRVhDMzAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX0ZVSklUU1UgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9ISURF
RVAgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9JTEkyMTBYIGlzIG5vdCBzZXQK
IyBDT05GSUdfVE9VQ0hTQ1JFRU5fUzZTWTc2MSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNI
U0NSRUVOX0dVTlpFIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRUtURjIxMjcg
aXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FTEFOIGlzIG5vdCBzZXQKIyBDT05G
SUdfVE9VQ0hTQ1JFRU5fRUxPIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fV0FD
T01fVzgwMDEgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9XQUNPTV9JMkMgaXMg
bm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9NQVgxMTgwMSBpcyBub3Qgc2V0CiMgQ09O
RklHX1RPVUNIU0NSRUVOX01DUzUwMDAgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVF
Tl9NTVMxMTQgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9NRUxGQVNfTUlQNCBp
cyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX01UT1VDSCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RPVUNIU0NSRUVOX0lORVhJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVO
X01LNzEyIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fUEVOTU9VTlQgaXMgbm90
IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FRFRfRlQ1WDA2IGlzIG5vdCBzZXQKIyBDT05G
SUdfVE9VQ0hTQ1JFRU5fVE9VQ0hSSUdIVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NS
RUVOX1RPVUNIV0lOIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fUElYQ0lSIGlz
IG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fV0RUODdYWF9JMkMgaXMgbm90IHNldAoj
IENPTkZJR19UT1VDSFNDUkVFTl9VU0JfQ09NUE9TSVRFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9VQ0hTQ1JFRU5fVE9VQ0hJVDIxMyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVO
X1RTQ19TRVJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1RTQzIwMDQgaXMg
bm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9UU0MyMDA3IGlzIG5vdCBzZXQKIyBDT05G
SUdfVE9VQ0hTQ1JFRU5fU0lMRUFEIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5f
U1QxMjMyIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fU1RNRlRTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fU1g4NjU0IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9V
Q0hTQ1JFRU5fVFBTNjUwN1ggaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9aRVQ2
MjIzIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fUk9ITV9CVTIxMDIzIGlzIG5v
dCBzZXQKQ09ORklHX0lOUFVUX01JU0M9eQojIENPTkZJR19JTlBVVF9BRDcxNFggaXMgbm90
IHNldAojIENPTkZJR19JTlBVVF9CTUExNTAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9F
M1gwX0JVVFRPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1BDU1BLUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX01NQTg0NTAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BUEFO
RUwgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BVExBU19CVE5TIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfQVRJX1JFTU9URTIgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9LRVlT
UEFOX1JFTU9URSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0tYVEo5IGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfUE9XRVJNQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfWUVB
TElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0NNMTA5IGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5QVVRfVUlOUFVUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUENGODU3NCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOUFVUX0FEWEwzNFggaXMgbm90IHNldAojIENPTkZJR19JTlBV
VF9JTVNfUENVIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQ01BMzAwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX0lERUFQQURfU0xJREVCQVIgaXMgbm90IHNldAojIENPTkZJR19J
TlBVVF9EUlYyNjY1X0hBUFRJQ1MgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9EUlYyNjY3
X0hBUFRJQ1MgaXMgbm90IHNldAojIENPTkZJR19STUk0X0NPUkUgaXMgbm90IHNldAoKIwoj
IEhhcmR3YXJlIEkvTyBwb3J0cwojCkNPTkZJR19TRVJJTz15CkNPTkZJR19BUkNIX01JR0hU
X0hBVkVfUENfU0VSSU89eQpDT05GSUdfU0VSSU9fSTgwNDI9eQpDT05GSUdfU0VSSU9fU0VS
UE9SVD15CiMgQ09ORklHX1NFUklPX0NUODJDNzEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VS
SU9fUENJUFMyIGlzIG5vdCBzZXQKQ09ORklHX1NFUklPX0xJQlBTMj15CiMgQ09ORklHX1NF
UklPX1JBVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX0FMVEVSQV9QUzIgaXMgbm90IHNl
dAojIENPTkZJR19TRVJJT19QUzJNVUxUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fQVJD
X1BTMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTRVJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0dB
TUVQT1JUIGlzIG5vdCBzZXQKCiMKIyBDaGFyYWN0ZXIgZGV2aWNlcwojCkNPTkZJR19UVFk9
eQpDT05GSUdfVlQ9eQpDT05GSUdfQ09OU09MRV9UUkFOU0xBVElPTlM9eQpDT05GSUdfVlRf
Q09OU09MRT15CkNPTkZJR19WVF9DT05TT0xFX1NMRUVQPXkKQ09ORklHX0hXX0NPTlNPTEU9
eQpDT05GSUdfVlRfSFdfQ09OU09MRV9CSU5ESU5HPXkKQ09ORklHX1VOSVg5OF9QVFlTPXkK
IyBDT05GSUdfTEVHQUNZX1BUWVMgaXMgbm90IHNldApDT05GSUdfU0VSSUFMX05PTlNUQU5E
QVJEPXkKIyBDT05GSUdfUk9DS0VUUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NZQ0xBREVT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTU9YQV9JTlRFTExJTyBpcyBub3Qgc2V0CiMgQ09ORklH
X01PWEFfU01BUlRJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTkNMSU5LIGlzIG5vdCBzZXQK
IyBDT05GSUdfU1lOQ0xJTktNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTkNMSU5LX0dUIGlz
IG5vdCBzZXQKIyBDT05GSUdfTk9aT01JIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNJIGlzIG5v
dCBzZXQKIyBDT05GSUdfTl9IRExDIGlzIG5vdCBzZXQKIyBDT05GSUdfTl9HU00gaXMgbm90
IHNldAojIENPTkZJR19UUkFDRV9TSU5LIGlzIG5vdCBzZXQKQ09ORklHX0RFVk1FTT15CiMg
Q09ORklHX0RFVktNRU0gaXMgbm90IHNldAoKIwojIFNlcmlhbCBkcml2ZXJzCiMKQ09ORklH
X1NFUklBTF9FQVJMWUNPTj15CkNPTkZJR19TRVJJQUxfODI1MD15CkNPTkZJR19TRVJJQUxf
ODI1MF9ERVBSRUNBVEVEX09QVElPTlM9eQpDT05GSUdfU0VSSUFMXzgyNTBfUE5QPXkKIyBD
T05GSUdfU0VSSUFMXzgyNTBfRklOVEVLIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUw
X0NPTlNPTEU9eQpDT05GSUdfU0VSSUFMXzgyNTBfRE1BPXkKQ09ORklHX1NFUklBTF84MjUw
X1BDST15CkNPTkZJR19TRVJJQUxfODI1MF9FWEFSPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBf
Q1MgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBfTlJfVUFSVFM9MzIKQ09ORklHX1NF
UklBTF84MjUwX1JVTlRJTUVfVUFSVFM9NApDT05GSUdfU0VSSUFMXzgyNTBfRVhURU5ERUQ9
eQpDT05GSUdfU0VSSUFMXzgyNTBfTUFOWV9QT1JUUz15CkNPTkZJR19TRVJJQUxfODI1MF9T
SEFSRV9JUlE9eQpDT05GSUdfU0VSSUFMXzgyNTBfREVURUNUX0lSUT15CkNPTkZJR19TRVJJ
QUxfODI1MF9SU0E9eQojIENPTkZJR19TRVJJQUxfODI1MF9EVyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFUklBTF84MjUwX1JUMjg4WCBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9M
UFNTPXkKQ09ORklHX1NFUklBTF84MjUwX01JRD15CiMgQ09ORklHX1NFUklBTF84MjUwX01P
WEEgaXMgbm90IHNldAoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1cHBvcnQKIwojIENP
TkZJR19TRVJJQUxfVUFSVExJVEUgaXMgbm90IHNldApDT05GSUdfU0VSSUFMX0NPUkU9eQpD
T05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CiMgQ09ORklHX1NFUklBTF9KU00gaXMgbm90
IHNldAojIENPTkZJR19TRVJJQUxfU0NDTlhQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFM
X1NDMTZJUzdYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BTFRFUkFfSlRBR1VBUlQg
aXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQUxURVJBX1VBUlQgaXMgbm90IHNldAojIENP
TkZJR19TRVJJQUxfQVJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1JQMiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFUklBTF9GU0xfTFBVQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VS
SUFMX0RFVl9CVVMgaXMgbm90IHNldApDT05GSUdfSFZDX0RSSVZFUj15CkNPTkZJR19WSVJU
SU9fQ09OU09MRT15CiMgQ09ORklHX0lQTUlfSEFORExFUiBpcyBub3Qgc2V0CkNPTkZJR19I
V19SQU5ET009eQojIENPTkZJR19IV19SQU5ET01fVElNRVJJT01FTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hXX1JBTkRPTV9JTlRFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0hXX1JBTkRPTV9B
TUQgaXMgbm90IHNldApDT05GSUdfSFdfUkFORE9NX1ZJQT15CiMgQ09ORklHX0hXX1JBTkRP
TV9WSVJUSU8gaXMgbm90IHNldApDT05GSUdfTlZSQU09eQojIENPTkZJR19SMzk2NCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FQUExJQ09NIGlzIG5vdCBzZXQKCiMKIyBQQ01DSUEgY2hhcmFj
dGVyIGRldmljZXMKIwojIENPTkZJR19TWU5DTElOS19DUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NBUkRNQU5fNDAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0NBUkRNQU5fNDA0MCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDUjI0WCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQV0lSRUxFU1MgaXMg
bm90IHNldAojIENPTkZJR19NV0FWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JBV19EUklWRVIg
aXMgbm90IHNldApDT05GSUdfSFBFVD15CiMgQ09ORklHX0hQRVRfTU1BUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0hBTkdDSEVDS19USU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RDR19UUE0g
aXMgbm90IHNldAojIENPTkZJR19URUxDTE9DSyBpcyBub3Qgc2V0CkNPTkZJR19ERVZQT1JU
PXkKIyBDT05GSUdfWElMTFlCVVMgaXMgbm90IHNldAoKIwojIEkyQyBzdXBwb3J0CiMKQ09O
RklHX0kyQz15CkNPTkZJR19BQ1BJX0kyQ19PUFJFR0lPTj15CkNPTkZJR19JMkNfQk9BUkRJ
TkZPPXkKQ09ORklHX0kyQ19DT01QQVQ9eQojIENPTkZJR19JMkNfQ0hBUkRFViBpcyBub3Qg
c2V0CiMgQ09ORklHX0kyQ19NVVggaXMgbm90IHNldApDT05GSUdfSTJDX0hFTFBFUl9BVVRP
PXkKQ09ORklHX0kyQ19TTUJVUz15CkNPTkZJR19JMkNfQUxHT0JJVD15CgojCiMgSTJDIEhh
cmR3YXJlIEJ1cyBzdXBwb3J0CiMKCiMKIyBQQyBTTUJ1cyBob3N0IGNvbnRyb2xsZXIgZHJp
dmVycwojCiMgQ09ORklHX0kyQ19BTEkxNTM1IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FM
STE1NjMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19BTUQ3NTYgaXMgbm90IHNldAojIENPTkZJR19JMkNfQU1EODExMSBpcyBub3Qg
c2V0CkNPTkZJR19JMkNfSTgwMT15CiMgQ09ORklHX0kyQ19JU0NIIGlzIG5vdCBzZXQKIyBD
T05GSUdfSTJDX0lTTVQgaXMgbm90IHNldAojIENPTkZJR19JMkNfUElJWDQgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfTkZPUkNFMiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM1NTk1
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzYzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19TSVM5NlggaXMgbm90IHNldAojIENPTkZJR19JMkNfVklBIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX1ZJQVBSTyBpcyBub3Qgc2V0CgojCiMgQUNQSSBkcml2ZXJzCiMKIyBDT05GSUdf
STJDX1NDTUkgaXMgbm90IHNldAoKIwojIEkyQyBzeXN0ZW0gYnVzIGRyaXZlcnMgKG1vc3Rs
eSBlbWJlZGRlZCAvIHN5c3RlbS1vbi1jaGlwKQojCiMgQ09ORklHX0kyQ19ERVNJR05XQVJF
X1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFU0lHTldBUkVfUENJIGlzIG5v
dCBzZXQKIyBDT05GSUdfSTJDX0VNRVYyIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX09DT1JF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QQ0FfUExBVEZPUk0gaXMgbm90IHNldAojIENP
TkZJR19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1hJTElOWCBpcyBub3Qg
c2V0CgojCiMgRXh0ZXJuYWwgSTJDL1NNQnVzIGFkYXB0ZXIgZHJpdmVycwojCiMgQ09ORklH
X0kyQ19ESU9MQU5fVTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BBUlBPUlRfTElHSFQg
aXMgbm90IHNldAojIENPTkZJR19JMkNfUk9CT1RGVVpaX09TSUYgaXMgbm90IHNldAojIENP
TkZJR19JMkNfVEFPU19FVk0gaXMgbm90IHNldAojIENPTkZJR19JMkNfVElOWV9VU0IgaXMg
bm90IHNldAoKIwojIE90aGVyIEkyQy9TTUJ1cyBidXMgZHJpdmVycwojCiMgQ09ORklHX0ky
Q19NTFhDUExEIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NUVUIgaXMgbm90IHNldAojIENP
TkZJR19JMkNfU0xBVkUgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQ09SRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19BTEdPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X0RFQlVHX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NQTUkgaXMgbm90IHNldAojIENPTkZJR19IU0kgaXMgbm90IHNldApDT05GSUdfUFBTPXkK
IyBDT05GSUdfUFBTX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBQUFMgY2xpZW50cyBzdXBwb3J0
CiMKIyBDT05GSUdfUFBTX0NMSUVOVF9LVElNRVIgaXMgbm90IHNldAojIENPTkZJR19QUFNf
Q0xJRU5UX0xESVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBTX0NMSUVOVF9HUElPIGlzIG5v
dCBzZXQKCiMKIyBQUFMgZ2VuZXJhdG9ycyBzdXBwb3J0CiMKCiMKIyBQVFAgY2xvY2sgc3Vw
cG9ydAojCkNPTkZJR19QVFBfMTU4OF9DTE9DSz15CgojCiMgRW5hYmxlIFBIWUxJQiBhbmQg
TkVUV09SS19QSFlfVElNRVNUQU1QSU5HIHRvIHNlZSB0aGUgYWRkaXRpb25hbCBjbG9ja3Mu
CiMKQ09ORklHX1BUUF8xNTg4X0NMT0NLX0tWTT15CiMgQ09ORklHX1BJTkNUUkwgaXMgbm90
IHNldAojIENPTkZJR19HUElPTElCIGlzIG5vdCBzZXQKIyBDT05GSUdfVzEgaXMgbm90IHNl
dAojIENPTkZJR19QT1dFUl9BVlMgaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9SRVNFVCBp
cyBub3Qgc2V0CkNPTkZJR19QT1dFUl9TVVBQTFk9eQojIENPTkZJR19QT1dFUl9TVVBQTFlf
REVCVUcgaXMgbm90IHNldAojIENPTkZJR19QREFfUE9XRVIgaXMgbm90IHNldAojIENPTkZJ
R19URVNUX1BPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9EUzI3ODAgaXMgbm90
IHNldAojIENPTkZJR19CQVRURVJZX0RTMjc4MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRF
UllfRFMyNzgyIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9TQlMgaXMgbm90IHNldAoj
IENPTkZJR19DSEFSR0VSX1NCUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfQlEyN1hY
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfTUFYMTcwNDAgaXMgbm90IHNldAojIENP
TkZJR19CQVRURVJZX01BWDE3MDQyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQVg4
OTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9MUDg3MjcgaXMgbm90IHNldAojIENP
TkZJR19DSEFSR0VSX0JRMjQxNVggaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX1NNQjM0
NyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfR0FVR0VfTFRDMjk0MSBpcyBub3Qgc2V0
CkNPTkZJR19IV01PTj15CiMgQ09ORklHX0hXTU9OX0RFQlVHX0NISVAgaXMgbm90IHNldAoK
IwojIE5hdGl2ZSBkcml2ZXJzCiMKIyBDT05GSUdfU0VOU09SU19BQklUVUdVUlUgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0FCSVRVR1VSVTMgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0FENzQxNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUQ3NDE4IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRE0xMDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI2IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRE0xMDMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE05MjQwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRFQ3NDExIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDYyIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRFQ3NDc1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BU0M3NjIxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19LOFRFTVAgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0sxMFRFTVAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZBTTE1SF9QT1dFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVBQTEVTTUMgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0FTQjEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNQRUVEIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BVFhQMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfRFM2MjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0RTMTYyMSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfREVMTF9TTU0gaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0k1S19BTUIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0Y3MTgwNUYgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0Y3MTg4MkZHIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19GNzUzNzVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GU0NITUQgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0ZUU1RFVVRBVEVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19HTDUxOFNNIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19HTDUyMFNNIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19HNzYwQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfRzc2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSElINjEzMCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfSTU1MDAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0NPUkVURU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JVDg3IGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19KQzQyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QT1dS
MTIyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTElORUFHRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTFRDMjk0NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRD
Mjk5MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDNDE1MSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTFRDNDIxNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRD
NDIyMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDNDI0NSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTFRDNDI2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRD
NDI2MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMTYwNjUgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX01BWDE2MTkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01B
WDE2NjggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE5NyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTUFYNjYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFY
NjYzOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjY0MiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTUFYNjY1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFY
NjY5NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMzE3OTAgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX01DUDMwMjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RD
NjU0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTYzIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19MTTczIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19MTTc4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTgwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19MTTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTg1IGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTg3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MTTkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkyIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19MTTkzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTk1
MjM0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTk1MjQxIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19MTTk1MjQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQzg3
MzYwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQzg3NDI3IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19OVENfVEhFUk1JU1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfTkNUNjY4MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNjc3NSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNzgwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfTkNUNzkwNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUENGODU5MSBpcyBub3Qg
c2V0CiMgQ09ORklHX1BNQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSFQyMSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUM3ggaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX1NIVEMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSVM1NTk1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19ETUUxNzM3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19FTUMxNDAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUMyMTAzIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUM2VzIwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfU01TQzQ3TTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N00xOTIg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N0IzOTcgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1NDSDU2MjcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NDSDU2
MzYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NUVFM3NTEgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1NNTTY2NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURDMTI4
RDgxOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURTMTAxNSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfQURTNzgyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQU1D
NjgyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSU5BMjA5IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19JTkEyWFggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lOQTMy
MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RDNzQgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1RITUM1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QMTAyIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVAxMDMgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX1RNUDEwOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QNDAxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVA0MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1ZJQV9DUFVURU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19WSUE2ODZBIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19WVDEyMTEgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX1ZUODIzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNzczRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNzgxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfVzgzNzkxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNzkyRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNzkzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19XODM3OTUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4M0w3ODVUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzTDc4Nk5HIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19XODM2MjdIRiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNjI3RUhG
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19YR0VORSBpcyBub3Qgc2V0CgojCiMgQUNQ
SSBkcml2ZXJzCiMKIyBDT05GSUdfU0VOU09SU19BQ1BJX1BPV0VSIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19BVEswMTEwIGlzIG5vdCBzZXQKQ09ORklHX1RIRVJNQUw9eQojIENP
TkZJR19USEVSTUFMX1NUQVRJU1RJQ1MgaXMgbm90IHNldApDT05GSUdfVEhFUk1BTF9FTUVS
R0VOQ1lfUE9XRVJPRkZfREVMQVlfTVM9MApDT05GSUdfVEhFUk1BTF9IV01PTj15CkNPTkZJ
R19USEVSTUFMX1dSSVRBQkxFX1RSSVBTPXkKQ09ORklHX1RIRVJNQUxfREVGQVVMVF9HT1Zf
U1RFUF9XSVNFPXkKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9GQUlSX1NIQVJFIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9VU0VSX1NQQUNFIGlzIG5v
dCBzZXQKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9QT1dFUl9BTExPQ0FUT1IgaXMg
bm90IHNldAojIENPTkZJR19USEVSTUFMX0dPVl9GQUlSX1NIQVJFIGlzIG5vdCBzZXQKQ09O
RklHX1RIRVJNQUxfR09WX1NURVBfV0lTRT15CiMgQ09ORklHX1RIRVJNQUxfR09WX0JBTkdf
QkFORyBpcyBub3Qgc2V0CkNPTkZJR19USEVSTUFMX0dPVl9VU0VSX1NQQUNFPXkKIyBDT05G
SUdfVEhFUk1BTF9HT1ZfUE9XRVJfQUxMT0NBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhF
Uk1BTF9FTVVMQVRJT04gaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9QT1dFUkNMQU1QIGlz
IG5vdCBzZXQKQ09ORklHX1g4Nl9QS0dfVEVNUF9USEVSTUFMPW0KIyBDT05GSUdfSU5URUxf
U09DX0RUU19USEVSTUFMIGlzIG5vdCBzZXQKCiMKIyBBQ1BJIElOVDM0MFggdGhlcm1hbCBk
cml2ZXJzCiMKIyBDT05GSUdfSU5UMzQwWF9USEVSTUFMIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5URUxfUENIX1RIRVJNQUwgaXMgbm90IHNldApDT05GSUdfV0FUQ0hET0c9eQojIENPTkZJ
R19XQVRDSERPR19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FUQ0hET0dfTk9XQVlPVVQg
aXMgbm90IHNldApDT05GSUdfV0FUQ0hET0dfSEFORExFX0JPT1RfRU5BQkxFRD15CiMgQ09O
RklHX1dBVENIRE9HX1NZU0ZTIGlzIG5vdCBzZXQKCiMKIyBXYXRjaGRvZyBEZXZpY2UgRHJp
dmVycwojCiMgQ09ORklHX1NPRlRfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19XREFU
X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9XQVRDSERPRyBpcyBub3Qgc2V0CiMg
Q09ORklHX1pJSVJBVkVfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19DQURFTkNFX1dB
VENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfRFdfV0FUQ0hET0cgaXMgbm90IHNldAojIENP
TkZJR19NQVg2M1hYX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNRVUlSRV9XRFQg
aXMgbm90IHNldAojIENPTkZJR19BRFZBTlRFQ0hfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdf
QUxJTTE1MzVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxJTTcxMDFfV0RUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRUJDX0MzODRfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfRjcxODA4RV9X
RFQgaXMgbm90IHNldAojIENPTkZJR19TUDUxMDBfVENPIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0JDX0ZJVFBDMl9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0VVUk9URUNIX1dEVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lCNzAwX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTUFT
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1dBRkVSX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0k2
MzAwRVNCX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lFNlhYX1dEVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lUQ09fV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVQ4NzEyRl9XRFQgaXMgbm90
IHNldAojIENPTkZJR19JVDg3X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0hQX1dBVENIRE9H
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0MxMjAwX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BD
ODc0MTNfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZfVENPIGlzIG5vdCBzZXQKIyBDT05G
SUdfNjBYWF9XRFQgaXMgbm90IHNldAojIENPTkZJR19DUFU1X1dEVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NNU0NfU0NIMzExWF9XRFQgaXMgbm90IHNldAojIENPTkZJR19TTVNDMzdCNzg3
X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJQV9XRFQgaXMgbm90IHNldAojIENPTkZJR19X
ODM2MjdIRl9XRFQgaXMgbm90IHNldAojIENPTkZJR19XODM4NzdGX1dEVCBpcyBub3Qgc2V0
CiMgQ09ORklHX1c4Mzk3N0ZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDSFpfV0RUIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0JDX0VQWF9DM19XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09O
RklHX05JOTAzWF9XRFQgaXMgbm90IHNldAojIENPTkZJR19OSUM3MDE4X1dEVCBpcyBub3Qg
c2V0CgojCiMgUENJLWJhc2VkIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfUENJUENXQVRD
SERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX1dEVFBDSSBpcyBub3Qgc2V0CgojCiMgVVNCLWJh
c2VkIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfVVNCUENXQVRDSERPRyBpcyBub3Qgc2V0
CgojCiMgV2F0Y2hkb2cgUHJldGltZW91dCBHb3Zlcm5vcnMKIwojIENPTkZJR19XQVRDSERP
R19QUkVUSU1FT1VUX0dPViBpcyBub3Qgc2V0CkNPTkZJR19TU0JfUE9TU0lCTEU9eQojIENP
TkZJR19TU0IgaXMgbm90IHNldApDT05GSUdfQkNNQV9QT1NTSUJMRT15CiMgQ09ORklHX0JD
TUEgaXMgbm90IHNldAoKIwojIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKIwojIENP
TkZJR19NRkRfQVMzNzExIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1JQ19BRFA1NTIwIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX0JDTTU5MFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JE
OTU3MU1XViBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BWFAyMFhfSTJDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX0NST1NfRUMgaXMgbm90IHNldAojIENPTkZJR19QTUlDX0RBOTAzWCBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNTJfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX0RBOTA1NSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNjIgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfREE5MDYzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RBOTE1MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9ETE4yIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01DMTNY
WFhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfSFRDX1BBU0lDMyBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9JTlRFTF9RVUFSS19JMkNfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0xQQ19J
Q0ggaXMgbm90IHNldAojIENPTkZJR19MUENfU0NIIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5U
RUxfU09DX1BNSUNfQ0hUV0MgaXMgbm90IHNldAojIENPTkZJR19NRkRfSU5URUxfTFBTU19B
Q1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lOVEVMX0xQU1NfUENJIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX0pBTlpfQ01PRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0tFTVBM
RCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF84OFBNODAwIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEXzg4UE04MDUgaXMgbm90IHNldAojIENPTkZJR19NRkRfODhQTTg2MFggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfTUFYMTQ1NzcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc2
OTMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc4NDMgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfTUFYODkwNyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NQVg4OTI1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX01BWDg5OTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODk5
OCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NVDYzOTcgaXMgbm90IHNldAojIENPTkZJR19N
RkRfTUVORjIxQk1DIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1ZJUEVSQk9BUkQgaXMgbm90
IHNldAojIENPTkZJR19NRkRfUkVUVSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9QQ0Y1MDYz
MyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SREMzMjFYIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SQzVUNTgzIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX1NFQ19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NJNDc2WF9D
T1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNNTAxIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1NLWTgxNDUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNU0MgaXMgbm90IHNldAoj
IENPTkZJR19BQlg1MDBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TWVNDT04gaXMg
bm90IHNldAojIENPTkZJR19NRkRfVElfQU0zMzVYX1RTQ0FEQyBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9MUDM5NDMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTFA4Nzg4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX1RJX0xNVSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9QQUxNQVMg
aXMgbm90IHNldAojIENPTkZJR19UUFM2MTA1WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RQUzY1
MDdYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1MDg2IGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX1RQUzY1MDkwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY4NDcwIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1RJX0xQODczWCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9U
UFM2NTg2WCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UUFM2NTkxMl9JMkMgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfVFBTODAwMzEgaXMgbm90IHNldAojIENPTkZJR19UV0w0MDMwX0NP
UkUgaXMgbm90IHNldAojIENPTkZJR19UV0w2MDQwX0NPUkUgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfV0wxMjczX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfTE0zNTMzIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1ZYODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpP
TkFfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1dNODQwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9XTTgzMVhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1dNODM1MF9JMkMg
aXMgbm90IHNldAojIENPTkZJR19NRkRfV004OTk0IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVH
VUxBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklH
X01FRElBX1NVUFBPUlQgaXMgbm90IHNldAoKIwojIEdyYXBoaWNzIHN1cHBvcnQKIwpDT05G
SUdfQUdQPXkKQ09ORklHX0FHUF9BTUQ2ND15CkNPTkZJR19BR1BfSU5URUw9eQojIENPTkZJ
R19BR1BfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX1ZJQSBpcyBub3Qgc2V0CkNPTkZJ
R19JTlRFTF9HVFQ9eQpDT05GSUdfVkdBX0FSQj15CkNPTkZJR19WR0FfQVJCX01BWF9HUFVT
PTE2CiMgQ09ORklHX1ZHQV9TV0lUQ0hFUk9PIGlzIG5vdCBzZXQKQ09ORklHX0RSTT15CkNP
TkZJR19EUk1fTUlQSV9EU0k9eQojIENPTkZJR19EUk1fRFBfQVVYX0NIQVJERVYgaXMgbm90
IHNldAojIENPTkZJR19EUk1fREVCVUdfTU0gaXMgbm90IHNldAojIENPTkZJR19EUk1fREVC
VUdfTU1fU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfRFJNX0tNU19IRUxQRVI9eQpDT05G
SUdfRFJNX0tNU19GQl9IRUxQRVI9eQpDT05GSUdfRFJNX0ZCREVWX0VNVUxBVElPTj15CkNP
TkZJR19EUk1fRkJERVZfT1ZFUkFMTE9DPTEwMAojIENPTkZJR19EUk1fTE9BRF9FRElEX0ZJ
Uk1XQVJFIGlzIG5vdCBzZXQKQ09ORklHX0RSTV9UVE09eQoKIwojIEkyQyBlbmNvZGVyIG9y
IGhlbHBlciBjaGlwcwojCiMgQ09ORklHX0RSTV9JMkNfQ0g3MDA2IGlzIG5vdCBzZXQKIyBD
T05GSUdfRFJNX0kyQ19TSUwxNjQgaXMgbm90IHNldAojIENPTkZJR19EUk1fSTJDX05YUF9U
REE5OThYIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1JBREVPTiBpcyBub3Qgc2V0CiMgQ09O
RklHX0RSTV9BTURHUFUgaXMgbm90IHNldAoKIwojIEFDUCAoQXVkaW8gQ29Qcm9jZXNzb3Ip
IENvbmZpZ3VyYXRpb24KIwoKIwojIEFNRCBMaWJyYXJ5IHJvdXRpbmVzCiMKIyBDT05GSUdf
RFJNX05PVVZFQVUgaXMgbm90IHNldApDT05GSUdfRFJNX0k5MTU9eQojIENPTkZJR19EUk1f
STkxNV9BTFBIQV9TVVBQT1JUIGlzIG5vdCBzZXQKQ09ORklHX0RSTV9JOTE1X0NBUFRVUkVf
RVJST1I9eQpDT05GSUdfRFJNX0k5MTVfQ09NUFJFU1NfRVJST1I9eQpDT05GSUdfRFJNX0k5
MTVfVVNFUlBUUj15CiMgQ09ORklHX0RSTV9JOTE1X0dWVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9WR0VNIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1ZNV0dGWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0RSTV9HTUE1MDAgaXMgbm90IHNldAojIENPTkZJR19EUk1fVURMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFJNX0FTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9NR0FHMjAwIGlz
IG5vdCBzZXQKIyBDT05GSUdfRFJNX0NJUlJVU19RRU1VIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX1FYTCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9CT0NIUyBpcyBub3Qgc2V0CkNPTkZJ
R19EUk1fVklSVElPX0dQVT15CkNPTkZJR19EUk1fUEFORUw9eQoKIwojIERpc3BsYXkgUGFu
ZWxzCiMKIyBDT05GSUdfRFJNX1BBTkVMX1JBU1BCRVJSWVBJX1RPVUNIU0NSRUVOIGlzIG5v
dCBzZXQKQ09ORklHX0RSTV9CUklER0U9eQpDT05GSUdfRFJNX1BBTkVMX0JSSURHRT15Cgoj
CiMgRGlzcGxheSBJbnRlcmZhY2UgQnJpZGdlcwojCiMgQ09ORklHX0RSTV9BTkFMT0dJWF9B
Tlg3OFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0hJU0lfSElCTUMgaXMgbm90IHNldAoj
IENPTkZJR19EUk1fVElOWURSTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9MRUdBQ1kgaXMg
bm90IHNldApDT05GSUdfRFJNX1BBTkVMX09SSUVOVEFUSU9OX1FVSVJLUz15CgojCiMgRnJh
bWUgYnVmZmVyIERldmljZXMKIwpDT05GSUdfRkI9eQojIENPTkZJR19GSVJNV0FSRV9FRElE
IGlzIG5vdCBzZXQKQ09ORklHX0ZCX0NNRExJTkU9eQpDT05GSUdfRkJfTk9USUZZPXkKQ09O
RklHX0ZCX0NGQl9GSUxMUkVDVD15CkNPTkZJR19GQl9DRkJfQ09QWUFSRUE9eQpDT05GSUdf
RkJfQ0ZCX0lNQUdFQkxJVD15CkNPTkZJR19GQl9TWVNfRklMTFJFQ1Q9eQpDT05GSUdfRkJf
U1lTX0NPUFlBUkVBPXkKQ09ORklHX0ZCX1NZU19JTUFHRUJMSVQ9eQojIENPTkZJR19GQl9G
T1JFSUdOX0VORElBTiBpcyBub3Qgc2V0CkNPTkZJR19GQl9TWVNfRk9QUz15CkNPTkZJR19G
Ql9ERUZFUlJFRF9JTz15CkNPTkZJR19GQl9NT0RFX0hFTFBFUlM9eQpDT05GSUdfRkJfVElM
RUJMSVRUSU5HPXkKCiMKIyBGcmFtZSBidWZmZXIgaGFyZHdhcmUgZHJpdmVycwojCiMgQ09O
RklHX0ZCX0NJUlJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1BNMiBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZCX0NZQkVSMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FSQyBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZCX0FTSUxJQU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSU1TVFQg
aXMgbm90IHNldAojIENPTkZJR19GQl9WR0ExNiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1VW
RVNBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVkVTQSBpcyBub3Qgc2V0CkNPTkZJR19GQl9F
Rkk9eQojIENPTkZJR19GQl9ONDExIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSEdBIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfT1BFTkNPUkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUzFE
MTNYWFggaXMgbm90IHNldAojIENPTkZJR19GQl9OVklESUEgaXMgbm90IHNldAojIENPTkZJ
R19GQl9SSVZBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSTc0MCBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX0xFODA1NzggaXMgbm90IHNldAojIENPTkZJR19GQl9NQVRST1ggaXMgbm90IHNl
dAojIENPTkZJR19GQl9SQURFT04gaXMgbm90IHNldAojIENPTkZJR19GQl9BVFkxMjggaXMg
bm90IHNldAojIENPTkZJR19GQl9BVFkgaXMgbm90IHNldAojIENPTkZJR19GQl9TMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZCX1NBVkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NJUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX05FT01BR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
S1lSTyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCXzNERlggaXMgbm90IHNldAojIENPTkZJR19G
Ql9WT09ET08xIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVlQ4NjIzIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfVFJJREVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FSSyBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1BNMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NBUk1JTkUgaXMgbm90
IHNldAojIENPTkZJR19GQl9TTVNDVUZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVURMIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkJfSUJNX0dYVDQ1MDAgaXMgbm90IHNldAojIENPTkZJR19G
Ql9WSVJUVUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUVUUk9OT01FIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfTUI4NjJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0JST0FEU0hFRVQg
aXMgbm90IHNldAojIENPTkZJR19GQl9BVU9fSzE5MFggaXMgbm90IHNldAojIENPTkZJR19G
Ql9TSU1QTEUgaXMgbm90IHNldAojIENPTkZJR19GQl9TTTcxMiBpcyBub3Qgc2V0CkNPTkZJ
R19CQUNLTElHSFRfTENEX1NVUFBPUlQ9eQojIENPTkZJR19MQ0RfQ0xBU1NfREVWSUNFIGlz
IG5vdCBzZXQKQ09ORklHX0JBQ0tMSUdIVF9DTEFTU19ERVZJQ0U9eQpDT05GSUdfQkFDS0xJ
R0hUX0dFTkVSSUM9eQojIENPTkZJR19CQUNLTElHSFRfQVBQTEUgaXMgbm90IHNldAojIENP
TkZJR19CQUNLTElHSFRfUE04OTQxX1dMRUQgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElH
SFRfU0FIQVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0FEUDg4NjAgaXMgbm90
IHNldAojIENPTkZJR19CQUNLTElHSFRfQURQODg3MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JB
Q0tMSUdIVF9MTTM2MzkgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfTFY1MjA3TFAg
aXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfQkQ2MTA3IGlzIG5vdCBzZXQKIyBDT05G
SUdfQkFDS0xJR0hUX0FSQ1hDTk4gaXMgbm90IHNldApDT05GSUdfSERNST15CgojCiMgQ29u
c29sZSBkaXNwbGF5IGRyaXZlciBzdXBwb3J0CiMKQ09ORklHX1ZHQV9DT05TT0xFPXkKQ09O
RklHX1ZHQUNPTl9TT0ZUX1NDUk9MTEJBQ0s9eQpDT05GSUdfVkdBQ09OX1NPRlRfU0NST0xM
QkFDS19TSVpFPTY0CiMgQ09ORklHX1ZHQUNPTl9TT0ZUX1NDUk9MTEJBQ0tfUEVSU0lTVEVO
VF9FTkFCTEVfQllfREVGQVVMVCBpcyBub3Qgc2V0CkNPTkZJR19EVU1NWV9DT05TT0xFPXkK
Q09ORklHX0RVTU1ZX0NPTlNPTEVfQ09MVU1OUz04MApDT05GSUdfRFVNTVlfQ09OU09MRV9S
T1dTPTI1CkNPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFPXkKQ09ORklHX0ZSQU1FQlVGRkVS
X0NPTlNPTEVfREVURUNUX1BSSU1BUlk9eQojIENPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xF
X1JPVEFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0xPR089eQojIENPTkZJR19MT0dPX0xJTlVY
X01PTk8gaXMgbm90IHNldAojIENPTkZJR19MT0dPX0xJTlVYX1ZHQTE2IGlzIG5vdCBzZXQK
Q09ORklHX0xPR09fTElOVVhfQ0xVVDIyND15CkNPTkZJR19TT1VORD15CkNPTkZJR19TTkQ9
eQpDT05GSUdfU05EX1RJTUVSPXkKQ09ORklHX1NORF9QQ009eQpDT05GSUdfU05EX0hXREVQ
PXkKQ09ORklHX1NORF9TRVFfREVWSUNFPXkKQ09ORklHX1NORF9KQUNLPXkKQ09ORklHX1NO
RF9KQUNLX0lOUFVUX0RFVj15CiMgQ09ORklHX1NORF9PU1NFTVVMIGlzIG5vdCBzZXQKQ09O
RklHX1NORF9QQ01fVElNRVI9eQpDT05GSUdfU05EX0hSVElNRVI9eQojIENPTkZJR19TTkRf
RFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldApDT05GSUdfU05EX1NVUFBPUlRfT0xEX0FQST15
CkNPTkZJR19TTkRfUFJPQ19GUz15CkNPTkZJR19TTkRfVkVSQk9TRV9QUk9DRlM9eQojIENP
TkZJR19TTkRfVkVSQk9TRV9QUklOVEsgaXMgbm90IHNldAojIENPTkZJR19TTkRfREVCVUcg
aXMgbm90IHNldApDT05GSUdfU05EX1ZNQVNURVI9eQpDT05GSUdfU05EX0RNQV9TR0JVRj15
CkNPTkZJR19TTkRfU0VRVUVOQ0VSPXkKQ09ORklHX1NORF9TRVFfRFVNTVk9eQpDT05GSUdf
U05EX1NFUV9IUlRJTUVSX0RFRkFVTFQ9eQpDT05GSUdfU05EX0RSSVZFUlM9eQojIENPTkZJ
R19TTkRfUENTUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9EVU1NWSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9BTE9PUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSVJNSURJIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX01UUEFWIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NFUklB
TF9VMTY1NTAgaXMgbm90IHNldAojIENPTkZJR19TTkRfTVBVNDAxIGlzIG5vdCBzZXQKQ09O
RklHX1NORF9QQ0k9eQojIENPTkZJR19TTkRfQUQxODg5IGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0FMUzMwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BTFM0MDAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0FMSTU0NTEgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVNJSFBJIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0FUSUlYUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9B
VElJWFBfTU9ERU0gaXMgbm90IHNldAojIENPTkZJR19TTkRfQVU4ODEwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0FVODgyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BVTg4MzAgaXMg
bm90IHNldAojIENPTkZJR19TTkRfQVcyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FaVDMz
MjggaXMgbm90IHNldAojIENPTkZJR19TTkRfQlQ4N1ggaXMgbm90IHNldAojIENPTkZJR19T
TkRfQ0EwMTA2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NNSVBDSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9PWFlHRU4gaXMgbm90IHNldAojIENPTkZJR19TTkRfQ1M0MjgxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0NTNDZYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DVFhG
SSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9EQVJMQTIwIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0dJTkEyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9MQVlMQTIwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0RBUkxBMjQgaXMgbm90IHNldAojIENPTkZJR19TTkRfR0lOQTI0IGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0xBWUxBMjQgaXMgbm90IHNldAojIENPTkZJR19TTkRf
TU9OQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NSUEgaXMgbm90IHNldAojIENPTkZJR19T
TkRfRUNITzNHIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHTyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9JTkRJR09JTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTkRJR09ESiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTkRJR09JT1ggaXMgbm90IHNldAojIENPTkZJR19T
TkRfSU5ESUdPREpYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VNVTEwSzEgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfRU1VMTBLMVggaXMgbm90IHNldAojIENPTkZJR19TTkRfRU5TMTM3
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FTlMxMzcxIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0VTMTkzOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FUzE5NjggaXMgbm90IHNldAoj
IENPTkZJR19TTkRfRk04MDEgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERTUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9IRFNQTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JQ0UxNzEy
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lDRTE3MjQgaXMgbm90IHNldAojIENPTkZJR19T
TkRfSU5URUw4WDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5URUw4WDBNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX0tPUkcxMjEyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0xPTEEg
aXMgbm90IHNldAojIENPTkZJR19TTkRfTFg2NDY0RVMgaXMgbm90IHNldAojIENPTkZJR19T
TkRfTUFFU1RSTzMgaXMgbm90IHNldAojIENPTkZJR19TTkRfTUlYQVJUIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX05NMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1BDWEhSIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1JJUFRJREUgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1F
MzIgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1FOTYgaXMgbm90IHNldAojIENPTkZJR19T
TkRfUk1FOTY1MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TRTZYIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1NPTklDVklCRVMgaXMgbm90IHNldAojIENPTkZJR19TTkRfVFJJREVOVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSUE4MlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1ZJQTgyWFhfTU9ERU0gaXMgbm90IHNldAojIENPTkZJR19TTkRfVklSVFVPU08gaXMgbm90
IHNldAojIENPTkZJR19TTkRfVlgyMjIgaXMgbm90IHNldAojIENPTkZJR19TTkRfWU1GUENJ
IGlzIG5vdCBzZXQKCiMKIyBIRC1BdWRpbwojCkNPTkZJR19TTkRfSERBPXkKQ09ORklHX1NO
RF9IREFfSU5URUw9eQpDT05GSUdfU05EX0hEQV9IV0RFUD15CiMgQ09ORklHX1NORF9IREFf
UkVDT05GSUcgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0lOUFVUX0JFRVAgaXMgbm90
IHNldAojIENPTkZJR19TTkRfSERBX1BBVENIX0xPQURFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9IREFfQ09ERUNfUkVBTFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09E
RUNfQU5BTE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19TSUdNQVRFTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfVklBIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0hEQV9DT0RFQ19IRE1JIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RF
Q19DSVJSVVMgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX0NPTkVYQU5UIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19DQTAxMTAgaXMgbm90IHNldAojIENP
TkZJR19TTkRfSERBX0NPREVDX0NBMDEzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFf
Q09ERUNfQ01FRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19TSTMwNTQg
aXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0dFTkVSSUMgaXMgbm90IHNldApDT05GSUdf
U05EX0hEQV9QT1dFUl9TQVZFX0RFRkFVTFQ9MApDT05GSUdfU05EX0hEQV9DT1JFPXkKQ09O
RklHX1NORF9IREFfSTkxNT15CkNPTkZJR19TTkRfSERBX1BSRUFMTE9DX1NJWkU9NjQKQ09O
RklHX1NORF9VU0I9eQojIENPTkZJR19TTkRfVVNCX0FVRElPIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1VTQl9VQTEwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVVNYMlkgaXMg
bm90IHNldAojIENPTkZJR19TTkRfVVNCX0NBSUFRIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1VTQl9VUzEyMkwgaXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCXzZGSVJFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1VTQl9ISUZBQ0UgaXMgbm90IHNldAojIENPTkZJR19TTkRfQkNE
MjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfUE9EIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1VTQl9QT0RIRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVE9ORVBPUlQg
aXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCX1ZBUklBWCBpcyBub3Qgc2V0CkNPTkZJR19T
TkRfUENNQ0lBPXkKIyBDT05GSUdfU05EX1ZYUE9DS0VUIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX1BEQVVESU9DRiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT0MgaXMgbm90IHNldApD
T05GSUdfU05EX1g4Nj15CiMgQ09ORklHX0hETUlfTFBFX0FVRElPIGlzIG5vdCBzZXQKCiMK
IyBISUQgc3VwcG9ydAojCkNPTkZJR19ISUQ9eQojIENPTkZJR19ISURfQkFUVEVSWV9TVFJF
TkdUSCBpcyBub3Qgc2V0CkNPTkZJR19ISURSQVc9eQojIENPTkZJR19VSElEIGlzIG5vdCBz
ZXQKQ09ORklHX0hJRF9HRU5FUklDPXkKCiMKIyBTcGVjaWFsIEhJRCBkcml2ZXJzCiMKQ09O
RklHX0hJRF9BNFRFQ0g9eQojIENPTkZJR19ISURfQUNDVVRPVUNIIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX0FDUlVYIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9BUFBMRT15CiMgQ09ORklH
X0hJRF9BUFBMRUlSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FTVVMgaXMgbm90IHNldAoj
IENPTkZJR19ISURfQVVSRUFMIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9CRUxLSU49eQojIENP
TkZJR19ISURfQkVUT1BfRkYgaXMgbm90IHNldApDT05GSUdfSElEX0NIRVJSWT15CkNPTkZJ
R19ISURfQ0hJQ09OWT15CiMgQ09ORklHX0hJRF9DT1JTQUlSIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX1BST0RJS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DTUVESUEgaXMgbm90
IHNldApDT05GSUdfSElEX0NZUFJFU1M9eQojIENPTkZJR19ISURfRFJBR09OUklTRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9FTVNfRkYgaXMgbm90IHNldAojIENPTkZJR19ISURfRUxB
TiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9FTEVDT00gaXMgbm90IHNldAojIENPTkZJR19I
SURfRUxPIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9FWktFWT15CiMgQ09ORklHX0hJRF9HRU1C
SVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dGUk0gaXMgbm90IHNldAojIENPTkZJR19I
SURfSE9MVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dPT0dMRV9IQU1NRVIgaXMgbm90
IHNldAojIENPTkZJR19ISURfR1Q2ODNSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tFWVRP
VUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tZRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9VQ0xPR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dBTFRPUCBpcyBub3Qgc2V0CkNP
TkZJR19ISURfR1lSQVRJT049eQojIENPTkZJR19ISURfSUNBREUgaXMgbm90IHNldApDT05G
SUdfSElEX0lURT15CiMgQ09ORklHX0hJRF9KQUJSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9UV0lOSEFOIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9LRU5TSU5HVE9OPXkKIyBDT05GSUdf
SElEX0xDUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19ISURfTEVEIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX0xFTk9WTyBpcyBub3Qgc2V0CkNPTkZJR19ISURfTE9HSVRFQ0g9eQojIENP
TkZJR19ISURfTE9HSVRFQ0hfREogaXMgbm90IHNldAojIENPTkZJR19ISURfTE9HSVRFQ0hf
SElEUFAgaXMgbm90IHNldApDT05GSUdfTE9HSVRFQ0hfRkY9eQojIENPTkZJR19MT0dJUlVN
QkxFUEFEMl9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0xPR0lHOTQwX0ZGIGlzIG5vdCBzZXQK
Q09ORklHX0xPR0lXSEVFTFNfRkY9eQojIENPTkZJR19ISURfTUFHSUNNT1VTRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9NQVlGTEFTSCBpcyBub3Qgc2V0CkNPTkZJR19ISURfTUlDUk9T
T0ZUPXkKQ09ORklHX0hJRF9NT05URVJFWT15CiMgQ09ORklHX0hJRF9NVUxUSVRPVUNIIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX05USSBpcyBub3Qgc2V0CkNPTkZJR19ISURfTlRSSUc9
eQojIENPTkZJR19ISURfT1JURUsgaXMgbm90IHNldApDT05GSUdfSElEX1BBTlRIRVJMT1JE
PXkKQ09ORklHX1BBTlRIRVJMT1JEX0ZGPXkKIyBDT05GSUdfSElEX1BFTk1PVU5UIGlzIG5v
dCBzZXQKQ09ORklHX0hJRF9QRVRBTFlOWD15CiMgQ09ORklHX0hJRF9QSUNPTENEIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX1BMQU5UUk9OSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X1BSSU1BWCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9SRVRST0RFIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX1JPQ0NBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TQUlURUsgaXMgbm90
IHNldApDT05GSUdfSElEX1NBTVNVTkc9eQpDT05GSUdfSElEX1NPTlk9eQojIENPTkZJR19T
T05ZX0ZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NQRUVETElOSyBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9TVEVFTFNFUklFUyBpcyBub3Qgc2V0CkNPTkZJR19ISURfU1VOUExVUz15
CiMgQ09ORklHX0hJRF9STUkgaXMgbm90IHNldAojIENPTkZJR19ISURfR1JFRU5BU0lBIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX1NNQVJUSk9ZUExVUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9USVZPIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9UT1BTRUVEPXkKIyBDT05GSUdfSElE
X1RISU5HTSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9USFJVU1RNQVNURVIgaXMgbm90IHNl
dAojIENPTkZJR19ISURfVURSQVdfUFMzIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dBQ09N
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dJSU1PVEUgaXMgbm90IHNldAojIENPTkZJR19I
SURfWElOTU8gaXMgbm90IHNldAojIENPTkZJR19ISURfWkVST1BMVVMgaXMgbm90IHNldAoj
IENPTkZJR19ISURfWllEQUNST04gaXMgbm90IHNldAojIENPTkZJR19ISURfU0VOU09SX0hV
QiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BTFBTIGlzIG5vdCBzZXQKCiMKIyBVU0IgSElE
IHN1cHBvcnQKIwpDT05GSUdfVVNCX0hJRD15CkNPTkZJR19ISURfUElEPXkKQ09ORklHX1VT
Ql9ISURERVY9eQoKIwojIEkyQyBISUQgc3VwcG9ydAojCiMgQ09ORklHX0kyQ19ISUQgaXMg
bm90IHNldAoKIwojIEludGVsIElTSCBISUQgc3VwcG9ydAojCiMgQ09ORklHX0lOVEVMX0lT
SF9ISUQgaXMgbm90IHNldApDT05GSUdfVVNCX09IQ0lfTElUVExFX0VORElBTj15CkNPTkZJ
R19VU0JfU1VQUE9SVD15CkNPTkZJR19VU0JfQ09NTU9OPXkKQ09ORklHX1VTQl9BUkNIX0hB
U19IQ0Q9eQpDT05GSUdfVVNCPXkKQ09ORklHX1VTQl9QQ0k9eQpDT05GSUdfVVNCX0FOTk9V
TkNFX05FV19ERVZJQ0VTPXkKCiMKIyBNaXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09O
RklHX1VTQl9ERUZBVUxUX1BFUlNJU1Q9eQojIENPTkZJR19VU0JfRFlOQU1JQ19NSU5PUlMg
aXMgbm90IHNldAojIENPTkZJR19VU0JfT1RHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09U
R19XSElURUxJU1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEVEU19UUklHR0VSX1VTQlBP
UlQgaXMgbm90IHNldApDT05GSUdfVVNCX01PTj15CiMgQ09ORklHX1VTQl9XVVNCX0NCQUYg
aXMgbm90IHNldAoKIwojIFVTQiBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwojCiMgQ09ORklH
X1VTQl9DNjdYMDBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1hIQ0lfSENEIGlzIG5v
dCBzZXQKQ09ORklHX1VTQl9FSENJX0hDRD15CiMgQ09ORklHX1VTQl9FSENJX1JPT1RfSFVC
X1RUIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9FSENJX1RUX05FV1NDSEVEPXkKQ09ORklHX1VT
Ql9FSENJX1BDST15CiMgQ09ORklHX1VTQl9FSENJX0hDRF9QTEFURk9STSBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9PWFUyMTBIUF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNQ
MTE2WF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfRk9URzIxMF9IQ0QgaXMgbm90IHNl
dApDT05GSUdfVVNCX09IQ0lfSENEPXkKQ09ORklHX1VTQl9PSENJX0hDRF9QQ0k9eQojIENP
TkZJR19VU0JfT0hDSV9IQ0RfUExBVEZPUk0gaXMgbm90IHNldApDT05GSUdfVVNCX1VIQ0lf
SENEPXkKIyBDT05GSUdfVVNCX1NMODExX0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9S
OEE2NjU5N19IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfSENEX1RFU1RfTU9ERSBpcyBu
b3Qgc2V0CgojCiMgVVNCIERldmljZSBDbGFzcyBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX0FD
TSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfUFJJTlRFUj15CiMgQ09ORklHX1VTQl9XRE0gaXMg
bm90IHNldAojIENPTkZJR19VU0JfVE1DIGlzIG5vdCBzZXQKCiMKIyBOT1RFOiBVU0JfU1RP
UkFHRSBkZXBlbmRzIG9uIFNDU0kgYnV0IEJMS19ERVZfU0QgbWF5CiMKCiMKIyBhbHNvIGJl
IG5lZWRlZDsgc2VlIFVTQl9TVE9SQUdFIEhlbHAgZm9yIG1vcmUgaW5mbwojCkNPTkZJR19V
U0JfU1RPUkFHRT15CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RFQlVHIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NUT1JBR0VfUkVBTFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9S
QUdFX0RBVEFGQUIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9GUkVFQ09NIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSVNEMjAwIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NUT1JBR0VfVVNCQVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9T
RERSMDkgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9TRERSNTUgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU1RPUkFHRV9KVU1QU0hPVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TVE9SQUdFX0FMQVVEQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX09ORVRP
VUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfS0FSTUEgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU1RPUkFHRV9DWVBSRVNTX0FUQUNCIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NUT1JBR0VfRU5FX1VCNjI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9VQVMgaXMg
bm90IHNldAoKIwojIFVTQiBJbWFnaW5nIGRldmljZXMKIwojIENPTkZJR19VU0JfTURDODAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01JQ1JPVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCSVBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NVVNCX0hEUkMgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfRFdDMyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EV0MyIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0NISVBJREVBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lT
UDE3NjAgaXMgbm90IHNldAoKIwojIFVTQiBwb3J0IGRyaXZlcnMKIwojIENPTkZJR19VU0Jf
U0VSSUFMIGlzIG5vdCBzZXQKCiMKIyBVU0IgTWlzY2VsbGFuZW91cyBkcml2ZXJzCiMKIyBD
T05GSUdfVVNCX0VNSTYyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VNSTI2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX0FEVVRVWCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVZTRUcg
aXMgbm90IHNldAojIENPTkZJR19VU0JfUklPNTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0xFR09UT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MQ0QgaXMgbm90IHNldAojIENP
TkZJR19VU0JfQ1lQUkVTU19DWTdDNjMgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ1lUSEVS
TSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JRE1PVVNFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0ZURElfRUxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BUFBMRURJU1BMQVkgaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0lTVVNCVkdBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RSQU5DRVZJQlJBVE9SIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0lPV0FSUklPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9URVNUIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0VIU0VUX1RFU1RfRklYVFVSRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9JU0lHSFRGVyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ZVVJFWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9FWlVTQl9GWDIgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
SFVCX1VTQjI1MVhCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hTSUNfVVNCMzUwMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9IU0lDX1VTQjQ2MDQgaXMgbm90IHNldAojIENPTkZJR19V
U0JfTElOS19MQVlFUl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NIQU9TS0VZIGlz
IG5vdCBzZXQKCiMKIyBVU0IgUGh5c2ljYWwgTGF5ZXIgZHJpdmVycwojCiMgQ09ORklHX05P
UF9VU0JfWENFSVYgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNQMTMwMSBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9HQURHRVQgaXMgbm90IHNldAojIENPTkZJR19UWVBFQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9MRURfVFJJRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9VTFBJ
X0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VXQiBpcyBub3Qgc2V0CiMgQ09ORklHX01NQyBp
cyBub3Qgc2V0CiMgQ09ORklHX01FTVNUSUNLIGlzIG5vdCBzZXQKQ09ORklHX05FV19MRURT
PXkKQ09ORklHX0xFRFNfQ0xBU1M9eQojIENPTkZJR19MRURTX0NMQVNTX0ZMQVNIIGlzIG5v
dCBzZXQKIyBDT05GSUdfTEVEU19CUklHSFRORVNTX0hXX0NIQU5HRUQgaXMgbm90IHNldAoK
IwojIExFRCBkcml2ZXJzCiMKIyBDT05GSUdfTEVEU19BUFUgaXMgbm90IHNldAojIENPTkZJ
R19MRURTX0xNMzUzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTE0zNjQyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEVEU19QQ0E5NTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDM5
NDQgaXMgbm90IHNldAojIENPTkZJR19MRURTX0xQNTUyMSBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfTFA1NTIzIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDU1NjIgaXMgbm90IHNl
dAojIENPTkZJR19MRURTX0xQODUwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQ0xFVk9f
TUFJTCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfUENBOTU1WCBpcyBub3Qgc2V0CiMgQ09O
RklHX0xFRFNfUENBOTYzWCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQkQyODAyIGlzIG5v
dCBzZXQKIyBDT05GSUdfTEVEU19JTlRFTF9TUzQyMDAgaXMgbm90IHNldAojIENPTkZJR19M
RURTX1RDQTY1MDcgaXMgbm90IHNldAojIENPTkZJR19MRURTX1RMQzU5MVhYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEVEU19MTTM1NXggaXMgbm90IHNldAoKIwojIExFRCBkcml2ZXIgZm9y
IGJsaW5rKDEpIFVTQiBSR0IgTEVEIGlzIHVuZGVyIFNwZWNpYWwgSElEIGRyaXZlcnMgKEhJ
RF9USElOR00pCiMKIyBDT05GSUdfTEVEU19CTElOS00gaXMgbm90IHNldAojIENPTkZJR19M
RURTX01MWENQTEQgaXMgbm90IHNldAojIENPTkZJR19MRURTX01MWFJFRyBpcyBub3Qgc2V0
CiMgQ09ORklHX0xFRFNfVVNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTklDNzhCWCBp
cyBub3Qgc2V0CgojCiMgTEVEIFRyaWdnZXJzCiMKQ09ORklHX0xFRFNfVFJJR0dFUlM9eQoj
IENPTkZJR19MRURTX1RSSUdHRVJfVElNRVIgaXMgbm90IHNldAojIENPTkZJR19MRURTX1RS
SUdHRVJfT05FU0hPVCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9ESVNLIGlz
IG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0hFQVJUQkVBVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0xFRFNfVFJJR0dFUl9CQUNLTElHSFQgaXMgbm90IHNldAojIENPTkZJR19MRURT
X1RSSUdHRVJfQ1BVIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0FDVElWSVRZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0RFRkFVTFRfT04gaXMgbm90IHNl
dAoKIwojIGlwdGFibGVzIHRyaWdnZXIgaXMgdW5kZXIgTmV0ZmlsdGVyIGNvbmZpZyAoTEVE
IHRhcmdldCkKIwojIENPTkZJR19MRURTX1RSSUdHRVJfVFJBTlNJRU5UIGlzIG5vdCBzZXQK
IyBDT05GSUdfTEVEU19UUklHR0VSX0NBTUVSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNf
VFJJR0dFUl9QQU5JQyBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9ORVRERVYg
aXMgbm90IHNldAojIENPTkZJR19BQ0NFU1NJQklMSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5GSU5JQkFORCBpcyBub3Qgc2V0CkNPTkZJR19FREFDX0FUT01JQ19TQ1JVQj15CkNPTkZJ
R19FREFDX1NVUFBPUlQ9eQpDT05GSUdfRURBQz15CkNPTkZJR19FREFDX0xFR0FDWV9TWVNG
Uz15CiMgQ09ORklHX0VEQUNfREVCVUcgaXMgbm90IHNldApDT05GSUdfRURBQ19ERUNPREVf
TUNFPXkKIyBDT05GSUdfRURBQ19BTUQ2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0VEQUNfRTc1
MlggaXMgbm90IHNldAojIENPTkZJR19FREFDX0k4Mjk3NVggaXMgbm90IHNldAojIENPTkZJ
R19FREFDX0kzMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRURBQ19JMzIwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0VEQUNfSUUzMTIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0VEQUNfWDM4IGlz
IG5vdCBzZXQKIyBDT05GSUdfRURBQ19JNTQwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0VEQUNf
STdDT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfRURBQ19JNTAwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX0VEQUNfSTUxMDAgaXMgbm90IHNldAojIENPTkZJR19FREFDX0k3MzAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRURBQ19TQlJJREdFIGlzIG5vdCBzZXQKIyBDT05GSUdfRURBQ19TS1gg
aXMgbm90IHNldAojIENPTkZJR19FREFDX1BORDIgaXMgbm90IHNldApDT05GSUdfUlRDX0xJ
Qj15CkNPTkZJR19SVENfTUMxNDY4MThfTElCPXkKQ09ORklHX1JUQ19DTEFTUz15CiMgQ09O
RklHX1JUQ19IQ1RPU1lTIGlzIG5vdCBzZXQKQ09ORklHX1JUQ19TWVNUT0hDPXkKQ09ORklH
X1JUQ19TWVNUT0hDX0RFVklDRT0icnRjMCIKIyBDT05GSUdfUlRDX0RFQlVHIGlzIG5vdCBz
ZXQKQ09ORklHX1JUQ19OVk1FTT15CgojCiMgUlRDIGludGVyZmFjZXMKIwpDT05GSUdfUlRD
X0lOVEZfU1lTRlM9eQpDT05GSUdfUlRDX0lOVEZfUFJPQz15CkNPTkZJR19SVENfSU5URl9E
RVY9eQojIENPTkZJR19SVENfSU5URl9ERVZfVUlFX0VNVUwgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX1RFU1QgaXMgbm90IHNldAoKIwojIEkyQyBSVEMgZHJpdmVycwojCiMgQ09O
RklHX1JUQ19EUlZfQUJCNVpFUzMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0FCWDgw
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzA3IGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9EUzEzNzQgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTY3MiBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTUFYNjkwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfUlM1QzM3MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfSVNMMTIwOCBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfSVNMMTIwMjIgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX1gxMjA1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTIzIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTA2MyBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfUENGODUzNjMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1NjMg
aXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1ODMgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX000MVQ4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQlEzMksgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1MzNTM5MEEgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0ZNMzEzMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlg4MDEwIGlzIG5v
dCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDg1ODEgaXMgbm90IHNldAojIENPTkZJR19SVENf
RFJWX1JYODAyNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRU0zMDI3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9SVjg4MDMgaXMgbm90IHNldAoKIwojIFNQSSBSVEMgZHJp
dmVycwojCkNPTkZJR19SVENfSTJDX0FORF9TUEk9eQoKIwojIFNQSSBhbmQgSTJDIFJUQyBk
cml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9EUzMyMzIgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX1BDRjIxMjcgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JWMzAyOUMyIGlz
IG5vdCBzZXQKCiMKIyBQbGF0Zm9ybSBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfRFJWX0NN
T1M9eQojIENPTkZJR19SVENfRFJWX0RTMTI4NiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfRFMxNTExIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1NTMgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX0RTMTY4NV9GQU1JTFkgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0RTMTc0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMyNDA0IGlzIG5v
dCBzZXQKIyBDT05GSUdfUlRDX0RSVl9TVEsxN1RBOCBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfTTQ4VDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUMzUgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX000OFQ1OSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfTVNNNjI0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQlE0ODAyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9SUDVDMDEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X1YzMDIwIGlzIG5vdCBzZXQKCiMKIyBvbi1DUFUgUlRDIGRyaXZlcnMKIwojIENPTkZJR19S
VENfRFJWX0ZUUlRDMDEwIGlzIG5vdCBzZXQKCiMKIyBISUQgU2Vuc29yIFJUQyBkcml2ZXJz
CiMKIyBDT05GSUdfUlRDX0RSVl9ISURfU0VOU09SX1RJTUUgaXMgbm90IHNldApDT05GSUdf
RE1BREVWSUNFUz15CiMgQ09ORklHX0RNQURFVklDRVNfREVCVUcgaXMgbm90IHNldAoKIwoj
IERNQSBEZXZpY2VzCiMKQ09ORklHX0RNQV9FTkdJTkU9eQpDT05GSUdfRE1BX1ZJUlRVQUxf
Q0hBTk5FTFM9eQpDT05GSUdfRE1BX0FDUEk9eQojIENPTkZJR19BTFRFUkFfTVNHRE1BIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5URUxfSURNQTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5U
RUxfSU9BVERNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1FDT01fSElETUFfTUdNVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1FDT01fSElETUEgaXMgbm90IHNldApDT05GSUdfRFdfRE1BQ19DT1JF
PXkKIyBDT05GSUdfRFdfRE1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RXX0RNQUNfUENJIGlz
IG5vdCBzZXQKQ09ORklHX0hTVV9ETUE9eQoKIwojIERNQSBDbGllbnRzCiMKIyBDT05GSUdf
QVNZTkNfVFhfRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BVEVTVCBpcyBub3Qgc2V0Cgoj
CiMgRE1BQlVGIG9wdGlvbnMKIwpDT05GSUdfU1lOQ19GSUxFPXkKIyBDT05GSUdfU1dfU1lO
QyBpcyBub3Qgc2V0CiMgQ09ORklHX0FVWERJU1BMQVkgaXMgbm90IHNldAojIENPTkZJR19V
SU8gaXMgbm90IHNldAojIENPTkZJR19WRklPIGlzIG5vdCBzZXQKIyBDT05GSUdfVklSVF9E
UklWRVJTIGlzIG5vdCBzZXQKQ09ORklHX1ZJUlRJTz15CkNPTkZJR19WSVJUSU9fTUVOVT15
CkNPTkZJR19WSVJUSU9fUENJPXkKQ09ORklHX1ZJUlRJT19QQ0lfTEVHQUNZPXkKIyBDT05G
SUdfVklSVElPX0JBTExPT04gaXMgbm90IHNldApDT05GSUdfVklSVElPX0lOUFVUPXkKIyBD
T05GSUdfVklSVElPX01NSU8gaXMgbm90IHNldAoKIwojIE1pY3Jvc29mdCBIeXBlci1WIGd1
ZXN0IHN1cHBvcnQKIwojIENPTkZJR19IWVBFUlYgaXMgbm90IHNldAojIENPTkZJR19TVEFH
SU5HIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9QTEFURk9STV9ERVZJQ0VTPXkKIyBDT05GSUdf
QUNFUl9XSVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDRVJIREYgaXMgbm90IHNldAoj
IENPTkZJR19BU1VTX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFTExfU01CSU9TIGlz
IG5vdCBzZXQKIyBDT05GSUdfREVMTF9MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19ERUxM
X1NNTzg4MDAgaXMgbm90IHNldAojIENPTkZJR19ERUxMX1JCVE4gaXMgbm90IHNldAojIENP
TkZJR19GVUpJVFNVX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVSklUU1VfVEFCTEVU
IGlzIG5vdCBzZXQKIyBDT05GSUdfQU1JTE9fUkZLSUxMIGlzIG5vdCBzZXQKIyBDT05GSUdf
R1BEX1BPQ0tFVF9GQU4gaXMgbm90IHNldAojIENPTkZJR19IUF9BQ0NFTCBpcyBub3Qgc2V0
CiMgQ09ORklHX0hQX1dJUkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVNJX0xBUFRPUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BBTkFTT05JQ19MQVBUT1AgaXMgbm90IHNldAojIENPTkZJ
R19DT01QQUxfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU09OWV9MQVBUT1AgaXMgbm90
IHNldAojIENPTkZJR19JREVBUEFEX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RISU5L
UEFEX0FDUEkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0hEQVBTIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5URUxfTUVOTE9XIGlzIG5vdCBzZXQKQ09ORklHX0VFRVBDX0xBUFRPUD15
CiMgQ09ORklHX0FTVVNfV0lSRUxFU1MgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1dNSSBp
cyBub3Qgc2V0CiMgQ09ORklHX1RPUFNUQVJfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9TSElCQV9CVF9SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19UT1NISUJBX0hBUFMgaXMg
bm90IHNldAojIENPTkZJR19BQ1BJX0NNUEMgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9I
SURfRVZFTlQgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9WQlROIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5URUxfSVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfUE1DX0NPUkUgaXMg
bm90IHNldAojIENPTkZJR19JQk1fUlRMIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FNU1VOR19M
QVBUT1AgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9PQUtUUkFJTCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NBTVNVTkdfUTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTEVfR01VWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOVEVMX1JTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1NN
QVJUQ09OTkVDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BWUEFOSUMgaXMgbm90IHNldAojIENP
TkZJR19JTlRFTF9QTUNfSVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VSRkFDRV9QUk8zX0JV
VFRPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1BVTklUX0lQQyBpcyBub3Qgc2V0CiMg
Q09ORklHX01MWF9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1RVUkJPX01B
WF8zIGlzIG5vdCBzZXQKQ09ORklHX1BNQ19BVE9NPXkKIyBDT05GSUdfQ0hST01FX1BMQVRG
T1JNUyBpcyBub3Qgc2V0CiMgQ09ORklHX01FTExBTk9YX1BMQVRGT1JNIGlzIG5vdCBzZXQK
Q09ORklHX0NMS0RFVl9MT09LVVA9eQpDT05GSUdfSEFWRV9DTEtfUFJFUEFSRT15CkNPTkZJ
R19DT01NT05fQ0xLPXkKCiMKIyBDb21tb24gQ2xvY2sgRnJhbWV3b3JrCiMKIyBDT05GSUdf
Q09NTU9OX0NMS19TSTUzNTEgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX1NJNTQ0
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19DRENFNzA2IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ09NTU9OX0NMS19DUzIwMDBfQ1AgaXMgbm90IHNldAojIENPTkZJR19IV1NQSU5M
T0NLIGlzIG5vdCBzZXQKCiMKIyBDbG9jayBTb3VyY2UgZHJpdmVycwojCkNPTkZJR19DTEtF
VlRfSTgyNTM9eQpDT05GSUdfSTgyNTNfTE9DSz15CkNPTkZJR19DTEtCTERfSTgyNTM9eQpD
T05GSUdfTUFJTEJPWD15CkNPTkZJR19QQ0M9eQojIENPTkZJR19BTFRFUkFfTUJPWCBpcyBu
b3Qgc2V0CkNPTkZJR19JT01NVV9BUEk9eQpDT05GSUdfSU9NTVVfU1VQUE9SVD15CgojCiMg
R2VuZXJpYyBJT01NVSBQYWdldGFibGUgU3VwcG9ydAojCkNPTkZJR19JT01NVV9JT1ZBPXkK
Q09ORklHX0FNRF9JT01NVT15CiMgQ09ORklHX0FNRF9JT01NVV9WMiBpcyBub3Qgc2V0CkNP
TkZJR19ETUFSX1RBQkxFPXkKQ09ORklHX0lOVEVMX0lPTU1VPXkKIyBDT05GSUdfSU5URUxf
SU9NTVVfU1ZNIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfSU9NTVVfREVGQVVMVF9PTiBp
cyBub3Qgc2V0CkNPTkZJR19JTlRFTF9JT01NVV9GTE9QUFlfV0E9eQojIENPTkZJR19JUlFf
UkVNQVAgaXMgbm90IHNldAoKIwojIFJlbW90ZXByb2MgZHJpdmVycwojCiMgQ09ORklHX1JF
TU9URVBST0MgaXMgbm90IHNldAoKIwojIFJwbXNnIGRyaXZlcnMKIwojIENPTkZJR19SUE1T
R19RQ09NX0dMSU5LX1JQTSBpcyBub3Qgc2V0CiMgQ09ORklHX1JQTVNHX1ZJUlRJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NPVU5EV0lSRSBpcyBub3Qgc2V0CgojCiMgU09DIChTeXN0ZW0g
T24gQ2hpcCkgc3BlY2lmaWMgRHJpdmVycwojCgojCiMgQW1sb2dpYyBTb0MgZHJpdmVycwoj
CgojCiMgQnJvYWRjb20gU29DIGRyaXZlcnMKIwoKIwojIGkuTVggU29DIGRyaXZlcnMKIwoK
IwojIFF1YWxjb21tIFNvQyBkcml2ZXJzCiMKIyBDT05GSUdfU09DX1RJIGlzIG5vdCBzZXQK
CiMKIyBYaWxpbnggU29DIGRyaXZlcnMKIwojIENPTkZJR19YSUxJTlhfVkNVIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUE1fREVWRlJFUSBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVENPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX01FTU9SWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX05UQiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNRV9CVVMgaXMgbm90IHNl
dAojIENPTkZJR19QV00gaXMgbm90IHNldAoKIwojIElSUSBjaGlwIHN1cHBvcnQKIwpDT05G
SUdfQVJNX0dJQ19NQVhfTlI9MQojIENPTkZJR19JUEFDS19CVVMgaXMgbm90IHNldAojIENP
TkZJR19SRVNFVF9DT05UUk9MTEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfRk1DIGlzIG5vdCBz
ZXQKCiMKIyBQSFkgU3Vic3lzdGVtCiMKIyBDT05GSUdfR0VORVJJQ19QSFkgaXMgbm90IHNl
dAojIENPTkZJR19CQ01fS09OQV9VU0IyX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1BIWV9Q
WEFfMjhOTV9IU0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX1BYQV8yOE5NX1VTQjIgaXMg
bm90IHNldAojIENPTkZJR19QT1dFUkNBUCBpcyBub3Qgc2V0CiMgQ09ORklHX01DQiBpcyBu
b3Qgc2V0CgojCiMgUGVyZm9ybWFuY2UgbW9uaXRvciBzdXBwb3J0CiMKQ09ORklHX1JBUz15
CiMgQ09ORklHX1RIVU5ERVJCT0xUIGlzIG5vdCBzZXQKCiMKIyBBbmRyb2lkCiMKIyBDT05G
SUdfQU5EUk9JRCBpcyBub3Qgc2V0CiMgQ09ORklHX0xJQk5WRElNTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RBWCBpcyBub3Qgc2V0CkNPTkZJR19OVk1FTT15CgojCiMgSFcgdHJhY2luZyBz
dXBwb3J0CiMKIyBDT05GSUdfU1RNIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfVEggaXMg
bm90IHNldAojIENPTkZJR19GUEdBIGlzIG5vdCBzZXQKIyBDT05GSUdfVU5JU1lTX1ZJU09S
QlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0lPWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NMSU1C
VVMgaXMgbm90IHNldAoKIwojIEZpcm13YXJlIERyaXZlcnMKIwojIENPTkZJR19FREQgaXMg
bm90IHNldApDT05GSUdfRklSTVdBUkVfTUVNTUFQPXkKIyBDT05GSUdfREVMTF9SQlUgaXMg
bm90IHNldAojIENPTkZJR19EQ0RCQVMgaXMgbm90IHNldApDT05GSUdfRE1JSUQ9eQojIENP
TkZJR19ETUlfU1lTRlMgaXMgbm90IHNldApDT05GSUdfRE1JX1NDQU5fTUFDSElORV9OT05f
RUZJX0ZBTExCQUNLPXkKIyBDT05GSUdfSVNDU0lfSUJGVF9GSU5EIGlzIG5vdCBzZXQKIyBD
T05GSUdfRldfQ0ZHX1NZU0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfR09PR0xFX0ZJUk1XQVJF
IGlzIG5vdCBzZXQKCiMKIyBFRkkgKEV4dGVuc2libGUgRmlybXdhcmUgSW50ZXJmYWNlKSBT
dXBwb3J0CiMKQ09ORklHX0VGSV9WQVJTPXkKQ09ORklHX0VGSV9FU1JUPXkKQ09ORklHX0VG
SV9SVU5USU1FX01BUD15CiMgQ09ORklHX0VGSV9GQUtFX01FTU1BUCBpcyBub3Qgc2V0CkNP
TkZJR19FRklfUlVOVElNRV9XUkFQUEVSUz15CiMgQ09ORklHX0VGSV9CT09UTE9BREVSX0NP
TlRST0wgaXMgbm90IHNldAojIENPTkZJR19FRklfQ0FQU1VMRV9MT0FERVIgaXMgbm90IHNl
dAojIENPTkZJR19FRklfVEVTVCBpcyBub3Qgc2V0CgojCiMgVGVncmEgZmlybXdhcmUgZHJp
dmVyCiMKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdfRENBQ0hFX1dPUkRfQUNDRVNTPXkK
Q09ORklHX0ZTX0lPTUFQPXkKIyBDT05GSUdfRVhUMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0VYVDNfRlMgaXMgbm90IHNldApDT05GSUdfRVhUNF9GUz15CkNPTkZJR19FWFQ0X1VTRV9G
T1JfRVhUMj15CkNPTkZJR19FWFQ0X0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFQ0X0ZTX1NF
Q1VSSVRZPXkKIyBDT05GSUdfRVhUNF9FTkNSWVBUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
RVhUNF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19KQkQyPXkKIyBDT05GSUdfSkJEMl9ERUJV
RyBpcyBub3Qgc2V0CkNPTkZJR19GU19NQkNBQ0hFPXkKIyBDT05GSUdfUkVJU0VSRlNfRlMg
aXMgbm90IHNldAojIENPTkZJR19KRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19YRlNfRlMg
aXMgbm90IHNldAojIENPTkZJR19HRlMyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRSRlNf
RlMgaXMgbm90IHNldAojIENPTkZJR19OSUxGUzJfRlMgaXMgbm90IHNldAojIENPTkZJR19G
MkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRlNfREFYIGlzIG5vdCBzZXQKQ09ORklHX0ZT
X1BPU0lYX0FDTD15CkNPTkZJR19FWFBPUlRGUz15CiMgQ09ORklHX0VYUE9SVEZTX0JMT0NL
X09QUyBpcyBub3Qgc2V0CkNPTkZJR19GSUxFX0xPQ0tJTkc9eQpDT05GSUdfTUFOREFUT1JZ
X0ZJTEVfTE9DS0lORz15CiMgQ09ORklHX0ZTX0VOQ1JZUFRJT04gaXMgbm90IHNldApDT05G
SUdfRlNOT1RJRlk9eQpDT05GSUdfRE5PVElGWT15CkNPTkZJR19JTk9USUZZX1VTRVI9eQoj
IENPTkZJR19GQU5PVElGWSBpcyBub3Qgc2V0CkNPTkZJR19RVU9UQT15CkNPTkZJR19RVU9U
QV9ORVRMSU5LX0lOVEVSRkFDRT15CiMgQ09ORklHX1BSSU5UX1FVT1RBX1dBUk5JTkcgaXMg
bm90IHNldAojIENPTkZJR19RVU9UQV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19RVU9UQV9U
UkVFPXkKIyBDT05GSUdfUUZNVF9WMSBpcyBub3Qgc2V0CkNPTkZJR19RRk1UX1YyPXkKQ09O
RklHX1FVT1RBQ1RMPXkKQ09ORklHX1FVT1RBQ1RMX0NPTVBBVD15CkNPTkZJR19BVVRPRlM0
X0ZTPXkKIyBDT05GSUdfRlVTRV9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09WRVJMQVlfRlMg
aXMgbm90IHNldAoKIwojIENhY2hlcwojCiMgQ09ORklHX0ZTQ0FDSEUgaXMgbm90IHNldAoK
IwojIENELVJPTS9EVkQgRmlsZXN5c3RlbXMKIwpDT05GSUdfSVNPOTY2MF9GUz15CkNPTkZJ
R19KT0xJRVQ9eQpDT05GSUdfWklTT0ZTPXkKIyBDT05GSUdfVURGX0ZTIGlzIG5vdCBzZXQK
CiMKIyBET1MvRkFUL05UIEZpbGVzeXN0ZW1zCiMKQ09ORklHX0ZBVF9GUz15CkNPTkZJR19N
U0RPU19GUz15CkNPTkZJR19WRkFUX0ZTPXkKQ09ORklHX0ZBVF9ERUZBVUxUX0NPREVQQUdF
PTQzNwpDT05GSUdfRkFUX0RFRkFVTFRfSU9DSEFSU0VUPSJpc284ODU5LTEiCiMgQ09ORklH
X0ZBVF9ERUZBVUxUX1VURjggaXMgbm90IHNldAojIENPTkZJR19OVEZTX0ZTIGlzIG5vdCBz
ZXQKCiMKIyBQc2V1ZG8gZmlsZXN5c3RlbXMKIwpDT05GSUdfUFJPQ19GUz15CkNPTkZJR19Q
Uk9DX0tDT1JFPXkKQ09ORklHX1BST0NfVk1DT1JFPXkKQ09ORklHX1BST0NfU1lTQ1RMPXkK
Q09ORklHX1BST0NfUEFHRV9NT05JVE9SPXkKIyBDT05GSUdfUFJPQ19DSElMRFJFTiBpcyBu
b3Qgc2V0CkNPTkZJR19LRVJORlM9eQpDT05GSUdfU1lTRlM9eQpDT05GSUdfVE1QRlM9eQpD
T05GSUdfVE1QRlNfUE9TSVhfQUNMPXkKQ09ORklHX1RNUEZTX1hBVFRSPXkKQ09ORklHX0hV
R0VUTEJGUz15CkNPTkZJR19IVUdFVExCX1BBR0U9eQojIENPTkZJR19DT05GSUdGU19GUyBp
cyBub3Qgc2V0CkNPTkZJR19FRklWQVJfRlM9bQpDT05GSUdfTUlTQ19GSUxFU1lTVEVNUz15
CiMgQ09ORklHX09SQU5HRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQURGU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FGRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19FQ1JZUFRfRlMg
aXMgbm90IHNldAojIENPTkZJR19IRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IRlNQTFVT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkVGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
QU1GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NRVUFTSEZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
VlhGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklYX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfT01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19RTlg2RlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19ST01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BTVE9SRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90IHNldAojIENPTkZJR19VRlNfRlMgaXMgbm90
IHNldApDT05GSUdfTkVUV09SS19GSUxFU1lTVEVNUz15CkNPTkZJR19ORlNfRlM9eQpDT05G
SUdfTkZTX1YyPXkKQ09ORklHX05GU19WMz15CkNPTkZJR19ORlNfVjNfQUNMPXkKQ09ORklH
X05GU19WND15CiMgQ09ORklHX05GU19TV0FQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX1Y0
XzEgaXMgbm90IHNldApDT05GSUdfUk9PVF9ORlM9eQojIENPTkZJR19ORlNfVVNFX0xFR0FD
WV9ETlMgaXMgbm90IHNldApDT05GSUdfTkZTX1VTRV9LRVJORUxfRE5TPXkKIyBDT05GSUdf
TkZTRCBpcyBub3Qgc2V0CkNPTkZJR19HUkFDRV9QRVJJT0Q9eQpDT05GSUdfTE9DS0Q9eQpD
T05GSUdfTE9DS0RfVjQ9eQpDT05GSUdfTkZTX0FDTF9TVVBQT1JUPXkKQ09ORklHX05GU19D
T01NT049eQpDT05GSUdfU1VOUlBDPXkKQ09ORklHX1NVTlJQQ19HU1M9eQojIENPTkZJR19T
VU5SUENfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19DRVBIX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0lGUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREFfRlMgaXMgbm90IHNldAojIENP
TkZJR19BRlNfRlMgaXMgbm90IHNldApDT05GSUdfOVBfRlM9eQojIENPTkZJR185UF9GU19Q
T1NJWF9BQ0wgaXMgbm90IHNldAojIENPTkZJR185UF9GU19TRUNVUklUWSBpcyBub3Qgc2V0
CkNPTkZJR19OTFM9eQpDT05GSUdfTkxTX0RFRkFVTFQ9InV0ZjgiCkNPTkZJR19OTFNfQ09E
RVBBR0VfNDM3PXkKIyBDT05GSUdfTkxTX0NPREVQQUdFXzczNyBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV83NzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19DT0RFUEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODU3IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfODYyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjQgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfODY1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NiBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjkgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk1MCBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzIgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg3
NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzggaXMgbm90IHNldAojIENPTkZJ
R19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV8x
MjUxIGlzIG5vdCBzZXQKQ09ORklHX05MU19BU0NJST15CkNPTkZJR19OTFNfSVNPODg1OV8x
PXkKIyBDT05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084
ODU5XzMgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV80IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0lTTzg4NTlfNSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzYg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV83IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0lTTzg4NTlfOSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEzIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTQgaXMgbm90IHNldAojIENPTkZJR19OTFNf
SVNPODg1OV8xNSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19LT0k4X1IgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfS09JOF9VIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19ST01BTiBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfQ0VMVElDIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX01BQ19DRU5URVVSTyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfQ1JPQVRJQU4g
aXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NZUklMTElDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX01BQ19HQUVMSUMgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0dSRUVLIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19JQ0VMQU5EIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX01BQ19JTlVJVCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfUk9NQU5JQU4gaXMg
bm90IHNldAojIENPTkZJR19OTFNfTUFDX1RVUktJU0ggaXMgbm90IHNldApDT05GSUdfTkxT
X1VURjg9eQoKIwojIEtlcm5lbCBoYWNraW5nCiMKQ09ORklHX1RSQUNFX0lSUUZMQUdTX1NV
UFBPUlQ9eQoKIwojIHByaW50ayBhbmQgZG1lc2cgb3B0aW9ucwojCkNPTkZJR19QUklOVEtf
VElNRT15CkNPTkZJR19DT05TT0xFX0xPR0xFVkVMX0RFRkFVTFQ9NwpDT05GSUdfTUVTU0FH
RV9MT0dMRVZFTF9ERUZBVUxUPTQKIyBDT05GSUdfQk9PVF9QUklOVEtfREVMQVkgaXMgbm90
IHNldAojIENPTkZJR19EWU5BTUlDX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBDb21waWxlLXRp
bWUgY2hlY2tzIGFuZCBjb21waWxlciBvcHRpb25zCiMKQ09ORklHX0RFQlVHX0lORk89eQoj
IENPTkZJR19ERUJVR19JTkZPX1JFRFVDRUQgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19J
TkZPX1NQTElUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfSU5GT19EV0FSRjQgaXMgbm90
IHNldAojIENPTkZJR19HREJfU0NSSVBUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VOQUJMRV9X
QVJOX0RFUFJFQ0FURUQgaXMgbm90IHNldApDT05GSUdfRU5BQkxFX01VU1RfQ0hFQ0s9eQpD
T05GSUdfRlJBTUVfV0FSTj0yMDQ4CiMgQ09ORklHX1NUUklQX0FTTV9TWU1TIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkVBREFCTEVfQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfVU5VU0VEX1NZ
TUJPTFMgaXMgbm90IHNldAojIENPTkZJR19QQUdFX09XTkVSIGlzIG5vdCBzZXQKQ09ORklH
X0RFQlVHX0ZTPXkKIyBDT05GSUdfSEVBREVSU19DSEVDSyBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX1NFQ1RJT05fTUlTTUFUQ0ggaXMgbm90IHNldApDT05GSUdfU0VDVElPTl9NSVNN
QVRDSF9XQVJOX09OTFk9eQpDT05GSUdfU1RBQ0tfVkFMSURBVElPTj15CiMgQ09ORklHX0RF
QlVHX0ZPUkNFX1dFQUtfUEVSX0NQVSBpcyBub3Qgc2V0CkNPTkZJR19NQUdJQ19TWVNSUT15
CkNPTkZJR19NQUdJQ19TWVNSUV9ERUZBVUxUX0VOQUJMRT0weDEKQ09ORklHX01BR0lDX1NZ
U1JRX1NFUklBTD15CkNPTkZJR19ERUJVR19LRVJORUw9eQoKIwojIE1lbW9yeSBEZWJ1Z2dp
bmcKIwojIENPTkZJR19QQUdFX0VYVEVOU0lPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X1BBR0VBTExPQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBR0VfUE9JU09OSU5HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVCVUdfUEFHRV9SRUYgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19S
T0RBVEFfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX09CSkVDVFMgaXMgbm90IHNl
dAojIENPTkZJR19TTFVCX0RFQlVHX09OIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xVQl9TVEFU
UyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0RFQlVHX0tNRU1MRUFLPXkKIyBDT05GSUdfREVC
VUdfS01FTUxFQUsgaXMgbm90IHNldApDT05GSUdfREVCVUdfU1RBQ0tfVVNBR0U9eQpDT05G
SUdfREVCVUdfVk09eQojIENPTkZJR19ERUJVR19WTV9WTUFDQUNIRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFQlVHX1ZNX1JCIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfVk1fUEdGTEFH
UyBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19ERUJVR19WSVJUVUFMPXkKIyBDT05GSUdf
REVCVUdfVklSVFVBTCBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19NRU1PUllfSU5JVD15CiMg
Q09ORklHX0RFQlVHX1BFUl9DUFVfTUFQUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0RFQlVH
X1NUQUNLT1ZFUkZMT1c9eQpDT05GSUdfREVCVUdfU1RBQ0tPVkVSRkxPVz15CkNPTkZJR19I
QVZFX0FSQ0hfS0FTQU49eQpDT05GSUdfS0FTQU49eQojIENPTkZJR19LQVNBTl9FWFRSQSBp
cyBub3Qgc2V0CiMgQ09ORklHX0tBU0FOX09VVExJTkUgaXMgbm90IHNldApDT05GSUdfS0FT
QU5fSU5MSU5FPXkKIyBDT05GSUdfVEVTVF9LQVNBTiBpcyBub3Qgc2V0CkNPTkZJR19BUkNI
X0hBU19LQ09WPXkKQ09ORklHX0tDT1Y9eQojIENPTkZJR19LQ09WX0VOQUJMRV9DT01QQVJJ
U09OUyBpcyBub3Qgc2V0CkNPTkZJR19LQ09WX0lOU1RSVU1FTlRfQUxMPXkKIyBDT05GSUdf
REVCVUdfU0hJUlEgaXMgbm90IHNldAoKIwojIERlYnVnIExvY2t1cHMgYW5kIEhhbmdzCiMK
Q09ORklHX0xPQ0tVUF9ERVRFQ1RPUj15CkNPTkZJR19TT0ZUTE9DS1VQX0RFVEVDVE9SPXkK
IyBDT05GSUdfQk9PVFBBUkFNX1NPRlRMT0NLVVBfUEFOSUMgaXMgbm90IHNldApDT05GSUdf
Qk9PVFBBUkFNX1NPRlRMT0NLVVBfUEFOSUNfVkFMVUU9MApDT05GSUdfSEFSRExPQ0tVUF9E
RVRFQ1RPUl9QRVJGPXkKQ09ORklHX0hBUkRMT0NLVVBfQ0hFQ0tfVElNRVNUQU1QPXkKQ09O
RklHX0hBUkRMT0NLVVBfREVURUNUT1I9eQojIENPTkZJR19CT09UUEFSQU1fSEFSRExPQ0tV
UF9QQU5JQyBpcyBub3Qgc2V0CkNPTkZJR19CT09UUEFSQU1fSEFSRExPQ0tVUF9QQU5JQ19W
QUxVRT0wCkNPTkZJR19ERVRFQ1RfSFVOR19UQVNLPXkKQ09ORklHX0RFRkFVTFRfSFVOR19U
QVNLX1RJTUVPVVQ9MTIwCiMgQ09ORklHX0JPT1RQQVJBTV9IVU5HX1RBU0tfUEFOSUMgaXMg
bm90IHNldApDT05GSUdfQk9PVFBBUkFNX0hVTkdfVEFTS19QQU5JQ19WQUxVRT0wCkNPTkZJ
R19XUV9XQVRDSERPRz15CiMgQ09ORklHX1BBTklDX09OX09PUFMgaXMgbm90IHNldApDT05G
SUdfUEFOSUNfT05fT09QU19WQUxVRT0wCkNPTkZJR19QQU5JQ19USU1FT1VUPTAKIyBDT05G
SUdfU0NIRURfREVCVUcgaXMgbm90IHNldApDT05GSUdfU0NIRURfSU5GTz15CkNPTkZJR19T
Q0hFRFNUQVRTPXkKIyBDT05GSUdfU0NIRURfU1RBQ0tfRU5EX0NIRUNLIGlzIG5vdCBzZXQK
IyBDT05GSUdfREVCVUdfVElNRUtFRVBJTkcgaXMgbm90IHNldAoKIwojIExvY2sgRGVidWdn
aW5nIChzcGlubG9ja3MsIG11dGV4ZXMsIGV0Yy4uLikKIwpDT05GSUdfTE9DS19ERUJVR0dJ
TkdfU1VQUE9SVD15CkNPTkZJR19QUk9WRV9MT0NLSU5HPXkKIyBDT05GSUdfTE9DS19TVEFU
IGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX1JUX01VVEVYRVM9eQpDT05GSUdfREVCVUdfU1BJ
TkxPQ0s9eQpDT05GSUdfREVCVUdfTVVURVhFUz15CkNPTkZJR19ERUJVR19XV19NVVRFWF9T
TE9XUEFUSD15CkNPTkZJR19ERUJVR19SV1NFTVM9eQpDT05GSUdfREVCVUdfTE9DS19BTExP
Qz15CkNPTkZJR19MT0NLREVQPXkKIyBDT05GSUdfREVCVUdfTE9DS0RFUCBpcyBub3Qgc2V0
CkNPTkZJR19ERUJVR19BVE9NSUNfU0xFRVA9eQojIENPTkZJR19ERUJVR19MT0NLSU5HX0FQ
SV9TRUxGVEVTVFMgaXMgbm90IHNldAojIENPTkZJR19MT0NLX1RPUlRVUkVfVEVTVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1dXX01VVEVYX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX1RS
QUNFX0lSUUZMQUdTPXkKQ09ORklHX1NUQUNLVFJBQ0U9eQojIENPTkZJR19XQVJOX0FMTF9V
TlNFRURFRF9SQU5ET00gaXMgbm90IHNldApDT05GSUdfREVCVUdfS09CSkVDVD15CkNPTkZJ
R19ERUJVR19CVUdWRVJCT1NFPXkKIyBDT05GSUdfREVCVUdfTElTVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFQlVHX1BJX0xJU1QgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX05PVElGSUVSUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RF
QlVHX0NSRURFTlRJQUxTIGlzIG5vdCBzZXQKCiMKIyBSQ1UgRGVidWdnaW5nCiMKQ09ORklH
X1BST1ZFX1JDVT15CiMgQ09ORklHX1JDVV9QRVJGX1RFU1QgaXMgbm90IHNldAojIENPTkZJ
R19SQ1VfVE9SVFVSRV9URVNUIGlzIG5vdCBzZXQKQ09ORklHX1JDVV9DUFVfU1RBTExfVElN
RU9VVD03MQpDT05GSUdfUkNVX1RSQUNFPXkKIyBDT05GSUdfUkNVX0VRU19ERUJVRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX1dRX0ZPUkNFX1JSX0NQVSBpcyBub3Qgc2V0CiMgQ09O
RklHX0RFQlVHX0JMT0NLX0VYVF9ERVZUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0hPVFBM
VUdfU1RBVEVfQ09OVFJPTCBpcyBub3Qgc2V0CiMgQ09ORklHX05PVElGSUVSX0VSUk9SX0lO
SkVDVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZBVUxUX0lOSkVDVElPTiBpcyBub3Qgc2V0
CkNPTkZJR19GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT049eQojIENPTkZJR19MQVRFTkNZVE9Q
IGlzIG5vdCBzZXQKQ09ORklHX1VTRVJfU1RBQ0tUUkFDRV9TVVBQT1JUPXkKQ09ORklHX05P
UF9UUkFDRVI9eQpDT05GSUdfSEFWRV9GVU5DVElPTl9UUkFDRVI9eQpDT05GSUdfSEFWRV9G
VU5DVElPTl9HUkFQSF9UUkFDRVI9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRT15CkNP
TkZJR19IQVZFX0RZTkFNSUNfRlRSQUNFX1dJVEhfUkVHUz15CkNPTkZJR19IQVZFX0ZUUkFD
RV9NQ09VTlRfUkVDT1JEPXkKQ09ORklHX0hBVkVfU1lTQ0FMTF9UUkFDRVBPSU5UUz15CkNP
TkZJR19IQVZFX0ZFTlRSWT15CkNPTkZJR19IQVZFX0NfUkVDT1JETUNPVU5UPXkKQ09ORklH
X1RSQUNFX0NMT0NLPXkKQ09ORklHX1JJTkdfQlVGRkVSPXkKQ09ORklHX0VWRU5UX1RSQUNJ
Tkc9eQpDT05GSUdfQ09OVEVYVF9TV0lUQ0hfVFJBQ0VSPXkKQ09ORklHX1RSQUNJTkc9eQpD
T05GSUdfR0VORVJJQ19UUkFDRVI9eQpDT05GSUdfVFJBQ0lOR19TVVBQT1JUPXkKQ09ORklH
X0ZUUkFDRT15CiMgQ09ORklHX0ZVTkNUSU9OX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X0lSUVNPRkZfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NIRURfVFJBQ0VSIGlzIG5v
dCBzZXQKIyBDT05GSUdfSFdMQVRfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfRlRSQUNF
X1NZU0NBTExTIGlzIG5vdCBzZXQKIyBDT05GSUdfVFJBQ0VSX1NOQVBTSE9UIGlzIG5vdCBz
ZXQKQ09ORklHX0JSQU5DSF9QUk9GSUxFX05PTkU9eQojIENPTkZJR19QUk9GSUxFX0FOTk9U
QVRFRF9CUkFOQ0hFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NUQUNLX1RSQUNFUiBpcyBub3Qg
c2V0CkNPTkZJR19CTEtfREVWX0lPX1RSQUNFPXkKQ09ORklHX0tQUk9CRV9FVkVOVFM9eQpD
T05GSUdfVVBST0JFX0VWRU5UUz15CkNPTkZJR19QUk9CRV9FVkVOVFM9eQojIENPTkZJR19G
VFJBQ0VfU1RBUlRVUF9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1JT1RSQUNFIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElTVF9UUklHR0VSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RSQUNF
UE9JTlRfQkVOQ0hNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfUklOR19CVUZGRVJfQkVOQ0hN
QVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfUklOR19CVUZGRVJfU1RBUlRVUF9URVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfVFJBQ0VfRVZBTF9NQVBfRklMRSBpcyBub3Qgc2V0CkNPTkZJR19Q
Uk9WSURFX09IQ0kxMzk0X0RNQV9JTklUPXkKIyBDT05GSUdfRE1BX0FQSV9ERUJVRyBpcyBu
b3Qgc2V0CkNPTkZJR19SVU5USU1FX1RFU1RJTkdfTUVOVT15CiMgQ09ORklHX0xLRFRNIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEVTVF9MSVNUX1NPUlQgaXMgbm90IHNldAojIENPTkZJR19U
RVNUX1NPUlQgaXMgbm90IHNldAojIENPTkZJR19LUFJPQkVTX1NBTklUWV9URVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkFDS1RSQUNFX1NFTEZfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JCVFJFRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URVJWQUxfVFJFRV9URVNUIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEVSQ1BVX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19BVE9N
SUM2NF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfSEVYRFVNUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RFU1RfU1RSSU5HX0hFTFBFUlMgaXMgbm90IHNldAojIENPTkZJR19U
RVNUX0tTVFJUT1ggaXMgbm90IHNldAojIENPTkZJR19URVNUX1BSSU5URiBpcyBub3Qgc2V0
CiMgQ09ORklHX1RFU1RfQklUTUFQIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9VVUlEIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEVTVF9SSEFTSFRBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9IQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9MS00gaXMgbm90IHNldAojIENP
TkZJR19URVNUX1VTRVJfQ09QWSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQlBGIGlzIG5v
dCBzZXQKIyBDT05GSUdfRklORF9CSVRfQkVOQ0hNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9GSVJNV0FSRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfU1lTQ1RMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVEVTVF9VREVMQVkgaXMgbm90IHNldAojIENPTkZJR19URVNUX1NUQVRJ
Q19LRVlTIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9LTU9EIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUVNVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JVR19PTl9EQVRBX0NPUlJVUFRJT04g
aXMgbm90IHNldAojIENPTkZJR19TQU1QTEVTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJD
SF9LR0RCPXkKIyBDT05GSUdfS0dEQiBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19VQlNB
Tl9TQU5JVElaRV9BTEw9eQojIENPTkZJR19VQlNBTiBpcyBub3Qgc2V0CkNPTkZJR19BUkNI
X0hBU19ERVZNRU1fSVNfQUxMT1dFRD15CkNPTkZJR19TVFJJQ1RfREVWTUVNPXkKIyBDT05G
SUdfSU9fU1RSSUNUX0RFVk1FTSBpcyBub3Qgc2V0CkNPTkZJR19FQVJMWV9QUklOVEtfVVNC
PXkKQ09ORklHX1g4Nl9WRVJCT1NFX0JPT1RVUD15CkNPTkZJR19FQVJMWV9QUklOVEs9eQpD
T05GSUdfRUFSTFlfUFJJTlRLX0RCR1A9eQojIENPTkZJR19FQVJMWV9QUklOVEtfRUZJIGlz
IG5vdCBzZXQKIyBDT05GSUdfRUFSTFlfUFJJTlRLX1VTQl9YREJDIGlzIG5vdCBzZXQKIyBD
T05GSUdfWDg2X1BURFVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX0VGSV9QR1RfRFVNUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX1dYIGlzIG5vdCBzZXQKQ09ORklHX0RPVUJMRUZBVUxU
PXkKIyBDT05GSUdfREVCVUdfVExCRkxVU0ggaXMgbm90IHNldApDT05GSUdfSEFWRV9NTUlP
VFJBQ0VfU1VQUE9SVD15CiMgQ09ORklHX1g4Nl9ERUNPREVSX1NFTEZURVNUIGlzIG5vdCBz
ZXQKQ09ORklHX0lPX0RFTEFZX1RZUEVfMFg4MD0wCkNPTkZJR19JT19ERUxBWV9UWVBFXzBY
RUQ9MQpDT05GSUdfSU9fREVMQVlfVFlQRV9VREVMQVk9MgpDT05GSUdfSU9fREVMQVlfVFlQ
RV9OT05FPTMKQ09ORklHX0lPX0RFTEFZXzBYODA9eQojIENPTkZJR19JT19ERUxBWV8wWEVE
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU9fREVMQVlfVURFTEFZIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU9fREVMQVlfTk9ORSBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX0lPX0RFTEFZX1RZ
UEU9MApDT05GSUdfREVCVUdfQk9PVF9QQVJBTVM9eQojIENPTkZJR19DUEFfREVCVUcgaXMg
bm90IHNldApDT05GSUdfT1BUSU1JWkVfSU5MSU5JTkc9eQojIENPTkZJR19ERUJVR19FTlRS
WSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX05NSV9TRUxGVEVTVCBpcyBub3Qgc2V0CkNP
TkZJR19YODZfREVCVUdfRlBVPXkKIyBDT05GSUdfUFVOSVRfQVRPTV9ERUJVRyBpcyBub3Qg
c2V0CkNPTkZJR19VTldJTkRFUl9PUkM9eQojIENPTkZJR19VTldJTkRFUl9GUkFNRV9QT0lO
VEVSIGlzIG5vdCBzZXQKCiMKIyBTZWN1cml0eSBvcHRpb25zCiMKQ09ORklHX0tFWVM9eQpD
T05GSUdfS0VZU19DT01QQVQ9eQojIENPTkZJR19QRVJTSVNURU5UX0tFWVJJTkdTIGlzIG5v
dCBzZXQKIyBDT05GSUdfQklHX0tFWVMgaXMgbm90IHNldAojIENPTkZJR19FTkNSWVBURURf
S0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWV9ESF9PUEVSQVRJT05TIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VDVVJJVFlfRE1FU0dfUkVTVFJJQ1QgaXMgbm90IHNldApDT05GSUdfU0VD
VVJJVFk9eQpDT05GSUdfU0VDVVJJVFlfV1JJVEFCTEVfSE9PS1M9eQojIENPTkZJR19TRUNV
UklUWUZTIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX05FVFdPUks9eQpDT05GSUdfUEFH
RV9UQUJMRV9JU09MQVRJT049eQojIENPTkZJR19TRUNVUklUWV9ORVRXT1JLX1hGUk0gaXMg
bm90IHNldAojIENPTkZJR19TRUNVUklUWV9QQVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5U
RUxfVFhUIGlzIG5vdCBzZXQKQ09ORklHX0xTTV9NTUFQX01JTl9BRERSPTY1NTM2CkNPTkZJ
R19IQVZFX0hBUkRFTkVEX1VTRVJDT1BZX0FMTE9DQVRPUj15CkNPTkZJR19IQVJERU5FRF9V
U0VSQ09QWT15CkNPTkZJR19IQVJERU5FRF9VU0VSQ09QWV9GQUxMQkFDSz15CkNPTkZJR19G
T1JUSUZZX1NPVVJDRT15CiMgQ09ORklHX1NUQVRJQ19VU0VSTU9ERUhFTFBFUiBpcyBub3Qg
c2V0CkNPTkZJR19TRUNVUklUWV9TRUxJTlVYPXkKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhf
Qk9PVFBBUkFNPXkKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfQk9PVFBBUkFNX1ZBTFVFPTEK
Q09ORklHX1NFQ1VSSVRZX1NFTElOVVhfRElTQUJMRT15CkNPTkZJR19TRUNVUklUWV9TRUxJ
TlVYX0RFVkVMT1A9eQpDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9BVkNfU1RBVFM9eQpDT05G
SUdfU0VDVVJJVFlfU0VMSU5VWF9DSEVDS1JFUVBST1RfVkFMVUU9MAojIENPTkZJR19TRUNV
UklUWV9TTUFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1RPTU9ZTyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFQ1VSSVRZX0FQUEFSTU9SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VD
VVJJVFlfTE9BRFBJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1lBTUEgaXMgbm90
IHNldApDT05GSUdfSU5URUdSSVRZPXkKIyBDT05GSUdfSU5URUdSSVRZX1NJR05BVFVSRSBp
cyBub3Qgc2V0CkNPTkZJR19JTlRFR1JJVFlfQVVESVQ9eQojIENPTkZJR19JTUEgaXMgbm90
IHNldAojIENPTkZJR19FVk0gaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9TRUNVUklUWV9T
RUxJTlVYPXkKIyBDT05GSUdfREVGQVVMVF9TRUNVUklUWV9EQUMgaXMgbm90IHNldApDT05G
SUdfREVGQVVMVF9TRUNVUklUWT0ic2VsaW51eCIKQ09ORklHX0NSWVBUTz15CgojCiMgQ3J5
cHRvIGNvcmUgb3IgaGVscGVyCiMKQ09ORklHX0NSWVBUT19BTEdBUEk9eQpDT05GSUdfQ1JZ
UFRPX0FMR0FQSTI9eQpDT05GSUdfQ1JZUFRPX0FFQUQ9eQpDT05GSUdfQ1JZUFRPX0FFQUQy
PXkKQ09ORklHX0NSWVBUT19CTEtDSVBIRVI9eQpDT05GSUdfQ1JZUFRPX0JMS0NJUEhFUjI9
eQpDT05GSUdfQ1JZUFRPX0hBU0g9eQpDT05GSUdfQ1JZUFRPX0hBU0gyPXkKQ09ORklHX0NS
WVBUT19STkc9eQpDT05GSUdfQ1JZUFRPX1JORzI9eQpDT05GSUdfQ1JZUFRPX1JOR19ERUZB
VUxUPXkKQ09ORklHX0NSWVBUT19BS0NJUEhFUjI9eQpDT05GSUdfQ1JZUFRPX0FLQ0lQSEVS
PXkKQ09ORklHX0NSWVBUT19LUFAyPXkKQ09ORklHX0NSWVBUT19BQ09NUDI9eQpDT05GSUdf
Q1JZUFRPX1JTQT15CiMgQ09ORklHX0NSWVBUT19ESCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19FQ0RIIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19NQU5BR0VSPXkKQ09ORklHX0NS
WVBUT19NQU5BR0VSMj15CiMgQ09ORklHX0NSWVBUT19VU0VSIGlzIG5vdCBzZXQKQ09ORklH
X0NSWVBUT19NQU5BR0VSX0RJU0FCTEVfVEVTVFM9eQpDT05GSUdfQ1JZUFRPX0dGMTI4TVVM
PXkKQ09ORklHX0NSWVBUT19OVUxMPXkKQ09ORklHX0NSWVBUT19OVUxMMj15CiMgQ09ORklH
X0NSWVBUT19QQ1JZUFQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX1dPUktRVUVVRT15CiMg
Q09ORklHX0NSWVBUT19DUllQVEQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTUNSWVBU
RCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fQVVUSEVOQz15CiMgQ09ORklHX0NSWVBUT19U
RVNUIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19FTkdJTkU9bQoKIwojIEF1dGhlbnRpY2F0
ZWQgRW5jcnlwdGlvbiB3aXRoIEFzc29jaWF0ZWQgRGF0YQojCkNPTkZJR19DUllQVE9fQ0NN
PXkKQ09ORklHX0NSWVBUT19HQ009eQojIENPTkZJR19DUllQVE9fQ0hBQ0hBMjBQT0xZMTMw
NSBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fU0VRSVY9eQpDT05GSUdfQ1JZUFRPX0VDSEFJ
TklWPXkKCiMKIyBCbG9jayBtb2RlcwojCkNPTkZJR19DUllQVE9fQ0JDPXkKIyBDT05GSUdf
Q1JZUFRPX0NGQiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fQ1RSPXkKIyBDT05GSUdfQ1JZ
UFRPX0NUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19FQ0IgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fTFJXIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1BDQkMgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fWFRTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0tF
WVdSQVAgaXMgbm90IHNldAoKIwojIEhhc2ggbW9kZXMKIwpDT05GSUdfQ1JZUFRPX0NNQUM9
eQpDT05GSUdfQ1JZUFRPX0hNQUM9eQojIENPTkZJR19DUllQVE9fWENCQyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19WTUFDIGlzIG5vdCBzZXQKCiMKIyBEaWdlc3QKIwpDT05GSUdf
Q1JZUFRPX0NSQzMyQz15CiMgQ09ORklHX0NSWVBUT19DUkMzMkNfSU5URUwgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fQ1JDMzIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1JD
MzJfUENMTVVMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NSQ1QxMERJRiBpcyBub3Qg
c2V0CkNPTkZJR19DUllQVE9fR0hBU0g9eQojIENPTkZJR19DUllQVE9fUE9MWTEzMDUgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fUE9MWTEzMDVfWDg2XzY0IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX01ENCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fTUQ1PXkKIyBDT05G
SUdfQ1JZUFRPX01JQ0hBRUxfTUlDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDEy
OCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19STUQxNjAgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fUk1EMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDMyMCBpcyBu
b3Qgc2V0CkNPTkZJR19DUllQVE9fU0hBMT15CiMgQ09ORklHX0NSWVBUT19TSEExX1NTU0Uz
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTI1Nl9TU1NFMyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19TSEE1MTJfU1NTRTMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
U0hBMV9NQiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEEyNTZfTUIgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fU0hBNTEyX01CIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19T
SEEyNTY9eQojIENPTkZJR19DUllQVE9fU0hBNTEyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX1NIQTMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU00zIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX1RHUjE5MiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19XUDUxMiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19HSEFTSF9DTE1VTF9OSV9JTlRFTCBpcyBub3Qg
c2V0CgojCiMgQ2lwaGVycwojCkNPTkZJR19DUllQVE9fQUVTPXkKIyBDT05GSUdfQ1JZUFRP
X0FFU19USSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BRVNfWDg2XzY0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0FFU19OSV9JTlRFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19BTlVCSVMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FSQzQ9eQojIENPTkZJR19D
UllQVE9fQkxPV0ZJU0ggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQkxPV0ZJU0hfWDg2
XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX0NBTUVMTElBX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19DQU1FTExJQV9BRVNOSV9BVlhfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X0NBTUVMTElBX0FFU05JX0FWWDJfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X0NBU1Q1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q1X0FWWF9YODZfNjQgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fQ0FTVDYgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fQ0FTVDZfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fREVTPXkKIyBD
T05GSUdfQ1JZUFRPX0RFUzNfRURFX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19GQ1JZUFQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fS0hBWkFEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX1NBTFNBMjAgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0FM
U0EyMF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0hBQ0hBMjAgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fQ0hBQ0hBMjBfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1NFRUQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0VSUEVOVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UX1NTRTJfWDg2XzY0IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX1NFUlBFTlRfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19TRVJQRU5UX0FWWDJfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X1NNNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TUEVDSyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19URUEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVFdPRklTSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNIX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19UV09GSVNIX1g4Nl82NF8zV0FZIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX1RXT0ZJU0hfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CgojCiMgQ29tcHJlc3Npb24KIwoj
IENPTkZJR19DUllQVE9fREVGTEFURSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWk8g
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fODQyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX0xaNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWjRIQyBpcyBub3Qgc2V0Cgoj
CiMgUmFuZG9tIE51bWJlciBHZW5lcmF0aW9uCiMKIyBDT05GSUdfQ1JZUFRPX0FOU0lfQ1BS
TkcgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RSQkdfTUVOVT15CkNPTkZJR19DUllQVE9f
RFJCR19ITUFDPXkKIyBDT05GSUdfQ1JZUFRPX0RSQkdfSEFTSCBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19EUkJHX0NUUiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fRFJCRz15CkNP
TkZJR19DUllQVE9fSklUVEVSRU5UUk9QWT15CiMgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9I
QVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1NLQ0lQSEVSIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1JORyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19VU0VSX0FQSV9BRUFEIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19IQVNIX0lO
Rk89eQpDT05GSUdfQ1JZUFRPX0hXPXkKIyBDT05GSUdfQ1JZUFRPX0RFVl9QQURMT0NLIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9DQ1AgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fREVWX1FBVF9ESDg5NXhDQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZf
UUFUX0MzWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfQzYyWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFUX0RIODk1eENDVkYgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fREVWX1FBVF9DM1hYWFZGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX0RFVl9RQVRfQzYyWFZGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9OSVRS
T1hfQ05ONTVYWCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fREVWX1ZJUlRJTz1tCkNPTkZJ
R19BU1lNTUVUUklDX0tFWV9UWVBFPXkKQ09ORklHX0FTWU1NRVRSSUNfUFVCTElDX0tFWV9T
VUJUWVBFPXkKQ09ORklHX1g1MDlfQ0VSVElGSUNBVEVfUEFSU0VSPXkKQ09ORklHX1BLQ1M3
X01FU1NBR0VfUEFSU0VSPXkKIyBDT05GSUdfUEtDUzdfVEVTVF9LRVkgaXMgbm90IHNldAoj
IENPTkZJR19TSUdORURfUEVfRklMRV9WRVJJRklDQVRJT04gaXMgbm90IHNldAoKIwojIENl
cnRpZmljYXRlcyBmb3Igc2lnbmF0dXJlIGNoZWNraW5nCiMKQ09ORklHX1NZU1RFTV9UUlVT
VEVEX0tFWVJJTkc9eQpDT05GSUdfU1lTVEVNX1RSVVNURURfS0VZUz0iIgojIENPTkZJR19T
WVNURU1fRVhUUkFfQ0VSVElGSUNBVEUgaXMgbm90IHNldAojIENPTkZJR19TRUNPTkRBUllf
VFJVU1RFRF9LRVlSSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVEVNX0JMQUNLTElTVF9L
RVlSSU5HIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfS1ZNPXkKQ09ORklHX1ZJUlRVQUxJWkFU
SU9OPXkKIyBDT05GSUdfS1ZNIGlzIG5vdCBzZXQKIyBDT05GSUdfVkhPU1RfTkVUIGlzIG5v
dCBzZXQKIyBDT05GSUdfVkhPU1RfQ1JPU1NfRU5ESUFOX0xFR0FDWSBpcyBub3Qgc2V0CkNP
TkZJR19CSU5BUllfUFJJTlRGPXkKCiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0JJ
VFJFVkVSU0U9eQpDT05GSUdfUkFUSU9OQUw9eQpDT05GSUdfR0VORVJJQ19TVFJOQ1BZX0ZS
T01fVVNFUj15CkNPTkZJR19HRU5FUklDX1NUUk5MRU5fVVNFUj15CkNPTkZJR19HRU5FUklD
X05FVF9VVElMUz15CkNPTkZJR19HRU5FUklDX0ZJTkRfRklSU1RfQklUPXkKQ09ORklHX0dF
TkVSSUNfUENJX0lPTUFQPXkKQ09ORklHX0dFTkVSSUNfSU9NQVA9eQpDT05GSUdfQVJDSF9V
U0VfQ01QWENIR19MT0NLUkVGPXkKQ09ORklHX0FSQ0hfSEFTX0ZBU1RfTVVMVElQTElFUj15
CkNPTkZJR19DUkNfQ0NJVFQ9eQpDT05GSUdfQ1JDMTY9eQojIENPTkZJR19DUkNfVDEwRElG
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDX0lUVV9UIGlzIG5vdCBzZXQKQ09ORklHX0NSQzMy
PXkKIyBDT05GSUdfQ1JDMzJfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfQ1JDMzJfU0xJ
Q0VCWTg9eQojIENPTkZJR19DUkMzMl9TTElDRUJZNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
QzMyX1NBUldBVEUgaXMgbm90IHNldAojIENPTkZJR19DUkMzMl9CSVQgaXMgbm90IHNldAoj
IENPTkZJR19DUkM0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDNyBpcyBub3Qgc2V0CiMgQ09O
RklHX0xJQkNSQzMyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzggaXMgbm90IHNldAojIENP
TkZJR19SQU5ET00zMl9TRUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19aTElCX0lORkxBVEU9
eQpDT05GSUdfWkxJQl9ERUZMQVRFPXkKQ09ORklHX0xaT19DT01QUkVTUz15CkNPTkZJR19M
Wk9fREVDT01QUkVTUz15CkNPTkZJR19MWjRfREVDT01QUkVTUz15CkNPTkZJR19YWl9ERUM9
eQpDT05GSUdfWFpfREVDX1g4Nj15CkNPTkZJR19YWl9ERUNfUE9XRVJQQz15CkNPTkZJR19Y
Wl9ERUNfSUE2ND15CkNPTkZJR19YWl9ERUNfQVJNPXkKQ09ORklHX1haX0RFQ19BUk1USFVN
Qj15CkNPTkZJR19YWl9ERUNfU1BBUkM9eQpDT05GSUdfWFpfREVDX0JDSj15CiMgQ09ORklH
X1haX0RFQ19URVNUIGlzIG5vdCBzZXQKQ09ORklHX0RFQ09NUFJFU1NfR1pJUD15CkNPTkZJ
R19ERUNPTVBSRVNTX0JaSVAyPXkKQ09ORklHX0RFQ09NUFJFU1NfTFpNQT15CkNPTkZJR19E
RUNPTVBSRVNTX1haPXkKQ09ORklHX0RFQ09NUFJFU1NfTFpPPXkKQ09ORklHX0RFQ09NUFJF
U1NfTFo0PXkKQ09ORklHX0dFTkVSSUNfQUxMT0NBVE9SPXkKQ09ORklHX0lOVEVSVkFMX1RS
RUU9eQpDT05GSUdfQVNTT0NJQVRJVkVfQVJSQVk9eQpDT05GSUdfSEFTX0lPTUVNPXkKQ09O
RklHX0hBU19JT1BPUlRfTUFQPXkKQ09ORklHX0hBU19ETUE9eQpDT05GSUdfU0dMX0FMTE9D
PXkKQ09ORklHX0RNQV9ESVJFQ1RfT1BTPXkKQ09ORklHX0NIRUNLX1NJR05BVFVSRT15CkNP
TkZJR19DUFVfUk1BUD15CkNPTkZJR19EUUw9eQpDT05GSUdfR0xPQj15CiMgQ09ORklHX0dM
T0JfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfTkxBVFRSPXkKQ09ORklHX0NMWl9UQUI9
eQojIENPTkZJR19DT1JESUMgaXMgbm90IHNldAojIENPTkZJR19ERFIgaXMgbm90IHNldAoj
IENPTkZJR19JUlFfUE9MTCBpcyBub3Qgc2V0CkNPTkZJR19NUElMSUI9eQpDT05GSUdfT0lE
X1JFR0lTVFJZPXkKQ09ORklHX1VDUzJfU1RSSU5HPXkKQ09ORklHX0ZPTlRfU1VQUE9SVD15
CiMgQ09ORklHX0ZPTlRTIGlzIG5vdCBzZXQKQ09ORklHX0ZPTlRfOHg4PXkKQ09ORklHX0ZP
TlRfOHgxNj15CkNPTkZJR19TR19QT09MPXkKQ09ORklHX0FSQ0hfSEFTX1NHX0NIQUlOPXkK
Q09ORklHX0FSQ0hfSEFTX1BNRU1fQVBJPXkKQ09ORklHX0FSQ0hfSEFTX1VBQ0NFU1NfRkxV
U0hDQUNIRT15CkNPTkZJR19TVEFDS0RFUE9UPXkKQ09ORklHX1NCSVRNQVA9eQojIENPTkZJ
R19TVFJJTkdfU0VMRlRFU1QgaXMgbm90IHNldAo=
--------------2F98B52CD204307F268FBB46
Content-Type: text/x-csrc;
 name="main1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="main1.c"

// autogenerated by syzkaller (http://github.com/google/syzkaller)

#define _GNU_SOURCE 
#include <endian.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <stdint.h>
#include <string.h>

static uintptr_t syz_open_dev(uintptr_t a0, uintptr_t a1, uintptr_t a2)
{
	if (a0 == 0xc || a0 == 0xb) {
		char buf[128];
		sprintf(buf, "/dev/%s/%d:%d", a0 == 0xc ? "char" : "block", (uint8_t)a1, (uint8_t)a2);
		return open(buf, O_RDWR, 0);
	} else {
		char buf[1024];
		char* hash;
strncpy(buf, (char*)a0, sizeof(buf));
		buf[sizeof(buf) - 1] = 0;
		while ((hash = strchr(buf, '#'))) {
			*hash = '0' + (char)(a1 % 10);
			a1 /= 10;
		}
		return open(buf, a2, 0);
	}
}

static void execute_one();
extern unsigned long long procid;

void loop()
{
	while (1) {
		execute_one();
	}
}

uint64_t r[1] = {0xffffffffffffffff};
unsigned long long procid;
void execute_one()
{
	long res = 0;
*(uint64_t*)0x20000140 = 0x20000080;
*(uint16_t*)0x20000080 = 0x10;
*(uint16_t*)0x20000082 = 0;
*(uint32_t*)0x20000084 = 0;
*(uint32_t*)0x20000088 = 0x2008;
*(uint32_t*)0x20000148 = 0xc;
*(uint64_t*)0x20000150 = 0x20000100;
*(uint64_t*)0x20000100 = 0x200000c0;
*(uint32_t*)0x200000c0 = 0x10;
*(uint16_t*)0x200000c4 = 0x14;
*(uint16_t*)0x200000c6 = 8;
*(uint32_t*)0x200000c8 = 0x70bd26;
*(uint32_t*)0x200000cc = 0x25dfdbfe;
*(uint64_t*)0x20000108 = 0x10;
*(uint64_t*)0x20000158 = 1;
*(uint64_t*)0x20000160 = 0;
*(uint64_t*)0x20000168 = 0;
*(uint32_t*)0x20000170 = 0x40;
	syscall(__NR_sendmsg, -1, 0x20000140, 0x4040000);
memcpy((void*)0x20000040, "/dev/sg#", 9);
	res = syz_open_dev(0x20000040, 0, 0x8006);
	if (res != -1)
		r[0] = res;
	syscall(__NR_ioctl, r[0], 1, 0x20000080);
}

int main()
{
	syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
	for (procid = 0; procid < 8; procid++) {
		if (fork() == 0) {
			for (;;) {
				loop();
			}
		}
	}
	sleep(1000000);
	return 0;
}


--------------2F98B52CD204307F268FBB46--
