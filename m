Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B356C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE972192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391328AbfBOIwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:52:42 -0500
Received: from sauhun.de ([88.99.104.3]:60200 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfBOIwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:52:41 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id AF80A2E3551;
        Fri, 15 Feb 2019 09:52:39 +0100 (CET)
Date:   Fri, 15 Feb 2019 09:52:39 +0100
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
Subject: Re: [PATCH v2] i2c: aspeed: Add multi-master use case support
Message-ID: <20190215085239.v5cjmcef2q62xiyl@ninjato>
References: <20190211185444.4965-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ybsnxjjqnbgxua7z"
Content-Disposition: inline
In-Reply-To: <20190211185444.4965-1-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ybsnxjjqnbgxua7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:54:44AM -0800, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
>=20
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-next, thanks!


--ybsnxjjqnbgxua7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmfdcACgkQFA3kzBSg
KbYJEw//dnf7zJDVpII7ZpsgPtNZerCcz/+RipuuRefqyn6ol/03zMNMDsTsqWTZ
WB9tWi0dBE0uC50iOyLKS0M9I5b1xVqKasEl2Z/r8J9IvGuakbIfGfhiYJ9oJgdH
zJBxkc5W2Or1FJ9AUIxpKWeaUSeE6J2/wv5168RfjLQAb+Sr9jVCrCon1ZsTo/7B
9lBwoYMAXTonbf615WTcU+fnRHDyIbjboL0OB1W2Iv8ksmTPvETviuqfSk4PyiSJ
RLcQUWrw44sUu9sSUzQNZ97g6l20R/LnFtXdQYIDrXNTmP+tXlAfxqdt6ghVumwa
toW9MZX/JkYc0xrBIOQPpEL61yqLyoQdChhv9ahUAKUiKTIkz0Io9S5PobOMvIbd
sGyJ+abYVA9Qvg8CH+ZKQGZwm/SgIGfKtkIgbh+3Q6ATChB5dDfytJw4N2OoVu0T
5DgPrkmpIaVF9JTOnhvzQZYswpBZuDk11yC2Tea2s9Djp1fN3ettw+uYLbcnLmo1
GNLWOtLTkT0gr/krY8xy006jaMOa4tjlLLKlB9AzUNB4APidP2UDKE68wrxlo7SD
+5nQ+CZn9CJUBdXR5hQeDrzpoTdRBgNlUPUaB0TOK3Sbz962vu1I4019xG1ITLwf
OEUWzonl3lABGqbew7I3lyn5Py9nEcWVfW+6Ks74i5vvRBcIAOQ=
=dfmE
-----END PGP SIGNATURE-----

--ybsnxjjqnbgxua7z--
