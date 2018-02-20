Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBTLsD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:48:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeBTLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:48:02 -0500
Date: Tue, 20 Feb 2018 11:47:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Handle PM_SUSPEND_TO_IDLE
 suspend_state_t
Message-ID: <20180220114759.GB6378@sirena.org.uk>
References: <20180218170424.11976-1-hdegoede@redhat.com>
 <20180219113444.GA32761@sirena.org.uk>
 <5486ab34-4e5b-e2d5-9475-4d7e24a0cda6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <5486ab34-4e5b-e2d5-9475-4d7e24a0cda6@redhat.com>
X-Cookie: Don't read everything you believe.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2018 at 09:59:13PM +0100, Hans de Goede wrote:
> On 19-02-18 12:34, Mark Brown wrote:

> There are multiple callers of regulator_get_suspend_state() in
> drivers/regulator/core.c, I assume you refer to this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/regulator/core.c?id=57a0dd187956ea04870f4bbbf25a63c425ee7cad

No, he sent a second fix which isn't in Linus' tree yet, see my -next.

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqMCu4ACgkQJNaLcl1U
h9DzPQf8DUScJoIo2mnMBeZ0pXMnhb5YiHPic1PM5/k1IMYgSdtv0wcn46n1D4Uj
UpbH5GRedb+wJqmoQaR90Ikg/gbb5jK2spt7SELr40uDLxrkoNqPZIwS5Dc8xCgV
I/dXTaHuQQYxxd6velO6eDxM6TgDzJpjjfaUkspg6kFQdNFli/Qp1I8IXxST0dGV
Wi2UXy85esXbudcHa1pD5k1KWiwdfLe96uac+2R2hLLtx7BM6Ubbj/76kNc+4UMz
9KUfRXnIT/29GrxgJ246ZhvIxrCzCzoeoPdwe/F37rbNYAkgPEtbAsUtXLD8uRTG
8p/LROkLjW8covGtjwRN8ktrL5c2Ng==
=23EA
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
