Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2031234-1520786692-2-16149327958592105435
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
    t=1520786672; b=KR7r9wQAkjrCYaF4T29jnpOmu5WP+xg0moRklJzAy3ZlHhP
    FZb5MzZDo4Y8GK4aS/qnnoGt7val5qznSxiTc1PG01bw5LztbWfix/RCM5FYHN9z
    f5HdjiQm3tt9aGWI6pos8XwEs+H03pT2CE+Md6W5xXPDC6Ihjoxz9c6INznoN/kz
    HqgtiuifKL3ccPq242ueHO/rdKeknJaewOproJVsSu3IaoRc05FG9WJ5sMJeUTsn
    BjWPTjFhxRG2UIea8Oa5QY/Pc1D1VdfS4qyvQfsuPt8gPDr7BZzcUx1L57jsKSYl
    0okieFgpiiB9PUNQr3ZkTHX5JxvgvNj4qSM5GAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520786672; bh=jcEJoO9tt2iFzs8G3Fta0g0/UanijszbBJS0jHA4hh8=; b=m
    nk+rmt73Hso9PRp7l5LkmU7e6tTTxiIAt4e8C2Z/RUcFgYJrDE1hrxoLBq3TblYw
    Qa1E9LnXw7RRfSPlr2Z6oOIZsATKjAFCpdnVRgWaUDMsOCxmYKKKaYpu6Z5D3mDJ
    TkgZtmaHz4NhBhKVDjyxWL3qeuaHRwyAG1jV1WA6Lzg9/+Ky0LwVSGVieizd9dm0
    zRoP+Y/xopM7YFAlL9DE03BVi9bPc1uPYB3uH794ps8Nz6+m9XSiXIGt7aZEtOPf
    noGclZ0oPDdXwm+LnvDNoSBzfHEieDNCbUjvn6RNGHfKRVWAQA4NsazZaRheXCmk
    oTbZ/klPRAXedMrvFu6EQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeCKQo3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 12:44:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeCKQo2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 12:44:28 -0400
Date: Sun, 11 Mar 2018 17:44:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.99
Message-ID: <20180311164429.GA11253@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.99 kernel.

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

 Makefile                                  |    2 -
 arch/arm/mach-mvebu/Kconfig               |    4 +-
 drivers/char/tpm/tpm_i2c_infineon.c       |    5 +--
 drivers/char/tpm/tpm_i2c_nuvoton.c        |    8 +++--
 drivers/cpufreq/s3c24xx-cpufreq.c         |    8 ++++-
 drivers/leds/led-triggers.c               |   12 ++++---
 drivers/md/dm-io.c                        |    1=20
 drivers/net/ethernet/freescale/fec.h      |    1=20
 drivers/net/ethernet/freescale/fec_main.c |    5 +--
 drivers/net/ethernet/freescale/fec_ptp.c  |   10 ++++++
 drivers/net/ppp/ppp_generic.c             |    9 +++++
 drivers/net/wan/hdlc_ppp.c                |    5 ++-
 drivers/s390/net/qeth_core.h              |    5 +++
 drivers/s390/net/qeth_core_main.c         |   33 +++++++++++----------
 include/net/udplite.h                     |    1=20
 net/bridge/br_sysfs_if.c                  |    3 +
 net/core/dev.c                            |   11 +++++--
 net/ipv4/fib_semantics.c                  |    5 +++
 net/ipv4/route.c                          |    7 +++-
 net/ipv4/udp.c                            |    5 +++
 net/ipv6/ip6_checksum.c                   |    5 +++
 net/ipv6/sit.c                            |    2 -
 net/netlink/genetlink.c                   |   12 ++++++-
 net/sctp/ipv6.c                           |   10 ++++--
 net/sctp/sm_make_chunk.c                  |    8 +++--
 sound/usb/quirks-table.h                  |   47 +++++++++++++++++++++++++=
+++++
 26 files changed, 180 insertions(+), 44 deletions(-)

Alexey Kodanev (3):
      udplite: fix partial checksum initialization
      sctp: fix dst refcnt leak in sctp_v6_get_dst()
      sctp: verify size of a new chunk in _sctp_make_chunk()

Arnd Bergmann (1):
      ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Denis Du (1):
      hdlc_ppp: carrier detect ok, don't turn off negotiation

Erik Veijola (1):
      ALSA: usb-audio: Add a quirck for B&W PX headphones

Greg Kroah-Hartman (1):
      Linux 3.18.99

Guillaume Nault (1):
      ppp: prevent unregistered channels from connecting to PPP units

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues

Jeremy Boone (2):
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitche=
s on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches=
 on the bus

Julian Wiedmann (2):
      s390/qeth: fix SETIP command handling
      s390/qeth: fix IPA command submission race

Lucas Stach (1):
      net: fec: introduce fec_ptp_stop and use in probe fail path

Mike Snitzer (1):
      dm io: fix duplicate bio completion due to missing ref count

Nathan Sullivan (1):
      leds: do not overflow sysfs buffer in led_trigger_show

Nicolas Dichtel (1):
      netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Sabrina Dubroca (1):
      net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Stefano Brivio (1):
      fib_semantics: Don't match route with mismatching tclassid

Ulf Magnusson (1):
      ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Viresh Kumar (1):
      cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Xin Long (1):
      bridge: check brport attr show in brport_show


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqlXOoACgkQONu9yGCS
aT5r6RAAuM4kV1lVH0L44iAo2XL36AgTypSNeizwurYhQXW7uxKWExwKreJvx9KY
JvWi8okbsaX+wmIkEd+ntWngsw4j7TMrrxXSbhK+NSsO/fFmXg8squoge1cG5XKN
4BCMg/j54CDe7zJLj3QMp95TtvSoeNQvrkadqhluGGjU3MWfOk5aXSIycUFRDXyl
L0ZpQfPYmExLU09WbQ1LIsqTSpEPk7KTJrDEwFT4QqLkVz/na+0jCq6G4ynAdiIe
yXESAq5VvMiZlJfmePbsU4EFMNvEYPnEg9wrEC2TflaU7idTIiHEsnbmvP6Q1qE5
gpDE7FrHQQ32oh+e+CSG3vhmTSiBDJw6iBaQWh7pf8U7wYKHMDovRTe9RC1WMhkD
1mpx3rpJj2rJhpe0u58PkIfQpQ47rNVDGKcu7z6U5dOxYOiE/okfKElT1EX0YjSy
FCGNfU601PANn0l3agj1DDFQclxDRjOY5McIeDe4CnXzaPCzqtZnlEQrCwqWNuN3
R3gXQp6xzlkKVDrc2BL8MYv1eiLwDcHZR04mirAgNWRg0RP2R7LMVsEl59sUPsvy
ub1ymiPf+Yi9Lryi5oYScMzS+hIoGRJW8zv7nLVa5vIScBLySEPzvVKZchjLpdDl
97DkDM4yo2UT1DSVmuaaXgnR7z3lS0YhcuY10HWPb8A46K6mCzc=
=gZaw
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
