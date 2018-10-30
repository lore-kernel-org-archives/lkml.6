Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3866C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE192080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE192080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeJ3Xtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:49:41 -0400
Received: from sauhun.de ([88.99.104.3]:49540 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJ3Xtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:49:40 -0400
Received: from localhost (unknown [87.114.85.207])
        by pokefinder.org (Postfix) with ESMTPSA id 8A1FF2E35E6;
        Tue, 30 Oct 2018 15:55:50 +0100 (CET)
Date:   Tue, 30 Oct 2018 14:55:50 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     ckeepax@opensource.cirrus.com,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Message-ID: <20181030145549.GB2459@kunai>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
 <20181028223116.GJ1882@kunai>
 <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
 <20181030115120.GI16508@imbe.wolfsonmicro.main>
 <CAO-hwJ+B5iUpbUamsCfNKGwxJMM9fNBUnrb2-csn1VpNG58KBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+B5iUpbUamsCfNKGwxJMM9fNBUnrb2-csn1VpNG58KBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> No, that's fine. Now I get this, and I totally agree with the approach:
>=20
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks! If one of you could provide me with a Fixes tag (for this. or
both patches?), that would be most helpful.


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvYcPUACgkQFA3kzBSg
KbbBLBAArsFBvF18lduX8tW25Jn2VvrX/3hEt8dMJAIyWD0pH84M8elcWQbs/tdz
p/aAiLsfX+RteluA3fNqllohWGpgPcJaMlA7na126FZ13pEsCnw1ot8wUOZfTRlm
2k2PbCCo1GkIoHSCwJpkkPXC/zIyXij74KWGS6n6BIsy33X6GjePh1NiJ35MQA8u
ujz8pSFGhA2LVAntjOvDOhA0DnqYilNABdjNzg8k7N0LIrH3A9K9O+AL5PKk72Tx
yK/wPquy2Th8F5dXNiPv1J9OSpP6yagdvF6ADhacFDuFnLCbS5aAN2Y5lbF0st3m
oWjlYEX5ZaJmHFTKtNZlE+WZFa/1AYjC1ve1AAW1SecAWhDOCOh5N+IFYaLTwYQb
S6dmzA7NXK/+NTCyUVwyopkLYdDvPcQLIEdQdXjTmGuesu8Isn3d9J8bq8NQDPMm
9EuIOXDKEjpkurguVD4DANcYZRw+Gc7LWQKJzMFI2erShFmZjwRItvzKu6f9vlVQ
brT2rXB6dRzEiWVHV02trbcsNpTcNopXSU9kVBTWOFvSLBQA7yAyDUyoYNIpOwSW
DCu26kZqDln00prQvQF9dmwzuHeC00oNwVMsHISF6bZgESf4LNrN2TkkjXHfIDvP
h9vZbBCyKauhDFc6HO+//Fyo2kWsBdSfqFIINLEd2VCrIUS0nKg=
=3PS+
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
