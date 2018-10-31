Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB5EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0AA205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0AA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeJaS5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:57:02 -0400
Received: from sauhun.de ([88.99.104.3]:55106 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeJaS5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:57:02 -0400
Received: from localhost (unknown [87.114.85.207])
        by pokefinder.org (Postfix) with ESMTPSA id 2B9922E35E1;
        Wed, 31 Oct 2018 10:59:34 +0100 (CET)
Date:   Wed, 31 Oct 2018 09:59:32 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Message-ID: <20181031095932.GA1487@kunai>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
 <20181028223116.GJ1882@kunai>
 <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
 <20181030115120.GI16508@imbe.wolfsonmicro.main>
 <CAO-hwJ+B5iUpbUamsCfNKGwxJMM9fNBUnrb2-csn1VpNG58KBA@mail.gmail.com>
 <20181030145549.GB2459@kunai>
 <20181031095230.GK16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20181031095230.GK16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> It's a bit of a long chain and fairly tricky to say exactly when
> the bug was introduced but I think this is probably the closest
> match:
>=20
> Fixes: 2fd36c552649 ("i2c: core: Map OF IRQ at probe time")

Thank you for checking! Then, I'll just leave it and cc stable so it can
be applied as long as it fits.


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvZfP8ACgkQFA3kzBSg
KbajlBAAqOEGMuXQ+XDNiiSuBsZr8jIbdFSkb9pLlGRkLjetIkS1dAEOjYBr2+/U
nQ6m55UUhVFLtiiidsESt4pHx4YtLlUrbKUvDXsoNdUDmU1XFfQKM7C1xHzZsMal
HfQ09z07mMxmKnsTIAgxvqt7XFa0EO2+hO1A4YtcZpSYeJ33WfeuREH7CmtiqlpL
/+06LZMotG1XXWbE1823na/zqdhHMXjykt0S1qytnrhERM2rgyOeXo//IKhJV3aP
RR0HcHiHbqm5Qur2RcKrvVVPTv7wTfeCpoyjFp8VAxLd2JPtWy783TrmdTIpEcQc
aEjEDPVFAdj94+jV8ioQ9xcFxoZiHzgrZi+swJLBS0YLzZfb7N8pj+LMePsI2fDH
CUBrvnuG+49kOI0NBx/iQ+P9jVeP5gPwQzU+MiyU+3/FlACX+5dTIlnFUaBArx4K
CX0zsLAqwFhI3vyZU1QEVMXRUSTf2usFb9O2xHk13M1/r/Tim52afLDKkRtTq6Cu
dqSx7h0o2UM9ijMDsrV6fNl0X3XUWfQIvpONTt15/kcInWPMwPojd/iVbc6Zqe0L
Dk5GgdgOZxnNS62uYkTaybqgLZmCKCyWQ4UZzh9a7mBFZOl7EqubkngjcB4VLLNF
3AIyRdUfBDuFZa7/FzGumukyUQuVuTSJTaZZI5BFH+kcmKVVEaI=
=q9jn
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
