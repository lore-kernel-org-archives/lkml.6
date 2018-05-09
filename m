Date: Wed, 9 May 2018 11:34:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.99
Message-ID: <20180509093418.GA25914@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.99 kernel.

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

 Documentation/virtual/kvm/api.txt                 |    9=20
 Documentation/virtual/kvm/arm/psci.txt            |   30 +
 Makefile                                          |    2=20
 arch/arm/include/asm/kvm_host.h                   |    3=20
 arch/arm/include/uapi/asm/kvm.h                   |    6=20
 arch/arm/kvm/guest.c                              |   13=20
 arch/arm/kvm/psci.c                               |   60 ++
 arch/arm64/include/asm/kvm_host.h                 |    3=20
 arch/arm64/include/uapi/asm/kvm.h                 |    6=20
 arch/arm64/kvm/guest.c                            |   14=20
 arch/s390/include/asm/facility.h                  |    2=20
 drivers/crypto/talitos.c                          |   41 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c             |    4=20
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |    1=20
 drivers/infiniband/core/ucma.c                    |    2=20
 drivers/infiniband/hw/cxgb4/device.c              |    9=20
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h            |    4=20
 drivers/infiniband/hw/cxgb4/resource.c            |   26 +
 drivers/infiniband/hw/hfi1/init.c                 |    2=20
 drivers/infiniband/hw/hfi1/pcie.c                 |    3=20
 drivers/infiniband/hw/mlx5/qp.c                   |   22 -
 drivers/input/input-leds.c                        |    8=20
 drivers/input/touchscreen/atmel_mxt_ts.c          |    9=20
 drivers/net/usb/qmi_wwan.c                        |    1=20
 drivers/platform/x86/asus-wireless.c              |    4=20
 drivers/tty/serial/imx.c                          |   14=20
 drivers/usb/core/config.c                         |    4=20
 drivers/usb/musb/musb_gadget.c                    |    3=20
 drivers/usb/musb/musb_host.c                      |    4=20
 drivers/usb/serial/option.c                       |  448 +++++++----------=
-----
 drivers/usb/serial/visor.c                        |   69 +--
 fs/xfs/xfs_file.c                                 |   14=20
 include/kvm/arm_psci.h                            |   16=20
 kernel/bpf/arraymap.c                             |    2=20
 kernel/bpf/hashtab.c                              |    9=20
 kernel/bpf/syscall.c                              |   20=20
 kernel/events/core.c                              |    2=20
 kernel/tracepoint.c                               |    4=20
 mm/percpu.c                                       |    1=20
 sound/core/pcm_compat.c                           |    2=20
 sound/core/seq/seq_virmidi.c                      |    4=20
 sound/drivers/aloop.c                             |   29 +
 tools/testing/selftests/firmware/fw_filesystem.sh |    6=20
 43 files changed, 529 insertions(+), 406 deletions(-)

Alan Stern (1):
      USB: Accept bulk endpoints with 1024-byte maxpacket

Ben Hutchings (1):
      test_firmware: fix setting old custom fw path back on exit, second try

Bin Liu (2):
      usb: musb: host: fix potential NULL pointer dereference
      usb: musb: trace: fix NULL pointer dereference in musb_g_tx()

Danit Goldberg (1):
      IB/mlx5: Use unlimited rate when static rate is not supported

Darrick J. Wong (1):
      xfs: prevent creating negative-sized file via INSERT_RANGE

Dmitry Torokhov (1):
      Input: leds - fix out of bound access

Greg Kroah-Hartman (2):
      USB: serial: visor: handle potential invalid device configuration
      Linux 4.9.99

Heiko Carstens (1):
      s390/facilites: use stfle_fac_list array size for MAX_FACILITY_BIT

Johan Hovold (1):
      USB: serial: option: reimplement interface masking

Jo=C3=A3o Paulo Rechi Vita (1):
      platform/x86: asus-wireless: Fix NULL pointer dereference

Kristian Evensen (1):
      USB: serial: option: Add support for Quectel EP06

LEROY Christophe (1):
      crypto: talitos - fix IPsec cipher in length

Leon Romanovsky (1):
      RDMA/mlx5: Protect from shift operand overflow

Marc Zyngier (1):
      arm/arm64: KVM: Add PSCI version selection API

Mathieu Desnoyers (1):
      tracepoint: Do not warn on ENOMEM

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

Takashi Iwai (3):
      ALSA: pcm: Check PCM state at xfern compat ioctl
      ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
      ALSA: aloop: Add missing cable lock to ctl API callbacks

Tan Xiaojun (1):
      perf/core: Fix the perf_cpu_time_max_percent check

Tejun Heo (1):
      percpu: include linux/sched.h for cond_resched()

Teng Qin (1):
      bpf: map_get_next_key to return first key on NULL

Thomas Hellstrom (1):
      drm/vmwgfx: Fix a buffer object leak

Uwe Kleine-K=C3=B6nig (1):
      serial: imx: ensure UCR3 and UFCR are setup correctly

Vittorio Gambaletta (VittGam) (1):
      Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromeb=
ook Pro


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrywJcACgkQONu9yGCS
aT6xtxAA02a1s9vDIxEvZIC++fft4J0XY0iC19Mslb09kEjOoLQP6kkAj+am4/fC
PT8jWafhwljokzzUwH73ORRMdTrCAnKhMS3VEqMh+HLd5zvNZSukW27VZgi9Zobl
oAGPp64v1fGb3+d6+5haPOQ+YeAVLZL21YPRWUl0aoqQfO1wnujSH72UvV3rcwGa
fXNF/hbbXSn6yaU3TSp3eCxhe7ZvttLSO45//xOZJloTBkABUoN1KOb3/yhs6jbc
if6QNAd0AmwqBKVieCENag5ZbP/lAy8eejpkwoPdo+ENWjbki91IGhHl7U0y/zOm
p2y/b7clSGlDvmcv9xsy0hKhnLmzRpZe8arW/g0b49e2X2ajkIRZ9SJowDLbkzRA
TFyvnd+oyrQTofX9aEtWst2twzWtW0EtRY7i/JjZ8zwo26p/v65X7sNAY1fCAV32
ABKbH7GufyKeqb/WRd4BgsB1/aql6wkl2/Mhmr6ybB8Au0FG0e4NdHLlknf/QMhG
QbsWtv1DPdeVeWB1bh4oWulUG4RYEn5sg0u63qjDE6d6r8GFEUS/9QgKK3Bm2YLu
/xDW8bbDOroW8mCoURhaBdaovFG9BguHFDC7c0yQAm8w9aH3ltcUO11okt/QLfEa
CDfmWUxsAnmsc3NnNcgruU5/bX1+yEEDFe4YB9PNrOR+SfvaYkE=
=SuX+
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
