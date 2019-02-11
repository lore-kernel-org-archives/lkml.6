Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B8CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A6A21B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfBKSRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:17:01 -0500
Received: from sauhun.de ([88.99.104.3]:57056 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfBKSRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:17:01 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 2CCBA2E3542;
        Mon, 11 Feb 2019 19:16:59 +0100 (CET)
Date:   Mon, 11 Feb 2019 19:16:58 +0100
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
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
Message-ID: <20190211181658.u55ggc2xi4nsxxvy@katana>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
 <20190208214849.GH12451@kunai>
 <d26a95ac-41ab-91eb-bbae-e4143235e531@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b7kjvamtr6un2ngr"
Content-Disposition: inline
In-Reply-To: <d26a95ac-41ab-91eb-bbae-e4143235e531@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b7kjvamtr6un2ngr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Can you please apply above changes on top of this patch? Or I can submit
> v2 with it.

Please send v2.


--b7kjvamtr6un2ngr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhvBYACgkQFA3kzBSg
KbZ58hAAmNRU6mM70EOa6sDNBXGmzcZENP6uaJPIZhmXqGs2hZGLkU6mSJic0Q+m
GfvX9fFAYCSagyUe/TIjgdxW0zsYPvo+791TQkB7L+d4ttcMRWVymCBoiGVsQj8q
I1toNkiWc6cMUKpdTifAAjjuK5x5CVnyYEdlCkaH96CejSh++DzdCxqtoKBu+YZH
sIfcpclSkuyXJB1Auzc36FVmcYMxUZbsHhE1pAQUGOgV+6RqmreNctPC7OvDYeJx
Xi2z5GmlB2J/CWE7nxD6vWIz17O6hzmLHf5/xsgP0YewwqYkib/jiKIwxmdzAO7c
5e8R3mO/ivmnj+/0+ez0gENLneu9hu0NnkqcuC1VJ0BddNLsNIOYmjnpu2x8NHhB
HNxmop4N0jaFkloCGq6o9HfMuwLWIR7/AkK9LOfrw2ZGS1zwJZqb5aesysT9yy0F
uzw+srgi+bnYOfGD2+rZxmMHCYv/cW9QT2bA4/15KAo39yXfNup1+XZr/94QRej+
3Bo0NDqTQLIk1Gvd0NjsK7Ohdr+XPA3amgfPnUqZ+cTH4sEwU6ezaV5DvCXj9plx
kxFgWksLgBpaCGIzd6A7ui7lsSfpuFZgo6zlQFTtGNtYNNakhoKz3gvIVXMSNwMn
Y6S9MM25vev0yn/qX2APLeN6fWVL0ixI6ZlI0qAVBs5xmoIHQo8=
=SJHw
-----END PGP SIGNATURE-----

--b7kjvamtr6un2ngr--
