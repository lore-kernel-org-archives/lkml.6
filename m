Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A9C2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfADArH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:47:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:5420 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfADArG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:47:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 16:47:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="asc'?scan'208";a="123123136"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2019 16:47:05 -0800
Message-ID: <7cee52e8e94f79cf684449e817ac8fb2efad6573.camel@intel.com>
Subject: Re: [PATCH 3/8] i40e: increase indentation
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     David Miller <davem@davemloft.net>
Cc:     Julia.Lawall@lip6.fr, kernel-janitors@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Jan 2019 16:47:04 -0800
In-Reply-To: <20190103.163716.1927360927242144906.davem@davemloft.net>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
         <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
         <2320c3ac2267d17ee9fc9ff3e3df60b7ca405590.camel@intel.com>
         <20190103.163716.1927360927242144906.davem@davemloft.net>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zP/iw+GMlNQc84qdQTty"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zP/iw+GMlNQc84qdQTty
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-01-03 at 16:37 -0800, David Miller wrote:
> From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Date: Thu, 03 Jan 2019 15:58:10 -0800
>=20
> > On Sun, 2018-12-30 at 16:53 +0100, Julia Lawall wrote:
> > > Convert spaces to tabs to get correct alignment.
> > >=20
> > > Found with the help of Coccinelle.
> > >=20
> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > >=20
> > > ---
> > >  drivers/net/ethernet/intel/i40e/i40e_main.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> >=20
> > Dave, since this is apart of a series, please feel free to commit
> > this
> > patch with the series.
>=20
> It's kind of net-next material and therefore would need to be re-
> submitted
> anyways when net-next opens up.
>=20
> Alternatively, Jeff, you can toss it into your -next tree.

Ok will do.

--=-zP/iw+GMlNQc84qdQTty
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlwurQgACgkQ5W/vlVpL
7c5XFw//QHqoRMuaKBGyyk//SA4/4McnD1eHjSxVJWYBJmoVfiOl4ojHdIfiMD8A
2KJlDO+jadAsQwR+qXJIDAhD4h7y/SrW/7g4E4y4sDdHuPd7XH+R5Z2QeSkTVlpZ
CY2wTuHndf+dPknuQdw251XPY0ZKfNr16pLzcb7yBH1AE2FNOTxhLjlt5WPdoFRl
Zle5fDMVnDSRYvO6vukzLHfJPbaMxYdTJix2xQJPwJDrfCiKYC8ViwcOL1DH2DCy
yB4ObTMAbOQ3qsN7T1ldSKcDDNKa+sM3OVkwuzRuFpW40nOx1TN6itmqINcJmfeD
+mvfSApUg1PQXZ0RCLfIM1GEAzwIPH67PLIE/d94TSkVXMhPmhdVqwwUVAtCOiag
j0MRrJFWLS7h6V2OqGOfYa8MnaTGYc3TJychvvkllAj13FnSRkcr5vTtZwXU+d06
uKSO43bCf6yHkcaqp8ym/JKVYggkZfgTPKU8s6kP3gF3Q1Vtu5QDf6j1Wb27NYB5
5LmwwIm6r5u18T7/Bk5opsSl1BFfI+4txXpjzjCNuKcRPN5lcSAdVpNCmWpOW7wc
yLWTCxmgtQFWAHSLkEjbiOrXYr3a5XWYfC2cvb6YVSnWPbv6vtZD9SSxG/zzdDsy
QnsZIE/HQTYNM5Edkso9gwksJghpH5mNYegsTpE2sQvWRSQ5E2g=
=bwOk
-----END PGP SIGNATURE-----

--=-zP/iw+GMlNQc84qdQTty--

