Return-Path: <thierry.reding@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522764252; cv=none;
        d=google.com; s=arc-20160816;
        b=EwKSDlevQMYYHZwYk8N3fctMLUyW7jB26QvL0P/3BS7BcfBDtbmlzDXxOxyQuqQIhX
         UWSDY4J08xmrBjifxK/4hbiP1MHaWsAvN3LvpJRNnamYEshtAr68oqX7PzGe1MvuaryX
         sVfCRrr2Yk7goEfMLAwFuYvwiIaYBhtsvRtgRAVcfxdwUgdvjwhV6Imj5VLemBNp0dv/
         4Gwv2CRLLo+TMcMVx6yiUKPMY2ozynQ7eOki52fXR7L1FuSI2UqiCdHBoJyKTH1YNH7G
         4WvMmVLYk5VzXMeiTIwbUNQyZCivNoAkv2wpn7mghtrOD0/R93AX6XSGLcOuCSYm9TQi
         gUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=2HGmpWmX0VFhunsqOL+eCbCpSguYBXUwXQj4R396eNQ=;
        b=leWSvaC6TDBUne8ha1E+l30XPTSMPz620hA0mEm5Njm5rkrQm2H9SBqG4GiWqwcO/D
         J/B0D1raTUFm0hH9A9FkmuEDF7lC0WP1tQ1cRPp0wcc7SfS58YebuXHxyE2drijrO4G7
         7t6Vj2nkFnW7oZ1I3nEwyb5pwjwaj3pXSnmfr1FE7Y33iDRBFjY/9rZ1fEOZhfybuOoF
         6s9XBohJZHOSFTLe+ptYYn12phGZ2k0QJBYxs15fGbQ1ohfQ/G6m566MiYAjUN8LiTt8
         Vw2Ypdj3+poH8PB6vpFqOTVcIIIO8V98bOHvm3KD+nXsEXPdH9NHAKFN9A6TahVg/4fl
         iaxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZGhDkTgR;
       spf=pass (google.com: domain of thierry.reding@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thierry.reding@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZGhDkTgR;
       spf=pass (google.com: domain of thierry.reding@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thierry.reding@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/BK6qSqLI6j8FTdMAF5by7Kb4I1WbbgR7l3tK7PFC4IPex0xGUmhknnJXWS4MBO8/ELR5fqQ==
Date: Tue, 3 Apr 2018 16:04:10 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: John Garry <john.garry@huawei.com>
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org,
	lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	robh+dt@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	mark.rutland@arm.com, olof@lixom.net, dann.frazier@canonical.com,
	andy.shevchenko@gmail.com, robh@kernel.org,
	andriy.shevchenko@linux.intel.com, joe@perches.com,
	benh@kernel.crashing.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, minyard@acm.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, rdunlap@infradead.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	frowand.list@gmail.com, agraf@suse.de
Subject: Re: [PATCH v17 01/10] LIB: Introduce a generic PIO mapping method
Message-ID: <20180403140410.GE27789@ulmo>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <1521051359-34473-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938019743784580?=
X-GMAIL-MSGID: =?utf-8?q?1596734048508644560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 02:15:50AM +0800, John Garry wrote:
> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>=20
> In commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
> pci_pio_to_address()"), a new I/O space management was supported. With
> that driver, the I/O ranges configured for PCI/PCIe hosts on some
> architectures can be mapped to logical PIO, converted easily between
> CPU address and the corresponding logicial PIO. Based on this, PCI
> I/O devices can be accessed in a memory read/write way through the
> unified in/out accessors.
>=20
> But on some archs/platforms, there are bus hosts which access I/O
> peripherals with host-local I/O port addresses rather than memory
> addresses after memory-mapped.
>=20
> To support those devices, a more generic I/O mapping method is introduced
> here. Through this patch, both the CPU addresses and the host-local port
> can be mapped into the logical PIO space with different logical/fake PIOs.
> After this, all the I/O accesses to either PCI MMIO devices or host-local
> I/O peripherals can be unified into the existing I/O accessors defined in
> asm-generic/io.h and be redirected to the right device-specific hooks
> based on the input logical PIO.
>=20
> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Tested-by: dann frazier <dann.frazier@canonical.com>
> ---
>  include/asm-generic/io.h  |   2 +
>  include/linux/logic_pio.h | 124 ++++++++++++++++++++
>  lib/Kconfig               |  15 +++
>  lib/Makefile              |   2 +
>  lib/logic_pio.c           | 282 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 425 insertions(+)
>  create mode 100644 include/linux/logic_pio.h
>  create mode 100644 lib/logic_pio.c
>=20
[...]
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> new file mode 100644
> index 0000000..8394c2d
> --- /dev/null
> +++ b/lib/logic_pio.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
> + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> + *
> + */
> +
> +#define pr_fmt(fmt)	"LOGIC PIO: " fmt
> +
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/logic_pio.h>
> +#include <linux/mm.h>
> +#include <linux/rculist.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +
> +/* The unique hardware address list. */
> +static LIST_HEAD(io_range_list);
> +static DEFINE_MUTEX(io_range_mutex);
> +
> +/* Consider a kernel general helper for this */
> +#define in_range(b, first, len)        ((b) >=3D (first) && (b) < (first=
) + (len))
> +
> +/**
> + * logic_pio_register_range - register logical PIO range for a host
> + * @new_range: pointer to the io range to be registered.
> + *
> + * returns 0 on success, the error code in case of failure
> + *
> + * Register a new io range node in the io range list.
> + */
> +int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
> +{
> +	struct logic_pio_hwaddr *range;
> +	resource_size_t start =3D new_range->hw_start;
> +	resource_size_t end =3D new_range->hw_start + new_range->size;
> +	resource_size_t mmio_sz =3D 0;
> +	resource_size_t iio_sz =3D MMIO_UPPER_LIMIT;
> +	int ret =3D 0;
> +
> +	if (!new_range || !new_range->fwnode || !new_range->size)
> +		return -EINVAL;
> +
> +	mutex_lock(&io_range_mutex);
> +	list_for_each_entry_rcu(range, &io_range_list, list) {
> +		if (range->fwnode =3D=3D new_range->fwnode) {
> +			/* range already there */
> +			ret =3D -EFAULT;
> +			goto end_register;
> +		}

This is the -EFAULT that propagates to pci-tegra.c's ->probe() and fails
to bind the driver.

I'm not exactly sure what's causing the duplicate here because it's
rather difficult to get at something useful from just the ->fwnode, but
I'm fairly sure that the reason this breaks is because the Tegra driver
will defer probe due to some regulators that aren't available on the
first try. Given the above code and the rest of this file, I can't see a
way to "fix" the driver and remove the I/O range on failure.

This is doubly bad because this doesn't only leak the ranges on probe
deferral, but also on driver unload, and we just added support for
building the Tegra driver as a loadable module, so these are actually
cases that can happen in regular uses of the driver.

I have no idea on how to fix this. Anyone know of a quick fix to restore
PCI for Tegra other than reverting all of these changes?

I suppose an API could be added to unregister the range, but the calling
sequence is rather obfuscated, so removing the range will look totally
asymmetric, I'm afraid.

Here's the call stack:

	tegra_pcie_probe()
	tegra_pcie_parse_dt()
	of_pci_range_to_resource()
	pci_register_io_range()
	logic_pio_register_range()

So the range here is registered as part of a resource parsing function,
which is supposed to not have any side-effects. There's no equivalent of
that parsing routine (i.e. no "unparse" function that would undo the
effects of parsing).

Perhaps a cleaner way would be to decouple the parsing from the actual
request step that has the side-effect.

Going back in history a little, it looks like even before this commit
the I/O range registration was triggered by the parsing code and even
the range leak was there, except that it caused pci_register_io_range()
to return 0 rather than -EFAULT. Perhaps the quickest fix for this would
be to do the same in the new code and restore drivers that accidentally
depend on this behaviour.

Thierry

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrDidcACgkQ3SOs138+
s6GjMRAAsdA9Lv46KoBrexlZDNVztMdkPS1Bp8fl6l7fvdjMooivQMMzvG/jVypT
mfVmbS3QNT3OjSFUcOBvCz2c997s+hO1YBS9ULM44j4JoxRB+ZcI0XZ0q5nBoy1X
92PXDUMLvYc0QNOSXFjtLJEKsgaqx9jk7KWWc6Gxzqtmwrtsa1NiJ25AmvWUc3cT
KjTRCsafK+EsbpeKGuly5JyzHgBVdrv4u2zD+QN/47fGjP46/frWDDZ1NicK49HE
78nRx3JgsjeOjynGdwrzSHsIQbI2I28EhSpa1XgIMCoLeR2PAv4nZOSld+uCTD9z
gKf+0pAaFYkRRCF4g2Y2SvGlkYeCrDXFBPaPgDT4EA3G63jGq6Ha0sje7cRbhmQj
/Ug7wkYzEyy1ZjJPPamq/v6jjYb59c96qFmvnqM+EaZg2doPOKpBhjxnlOrPrHcA
BWbb/1o5bGaJJ6VMXAziJV1720ikIKrN+zl0NIyGmEI77HEQFhZEIxukNsEyGMjq
iPIyac4FUa45RHdSidU5iOexGOI4gtnYzxp+n7gC62IwUKIwtjL0S/dr/W1q3STa
upDhJXn0xtRRK2FUvxlYQ+GRiyrDKjhrQoIfu76piBebaaiG4H6cRY7KOmLZWAeP
G1I+D6aFtABWx4O1MmVDKc6z+riGllVkveiqPnauyfg0wzzCwhk=
=wuHb
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
