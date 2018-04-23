Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-4160759-1524452802-2-2014999605545141765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='203.11.71.1', Host='ozlabs.org', Country='AU', FromHeader='au',
  MailFrom='au'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: sfr@canb.auug.org.au
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524452801; b=Pg49QE2Bgf1f1UavOb1L3OrED3vzjKZM4LFElQLVJy0Xk9atml
    sc5rFZ4RBibGEjsgHFjlDQ3VD6zPROOrHz8TSiqZEDCziBEU8xpUJ2cOF9AT+inU
    oduxV+4wsvr0KSlGO9WUlbA/XDLZBN/4kZQ6A18sImiVYT3y2EMY5CIbxmf2He7k
    8DvM2ClnhAKCSKIHokETSjMzF/YJ4p+iQV7+kiAyU7crMnpbLi+SPlSAdSIVt0DT
    sSphxlAT4XEVjRnS4gCfLmu6N9phYSCvkrHZL1e/uShV7DNoADszQz/ySGMHbenP
    n85gLTEF9Cwt1v5onz98Z0I11H0FBVDcI8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=fm2; t=1524452801; bh=O5gyYG8a7WFx
    X+X47zlpBpmez+emgtsk63Db840FVhQ=; b=pcRxxQXkJlkJ17L27tO33+fg9nzK
    W192dFmcadhgNFkdQ/+VMCdytVfuBZVILEZERNpigaW4RZptmlsOT9zazXhO06dt
    /kkuzVubj+BkgvKm4m47wBa7Cd3V7edqogbtT0beNcbgeGTwKDQ6KS2DBjEKXUSS
    GKnmAZfDCXOOZ9fx5GIpeqaVnAJUgHOdRF/QaSnRtAnE6BSaisF+3spzlJTsykXu
    zrh1200Wnb1r/2wuaSumuAHvK7KM3SF+U8PbX3pS29f9bw3iYi5ZX/si5ERbAPzn
    dy0jKUkq2SHs0Cda2H19I5R791vbWsgCVdJJCFBZCq1u5eOeaC+dQ1a68Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HE/G17Ce x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=203.11.71.1 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HE/G17Ce x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=203.11.71.1 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPEVupHClNEP9EqQ/IH439XvHZtFlhlqp9d+JsVwlhp6cRCZAlZFfDtBhB95/bAEuheqDiw6BGaoqR+sIhdJSyhWkBHe1u7fYxhmN5rDOtQp2Nd54H23
    04rQIlG4Ys7KsB0io98jQRXP/al0AaznVYfDZr/lUG/24xjcdGyLkbDe
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=CXkk7yaifMICXdoo4J6eGQ==:117
    a=CXkk7yaifMICXdoo4J6eGQ==:17 a=Kd1tUaAdevIA:10 a=dyw2DOiuXS-uF6Cq8gwA:9
    a=CjuIK1q_8ugA:10 a=j2s68wSCXsb9u0Pn6IoA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 23 Apr 2018 13:04:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Johan Hovold <johan@kernel.org>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20180423130444.0672fb80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uZ5j=z4kN.lWQG5GAv0C5jt"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/uZ5j=z4kN.lWQG5GAv0C5jt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/core/hcd.c

between commit:

  63cb03f5c11e ("usb: core: split usb_phy_roothub_{init,alloc}")

from the usb.current tree and commit:

  bc40f5341741 ("USB: core: hcd: drop support for legacy phys")

from the usb tree.

I fixed it up (see below - though I am not sure what happens to the
phy_roothub allocation when usb_phy_roothub_init fails) and can carry
the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/core/hcd.c
index 0a42c5df3c0f,ac5bcf449d7d..000000000000
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@@ -2742,35 -2740,11 +2743,15 @@@ int usb_add_hcd(struct usb_hcd *hcd
  	int retval;
  	struct usb_device *rhdev;
 =20
- 	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->skip_phy_initialization) {
- 		struct usb_phy *phy =3D usb_get_phy_dev(hcd->self.sysdev, 0);
-=20
- 		if (IS_ERR(phy)) {
- 			retval =3D PTR_ERR(phy);
- 			if (retval =3D=3D -EPROBE_DEFER)
- 				return retval;
- 		} else {
- 			retval =3D usb_phy_init(phy);
- 			if (retval) {
- 				usb_put_phy(phy);
- 				return retval;
- 			}
- 			hcd->usb_phy =3D phy;
- 			hcd->remove_phy =3D 1;
- 		}
- 	}
-=20
  	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 -		hcd->phy_roothub =3D usb_phy_roothub_init(hcd->self.sysdev);
 +		hcd->phy_roothub =3D usb_phy_roothub_alloc(hcd->self.sysdev);
- 		if (IS_ERR(hcd->phy_roothub)) {
- 			retval =3D PTR_ERR(hcd->phy_roothub);
- 			goto err_phy_roothub_alloc;
- 		}
+ 		if (IS_ERR(hcd->phy_roothub))
+ 			return PTR_ERR(hcd->phy_roothub);
 =20
 +		retval =3D usb_phy_roothub_init(hcd->phy_roothub);
 +		if (retval)
- 			goto err_phy_roothub_alloc;
++			return retval;
 +
  		retval =3D usb_phy_roothub_power_on(hcd->phy_roothub);
  		if (retval)
  			goto err_usb_phy_roothub_power_on;

--Sig_/uZ5j=z4kN.lWQG5GAv0C5jt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrdTUwACgkQAVBC80lX
0GyJzAf/XsUbMyl+PGcUI17TBq5diJZcAjTPPJTiNKzHhAWLKXLqSZTZ9dla/a0s
jI39LaS18lIn0Jl09AMS63DfEVIAFWMCeW9iscrYPad1GyMhpc4dcw7eWKUZDDNn
kNx7+jfvUbCP/zTe0yLg+jStne8CwLSGVoH2Iglq54NRS6W0vaMkQuC0L+ZoIrXf
JaV/kHVrfztlOlXQ2DM5jVriCBzdjncnUT3KS80blbBYYtBtneGK6BzaWzQqRo2L
DthjGkOc/ozgkWoYvxEq5qfq4hHlpQxk77q8XRS4qtmmlRRDzuRGIRidYiis+lO3
mFEywEQlAKOzx4KRW7nPVZe4mZMnjw==
=LjKn
-----END PGP SIGNATURE-----

--Sig_/uZ5j=z4kN.lWQG5GAv0C5jt--
