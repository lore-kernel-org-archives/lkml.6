Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB09C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB192064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AiAeL1g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB192064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJISMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:12:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60610 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJISMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/vi4aDsEGYxfK0AOuvvxuZ/LEdctE3kjcRCiitAeH4A=; b=AiAeL1g+PjnLx2Hy3CscQqZup
        gNBpTwWS09tey0TVma9KXFT1CpBpbjp5RE6OyZogI1NcccJQH9Wl57Jol5XNKFVp/mYcPjYYW+m1v
        QNkpr7aQJkv0Aqik8NedPG6w3hOU9XjGyrD0PDugdH2KnD0vO7DqBcTRE34eZVzx4UG9U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9pg6-0005VA-RJ; Tue, 09 Oct 2018 10:55:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 71DFD112234A; Tue,  9 Oct 2018 11:55:50 +0100 (BST)
Date:   Tue, 9 Oct 2018 11:55:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
Message-ID: <20181009105550.GB20774@sirena.org.uk>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
 <20181008152043.GA5796@localhost>
 <1539012620.4344.5.camel@HansenPartnership.com>
 <20181008162357.7004ba48@coco.lan>
 <20181008195750.GA5367@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20181008195750.GA5367@localhost>
X-Cookie: Save gas, don't eat beans.
X-TUID: CLAtDYZwyf+a
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 12:57:51PM -0700, Josh Triplett wrote:
> On Mon, Oct 08, 2018 at 04:23:57PM -0300, Mauro Carvalho Chehab wrote:

> > Fully agreed on that. The same argument that we use for GPL 2 only
> > applies here: we should stick with an specific version of this it, in
> > a way that we won't be automatically bound to whatever new version
> > of it would say.

> Linking to a FAQ with useful clarifications in it doesn't make those
> "binding". This is *not* a legal agreement.

I don't think it's unreasonable for people to interpret the contributor
covenant in that sort of fashion - one of the consequences of the fact
that it does things people want like be explicit about exactly what
behaviours it's covering, specify consequences and so on is that it
looks a lot like how things that are intended to be some sort of legal
document look.  This is going to be especially true for non-native
speakers.  If it is causing problems that needs some clarification but
to be honest if people are erring on the side of taking the code of
conduct too seriously that doesn't seem like the worst thing ever. =20

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu8iTUACgkQJNaLcl1U
h9Ak6wf+Ia4H84n7lRzES3eL+zcr+TWYzGUV8BNDus71z1QfOUvWakqCJjYPXRSP
tKuayS5LdeGdJKIhHhZ3Mmp8TUF8KtmWKI+nTb9CnNVqXa4IQpoqjqgDj1xxEEw5
tO9BBJGn5375UcOlvviAqS1j3T9StS/kC96WY+5cw2tNlKmCzdjyzlLgYD9jwtS7
eHoc/2aldZjb58ot5A9/9PU/PFh2Gbu39co6CJZjxc2WW++gT8wfQJmR0Ml7jjEN
Wj60HSAmESR7MQz3LQj44GrY8QIxqvUsI/LzgpZ5EdXHSsaVMrvCcXOlQOGCTuLM
Kr2/7xGMMRZj1FufaFes17S/E5/Ahw==
=yAUU
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
