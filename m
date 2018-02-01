Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AH8x224wqSLJnoaOYYxRFrRZaXT0SezIhWVSeq4GF/OPJ6o6deckqPzhKAQD7JM7rK/prc6ufKoz
ARC-Seal: i=1; a=rsa-sha256; t=1517501162; cv=none;
        d=google.com; s=arc-20160816;
        b=iYFI7M0hSToDBdpBUQiYMV1I7ZA1SO4YTs07yIEYfHWiXPhApQq8S6fgj0utlbIeiQ
         dNf7LW8efVFmtGZ0AlvohDBnB5PEDHoRhFgdWvgmVOJJUnSRHXIxTSHHXa7MxKYFxB4s
         QnYqcKjMaXTVu9TnZwuknzOFfUU8Y8Gbx6r3F4+wthXgaTpAq8amQ0FcA85ftqsO3qyy
         SkX+QeN6GafbPW3M+Az9+CzBq5Mh4rQQ+P5rllo+J7hEjle0cdI+SLj122f7QIhPb3os
         yQ4DZn5WZqsn+c2aR8HGQT2AQGxG2agRxmi/dwsbeWFfA+shyD91nbXVxWtvwfItGSFL
         qlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=3wIU284uvhKwwskX/Z/XlHLcWgEei6SqjmpPZfOUWNo=;
        b=h27wG9lXS35XTX0LUFCAeATDG0BDQ9Xo25c9qk5MHQHDjHLMUrFwtrQsY0HpFNJMOp
         6rGD4pS4BIXmPvKAI+nk9KH+tthThcFRntBBpJJhEE39eppmkhZY3jaIPR4vEN4bl1bw
         6GydmE2JmMz2rZv3kA6p0ICYam1xX25WidEB+WaF3ypUSKkjCLyk45+6Nr0lxIcsjR2e
         nKkazaYRfy3n8GBUBopMoAvfRtG6hqoMx3lLp9pvDz45ghsbU9kMr9dJ4fLioHG04uTR
         hPMvORAq2YdQQm+bzWARJUwPIyy1MWkWU9MnBNlj0BNQFu4csfbtc0OfvmRew0F2xl4k
         V96g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A632178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 1 Feb 2018 16:05:54 +0000
From: James Hogan <jhogan@kernel.org>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: linux-mips@linux-mips.org, Miodrag Dinic <miodrag.dinic@mips.com>,
	Goran Ferenc <goran.ferenc@mips.com>,
	Aleksandar Markovic <aleksandar.markovic@mips.com>,
	"David S. Miller" <davem@davemloft.net>,
	Douglas Leung <douglas.leung@mips.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Petar Jovanovic <petar.jovanovic@mips.com>,
	Raghu Gandham <raghu.gandham@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v12 3/3] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Message-ID: <20180201160553.GL7637@saruman>
References: <1514562138-13774-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1514562138-13774-4-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z9t8O/5YJLB6LEUl"
Content-Disposition: inline
In-Reply-To: <1514562138-13774-4-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588133636070344770?=
X-GMAIL-MSGID: =?utf-8?q?1591215298566102495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Z9t8O/5YJLB6LEUl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2017 at 04:41:47PM +0100, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
>=20
> Provide amendments to the MIPS generic platform framework so that
> the new generic-based board Ranchu can be chosen to be built.
>=20
> The Ranchu board is intended to be used by Android emulator. The name
> "Ranchu" originates from Android development community. "Goldfish" and
> "Ranchu" are terms used for two generations of virtual boards used by
> Android emulator. The name "Ranchu" is a newer one among the two, and
> this patch deals with Ranchu. However, for historical reasons, some
> devices/drivers still contain the name "Goldfish".
>=20
> MIPS Ranchu machine includes a number of Goldfish devices. The support
> for Virtio devices is also included. Ranchu board supports up to 16
> Virtio devices which can be attached using Virtio MMIO Bus. This is
> summarized in the following picture:
>=20
>        ABUS
>         ||----MIPS CPU
>         ||       |                    IRQs
>         ||----Goldfish PIC------------(32)--------
>         ||                     | | | | | | | | |
>         ||----Goldfish TTY------ | | | | | | | |
>         ||                       | | | | | | | |
>         ||----Goldfish RTC-------- | | | | | | |
>         ||                         | | | | | | |
>         ||----Goldfish FB----------- | | | | | |
>         ||                           | | | | | |
>         ||----Goldfish Events--------- | | | | |
>         ||                             | | | | |
>         ||----Goldfish Audio------------ | | | |
>         ||                               | | | |
>         ||----Goldfish Battery------------ | | |
>         ||                                 | | |
>         ||----Android PIPE------------------ | |
>         ||                                   | |
>         ||----Virtio MMIO Bus                | |
>         ||    |    |    |                    | |
>         ||    |    |   (virtio-block)--------- |
>         ||   (16)  |                           |
>         ||    |   (virtio-net)------------------
>=20
> Device Tree is created on the QEMU side based on the information about
> devices IO map and IRQ numbers. Kernel will load this DTB using UHI
> boot protocol DTB handover mode.
>=20
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> Reviewed-by: James Hogan <jhogan@kernel.org>

Applied to my 4.16 branch,

Thanks
James

> ---
>  MAINTAINERS                                   |  7 ++
>  arch/mips/configs/generic/board-ranchu.config | 30 +++++++++
>  arch/mips/generic/Kconfig                     | 10 +++
>  arch/mips/generic/Makefile                    |  1 +
>  arch/mips/generic/board-ranchu.c              | 92 +++++++++++++++++++++=
++++++
>  5 files changed, 140 insertions(+)
>  create mode 100644 arch/mips/configs/generic/board-ranchu.config
>  create mode 100644 arch/mips/generic/board-ranchu.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e163873..95679c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11442,6 +11442,13 @@ S:	Maintained
>  F:	Documentation/blockdev/ramdisk.txt
>  F:	drivers/block/brd.c
> =20
> +RANCHU VIRTUAL BOARD FOR MIPS
> +M:	Miodrag Dinic <miodrag.dinic@mips.com>
> +L:	linux-mips@linux-mips.org
> +S:	Supported
> +F:	arch/mips/generic/board-ranchu.c
> +F:	arch/mips/configs/generic/board-ranchu.config
> +
>  RANDOM NUMBER DRIVER
>  M:	"Theodore Ts'o" <tytso@mit.edu>
>  S:	Maintained
> diff --git a/arch/mips/configs/generic/board-ranchu.config b/arch/mips/co=
nfigs/generic/board-ranchu.config
> new file mode 100644
> index 0000000..fee9ad4
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-ranchu.config
> @@ -0,0 +1,30 @@
> +CONFIG_VIRT_BOARD_RANCHU=3Dy
> +
> +CONFIG_BATTERY_GOLDFISH=3Dy
> +CONFIG_FB=3Dy
> +CONFIG_FB_GOLDFISH=3Dy
> +CONFIG_GOLDFISH=3Dy
> +CONFIG_STAGING=3Dy
> +CONFIG_GOLDFISH_AUDIO=3Dy
> +CONFIG_GOLDFISH_PIC=3Dy
> +CONFIG_GOLDFISH_PIPE=3Dy
> +CONFIG_GOLDFISH_TTY=3Dy
> +CONFIG_RTC_CLASS=3Dy
> +CONFIG_RTC_DRV_GOLDFISH=3Dy
> +
> +CONFIG_INPUT_EVDEV=3Dy
> +CONFIG_INPUT_KEYBOARD=3Dy
> +CONFIG_KEYBOARD_GOLDFISH_EVENTS=3Dy
> +
> +CONFIG_MAGIC_SYSRQ=3Dy
> +CONFIG_POWER_SUPPLY=3Dy
> +CONFIG_POWER_RESET=3Dy
> +CONFIG_POWER_RESET_SYSCON=3Dy
> +CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
> +
> +CONFIG_VIRTIO_BLK=3Dy
> +CONFIG_VIRTIO_CONSOLE=3Dy
> +CONFIG_VIRTIO_MMIO=3Dy
> +CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=3Dy
> +CONFIG_NETDEVICES=3Dy
> +CONFIG_VIRTIO_NET=3Dy
> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index 52e0286..2ff3b17 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -49,4 +49,14 @@ config FIT_IMAGE_FDT_XILFPGA
>  	  Enable this to include the FDT for the MIPSfpga platform
>  	  from Imagination Technologies in the FIT kernel image.
> =20
> +config VIRT_BOARD_RANCHU
> +	bool "Support Ranchu platform for Android emulator"
> +	help
> +	  This enables support for the platform used by Android emulator.
> +
> +	  Ranchu platform consists of a set of virtual devices. This platform
> +	  enables emulation of variety of virtual configurations while using
> +	  Android emulator. Android emulator is based on Qemu, and contains
> +	  the support for the same set of virtual devices.
> +
>  endif
> diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
> index 8749673..5fb60c8 100644
> --- a/arch/mips/generic/Makefile
> +++ b/arch/mips/generic/Makefile
> @@ -15,3 +15,4 @@ obj-y +=3D proc.o
>  obj-$(CONFIG_YAMON_DT_SHIM)		+=3D yamon-dt.o
>  obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+=3D board-sead3.o
>  obj-$(CONFIG_KEXEC)			+=3D kexec.o
> +obj-$(CONFIG_VIRT_BOARD_RANCHU)	+=3D board-ranchu.o
> diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-r=
anchu.c
> new file mode 100644
> index 0000000..ea451b8
> --- /dev/null
> +++ b/arch/mips/generic/board-ranchu.c
> @@ -0,0 +1,92 @@
> +/*
> + * Support code for virtual Ranchu board for MIPS.
> + *
> + * Author: Miodrag Dinic <miodrag.dinic@mips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> + * option) any later version.
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/types.h>
> +
> +#include <asm/machine.h>
> +#include <asm/mipsregs.h>
> +#include <asm/time.h>
> +
> +#define GOLDFISH_TIMER_LOW		0x00
> +#define GOLDFISH_TIMER_HIGH		0x04
> +
> +static __init u64 read_rtc_time(void __iomem *base)
> +{
> +	u32 time_low;
> +	u32 time_high;
> +
> +	/*
> +	 * Reading the low address latches the high value
> +	 * as well so there is no fear that we may read
> +	 * inaccurate high value.
> +	 */
> +	time_low =3D readl(base + GOLDFISH_TIMER_LOW);
> +	time_high =3D readl(base + GOLDFISH_TIMER_HIGH);
> +
> +	return ((u64)time_high << 32) | time_low;
> +}
> +
> +static __init unsigned int ranchu_measure_hpt_freq(void)
> +{
> +	u64 rtc_start, rtc_current, rtc_delta;
> +	unsigned int start, count;
> +	struct device_node *np;
> +	void __iomem *rtc_base;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "google,goldfish-rtc");
> +	if (!np)
> +		panic("%s(): Failed to find 'google,goldfish-rtc' dt node!",
> +		      __func__);
> +
> +	rtc_base =3D of_iomap(np, 0);
> +	if (!rtc_base)
> +		panic("%s(): Failed to ioremap Goldfish RTC base!", __func__);
> +
> +	/*
> +	 * Poll the nanosecond resolution RTC for one
> +	 * second to calibrate the CPU frequency.
> +	 */
> +	rtc_start =3D read_rtc_time(rtc_base);
> +	start =3D read_c0_count();
> +
> +	do {
> +		rtc_current =3D read_rtc_time(rtc_base);
> +		rtc_delta =3D rtc_current - rtc_start;
> +	} while (rtc_delta < NSEC_PER_SEC);
> +
> +	count =3D read_c0_count() - start;
> +
> +	/*
> +	 * Make sure the frequency will be a round number.
> +	 * Without this correction, the returned value may vary
> +	 * between subsequent emulation executions.
> +	 *
> +	 * TODO: Set this value using device tree.
> +	 */
> +	count +=3D 5000;
> +	count -=3D count % 10000;
> +
> +	iounmap(rtc_base);
> +
> +	return count;
> +}
> +
> +static const struct of_device_id ranchu_of_match[] __initconst =3D {
> +	{
> +		.compatible =3D "mti,ranchu",
> +	},
> +};
> +
> +MIPS_MACHINE(ranchu) =3D {
> +	.matches =3D ranchu_of_match,
> +	.measure_hpt_freq =3D ranchu_measure_hpt_freq,
> +};
> --=20
> 2.7.4
>=20

--Z9t8O/5YJLB6LEUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzOuEACgkQbAtpk944
dnpZiQ/+I6oBHfiF5A16H32Tz4V+pWGgIB3MC0IV85s9kcOS+w+QOq0Xep/9Be12
9ALUJEIk4xcBNCzfnsFfNqc7w7Q/VpdMsiFMpO8bMsRyqaCMjjKHVMQSdk+5Cm4j
W4acIqBNki0wr6a3AWvbJuOgy4gYZbPNyS9JodR7FIPf1uu+nk732cIuTxYIwpf5
6QLiI6zsgGjNmvy1c94bR1zfjnqZ2ZaEieXIB9Dx6U1jsrWk4GYsu2cnmguGjVXh
7vo4jTudSQVKRUjdQdi1bhnnQvFuR7jrWDx4razig88N19fMK4LMmUn77v7H2hfi
ba+gs5TiJLCpOslWVYAlwbtRgXJrn0SsALn8vOAwpZaDNnLUUJKnuKhLa7gwWqnR
sea+dd6vqTSxtnUYpfI8/+n4Lhzp9tzWTtYSuT97KYnqhtip7zDUqZQ5OAUveGux
U5tr8BQfLat53chBKsPYysPdq14v4D3SH20pJxnXSHms9j7EnAwCvD9PlPHMyNE5
4L+yrAVK+l75VWY2wD2igYtp4TZ0Tjg20+1JeWqV2wF4nQ5DQWpll5sQZrT2Lv4O
eLPfvg14yQwxsLXf/c1B7IgpJtAC+h5PAha0vC4kQ5Us0sSRUMcy2ui3dIaMjCFF
qJ47OmeUEe+HjY2ek2SYsgiMRotMKyWXRnd0LMJoYWX8JkXV5SA=
=ODB0
-----END PGP SIGNATURE-----

--Z9t8O/5YJLB6LEUl--
