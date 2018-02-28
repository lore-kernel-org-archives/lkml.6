Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972292-1519811838-2-12789705323056415390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1519811838; b=nDex92TqGtjhnqG2Sxy+LAr6pRsStC3XDpT+qhcrdAITcN+
    isDsUrG8ZPtI7V5QtchwOhouxUisISq5L9esguKJiy4oLJGZJli6JLGiNu03YZ1c
    6LL9ixi0ma8uQE3a3qe3Mqn/STGd7+I2tDBBj6OmB6DXblpGHfNRS63DsUXXBBUG
    Jc/BuKVaQFAIOAhLomk2SO95SMhySWMy/sGQ5FORW8vvwbcvqglMb5stC2GrW4cV
    lQuLsn57l13W+mqsiLDmApw6N24GLsQ/7XTEt0fs+O1qVdJsIk9PS7jKmbki5RQt
    peY3jCMpEunEMWW6cN4OVfOZOrV9J6G4zsW9NBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519811838; bh=ifK93yq0kVL9681mlsQ1Tet53WmFZyO8SfPaRgFei1g=; b=V
    8nNpA+XmsI6dUAAo7j55Fbuc2+JZHitohK6PT0yTfYHf3nsZU0iuN++UlGz7SypI
    Kf+eishJvZVnxQ5BUDH7tzcce/8Upw4KiYn1BCxz3lXGD9SG4SeCkGF79WrJis/Y
    9FnszS/9XXC5SowjHnsv395PE9GEAsKGkGPX0O9AL8Kp2OTBNjLaC8LM9xZ7mYWT
    1HrTFIQKjfag5ZttmSmazBMcd++v5eBrvh8zTYGjv1yZE3Q0hNJ2v2d01sdGXFcm
    jXxra1imrAGWtKatSnc3mtMTwaS7ZVsL9eys1/4ILRhx283GektoLLLe2QMfMWF9
    Qduc+7BNjtWGMOh9P8pnQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeB1J5R (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 04:57:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:32850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeB1J5Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 04:57:16 -0500
Date: Wed, 28 Feb 2018 10:57:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.97
Message-ID: <20180228095714.GA6207@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 3.18.97 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                           |    2 -
 arch/arm64/kernel/traps.c          |    2 -
 arch/x86/oprofile/nmi_int.c        |    2 -
 drivers/iio/imu/adis_trigger.c     |    7 +++---
 drivers/iio/industrialio-buffer.c  |    2 -
 drivers/irqchip/irq-gic-v3.c       |    2 -
 drivers/pci/host/pci-keystone.c    |    9 ++++++-
 drivers/scsi/ibmvscsi/ibmvfc.h     |    2 -
 drivers/usb/dwc3/gadget.c          |    2 +
 drivers/usb/gadget/function/f_fs.c |    6 +----
 lib/asn1_decoder.c                 |   43 ++++++++++++++++++++-----------------
 net/ipv4/ip_sockglue.c             |    7 ------
 net/ipv6/ipv6_sockglue.c           |   10 +-------
 net/mac80211/cfg.c                 |    2 -
 14 files changed, 49 insertions(+), 49 deletions(-)

Arnd Bergmann (2):
      cfg80211: fix cfg80211_beacon_dup
      x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()

Eric Biggers (1):
      ASN.1: fix out-of-bounds read when parsing indefinite length item

Greg Kroah-Hartman (1):
      Linux 3.18.97

Jack Pham (1):
      usb: gadget: f_fs: Process all descriptors during bind

Johan Hovold (1):
      PCI: keystone: Fix interrupt-controller-node lookup

Lars-Peter Clausen (1):
      iio: adis_lib: Initialize trigger before requesting interrupt

Michael Weiser (1):
      arm64: Disable unhandled signal log messages by default

Paolo Abeni (1):
      netfilter: drop outermost socket lock in getsockopt()

Shanker Donthineni (1):
      irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Stefan Windfeldt-Prytz (1):
      iio: buffer: check if a buffer has been set up when poll is called

Thinh Nguyen (1):
      usb: dwc3: gadget: Set maxpacket size for ep0 IN

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqWfPYACgkQONu9yGCS
aT4pWg//fUkbEO0m+wkq5plLxDfd9SLCLsjS81vr0KjcCjiX2xtjScx7qXjFnYvE
4DwQ2IofoSb7A5BqaH9lt7C33BFhLPu3huZlCJ3hzEyhMiKKKrGom28GJEo06s4b
tam16GdhSlqa0mSFsI6cibWofFxA2e7dkFDgv0sqml1GJvNVtXfzuO33jN4uTnsN
mbUjh4Rcf629qsQhmwkoGTAqhYrN34UTahw3aaQmbC2hs8YfxvB1Wo4EpQ5Qpqso
eQa8YvXRkvO+TNnKJ2d09BY9sgui8kYnFAUfTuah36LgpN2SGxbzZ3VnD5AK1IWa
+uPn3NCICbbllThG5LNwOUP/Gfjf2xzqb/YcIXfS/Zss3a4TZxWuLo60saEcvVAA
52jMuSAu/XQa32G4AEjv7kbyGIaGNdGejmAOdin2oKRZXiP1H0rJHWiBTz2cAVEu
0ea51J14rfVC5JO+OKVhEEz3Z9PEmrqokj8ZYbsyTL18VzaHIZ4j634gIzUqG1sB
U25KAdUe17mdeKcKPShTON8Hi0+6SfHGjHF8H+wRckVo/Yk9KngucTJDOKZUh4LG
w7v6+n80XeWXB80haN7uJNbs8TtvEG2q/eYQ2oUMGLpTZzN3aKdCCZDO5tdECDGZ
c14bZUguAdd58Jbwxj5KUXCRpa/KO8lhaOUB0dhAosDUH8zt2/Q=
=HRX1
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
