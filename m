Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeDRHiT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:38:19 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42340 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeDRHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:38:17 -0400
X-Google-Smtp-Source: AIpwx49X3Q5+X0F6hmrCaFyYHi5s/D6RlXG/GUry+/vZt7Evy4gqKSony7qv+9HimEB5tmAULTtYNg==
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
Subject: Re: [v5,05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
Date: Wed, 18 Apr 2018 09:38:12 +0200
Message-ID: <2715737.hC3rduhfyA@bentobox>
User-Agent: KMail/5.2.3 (Linux/4.14.0-0.bpo.3-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <734eb6eb-9af9-d599-81f1-ec66d9cd839c@codeaurora.org>
References: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org> <2284833.pBtR1QS54F@bentobox> <734eb6eb-9af9-d599-81f1-ec66d9cd839c@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12205840.CKSMYhIfR3"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12205840.CKSMYhIfR3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Mittwoch, 18. April 2018 12:45:20 CEST Sricharan R wrote:
>  Right, will add the above change to soc.dtsi in V6. Does that sound ok for 
> you ?

I have submitted a patch for this now [1] because I need this for OpenWrt 
(sooner rather than later). And I am not sure whether it is good to have this 
in your feature series because it is a bugfix which might even qualify for 
stable@vger.kernel.org.

I hope this patch [1] is ok for you.

Kind regards,
	Sven

[1] https://patchwork.kernel.org/patch/10347459/
--nextPart12205840.CKSMYhIfR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrW9eQACgkQXYcKB8Em
e0bQ1hAAlJVAO98+uVP4boEF80XV3bWUszisCClqdPZ/NqwHyurG/Ma+jzXKT6N6
gBANfCrSKDgbsyckfjOsSgVMnuXFjdjKLLXdMEcng/DnegDz6ljxomiwB3Gb5AxL
GqZNS9w6XPSm1il0UC0Xh5rD/uUgAO/VwZfZOYwvcVpiX1UpsCz1cHRzrF1gpX9O
nPuPWE+rskHp1NDzwOhmvjgwk6gTjorcrJ2CAlUAXbdcTno+mu/noF1wxzM0T/Ew
ppGmJEeAn8JQOxdO/ywdUM5RRYSWxalGGPvgioJvsRm+6vbMX3GVAcrU5S433DZJ
n26BtzfCcCe9u/GOtAIdTL3DqTzIitApdiZqprUZ/zv7H22zVHzG0Ij0te8SgFK2
5SqvBS66KWO2YvozoVyeB3WSdHDE3xp7xdEV3keZLVjI/iuNCu+Y5V/r6/NlA1vE
Zpo6NBks+BDqfW3HyJYaCXgzKnlZKIHpF0bO/RjrLGQNtjvp0mh/4pNQJmUhhgld
d1oKlQkUsoe27r4tvhcD+phMMjcZDDaUYBV5GxSNd0LO/UDztcRAuSCL1WwdQKYQ
aSmu/bN+zvENOS49M04oPX4kC//Q+T35kEHvb5vFSZUgdgLzgawbGwMIUH+J1JnI
BnEICQGA4UzMulCCcmjCJZ41q484wjCviuU/o9Bxa5JzPdSOaoU=
=4IUN
-----END PGP SIGNATURE-----

--nextPart12205840.CKSMYhIfR3--
