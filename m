Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeCTSvU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:51:20 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51552 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751424AbeCTSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:51:16 -0400
X-Google-Smtp-Source: AG47ELuJ2PGJF6iOtVRazgOyTW5lXZhfaVmoDX4P3hxB7s6evcBG/PurOQT5F9JfhjSgOtNqdO0/tA==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Liran Alon <LIRAN.ALON@ORACLE.COM>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, idan.brown@ORACLE.COM,
        yuval.shaia@ORACLE.COM
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info only when crossing netns
In-Reply-To: <5AB13953.3000606@ORACLE.COM>
References: <5AB12A0E.2060704@ORACLE.COM> <20180320.120036.1999626754164343704.davem@davemloft.net> <5AB132C5.5010806@ORACLE.COM> <20180320.123401.2138083793709750726.davem@davemloft.net>
 <5AB13953.3000606@ORACLE.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1521571867_3137P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Mar 2018 14:51:07 -0400
Message-ID: <55538.1521571867@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1521571867_3137P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Mar 2018 18:39:47 +0200, Liran Alon said:
> What is your opinion in regards if it's OK to put the flag enabling this
> "fix" in /proc/sys/net/core? Do you think it's sufficient?

Umm.. *which* /proc/sys/net/core?  These could differ for things that
are in different namespaces.  Or are you proposing one systemwide
global value (which also gets "interesting" if it's writable inside a
container and changes the behavior a different container sees...)


--==_Exmh_1521571867_3137P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWrFYG40DS38y7CIcAQJL5Af+JvWAyw/rPHQdMa+n+LZhoLmEtp7FNEsB
+QXUcxO5XeuSecJbg0SpPPRh5KcWy2VNY3kjq4yjqFtSSrXmTR0atJ7Oi0DTyRlF
r4H6NM1CtTNaqlS6khWKqesccLL7thUYNiP5ckD2pYCMu3iCdRbp+y0RFiNFa9vS
yDWFz9cAThQM8tu3L9RW5PdKn44WDzOmf0WXrhvTEpU6HOQWBj8aZzUSLz14Q2Jy
KSCjpVbD3sqZEqcmFt+N7UckpP4G360k1KNeekjqsVf3FeKgnrg8+SxQ+Cb914xL
38t8eX1Ot3dMwBUYqnUUB5rwVdu0jQM4zpWgIUgG9ylP20RUgiOFXQ==
=dHhk
-----END PGP SIGNATURE-----

--==_Exmh_1521571867_3137P--
