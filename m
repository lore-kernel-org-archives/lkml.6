Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14291ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DE1208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DE1208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeGMH7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:59:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50323 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeGMH7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:59:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E64DF20731; Fri, 13 Jul 2018 09:45:50 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id B94EB206ED;
        Fri, 13 Jul 2018 09:45:50 +0200 (CEST)
Date:   Fri, 13 Jul 2018 09:45:50 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output
 on Banana Pi M2 Zero
Message-ID: <20180713074550.mna4nqbjringf2xn@flea.home>
References: <20180711132233.42301-1-icenowy@aosc.io>
 <20180711132233.42301-2-icenowy@aosc.io>
 <20180711150532.6gzm7krouriddreh@flea>
 <8F6CDF5C-2AC1-43EC-858A-5C6345CF279A@aosc.io>
 <20180712064601.m3bdd46wzac5fpgh@flea>
 <A7CA2831-7117-415C-BC59-3FB4AE425598@aosc.io>
 <20180712145306.ootqt7dfh3nxsamy@flea>
 <82CD0BCE-9DE4-45D7-8DF4-FCCFBC70BECF@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m4qdj5cmxwskf2b4"
Content-Disposition: inline
In-Reply-To: <82CD0BCE-9DE4-45D7-8DF4-FCCFBC70BECF@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m4qdj5cmxwskf2b4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 10:28:08AM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8812=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
10:53:06, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Thu, Jul 12, 2018 at 03:09:55PM +0800, Icenowy Zheng wrote:
> >> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8812=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=882:46:01, Maxime Ripard
> ><maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >> >On Wed, Jul 11, 2018 at 11:15:50PM +0800, Icenowy Zheng wrote:
> >> >>=20
> >> >>=20
> >> >> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8811=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=8811:05:32, Maxime Ripard
> >> ><maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >> >> >Hi,
> >> >> >
> >> >> >On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
> >> >> >> Banana Pi M2 Zero board has a miniHDMI port connected to the
> >HDMI
> >> >> >> controller of Allwinner H3 SoC.
> >> >> >>=20
> >> >> >> Enable the HDMI output in Banana Pi M2 Zero device tree.
> >> >> >>=20
> >> >> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> >> >> ---
> >> >> >>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25
> >> >> >+++++++++++++++++++
> >> >> >>  1 file changed, 25 insertions(+)
> >> >> >>=20
> >> >> >> diff --git
> >a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> >> >b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> >> >> index 7d01f9322658..eb61dcf32797 100644
> >> >> >> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> >> >> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> >> >> @@ -26,6 +26,17 @@
> >> >> >>  		stdout-path =3D "serial0:115200n8";
> >> >> >>  	};
> >> >> >> =20
> >> >> >> +	hdmi-connector {
> >> >> >> +		compatible =3D "hdmi-connector";
> >> >> >> +		type =3D "c";
> >> >> >
> >> >> >This is not one of the connector type declared in DRM, how is it
> >> >> >exposed to the userspace?
> >> >>=20
> >> >> So just use "A" here (because of single link)?
> >> >
> >> >If the connector type is C, it should be C, and DRM / driver
> >adjusted
> >> >to handle it.
> >>=20
> >> Okay I won't change this property, if there's any further revisions.
> >>=20
> >> For DRM driver, I think it can be an independent patchset.
> >
> >Not really, since it's going to break userspace as soon as you merge
> >that other patchset.
>=20
> Should we bother the DRM maintainer to ask for any advice?

You can if you want.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--m4qdj5cmxwskf2b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltIWK0ACgkQ0rTAlCFN
r3RzMw/+NOkagve5cYYwxlSLdNY9jj3qM5FjCUr/TmXaI0Nt6pTkex/h/leNZzQn
+sudTr+MqPSsvvlHFSJYHPBB/rvWLbIm2VJmv6dZityvXag24GPN0B+yz1V0fjs2
Z9pNembUi6dc09AjqPU9JJOG5pDok2ve4xMk9l4wOKkLUIiWiyCm31zWuivBGpmN
KkvbzDtRIsmUX6ECusEtBQbmaSlqr7HoAdfepahqo6Be7IeGuL6RyFip7ys4VHAR
VZ0eWogahg0tFAXGGCtfjuG5CojTuw92AF89LzbXq/5YzEuJoyZJ1l547qn+fhVH
TCSTAwvBmRPyQAprwGndcmHSiYeBp1bdIcBUVncLHBiRbtaC+y8xd72d3OAHMd81
4QF5SNXuFmegY3EelXCbfoZaMXewZEwvBYKRKbHUS/NRpf5s1P7+5y5RKDRQtFq7
VwDCb2NW1Z4ettMyELMgVi1ubt3essug701dg3BpwEiG/mROb/TDC5cNo9Ob2BwN
Nu70XyNZ4prVjYEPLuwjmivniJGndj8R1CHBPYYt7l/zE6qQEDnGZ60NCPn6ISWU
5FIfi1oveUX5a0iiFBjeq3tPg0hc9Ehy8mVdd3EH7C/hzFBpZRROTWfYx83fTOEe
+cn4IQG8MM2ZPXw0By77wGaiX8IGuul5yb7pUoVXc0z74gFnoF4=
=rPGU
-----END PGP SIGNATURE-----

--m4qdj5cmxwskf2b4--
