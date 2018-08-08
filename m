Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F2C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B46421A33
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B46421A33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeHHTUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:20:50 -0400
Received: from sauhun.de ([88.99.104.3]:36172 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeHHTUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:20:50 -0400
Received: from localhost (p54B334CC.dip0.t-ipconnect.de [84.179.52.204])
        by pokefinder.org (Postfix) with ESMTPSA id 1C1A26DB803;
        Wed,  8 Aug 2018 19:00:15 +0200 (CEST)
Date:   Wed, 8 Aug 2018 19:00:14 +0200
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
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
Message-ID: <20180808170014.izjkviwh67hfu3hz@ninjato>
References: <20180808083006.31919-1-hdegoede@redhat.com>
 <20180808083006.31919-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ybomuhi25ygzki2d"
Content-Disposition: inline
In-Reply-To: <20180808083006.31919-5-hdegoede@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ybomuhi25ygzki2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


$subject still says "i2c:"

--ybomuhi25ygzki2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrIZoACgkQFA3kzBSg
KbZ5ow/+I15cSouc8w/8+C95suhWRaukkCFX4CQ2OEvSglyqngMP1+m+KjGZuhZm
08FxGzVAwhHscc/9OSbFnBuFqpDtPFEI+bQLDGeCse0rlEvEQDqfF9QWIwRoTocB
kDogKAyeBKbiBRocl+zHXkZXEOycVzRTI6Plc4GgrFJKjvGc919vlRB6lPODYQxZ
psfl7+QJsHjYW5n1XaWHVuwr1tgOoG8aefDZT9davvAx2NqhLvQWWSr6ZOXdsU8Z
Ywd1h6VBHhHXKMz9DB3O0m+48oGzSUdJHem2KDTrUCLyXDpG4neBhoqGSgksW2qt
wN/3yqF8pWxFsePOZJy5L9WayEl/GUM3gr0fx2di20oYBL+82cJ6IgtFh8diRPio
azDWrlckAD0ynmatYHQDPtePAQeTIi/u8Y4K2Rfd73tflMNQXmIiuKdJdF4cLkbd
m5Vl0wQKrrr3LAJqfFiG+dCzEOahCSYPkf0seO7b+InXtqPCP6cRnYLevTpS5khB
6bm3JsTHMWKDfRzPQtScFQFwB0JeSDwg6B943187Q7EyDGp/iKSAkzKWK2Pq+TrQ
+QvcQmoNPPYHGYoPzAfK0w5e6Xq3VgPSacXlUuL+PWFmC6ZwT/Bs/SvS0S+zigTG
RQiJJvE7xugsGjWuMphF988uTyXNgK6LKW9mUoVt/dSkU7YLasM=
=FDDC
-----END PGP SIGNATURE-----

--ybomuhi25ygzki2d--
