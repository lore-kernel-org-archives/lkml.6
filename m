Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842254-1521371772-2-6202294486320136722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521371772; b=CUvLsWZcLs14/XcwfmesjTWwQN1IGdNgdbVA0dekvFSdGTi
    Wk4ecylszodm+nyfWO9UI+H88kJh5L8hKJijW5KvJ4nvmHXDOBn5RRIC37/mTtmL
    bbx1IuilxfF5qJinTWIfxbKULRsA2nptm8jIXqUeOqIWCjLMHWIeQdRLaq2IgTyl
    RLVnpGlesoqRxTOoQYe+GQsD+5UclbjjegUlWZ4Kn7+JaFXSksPeQgLNWCj5Hd/c
    PiF/R8em9TUmYQ74VO6xfTvkP+BSmLl0JyLVLmt0SfmjBu8AtW1SNThulZxyG3CL
    sN8gJzSkkC6mKtjE8qcX2cY0BTqVsI/TPWakHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521371772; bh=LWR5xQWygK85Lu5q/LhYmQuuStTQlEcSCkx34+WS//g=; b=l
    ukfuvCQz7U47DIh4p2smdif/yr3pOe3jXLqCLqCwAWouIFPeadumP9ZTegjm49JJ
    C98Whq8uYPqgbJ8SLjXEU8mD7nX20vY4q+930w1+lxcn5qopEojdyO7Z/9DJOoqO
    VNXom6kQHEvQ/zgMvOVoVFqKf3BW2NWglZFTxgwTqNUddv+dh0co61DH4HR7CvuM
    kM1CmaEqjjDbV9V1pC9CVb5j1d8TljJBcz3Z+9eLPh8UUIlmKSAdYef2/lUkzd29
    9aFNN0tHSx+/FETYqDGb9VnpuYBf0AV7PgdCEcuA41yX0GmNT9zGUdeZ2H01p5Do
    9wwQUDOb3LvPTU6sNldmg==
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
        id S1751967AbeCRLQK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 07:16:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeCRLQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 07:16:09 -0400
Date: Sun, 18 Mar 2018 12:16:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.100
Message-ID: <20180318111608.GA6614@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.100 kernel.

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

 Makefile                                 |    2=20
 arch/mips/kernel/smp-bmips.c             |    8 +-
 arch/x86/kernel/cpu/mcheck/mce.c         |   22 +++++
 arch/x86/kernel/machine_kexec_64.c       |    1=20
 arch/x86/kernel/module.c                 |   14 +++
 arch/x86/tools/relocs.c                  |    3=20
 drivers/input/keyboard/matrix_keypad.c   |    4 -
 drivers/mtd/ubi/vmt.c                    |   15 ++-
 drivers/scsi/qla2xxx/qla_init.c          |    1=20
 drivers/staging/android/ashmem.c         |   15 +--
 drivers/tty/serial/8250/8250_pci.c       |   11 ++
 drivers/tty/serial/atmel_serial.c        |    1=20
 drivers/tty/serial/sh-sci.c              |    2=20
 drivers/usb/core/message.c               |    4 +
 drivers/usb/core/quirks.c                |    3=20
 drivers/usb/mon/mon_text.c               |  124 +++++++++++++++++++-------=
-----
 drivers/usb/storage/uas.c                |    2=20
 include/linux/usb/quirks.h               |    3=20
 net/bridge/netfilter/ebt_among.c         |   21 ++++-
 net/bridge/netfilter/ebtables.c          |   13 +++
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c |    4 +
 net/netfilter/nf_nat_proto_common.c      |    7 +
 net/netfilter/xt_IDLETIMER.c             |    9 +-
 net/netfilter/xt_LED.c                   |   12 +--
 net/sctp/sm_make_chunk.c                 |    2=20
 scripts/recordmcount.c                   |   14 +++
 sound/core/seq/seq_clientmgr.c           |   21 +++--
 sound/core/seq/seq_fifo.c                |    2=20
 sound/core/seq/seq_memory.c              |   14 ++-
 sound/core/seq/seq_memory.h              |    3=20
 30 files changed, 261 insertions(+), 96 deletions(-)

Clay McClure (1):
      ubi: Fix race condition between ubi volume creation and udev

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20

Eric Dumazet (1):
      netfilter: IDLETIMER: be syzkaller friendly

Florian Westphal (3):
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
      netfilter: bridge: ebt_among: add missing match size checks
      netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt

Greg Kroah-Hartman (2):
      fixup: sctp: verify size of a new chunk in _sctp_make_chunk()
      Linux 3.18.100

H.J. Lu (1):
      x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Joel Fernandes (1):
      staging: android: ashmem: Fix lockdep issue during llseek

Jonas Danielsson (1):
      tty/serial: atmel: add new version check for usart

Josh Poimboeuf (1):
      x86/module: Detect and skip invalid relocations

Julia Lawall (1):
      USB: usbmon: remove assignment from IS_ERR argument

Justin Chen (1):
      MIPS: BMIPS: Do not mask IPIs during suspend

Nikola Ciprich (1):
      serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Oliver Neukum (1):
      uas: fix comparison for error code

Paolo Abeni (2):
      netfilter: x_tables: fix missing timer initialization in xt_LED
      netfilter: nat: cope with negative port range

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size

Russell King (1):
      scripts: recordmcount: break hardlinks

Seunghun Han (1):
      x86/MCE: Serialize sysfs changes

Takashi Iwai (2):
      ALSA: seq: Don't allow resizing pool in use
      ALSA: seq: More protection for concurrent write and ioctl races

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts

himanshu.madhani@cavium.com (1):
      scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlquSnQACgkQONu9yGCS
aT6rug//YQyt3Ky/JpJ47p1+gcyR/wtnC9LxcJBvF3/3n4fsr1LuhwriSFH/ux+A
TsqHr0QKbsCiX+Czp2pNeUrOcNCQKUyL9oy/G338tr4C5ENCzmt1FlrmoxQMzq+l
T6tQFCWrWFd9VY8/ZvJpohezl81qkGVFgM/4l9TdJoagZqVTmqeh6idR2mBj7Rry
fOsMn5Iq1O+ewkMl2zzIeqe+eClVxaqckqrDwv2Y8lIDXyX0dF8TIDUan1KPlKkl
gnOTKkhbwUl2D6Z1D0GaGdAxqtSFCKWxTIw1atbQGvwpCzoW4JThRJhluIub8XPZ
/TuSo3RduqBDHEYvTdYkJdRSS54ivv6qhswiH7xcrsVGw4quQkO8PjRasqFjU2Ya
+kIU5qLucQghgRXEztR1rd2nR/5jVm4ZT968XYs3Eyn6Ek6Pc6ujaDagflnJcjIO
d5SBKlX0rMjwQfQJomSugjR1f85XvMOUnpsgNKl1lCcbFVwGtDMWoB6qzmPN0/V4
Dv3u3yl7Xx4xh+DQCtetG2T30R9ke8Pvu+M2WuvJBHzbH+jabrDbeCHg6vn51LfY
GyP8j7877HZPx6yg8xiko7RQWgqwUOKnw9sRiAeIeoSefuuvzfc+d9EUmOaXsrs4
xmQ+7c2sKTruZlDJBXQqgtmXASDHMpquDHMJOv+HJNeuCKDjZ18=
=04b6
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
