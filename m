Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F312CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42F620859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546863574;
	bh=XuR54kofSfe41nViEwtHJYTk3g6AQeE81rbqXUjrdsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D5M1vAg6csY0Gid4qTTIhh0cX0dXI/mBWcey66vNS0ML3lyCZreqs4AVIJ99IwuXy
	 sL3fnEmLXJJMpOGgD5sWRqv5B5FrmJIJ4gnqeAHCUiszqSxXemNP9DTTMI3WAgN3/B
	 nNOoZG5sTs7Ql8d1u8CqEu9CCoJbRmvbo2atxTRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfAGMTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:19:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48432 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfAGMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mTRi9Pl5JLCxr8HY4wKUQz1tplNueDdmmh1qoY0R5VI=; b=iHDVYYnKg3uMfe0WunA3iuCeJ
        KhQIp+GPGuJtjA6zRkYsVzmBQ/HIyWbp3PspXXx4GqBIqJHcZf9TJBq2uIxhujuXB9HHHG20NLGlK
        vNMi4JsJ6stnjpjP4MSIOH9MDOtrqP0zxjmKUO2fZ151jncbGSMS5v8Ca9MNdU1osuL20=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggTsK-0006gJ-JZ; Mon, 07 Jan 2019 12:19:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 209451127490; Mon,  7 Jan 2019 12:19:19 +0000 (GMT)
Date:   Mon, 7 Jan 2019 12:19:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Message-ID: <20190107121919.GA9570@sirena.org.uk>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-9-okaya@kernel.org>
 <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 12:15:35PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:

> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>

> Sinan, I thought you received an ACK from Pierre-Louis on this one, didn't you?

Yes.  I've also applied it already and it's *still* being sent without
either a cover letter or the rest of the series :(

Sinan:

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzQ8YACgkQJNaLcl1U
h9Dk3gf/VSotM7FP5LrgR8nnd8s0QCNxDaJNzQKDeK5QNqcuJTjFXHnueHbqQTN1
XTK8OXYLK8DYqVDYpv+3HAdYdb1p0U/oEZo1kDof0et7g3+HnWy5h09jWxjREbw9
GdAVB5B4muqL0O9iAXXGnk+nubHbVccT3Ksf3qRwxQk10ttkjUWiYEGu12B3d08U
0UmuzpXOmm3TUPvydt+myreT99t22YBTAXgYYR5uESOoFrB88yn+AFu35LNZD3mh
OgnMFAF5pXoFGAlP0FuLlmDbvW0Y5VUsUKe4iP9iWVK3wTt52bONrao5f98vl9hR
ydbZSx4dHQ5kMURR4qvl0PQzQc8e5A==
=HdFs
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
