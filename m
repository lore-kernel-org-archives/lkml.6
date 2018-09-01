Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337FBC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E642083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E642083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeIAQ4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:56:15 -0400
Received: from sauhun.de ([88.99.104.3]:38658 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeIAQ4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:56:14 -0400
Received: from localhost (mue-88-130-111-030.dsl.tropolys.de [88.130.111.30])
        by pokefinder.org (Postfix) with ESMTPSA id 40DD036488B;
        Sat,  1 Sep 2018 14:44:17 +0200 (CEST)
Date:   Sat, 1 Sep 2018 14:44:16 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>
Subject: Re: [PATCH v5 5/7] i2c: designware: add MSCC Ocelot support
Message-ID: <20180901124416.GC1196@kunai>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
 <20180831151114.25739-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20180831151114.25739-6-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +int dw_i2c_of_configure(struct platform_device *pdev)

I made this 'static' as well.


--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluKiaAACgkQFA3kzBSg
KbYlpQ/8Dpz1rwpriPCRczKfGEpM49wx/FAypJOs0rSQQEjDcMgpYjRhUGZOHdL/
o/chajkvs1hyXilHjudAb99SuEqZyHk9cOJIoSurborwizJfsVRnZ0NIdb3BuWVb
XN8+eZ7CrEbWCOwv/PPC3glB9hkysLMOSU1xk4QPhTtAn1jv7LKd0ZN2HcALb6Ux
gTqjOxw26USwhuxswSP2LPO53SfHvdu83skDAtJSIcyDFRbDoXJELJBUzLvDS+LH
WuVNBSfUVKRGPK0GH/wB3ZQly5te0GDrMO6k1NQeJ8swGasTapDU9seEKAfcN0JO
NRsDDY0eJ/XcFMS2ew2+EH7B59rEhLuvNuZm6KvCf1xMcVeH01qGapOt17pQFkL7
1Aswcr/R512cI37O+HtwZY941lHX4f2/8nJ0LXnerxxJFZT1AnmBtoIuJRfCN+HV
EqezURSkVhHH6XhUxmsPPcG0L5IcHbu0RHbPaHa1AAVREk0anYXFyIY1JogrUHqs
XXowZch8YpIGsqLcussrU+noU49VCMuyllLr7K8pQHBvggTsuE3XFhGK9zTG5EFP
a0H3rHKDCCMH46F9s11MhvlCvRbjKd6vDKzzHCV/yU7qVP4h4sGcGEmjk2p8+pGq
n9MCZAfkMuoMpAwoACOP2TzGQonf0ZDMIzuPqux/+zMBE3foM0M=
=0MVY
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
