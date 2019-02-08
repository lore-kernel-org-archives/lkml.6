Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E242CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8D52084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549644178;
	bh=1wNkQkf/UtQ6+fr+LcGI2FbZVeFAPE4tiIqJdacuJZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ksOOxvjQaJy9h4XMEgVhiujeiGa3C0Vqk7dEPiVCvXSxEkS5o2ZypCtqEUK++WAqw
	 lZu50NTooXk8B8s9TJ285IOpbWL4heBEGg4OJ5OzDYOX/6BO7PzIelSayliAxuNgAz
	 UPAxpe2N3vdgJx8/jwqzQvBKokHhcCjBMBMrtr5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfBHQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:42:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1wNkQkf/UtQ6+fr+LcGI2FbZVeFAPE4tiIqJdacuJZg=; b=IxAoNOtYHy4S8uz30oREFsiqh
        qspsU5dV3ia4BFvzawTATtx4bkJcWGvjJ3OiE3WADxTaQkgiBQtK2kp5ys6NBVfpDEgZU9aceL83x
        TK9XyeLZuvYEeVE0EoGKWph3kOczjdrIFQ0ckwZUHIWqnljdfdAfAIJb26ulDzw1VNbz4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gs9Ep-0002EA-00; Fri, 08 Feb 2019 16:42:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3E8EA1127F2F; Fri,  8 Feb 2019 16:42:50 +0000 (GMT)
Date:   Fri, 8 Feb 2019 16:42:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: msm8916-wcd-analog: add missing license
 information
Message-ID: <20190208164250.GG6695@sirena.org.uk>
References: <20190207165755.1548-1-johan@kernel.org>
 <20190207165755.1548-2-johan@kernel.org>
 <20190208115341.GB6695@sirena.org.uk>
 <20190208151502.GP4686@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
In-Reply-To: <20190208151502.GP4686@localhost>
X-Cookie: Mickey Mouse wears a Spiro Agnew watch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 08, 2019 at 04:15:02PM +0100, Johan Hovold wrote:

> Ah, yes, that makes sense for consistency since you've already enforced
> that style. And while I don't think the all-c++-comment headers look
> better in general, for the single copyright statement case it's not too
> bad.

Yeah, I'm not really actively a fan either.

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxdsYkACgkQJNaLcl1U
h9CstAf9HetsWXgiyITwU+/rGgnBrKgOr2pU2+nnMZqPMabWnB2vcLHeM7JzrWRk
quGhzasynFfL2CJC7qo92djEpPmcp4kIJ7FzyDxJgilEvxglt93YFYllJN4Lr5T4
B/jnW8QAlWDoVcTe0nM7sBbw8ExoAe4A0KLLlDI57fudnpSDjdk0XPVKVBjOD0Xq
fjQ/tw+oTwxk0Ov939xKlp6Lv8Nzj+2cdJdYW+jTLq7rmVN6VUGfviP41nXhg4Hw
cuuO0FzW36HECUx1zoCcNnHo89f3hbtTuW26H8ZgKaBkwdXOruiaaW2aV3AfcLky
cKrv8cBbDSI+guVQk9Rd6eV+6UAJuw==
=oHjI
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
