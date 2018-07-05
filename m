Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDF3C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06B424075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06B424075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeGEV7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:59:48 -0400
Received: from sauhun.de ([88.99.104.3]:39544 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753439AbeGEV7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:59:46 -0400
Received: from localhost (ip5b40da0f.dynamic.kabel-deutschland.de [91.64.218.15])
        by pokefinder.org (Postfix) with ESMTPSA id B835156A485;
        Thu,  5 Jul 2018 23:59:43 +0200 (CEST)
Date:   Thu, 5 Jul 2018 23:59:42 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v10 5/7] i2c: fsi: Add transfer implementation
Message-ID: <20180705215941.25lniljxnzcopsp7@tetsubishi>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023823.i3fmdegn2sric5kx@ninjato>
 <6713efb9-c4c3-f648-a1e9-7918110091e4@linux.vnet.ibm.com>
 <20180702182434.5wxxszpgpf6wergl@ninjato>
 <ab5a5b9c-931e-e8ca-d064-92a917e00a3b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jbuejn5n2u6fhqy6"
Content-Disposition: inline
In-Reply-To: <ab5a5b9c-931e-e8ca-d064-92a917e00a3b@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jbuejn5n2u6fhqy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I meant that the hardware cannot interpret this, it would be a meaningless
> command unfortunately.

I see. Thanks for double-checking.


--jbuejn5n2u6fhqy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls+lMUACgkQFA3kzBSg
KbYrMQ//Szqy7H8ny/ePnGdQoC+aBNI7ua2lPaS1u+dvzlSnqmuh5eSsQZ0m+RLr
02g3U2/EYtwU+9g7Qu5kjAanpV2aDlhdTl4PsU9B382zd7Rvs2l4iZAhw4kFtEl9
bnb+mUfVWNZW21PhqeD51AjBjXMA2rW1nHSozhMtesHfWAqwvGcUE54w4Zc35EZS
3yh2+1M6fTAKh77LGjBU65aJZb4cwSf+KO8UOUsOzG8s9ZC6LYsJZIWMLEc7mhQA
dr7vxmwCMi2tf5OSsH8QN39cRMSMOxTdxmLGKjZPFIb+i7YWfWsx6zrPCb2X7kJi
GDko5LmGgJA2j93BVGF1jdjZX6FyxE6yxXjCWXbbrkuiVqDBVk8Id9WH9QnlifV7
pYXrboKLQ/aIeH5zo3LBSPpWbz9obBXN8c40D8fUljv+jrz2HHF/4iVA9GsNSa+y
1qWFbVsbjXg2fznkyOSg+e3zNSVQ8myD+r47WpjMEfLXPeDpYXF6eWOhgL4mlqn1
lwEa2Y/maQKipTowhuC0bH7G82uw25OqR6WZ2dqyTRGivmui7p4KUQrYCzbnZPYZ
Yrd2eJGzqZbiKIXrcObq9VajOKJWIbgaBAZwk2ZRyvNqcR35+iQzlSot76IY63M6
60R4hSgQNLwTMXwaMsS5nUiia2mBhF+YOjp1tzu+8q5vY9PUjdc=
=CJql
-----END PGP SIGNATURE-----

--jbuejn5n2u6fhqy6--
