Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67872C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1AF2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1AF2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeHXRl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:41:57 -0400
Received: from sauhun.de ([88.99.104.3]:40978 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbeHXRl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:41:57 -0400
Received: from localhost (p54B33931.dip0.t-ipconnect.de [84.179.57.49])
        by pokefinder.org (Postfix) with ESMTPSA id 7E88C305B98;
        Fri, 24 Aug 2018 16:07:06 +0200 (CEST)
Date:   Fri, 24 Aug 2018 16:07:06 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sedat Dilek <sedat.dilek@credativ.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Message-ID: <20180824140705.t3pkiqfpnqzaaksz@ninjato>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <20180824130130.bialyhjarwkwodzw@ninjato>
 <1335058904.531.1535118581478@ox.credativ.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ac2cl3ttkkj4qfwg"
Content-Disposition: inline
In-Reply-To: <1335058904.531.1535118581478@ox.credativ.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ac2cl3ttkkj4qfwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> will my patch go to [1]?

It won't be needed anymore, the __deprecated function will go away until
next week.


--ac2cl3ttkkj4qfwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluAEQUACgkQFA3kzBSg
Kba5Ow//dcKcXBiZ1sBJZgLzYdDjQPBb/xfPsxE8a4LzlShBun23hA9u2MiAh0q2
kJLeTsyAfiQR3nbb4ax1oUNLycqzInz/HrYW4zyiajbg4o8dQQugJNWwWbMJtiO3
UhasNZv3nwnbJ6DEOS3XVko9FQkjnn73fgfL0gq6qpSuC+YIYQOMjbdvhfFaR065
QJIGK/zz/xktwRRswSL2CV1rsF6edJMizgJR/IjXCZVFg5gYKQsk344MbK5w6pjZ
0lEiSkMML+fCk8rhkyYewrHKak99hM7IIRuwGGo2BJiukqgXpedLPzVVreYFlzu2
z2XfXZcJg15s6lgol54X4kk9bnBeqwsDz7TnveeVoqu4QaoMiva3ay2hkeS3zmpj
8XfaMy9o7PQMQdzx2OiX8w9uI9AEFRjd+5y4KknavVOqaoXmWEqwp1RMTZistIt/
BeJZE2vnazA8q3bG9n7ffzulY11ImxraEsgfY5uT88pfdaGeJrbLWEp7n/kFttGK
JFYGzSYL+HkcwoNra3odYDbef3t4j6TGZYh0HeDPHJpfyT2NWew237FGlR2cgUxb
hCq4oIG1+Q2TD7bZUstsJSg/tfycqYEUknr1KKiAYg3ZPAm9yuKocvVssIPg1loV
TXo5ORSiQy0TlqA6/qE1Ox8N0Ork76p1NNOlfswqn6rP9MLCRN0=
=oWai
-----END PGP SIGNATURE-----

--ac2cl3ttkkj4qfwg--
