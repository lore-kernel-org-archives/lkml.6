Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E26DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CA4206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbeLQNtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:49:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:32331 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeLQNtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:49:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 05:49:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="asc'?scan'208";a="101307730"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2018 05:49:04 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, sandeep.singh@amd.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: fix 'broken_suspend' placement in struct xchi_hcd
In-Reply-To: <20181217133740.5342-1-nsaenzjulienne@suse.de>
References: <20181217133740.5342-1-nsaenzjulienne@suse.de>
Date:   Mon, 17 Dec 2018 15:49:00 +0200
Message-ID: <87k1k8gt6b.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> As commented in the struct's definition there shouldn't be anything
> underneath it's 'priv[0]' member as it would break some macros.
             its?

I guess Mathias can fix when applying.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwXqUwACgkQzL64meEa
mQZVDRAAp6nsw50xGfcrlRda+ZPVb7utKlccEpHWNSlw+h1EFOQxi9Ao3rXy6XNo
nvLmebanUuYpkH4k4eYaWt+J8u6/9aghO866NFQbYd+tQ+3cQWuU28wBgYiPf2q0
apaTgINKoPwP3Xr4FeUXBwAqO0gycyG21unsClyS4YOGykMTKkbbb64As6h2i42Y
NO08TSeYE87rfvR5ZaPdUo3qFIUKODNEglrMXwGyHX4kzhcY15Vuol1/RUsPPf3h
A5JqRBvQo57BUiw/kN+Jl2J56OCvb6p9TUNWmfGRE7ww6c+nEVrvuR+/TBIvkidT
KzEnpJK74pTzplW3yxx6l4B3pcvyMfmPWuAWOl6Y5UeES1qShIFYbcFv2bZXSip9
foJaHgCNmRaWe5sDokTER7vfheElp0/p6yNv4yOqosDQ9acaMiSTe8az6xOZX0yn
Ls3hYA9yjXz6o2aqIZXtEANIQ6ZXZ1joJg/owYb5WweIS8mE81wxrvK5i516NZIQ
bM5Vi8QBdWg/4kXoSRJWS8QTLZblXbXhKwPfZSPRZXP5iCzV6alM7MSjwsyifp0X
gsjPq6RaL2Th2SyPOFrBIthtdCGAvgH7/3aG10fS9NDRhPpAxBzwdBF81Uc/mk2P
Bg0wnckiG8MOyinErmMS/pCmnlzrbpexAVapvjdqiguL9lTs1dc=
=tbVy
-----END PGP SIGNATURE-----
--=-=-=--
