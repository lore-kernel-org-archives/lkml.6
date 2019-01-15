Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33883C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D69620866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfAOWWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:22:32 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:34936 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733219AbfAOWWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:22:30 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 11E528044E;
        Tue, 15 Jan 2019 23:22:25 +0100 (CET)
Date:   Tue, 15 Jan 2019 23:22:23 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Urs =?iso-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v2 3/5] dt-binding: pcf85063: add xtal load capacitance
Message-ID: <20190115222223.GA558@ravnborg.org>
References: <20190108185414.26922-1-sam@ravnborg.org>
 <20190108185414.26922-4-sam@ravnborg.org>
 <20190115210827.GA25046@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115210827.GA25046@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=VS2a7EESzNgYQ6qa8v0A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob.

> > +
> > +Optional property:
> > +- quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
> 
> Probably should put this in rtc.txt so it can be shared.

Good point - will do and respin the patchset.

> 
> > +  expressed in femto Farad (fF). Valid values are 7000 and 12500.
> > +  Default value (if no value is specified) is 7000fF.
> > +
> > +Example:
> > +
> > +pcf85063: pcf85063@51 {
> 
> rtc@51

OK, will change.

	Sam
