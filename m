Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62EFECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F99A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F99A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeGTXPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:15:50 -0400
Received: from sauhun.de ([88.99.104.3]:59932 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbeGTXPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:15:50 -0400
Received: from localhost (p54B33241.dip0.t-ipconnect.de [84.179.50.65])
        by pokefinder.org (Postfix) with ESMTPSA id D5EDA5E000F;
        Sat, 21 Jul 2018 00:25:32 +0200 (CEST)
Date:   Sat, 21 Jul 2018 00:25:32 +0200
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
Subject: Re: [PATCH] i2c: aspeed: Add newline characters into message
 printings.
Message-ID: <20180720222532.o273zjv4lx7rkq7z@ninjato>
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wihqb6kqvskazihp"
Content-Disposition: inline
In-Reply-To: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wihqb6kqvskazihp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:13:59PM -0700, Jae Hyun Yoo wrote:
> There are some log printing without a newline character. This
> patch adds the missing newline characters.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!


--wihqb6kqvskazihp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSYVgACgkQFA3kzBSg
KbYU5Q/8CHYKb4Oz94Wk9vwYE4D3uU0wJ2e48bajqBPX04l+RTqV1MtcpYsqzSai
sF53/0+XEnP3T34bQPTG2LVvrVOlHqT9ufrSpBmujAoZAvlVZ+Vb34yszla18xZn
BcTrkRQIWTnpi+STp59QaK7QQylnYDgNf72qpz1HtmC+Q2ZxLs2XJ/8JzI1e0kMA
yGDA96X3KnSixgDDy0+gH+w99IBjto5pCXKkES7WC3/sweXFvDM0eyF2k21jEqrn
nsP83c9FoeRKloBy7t17nTAUa9kv02vmi1yvjKxbbeGkGUpJOXBhGQO/rzKn2qzC
gH30aMjM3KmzyCvOwVWtTxYMn1corxUnCvPBpll21dtG9TMM84Il6YWOnoT1W6ni
SCm1YHLrUSh+nAxkZNiGMcqFCGo+9x+hesQnvbk5SSMkPH7NWWmRgHkA1X+refG7
9UgHDs6LRrhMXyEvCogi6JP66SAA2UYFMk+ILi6jpFGerf20/MDqZQi+wJvg+DeF
ZOdpmD9NveW34bfH0ocV/byM/QNthYiYqGyIbe33X4ivt6s9lqg4m/qJUkAcp2C7
DOYPo3FuBFKyc6YTOxnOtkgP3I112wMjA3+1sh0oPmkbJS7aLqTg+h402GkbPZzW
NwjLrHaL/PYuubKdypQb/h4W/L00I0KoV1lSOO4ChoJ8IcdV+gg=
=EgKQ
-----END PGP SIGNATURE-----

--wihqb6kqvskazihp--
