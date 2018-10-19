Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F8ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAFB21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Pk2a7+lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAFB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJSUCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:02:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSUCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z8P7+dNT9o+sk6gh3sTI29Hs0l96xz/pOc2hLzwLXIQ=; b=Pk2a7+lLg/d8HmWGyt9HXQNK1
        poTs6YSSrZNQo6ay8Zu0sTAOT2D2gppnSyOy7CCFmjtYmHdQFQgzcbXVSSdtQo6ExV1E0mgIQTSjQ
        /wUTfGWlTeTgDv16knpWYrtnwRfR+iq3bL1NjGX0LTMWvRGWLSk/E6QWLRzBJNQ1FpJbw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTOe-0008RU-PU; Fri, 19 Oct 2018 11:56:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5B9691122548; Fri, 19 Oct 2018 12:56:52 +0100 (BST)
Date:   Fri, 19 Oct 2018 12:56:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     afaerber@suse.de, Ben Whitten <ben.whitten@lairdtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] regmap: Add regmap_noinc_write API
Message-ID: <20181019115652.GD5895@sirena.org.uk>
References: <1539941631-4421-1-git-send-email-ben.whitten@lairdtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <1539941631-4421-1-git-send-email-ben.whitten@lairdtech.com>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 10:33:50AM +0100, Ben Whitten wrote:
> The regmap API had a noinc_read function added for instances where devices
> supported returning data from an internal FIFO in a single read.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-noinc-write

for you to fetch changes up to cdf6b11daa77d4b55ddf0530842a551cc5562a93:

  regmap: Add regmap_noinc_write API (2018-10-19 12:51:19 +0100)

----------------------------------------------------------------
regmap: Add noinc write support

Mirroring the read support

----------------------------------------------------------------
Ben Whitten (1):
      regmap: Add regmap_noinc_write API

 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 77 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h         | 19 +++++++++++
 3 files changed, 99 insertions(+)

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJxoMACgkQJNaLcl1U
h9BvFwf/Q+S/rFvNeLEMykZrSCknRpGVos2CKVdAjwOiAom+zd2k0FmTfMbrHjEM
PJ08CYjMP6NccYNcouYHo4HehZvjRYpoFssghc0PvuxRxHtOYx9PE9R6mzTxe6kz
CjI3778g6lymDnzM6xPHL6tntY+ipgo3mD83ts+auz+01Pvo3Ol9G6A+TgpF8bPk
gmCxMQ8kMLJTW6jIEfvRbBR3PnV6EZInohX1xPiQGBQOOdE3krniPv14yXRRcL+T
tx47fwzpB4he87fDcUA6o5jSqTN+Y3C58L6ArARAS07BM9lGUb8QECRTqU4vBRa5
SKoJoxCXDYHG9+jVv+n/LEFKHONcRg==
=G+fi
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
