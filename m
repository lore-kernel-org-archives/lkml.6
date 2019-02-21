Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE253C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC46F20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550742175;
	bh=FYAXL+K2KvKYO/yqFWM66tEPVI4M6pYljFbYvVPdwCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T9dLTd1iM+h3/gKkRWdCvvjdG83UPQ6VN7riMrnwy/15iRsDtVrL+YDdsS6aDS4JM
	 KAZtaQzzAZaomoMnJYxdgqV6wlsp5O4FlFzqU60gwZyioJHxAwjIOexpuZ1g7eJPMG
	 yJwBHE3Nt/Dcqxxy0f37lRFRn1wgOFzh406iaZcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfBUJmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:42:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfBUJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fLyItT/z5/2XZidaZ8wic/LJLjAqhGtq2LlqcBV/L3A=; b=kGb5WpPP4aOnwI9kwYU0eNuUU
        oO7JK37PMe0KsdXPTd4ztM++g8g5OJPu3fF0QE1Ssvnw/yJKUUKeKwtY2F0wYAX/C5EEm6SVNRrxv
        yZDHOeY30KSX+Z7fTeCUOfZU4opA47ovh+iRZGwTQugQVpBLewD1dfrllAepO++yiDlQc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwksI-0002Iu-Bm; Thu, 21 Feb 2019 09:42:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 64D9B1126F2B; Thu, 21 Feb 2019 09:42:37 +0000 (GMT)
Date:   Thu, 21 Feb 2019 09:42:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Olliver Schinagl <oliver@schinagl.nl>,
        Chen-Yu Tsai <wens@csie.org>, Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS
 defines
Message-ID: <20190221094237.GA5970@sirena.org.uk>
References: <20190220165013.12774-1-axel.lin@ingics.com>
 <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
 <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
X-Cookie: Garbage In -- Gospel Out.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 08:22:53AM +0800, Axel Lin wrote:
> Olliver Schinagl <oliver@schinagl.nl> =E6=96=BC 2019=E5=B9=B42=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=886:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > On February 20, 2019 5:50:13 PM GMT+01:00, Axel Lin <axel.lin@ingics.co=
m> wrote:

> > >The AXP20X_xxx_START/END/STEPS defines make the code hard to read and
> > >very hard to check the linear range settings because it needs to check
> > >the defines one-by-one.
> > >The original code without the defines is very good in readability
> > >as the meaning of each field of REGULATOR_LINEAR_RANGE is clear.
> > >So I suggest to get rid of AXP20X_xxx_START/END/STEPS defines.

> > Are you suggesting that magic values and hex numbers are more readable?

> For example:
> static const struct regulator_linear_range axp803_dcdc234_ranges[] =3D {
>        REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
>        REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x4b, 20000),
> };
> Above looks very clear to me as it describes the linear ranges:
> 1st linear range: min_uV is 500000, from selector 0 ~ 0x46, the uV_step i=
s 10000
> 2nd linear range: min_uV is 1220000, from selector 0x47 ~ 0x4b, the
> uV_step is 20000
> And it's easy to check the min_sel and max_sel in each linear range.

Frankly I tend to agree with Axel here - the defines are used in exactly
one place so their main impact is that you can't read the ranges
directly in the array but have to jump around to read through the
defines.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxucowACgkQJNaLcl1U
h9BGHwf/Q+ifyezTt87Xs3xlYSMNusmi3EIumBSCRu65XFMH1MM7qA/xGCQCcWF0
4k/0iSwQbo7wbHwdsDaptxPk0sOflhgKNwlO3Lm+R33MbO6JH2Rn/ARamzeipI8T
guPQ+QrlMy4GFlAfufnWZOf7hqZh6JEpWw5N5q23swZ4ELlLFkLydRI4jk2SuCkT
KMfjYE/ylYcECaHCtbClI8ixZVz8HaCjI0UyoAkGUy04XA63IxOkNRRYxEtzhNNr
iZrZvoRwC+RWtkE71Vags0O4lARbwn2Y8NZAZHFUj7Qk0D9N5uxD/kYxQIKPpcOo
7aVK9oPOKbFMmeR2B/9iu93d7f5IMg==
=Ia8M
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
