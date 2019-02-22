Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A2CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCD920652
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="PVy1liGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfBVLvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:51:25 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:12553 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfBVLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:51:24 -0500
X-Greylist: delayed 3316 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2019 06:51:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550836282;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Dg8R1bJpmNapX0EWWsD+nl6yZL3YMX8pvEvzU39El6k=;
        b=PVy1liGm8MLnYnV3MHtWOJkA/0rbr8rTNBYz24Z3ANk9BK3I1A/kqWezxHfEUsKb8j
        EQsLpGJlGnF6utb0uoMzt6TRIM45eyCRfJ8643C7p6VYsqm8FOjlQmNpUXBrGSFeQXbB
        3jJu8QKVP4cPGRucjKDrRTM0lpiyBZtIeTsY4=
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsASNzKJ5utOf/1mzsWliHF5sWnBXHH2RJsJO8="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.12 AUTH)
        with ESMTPSA id R08017v1MBpHjYC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 22 Feb 2019 12:51:17 +0100 (CET)
Date:   Fri, 22 Feb 2019 12:51:08 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: recalibrating x86 TSC during suspend/resume
Message-ID: <20190222125108.09ed29f0.olaf@aepfle.de>
In-Reply-To: <alpine.DEB.2.21.1902221212190.1777@nanos.tec.linutronix.de>
References: <20190222105302.GA26398@aepfle.de>
        <alpine.DEB.2.21.1902221212190.1777@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 2019.02.17 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/NmJ7JGuQkuA6HMdmmViTwr0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NmJ7JGuQkuA6HMdmmViTwr0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 22 Feb 2019 12:44:39 +0100 (CET)
schrieb Thomas Gleixner <tglx@linutronix.de>:

> Whether that is accurate enough or not to make NTP happy, I can't tell, b=
ut
> it's definitely worth a try.

Thanks Thomas, I will look into the suggestions.


Olaf

--Sig_/NmJ7JGuQkuA6HMdmmViTwr0
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXG/iLAAKCRBdQqD6ppg2
foRsAKDh5TTALtZKWrmL7pDI1CTGPA+iugCg3CDrHMdy9e4Ktjb0mBmMe9Hf4Ww=
=v4iH
-----END PGP SIGNATURE-----

--Sig_/NmJ7JGuQkuA6HMdmmViTwr0--
