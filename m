Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeCTJmV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:42:21 -0400
Received: from www.zeus03.de ([194.117.254.33]:44234 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeCTJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:42:18 -0400
Date: Tue, 20 Mar 2018 10:42:17 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
Message-ID: <20180320094216.ugietqyerdowq4c4@katana>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
 <20180317204720.mclh4jw5owobbtww@ninjato>
 <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
 <fdc16b28-3aab-1d37-3c93-40ed371bfd4f@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kmohnvwq7fipub72"
Content-Disposition: inline
In-Reply-To: <fdc16b28-3aab-1d37-3c93-40ed371bfd4f@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kmohnvwq7fipub72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> Looking at the recovery API, this recovery is for slave and nothing else with my
> case. Therefore I think I have to get move this reset out of recovery API.

Yes, you are correct. You need a custom function, this is totally driver
specific.

> Slave Recovery mechanism is another story to implement in our platform since we
> have to deal with GPIOs.

For that, the recovery infrastructure in the core has lots of helpers
for you.

Regards,

   Wolfram


--kmohnvwq7fipub72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqw13gACgkQFA3kzBSg
KbYU+w//Tpu7vQF9mrYDI8uZdzdkAvemfARGYmeate/BOjy2Js/c6avmgdV0m1xX
d1yzllIVveqzfXNfSbigQ9fil3T2SsSxXYtcVwOSPu55TQX5S6ZQPlhXJ+w5s121
UFK5YR9/9sBGMY9ouYk1LW8ksWYYgNUi+ctpAYzoTCiC/02nFthIjP210F3sLyP/
D0tR8I1FKMmOht50B8LqpxMCUjmFXjbwuWecgmNh5LcO6+7Tk5IFdVFCU/HOH9a6
sa/Gj8Jk+vI3N84aMahJvZPwIXHjqQlLCF54P5rNWqr1ybEZW0vnovKXDIixrY9V
yl0zuQeStY42ZGi8X3bfNmJVrZvWWBLEuuS4EHD//rYvIYRu8aX1hHuQDKK/0JXP
mbH2V7PbxG2z68TBB0lVhCzKciPfl4mddd1f9JeLEHvWer9vSfjB6VhoxbxCppPK
G5/G93pw/ZhHyxA77dmB01yWYH1ql6+ZvxY9NL3ECLaFYbwh1d7UX8HCRPvZFWCk
f9JeQY+6FVJpAKMtHb5o+MIGMCHLdnE5F7sOAuhqlILWonlw0QG0Uqp4s9Cr4r/R
f2bm71Cirgd2NAAJSsZaYd0VCw73ADWSZibU5ws4EaqnqufVkx8pFIomFDTPF4rm
f76M72lZMNYFwfK/8n+zLMIYEJHikN+sUInyUom2ouTnoRMjco0=
=1Hhj
-----END PGP SIGNATURE-----

--kmohnvwq7fipub72--
