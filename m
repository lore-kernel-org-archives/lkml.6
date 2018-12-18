Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE11C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B172184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeLRXdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:33:02 -0500
Received: from sauhun.de ([88.99.104.3]:50004 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbeLRXdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:33:02 -0500
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
        by pokefinder.org (Postfix) with ESMTPSA id D34E32E3542;
        Wed, 19 Dec 2018 00:32:59 +0100 (CET)
Date:   Wed, 19 Dec 2018 00:32:59 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Message-ID: <20181218233259.2ufszlpw5hjlg2hm@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
 <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
 <20181218201725.2uqfmsethlkasdvc@ninjato>
 <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zqdnv7q2yfssawi"
Content-Disposition: inline
In-Reply-To: <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2zqdnv7q2yfssawi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I've been thinking along the same lines: your series for the drivers
> with separate runtime and system suspend handlers, "custom" driver
> specific code for troublesome cases like i2c-designware.

Cool, thanks!

> Do you want me to send out a new version of my patch for the i2c-designware
> code?

Yes, please do.


--2zqdnv7q2yfssawi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZg6sACgkQFA3kzBSg
Kbb76A//brac55lwWTzuGQxjrhsSLEQwELKmBFUMND3qoxvsksj7MPwfUes29I22
/40oqppJtH5pvm9a9oLl1EHmvIPKCmECe1kgp9SqrxRtspuMIIvwVL2YVA23bEsk
g29Fo9oIQ23Le7vsh3CT+9hcfrsyuBUnqbQWdpWQVIEgdzwySeDuRzgF5CbV4951
WiPwMH9+dxt4JnQART5cjHIkjf88TMNLNZah2mv+Qc306U/qvxBNPjKRAfMuyMHt
4axCZ6WwuRGB8uXeFu/fkctno7l7Qta/m1iFHIt3t3nGVAlWdOB/fOqS9H3IX0+L
y4MbbS6WVr+mCjddy1T9UBC9U2GXP29aU6Zn4x9XlcBq7AY/LHAGyvWbXHhuB8IO
j4ZFy0P/2DH4VYDEtJdFFR4abyBzpPQZIR4dNQIIDQ4qPN5aWgs6gcRTJ38j3fdd
neCGpf37wKEBzryrRdC4vbMx4CwoeMIcStDz62ARsOV5fOomyg4w8cL6Xlu1Vt+3
4fIimBvfSzeb+wmSvep+9PPaBzXT99Uft6z0WlpPo2oRIS/x2ryD2livFPQYcxkE
a0zyiy+8pYgfhrRc4YYp1K2LEJi2dJWBl0dDMyQMT3Wp0qPL02MAVsUEcodWqP6e
lNasaYCIBijQlWPK6UmIt7ajsXAyXO8TrUZPXFjBK50hFwWYgSk=
=m5jJ
-----END PGP SIGNATURE-----

--2zqdnv7q2yfssawi--
