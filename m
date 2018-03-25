Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825519-1521968571-2-6734094695939904050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521968570; b=qBy6spDRkOeHEqPA/g6mij1RK3CNT140o22KtdVDrh3trII
    4M4njTYUGhiTSn8sHsKbSrMTpYpbkQly3oEx434kCMiQvtdBPzgUlQWPiUghTX7T
    MzkgAnVIGWNUiJMiX1ibBcJ2/BdnyAEYFzICAK/8g5MEHIYOf7gQ/uAb5rHC1GN4
    /BQTrsGY69oiVlaka2ThurFHlX/mmO3OA68YVdfmwgP3CjOqBkBVQe8eK29KRls6
    JS01V2bCA/+tUww2w6ce6rQZA+TD8r79PoNFt0Ftw6AadHVswQzVAX9RrBMAVPMs
    SAZHb7PE+8aBRULyyZ7UWWrl2YPaLPZjsJHf2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521968570; bh=ZJw/jdPaeUWJv0jq58gSdmrLfWF2pWHYqQ2l/GeJp2A=; b=e
    VQbZH3UT93JHHXd2AsmPQWmKYii3HsViREGzgzmRrdu82DojzbPih1InZnDNrtrz
    0eSW/Wi0jniyJGDkQU3HD5s+Ye7KC2GEzqgA6MxvrqouBxy9U0UGxl5waEgSVY9z
    ptLy/VGJq2RATgtuolDvqtcecRWHVLTpMBH0J8S73dEGmn9B4e6tlFe5P+nmsq3x
    N/KdT0AlXgEngwYebzpOW3q5LGzO0GKvagadzZTG2/wpLkw5wM6jFF1UggtUNheW
    aqowoP6uwzLTSekz4GrCzreC13/jYokIH/2ooA7IfIfI3x3tNnEHXonFamG2GIZr
    H2RjiO9JT9sEAtpqy2/Sw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeCYI76 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 04:59:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbeCYI7z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Mar 2018 04:59:55 -0400
Date: Sun, 25 Mar 2018 10:59:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.102
Message-ID: <20180325085952.GA31575@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.102 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                 |    2=20
 arch/alpha/kernel/console.c                              |    1=20
 arch/arm/mach-omap2/clockdomains7xx_data.c               |    2=20
 arch/ia64/kernel/module.c                                |    4=20
 arch/powerpc/kvm/book3s_64_mmu_host.c                    |    5 -
 arch/powerpc/kvm/book3s_pr.c                             |    6 +
 arch/x86/kernel/i8259.c                                  |    1=20
 drivers/acpi/processor_driver.c                          |    7 +
 drivers/acpi/processor_throttling.c                      |   62 ++++++++--=
-----
 drivers/char/ipmi/ipmi_watchdog.c                        |    8 -
 drivers/clk/clk-si5351.c                                 |    2=20
 drivers/cpufreq/sh-cpufreq.c                             |   45 ++++++----
 drivers/gpu/drm/msm/msm_gem.c                            |   14 ++-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                 |    5 +
 drivers/hsi/clients/ssi_protocol.c                       |    5 -
 drivers/i2c/busses/i2c-scmi.c                            |    4=20
 drivers/infiniband/core/cma.c                            |    5 -
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                  |   13 +++
 drivers/infiniband/ulp/ipoib/ipoib_main.c                |   16 +++
 drivers/input/touchscreen/ar1021_i2c.c                   |    2=20
 drivers/md/raid10.c                                      |    1=20
 drivers/media/dvb-core/dvb_ca_en50221.c                  |   23 +++++
 drivers/media/dvb-frontends/si2168.c                     |    3=20
 drivers/media/pci/bt8xx/bt878.c                          |    3=20
 drivers/mfd/palmas.c                                     |   14 +++
 drivers/mmc/core/core.c                                  |    8 +
 drivers/mmc/host/omap_hsmmc.c                            |    4=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c          |    1=20
 drivers/net/ethernet/intel/e1000e/netdev.c               |    6 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c |    2=20
 drivers/net/wan/pc300too.c                               |    1=20
 drivers/net/wireless/ath/regd.c                          |   19 ++--
 drivers/net/wireless/rndis_wlan.c                        |    4=20
 drivers/pinctrl/core.c                                   |   24 ++++-
 drivers/platform/x86/asus-nb-wmi.c                       |    9 ++
 drivers/power/pda_power.c                                |   49 ++++++-----
 drivers/scsi/lpfc/lpfc_sli.c                             |    3=20
 drivers/scsi/mac_esp.c                                   |   33 +++++--
 drivers/scsi/virtio_scsi.c                               |   24 +++++
 drivers/spi/spi-dw-mmio.c                                |    2=20
 drivers/video/console/vgacon.c                           |   34 ++++++--
 drivers/video/fbdev/sm501fb.c                            |    1=20
 drivers/video/fbdev/udlfb.c                              |   14 ++-
 fs/btrfs/send.c                                          |   23 +++++
 fs/cifs/netmisc.c                                        |    6 -
 kernel/irq/manage.c                                      |    4=20
 net/ipv4/tcp_input.c                                     |   16 ++-
 net/ipv6/ndisc.c                                         |    2=20
 net/mac80211/status.c                                    |    1=20
 sound/pci/hda/patch_realtek.c                            |   12 ++
 50 files changed, 415 insertions(+), 140 deletions(-)

Alexey Kardashevskiy (1):
      KVM: PPC: Book3S PR: Exit KVM on failed mapping

Alexey Khoroshilov (1):
      sm501fb: don't return zero on failure path in sm501fb_start()

Bernd Faust (1):
      e1000e: fix timing for 82579 Gigabit Ethernet controller

Bjorn Helgaas (1):
      vgacon: Set VGA struct resource types

Christophe JAILLET (1):
      media: bt8xx: Fix err 'bt878_probe()'

Dan Carpenter (3):
      HSI: ssi_protocol: double free in ssip_pn_xmit()
      mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()
      cifs: small underflow in cnvrtDosUnixTm()

Daniel Drake (1):
      mmc: avoid removing non-removable hosts during suspend

David Ahern (1):
      net: ipv6: send unsolicited NA on admin up

David Gibson (1):
      scsi: virtio_scsi: Always try to read VPD pages

Dmitry Torokhov (1):
      Input: ar1021_i2c - fix too long name in driver's device table

Edgar Cherkasov (1):
      i2c: i2c-scmi: add a MS HID

Emmanuel Grumbach (1):
      mac80211: don't parse encrypted management frames in ieee80211_frame_=
acked

Erez Shitrit (1):
      IB/ipoib: Avoid memory leak if the SA returns a different DGID

Eric Dumazet (1):
      tcp: remove poll() flakes with FastOpen

Feras Daoud (1):
      IB/ipoib: Update broadcast object if PKey value was changed in index 0

Filipe Manana (1):
      Btrfs: send, fix file hole not being preserved due to inline extent

Finn Thain (1):
      scsi: mac_esp: Replace bogus memory barrier with spinlock

Florian Fainelli (1):
      pinctrl: Really force states during suspend/resume

Greg Kroah-Hartman (1):
      Linux 3.18.102

Hans de Goede (2):
      x86: i8259: export legacy_pic symbol
      genirq: Use irqd_get_trigger_type to compare the trigger type for sha=
red IRQs

James Smart (1):
      Fix driver usage of 128B WQEs when WQ_CREATE is V1.

Jasmin J (1):
      media/dvb-core: Race condition when writing to CAM

Keerthy (1):
      mfd: palmas: Reset the POWERHOLD mux during power off

Kishon Vijay Abraham I (1):
      ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to =
SW_WKUP

Leon Romanovsky (1):
      RDMA/ucma: Fix access to non-initialized CM_ID object

Maksim Salau (1):
      video: fbdev: udlfb: Fix buffer on stack

Marek Vasut (1):
      spi: dw: Disable clock after unregistering the host

Michael Trimarchi (1):
      power: supply: pda_power: move from timer to delayed_work

Mikhail Paulyshka (1):
      ALSA: hda - Fix headset microphone detection for ASUS N551 and N751

Mohammed Shafi Shajakhan (1):
      ath: Fix updating radar flags for coutry code India

Pan Bian (3):
      wan: pc300too: abort path on failure
      qlcnic: fix unchecked return value
      rndis_wlan: add return value validation

Parav Pandit (1):
      RDMA/cma: Use correct size when writing netlink stats

Peter Ujfalusi (1):
      drm/omap: DMM: Check for DMM readiness after successful transaction c=
ommit

Prakash Kamliya (1):
      drm/msm: fix leak in failed get_pages

Robert Lippert (1):
      ipmi/watchdog: fix wdog hang on panic waiting for ipmi response

Ron Economos (1):
      media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart

Santeri Toivonen (1):
      platform/x86: asus-nb-wmi: Add wapf4 quirk for the X302UA

Scott Wood (1):
      bnx2x: Align RX buffers

Sergei Trofimovich (1):
      ia64: fix module loading for gcc-5.4

Sergej Sawazki (1):
      clk: si5351: Rename internal plls to avoid name collisions

Shaohua Li (1):
      md/raid10: skip spare disk as 'first' disk

Thomas Gleixner (2):
      ACPI/processor: Replace racy task affinity logic
      cpufreq/sh: Replace racy task affinity logic


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq3ZQUACgkQONu9yGCS
aT6U6BAAvS77+Oa27s2B6Dr3dh9Zhc7wnU0zBb8/a+CYK+ChzTLtuDtyjW8cZmPq
SWimAhYZjBW+WF9/nW3v5WKWHEOrtAAkVzC7jlrEX+hjLhwmh99Lw6wkG5SY0R2M
QLb9Zh83ND4Y1H5o+CnKuoTXjBCQimQmBnIafK/UGi/NMjauQ19zOXnKpz5tLgC/
NZrWeo+83wKTksZqeLs02TrwYopaNUlGwsybwN2k1snXOT3PV3NTEttYcG7gZmeU
warZrbhIhRxs0jdoBF52SJCQZ3hTT92sAzRYoO291PAIb+PnlXqwg556RhQYhK+T
NZIDuk2E0/dnBlfwKPlh/g/cIVn1O/tSH7Z2Svuvbsgzz0zOdLG2oUZbiVPGnDpd
jC2RwegqXeEzSK2BLUVM0GplNvENVF9fX+4O42wwYCZ1KH0d/5LxWUDE/JXCJnDK
rLRpxUI64giGwEI3PbTn51iGcfbwfWgCnqMHkzQibO/vN5gIX4N+tfpiJ1N5UfTd
mB7KuVmp+ZtJyi3HexilAOBoYKL4Zp85M2+9QMngKQdZZXNV6v4vPy496b+XGv0T
55RWFsFAmZcTIDv/oKz44/E6+CRsKaPA2en7R443GE1Izvzu313N7RQ1bJJIDL9W
5wx30NpoK4tzSyJ8+NjcYvEM2OKnHpHn/NWP/tpGCFrAHVybMMs=
=3cBL
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
