Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F91320855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F91320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeKZJ7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:59:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51744 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:59:40 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6C4DD807BC; Mon, 26 Nov 2018 00:07:20 +0100 (CET)
Date:   Mon, 26 Nov 2018 00:07:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
Cc:     LKML <linux-kernel@vger.kernel.org>, bernie@plugable.com,
        linux-fbdev@vger.kernel.org, airlied@redhat.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org
Subject: Re: The "udl" driver crashes the kernel.
Message-ID: <20181125230722.GD30242@amd>
References: <31dc20a5-66f4-051c-dfec-73924b00c0f8@elektron.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <31dc20a5-66f4-051c-dfec-73924b00c0f8@elektron.elka.pw.edu.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-11-25 16:58:59, wzabolot@elektron.elka.pw.edu.pl wrote:
> When I connect my Displaylink DL-165 adapter to my Debian/testing
> machine, the "udl" driver is loaded and the following error messages
> appears in kernel logs:

4.18 kernel. Might be worth testing latest stable, and latest
mainline...

Is there version that worked for you?

I added udl maintainers to the Cc list.

Best regards,
								Pavel

>=20
> Nov=A0 7 20:47:30 wzdell kernel: [=A0 205.871354] usb 4-1.2: new high-spe=
ed
> USB device number 4 using ehci-pci
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.209020] usb 4-1.2: New USB devi=
ce
> found, idVendor=3D17e9, idProduct=3D0290, bcdDevice=3D 0.01
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.209027] usb 4-1.2: New USB devi=
ce
> strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.209032] usb 4-1.2: Product: DL-=
165
> Adapter
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.209036] usb 4-1.2: Manufacturer:
> DisplayLink
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.209040] usb 4-1.2: SerialNumber:
> 102140
> Nov=A0 7 20:47:35 wzdell mtp-probe: checking bus 4, device 4:
> "/sys/devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.2"
> Nov=A0 7 20:47:35 wzdell mtp-probe: bus: 4, device: 4 was not an MTP devi=
ce
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.269753] [drm] vendor descriptor
> length:22 data:22 5f 01 00 20 05 00 01 03 04 02
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.320940] [drm] Cannot find any c=
rtc
> or sizes
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.320962] [drm] Supports vblank
> timestamp caching Rev 2 (21.10.2013).
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.320963] [drm] No driver support
> for vblank timestamp query.
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.320999] [drm] Initialized udl
> 0.0.1 20120220 for 4-1.2:1.0 on minor 1
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.321002] [drm] Initialized udl on
> minor 1
> Nov=A0 7 20:47:35 wzdell kernel: [=A0 211.321078] usbcore: registered new
> interface driver udl
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.700722] WARNING: CPU: 0 PID: 10=
24
> at /build/linux-iActNR/linux-4.18.10/drivers/gpu/drm/drm_gem.c:893
> drm_gem_object_put+0x34/0x40 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.700726] Modules linked in: udl
> rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave
> bnep bbswitch(O) nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4
> nf_defrag_ipv4 nft_counter xt_owner xt_state xt_conntrack nf_conntrack
> libcrc32c nft_compat nf_tables nfnetlink binfmt_misc intel_rapl
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> uvcvideo arc4 iwldvm videobuf2_vmalloc mac80211 videobuf2_memops
> videobuf2_v4l2 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel
> videobuf2_common snd_hda_codec videodev snd_hda_core snd_hwdep snd_pcm
> snd_timer media snd soundcore i915 btusb btrtl btbcm btintel bluetooth
> iwlwifi dell_laptop dell_wmi dell_smbios mei_me drbg ansi_cprng mei
> ecdh_generic wmi_bmof dcdbas cfg80211 drm_kms_helper sparse_keymap
> dell_wmi_descriptor
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.700822]=A0 intel_cstate drm
> intel_uncore intel_rapl_perf dell_smm_hwmon evdev iTCO_wdt
> iTCO_vendor_support joydev rfkill video serio_raw i2c_algo_bit pcspkr sg
> pcc_cpufreq wmi dell_smo8800 button battery ac parport_pc ppdev lp
> parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
> crc32c_generic fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod
> cdrom sd_mod ums_realtek uas usb_storage crct10dif_pclmul crc32_pclmul
> crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci
> aes_x86_64 ehci_pci crypto_simd libata xhci_hcd ehci_hcd cryptd
> glue_helper psmouse scsi_mod i2c_i801 r8169 lpc_ich mii usbcore
> usb_common thermal
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.700925] CPU: 0 PID: 1024 Comm:
> Xorg Tainted: G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 O=A0=A0=A0=A0=A0 4.18.0-2-a=
md64 #1 Debian 4.18.10-2
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.700927] Hardware name: Dell
> Inc.=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dell System Vostro 3750/0VP036, BIOS A14 =
09/26/2012
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.700955] RIP:
> 0010:drm_gem_object_put+0x34/0x40 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.700957] Code: 53 48 8b 47 08 48=
 8b
> 40 68 48 a9 f8 ff ff ff 74 19 48 89 fb e8 7d c3 02 de 84 c0 75 02 5b c3
> 48 89 df 5b e9 ee fc ff ff f3 c3 <0f> 0b eb e3 0f 1f 84 00 00 00 00 00
> 66 66 66 66 90 48 8b 42 08 48
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701035] RSP: 0018:ffffac86826bb=
d00
> EFLAGS: 00010246
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701039] RAX: 0000000000000000 R=
BX:
> ffff95fc65313800 RCX: 0000000000000000
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701042] RDX: ffffffffffffffff R=
SI:
> ffff95fc662b0610 RDI: ffff95fc65313800
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701045] RBP: ffff95fc31f1a020 R=
08:
> ffff95fc662b0610 R09: ffff95fc662b06c0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701047] R10: 0000000000100000 R=
11:
> 0000000000000040 R12: 0000000000000000
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701050] R13: ffffac86826bbdc8 R=
14:
> ffffac86826bbdc0 R15: 00000000000000b3
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701054] FS:=A0
> 00007f78c0ceba80(0000) GS:ffff95fc7e400000(0000) knlGS:0000000000000000
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701057] CS:=A0 0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701060] CR2: 00007f78abdfac94 C=
R3:
> 00000004287fe002 CR4: 00000000000606f0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701063] Call Trace:
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701080]=A0 udl_gem_mmap+0x58/0x=
b0 [udl]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701112]=A0 ?
> drm_mode_create_dumb_ioctl+0x90/0x90 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701138]=A0
> drm_ioctl_kernel+0xa1/0xf0 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701164]=A0 drm_ioctl+0x2eb/0x39=
0 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701193]=A0 ?
> drm_mode_create_dumb_ioctl+0x90/0x90 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701203]=A0 ? datagram_poll+0x28=
/0xf0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701209]=A0 ? sock_poll+0x7b/0xb0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701216]=A0 ?
> ep_item_poll.isra.13+0x3f/0xb0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701221]=A0 ? sock_poll+0x7b/0xb0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701230]=A0 do_vfs_ioctl+0xa4/0x=
640
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701237]=A0 ?
> __x64_sys_epoll_ctl+0xf2/0x590
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701243]=A0 ksys_ioctl+0x70/0x80
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701250]=A0 __x64_sys_ioctl+0x16=
/0x20
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701257]=A0 do_syscall_64+0x55/0=
x110
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701265]=A0
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701271] RIP: 0033:0x7f78c1c09067
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701272] Code: b3 66 90 48 8b 05=
 21
> 7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00
> 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d
> f1 7d 0c 00 f7 d8 64 89 01 48
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701349] RSP: 002b:00007ffc9ddc4=
ef8
> EFLAGS: 00003246 ORIG_RAX: 0000000000000010
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701354] RAX: ffffffffffffffda R=
BX:
> 0000000000000000 RCX: 00007f78c1c09067
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701356] RDX: 00007ffc9ddc4f30 R=
SI:
> 00000000c01064b3 RDI: 0000000000000037
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701359] RBP: 00007ffc9ddc4f30 R=
08:
> 0000000000000000 R09: 000055bbb6541fe0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701361] R10: 00007ffc9ddc4edc R=
11:
> 0000000000003246 R12: 00000000c01064b3
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701364] R13: 0000000000000037 R=
14:
> 000055bbb6580d90 R15: 0000000000000001
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.701369] ---[ end trace
> 6b30e2bd6c85b37b ]---
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703507] WARNING: CPU: 0 PID: 10=
24
> at /build/linux-iActNR/linux-4.18.10/drivers/gpu/drm/drm_gem.c:893
> drm_gem_object_put+0x34/0x40 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703509] Modules linked in: udl
> rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave
> bnep bbswitch(O) nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4
> nf_defrag_ipv4 nft_counter xt_owner xt_state xt_conntrack nf_conntrack
> libcrc32c nft_compat nf_tables nfnetlink binfmt_misc intel_rapl
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> uvcvideo arc4 iwldvm videobuf2_vmalloc mac80211 videobuf2_memops
> videobuf2_v4l2 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel
> videobuf2_common snd_hda_codec videodev snd_hda_core snd_hwdep snd_pcm
> snd_timer media snd soundcore i915 btusb btrtl btbcm btintel bluetooth
> iwlwifi dell_laptop dell_wmi dell_smbios mei_me drbg ansi_cprng mei
> ecdh_generic wmi_bmof dcdbas cfg80211 drm_kms_helper sparse_keymap
> dell_wmi_descriptor
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703595]=A0 intel_cstate drm
> intel_uncore intel_rapl_perf dell_smm_hwmon evdev iTCO_wdt
> iTCO_vendor_support joydev rfkill video serio_raw i2c_algo_bit pcspkr sg
> pcc_cpufreq wmi dell_smo8800 button battery ac parport_pc ppdev lp
> parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
> crc32c_generic fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod
> cdrom sd_mod ums_realtek uas usb_storage crct10dif_pclmul crc32_pclmul
> crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci
> aes_x86_64 ehci_pci crypto_simd libata xhci_hcd ehci_hcd cryptd
> glue_helper psmouse scsi_mod i2c_i801 r8169 lpc_ich mii usbcore
> usb_common thermal
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703696] CPU: 0 PID: 1024 Comm:
> Xorg Tainted: G=A0=A0=A0=A0=A0=A0=A0 W=A0 O=A0=A0=A0=A0=A0 4.18.0-2-amd64=
 #1 Debian 4.18.10-2
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703698] Hardware name: Dell
> Inc.=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dell System Vostro 3750/0VP036, BIOS A14 =
09/26/2012
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703723] RIP:
> 0010:drm_gem_object_put+0x34/0x40 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703724] Code: 53 48 8b 47 08 48=
 8b
> 40 68 48 a9 f8 ff ff ff 74 19 48 89 fb e8 7d c3 02 de 84 c0 75 02 5b c3
> 48 89 df 5b e9 ee fc ff ff f3 c3 <0f> 0b eb e3 0f 1f 84 00 00 00 00 00
> 66 66 66 66 90 48 8b 42 08 48
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703801] RSP: 0018:ffffac86826bb=
d00
> EFLAGS: 00010246
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703805] RAX: 0000000000000000 R=
BX:
> ffff95fc65313e00 RCX: 0000000000000000
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703807] RDX: ffffffffffffffff R=
SI:
> ffff95fc662b0610 RDI: ffff95fc65313e00
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703810] RBP: ffff95fc31f1a020 R=
08:
> ffff95fc662b0610 R09: ffff95fc65313868
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703812] R10: 0000000000100004 R=
11:
> 0000000000000040 R12: 0000000000000000
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703815] R13: ffffac86826bbdc8 R=
14:
> ffffac86826bbdc0 R15: 00000000000000b3
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703819] FS:=A0
> 00007f78c0ceba80(0000) GS:ffff95fc7e400000(0000) knlGS:0000000000000000
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703822] CS:=A0 0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703825] CR2: 00007f78abdfac94 C=
R3:
> 00000004287fe002 CR4: 00000000000606f0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703827] Call Trace:
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703837]=A0 udl_gem_mmap+0x58/0x=
b0 [udl]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703867]=A0 ?
> drm_mode_create_dumb_ioctl+0x90/0x90 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703902]=A0
> drm_ioctl_kernel+0xa1/0xf0 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703928]=A0 drm_ioctl+0x2eb/0x39=
0 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703956]=A0 ?
> drm_mode_create_dumb_ioctl+0x90/0x90 [drm]
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703963]=A0 ? do_mmap+0x3f9/0x5c0
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703971]=A0 do_vfs_ioctl+0xa4/0x=
640
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703978]=A0 ksys_ioctl+0x70/0x80
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703985]=A0 __x64_sys_ioctl+0x16=
/0x20
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703991]=A0 do_syscall_64+0x55/0=
x110
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.703998]=A0
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704002] RIP: 0033:0x7f78c1c09067
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704003] Code: b3 66 90 48 8b 05=
 21
> 7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00
> 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d
> f1 7d 0c 00 f7 d8 64 89 01 48
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704080] RSP: 002b:00007ffc9ddc4=
ef8
> EFLAGS: 00003246 ORIG_RAX: 0000000000000010
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704084] RAX: ffffffffffffffda R=
BX:
> 0000000000000000 RCX: 00007f78c1c09067
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704087] RDX: 00007ffc9ddc4f30 R=
SI:
> 00000000c01064b3 RDI: 0000000000000037
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704089] RBP: 00007ffc9ddc4f30 R=
08:
> 0000000000000037 R09: 0000000100000000
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704092] R10: 0000000000000001 R=
11:
> 0000000000003246 R12: 00000000c01064b3
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704094] R13: 0000000000000037 R=
14:
> 000055bbb6580d90 R15: 0000000000000001
> Nov=A0 7 20:47:37 wzdell kernel: [=A0 212.704099] ---[ end trace
> 6b30e2bd6c85b37c ]---
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv7KyoACgkQMOfwapXb+vIiVQCgtaSRzzaY9Xa5FFJbNtkoTkJE
zpMAoLDZrNkgaRTSXXcLyFfGYt4+JiLm
=UvoZ
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
