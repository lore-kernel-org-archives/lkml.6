Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C15FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37652156B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37652156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbeHGNlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:41:00 -0400
Received: from sauhun.de ([88.99.104.3]:52054 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeHGNk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:40:59 -0400
Received: from localhost (p54B338D2.dip0.t-ipconnect.de [84.179.56.210])
        by pokefinder.org (Postfix) with ESMTPSA id 95540685D36;
        Tue,  7 Aug 2018 13:27:05 +0200 (CEST)
Date:   Tue, 7 Aug 2018 13:27:02 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
Message-ID: <20180807112701.5iukqa6m5atf22fw@ninjato>
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rjsufeh33ovopkb5"
Content-Disposition: inline
In-Reply-To: <20180807080539.17811-5-hdegoede@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rjsufeh33ovopkb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

> +I2C MULTI INSTANTIATE DRIVER
> +M:	Hans de Goede <hdegoede@redhat.com>
> +L:	linux-i2c@vger.kernel.org

Since this driver is about FW bugs, I wonder if
platform-driver-x86@vger.kernel.org isn't the better list here?

> +S:	Maintained
> +F:	drivers/drivers/platform/x86/i2c-multi-instantiate.c

I2C parts of the rest looks good from a glimpse...


--rjsufeh33ovopkb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltpggIACgkQFA3kzBSg
Kba4jRAAon1GKq0XmtS0zG9XMo/h248W2ggHZqJyoYs0MskEWYOdp6hq7nAiez8e
p5BfOL6gahXCLg7inoputCpes+XDQ7TiWuChUDxgbcSH4WnTnSVI5kk28QTrOfPd
jebCKyHlcXecWWizRGPTydpHl1UuwWLUeogICpgjuTeqP0g38ahbPqhSa8lvUnzl
xnV9o/YWb7Z0gZy/HZWZhCTNfXqbUfaseK5x62bCYnxHXgjyZ/rwM2Gg4rPYMb6k
bk/agC6CWhU3CWpZ7Ja298sE2GSlzFRhE/Zc1VjpMEZWbAhyQqwxeQuliLY2EI0z
xl4FsFQ4uwGDdqk6Qm1SwnkhHWnhys4fo52B+o+8DkQs1Q24Rc6omLK42ctIA+7L
nyQuRQwDivpGOlg+jo5acpuN9XOsJd7TWZKuwuAU/CPEwwYPBIkm8S3JGAiEsBG0
aSha9nSWg+Uvkz5a+aCQ90rionXeQsOZ/ygovNZeymhu1TlnL27qSf3td2Zl+FvG
IBxJSoiGGJkiKl3CAKnRhFVUw5Cipixyts8LUHf9I5G6MBb5mi+RaNg3m99bxC4p
ZSGuhxWmCHrljxjBWep+ImlLR8LAJhMqrOivgF7H14bgq6qsbFH5q8VB+D+X4s4L
rT7pk507DF1MFWiJfZK6ltVL5/1uvwIIENTMTtUKjeKmQC/41Xw=
=W7HD
-----END PGP SIGNATURE-----

--rjsufeh33ovopkb5--
