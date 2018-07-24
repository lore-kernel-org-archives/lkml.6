Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D72ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A018620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A018620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbeGXONx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:13:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60556 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388248AbeGXONx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:13:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E289D20731; Tue, 24 Jul 2018 15:07:26 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 946DC20720;
        Tue, 24 Jul 2018 15:07:16 +0200 (CEST)
Date:   Tue, 24 Jul 2018 15:07:16 +0200
From:   =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dmitry.torokhov@gmail.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 1/3] Input: edt-ft5x06 - Add support for regulator
Message-ID: <20180724150716.4cb7c3b8@dell-desktop.home>
In-Reply-To: <20180720134355.GA24750@rob-hp-laptop>
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
        <20180718182719.29663-2-mylene.josserand@bootlin.com>
        <20180720134355.GA24750@rob-hp-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 20 Jul 2018 07:43:55 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 18, 2018 at 08:27:17PM +0200, Mylène Josserand wrote:
> > Add the support of regulator to use it as VCC source.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +  
> 
> Please add acks when posting new versions.

Yes, sorry, I missed it. I will be more careful, next time.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
