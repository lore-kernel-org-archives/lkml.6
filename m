Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF7EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0595217D2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0595217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbeHIMYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:24:51 -0400
Received: from sauhun.de ([88.99.104.3]:43832 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeHIMYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:24:51 -0400
Received: from localhost (p54B3374D.dip0.t-ipconnect.de [84.179.55.77])
        by pokefinder.org (Postfix) with ESMTPSA id 77ED96DEA52;
        Thu,  9 Aug 2018 12:00:43 +0200 (CEST)
Date:   Thu, 9 Aug 2018 12:00:43 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
Message-ID: <20180809100043.2twv3qma22ptkddq@katana>
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-2-hdegoede@redhat.com>
 <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mq743r4htrqmczbp"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mq743r4htrqmczbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As for the rest of the series I'll wait from comments from Wolfram and
> the other reviewers.

Well, I acked patch 4 now because I like the general approach. I can't
say much about the rest since this is mostly ACPI/FW related.

Thanks Hans, for keeping at it.


--mq743r4htrqmczbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltsEMoACgkQFA3kzBSg
KbZODg/7BfBqQDftu3X3jlS1Tp8Te05gl1KEVu60oaLRzmn2Gnlr2xTlMKO21L2R
W4Pze2A5p2/YlCMco2Xcfdc/UqV0hFxVkJTn0LkTxcub2akTwjt6jWmtO78iNmv1
eIbG6DY+3fwdogXhtgkqitgNvz37hoBYZN5CFlbHHXJDcdwb80hAf3BkyYSqNHc5
EBT54KKe8b/vVWuzC9eyvncwizbZBy/7jSVoEWwDqnSgj6azxeeYqELBBB5jhzsA
+SYKTtM3kMdKcJoI9X+60vgIua9LSFbsF0jimphF5n5pRd3uptIp5uZN9OQuDtXL
+DvBDr8vFGdgAL+7Niscrc/ATPwItpJhOEmQVkGJ4xMlMVZQArY/tCvvm7h97tuw
p284Lid71WmRnSnem+upzAfy646ZBGozBarijoN9vjqVGjAu/YUNIeT4ZQdQ1C3z
Q+2105Tl6OffuZK+m6yM6w2/sFmTQRzxY0pR/zwcA2fKBYXayMl8QCZIUTpk2d07
rBw4NUTInoRQTy7oVXUUgkwtnWVm0BnfuSWRaUVRHektJ4Y5KmKsR1nBCwL24jyt
9WAiyfu/nncBMQIGrFMeMp8+yfD9WCwJSyX5h0yZTmPNzOQLWEZs2BuQNkEGSuzQ
KdVTrQGdnMEuSgx6Nxs+8hDR5ZK31CVprtK/R52XEv9GVkTOC8M=
=UUWI
-----END PGP SIGNATURE-----

--mq743r4htrqmczbp--
