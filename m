Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HA37KP9wHFunXAAAmS7hNA
	; Sun, 10 Jun 2018 00:29:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8C3BD608BA; Sun, 10 Jun 2018 00:29:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0upaJi1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CE7DE605A2;
	Sun, 10 Jun 2018 00:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE7DE605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753571AbeFJA3s (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 20:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751254AbeFJA3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 20:29:47 -0400
Received: from mail.kernel.org (host-091-097-086-238.ewe-ip-backbone.de [91.97.86.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3159B2089F;
        Sun, 10 Jun 2018 00:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528590586;
        bh=V6MpmzO96YHYDMlJkjPinczpZ2tTJK/8/jwhmTu7/9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0upaJi1XBW6lRaNDz04kVjh/+R5scbAjT9c2SxZCSzVIW3YovB2iiQpP+z4x72iu
         BUp3ks1wAO8X3pD1K9tYqqH7uZwfq5tzPX2j0+y/7gsY1woq9lCwxFseGGpvPBG93k
         bgLJRpKH+U7avZPqbyYZlypquV8LJV5gpfsIFdgM=
Date: Sun, 10 Jun 2018 02:29:44 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: remove unused bt-nokia-h4p.h header
Message-ID: <20180610002944.ivdgzojt2akquwwv@earth.universe>
References: <1528401038-36287-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3mog5phdl7t5ijen"
Content-Disposition: inline
In-Reply-To: <1528401038-36287-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3mog5phdl7t5ijen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 07, 2018 at 07:50:38PM +0000, Corentin Labbe wrote:
> Nothing in tree use this header which seems a remains of a staging
> driver.
> This patch remove it.
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Right, this is not used by drivers/bluetooth/hci_nokia.c, but a
leftover from the staging driver.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  include/linux/platform_data/bt-nokia-h4p.h | 38 ------------------------=
------
>  1 file changed, 38 deletions(-)
>  delete mode 100644 include/linux/platform_data/bt-nokia-h4p.h
>=20
> diff --git a/include/linux/platform_data/bt-nokia-h4p.h b/include/linux/p=
latform_data/bt-nokia-h4p.h
> deleted file mode 100644
> index 30d169dfadf3..000000000000
> --- a/include/linux/platform_data/bt-nokia-h4p.h
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -/*
> - * This file is part of Nokia H4P bluetooth driver
> - *
> - * Copyright (C) 2010 Nokia Corporation.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
> - *
> - */
> -
> -
> -/**
> - * struct hci_h4p_platform data - hci_h4p Platform data structure
> - */
> -struct hci_h4p_platform_data {
> -	int chip_type;
> -	int bt_sysclk;
> -	unsigned int bt_wakeup_gpio;
> -	unsigned int host_wakeup_gpio;
> -	unsigned int reset_gpio;
> -	int reset_gpio_shared;
> -	unsigned int uart_irq;
> -	phys_addr_t uart_base;
> -	const char *uart_iclk;
> -	const char *uart_fclk;
> -	void (*set_pm_limits)(struct device *dev, bool set);
> -};
> --=20
> 2.16.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--3mog5phdl7t5ijen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsccPUACgkQ2O7X88g7
+pognA//Uk9rcAkWZyykAdmm+Xd9JmHjPotXeRxM+Rb1Hum7p4CPqov5g2gAvSaX
11OKnCqUwbBPgQJcIg0fxWAZqEuYwH2re4mohb6UPNF+8TxaKe2XmafiuMxygons
2zJzyF65f7tF1E5qk9mNuJMg+O2VkA3Zt5S6VnaCBpdEAtij98cwg3aPieKdaLvn
eIb9P44AxowvQv/Q9E4YiRAgX71s37XAPK+7jn7l3FJEMRhL3B9t/V8Br+ig3BGl
sWtemkcPA8cak3wC9k4zTkn03LPE6SLgeooh5M3LUdv0jgFbiSit2nZ45JLYdOEL
SRK3zKuKsUQ69vWHi+gl2f0WRbfElvbUnz4sQWkQ8uP2YHe9nmGMJYexHw74MKF9
WSPJ60UrM4svPuF4NNPaR26ao3YnhXyrVQh9CUOHsF3Vqw8mmMdoQ/1QRZvMV7pQ
0Gx8P/tAbGeTNZEc5TBbDFAgmriXf96ZedP1hUnhOC8GVSG6cszcKPQEmvsZ1ryK
E4KkE9maTgooIn0NYddLHWBq5euf+ve0//lGbsFOwzinbWpnW5w+nrUCCV2EWjD5
ilVlc3v5gq+ZPYYwIX6zn7doOSrcbLBseu8oc/1BDzZwj2cIIYzlX5kkaLwbzUXY
QWQa839Pv4VHmkzH1SQpxHAmS9Ct3R9oGqx9eNzN1tmNgT66+Xo=
=dS1p
-----END PGP SIGNATURE-----

--3mog5phdl7t5ijen--
