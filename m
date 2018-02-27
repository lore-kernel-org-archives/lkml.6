Return-Path: <maxime.ripard@bootlin.com>
X-Google-Smtp-Source: AH8x225k6izo4mtZdk2vM4DpwPG6ERRd6pOanLDPqZ1tDZdjFdcsxnNjPimJtJsENvcPT1S/1ki6
ARC-Seal: i=1; a=rsa-sha256; t=1519716326; cv=none;
        d=google.com; s=arc-20160816;
        b=nzj9PYTiSiea1/vKYz1ekL3XhLSHBZHgXem+qJLmstzWgNSrqwhmgHc/zXos0NEWOy
         hsI+TvYjfJ+XOViwSH8vciV16ZiQrlR1oRPoAJjfJBWcIuViPukk5BpJ0lPC//89CNMj
         8D8jQRdpK3AuNlHzsTkqUMRLDYRRIevxN6ryah+BesXs230NcKoi9FyRbVDHnTz4LoHm
         21CcNuZ20neZr3YrBjEU5P61jBLA4GIPI+Noa/yLtVVHGYU8SbUmY+F1i3Aieu7kEZwv
         gGG3em2GWw4HXU8gn0aGsirjRQIBVgJ+IGdTE5+hsER4HZ4OEvVpbNqzSlgfCRFAxCcH
         HM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=JBS03H4uRLUR2EgOFHZmaNhSFlst2NLvvy3orFIKe38=;
        b=Z/0BnKXrl1PIsCknzxM1LiiyBim8q+kjy4dYscFYt26+9gFYRLcfx0IZiL5nIhjte4
         I6NXQbyzn3UVekkdThRrvRx2kiIAtmnL/2v1BHKctBWsxqX3u1xCaM61ciXv+4fQaP7v
         hC60a0xh7EZYQwFct464FlQEgqw+a3aU1pMCRtfvs6/oeF9xM0dyjfUwsqfAyuIUmMYr
         hvKbjT2e7dt2lRDpatUOXYd1gQd7UjNan9HO55NZDqMFiBKi1GdiD5dUpym3G8okBsTl
         8CY3Wad7hYtaMtKu2YlXJel4rtAIza9pVlnE7B+Rjz+Fx0wjlN6t27RFxiRZiIcYlilF
         QIww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Date: Tue, 27 Feb 2018 08:25:24 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Yong Deng <yong.deng@magewell.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Todor Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v8 2/2] media: V3s: Add support for Allwinner CSI.
Message-ID: <20180227072524.5pjoxoo4yowfw43v@flea>
References: <1519697566-32600-1-git-send-email-yong.deng@magewell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fkl5txttwye7c5om"
Content-Disposition: inline
In-Reply-To: <1519697566-32600-1-git-send-email-yong.deng@magewell.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590918123212414894?=
X-GMAIL-MSGID: =?utf-8?q?1593538066585822307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--fkl5txttwye7c5om
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 10:12:46AM +0800, Yong Deng wrote:
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
>=20
> This patch implement a v4l2 framework driver for it.
>=20
> Currently, the driver only support the parallel interface. MIPI-CSI2,
> ISP's support are not included in this patch.
>=20
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fkl5txttwye7c5om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqVB+MACgkQ0rTAlCFN
r3SN/g//bxWocMt6hu3dxRXkZ1oj77FTZkLTsoNzIlcd1zh+buI3HHSoWYilOeVU
zLJj0nokWoF9FRuryNqiDXFjhOiRqLb3mgvu6HRRWVuQ7xwr1X3IN1ntG8aSy+5m
zy5xCT89S24QkcZNalZ0YKCM/qs2i12AXw6LMLFdoABeNz9WygFI3tch1qIX/CwT
IFQVh8ATY0RlYp275+A2OjzB5GSqbIeyMKjaPjWkIVP8iV3KkcuXvIjfMmnqm5Ok
HvMDJopDYu+95krEEeue82nhFzMSa4npAdu7Vxq2cNS88txV6zj/3dURt7CWk/v6
B/X2kKU3jH4HZ40BeNeuulSQdmSIlIPZEpYruiqimvurxqNKAQqBOnsiRGU+WWBh
9HRhhB7/8rSkZj5Dq/Xbrm/4zP1+lAYDL7nHgQeuFBIdosvvQYbzwhnnrbBIN/oU
qcwIrsjnz9wxzh5QbIMlEIXKLJBpFgmotgbc+A/QqUWzidoYp26JJScFeXcI68H7
oNW3O3XMdP8q3Q3O8YyWklhHMvEFvo8UBiqf4Fo6J1cYwMxPnL8N/yFQwzNuxyLJ
1j1tSxAepyrSHj6nvCq+HYMjmbODLCzxlS9Rk86PTM5vNAxNo6bQKxT+HVauwHfd
JprB6jgC6mCJaqCugHCB+H14H8KdOdSOsL9f3UpfRoEkf5bgYJ8=
=Kft4
-----END PGP SIGNATURE-----

--fkl5txttwye7c5om--
