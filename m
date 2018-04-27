Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoLagcwTX1nUWxpUSO/p3TMDN1tlkrnnJGhGha7Dg6rEQM6waukZ+z2/klPHBu1jBsS3ewW
ARC-Seal: i=1; a=rsa-sha256; t=1524837796; cv=none;
        d=google.com; s=arc-20160816;
        b=u/s21b8tnSM4ZAnOCqs1lReNCFqqHS1Hd3RylKtBnHNMZJdrO8XYPF3mZoHDOmgMns
         54cF3WGG759Cep5JbSsOrETN7r6GJS0Couydd/YFPmZ2Z8LalDgSjAhzjIbvQeSd5h0P
         vLvnsnPXxFr2WR+W6GjpXphKyl2XIsxj/K0z939NZmb1ECoS6qsvY/DRgxG1THft2YMT
         jIMyemyCukbFYtZuMEHDB9cO/jzJpHLbBsr2vNg9inmxmQfzrhuDSHhuWhDkitwEOpNJ
         X+RQAOvi0L9xF0izDaZ3OtU2aX2Il/e5oka9bd2uRc+CAUj09umHErO0cvXW2ox1DsxF
         BFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=1f4Q+pJ2mRJ/n1mYIXS6BvgbgNQXUiwjeMQUpEOJXhc=;
        b=Z0xVDTEj0JZqE8PR7BP3kyhm04aPwIC19cchk3vapZWfVit7R82iCs6g6AZ1bOrLRO
         oAfy3+eQE1/VH4uOYyMSGo6HP4shfd36McYJq3+H4XZq3wLlGSX2ctfSpldR4zeEkxn/
         qFC2tBgPR4HCywgCNtr1GqqrUunVZWTVFZKjfupqHFpauiytIAg6iIGji5KkUW/v7Pud
         /OajY9kul+Uz0DoCPkpTAmDfxlK7ZXJGEW9J+6JdBbLmR4BFNZsdJKqiQlG+1cKxc+bR
         1hL3qMKIKsRJX9+kUAk9EgGZNDcSCEkvVYteUbZQKA/6zpOszBpQ9EyZmf0Oe98CYnKW
         vWFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50483218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.9 00/74] 4.9.97-stable review
Date: Fri, 27 Apr 2018 15:57:50 +0200
Message-Id: <20180427135709.899303463@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.97-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.97-rc1
X-KernelTest-Deadline: 2018-04-29T13:57+00:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908317228713004?=
X-GMAIL-MSGID: =?utf-8?q?1598908317228713004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.97 release.
There are 74 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr 29 13:56:52 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.97-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.97-rc1

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Only default only_lcd to true on Win8-ready _desktops_

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390/uprobes: implement arch_uretprobe_is_alive()

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: fix IO error for newly defined devices

Sebastian Ott <sebott@linux.ibm.com>
    s390/cio: update chpid descriptor after resource accessibility event

Dan Carpenter <dan.carpenter@oracle.com>
    cdrom: information leak in cdrom_ioctl_media_changed()

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: mptsas: Disable WRITE SAME

Doron Roberts-Kedes <doronrk@fb.com>
    strparser: Fix incorrect strp->need_bytes value.

Eric Dumazet <edumazet@google.com>
    ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Eric Dumazet <edumazet@google.com>
    net: af_packet: fix race in PACKET_{R|T}X_RING

Eric Dumazet <edumazet@google.com>
    tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets

Wolfgang Bumiller <w.bumiller@proxmox.com>
    net: fix deadlock while clearing neighbor proxy table

Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
    net: ethernet: ti: cpsw: fix tx vlan priority mapping

Cong Wang <xiyou.wangcong@gmail.com>
    llc: fix NULL pointer deref for SOCK_ZAPPED

Cong Wang <xiyou.wangcong@gmail.com>
    llc: hold llc_sap before release_sock()

Alexander Aring <aring@mojatatu.com>
    net: sched: ife: signal not finding metaid

Xin Long <lucien.xin@gmail.com>
    sctp: do not check port in sctp_inet6_cmp_addr

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Guillaume Nault <g.nault@alphalink.fr>
    pppoe: check sockaddr length in pppoe_connect()

Eric Dumazet <edumazet@google.com>
    tipc: add policy for TIPC_NLA_NET_ADDR

Willem de Bruijn <willemb@google.com>
    packet: fix bitfield update race

Xin Long <lucien.xin@gmail.com>
    team: fix netconsole setup over team

Paolo Abeni <pabeni@redhat.com>
    team: avoid adding twice the same option to the event list

Jann Horn <jannh@google.com>
    tcp: don't read out-of-bounds opsize

Cong Wang <xiyou.wangcong@gmail.com>
    llc: delete timers synchronously in llc_sk_free()

Eric Dumazet <edumazet@google.com>
    net: validate attribute sizes in neigh_dump_table()

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: check sockaddr length in pppol2tp_connect()

Eric Biggers <ebiggers@google.com>
    KEYS: DNS: limit the length of option strings

Xin Long <lucien.xin@gmail.com>
    bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: correct module section names for expoline code revert

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: correct nospec auto detection init order

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add sysfs attributes for spectre

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: report spectre mitigation via syslog

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add automatic detection of the spectre defense

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move nobp parameter functions to nospec-branch.c

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/entry.S: fix spurious zeroing of r0

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: do not bypass BPENTER for interrupt system calls

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)

Martin Schwidefsky <schwidefsky@de.ibm.com>
    KVM: s390: force bp isolation for VSIE

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: introduce execute-trampolines for branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: run user space and KVM guests with modified branch prediction

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add options to change branch prediction behaviour for the kernel

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/alternative: use a copy of the facility bit mask

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add optimized array_index_mask_nospec

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: scrub registers on kernel entry and KVM exit

Martin Schwidefsky <schwidefsky@de.ibm.com>
    KVM: s390: wire up bpb feature

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: enable CPU alternatives unconditionally

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: introduce CPU alternatives

Sinan Kaya <okaya@codeaurora.org>
    PCI: Wait up to 60 seconds for device to become ready after FLR

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    Revert "ath10k: send (re)assoc peer command when NSS changed"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "pinctrl: intel: Initialize GPIO properly when used through irqchip"

Grant Grundler <grundler@chromium.org>
    r8152: add Linksys USB3GIGV1 id

Benjamin Beichler <benjamin.beichler@uni-rostock.de>
    mac80211_hwsim: fix use-after-free bug in hwsim_exit_net

Imre Deak <imre.deak@intel.com>
    drm/i915/bxt, glk: Increase PCODE timeouts during CDCLK freq changing

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix NULL dereference while accessing XRC_TGT QPs

Jiri Olsa <jolsa@kernel.org>
    perf: Return proper values for user stack errors

Jiri Olsa <jolsa@kernel.org>
    perf: Fix sample_max_stack maximum check

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "perf tools: Decompress kernel module when reading DSO data"

Sahitya Tummala <stummala@codeaurora.org>
    jbd2: fix use after free in kjournald2()

Felix Fietkau <nbd@nbd.name>
    ath9k_hw: check if the chip failed to wake up

Paul Burton <paul.burton@imgtec.com>
    OF: Prevent unaligned access in of_alias_scan()

Dan Carpenter <dan.carpenter@oracle.com>
    stk-webcam: fix an endian bug in stk_camera_read_reg()

Colin Ian King <colin.king@canonical.com>
    power: supply: bq2415x: check for NULL acpi_id to avoid null pointer dereference

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: drv260x - fix initializing overdrive voltage

Matt Redfearn <matt.redfearn@imgtec.com>
    MIPS: Generic: Fix big endian CPUs on generic machine

Merlijn Wajer <merlijn@wizzup.org>
    usb: musb: Fix external abort in musb_remove on omap2430

Merlijn Wajer <merlijn@wizzup.org>
    usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers

Andreas Kemnade <andreas@kemnade.info>
    usb: musb: fix enumeration after resume

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Restore configuration at shutdown

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Save register SMBSLVCMD value only once

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    i2c: i801: store and restore the SLVCMD register at load and unload

Imre Deak <imre.deak@intel.com>
    drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state

Daniel J Blueman <daniel@quora.org>
    drm/vc4: Fix memory leak during BO teardown

Xiaoming Gao <gxm.linux.kernel@gmail.com>
    x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Steve French <smfrench@gmail.com>
    cifs: do not allow creating sockets except with SMB1 posix exensions


-------------

Diffstat:

 Documentation/kernel-parameters.txt        |   3 +
 Makefile                                   |   4 +-
 arch/mips/Kconfig                          |   1 +
 arch/s390/Kconfig                          |  47 ++++++
 arch/s390/Makefile                         |  10 ++
 arch/s390/include/asm/alternative.h        | 149 +++++++++++++++++
 arch/s390/include/asm/barrier.h            |  24 +++
 arch/s390/include/asm/facility.h           |  18 +++
 arch/s390/include/asm/kvm_host.h           |   3 +-
 arch/s390/include/asm/lowcore.h            |   7 +-
 arch/s390/include/asm/nospec-branch.h      |  17 ++
 arch/s390/include/asm/processor.h          |   4 +
 arch/s390/include/asm/thread_info.h        |   4 +
 arch/s390/include/uapi/asm/kvm.h           |   5 +-
 arch/s390/kernel/Makefile                  |   6 +-
 arch/s390/kernel/alternative.c             | 112 +++++++++++++
 arch/s390/kernel/early.c                   |   5 +
 arch/s390/kernel/entry.S                   | 250 ++++++++++++++++++++++++++---
 arch/s390/kernel/ipl.c                     |   1 +
 arch/s390/kernel/module.c                  |  65 +++++++-
 arch/s390/kernel/nospec-branch.c           | 169 +++++++++++++++++++
 arch/s390/kernel/processor.c               |  18 +++
 arch/s390/kernel/setup.c                   |  14 +-
 arch/s390/kernel/smp.c                     |   7 +-
 arch/s390/kernel/uprobes.c                 |   9 ++
 arch/s390/kernel/vmlinux.lds.S             |  37 +++++
 arch/s390/kvm/kvm-s390.c                   |  13 +-
 arch/s390/kvm/vsie.c                       |  30 ++++
 arch/x86/kernel/tsc.c                      |   2 +-
 drivers/acpi/acpi_video.c                  |  27 +++-
 drivers/cdrom/cdrom.c                      |   2 +-
 drivers/gpu/drm/drm_dp_dual_mode_helper.c  |  39 ++++-
 drivers/gpu/drm/i915/i915_drv.h            |   6 +-
 drivers/gpu/drm/i915/intel_display.c       |   9 +-
 drivers/gpu/drm/i915/intel_pm.c            |   6 +-
 drivers/gpu/drm/vc4/vc4_bo.c               |   2 +
 drivers/gpu/drm/vc4/vc4_validate_shaders.c |   1 +
 drivers/i2c/busses/i2c-i801.c              |  29 +++-
 drivers/infiniband/hw/mlx5/qp.c            |   3 +-
 drivers/input/misc/drv260x.c               |   2 +-
 drivers/media/usb/stkwebcam/stk-sensor.c   |   6 +-
 drivers/media/usb/stkwebcam/stk-webcam.c   |  11 +-
 drivers/media/usb/stkwebcam/stk-webcam.h   |   2 +-
 drivers/message/fusion/mptsas.c            |   1 +
 drivers/net/bonding/bond_main.c            |   3 +-
 drivers/net/ethernet/ti/cpsw.c             |   2 +-
 drivers/net/ppp/pppoe.c                    |   4 +
 drivers/net/team/team.c                    |  38 ++++-
 drivers/net/usb/cdc_ether.c                |  10 ++
 drivers/net/usb/r8152.c                    |   2 +
 drivers/net/wireless/ath/ath10k/mac.c      |   5 +-
 drivers/net/wireless/ath/ath9k/hw.c        |   4 +
 drivers/net/wireless/mac80211_hwsim.c      |   7 +-
 drivers/of/base.c                          |   2 +-
 drivers/pci/pci.c                          |  52 ++++--
 drivers/pinctrl/intel/pinctrl-intel.c      |  23 +--
 drivers/power/supply/bq2415x_charger.c     |   5 +
 drivers/s390/block/dasd_alias.c            |  13 +-
 drivers/s390/char/Makefile                 |   2 +
 drivers/s390/cio/chsc.c                    |  14 +-
 drivers/usb/musb/musb_core.c               |   8 +-
 fs/cifs/dir.c                              |   9 +-
 fs/jbd2/journal.c                          |   2 +-
 include/linux/if_vlan.h                    |   7 +-
 include/net/llc_conn.h                     |   1 +
 include/uapi/linux/kvm.h                   |   1 +
 kernel/events/callchain.c                  |  21 +--
 kernel/events/core.c                       |   4 +-
 net/core/dev.c                             |   2 +-
 net/core/neighbour.c                       |  40 +++--
 net/dns_resolver/dns_key.c                 |  13 +-
 net/ipv4/tcp.c                             |   6 +-
 net/ipv4/tcp_input.c                       |   7 +-
 net/ipv6/route.c                           |   2 +
 net/l2tp/l2tp_ppp.c                        |   7 +
 net/llc/af_llc.c                           |  14 +-
 net/llc/llc_c_ac.c                         |   9 +-
 net/llc/llc_conn.c                         |  22 ++-
 net/packet/af_packet.c                     |  82 +++++++---
 net/packet/internal.h                      |  10 +-
 net/sched/act_ife.c                        |   2 +-
 net/sctp/ipv6.c                            |  60 +++----
 net/strparser/strparser.c                  |   7 +-
 net/tipc/netlink.c                         |   3 +-
 tools/perf/util/dso.c                      |  16 --
 85 files changed, 1459 insertions(+), 262 deletions(-)
