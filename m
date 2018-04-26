Return-Path: <wsa@the-dreams.de>
X-Google-Smtp-Source: AIpwx4/cxvzqfLxwiBZ0fL0Tz3ZPIBnkNWQX6Ih/WWbbDfgvqpuRI9fL4cNgZrJ8DW7NSE+GYbaQ
ARC-Seal: i=1; a=rsa-sha256; t=1524733386; cv=none;
        d=google.com; s=arc-20160816;
        b=tOts40m61O4jEZkwPdZbR74w5aPtrpVcvicGigElMAXw7OvoBJ06VqgdFpa07gAoNy
         ZMEv0UkAKVLNN4LPfp9nxwLt+mu8ZBuiYkSfXBmB0F3c1ANaA8UzuUE8E60m9Xm2MwMR
         7ep1mP60bJpNfvPtY9zmOGqoF5Xf7grESnBHYIF8Ze0sE/xqy6if+qu/2pVKy1yksLep
         kgIPYaCxpUyU2VTtaDAIBdZjCWiKCWXLjNebjjebcNEkvgWniGDQb75i8r+m6t12oFEL
         3xo1Qk/fG0XIiPCpWjZRYfpFQJI9BqL2pbHANLch4l24lQ+Ukv9dgSWabUX5mFVkEoEO
         dIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=R38HPiwXaaZ0/1xu8I/5A4vHuMhrwHPmz2Ta4x5OmWw=;
        b=NkEqy1e5XffWwr9wgFApoVmuRzPiKYhEXjH4KaM0DSRAdSofulUDKTQTAWO2B1O0On
         GVSk2jL46rH9svDiL0OHCI1hcbV0BNDNSyarXyQEx8oP0Yzv45BivENHu3wX86UAH2Ln
         YdIgXHYA1hMowTLKnmEHjXYTsx6DdeH+cWfbt3DDL2nj9WrWkN01oZdNTOjjd/tJR6bL
         EHDwBFhIL+V7SfPJdNRwurbpby552LP2Yo7nzKoXtNwhWeqzYyQcHKNYZ7nofYMYWTcL
         sIWEmeMnt2snhRqS5c5c2GAy1BGkBbnvgEr7xmVeMnmqDxPd9JYRG766jxkOTuY6cuQI
         wWtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wsa@the-dreams.de designates 88.99.104.3 as permitted sender) smtp.mailfrom=wsa@the-dreams.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wsa@the-dreams.de designates 88.99.104.3 as permitted sender) smtp.mailfrom=wsa@the-dreams.de
Date: Thu, 26 Apr 2018 11:03:05 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/11] i2c: Respect all error codes from
 dev_pm_domain_attach()
Message-ID: <20180426090305.gusouz4dly5ozr5y@ninjato>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-9-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zdolorkre7rhqchr"
Content-Disposition: inline
In-Reply-To: <1524732790-2234-9-git-send-email-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798227731676848?=
X-GMAIL-MSGID: =?utf-8?q?1598798835053644214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--zdolorkre7rhqchr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 10:53:07AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--zdolorkre7rhqchr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrhlcUACgkQFA3kzBSg
KbZiJA//Sjv+7379T4aGYs5bqEungMa2Y+nzrFohaEgP6x9Hc2TQcDDpQg4bvPiU
Zat0qefuoD+pKTR19swrVw5pUuTdHk2Qz+n0Fvc+WmSMpzOOuYwKvf5mH8uDQD6x
113rzXOXuSkxNkExqVzYtyPOvahodnYtEfW4LI3/Q7Uk1g+V0pdEs4w3/IpuE7WV
10DbOFNWdCGKxzMu82Y6AL8UrL/M3HVz5eCi7dbTo0yRGJzlqWhuk/GcqrbySgcG
qc12RaiXathmaWZbCwdPGZbtg085u6YU8zC9QLFfC5k3obNxligzAFeBxuaU038a
1AAmtHb+mfqjNd/Bf4GPq1nqDFK6eAsU7PPrT2WKcVuZ0iMAeRJS+MO6KlQTTINd
kd7qkfxMWmHaQIUwCt9x4/KwvXty8CgMOPhBoa7s6NBPcuBcQbTeeRgzmmJEdrTJ
KNsfzk6ozu3N3APpXuU1AwfJwlGLdninMrqRRDS/+1XRePAkfNHIYalgrb0EO6qJ
63faFI1qwWaXzIwj1i5HPErWr1QFKEqeHvG1cpjZVE6rAUlmEMD1sWg5QXRPtBct
XuXbXf7MeM5uYFNSfjT8FrUWajp3vCPRlCCDpkWoGrlbeBH7jLkONm05vC27sG6v
UeTfc7BLtvXgavWUS3i8BxnHl5xcFMoAj8WUYFCFur2hdwYbSxQ=
=HAVl
-----END PGP SIGNATURE-----

--zdolorkre7rhqchr--
