Date: Mon, 30 Apr 2018 05:19:12 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.107
Message-ID: <20180430121912.GA6561@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.107 kernel.

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

 Makefile                        |    2=20
 arch/x86/kernel/tsc.c           |    2=20
 drivers/cdrom/cdrom.c           |    2=20
 drivers/message/fusion/mptsas.c |    1=20
 drivers/net/bonding/bond_main.c |    3 -
 drivers/net/ppp/pppoe.c         |    4 +
 drivers/net/team/team.c         |   38 ++++++++++++++---
 fs/cifs/dir.c                   |    9 ++--
 fs/ext4/balloc.c                |    3 -
 fs/ext4/ialloc.c                |   43 +------------------
 fs/ext4/inline.c                |   66 +++++++++++++-----------------
 fs/ext4/inode.c                 |    2=20
 fs/ext4/xattr.c                 |   30 +++++--------
 fs/ext4/xattr.h                 |   32 ++++++++++++++
 fs/jbd2/journal.c               |    2=20
 include/net/llc_conn.h          |    1=20
 kernel/events/core.c            |    4 -
 mm/filemap.c                    |    4 -
 net/dns_resolver/dns_key.c      |   13 ++---
 net/ipv4/tcp.c                  |    6 +-
 net/ipv4/tcp_input.c            |    7 ---
 net/ipv6/route.c                |    2=20
 net/l2tp/l2tp_ppp.c             |    7 +++
 net/llc/af_llc.c                |   14 +++++-
 net/llc/llc_c_ac.c              |    9 ----
 net/llc/llc_conn.c              |   22 +++++++++-
 net/packet/af_packet.c          |   88 ++++++++++++++++++++++++++++-------=
-----
 net/packet/internal.h           |   10 ++--
 28 files changed, 253 insertions(+), 173 deletions(-)

Cong Wang (3):
      llc: hold llc_sap before release_sock()
      llc: fix NULL pointer deref for SOCK_ZAPPED
      llc: delete timers synchronously in llc_sk_free()

Dan Carpenter (1):
      cdrom: information leak in cdrom_ioctl_media_changed()

Eric Biggers (1):
      KEYS: DNS: limit the length of option strings

Eric Dumazet (3):
      tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
      net: af_packet: fix race in PACKET_{R|T}X_RING
      ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Greg Kroah-Hartman (1):
      Linux 3.18.107

Guillaume Nault (2):
      l2tp: check sockaddr length in pppol2tp_connect()
      pppoe: check sockaddr length in pppoe_connect()

Jann Horn (1):
      tcp: don't read out-of-bounds opsize

Jiri Olsa (1):
      perf: Return proper values for user stack errors

Martin K. Petersen (1):
      scsi: mptsas: Disable WRITE SAME

Matthew Wilcox (1):
      mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Paolo Abeni (1):
      team: avoid adding twice the same option to the event list

Sahitya Tummala (1):
      jbd2: fix use after free in kjournald2()

Steve French (1):
      cifs: do not allow creating sockets except with SMB1 posix exensions

Theodore Ts'o (2):
      ext4: fix deadlock between inline_data and ext4_expand_extra_isize_ea=
()
      ext4: don't update checksum of new initialized bitmaps

Willem de Bruijn (1):
      packet: fix bitfield update race

Xiaoming Gao (1):
      x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Xin Long (2):
      bonding: do not set slave_dev npinfo before slave_enable_netpoll in b=
ond_enslave
      team: fix netconsole setup over team

wangguang (1):
      ext4: bugfix for mmaped pages in mpage_release_unused_pages()


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrnCcAACgkQONu9yGCS
aT7udRAAhKM+v8XHpJLTx4MWlkmpDBXikTfPcjJiCQdmrVjxZoZu0ROrtYvL2Chp
nFGUT/REHbAe+PDxAmu2C00PGwxvcHMlMr1mgZm8bZOvA7ZgdoYxqQR0S2/3ewrq
Q6h87Vrxuo0q/XXdysSAEwGVBClWb9o08XR+8CqSkms/oRuanbywoimkYXZy7wiu
mtnXr7jU2+mUJneq8/HBewXOAo+UzCi4hsiWHBZ95voZthRxhxAlqCiSHyGftmkk
R3ErLZbS7pCXS6NxNTWc2ne8pGcAEnRt5X5SEFD4FMQUHxyuuaJjqJcDNNv54cRI
3F58D7n0ODSxv9zn6Os9hTJA/nLI8jsffhoKe+n584mwJImZRWWBArlMVsUxl41G
8EK97x1C6ZA7jwK86GgF0RFfSGLqRuyHQansJaHxdL4NJNFC2top8yBkfULHfy7L
SmcVEWk/vRrI6hpRKsrn+/n1BAo+Ym94y/mc5Cc4+W79woPjKoHUdru+XUYBSIla
5/NL8p84IkphvKJPn2MHOo3dj1pc2Ao93Ws2/SJh1MjlusKCKqWxxMOd00qjGI2G
jKMpu89Gkhtn8I6YHgCVz+KfrXsatgZ0rG930vgh2sjr3/Xh5cSXt3fcl94QhEDo
tCwpQNtk25GyB83F5dhZO0ovFGn3HjS+m8c3l0ji3xk5emlbezY=
=kTqh
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
