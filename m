Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F8AC282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF5E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfAUHaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:30:25 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:39309 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726630AbfAUHaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:30:24 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43jjrG01NRztc;
        Mon, 21 Jan 2019 08:30:21 +0100 (CET)
Date:   Mon, 21 Jan 2019 08:30:20 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] doc: networking: integrate scaling document into
 doc tree
Message-ID: <20190121073020.GA10146@personal>
References: <cover.1547843156.git.ottosabart@seberm.com>
 <3eddcfcf3916ef8e89230971359fc9b6bef35d20.1547843156.git.ottosabart@seberm.com>
 <20190120191359.41e5de0c@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20190120191359.41e5de0c@lwn.net>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20. Jan (Sunday) v 19:13:59 -0700 2019, Jonathan Corbet wrote:
> On Fri, 18 Jan 2019 21:38:32 +0100
> Otto Sabart <ottosabart@seberm.com> wrote:
>=20
> > Convert scaling document into reStructuredText and add reference to
> > scaling document into main table of contents in network documentation.
> >=20
> > There are no semantic changes.
> >=20
> > There are no references to "scaling.txt" file. Whole kernel tree was
> > checked using:
> > $ grep -r "scaling\.txt"
> >=20
> > Signed-off-by: Otto Sabart <ottosabart@seberm.com>
>=20
> So this didn't apply cleanly to docs-next due to a conflict with
> commit d96bedb2b248 ("doc: networking: add offload documents into main
> index file") by one Otto Sabart.

Yeah, .. I always just checked if it merges cleanly against the Linus's
tree.

> I've fixed that up, but in the future it will be helpful if you can be
> sure that your patches are against the docs tree if you want me to
> merge them.

Will do. Thank you Jon and sorry for the merge conflict.

Ota

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlxFdQkACgkQgjuumfi+
Hjy22BAAg5Dr+yuc8g/4NcxpMWe17kK6wxywsH75zTvAiKlKd82Qq3be8jF6KyvA
4X0/DsiPl9CSEkEu0S7SNQ0cESwl3IH3mqRXcICUC2HSBmOPdqjftPZ0pj0LdBlm
3FrlFgHHy+S3tkDPUfGbo24/W50JmYmWldtXR/3/RuuDtcx7PKz1Gcwx/FQ7Icq/
nABm62EGgmODsZpzRSFb1NchbOpFWb1RbnRkEZI0uSJHI1GNbPhvxOnNNZnAdQ8Y
ePd6K9IeTWMQ+lQef1WhDL+p8j2XgdnLpFQErTG3RQP4xTRLugFnSxYmyeTSg7nd
vO6ZFa2WnlCoysEAb8paAi/cHGE+k13R6GPcYvtOWbjmkcXWjifSXwRN+rod5r+1
C4JHbbjyJSTtHPvKc8clP15PTMELO92yHV7ar/2SjpaLBVGM6vvT4fyfQafZxuws
ffSS6nt14rNKfaxFhyQIDH4Kzg7OCAIFtDrwNoaznP6gGwvLFLaW9KU2R0amH4+k
Srkxudf7wyLE2AsTa69fjdRNtiuRyD1BlMvDr+J55MsCDZdIdM/eaPTBa7gsei02
VMwUG3gpcHmVR4CSloYAU0dywQ0oFuqQCXsPMM+8S8PfGpfbEdRZZrD5+TP8bUfV
m91ueO+0qZ2nJ7t38YWQLSf9wQ+4aS6Txn4btNtDkct2tGKmGNo=
=mwlX
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
