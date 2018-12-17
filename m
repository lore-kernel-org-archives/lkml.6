Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC3DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C273320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545070047;
	bh=5CvlKTxSJQE7PBQ1tzNfRZvSU+xT5KLJV0M9I1io3Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qqTUw1tV+KnBKrvt9E5WN3bm9QjPFBKydi0+ZTn/g4TntdjCDPk1QbLB0plItHL/3
	 bAh488YUwlU6uoYNDWj9XGGv64wfJd7tL0qe3pf/hPZFeMGaupVniULu9D6kHfX7Qr
	 r/In+IGP6gRsc8dTcOCNpfR9DusLiVLFxIop9kxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbeLQSH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:07:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeLQSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NvzO7Jt2J71VWwp4ckGZUSO5+axIxWMXhTHZo3clvl0=; b=hY5PX+joidvjekir/U1XUH8vE
        DJebjVk0Sqjv7yq/dfnBfVm6w6aZ646tw+2sKtGB2bE1CAoVLm3vPfSerdHuZ8lTWIIBjHgsMyWKe
        35avtmBUfAWzwSGLowO4nGtTyufaoqOUcH5zHqjnu+0uxqAMM8qF7NVF3e4Hq9szfhAZs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gYxIY-00030K-L1; Mon, 17 Dec 2018 18:07:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1471A112593C; Mon, 17 Dec 2018 18:07:22 +0000 (GMT)
Date:   Mon, 17 Dec 2018 18:07:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        vladimir_zapolskiy@mentor.com
Subject: Re: [RFC PATCH v2] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181217180722.GG27909@sirena.org.uk>
References: <20181211140555.GA5872@localhost.localdomain>
 <20181213182026.GX10669@sirena.org.uk>
 <20181217084248.GC2477@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c7hkjup166d4FzgN"
Content-Disposition: inline
In-Reply-To: <20181217084248.GC2477@localhost.localdomain>
X-Cookie: Cold hands, no gloves.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7hkjup166d4FzgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:42:48AM +0200, Matti Vaittinen wrote:
> On Thu, Dec 13, 2018 at 06:20:26PM +0000, Mark Brown wrote:

> > I can't remember and can't find any record of any discussion of it which
> > is odd, might've been on IRC or something.  Let's just remove it and see
> > what breaks, since we generally provide the type along with the request
> > for the interrupt I'm not sure how often the default actually gets used=
=2E =20
> > Possibly safer as a second patch though in case there is a good reason
> > that I missed so we can easily revert it.

> So how do you see this - should the regmap_add_irq_chip read the current
> type setting information from HW and populate the cached type values
> based on the current HW configuration? (I think that would be corect
> thing to do).

Yes.

> >  It
> > does look safe to me but it's possible I missed something.  Equally it
> > only seems to be some quite old Tegra systems using the max77620 so
> > perhaps mainline usage of affected devices is limited anyway...

> Right. This makes me wonder if there is some other preferred approach on
> this... How other drivers are doing the type configurations? Why they
> are not using regmap-irq? Am I missing something? But what comes to
> changing the regmap-irq type-setting this is definitely a good news =3D)

I suspect a lot of devices lack configurability or have never actually
done anything where configurability would matter - probably the biggest
use of regmap-irq is interrupts internal to a chip where there's no real
need for that, and even where there are GPIOs I'd be surprised if many
of them were actually used as interrupts rather than dumb outputs or
something given that most embedded systems have an abundance of GPIOs
directly on the SoC which are much better.

--c7hkjup166d4FzgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwX5dkACgkQJNaLcl1U
h9Ajawf/bLgkFNQNov++KKeaj9gMIgTH7cuGQY+aj84B/u4u5iIiKAxPCz/2eCHb
ga4j13Obe9XmECOgDJSY9tNoaKj1n2GK0He/aH6NhHqhH4heBzJIFPXkLVnush3v
kPEiaShENPZ0vcI0nWNYLcRZvPyJ3PcWjow2KtHSWvhkWz7Up3e5tcHO46UUYkp8
QXrP04KPaL3vNw7rJ3givqBt7NFR6912FrkgBE+oTPFjsKXhtxyOSNNWhoMyA0Cu
YQmEJxUKtVaAXyEwlRjpE10nV+fbY6Bu3wyOgJ83EYnpwNgCuVeYFYIcLc5Z5rCr
c8965kc6UrnaHP1dJ+WdEOPr9ldGzg==
=E7ya
-----END PGP SIGNATURE-----

--c7hkjup166d4FzgN--
