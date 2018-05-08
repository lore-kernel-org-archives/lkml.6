Return-Path: <sre@kernel.org>
X-Google-Smtp-Source: AB8JxZofDftHHtnMr9uqixGuutMyNxW8+MSJ4DXx8RBZp8cMA34PVMqP30rflrv8v/AmCwtth6Wp
ARC-Seal: i=1; a=rsa-sha256; t=1525794972; cv=none;
        d=google.com; s=arc-20160816;
        b=SmzJU4gMASpDrdDdIHEMb7N2CBi6qLwBgNfw0jogqbr2rAOYOe1rAZmOpmHeH/zuOL
         5i40DkxY6PtFruBHyZqNZOBW6kmn4J12tbPdJE/rWcJBwdtinuCev3JrgkFqFgf/r9a0
         G/ws0qk9tNHf4JeJtGJfGq8xK71HkiUIAFl6Ix0MPXaZQlsuSurVu1N8JmF5uERHOPkZ
         fBxPCFCH46jwwNyDS2BhvXvEDYQGHDHhCf1qydELglJGensbbvsBzuS9MgfbpDTur1zd
         4jR/qEQKq7qaqm7mR+WUMAh+DR3RQUQV7bWL/qRA4yG/I/7QaiMwPqAvesHdJhJsy7Q/
         Kexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ijOzT+aIQerZtYYsNljxHAOvSQ7f7JzGg0jiWhNW6/4=;
        b=KkFK6C0ANyUx8wHnNUu4B04V38oJxdVZTAwP88BKgdOK0mUhsJ1B77Y2xW4FNJZ/Xm
         C3HTMCnsSrSgvvedHOZuZaGIBvOu4zLPRfbrji7VLBmTAbPAJnoCPqdfKfUFg2Xt/1da
         AoyQK20j/iS6OP6J5jFdzQd6AbDAzyKxAK4eQ1XEgrSTJ/wa5/0z1DNO5IV/V0Nmxxnz
         fjT3V7NDi1H0M2vSBsoURowZtFGTiZCIVSvqpvX6cBK1ZEvJkLD0SfM9gVJA4jOAGqS2
         nVZW6lSiaIb5toKZMAbI+TjkyW/A89fca9wyvbHfKjZhfI9IVMB/RnkHr4rWNuCaHWUH
         2puA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mrqvaQU7;
       spf=pass (google.com: domain of sre@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sre@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mrqvaQU7;
       spf=pass (google.com: domain of sre@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sre@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 17:56:08 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180508155608.3bzcbepsmoskhlox@earth.universe>
References: <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bb62bfpxgpire5os"
Content-Disposition: inline
In-Reply-To: <20180507163439.GV2285@localhost>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599911989125475609?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bb62bfpxgpire5os
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 07, 2018 at 06:34:39PM +0200, Johan Hovold wrote:
> On Mon, May 07, 2018 at 08:45:15AM -0700, Tony Lindgren wrote:
> > * Johan Hovold <johan@kernel.org> [180507 03:03]:
> > > On Fri, May 04, 2018 at 01:42:13PM +0200, Sebastian Reichel wrote:
> > >=20
> > > > Having said all of this, serdev does not yet support runtime PM (at
> > > > all). Tony is currently looking into it. Fortunately serdev allows
> > > > us to enable runtime PM by default (once implemented), since we know
> > > > the remote side and can (hopefully) avoid losing characters (i.e.
> > > > with sideband wakeup gpios).
> > >=20
> > > I'm not sure we want generic runtime-pm support for the controllers in
> > > the sense that the slave device state is always reflected by the seri=
al
> > > controller. Similar as for i2c and spi, we really only want to keep t=
he
> > > controller active when we are doing I/O, but we may want to keep a
> > > client active for longer.
> >=20
> > Yeah i2c seems to do the right thing where the bus takes care
> > of runtime PM.
>=20
> Yeah, but since serial is async in contrast to i2c/spi, we may not be
> able to push this entirely into core. The serdev drivers may need to
> indicate when they expect or need to do I/O by opening and closing the
> port. And this is how I implemented these first couple of gnss drivers.
>
> Also note that most serial driver do not do runtime pm while the port is
> open (as OMAP does), and doing so also has the drawbacks of lost
> characters etc. as Sebastian mentioned.

I think using open/close for runtime pm is good enough for GPS,
since it regularly sends data and draws lots of power anyways.
But devices, that have an out-of-band wakeup signal can do proper
runtime PM of the serial port without loosing characters.

Note, that OMAP does not reach deep idle states with active
serial port. This is not acceptable for low power devices.

> > > Take the u-blox driver in this series for example. As I'm using runti=
me
> > > PM to manage device power, user-space can chose to prevent the receiv=
er
> > > from runtime suspending in order to avoid lengthy (re-)acquisition ti=
mes
> > > in setups without a backup battery (by means of the power/control
> > > attribute).
> >=20
> > Sorry I don't seem to have that one, care to paste the subject
> > line of that patch?
>=20
> 	"[PATCH 5/7] gnss: add driver for u-blox receivers"
>=20
> 	https://lkml.kernel.org/r/20180424163458.11947-6-johan@kernel.org
>=20
> > > Note that serdev not enabling runtime pm for controllers is roughly
> > > equivalent to setting the .ignore_children flag, which is what we do =
for
> > > i2c and spi controller, and possibly what we want here too.

For I2C/SPI this works, since receive operations are initiated by
the controller. Unfortunately its harder to implement for async
serial. But I agree, that we may want to have runtime PM for the
serdev client and .ignore_children is the way to go.

I think the client API should allow two things:

1. minimal runtime PM support: The controller is runtime enabled
on serdev open and disabled on serdev close. This may be enough
for some clients and useful for writing new drivers.

2. full runtime PM support: The controller is sleeping by default
even with serdev open. The calls to write/change port settings/...
automatically enables the device, similar to i2c/spi. But there
must be additional functions to enable/disable runtime PM based
on a wakeup gpio or similar out-of-band information. It may be
enough to just provide:

int serdev_pm_runtime_get_sync(struct serdev_device *serdev) {
    pm_runtime_get_sync(&serdev->dev);
}

int serdev_pm_runtime_put_autosuspend(struct serdev_device *serdev) {
    pm_runtime_put_autosuspend(&serdev->dev);
}

-- Sebastian

--bb62bfpxgpire5os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrxyJYACgkQ2O7X88g7
+pqIHw/+M7vmp8dnlzGVLc2ieizD37GnGzygzVoj0YF75mA5E/lu4AXJhuG3hz5i
np4v6QDhEjQBMfU4FUYNuRCQeGUaxcWeV+IgUGIm6ZF7vGb5E7JFErTrAMvAXoOz
758e63iB6EXBtlRbs+E2Ju2OBhLhpUnlcYvCN/T9PRHXOT+qamq4VT9DqNZCOby1
uH/4N66dteZphu+3FCRj/O+r1+lgj+y+tZ4AZH2zUoLxSWpOdB48FOTu/9O+N9oE
aHd8nKbB1+aqae5yj855lFJPESfSFaMJUlcB50vdIsSmDAd6NXSRAsDP6mdoeRC0
1aGgTCRG1lPju0RAdZD6qN81S2tteT1WGkCbcmW4VtyrHegrGimEDyLH7nU2hU6z
I8G1tGFqZtJDmoUgzTscAq5PkJptzINeBMy9eFOxDy5j/V1sWXmgAzS9gfFbvnaW
a9lBCBTnxgnHocx+bKDjYnL/72z8yf9dy2Z5rzbcEHLZrR6VNElu8YZyFYVIFDaO
NPQeXrpTaWHl29cCsmVrWu0AZ/2cnRrIJcn5tj/R9biJGAicy0mlkMlqm6I0w7Tx
5RS5GFzwD+5nRAo0ddXmAqEXiLX6qcKGZ8PidXO/f08KnWFcW9E2BC/1ypQFlLfH
RMaCSxi5GD9Noiqh/40gVJ6A1Dx8hw9gWF+3wiNCXVVRLFsxT0o=
=cJi6
-----END PGP SIGNATURE-----

--bb62bfpxgpire5os--
