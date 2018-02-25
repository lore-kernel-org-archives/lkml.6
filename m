Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3799018-1519557111-2-8497214233241422660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
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
    t=1519557111; b=CuMxX8YwkfIoru+hNcYQDHALKtE/bp5sY/OGjPokBDNixvC
    U4EnwQ/Vmr50rk6IlX23mdjdWvzpCm6fFdb9bDjcvDhQZbWp05qKacbjoA1gq4CZ
    IhjnNKR7Q9rtP3wpzv3LVU1fEhgpD+uWSiqGEwIa/TqTQbRR59cWv0nDwlKZMki1
    VPZBzYGPQ4Erd+0IC4xa1mBysiFBx4ZmyrHfoSYUvly6tutZfXZhopKwL369p4P+
    TOoucZn2cbjVcps8lBq8X3YctVTlQUTW93I1Xm9vDvWWnwTPbbjqRxbetDa4NFws
    6lTYAFSwanyh+WIzprQXQUv+51ezUu/+hKABc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519557111; bh=sk/y6dKSAr2nxcHTLZ7obx2mxkznBuYodaqP2L/W8B0=; b=t
    uQ5WYKTamSJrqoMrQwJ6XbWJok8HC0YXgpldsJGxLeFJ/tXIJX6OesTVQzSupttj
    6mMMN28a6YdZ2aKj4XqWAe44OSRtJEFGAELYkp1MIVWMGmMywXA//FB5vHWv+CGy
    X3baBF8ed5J1UAm/DctIMJSsvQVnpdn6Odxc04CZSzrdZQzd7aoJyzBB2zUekfZs
    p5Yj/3Iuc4f9HjzWVt7W4J+mJiVPbIj/q7ARtv8Ba3uySmz1N97QvyO71LGBs2eC
    rzRNN8e4gh87JC1hJ9cEn0xY488eNGU4bKxj/hzM1ynJLK1JKHBoT0OZeflHrlFe
    HMK9nvJsFcndbKDURq3oQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeBYLLA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 06:11:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeBYLJt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Feb 2018 06:09:49 -0500
Date: Sun, 25 Feb 2018 12:09:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.6
Message-ID: <20180225110944.GA21834@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.6 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                        |    2=20
 arch/arm/common/bL_switcher_dummy_if.c          |    4=20
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |    2=20
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S    |  112 ++++++++++++-------=
-----
 arch/x86/kvm/x86.c                              |    6 +
 block/blk-map.c                                 |    4=20
 drivers/android/binder.c                        |   29 ++++--
 drivers/crypto/s5p-sss.c                        |   12 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c         |   12 ++
 drivers/misc/mei/hw-me-regs.h                   |    5 +
 drivers/misc/mei/pci-me.c                       |    5 +
 drivers/net/tun.c                               |   16 +--
 drivers/soc/qcom/rmtfs_mem.c                    |    4=20
 drivers/staging/android/ashmem.c                |   19 ++--
 drivers/staging/android/ion/ion-ioctl.c         |    4=20
 drivers/staging/android/ion/ion_system_heap.c   |    2=20
 drivers/staging/fsl-mc/bus/Kconfig              |    2=20
 drivers/staging/iio/adc/ad7192.c                |   27 ++++-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4=20
 drivers/usb/host/xhci-debugfs.c                 |    4=20
 drivers/usb/host/xhci.c                         |   10 --
 drivers/usb/usbip/stub_dev.c                    |    3=20
 drivers/usb/usbip/vhci_hcd.c                    |    2=20
 drivers/video/fbdev/mmp/core.c                  |    5 +
 include/linux/ptr_ring.h                        |   15 ++-
 kernel/kcov.c                                   |    4=20
 mm/vmalloc.c                                    |   10 +-
 net/core/dev.c                                  |    2=20
 net/core/gen_estimator.c                        |    4=20
 net/decnet/af_decnet.c                          |   62 +++++++------
 net/ipv4/ip_sockglue.c                          |   14 ---
 net/ipv4/netfilter/ipt_CLUSTERIP.c              |   16 ++-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c  |    6 +
 net/ipv6/ipv6_sockglue.c                        |   17 +--
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c  |   18 ++-
 net/netfilter/x_tables.c                        |    9 +
 net/netfilter/xt_RATEEST.c                      |   22 +++-
 net/netfilter/xt_cgroup.c                       |    1=20
 net/rds/connection.c                            |    3=20
 net/rds/rds.h                                   |    6 -
 net/rds/tcp.c                                   |   13 +-
 net/rds/tcp.h                                   |    1=20
 security/selinux/ss/services.c                  |   21 ++--
 sound/soc/ux500/mop500.c                        |    4=20
 sound/soc/ux500/ux500_pcm.c                     |    5 +
 45 files changed, 347 insertions(+), 201 deletions(-)

Alexander Usyskin (1):
      mei: me: add cannon point device ids

Alexandru Ardelean (2):
      staging: iio: adc: ad7192: fix external frequency setting
      staging: iio: ad5933: switch buffer mode to software

Andrey Konovalov (1):
      media: pvrusb2: properly check endpoint types

Arnd Bergmann (5):
      ASoC: ux500: add MODULE_LICENSE tag
      video: fbdev/mmp: add MODULE_LICENSE
      ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag
      arm64: dts: add #cooling-cells to CPU nodes
      staging: fsl-mc: fix build testing on x86

Ben Hutchings (1):
      staging: android: ashmem: Fix a race condition in pin ioctls

Cong Wang (2):
      netfilter: xt_cgroup: initialize info->priv in cgroup_mt_check_v1()
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Dmitry Vyukov (3):
      kcov: detect double association with a single task
      netfilter: x_tables: fix int overflow in xt_alloc_table_info()
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_=
check()

Douglas Gilbert (1):
      blk_rq_map_user_iov: fix error override

Eric Biggers (2):
      crypto: x86/twofish-3way - Fix %rbp usage
      binder: check for binder_thread allocation failure in binder_poll()

Eric Dumazet (3):
      tun: fix tun_napi_alloc_frags() frag allocator
      netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{ma=
tch|target}
      net_sched: gen_estimator: fix lockdep splat

Greg Kroah-Hartman (1):
      Linux 4.15.6

Jason Wang (2):
      ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE
      ptr_ring: try vmalloc() when kmalloc() fails

Jesse Chan (1):
      soc: qcom: rmtfs_mem: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Kamil Konieczny (1):
      crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Laura Abbott (2):
      staging: android: ion: Add __GFP_NOWARN for system contig heap
      staging: android: ion: Switch from WARN to pr_warn

Martijn Coenen (1):
      ANDROID: binder: synchronize_rcu() when using POLLFREE.

Michal Hocko (1):
      vmalloc: fix __GFP_HIGHMEM usage for vmalloc_32 on 32b systems

Paolo Abeni (2):
      netfilter: on sockopt() acquire sock lock only in the required scope
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Paul Moore (2):
      selinux: ensure the context is NUL terminated in security_context_to_=
sid_core()
      selinux: skip bounded transition processing if the policy isn't loaded

Shuah Khan (1):
      usbip: keep usbip_device sockfd state in sync with tcp_socket

Sowmini Varadhan (2):
      rds: tcp: correctly sequence cleanup on netns deletion.
      rds: tcp: atomically purge entries from rds_tcp_conn_list during netn=
s delete

Todd Kjos (2):
      ANDROID: binder: remove WARN() for redundant txn error
      binder: replace "%p" with "%pK"

Tomas Winkler (1):
      mei: me: add cannon point device ids for 4th device

Wanpeng Li (1):
      KVM: x86: fix escape of guest dr6 to the host

Willem de Bruijn (1):
      net: avoid skb_warn_bad_offload on IS_ERR

Zhengjun Xing (4):
      xhci: Fix NULL pointer in xhci debugfs
      xhci: Fix xhci debugfs devices node disappearance after hibernation
      xhci: xhci debugfs device nodes weren't removed after device plugged =
out
      xhci: fix xhci debugfs errors in xhci_stop


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqSmXgACgkQONu9yGCS
aT594A//d588o2AFuzt1dqRZTSnHq5B9No1isgs9WssGxCMnVqGybJDn7vydinlu
xDQ5s/VI82NNILlRLGigPw+jhu3YtmBe2tDuctayy0ZW3RPXMbcjyaMHhGXO5HiZ
BkX3XvGzAh3p3mC3f8eM8adQF5HTElpIImHJP6OFP0Ot7x/uquH73qc5cjNbC1o+
3/Ic/pYGn4QkIMoWPVc/4DzHMQu8pt+wdODp/uz/T+zuCWdjU5mDxIajpgwyY1da
fKw0vQ9FVK9nXlzFhVsSNzhcyTxQWoqmV+gpGT6/NVhQ0MoNoZ8Pac7zrbtf2vki
9kcOl6YXVaSQoz16SRQlb62aOqE6pb3tCBjX5G2LW0Kp1pUBzLmbh5Ex+SaXYOHM
9+ADFzNW+j1tpZ8ViL6NC1omNdUgt97kaxPG1afxln+iJyzMmEl8IDT+krTZPZYb
rHJvRo+fm1ewuLp7anDNYC9Fg+YicmEJewcb95yuojhAr+XutGWdQas6aEF6vMVZ
Ia0Oi8ihp2Hd7i0E0kGrf6MNnu5OaJM7B2zDcTu52Y6OkgX0eaA60GeqDu4xopum
bA2H/wFPeyMurgpCv/C4AoNOeG++sZIhw3OPqPJN45hR0UPqr+W74yaPcshHGhG/
RzOoQzogP5BryMjGtPuJzE1ATf74LmcWUuacSMlJrmu9GdnzXDY=
=CwUr
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
