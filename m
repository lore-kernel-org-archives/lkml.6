Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-415012-1525052059-2-540015688647690339
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
    1525052058; b=hypekdfbV93Bu+TLbB6bj2dzFGfX6dFJxafNATs30HfcH09ReP
    GBQ/g7QZvVFLoILScwMvNWPyW9sgeZaYMpX2iTZQFaf3qocZ3mKP7yy9Ov15KmQT
    R3YsGE5yTTXDxMUErueFy7PHb7wGq5bweSuTqbtaqCb16nP34ekgx6bprOCO8WiH
    /iFUUYp8aJWvDXQIqoPILnXMDM+XjXY3QIc2gB1o0hsJmZrdzITQPWOGAknXoAIl
    grjwQB8ygQe8Giq/SetwSVDT5fxs38SVhaatgIDKhSGtfbO28bMraRNIUlDDSvb4
    hOZsY5AQ02HIWw8HHyTEF0DSHbS7B+sT7g9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1525052058; bh=nh2W1l2q7LAHkLDrLi7zenRkrJy5TrucJOS7J5QPGLE=; b=j
    S4ppmQrv9OFTtHkbtoicSWvN6byuxO/tlGWfMbAwHa2qGAUXC2aTGgMGiukuNSzs
    QwwNu4jxj4BCROXPpWr30AjVjRhxauqMM1AVewsZuXrcGC084wzO4taa6fJjsMLT
    nOPMTOPr1ONhFUfGzaJEX7ySXAQcKjO9vvSCLN1wVJNrwdmHnXwdbQSs7agZ+vHJ
    OBAOg012zsvaW9h30AiE77FS7vYK9IQ4PQ+DCiB8FWeiNADidIkLL6zcgASa7EHO
    o8prDavBTFWyP6x1ggMQjssq/qD4d7zhINH7zOE9bEXvkW1tM5xO2lWeXVMoZf2u
    r9sUPSdKUxLFJx8rI7MCw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=h/193WvC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=h/193WvC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
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
X-CM-Envelope: MS4wfA0+1fn7rDCjNtA4f2JKPGbbaTJv6AMkxlGwv9aCAvhCKyE+yV1BA5EfsIipDiqE6hvOGK5F94IbRuqZn33Ka8P1VK0q+ssOh1kMpkHN6NZewVA9rqJP
    0V1EeW4xOUzltO4810ufSEm6oP4VeIgX589TD7V6LPiUVUVCpCF1GsLe
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=CXkk7yaifMICXdoo4J6eGQ==:117
    a=CXkk7yaifMICXdoo4J6eGQ==:17 a=Kd1tUaAdevIA:10 a=rOUgymgbAAAA:8
    a=pVKUQKkLIj9GLWeuXIUA:9 a=CjuIK1q_8ugA:10 a=se9pxHfz9KnIxSGZ2QIA:9
    a=MP9ZtiD8KjrkvI0BhSjB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 30 Apr 2018 11:34:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Sebastian Reichel <sre@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Johan Hovold <johan@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <20180430113410.6bb4d6ea@canb.auug.org.au>
In-Reply-To: <20180423130444.0672fb80@canb.auug.org.au>
References: <20180423130444.0672fb80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xSfrB86U=mtcPSt7kZNe/XK"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/xSfrB86U=mtcPSt7kZNe/XK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 23 Apr 2018 13:04:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the usb tree got a conflict in:
>=20
>   drivers/usb/core/hcd.c
>=20
> between commit:
>=20
>   63cb03f5c11e ("usb: core: split usb_phy_roothub_{init,alloc}")
>=20
> from the usb.current tree and commit:
>=20
>   bc40f5341741 ("USB: core: hcd: drop support for legacy phys")
>=20
> from the usb tree.
>=20
> I fixed it up (see below - though I am not sure what happens to the
> phy_roothub allocation when usb_phy_roothub_init fails) and can carry
> the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/usb/core/hcd.c
> index 0a42c5df3c0f,ac5bcf449d7d..000000000000
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@@ -2742,35 -2740,11 +2743,15 @@@ int usb_add_hcd(struct usb_hcd *hcd
>   	int retval;
>   	struct usb_device *rhdev;
>  =20
> - 	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->skip_phy_initialization) {
> - 		struct usb_phy *phy =3D usb_get_phy_dev(hcd->self.sysdev, 0);
> -=20
> - 		if (IS_ERR(phy)) {
> - 			retval =3D PTR_ERR(phy);
> - 			if (retval =3D=3D -EPROBE_DEFER)
> - 				return retval;
> - 		} else {
> - 			retval =3D usb_phy_init(phy);
> - 			if (retval) {
> - 				usb_put_phy(phy);
> - 				return retval;
> - 			}
> - 			hcd->usb_phy =3D phy;
> - 			hcd->remove_phy =3D 1;
> - 		}
> - 	}
> -=20
>   	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
>  -		hcd->phy_roothub =3D usb_phy_roothub_init(hcd->self.sysdev);
>  +		hcd->phy_roothub =3D usb_phy_roothub_alloc(hcd->self.sysdev);
> - 		if (IS_ERR(hcd->phy_roothub)) {
> - 			retval =3D PTR_ERR(hcd->phy_roothub);
> - 			goto err_phy_roothub_alloc;
> - 		}
> + 		if (IS_ERR(hcd->phy_roothub))
> + 			return PTR_ERR(hcd->phy_roothub);
>  =20
>  +		retval =3D usb_phy_roothub_init(hcd->phy_roothub);
>  +		if (retval)
> - 			goto err_phy_roothub_alloc;
> ++			return retval;
>  +
>   		retval =3D usb_phy_roothub_power_on(hcd->phy_roothub);
>   		if (retval)
>   			goto err_usb_phy_roothub_power_on;

This is now a conflict between the battery tree (since it merged the
usb tree) and Linus' tree (since it merged the usb.current tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/xSfrB86U=mtcPSt7kZNe/XK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrmcpIACgkQAVBC80lX
0GzdDAf/WjXrdToZ4UK8vTGS6o7BHrLkW8xYb2FGEszD6F5eQuoIh8sq4TDgvYoR
617ETKTpdICcS9/8EIpi7yZmoIyqPaIhYorlIq9ZVJUjsUpTrCf1pGmI5uDCi9SF
AI8Pd86A5nqtj7dvsxVl/AexElAF1P41wEGH4RaziC5Qfir7QBaLJRbdnqhbCkQN
r8sL7GrGfhXhjmsny+zUbw1BAdkZNV+iWk0jK3PTezcmCKUMj4gosbrHEDnK3bf8
H3dCr1Ek0NIW+u57P/WlvDkOo7/2kMhRsuk4g3Mm6UmJfB799O4D03tKffvj3/Oi
iguIUEnAG1wPrUc2qzUKCuJnKp7Ctw==
=y6qE
-----END PGP SIGNATURE-----

--Sig_/xSfrB86U=mtcPSt7kZNe/XK--
