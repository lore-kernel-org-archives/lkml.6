Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-1376423-1526529807-2-15784555964592789536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_05 -0.5, SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='203.11.71.1', Host='ozlabs.org', Country='AU', FromHeader='au',
  MailFrom='au'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: sfr@canb.auug.org.au
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526529806; b=G4VbLT78RNDH6F1QzIN17LbmYhdaEwgW9r3JRL+VIXH+WFC478
    8JeF+rKQl4hvP+C9grMDDxRU5kdIhlPiZLeddwMXqmCbVQpKiY/ULGniYQBVD4pr
    /H4dhNzQY31STP0uhZywXLtogLj6tAynjdt7S+J6Xz97KrTbChOmlApDcuH0j7a3
    /5/O7Mb6+nYc+gSlzYPWkV9zz+VX8CXFDTAm7dh/8PFv3i2fhZfxgHQv2JgrNZQO
    K/3NsV0vjkSZTD4q/e6feaO+RVUfEaL0uhbglny+HBCB2+EW7PcV3Yg88fMHl27n
    V+csbJoOgmlMAjusdvzoKQtw8Gr9dKW3OHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=fm2; t=1526529806; bh=gUD1Jic6OL/b
    XJNIQPoR5F6qB5QgpNDRtDgVwSZauLU=; b=lKsq9dOGyiK7pzyS2COTTiizTRUO
    W43cUv2s/tIcT5fOKFuyR1xt/3iBgqjnlkUgVOLG390dkVofizGNdWNfJqoA+vfC
    Wj3Y+1e5lQ7SUvLMUVPvAkM7hzqhThSpNq68jmEx8yikNR8N1r+pGBXMEb3HiKpE
    hGwBoY3kMy1qnHqPcdo6PqDZHHSG0MDRutooD7CHz+mlXJ5ByiGFgdB+f7veoRkw
    XyEuPwfQNhtfH4aWz/9J0QbnOu/AGuVPRvOjJivhOtafEDWvcDeoSjg1G1Nmgdkf
    Xg4zSl+n/3hHAb/rTbPGsY3LrnqJuFbUCYZXwI65Zo2A6el67ZR8ImNeKA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au
    header.i=@canb.auug.org.au header.b=G+55msiM x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=203.11.71.1 (ozlabs.org);
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass
    smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canb.auug.org.au header.result=pass
    header_org.domain=auug.org.au header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au
      header.i=@canb.auug.org.au header.b=G+55msiM x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=203.11.71.1 (ozlabs.org);
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass
      smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canb.auug.org.au header.result=pass
      header_org.domain=auug.org.au header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDVaFNWL38m/foPe6aMxRXJVtOEjzKNdSETK1B/SLTKf5jJS7Hs9rOGibNvQ35tMaJxgaIlrG+DFwcNI770KO2nn0izK+Hti/rSeE9JuxtR3aQ3TShB/
    P5hdy0RQZgu1ZmAcSEHMmdo8ieYR7yK4zNZYm8RX6ziT5OotcQyv/LuR
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=CXkk7yaifMICXdoo4J6eGQ==:117
    a=CXkk7yaifMICXdoo4J6eGQ==:17 a=VUJBJC2UJ8kA:10 a=g7oqwkL-bcPgGnW_UlcA:9
    a=CjuIK1q_8ugA:10 a=ysR7nVTyFsXTbVGHr-4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 14:03:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Felipe Balbi <balbi@kernel.org>, Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: linux-next: manual merge of the usb-gadget tree with the usb tree
Message-ID: <20180517140318.5333cfee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GHBthan.XRFrE_er1L8LppO"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/GHBthan.XRFrE_er1L8LppO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb-gadget tree got a conflict in:

  drivers/usb/mtu3/Kconfig

between commit:

  cd91a0e9d38f ("usb: Remove depends on HAS_DMA in case of platform depende=
ncy")

from the usb tree and commit:

  f39846824cd6 ("usb: mtu3: make USB_MTU3_DUAL_ROLE depend on EXTCON but no=
t USB_MTU3")

from the usb-gadget tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/mtu3/Kconfig
index c0c0eb88e5ea,8daf27768888..000000000000
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@@ -2,7 -2,7 +2,7 @@@
 =20
  config USB_MTU3
  	tristate "MediaTek USB3 Dual Role controller"
- 	depends on EXTCON && (USB || USB_GADGET)
 -	depends on (USB || USB_GADGET) && HAS_DMA
++	depends on (USB || USB_GADGET)
  	depends on ARCH_MEDIATEK || COMPILE_TEST
  	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
  	help

--Sig_/GHBthan.XRFrE_er1L8LppO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr8/wYACgkQAVBC80lX
0GwX+AgAk5TYGQTl+ddjehL+H1fCjGhOZSZnjhEICH5D6h5t8R9ahMScfterLTqy
c84SAJLY2p8HP9Vh+4w45FQtQvCpp5uZrypRRyC36smwgPuC5qP16JAwPl3cj50c
qwTwlTFj0OCyAFpoYQGJfHaohqT7ejBAxGqztHpmQVc7Gga8cPVQzoNMFJE/YXX0
exMwAt5119n7V+O9uXrgBLzkXuIuyOcBqSe+84YVNOysW5UxpsIwDCiCDNVw4YfB
7QGGk/fXa0q6euKJHBvG+ACe3xmul9z4u9f37KrbR0F8LlUYAROgdLGV74IKI89T
nO8nSBBAVyITfqC5XHH06KZdYJNi2w==
=1QUg
-----END PGP SIGNATURE-----

--Sig_/GHBthan.XRFrE_er1L8LppO--
