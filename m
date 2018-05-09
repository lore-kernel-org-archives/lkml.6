Date: Wed, 9 May 2018 11:35:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.40
Message-ID: <20180509093505.GA26017@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.40 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                      |    2=20
 drivers/acpi/button.c                                         |   24=20
 drivers/crypto/talitos.c                                      |   41=20
 drivers/gpu/drm/bridge/dumb-vga-dac.c                         |    4=20
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                           |    1=20
 drivers/infiniband/core/ucma.c                                |    2=20
 drivers/infiniband/hw/cxgb4/cq.c                              |   11=20
 drivers/infiniband/hw/cxgb4/device.c                          |    9=20
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h                        |    6=20
 drivers/infiniband/hw/cxgb4/qp.c                              |    4=20
 drivers/infiniband/hw/cxgb4/resource.c                        |   26=20
 drivers/infiniband/hw/hfi1/driver.c                           |   19=20
 drivers/infiniband/hw/hfi1/hfi.h                              |    8=20
 drivers/infiniband/hw/hfi1/init.c                             |    2=20
 drivers/infiniband/hw/hfi1/pcie.c                             |    3=20
 drivers/infiniband/hw/hfi1/ruc.c                              |   50 -
 drivers/infiniband/hw/hfi1/ud.c                               |    4=20
 drivers/infiniband/hw/mlx5/mr.c                               |   32=20
 drivers/infiniband/hw/mlx5/qp.c                               |   22=20
 drivers/infiniband/ulp/ipoib/ipoib_cm.c                       |    3=20
 drivers/input/input-leds.c                                    |    8=20
 drivers/input/touchscreen/atmel_mxt_ts.c                      |    9=20
 drivers/irqchip/qcom-irq-combiner.c                           |    4=20
 drivers/net/geneve.c                                          |   14=20
 drivers/net/usb/qmi_wwan.c                                    |    1=20
 drivers/net/vxlan.c                                           |    6=20
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c |   15=20
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h |    1=20
 drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c      |    6=20
 drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.h      |    1=20
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c           |   11=20
 drivers/net/wireless/realtek/rtlwifi/wifi.h                   |    6=20
 drivers/platform/x86/asus-wireless.c                          |    4=20
 drivers/target/target_core_iblock.c                           |    8=20
 drivers/usb/core/config.c                                     |    4=20
 drivers/usb/dwc3/gadget.c                                     |    2=20
 drivers/usb/musb/musb_gadget.c                                |    3=20
 drivers/usb/musb/musb_host.c                                  |    4=20
 drivers/usb/serial/option.c                                   |  448 +++--=
-----
 drivers/usb/serial/visor.c                                    |   69 -
 fs/xfs/xfs_file.c                                             |   14=20
 include/net/dst.h                                             |    8=20
 kernel/trace/trace_uprobe.c                                   |   24=20
 kernel/tracepoint.c                                           |    4=20
 lib/errseq.c                                                  |   25=20
 mm/percpu.c                                                   |    1=20
 net/ipv4/ip_tunnel.c                                          |    3=20
 net/ipv4/ip_vti.c                                             |    2=20
 net/ipv6/ip6_tunnel.c                                         |    5=20
 net/ipv6/ip6_vti.c                                            |    2=20
 net/ipv6/sit.c                                                |    4=20
 sound/core/pcm_compat.c                                       |    2=20
 sound/core/seq/seq_virmidi.c                                  |    4=20
 sound/drivers/aloop.c                                         |   29=20
 sound/firewire/amdtp-stream.c                                 |    5=20
 sound/pci/hda/patch_realtek.c                                 |    2=20
 tools/testing/selftests/firmware/fw_filesystem.sh             |    6=20
 57 files changed, 546 insertions(+), 491 deletions(-)

Agustin Vega-Frias (1):
      irqchip/qcom: Fix check for spurious interrupts

Alan Stern (1):
      USB: Accept bulk endpoints with 1024-byte maxpacket

Ard Biesheuvel (1):
      ACPI / button: make module loadable when booted in non-ACPI mode

Ben Hutchings (1):
      test_firmware: fix setting old custom fw path back on exit, second try

Bharat Potnuri (1):
      iw_cxgb4: Atomically flush per QP HW CQEs

Bin Liu (2):
      usb: musb: host: fix potential NULL pointer dereference
      usb: musb: trace: fix NULL pointer dereference in musb_g_tx()

Bryant G Ly (1):
      scsi: target: Fix fortify_panic kernel exception

Danit Goldberg (1):
      IB/mlx5: Use unlimited rate when static rate is not supported

Darrick J. Wong (1):
      xfs: prevent creating negative-sized file via INSERT_RANGE

Dmitry Torokhov (1):
      Input: leds - fix out of bound access

Greg Kroah-Hartman (2):
      USB: serial: visor: handle potential invalid device configuration
      Linux 4.14.40

Johan Hovold (1):
      USB: serial: option: reimplement interface masking

Jo=C3=A3o Paulo Rechi Vita (1):
      platform/x86: asus-wireless: Fix NULL pointer dereference

Kristian Evensen (1):
      USB: serial: option: Add support for Quectel EP06

LEROY Christophe (1):
      crypto: talitos - fix IPsec cipher in length

Leon Romanovsky (2):
      RDMA/mlx5: Fix multiple NULL-ptr deref errors in rereg_mr flow
      RDMA/mlx5: Protect from shift operand overflow

Mathieu Desnoyers (1):
      tracepoint: Do not warn on ENOMEM

Matthew Wilcox (1):
      errseq: Always report a writeback error once

Mayank Rana (1):
      usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue

Mike Marciniszyn (2):
      IB/hfi1: Fix handling of FECN marked multicast packet
      IB/hfi1: Fix loss of BECN with AHG

Nicolas Dichtel (1):
      net: don't call update_pmtu unconditionally

Ping-Ke Shih (2):
      rtlwifi: btcoex: Add power_on_setting routine
      rtlwifi: cleanup 8723be ant_sel definition

Raju Rangoju (1):
      RDMA/cxgb4: release hw resources on device removal

Robert Rosengren (1):
      ALSA: aloop: Mark paused device as inactive

Roland Dreier (1):
      RDMA/ucma: Allow resolving address w/o specifying source address

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (2):
      NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
      USB: serial: option: adding support for ublox R410M

Sean Paul (1):
      drm/bridge: vga-dac: Fix edid memory leak

Sebastian Sanchez (1):
      IB/hfi1: Fix NULL pointer dereference when invalid num_vls is used

Song Liu (1):
      tracing: Fix bad use of igrab in trace_uprobe.c

Takashi Iwai (4):
      ALSA: hda - Fix incorrect usage of IS_REACHABLE()
      ALSA: pcm: Check PCM state at xfern compat ioctl
      ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
      ALSA: aloop: Add missing cable lock to ctl API callbacks

Takashi Sakamoto (1):
      ALSA: dice: fix kernel NULL pointer dereference due to invalid calcul=
ation for array index

Tejun Heo (1):
      percpu: include linux/sched.h for cond_resched()

Thomas Hellstrom (1):
      drm/vmwgfx: Fix a buffer object leak

Vittorio Gambaletta (VittGam) (1):
      Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromeb=
ook Pro

Xin Long (1):
      geneve: update skb dst pmtu on tx path


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrywMgACgkQONu9yGCS
aT4UZg//dN7e0WOhRlUgFpsbDYuv2b5uqiPT626JyCKOWQ4QV1nQBp+Y5ZvF1ZiL
qp7fBfRp8erxfbQM3tQr9z/6sGe/mitINrILv508oYMJi08VtthcqkyqhnAbJwSQ
IRKaWCYTMeVk5i02mHtw4/+nkdQqBFofWBYspoD1Cr9+Hq7ap38sQSoZUF01p8wA
eoCnUB+MRKuUWNODkN8+eeENcL2Xl9l9gI0RXamkYYexdXdM+sjvmS5TEBV2PsLM
+inPks3faCKz5iGnOApaGjqOl+HzU85VKqCfsYg/Zg4DZY6yQtHVFRiBwFPiErFX
+onAawwDrVrBBwIq8fjgLuP4gem2i3CgKPZMiSNz46HYKrEnOP2An7B3/SExpwNK
9rA3myv9fFqP0L0yQOlGwDEYPGuUUTIKmJTmCouwPq8lZU0/a8RxKhYtwC2+L5Zx
VPImpT0oIfECnS1Xf9+XJCG9aw3TTyPk8mmr8vEZFv5b47YMj7pAE36njHQLGQSL
n5zPkgDUPow+rEvUtxpoRkPnTsEKTUvDo5Fl0zXUFiJzUn0csjtFObG3e/zgHBlt
bfWAyFL4XWdb5xaOqP0eCfFo54eeTNh5M4Dd9RmfAZU477lT66B2W1t+05IGXqHL
qr+kj7skX7XCwDZo03Zd0k7z9RB87YZb4UkoHtBhH/MBOBPtJj8=
=fr35
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
