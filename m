Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D86A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544188466;
	bh=CCVFTWWL/YgAq4iGp1T8piy/vpCY/l/Geb4kQAGsMTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zIiL78P2qC5CAc3uH688H2FFIYe/GZlrEIXU8Gy5oO3Yfag/FGvFCz2cMqzKASelG
	 XrwU0T9D9Do7J94gqPEtwJ2q2HtHynNiF7AZg0s8FIKVQYKVjGrZMfiKSKNEOWgbte
	 +O7r86rdlRuyXuhIGsiufktf7rbo5wnZ4lsOaCXY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D86A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLGNOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:14:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34044 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeLGNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Upfsh2ISMrxgIWIY+1n7+VcOCg+DGiiuqer2zsX05sE=; b=lgm93w8HxBPNB8PBIEHT5DXlZ
        x6MHkVtnv5hvJ2omdaYtaFlonmf3Z5hil0YtzcGqWKs1yL6yvO8mw2Fdj01kB1nGIHyky4CqguhgJ
        mDh5A6TXL14xvIOgOnhp5WE59aQP1JcdBkSXk3lK4SKmDkN/gEsmRVXxoifD1Pi3U4Fh4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gVFxS-0003dN-TK; Fri, 07 Dec 2018 13:14:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6A1EF11253E4; Fri,  7 Dec 2018 13:14:18 +0000 (GMT)
Date:   Fri, 7 Dec 2018 13:14:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181207131418.GB6510@sirena.org.uk>
References: <20181130085908.GA24983@localhost.localdomain>
 <20181204172137.GE6809@sirena.org.uk>
 <20181205082251.GE31204@localhost.localdomain>
 <20181205172701.GH6205@sirena.org.uk>
 <20181207075829.GA24940@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20181207075829.GA24940@localhost.localdomain>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 09:58:29AM +0200, Matti Vaittinen wrote:
> On Wed, Dec 05, 2018 at 05:27:01PM +0000, Mark Brown wrote:

> > If they're full subdevices you'd be pointing at the relevant platform
> > device anyway.

> I am not sure if I have explained me well enough =3D) When we look at
> regmap_add_irq_chip we see that it creates the IRQ domains. And we
> further see:
>=20
> 		d->domain =3D irq_domain_add_linear(map->dev->of_node,
> 						  chip->num_irqs,
> 						  &regmap_domain_ops, d);

> where map->dev->of_node points the node added to regmap. And as we
> really want to use the i2c to access registers, we should have done the
> regmap using:

> devm_regmap_init_i2c(i2c, &regmap);

> where the i2c is the struct i2c_client *. The dev in i2c_client is the
> i2c device - which has of_node pointing at the "main i2c node" - not the
> sub block nodes. Hence all irq chips created by regmap_add_irq_chip for
> this physical i2c slave device will point to the same DT node.=20

Hrm, right.  You'd need to have a proxy regmap for the child devices for
that.  Not ideal.

> 	bool mask_writeonly:1;
> +	bool no_of:1;
>=20
> and in the regmap_add_irq_chip do:

> 		node =3D (chip->no_of) ? NULL : map->dev->of_node;
> 		d->domain =3D irq_domain_add_linear(node, chip->num_irqs,
> 						  &regmap_domain_ops, d);

> Then we could have chip->no_of set for the 'main irq chip' and for those
> chips we don't wan't to expose via DT. In my case I would leave no_of
> unset only for the irq-chip which I created for the GPIO? Is this a
> silly idea?

That's worth a shot, yes - I'd need to see it fully fleshed out I think
but it looks sensible (no ternery operator please).

> > The mapping isn't guaranteed to be a 1:1 mapping - one way this hardware
> > gets structured is that the central interrupt controller is saying which
> > IP block is flagging an interrupt rather than which register has an
> > interrupt set in it.  You can then have either more than one detailed
> > status register for that IP

> Correct. But I guess the IP blocks often have limited set of registers fo=
r the
> "sub interrupts". For such cases my idea would work, right. My RFC
> handled case where there is many 'sub registers' to read for one 'main
> bit.

Your idea definitely works for the current case, yes - I'm just thinking
about future edge and extension cases.

> > or several smaller IPs reporting through a
> > single detailed status register.

> I think that if we have more than two layers of irqs (main and sub) -
> then we should do cascaded controllers.

Yeah, and my first thought here is that we should just be using cascaded
controllers all the time (but like I say I'm not 100% certain on that).

> > Right, it's about working out which subregister to read - the point is
> > you can do this by adding a link in either direction, I'm suggesting
> > doing it from the individual interrupt to the main register since we
> > already have individual data structures for those and it feels less
> > likely to run into hard to represent corner cases.

> I see your point now. But as I said, I am not sure we should add the
> overhead of 'main irq bit description' for simple cases just to cover
> the corner cases. Yet I can try seeing what I can come up with if you
> think this is the way to go.

If you could take a look that'd be great.

> > >  * @main_status: Optional base main status register address. Some chi=
ps have
> > >  *		 "main status register(s)" which indicate actual irq registers
> > >  *		 with unhandled interrupts. Provide main status register
> > >  *		 address here to avoid reading irq registers with no
> > >  *		 active interrupts. Mapping from main status value to
> > >  *		 interrupt register can be provided in sub_reg_offsets.

> > > Perhaps this would clarify that the status_base, mask_base, ack_base,
> > > etc. should still be used normally?

> > Probably.

> I am not sure this means I was able to convince you or if this is the
> polite way to tell me not to bother =3D) I am Finnish guy who does not
> understand small talk or polite hints ;)

I mean that probably if you add clarifications like you suggest that
might do it.  It's one of these things where you can't 100% tell how
things will look until you see the actual thing.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwKcikACgkQJNaLcl1U
h9BkrAf8CFu+3ZdlY/D0Fwi2KgBBLx48NDOIXLhucgnWPEAvYDjVuivkCa7HGjTi
o1/CZD8lxTUwHM35z8QbtnrELQb6JrArwkxxAxtKIt0V7XFMqkkz1xAfxrWkwuj2
28nV0HmSOxHmDKvaITPu3Jer5jK5bs5YIWReex/jaAHAW1mrEoAT5TJA4GNSCRD9
mI4HDd0XjYPcHIjhwc17P2xegM7uswXCUFGbEUyfJPPG4VsUT9GkO8w/Srxd4AgZ
7jIfmrUGfyaa5z4hlNSvlfUu4U05zWTtt7vdYnm//YGHNPV8Tj87wMcfO4WHV5hV
CSPUBPu93nFiBcPNZ+NRteeraspn3Q==
=glZu
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
