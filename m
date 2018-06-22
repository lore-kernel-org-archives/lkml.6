Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A4022B43
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A4022B43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbeFVAPS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:15:18 -0400
Received: from anholt.net ([50.246.234.109]:59314 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932397AbeFVAPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:15:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EFEDE10A1642;
        Thu, 21 Jun 2018 17:15:16 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id YFRHnFVmk26n; Thu, 21 Jun 2018 17:15:15 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CEA3A10A1128;
        Thu, 21 Jun 2018 17:15:15 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 4F1552FE21D0; Thu, 21 Jun 2018 17:15:15 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <1804311797.71726.1526929189594@email.1und1.de>
References: <20180521183907.27563-1-eric@anholt.net> <1804311797.71726.1526929189594@email.1und1.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jun 2018 17:15:14 -0700
Message-ID: <8736xfekx9.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

>> Eric Anholt <eric@anholt.net> hat am 21. Mai 2018 um 20:39 geschrieben:
>>=20
>>=20
>> This only probes on arm64 so far, but hopefully that driver will be
>> generalized soon.
>>=20
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Merged to bcm2835-dt-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlssP5MACgkQtdYpNtH8
nujzOA//aCzDTiAyku0uEMFrUwBUDh6ENrsq/ydFcG6rfK9wm9xcvuMO8VmMS9jL
5ZR0HtVvUfmoKi72ShuJLcoJTmwX0aWpxK484qt/RSSt1TS0t7CtrHZyPGIdWZXQ
zTNTPZzO2ZEN4RD+wRsZuWpSL+LRuOa3ryL1PQ5Gakv+hVbSYRlVGtKDocHorr0P
7V8JvL16DZg5YgCnx0IxOxhk0Pig25uFF5arvtyIV30r6vGTc0z+tSfRqPqo1YxH
hrSrmQ8NSBuGMtpUXXNYg8qhRlQVkhzgcSkLUEPVJbDLL9gmV/CoE4LQo9s0sj6j
eJTuacVc63ZCuTrpTO2dtf/oWJFRPO/v1ieRq1/hwKvAkdib62Z8gi+4l9HFgIZ3
Gm4H2GmfTcV6A4AH7ZvjQdDNdAw+cyeL+45tDYNUlRu7mjsmoJz9pufmy7WrvEw3
e0WY1gVWaVVCAGx2jjGlnCxw0u+tGBFEPXYn4sDvYAnO9I5tOa+ffXOBAHlNuqYc
ux4uUEfDEEM8h8NjE3voDiLym6SSO+t+fkRhwuQVGg3yTjztGJZHj/Kqnc0xv9+6
072V1mcZGX2IYD29aIik5Q7K7BLu5mq9EcLQkCVFPBItYYUxmYWSobzts7vTKk14
G1LAz15Ohye8KpFIYpOJ77TpZ/FeHDdbh3uelHQ3VVw9PmcC47w=
=Eg2c
-----END PGP SIGNATURE-----
--=-=-=--
