Date: Mon, 30 Apr 2018 05:21:53 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.6
Message-ID: <20180430122153.GA7020@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.6 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/networking/ip-sysctl.txt                       |    8=20
 Makefile                                                     |    2=20
 arch/s390/kernel/perf_cpum_cf_events.c                       |    8=20
 arch/s390/kernel/uprobes.c                                   |    9=20
 drivers/acpi/acpi_video.c                                    |   27 +
 drivers/block/swim.c                                         |   49 +-
 drivers/block/swim3.c                                        |    6=20
 drivers/cdrom/cdrom.c                                        |    2=20
 drivers/char/tpm/tpm-interface.c                             |  131 +++++--
 drivers/char/tpm/tpm.h                                       |    1=20
 drivers/char/tpm/tpm_crb.c                                   |  108 ++++--
 drivers/char/tpm/tpm_tis_core.c                              |    4=20
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                    |    3=20
 drivers/hwmon/k10temp.c                                      |   17=20
 drivers/message/fusion/mptsas.c                              |    1=20
 drivers/net/bonding/bond_main.c                              |    3=20
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                  |    8=20
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c                 |   16=20
 drivers/net/ethernet/amd/xgbe/xgbe-main.c                    |    1=20
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                    |   24 +
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c                     |    2=20
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                  |  196 ++++++=
+++--
 drivers/net/ethernet/amd/xgbe/xgbe.h                         |    9=20
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c              |    8=20
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c |   16=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c            |   49 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_nvm_defs.h           |    2=20
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c           |   11=20
 drivers/net/ethernet/marvell/mvpp2.c                         |   12=20
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h                 |    2=20
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c            |    7=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c            |    7=20
 drivers/net/ethernet/ti/cpsw.c                               |    2=20
 drivers/net/macsec.c                                         |    5=20
 drivers/net/ppp/pppoe.c                                      |    4=20
 drivers/net/team/team.c                                      |   38 +-
 drivers/net/tun.c                                            |    7=20
 drivers/net/usb/qmi_wwan.c                                   |    1=20
 drivers/net/virtio_net.c                                     |   79 ++--
 drivers/net/vmxnet3/vmxnet3_drv.c                            |   17=20
 drivers/net/vmxnet3/vmxnet3_int.h                            |    4=20
 drivers/net/wireless/ath/ath10k/mac.c                        |    5=20
 drivers/pinctrl/intel/pinctrl-intel.c                        |   23 -
 drivers/s390/block/dasd_alias.c                              |   13=20
 drivers/s390/cio/chsc.c                                      |   14=20
 drivers/s390/net/qeth_core.h                                 |    2=20
 drivers/s390/net/qeth_core_main.c                            |  115 ++----
 include/linux/fsnotify_backend.h                             |    4=20
 include/linux/hmm.h                                          |    9=20
 include/linux/if_vlan.h                                      |    7=20
 include/linux/tpm.h                                          |    2=20
 include/net/ife.h                                            |    3=20
 include/net/llc_conn.h                                       |    1=20
 kernel/kprobes.c                                             |    2=20
 kernel/trace/trace_entries.h                                 |    2=20
 net/core/dev.c                                               |    2=20
 net/core/neighbour.c                                         |   40 +-
 net/dns_resolver/dns_key.c                                   |   12=20
 net/ife/ife.c                                                |   38 ++
 net/ipv4/tcp.c                                               |    8=20
 net/ipv4/tcp_input.c                                         |    7=20
 net/ipv6/route.c                                             |    2=20
 net/ipv6/seg6_iptunnel.c                                     |    2=20
 net/l2tp/l2tp_core.c                                         |   40 +-
 net/l2tp/l2tp_core.h                                         |    3=20
 net/l2tp/l2tp_debugfs.c                                      |   18 -
 net/l2tp/l2tp_netlink.c                                      |   11=20
 net/l2tp/l2tp_ppp.c                                          |   34 +
 net/llc/af_llc.c                                             |   14=20
 net/llc/llc_c_ac.c                                           |    9=20
 net/llc/llc_conn.c                                           |   22 +
 net/packet/af_packet.c                                       |   83 +++-
 net/packet/internal.h                                        |   10=20
 net/sched/act_ife.c                                          |    9=20
 net/sctp/ipv6.c                                              |   60 +--
 net/smc/af_smc.c                                             |   10=20
 net/strparser/strparser.c                                    |    9=20
 net/tipc/netlink.c                                           |    3=20
 net/vmw_vsock/af_vsock.c                                     |    6=20
 security/commoncap.c                                         |    2=20
 80 files changed, 1083 insertions(+), 479 deletions(-)

Ahmed Abdelsalam (1):
      ipv6: sr: fix NULL pointer dereference in seg6_do_srh_encap()- v4 pkts

Alexander Aring (3):
      net: sched: ife: signal not finding metaid
      net: sched: ife: handle malformed tlv length
      net: sched: ife: check on metadata length

Andr=C3=A9 Wild (1):
      s390/cpum_cf: rename IBM z13/z14 counter names

Bj=C3=B8rn Mork (1):
      tun: fix vlan packet truncation

Cong Wang (3):
      llc: delete timers synchronously in llc_sk_free()
      llc: hold llc_sap before release_sock()
      llc: fix NULL pointer deref for SOCK_ZAPPED

Dan Carpenter (2):
      Revert "macsec: missing dev_put() on error in macsec_newlink()"
      cdrom: information leak in cdrom_ioctl_media_changed()

Doron Roberts-Kedes (2):
      strparser: Do not call mod_delayed_work with a timeout of LONG_MAX
      strparser: Fix incorrect strp->need_bytes value.

Eric Biggers (1):
      KEYS: DNS: limit the length of option strings

Eric Dumazet (5):
      ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
      net: af_packet: fix race in PACKET_{R|T}X_RING
      tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
      tipc: add policy for TIPC_NLA_NET_ADDR
      net: validate attribute sizes in neigh_dump_table()

Finn Thain (8):
      m68k/mac: Don't remap SWIM MMIO region
      block/swim: Check drive type
      block/swim: Don't log an error message for an invalid ioctl
      block/swim: Remove extra put_disk() call from error path
      block/swim: Rename macros to avoid inconsistent inverted logic
      block/swim: Select appropriate drive on device open
      block/swim: Fix array bounds check
      block/swim: Fix IO error at end of medium

Greg Kroah-Hartman (3):
      Revert "pinctrl: intel: Initialize GPIO properly when used through ir=
qchip"
      Revert "mm/hmm: fix header file if/else/endif maze"
      Linux 4.16.6

Guenter Roeck (2):
      hwmon: (k10temp) Add temperature offset for Ryzen 2700X
      hwmon: (k10temp) Add support for AMD Ryzen w/ Vega graphics

Guillaume Nault (6):
      l2tp: check sockaddr length in pppol2tp_connect()
      pppoe: check sockaddr length in pppoe_connect()
      l2tp: hold reference on tunnels in netlink dumps
      l2tp: hold reference on tunnels printed in pppol2tp proc file
      l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file
      l2tp: fix {pppol2tp, l2tp_dfs}_seq_stop() in case of seq_file overflow

Hans de Goede (1):
      ACPI / video: Only default only_lcd to true on Win8-ready _desktops_

Heiko Carstens (1):
      s390/uprobes: implement arch_uretprobe_is_alive()

Igor Russkikh (2):
      net: aquantia: Regression on reset with 1.x firmware
      net: aquantia: oops when shutdown on already stopped device

Ivan Khoronzhuk (1):
      net: ethernet: ti: cpsw: fix tx vlan priority mapping

James Bottomley (1):
      tpm: add retry logic

Jann Horn (1):
      tcp: don't read out-of-bounds opsize

Jason Wang (1):
      virtio-net: add missing virtqueue kick when flushing packets

Jose Abreu (1):
      net: stmmac: Disable ACS Feature for GMAC >=3D 4

Julian Wiedmann (3):
      s390/qeth: fix error handling in adapter command callbacks
      s390/qeth: avoid control IO completion stalls
      s390/qeth: handle failure on workqueue creation

Karthikeyan Periyasamy (1):
      Revert "ath10k: send (re)assoc peer command when NSS changed"

Martin K. Petersen (1):
      scsi: mptsas: Disable WRITE SAME

Maxime Chevallier (1):
      net: mvpp2: Fix DMA address mask size

Michael S. Tsirkin (2):
      virtio_net: split out ctrl buffer
      virtio_net: fix adding vids on big-endian

Neil Armstrong (1):
      drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX So=
Cs

Olivier Gayot (1):
      docs: ip-sysctl.txt: fix name of some ipv6 variables

Paolo Abeni (1):
      team: avoid adding twice the same option to the event list

Pawel Dembicki (1):
      net: qmi_wwan: add Wistron Neweb D19Q1

Pawe=C5=82 Jab=C5=82o=C5=84ski (1):
      i40e: Fix attach VF to VM issue

Peter Xu (1):
      tracing: Fix missing tab for hwlat_detector print format

Robert Kolchmeyer (1):
      fsnotify: Fix fsnotify_mark_connector race

Ronak Doshi (1):
      vmxnet3: fix incorrect dereference when rxvlan is disabled

Sebastian Ott (1):
      s390/cio: update chpid descriptor after resource accessibility event

Soheil Hassas Yeganeh (1):
      tcp: clear tp->packets_out when purging write queue

Stefan Haberland (1):
      s390/dasd: fix IO error for newly defined devices

Stefan Hajnoczi (1):
      VSOCK: make af_vsock.ko removable again

Tetsuo Handa (1):
      commoncap: Handle memory allocation failure.

Thomas Richter (1):
      kprobes: Fix random address output of blacklist file

Tom Lendacky (3):
      amd-xgbe: Add pre/post auto-negotiation phy hooks
      amd-xgbe: Improve KR auto-negotiation and training
      amd-xgbe: Only use the SFP supported transceiver signals

Tomas Winkler (1):
      tpm: cmd_ready command can be issued only after granting locality

Toshiaki Makita (1):
      vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Ursula Braun (1):
      net/smc: fix shutdown in state SMC_LISTEN

Vasundhara Volam (1):
      bnxt_en: Fix memory fault in bnxt_ethtool_init()

Willem de Bruijn (1):
      packet: fix bitfield update race

Winkler, Tomas (1):
      tpm: tpm-interface: fix tpm_transmit/_cmd kdoc

Wolfgang Bumiller (1):
      net: fix deadlock while clearing neighbor proxy table

Xin Long (3):
      bonding: do not set slave_dev npinfo before slave_enable_netpoll in b=
ond_enslave
      sctp: do not check port in sctp_inet6_cmp_addr
      team: fix netconsole setup over team


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrnCmAACgkQONu9yGCS
aT4C7RAAoHURDCN8gznQdj8mhU0EWFT+lV5QvRNGnPaVdutmEQcAoUcci2P6QvCK
/IGPAKJqAzJsTCfB3nd4ra0nn8cs3nntpo/rhaGDpkiWo/eZ8j6S5HGk7kL8/lIW
LKDDJLNyPtG0VeGBABT+CQrsjetK8CtA9A1M5j7JmWuFShOZBeXcNGcQzy/2m87W
EHDNPqXjb/OzW8W4LU4kLGrvQBZ48sDoLh0IZ4YrmbDEoKJ1NOdTDzo7Uy9GiW+n
QCcGSXcb7vtA75heqDYjDn75q9CNwBAIb3lub6nMme/9jPlR6W1SthJmSBLMkUqh
WFqh3JuZRG3v9LA+8bkzdnS6GfndjfRPsw+lS6AU5eneYoF1tFWt3M17MNqTD10V
3HTwTTLLvr7RXDG68bDhKCQ1OnYexgmG+oJtFu9NQ10VGUSIsGWyAsRVKDR4iBQN
AAIgTbiNztB5nT1L0/LHeGeEsFAc5Vl0xy+BM6ueASQ9x5+vz0Y9m/c/nSY2RDXS
aeQBrm3OwAsGhO55ECVda6JVtcym3wCtR7PrSffz2jNBjUmIeEpfiBZkIG/FUcaL
5fUZ3J4VKGjMeTkHvUvdl/ve9jO6llf63hbYZB8F/wiFoXzqk9Lxsujm0mMT+1lF
wpiQgAM4o96hhbhWRhURJo17QMdv8KTkq6BDr+mXLUX5/8azk1w=
=IccZ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
