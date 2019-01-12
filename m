Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ACFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC492084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfALPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:05:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42047 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfALPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:05:20 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1giKqa-0003ir-Jh; Sat, 12 Jan 2019 16:05:16 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1giKqZ-0007fz-NT; Sat, 12 Jan 2019 16:05:15 +0100
Date:   Sat, 12 Jan 2019 16:05:15 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Message-ID: <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Scott,

On Fri, Jan 11, 2019 at 01:28:45PM -0800, Scott Branden wrote:
> On 2019-01-11 12:48 p.m., Uwe Kleine-König wrote:
> > On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
> > > From: Praveen Kumar B <praveen.b@broadcom.com>
> > > 
> > > Add new compatible string for new version of pwm-kona
> > > 
> > > Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> > > ---
> > >   Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > index 8eae9fe..d37f697 100644
> > > --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
> > >   This controller has 6 channels.
> > >   Required Properties :
> > > -- compatible: should contain "brcm,kona-pwm"
> > > +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
> > Is v2 used on a newer generation of kona SoCs? On i.MX these variants
> > are usually named after the first SoC that came with the new variant. Is
> > this sensible here, too?
> 
> It doesn't make as much sense here as different revs of the IP block are
> picked up based on various decisions.
> 
> A new SoC could decide to use an old version.

IMHO this is no reason to not use the name of the oldest SoC with this
variant. I don't know how the SoC names are in the broadcom family, but
if they were (in order of age, oldest first):

	ant
	bear
	crocodile

and ant and crocodile use the same IP block we would have

a) with v1, v2:

	ant:
		compatible = "brcm,kona-pwm-v1";
	bear:
		compatible = "brcm,kona-pwm-v2";
	crocodile:
		compatible = "brcm,kona-pwm-v1";

; and 

b) with the SoC naming:

	ant:
		compatible = "brcm,kona-ant-pwm";
	bear:
		compatible = "brcm,kona-bear-pwm";
	crocodile:
		compatible = "brcm,kona-crocodile-pwm", "brcm,kona-ant-pwm";

(If you want, drop "brcm,kona-crocodile-pwm", but keeping it is more
defensive.) 

I like b) (with "...-crocodile-...") better than a). crocodile using
"...-ant-..." is not more ugly than crocodile using "...-v1". This is
also a tad more robust because if broadcom releases kona-dolphin and
someone finds a minor difference between the IPs used on ant and
crocodile it depends on the order of these events who gets v3, while
with the SoC naming the result is clear.

(OK, and given that "brcm,kona-pwm" is already fixed, both approaches
need slight adaption, but I guess you still get what I meant.)

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
