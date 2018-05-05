Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeEETVV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 15:21:21 -0400
Received: from mr11p00im-asmtp002.me.com ([17.110.69.253]:30360 "EHLO
        mr11p00im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeEETVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 15:21:20 -0400
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-05_12:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805050191
Date: Sat, 05 May 2018 21:21:12 +0200
From: damian <damian.tometzki@icloud.com>
To: jpoimboe@redhat.com, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Kernel build with gcc 8 a lot of warnings
Message-id: <20180505192112.GA18728@zrhn9910b>
Mail-followup-to: jpoimboe@redhat.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helllo together,

Hello everybody,

is something special to note when kernel build with gcc 8? I receive various warnings from the objtool:
With GCC 7 works all fine.

kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x40: sibling call from callable instruction with modified stack frame
kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x2a3: sibling call from callable instruction with modified stack frame
kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x20b: sibling call from callable instruction with modified stack frame
kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x296: sibling call from callable instruction with modified stack frame
kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable()+0x10: sibling call from callable instruction with modified stack frame
kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags.cold.45()+0xa: call without frame pointer save/setup
kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files.cold.46()+0x17: call without frame pointer save/setup
kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable.cold.47()+0x24: call without frame pointer save/setup
kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems.cold.48()+0x10: call without frame pointer save/setup
kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable.cold.49()+0x7: call without frame pointer save/setup
  CC      kernel/cgroup/stat.o
  CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic()+0x10: sibling call from callable instruction with modified stack frame
arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu()+0x2c: sibling call from callable instruction with modified stack frame
arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic.cold.6()+0x7: call without frame pointer save/setup
arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu.cold.7()+0x7: call without frame pointer save/setup

Best regards
Damian
