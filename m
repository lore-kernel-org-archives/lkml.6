Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1621DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BC220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BC220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeIYOdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:33:44 -0400
Received: from sauhun.de ([88.99.104.3]:41982 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeIYOdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:33:43 -0400
Received: from localhost (mue-88-130-98-139.dsl.tropolys.de [88.130.98.139])
        by pokefinder.org (Postfix) with ESMTPSA id D77292C015D;
        Tue, 25 Sep 2018 10:27:17 +0200 (CEST)
Date:   Tue, 25 Sep 2018 10:27:17 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' setting
Message-ID: <20180925082717.GB2270@kunai>
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
 <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
 <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
 <20180924215850.GD18592@kunai>
 <2c8563fd-0641-5237-0026-f559c480ad91@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <2c8563fd-0641-5237-0026-f559c480ad91@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:15:46PM -0700, Jae Hyun Yoo wrote:
> Hi Wolfram,
>=20
> On 9/24/2018 2:58 PM, Wolfram Sang wrote:
> > On Tue, Sep 18, 2018 at 11:02:54AM -0700, Jae Hyun Yoo wrote:
> > > On 9/10/2018 2:45 PM, Jae Hyun Yoo wrote:
> > > > +- idle-wait-timeout-ms	: bus idle waiting timeout in milliseconds =
when
> > > > +			  multi-master is set, defaults to 100 ms when not
> > > > +			  specified.
> > >=20
> > > Will change it to 'aspeed,idle-wait-timeout-ms' as it's a non standard
> > > property.
> >=20
> > No need. This binding is not a HW description, so not a DT property in
> > my book. I still don't understand: Your IP core in master mode does not
> > have a BUSY bit or similar which detects when a START was detected and
> > clears after a STOP?
> >=20
>=20
> Okay, I'll keep this property as it is then.

Sorry for the misunderstanding. I don't think this a property, at all.
It doesn't describe the hardware, it is more of a configuration thing,
or?


--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlup8WUACgkQFA3kzBSg
KbaCkQ//Sr79g4ksA+VQaClLdgoFcG7zOSuXCbILrhtjICbXU/WDEfPbqtL9IBVM
cSElb3LZuKX7VtGH4RdXdLjLtoK/uCub8uIoblbz+R614BQOUnLfmeeo0yVdOJeW
oJtPolSHTd6zrBXKv8sMCF/UBU2msJeHmEzgSEleV6ExaFCD4dI34VBKuFZFLpjz
6GYan49CkRxLNodatCnTJ4bMYY7SxGtAQC33A6K01FLVnQdLuM+P9XFvMLYOTq96
oNFQCYdX1c3h4aKLJGN4AInX9zlK75IVotYJwXQwBUiJ+QcajiOv8TfoWkDxibd/
QPVVCkRqextHRajwPwIFqyKwyKNfkSAmqrwqJ41qZDV40SUVrVnQpGrkWmUEk0G2
Zho/UfwyAkRYAaUzAjwsbzXOoCZMD10+WCBceajhgYHpUX/OVagrYCuD8BNcQMOq
w0MUdxk9zjjANGihAIOBagcbOc/rD2lo/g7m2yaTX8sxkvlksHLdMoBBguXlL/RO
lYOhgwTGTjXXL06bVReKLtmXaDb++QrCxrM1T+X2uL0VUas5MbvwepDq//Zo7VrV
u18Z7Uvee+8x+O6/hpkBr6i412E/BO/gN9RTtnNEHns1E4DN7cHairHtfV3BBggp
p0egYeeu0fkSQnigxhL49xaYTUYVPHHGTBcMP7d78LY3IpPkNiU=
=niVH
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
