Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B82C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2F52087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546963965;
	bh=dp05+YoeRNCMEL/YPcRKXDWC0qDv1RYjKfUJ3QCL/gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uk1ijmRRCSMldAec8OPfNnqcykdROGQAXW3pHzbUdRbc1kmhQCUdfsUCKB1pZUTzK
	 ybwD88O2wFMnfZcqreohS0iibrZHATzhZyksF0fOPY77tzkuBivSdmlmiQafiodHe1
	 Z9remUMwpRf83heffI/0GesrtfLhBA5U4dWbtqcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfAHQMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:12:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAHQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dp05+YoeRNCMEL/YPcRKXDWC0qDv1RYjKfUJ3QCL/gk=; b=GAL6EtlUYNTf2z8/jWZ5F74LY
        hSxa04Edu8cyP18KC6V5cpI3V2JToDzmxhoY1bTuzph0b1sxOQ37GjI+FJO7LGwf3bvdIf737tRy8
        b/p3vRyFICRxqbTprF6cK11bGr6NCOazNiqR3KFGD9rNmSNMuSUuiNfct8QPSRNo0JlfI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggtza-0003PH-NA; Tue, 08 Jan 2019 16:12:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5C129112778C; Tue,  8 Jan 2019 16:12:38 +0000 (GMT)
Date:   Tue, 8 Jan 2019 16:12:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20190108161238.GG6590@sirena.org.uk>
References: <20181226070317.72022-1-cychiang@chromium.org>
 <20190107192402.GW9570@sirena.org.uk>
 <20190108095450.GA27286@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline
In-Reply-To: <20190108095450.GA27286@dell>
X-Cookie: You look tired.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 08, 2019 at 09:54:50AM +0000, Lee Jones wrote:
> On Mon, 07 Jan 2019, Mark Brown wrote:

> > Is there a tag I can merge?

> Afraid not, but I reserve the right to rebase my tree, so if you want
> one, you can have one.

Yes, please - that'd be most helpful!

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw0y/UACgkQJNaLcl1U
h9ApxAf9GHL/qL6na/x5Oo3KZRXkrGOsUE2WxlEhjJrCTWjPHSukTp8Wn1gerCYY
bzcoovRjtNSXq7QjFh9EXY4rF9cCn9Tz14oAB7RP72pwpxY/o9uflzSLVn18xE+D
/I4BTZzaxnrZ8vP6s7vi9g6KhRMrkDlTE8E7zjaUf1Ln0qGKIe9OHwPWBDGh6x3w
ypDu7ybKcvw1KnpkZGAFKam3wikyNbrjdjqlYCvMOWEBTzvmar7b34IxROpwXVCh
tQYP5FtWzpKqqfNxKYilUZW754lSmeN3gTben9S3mhAvRHlAkPqwWIxzxY/ZpocN
/7+l7gYcIFlPGRv4bAu3vh82lxf2bg==
=ZW6R
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
