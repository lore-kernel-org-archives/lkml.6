Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0BDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F33C2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F33C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbeGTXP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:15:56 -0400
Received: from sauhun.de ([88.99.104.3]:59956 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbeGTXPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:15:55 -0400
Received: from localhost (p54B33241.dip0.t-ipconnect.de [84.179.50.65])
        by pokefinder.org (Postfix) with ESMTPSA id AEE8F5E0581;
        Sat, 21 Jul 2018 00:25:37 +0200 (CEST)
Date:   Sat, 21 Jul 2018 00:25:37 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Fix initial values of master and slave state
Message-ID: <20180720222537.2ldpgsign52dutkn@ninjato>
References: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ohlvevurqh7blhp"
Content-Disposition: inline
In-Reply-To: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ohlvevurqh7blhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:20:28PM -0700, Jae Hyun Yoo wrote:
> This patch changes the order of enum aspeed_i2c_master_state and
> enum aspeed_i2c_slave_state defines to make their initial value to
> ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
> In case of multi-master use, if a slave data comes ahead of the
> first master xfer, master_state starts from an invalid state so
> this change fixes the issue.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!


--3ohlvevurqh7blhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSYWEACgkQFA3kzBSg
KbZ8Jg//YKSUt2a/m5B26aWzCSeSgU5lO0k17TlCMkNO8xG2PUzjpfqxfWhxYGjj
opjcaYiF6WKHLAS1IhrhCVcuEV7H38as8NaXMr8/NtxvSOtbs88nYbKHx0wE3HC4
/h0KUHwnLGFoU2EShSSlOl57Q9q8icyCjWS9K8FLnqW0y4PatxFBYS5Zv9il3w0s
mdiEOVHVWvSoi5rDfgEgKk4Lo1iw1h1ziBS/9l49MDcnslzmjK2GSLHc7QnwtI/c
RaxRHb0u2yuIzxEMmzrKxQ8FlVA04oq1yndDg1cj9/pN0OBOLztO1eXlUOLDMBAb
FWsWv1adZl0++rnEV9gibDYeCdEI1yxRnXouen0Hlocpkw1fJHHDGSBeUv9DKiKS
yEmefiGeY07v9vyPNe0qoCW2ISFnot2jiPDbv71bkJUgUnCwmjKEynXN70W5vCy2
iKrI6+7HEX+igFvfLUPTTH/35DVkEs3DrqICY7I8Zox0mKaRjVlFwBSaGcWqTppS
Z5Ldfin1eqPP6vZ87dW4OAjFuHiAGkq7v/ODcvdNTz7w77H+KQCQ29rnGUozJns6
SWOy6pCmigweIezB9RhroMlzHsoS53uiIKWZxYG6iZS0NGYy7gIuYGcJjtAS9GpS
kra37ncjFWUVN3TvwSy+lyHLiTmtvsNd2cdQqs4Uxo9W2CumBPc=
=3A4E
-----END PGP SIGNATURE-----

--3ohlvevurqh7blhp--
