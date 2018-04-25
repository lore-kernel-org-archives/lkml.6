Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524635134; cv=none;
        d=google.com; s=arc-20160816;
        b=lWG3YspgK+uE5+erUYQIrYu/vuV6HU7U+Tf1uYmQcMWHgqNEai0hj4wDF72WlXpQ++
         +QFFnsTaRcYZv7J8xdNSWd40jFeDOJ/5YjFjBHuw0BdUf1C4RtIG2pC1KFdsOd2BT2rW
         ErZ39ORY3XTv8sw27sdBgO+K+zffK3G12JkLwatK5hClrI8e3TL/avgyUYCayF39aKz8
         5GzCA2uE0nx8+4883+nD3D/Ov7wCU6RQIGA++We41dekpPt1WT9K7Tx9MRaLL0jDl5Y2
         mmGg/jAIGFkio2Jzlrz8zoSnf+9uM6ePOsU8CbMRzBwIDnUmNQzh6F8v0sf6IFMzmtSh
         PPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=zBdji/rwruPhDMICfDxGap4knw3QbplR24nRcDNKVy4=;
        b=ZOJi2HD3N3zIFibChPBhM+FnpIeWDRFSpTff0xsBCykQ4PBfz3nddDX0Dks9iFkmvk
         lFNouRhC8y4JmHfrcvwz43dB1T5A9UIsK2KP3IA6Kw+cIOsUrVhKtHDW/PFo53gRko+W
         EqoJjaq3BVK01xuWKf0p1DX9rmCwdj2hA4Qv0+AA476PIGOedJjdsQ/DNBgo5gmLbpe4
         G/eR5jW6P1OlaM8nBKPRRVDAZquArNfgwuD0ZHWRIEFDG+Fp9v7IDdZzae2CgFSkFkaQ
         LFL62ydGIVdCYLC6JqKoW7Ehj0V/EpJCqsGbBbc/Ouvzq0gbxR4DSbJztL/h+/i5pFA1
         tozQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s9XfWiLW;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s9XfWiLW;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/iwb47ygXfUcAIguyxLPHe5zP1qkCGcTCJppCZi0eLi4CE/s7lg9NKrwjDb0EM5LKI8uZymw==
Date: Tue, 24 Apr 2018 19:45:30 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v3 1/2] tty/nozomi: cleanup DUMP() macro
Message-ID: <20180425054530.gifahvwftdbjuo7x@gmail.com>
References: <cover.1524606061.git.joeypabalinas@gmail.com>
 <58b559776732f0fc14b1c30ec7da6fc27c3f1cc8.1524606061.git.joeypabalinas@gmail.com>
 <20180425053848.GB30843@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vwn22mdw3nflhxbx"
Content-Disposition: inline
In-Reply-To: <20180425053848.GB30843@kroah.com>
User-Agent: NeoMutt/20180323-62-378db9
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668996565319671?=
X-GMAIL-MSGID: =?utf-8?q?1598695810951923286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vwn22mdw3nflhxbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:38:48AM +0200, Greg Kroah-Hartman wrote:
> How are you sending these patches?  How are you creating them?  What is
> taking part of the diffstat off and just leaving that line?

Hm, my `git format-patch` alias included --shortstat for some odd reason,
very sorry about that.

Going to resend.

--=20
Cheers,
Joey Pabalinas

--vwn22mdw3nflhxbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrgFfoACgkQruvLfWhy
VBl87hAAxRMjL7xOpBhBsUXpa/wEJZJW1Ewqm5t28FCQSUD+fCxSan5dr8Keo2Qo
WwJ/GV31DESF0ldku5LSfLo7KgmK/xRW6FUcigv5Ndu7u4u7n0ajpDcQhW+WHixS
KekzM/v4sluLlkPC1FBm6ljkI65zWo7KDFSTxRvh1nxEQuaUquR9vaIMWEv8E/QK
ZbvCFadsYi0gGod74Uue/K8+OIGXTV2CN789ezChgBsxxuoBLRve9DWZY4G5oJm/
7un15Kww+AHmVpxTLmSOoUvvavpuR513EDxPB78SJ065z32sxDUnVjMN79HJIy+C
+wuSz8oilbTiHVD+8p6UJfs/htDnrnWhakSOntRkisKfPbhNipR1owsv5rVprVGq
qwNG7rjtbSFkmaDnj9Miy/EvXBUFITFPj4iixzCGGdhCPmlIxc81X+/dIWaWj3ft
MtmE3dY726HJwIz0Zyukgw8C9N+qTFgfj/2sJOtg70Py37BYJpjMD1jsUPFljIa8
kzNg33QQBP73gzj+kiNz0HJdkIYK7X6NZbOfOhQJL/oEr5fi/xKKDzKciankxBow
+2WoEflwLF6VFkSUNTnIa9SwqvkfLqu/IgN5jX3ViUNvnCkHKDaPjmZ/gBAIqH/8
VivOftDSkNN16n7y86eWxx7TZDHh01SBdlgbXh8Kce6FQF8DqVU=
=TWS6
-----END PGP SIGNATURE-----

--vwn22mdw3nflhxbx--
