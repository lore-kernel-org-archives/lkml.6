Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDRHHd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:07:33 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34528 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeDRHHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:07:30 -0400
X-Google-Smtp-Source: AIpwx4/LvpxVmQ5jL9WPGr7F3krugT/85jkhkgGFvXjjiR2WfaVzB+9HOC874IQuJHNSK8fekRAGGA==
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
Date: Wed, 18 Apr 2018 09:07:27 +0200
Message-ID: <2284833.pBtR1QS54F@bentobox>
User-Agent: KMail/5.2.3 (Linux/4.14.0-0.bpo.3-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <2641190.FRMBLJWkCS@bentobox>
References: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org> <2641190.FRMBLJWkCS@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1974979.3aonjUcCjS"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1974979.3aonjUcCjS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 18. April 2018 08:59:46 CEST Sven Eckelmann wrote:
[...]
> I would not know how to disable QSEE on these boards and thus would assume 
> that it should be part of this dtsi.


Just did some reviews of the reserved-memory regions in other QCA devices and 
it looks like this tz and smem are often directly added to the SoC dtsi. So I 
will prepare a similar change for qcom-ipq4019.dtsi and this would then solve 
it for AP-DK01/04/07 and no changes in the board-family specific dtsi would be 
necessary.

But maybe someone has an objection because tz and smem can actually be 
disabled in a sane way on these SoCs and thus it would be better to have these 
regions in the board specific dts(i) files. We will see...

Kind regards,
	Sven
--nextPart1974979.3aonjUcCjS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrW7q8ACgkQXYcKB8Em
e0Z3kQ//Z5t4uSTLYRLvGFbaVhbCRSNH2o9qKGb2R5DHu/yXKVDqVsFMVsneGOsH
WqsgXsxaDG27FbfscsLLcCcvALnrsvJliKjI0FafdU3cF5TUQJZqV+A631qW1JQS
ipUGM01wA3Wn/xluWa6hFRllzUdNh7FQXb6YQ/o5t1KiQvFFHJaRArBsbq/BnFLR
PGCIi4TvJsT3U1QgpAKXmGqay2bHwQA1sv7wIQ+eCBLiSCt9aKPlSmyA20UeX6ZG
VpVsvK2xrIH0ClXU8soQPPtAxwWgazEbpSLH19z2oI/sG3TH1gjEC6NeA97pLLVi
HkDH1pADUvdEPx0X8qWfdjkyw5OhQYcGS9R1snMJIK//ebofDUU8DbLnekSZjvQd
efLwCdSONm8x1nFub/1/Sl1evu4/HsjF3D33qNdErakzVxjPmqku5Jt9XcNPksC/
PAPTVLMA2ZS0ecoEzgia1JDOeDBLTqdFhqYvXA3cU/FOMjk47wcJHus4glvhhePV
1zkoJaUETgT0lWoR1Qs0eizOYdSqVGvj5EAFHTVLpvEKbvJ2FwMfNcdVpH9vtPbC
81rPtmFrGHXCSHbLMVnIfmxHw57jmswRRxORl8ulayg6uY2Wkaj2P09xBRSWpAV8
yp9Bz5sSAX00Nc3eR4CIfzRociDoshuClJ8dcI81Xhe14MC5E2c=
=nY8x
-----END PGP SIGNATURE-----

--nextPart1974979.3aonjUcCjS--
