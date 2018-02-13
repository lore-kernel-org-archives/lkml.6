Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4003672-1518522647-2-7763303350569595616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518522646; b=cJHOuT6nl3LvGcLcnQKa8A7SLqGhuOHle48Lv+Q44EzJ0YI
    meFO/GDqlLqOY0VaZ34fBroE9S7DFcuDsIOqCWIRYgOMVxncQUJAwBTz02vy+MdI
    12a0UhMEsrtmoy/OwyeHG0bYP8AWht86MUjXX6OwBopmCuXLOxrmDqpj9A+0IxcY
    x9589GTXDooEeM55T9ZIBTBioeVmCdjH3y5bZcLZKLWHBE10ig8HTbxOBHpOgBRf
    5HLePH/Gl0LUZKLTEDMOelxlxsRSqKW7NkXufM/N/btrnZ7tcS/Zvb06Qh/KTv7V
    b0uXEaRdmsZBDzIqnCc6HWGfHR3Jh/EaqKxlbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518522646; bh=u1i/47iV2OYV4886/tCS+1ug20gIC21fWOloVO6X7/E=; b=A
    ou7pIbPGl69ZADEQMjrTFaJx7G+BtxS+a/9P3/B4uQwz8MunKLwfMQ9Wd+wu+zmV
    B5DVv9LRVNBlfdHRbVOsbSpgr3k+zWxx/XKg6rwQE9XZkiHITq07fYBTs/RCufCn
    QNf6z+O9FfvIp7TSimgaBDS79ULlGz4GAEhZp/KGSRX2NrYVJkkBWg8weeZTSbGB
    kVNJtFAlSQ/b82eDn/kQXpUuieEbPxqUgOs7yZP3tnOxCBoJD0+UjMQDA7jvUV4Z
    dsT4/mCUAlJYOOGy7PHhZGvjKbMDj871R1jkn67PV3fD9yIIdAj7n6WV0s4sH226
    oqOTYimxZfOmVLSokI22Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934573AbeBMLun (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 06:50:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeBMLul (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 06:50:41 -0500
Date: Tue, 13 Feb 2018 12:50:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.81
Message-ID: <20180213115042.GA2914@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.81 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/kernel-parameters.txt                 |    2=20
 Documentation/speculation.txt                       |   90 ++
 Makefile                                            |    2=20
 arch/powerpc/Kconfig                                |    1=20
 arch/powerpc/include/asm/exception-64e.h            |    6=20
 arch/powerpc/include/asm/exception-64s.h            |   53 +
 arch/powerpc/include/asm/feature-fixups.h           |   15=20
 arch/powerpc/include/asm/hvcall.h                   |   17=20
 arch/powerpc/include/asm/paca.h                     |   10=20
 arch/powerpc/include/asm/plpar_wrappers.h           |   14=20
 arch/powerpc/include/asm/setup.h                    |   13=20
 arch/powerpc/kernel/asm-offsets.c                   |    4=20
 arch/powerpc/kernel/entry_64.S                      |   30=20
 arch/powerpc/kernel/exceptions-64s.S                |  108 ++
 arch/powerpc/kernel/setup_64.c                      |  139 +++
 arch/powerpc/kernel/vmlinux.lds.S                   |    9=20
 arch/powerpc/lib/feature-fixups.c                   |   42 +
 arch/powerpc/platforms/powernv/setup.c              |   50 +
 arch/powerpc/platforms/pseries/setup.c              |   35=20
 arch/x86/entry/common.c                             |    9=20
 arch/x86/entry/entry_32.S                           |    3=20
 arch/x86/entry/entry_64.S                           |  134 ---
 arch/x86/entry/syscall_64.c                         |    7=20
 arch/x86/events/intel/bts.c                         |   44 -
 arch/x86/include/asm/asm-prototypes.h               |    4=20
 arch/x86/include/asm/asm.h                          |    4=20
 arch/x86/include/asm/barrier.h                      |   28=20
 arch/x86/include/asm/cpufeature.h                   |    7=20
 arch/x86/include/asm/cpufeatures.h                  |   22=20
 arch/x86/include/asm/disabled-features.h            |    3=20
 arch/x86/include/asm/intel-family.h                 |    7=20
 arch/x86/include/asm/msr-index.h                    |   12=20
 arch/x86/include/asm/msr.h                          |    3=20
 arch/x86/include/asm/nospec-branch.h                |   91 --
 arch/x86/include/asm/pgalloc.h                      |   11=20
 arch/x86/include/asm/pgtable.h                      |    6=20
 arch/x86/include/asm/processor.h                    |    2=20
 arch/x86/include/asm/required-features.h            |    3=20
 arch/x86/include/asm/syscall.h                      |    6=20
 arch/x86/include/asm/thread_info.h                  |    3=20
 arch/x86/include/asm/uaccess.h                      |   15=20
 arch/x86/include/asm/uaccess_32.h                   |   12=20
 arch/x86/include/asm/uaccess_64.h                   |   12=20
 arch/x86/kernel/alternative.c                       |   14=20
 arch/x86/kernel/cpu/bugs.c                          |  128 ++-
 arch/x86/kernel/cpu/common.c                        |   70 +
 arch/x86/kernel/cpu/intel.c                         |   66 +
 arch/x86/kernel/cpu/microcode/core.c                |   47 -
 arch/x86/kernel/cpu/scattered.c                     |    2=20
 arch/x86/kernel/process_64.c                        |    4=20
 arch/x86/kernel/ptrace.c                            |    2=20
 arch/x86/kernel/signal.c                            |    2=20
 arch/x86/kernel/tboot.c                             |   10=20
 arch/x86/kvm/cpuid.c                                |   21=20
 arch/x86/kvm/cpuid.h                                |   31=20
 arch/x86/kvm/emulate.c                              |   10=20
 arch/x86/kvm/svm.c                                  |  116 +++
 arch/x86/kvm/vmx.c                                  |  763 ++++++++++-----=
-----
 arch/x86/kvm/x86.c                                  |    1=20
 arch/x86/lib/Makefile                               |    1=20
 arch/x86/lib/getuser.S                              |   10=20
 arch/x86/lib/retpoline.S                            |   57 +
 arch/x86/lib/usercopy_32.c                          |    8=20
 crypto/tcrypt.c                                     |    6=20
 drivers/auxdisplay/img-ascii-lcd.c                  |    4=20
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c              |   55 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h              |    8=20
 drivers/media/platform/soc_camera/soc_scale_crop.c  |    4=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |   18=20
 drivers/net/ethernet/realtek/r8169.c                |    4=20
 drivers/net/usb/qmi_wwan.c                          |    1=20
 drivers/net/wireless/broadcom/b43/main.c            |   10=20
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c                |    4=20
 drivers/tty/serial/serial_core.c                    |    2=20
 drivers/vhost/net.c                                 |    1=20
 include/linux/fdtable.h                             |    5=20
 include/linux/init.h                                |    9=20
 include/linux/module.h                              |    9=20
 include/linux/nospec.h                              |   72 +
 kernel/module.c                                     |   11=20
 net/core/sock_reuseport.c                           |   35=20
 net/ipv4/igmp.c                                     |    4=20
 net/ipv4/tcp.c                                      |    6=20
 net/ipv4/tcp_bbr.c                                  |    6=20
 net/ipv6/af_inet6.c                                 |   11=20
 net/ipv6/ip6mr.c                                    |    1=20
 net/sched/cls_u32.c                                 |   12=20
 net/wireless/nl80211.c                              |    9=20
 scripts/mod/modpost.c                               |    9=20
 security/keys/encrypted-keys/encrypted.c            |   31=20
 sound/soc/codecs/pcm512x-spi.c                      |    4=20
 sound/soc/generic/simple-card.c                     |    8=20
 sound/soc/sh/rcar/ssi.c                             |    5=20
 93 files changed, 2026 insertions(+), 789 deletions(-)

Andi Kleen (1):
      module/retpoline: Warn about missing retpoline in module

Andy Lutomirski (3):
      x86/entry/64: Remove the SYSCALL64 fast path
      x86/entry/64: Push extra regs right away
      x86/asm: Move 'status' from thread_struct to thread_info

Arnd Bergmann (1):
      x86/pti: Mark constant arrays as __initconst

Ashok Raj (1):
      KVM/x86: Add IBPB support

Borislav Petkov (5):
      x86/microcode/AMD: Do not load when running on a hypervisor
      x86/nospec: Fix header guards names
      x86/bugs: Drop one "mitigation" from dmesg
      x86/retpoline: Simplify vmexit_fill_RSB()
      x86/microcode: Do the family check first

Chunhao Lin (1):
      r8169: fix RTL8168EP take too long to complete driver initialization.

Colin Ian King (1):
      x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"

Dan Williams (12):
      array_index_nospec: Sanitize speculative array de-references
      x86: Implement array_index_mask_nospec
      x86: Introduce barrier_nospec
      x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
      x86/usercopy: Replace open coded stac/clac with __uaccess_{begin, end}
      x86/uaccess: Use __uaccess_begin_nospec() and uaccess_try_nospec
      x86/get_user: Use pointer masking to limit speculation
      x86/syscall: Sanitize syscall table de-references under speculation
      vfs, fdtable: Prevent bounds-check bypass via speculative execution
      nl80211: Sanitize array index in parse_txq_params
      x86/spectre: Report get_user mitigation for spectre_v1
      x86/kvm: Update spectre-v1 mitigation

Darren Kenny (1):
      x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL

Dave Hansen (1):
      x86/pti: Make unpoison of pgd for trusted boot work for real

David Hildenbrand (2):
      KVM: nVMX: kmap() can't fail
      KVM: nVMX: vmx_complete_nested_posted_interrupt() can't fail

David Matlack (1):
      KVM: nVMX: mark vmcs12 pages dirty on L2 exit

David Woodhouse (10):
      x86/cpufeatures: Add CPUID_7_EDX CPUID leaf
      x86/cpufeatures: Add Intel feature bits for Speculation Control
      x86/cpufeatures: Add AMD feature bits for Speculation Control
      x86/msr: Add definitions for new speculation control MSRs
      x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdo=
wn
      x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 micr=
ocodes
      x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) =
support
      x86/cpufeatures: Clean up Spectre v2 related CPUID flags
      x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel
      x86/retpoline: Avoid retpolines for built-in __init functions

Dou Liyang (1):
      x86/spectre: Check CONFIG_RETPOLINE in command line parser

Eric Biggers (1):
      KEYS: encrypted: fix buffer overread in valid_master_desc()

Eric Dumazet (2):
      net: igmp: add a missing rcu locking section
      soreuseport: fix mem leak in reuseport_add_sock()

Greg Kroah-Hartman (1):
      Linux 4.9.81

Hugh Dickins (2):
      kaiser: fix intel_bts perf crashes
      kaiser: allocate pgd with order 0 when pti=3Doff

Jason Wang (1):
      vhost_net: stop device during reset owner

Jesse Chan (4):
      auxdisplay: img-ascii-lcd: add missing MODULE_DESCRIPTION/AUTHOR/LICE=
NSE
      pinctrl: pxa: pxa2xx: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUT=
HOR/LICENSE

Jim Mattson (1):
      KVM: nVMX: Eliminate vmcs02 pool

Josh Poimboeuf (2):
      x86/asm: Fix inline asm call constraints for GCC 4.4
      x86/paravirt: Remove 'noreplace-paravirt' cmdline option

Julian Scheel (1):
      ASoC: simple-card: Fix misleading error message

Junxiao Bi (1):
      qlcnic: fix deadlock bug

KarimAllah Ahmed (4):
      x86/spectre: Simplify spectre_v2 command line parsing
      KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
      KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
      KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL

Kristian Evensen (1):
      qmi_wwan: Add support for Quectel EP06

Kuninori Morimoto (2):
      ASoC: rsnd: don't call free_irq() on Parent SSI
      ASoC: rsnd: avoid duplicate free_irq()

Laurent Pinchart (2):
      drm: rcar-du: Use the VBK interrupt for vblank events
      drm: rcar-du: Fix race condition when disabling planes at CRTC stop

Li RongQing (1):
      tcp: release sk_frag.page in tcp_disconnect

Mark Rutland (1):
      Documentation: Document array_index_nospec

Martin KaFai Lau (1):
      ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only

Michael Ellerman (4):
      powerpc/64s: Add support for RFI flush of L1-D cache
      powerpc/64s: Support disabling RFI flush with no_rfi_flush and nopti
      powerpc/64s: Wire up cpu_show_meltdown()
      powerpc/64s: Allow control of RFI flush via debugfs

Michael Neuling (2):
      powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper
      powerpc/pseries: Query hypervisor for RFI flush settings

Neal Cardwell (1):
      tcp_bbr: fix pacing_gain to always be unity when using lt_bw

Nicholas Piggin (4):
      powerpc/64: Add macros for annotating the destination of rfid/hrfid
      powerpc/64: Convert fast_exception_return to use RFI_TO_USER/KERNEL
      powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL
      powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL

Nikolay Aleksandrov (1):
      ip6mr: fix stale iterator

Oliver O'Halloran (1):
      powerpc/powernv: Check device-tree for RFI flush settings

Paolo Abeni (1):
      cls_u32: add missing RCU annotation.

Paolo Bonzini (2):
      KVM: VMX: introduce alloc_loaded_vmcs
      KVM: VMX: make MSR bitmaps per-VCPU

Peter Zijlstra (2):
      KVM: x86: Make indirect calls in emulator speculation safe
      KVM: VMX: Make indirect call speculation safe

Robert Baronescu (1):
      crypto: tcrypt - fix S/G table for test_aead_speed()

Sebastian Andrzej Siewior (1):
      serial: core: mark port as initialized after successful IRQ change

Takashi Iwai (1):
      b43: Add missing MODULE_FIRMWARE()

Thomas Gleixner (1):
      x86/cpu/bugs: Make retpoline module warning conditional

Waiman Long (1):
      x86/retpoline: Remove the esp/rsp thunk


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqC0Q8ACgkQONu9yGCS
aT4IhBAAy2XguD9AX7++k9G+IFkHG5PRvyOKOEN82rSZVN4JlVimjLH3gg6lEmzU
T+0JhpM1ZwrTYH1XMVnOOuRDD1bR16DxtdVl6UUDN48BlBFM12Eipw3UTgJ/meKW
9ZwPsDHjW+DzqOLqnAr78H7gm5jsabCwwGshOUtOxBCxRy/CoZBzN0C9p+iqJghE
X8Hv0NPAph56OXN/fbZYiHpSkFMVobTf1wzaXY5uDirKJH7zV24Z6nz70I4eNpw0
VTLHQbK7y/w7YQZpaR9GoTwYH/ZOT5czFnCO7ofSBv7WVr/ihrykR+9L2sh3Qyxo
EQf9ebPM2O39kfHvHbj/8hZfdbpvDAzz/HVbvZGeBrseO9KxSSkEduo3q6OiaCdP
oOSPeEId5uMugy3csbD8LoT7erFmuCKN9Ge0Bp8IpDVOZVnMT5CLCy2B7vWzx+zA
vA/REubQfJhl7HJSUGnzcLThRM/Gu9Ep8Xr18ZSTGFLlUmy4XOEQzrhMaUaGon1B
f4AfAt3JeTfMpEmmbheSiEYSS6d0mvRygwId3vGRMI+AdhpD7puxwplaZKMf1yYc
L+z6mux6Dzzd69qKLVRKuTsxxvViQ7wX2EtiZA1fCmEikXQOUpT7xmCh3/ip3oUM
HEA6z7TMV/9fFIMoOXfFMW4DXMgs82x/vm+D2lUbaPT3LZR6y/g=
=yOfP
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
