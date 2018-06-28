Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9BDC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA6D27198
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA6D27198
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964998AbeF1Jx0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:53:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50073 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932809AbeF1JxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:53:25 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fYTc4-0006Hr-Sm; Thu, 28 Jun 2018 11:53:16 +0200
Message-ID: <1530179595.22468.50.camel@pengutronix.de>
Subject: Re: [PATCH 0/4] RDU1/2 latest supported RAVE SP nodes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        cphealy@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Jun 2018 11:53:15 +0200
In-Reply-To: <20180628042424.12664-1-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 27.06.2018, 21:24 -0700 schrieb Andrey Smirnov:
> Shawn:
> 
> These are patches adding the rest of RAVE SP child nodes covering all
> the rest of currently supported MFD cells. There's more to be added,
> once more drivers get accepted upstream.
> 
> The bindings three drivers mentioned are availible in:
> 
>     Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
>     Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
>     Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
> 
> Feedback is welcome!

Apart from the RDU 1/2 mixup you noticed yourself this looks good to
me. Maybe Shawn can just fix this up while applying.

For the series:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas
