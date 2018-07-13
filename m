Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23612ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFB22124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFB22124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbeGMIMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:12:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52083 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeGMIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:12:10 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdsyI-0005Oi-1m; Fri, 13 Jul 2018 09:58:34 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdsyH-0002PA-0N; Fri, 13 Jul 2018 09:58:33 +0200
Date:   Fri, 13 Jul 2018 09:58:32 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pfuze100: add optional pfuze-disable-sw
 binding
Message-ID: <20180713075832.5ncb2yvqn4z6mvqy@pengutronix.de>
References: <20180712110240.3006-1-m.felsch@pengutronix.de>
 <20180712110240.3006-2-m.felsch@pengutronix.de>
 <CAOMZO5Cx-ooNJ8hseTYBvBvWx6mMX0jOsFTmRxC1yogXk0ZZuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cx-ooNJ8hseTYBvBvWx6mMX0jOsFTmRxC1yogXk0ZZuA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:57:42 up 203 days, 20:35, 58 users,  load average: 0.07, 0.07,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 18-07-12 12:19, Fabio Estevam wrote:
> On Thu, Jul 12, 2018 at 8:02 AM, Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > +Optional properties:
> > +- pfuze-disable-sw: Disable all unused switch regulators to save power
> > +  consumption. Attention, some platforms are using the switch regulators as DDR
> > +  ref or supply voltage. Mark these regulators as "regulator-always-on" to skip
> > +  disabling these regulators. If not specified, the driver simualtes the
> 
> s/simualtes/simulates/
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Thanks for the feedback, I'll fix it in v2.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
