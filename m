Date: Fri, 13 Apr 2018 22:24:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.105
Message-ID: <20180413202459.GA23097@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.105 kernel.

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

 Makefile                                             |    2=20
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi             |    1=20
 arch/arm/include/asm/xen/events.h                    |    2=20
 arch/arm/mach-davinci/devices-da8xx.c                |   10 +
 arch/arm64/include/asm/futex.h                       |    8 -
 arch/mips/include/asm/kprobes.h                      |    3=20
 arch/mips/mm/pgtable-32.c                            |    6 -
 arch/powerpc/kernel/time.c                           |   14 ++
 arch/powerpc/kvm/book3s_pr_papr.c                    |   34 +++++-
 arch/powerpc/platforms/cell/spufs/coredump.c         |    2=20
 arch/s390/kernel/vmlinux.lds.S                       |    8 +
 arch/sparc/kernel/ldc.c                              |    7 +
 arch/x86/kernel/tsc.c                                |    2=20
 arch/x86/kvm/svm.c                                   |   24 ++--
 arch/x86/kvm/vmx.c                                   |    7 -
 block/bio-integrity.c                                |    3=20
 block/partition-generic.c                            |    4=20
 crypto/async_tx/async_pq.c                           |    5=20
 drivers/acpi/acpica/evxfevnt.c                       |   18 +++
 drivers/acpi/acpica/psobject.c                       |   14 ++
 drivers/ata/libahci_platform.c                       |    5=20
 drivers/char/random.c                                |   10 +
 drivers/edac/mv64x60_edac.c                          |    2=20
 drivers/gpu/drm/omapdrm/omap_gem.c                   |    4=20
 drivers/iio/magnetometer/st_magn_spi.c               |    2=20
 drivers/infiniband/ulp/srpt/ib_srpt.c                |    6 -
 drivers/isdn/mISDN/stack.c                           |    2=20
 drivers/leds/leds-pca955x.c                          |    2=20
 drivers/md/bcache/alloc.c                            |   19 ++-
 drivers/md/bcache/super.c                            |    6 +
 drivers/media/i2c/cx25840/cx25840-core.c             |   36 ++++--
 drivers/media/rc/mceusb.c                            |    9 +
 drivers/net/bonding/bond_main.c                      |   84 ++++++++------=
--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c      |   19 ++-
 drivers/net/ethernet/brocade/bna/bfa_ioc.c           |    2=20
 drivers/net/ethernet/freescale/fsl_pq_mdio.c         |    9 +
 drivers/net/ethernet/ibm/emac/core.c                 |   26 ++++-
 drivers/net/ethernet/intel/e1000e/netdev.c           |   17 ++-
 drivers/net/ethernet/marvell/sky2.c                  |    2=20
 drivers/net/ethernet/mellanox/mlx4/mcg.c             |   15 ++
 drivers/net/ethernet/mellanox/mlx4/qp.c              |   13 ++
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c  |    2=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c       |    2=20
 drivers/net/ethernet/qlogic/qlge/qlge_dbg.c          |    4=20
 drivers/net/ethernet/qualcomm/qca_spi.c              |   10 +
 drivers/net/ethernet/realtek/r8169.c                 |    4=20
 drivers/net/ethernet/renesas/sh_eth.c                |    2=20
 drivers/net/ethernet/ti/cpsw.c                       |   16 +++
 drivers/net/hamradio/hdlcdrv.c                       |    2=20
 drivers/net/phy/phy.c                                |    6 +
 drivers/net/ppp/pptp.c                               |    1=20
 drivers/net/virtio_net.c                             |   16 ++-
 drivers/net/vmxnet3/vmxnet3_drv.c                    |    5=20
 drivers/net/vxlan.c                                  |    2=20
 drivers/net/wireless/ath/ath5k/debug.c               |    5=20
 drivers/net/wireless/ray_cs.c                        |    7 -
 drivers/net/wireless/ti/wl1251/main.c                |    3=20
 drivers/powercap/powercap_sys.c                      |    1=20
 drivers/rtc/interface.c                              |    9 +
 drivers/scsi/bnx2fc/bnx2fc.h                         |    1=20
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                    |   10 +
 drivers/scsi/libiscsi.c                              |   24 ++++
 drivers/scsi/libsas/sas_expander.c                   |    4=20
 drivers/staging/wlan-ng/prism2mgmt.c                 |    2=20
 drivers/tty/n_gsm.c                                  |   17 ++-
 drivers/tty/serial/sccnxp.c                          |   15 +-
 drivers/usb/chipidea/core.c                          |   29 ++++-
 drivers/usb/dwc3/dwc3-keystone.c                     |    4=20
 drivers/usb/host/xhci-plat.c                         |    1=20
 drivers/usb/storage/ene_ub6250.c                     |   11 +-
 drivers/vhost/vhost.c                                |    3=20
 drivers/video/fbdev/vfb.c                            |   17 +++
 fs/btrfs/extent_io.c                                 |    2=20
 fs/cifs/file.c                                       |    2=20
 fs/cifs/smb2pdu.c                                    |   14 +-
 fs/ext4/file.c                                       |    2=20
 fs/lockd/svc.c                                       |    6 -
 fs/nfs/nfs4proc.c                                    |    7 +
 fs/nfs/nfs4state.c                                   |   10 +
 fs/overlayfs/inode.c                                 |   12 ++
 include/linux/mlx4/qp.h                              |    1=20
 include/linux/skbuff.h                               |    8 -
 include/net/x25.h                                    |    4=20
 kernel/events/core.c                                 |   15 +-
 kernel/futex.c                                       |   98 ++++++++++++++=
+++--
 kernel/pid.c                                         |    4=20
 net/bluetooth/hci_core.c                             |   17 ++-
 net/ceph/osdmap.c                                    |    1=20
 net/core/dev.c                                       |    4=20
 net/core/neighbour.c                                 |   14 +-
 net/core/net_namespace.c                             |   19 +++
 net/core/skbuff.c                                    |   65 ++++++++----
 net/core/sysctl_net_core.c                           |    2=20
 net/ipv4/ah4.c                                       |    8 +
 net/ipv4/esp4.c                                      |   12 +-
 net/ipv4/ip_tunnel.c                                 |   11 +-
 net/ipv6/addrconf.c                                  |    5=20
 net/ipv6/ah6.c                                       |    8 +
 net/ipv6/esp6.c                                      |   12 +-
 net/ipv6/ip6_gre.c                                   |    8 -
 net/ipv6/ip6_output.c                                |   13 +-
 net/ipv6/ip6_tunnel.c                                |    7 -
 net/ipv6/ip6_vti.c                                   |    7 -
 net/ipv6/sit.c                                       |    8 -
 net/key/af_key.c                                     |    2=20
 net/l2tp/l2tp_netlink.c                              |    2=20
 net/llc/af_llc.c                                     |    3=20
 net/mac80211/mlme.c                                  |    4=20
 net/netfilter/nf_conntrack_netlink.c                 |    7 +
 net/netlink/af_netlink.c                             |    3=20
 net/rxrpc/rxkad.c                                    |   21 ++--
 net/sched/act_api.c                                  |    4=20
 net/sctp/ipv6.c                                      |    4=20
 net/sctp/socket.c                                    |   17 +--
 net/x25/af_x25.c                                     |   24 +++-
 net/x25/sysctl_net_x25.c                             |    5=20
 net/xfrm/xfrm_state.c                                |    2=20
 scripts/tags.sh                                      |    1=20
 tools/perf/builtin-trace.c                           |    4=20
 tools/perf/tests/code-reading.c                      |   20 +++
 tools/perf/util/unwind-libdw.c                       |    8 +
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c |    2=20
 122 files changed, 924 insertions(+), 314 deletions(-)

A Sun (1):
      mceusb: sporadic RX truncation corruption fix

Alan Stern (2):
      USB: ene_usb6250: fix first command execution
      USB: ene_usb6250: fix SCSI residue overwriting

Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()

Andrea della Porta (1):
      staging: wlan-ng: prism2mgmt.c: fixed a double endian conversion befo=
re calling hfa384x_drvr_setconfig16, also fixes relative sparse warning

Antony Antony (1):
      xfrm: fix state migration copy replay sequence numbers

Anup Patel (1):
      async_tx: Fix DMA_PREP_FENCE usage in do_async_gen_syndrome()

Arnd Bergmann (1):
      xen: avoid type warning in xchg_xen_ulong

Bart Van Assche (1):
      IB/srpt: Fix abort handling

Bob Moore (1):
      ACPICA: Disassembler: Abort on an invalid/unknown AML opcode

Chris Wilson (1):
      e1000e: Undo e1000e_pm_freeze if __e1000_shutdown fails

Christian Lamparter (1):
      net: emac: fix reset timeout with AR8035 phy

Christophe JAILLET (2):
      SMB2: Fix share type handling
      EDAC, mv64x60: Fix an error handling path

Colin Ian King (4):
      netxen_nic: set rcode to the return status from the call to netxen_is=
sue_cmd
      btrfs: fix incorrect error return ret being passed to mapping_set_err=
or
      ath5k: fix memory leak on buf on failed eeprom read
      wl1251: check return from call to wl1251_acx_arp_ip_filter

Craig Dillabaugh (1):
      net sched actions: fix dumping which requires several messages to use=
r space

Dan Carpenter (3):
      PowerCap: Fix an error code in powercap_register_zone()
      block: fix an error code in add_partition()
      libceph: NULL deref on crush_decode() error path

Dmitry Monakhov (1):
      bio-integrity: Do not allocate integrity context for bio w/o data

Eric Dumazet (10):
      net: fix possible out-of-bound read in skb_network_protocol()
      pptp: remove a buggy dst release in pptp_connect()
      sctp: do not leak kernel memory to user space
      sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6
      net: fool proof dev_valid_name()
      ip_tunnel: better validate user provided tunnel names
      ipv6: sit: better validate user provided tunnel names
      ip6_gre: better validate user provided tunnel names
      vti6: better validate user provided tunnel names
      ip6_tunnel: better validate user provided tunnel names

Eryu Guan (1):
      ext4: fix off-by-one on max nr_pages in ext4_find_unwritten_pgoff()

Fabio Estevam (1):
      ARM: dts: imx6qdl-wandboard: Fix audio channel swap

Firo Yang (1):
      hdlcdrv: Fix divide by zero in hdlcdrv_ioctl

Geert Uytterhoeven (1):
      sh_eth: Use platform device for printing before register_netdev()

Greg Hackmann (1):
      Revert "xhci: plat: Register shutdown for xhci_plat"

Greg Kroah-Hartman (1):
      Linux 3.18.105

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: adjust cpsw fifos depth for fullduplex flow =
control

Gustavo A. R. Silva (1):
      net: freescale: fix potential null pointer dereference

Hangbin Liu (1):
      l2tp: fix missing print session offset info

Heiko Carstens (1):
      s390: move _text symbol to address higher than zero

Heiner Kallweit (1):
      r8169: fix setting driver_data after register_netdev

Ihar Hrachyshka (1):
      neighbour: update neigh timestamps iff update is effective

Ivan Mikhaylov (1):
      powerpc/[booke|4xx]: Don't clobber TCR[WP] when setting TCR[DIE]

J. Bruce Fields (1):
      lockd: fix lockd shutdown race

Jacob Keller (1):
      e1000e: fix race condition around skb_tstamp_tx()

Jag Raman (1):
      sparc64: ldc abort during vds iso boot

Jan H. Sch=F6nherr (1):
      KVM: nVMX: Fix handling of lmsw instruction

Jason A. Donenfeld (4):
      skbuff: return -EMSGSIZE in skb_to_sgvec to prevent overflow
      ipsec: check return value of skb_to_sgvec always
      rxrpc: check return value of skb_to_sgvec always
      virtio_net: check return value of skb_to_sgvec always

Jason Wang (1):
      vhost: correctly remove wait queue during poll failure

Jason Yan (2):
      scsi: libsas: fix memory leak in sas_smp_get_phy_events()
      scsi: libsas: fix error when getting phy events

Jia-Ju Bai (2):
      qlcnic: Fix a sleep-in-atomic bug in qlcnic_82xx_hw_write_wx_2M and q=
lcnic_82xx_hw_read_wx_2M
      mISDN: Fix a sleep-in-atomic bug

Jiri Olsa (1):
      perf trace: Add mmap alias for s390

Jisheng Zhang (1):
      usb: chipidea: properly handle host or gadget initialization failure

Kai-Heng Feng (1):
      sky2: Increase D3 delay to sky2 stops working after suspend

Kees Cook (3):
      bna: Avoid reading past end of buffer
      qlge: Avoid reading past end of buffer
      ray_cs: Avoid reading past end of buffer

Kirill Tkhai (1):
      pidns: disable pid allocation if pid_ns_prepare_proc() is failed in a=
lloc_pid()

Liping Zhang (1):
      netfilter: ctnetlink: fix incorrect nf_ct_put during hash resize

Lorenzo Bianconi (1):
      iio: magnetometer: st_magn_spi: fix spi_device_id table

Luca Coelho (1):
      mac80211: bail out from prep_connection() if a reconfig is ongoing

Lv Zheng (1):
      ACPICA: Events: Add runtime stub support for event APIs

Mahesh Bandewar (1):
      ipv6: avoid dad-failures for addresses with NODAD

Marcel Holtmann (1):
      Bluetooth: Send HCI Set Event Mask Page 2 command only when needed

Marcin Nowakowski (2):
      MIPS: mm: fixed mappings: correct initialisation
      MIPS: kprobes: flush_insn_slot should flush only if probe initialised

Maurizio Lombardi (1):
      scsi: bnx2fc: fix race condition in bnx2fc_get_host_stats()

Mel Gorman (1):
      futex: Remove requirement for lock_page() in get_futex_key()

Michael Ellerman (2):
      selftests/powerpc: Fix TM resched DSCR test with some compilers
      powerpc/spufs: Fix coredump of SPU contexts

Michael Schmitz (1):
      fix race in drivers/char/random.c:get_reg()

Miklos Szeredi (1):
      ovl: filter trusted xattr for non-admin

Milian Wolff (1):
      perf report: Ensure the perf DSO mapping matches what libdw sees

Mintz, Yuval (1):
      bnx2x: Allow vfs to disable txvlan offload

Namhyung Kim (1):
      perf tests: Decompress kernel module before objdump

Nathan Chancellor (1):
      virtio_net: check return value of skb_to_sgvec in one more location

Neil Horman (1):
      vmxnet3: ensure that adapter is in proper state during force_close

Nithin Sujir (1):
      bonding: Don't update slave->link until ready to commit

Pan Bian (2):
      usb: dwc3: keystone: check return value
      cx25840: fix unchecked return values

Paolo Abeni (1):
      ipv6: the entire IPv6 header chain must fit the first fragment

Paul Mackerras (1):
      KVM: PPC: Book3S PR: Check copy_to/from_user return values

Peter Zijlstra (2):
      x86/tsc: Provide 'tsc=3Dunstable' boot parameter
      perf/core: Correct event creation with PERF_FORMAT_GROUP

Pieter \"PoroCYon\" Sluys (1):
      vfb: fix video mode and line_length being set when loaded

Rabin Vincent (1):
      CIFS: silence lockdep splat in cifs_relock_file()

Rafael David Tinoco (1):
      scsi: libiscsi: Allow sd_shutdown on bad transport

Robert Jarzmik (1):
      tags: honor COMPILED_SOURCE with apart output directory

Roman Kapl (1):
      net: move somaxconn init from sysctl code

Roman Pen (1):
      KVM: SVM: do not zero out segment attributes if segment is unusable o=
r not present

Roopa Prabhu (1):
      vxlan: dont migrate permanent fdb entries during learn

Russell King (1):
      net: phy: avoid genphy_aneg_done() for PHYs without clause 22 support

Stefan Wahren (1):
      net: qca_spi: Fix alignment issues in rx path

Steffen Klassert (1):
      af_key: Fix slab-out-of-bounds in pfkey_compile_policy.

Suman Anna (1):
      ARM: davinci: da8xx: Create DSP device only when assigned memory

Talat Batheesh (2):
      net/mlx4_en: Avoid adding steering rules with invalid ring
      net/mlx4: Fix the check in attaching steering rules

Tang Junhui (2):
      bcache: stop writeback thread after detaching
      bcache: segregate flash only volume write streams

Theodore Ts'o (1):
      random: use lockless method of accessing and updating f->reg_idx

Thomas Bogendoerfer (1):
      Fix serial console on SNI RM400 machines

Thomas Petazzoni (1):
      ata: libahci: properly propagate return value of platform_get_irq()

Tin Huynh (1):
      leds: pca955x: Correct I2C Functionality

Tomi Valkeinen (1):
      drm/omap: fix tiled buffer stride calculations

Tony Lindgren (1):
      tty: n_gsm: Allow ADM response in addition to UA for control dlci

Trond Myklebust (1):
      NFSv4.1: RECLAIM_COMPLETE must handle NFS4ERR_CONN_NOT_BOUND_TO_SESSI=
ON

Vaibhav Jain (1):
      rtc: interface: Validate alarm-time before handling rollover

Will Deacon (1):
      arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage

Xin Long (4):
      sctp: fix recursive locking warning in sctp_do_peeloff
      bonding: fix the err path for dev hwaddr sync in bond_enslave
      bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
      bonding: process the err returned by dev_set_allmulti properly in bon=
d_enslave

chenxiang (1):
      scsi: libsas: initialize sas_phy status according to response of DISC=
OVER

linzhang (2):
      net: x25: fix one potential use-after-free issue
      net: llc: add lock_sock in llc_ui_bind to avoid a race condition


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrREhsACgkQONu9yGCS
aT5gHQ/8Ctz6ny6OhZq3y4vOHDzfzJmAOy8aJwjg4gZ9C7yr9UJDZ1GUtEzTh6SR
WP6UDAxRVFIhv3G9NrbEzmAZngm/8mfLrhjg13jZcmdbQWmt/72X5EbY5MerwApQ
viasfkYzbxo4tcGdcBoRxSLD0xb/UK1t9uYfXeMYDKFG2LZhQ+uSTdpRzDK5lr5P
9s4WqjIYnhAUwOMgglU/A5AMHHxK7UZCRRC1XON9FRmGmVXzyNiVynNLutBEA9Md
IAbrTgqv4mtC3AJvOY/MXd+IvZIDu0LONJ5OlzWaF9Ja55wbGS55IYgXKirBCJOq
E7+0WwY7XszWk7/68oxkPg2hUzQm7cDbWkLu+tbtT2C2I2BwXPMg199NE5FQRds6
QQmlc5lWHIeBbZgbCjr2k+Hnjnoibky5lD1pTm4hK5lffGbZoFHB4Z/QkXMRvMJo
1cm+PKqKCeqtMdcHYtCS9ME1qpHeczSxkGfXa5DIsjdd0nbOrcnT69/fDJTnDHux
OLM4cPChuA0eZGpkdjy5eMJgBZVCCY3eSeI7UNsSg3gnj+6k7JFq1Kn7WXUc1yIa
Z9pZKKQo9jH8qzG7li4nhNU5j78u2E1zwEDNBlo111RT6PyCITsoFjeMhhY02d+1
PPBkIj4N6Qsnn8w0AxE6wRS56GeyHy5exBsIDHKvu6j3unseSJE=
=ayu4
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
