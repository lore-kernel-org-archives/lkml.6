Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDF3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BDF2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BDF2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeJ3Dsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:48:51 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:58733 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727954AbeJ3Dsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:48:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BEF062AB8;
        Mon, 29 Oct 2018 18:58:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: screw92_4ca5bddfed811
X-Filterd-Recvd-Size: 2197
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Oct 2018 18:58:46 +0000 (UTC)
Message-ID: <ecd684121963748417a5d0105880ea8d73a20b9b.camel@perches.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add myself as the dw-i3c-master module
 maintainer
From:   Joe Perches <joe@perches.com>
To:     Vitor soares <vitor.soares@synopsys.com>,
        boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com,
        bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com,
        cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com, luis.oliveira@synopsys.com,
        manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
Date:   Mon, 29 Oct 2018 11:58:45 -0700
In-Reply-To: <1540807618-13246-4-git-send-email-soares@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
         <1540807618-13246-4-git-send-email-soares@synopsys.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:06 +0000, Vitor soares wrote:
> Signed-off-by: Vitor soares <soares@synopsys.com>
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -6930,6 +6930,12 @@ F:	drivers/i3c/
>  F:	include/linux/i3c/
>  F:	include/dt-bindings/i3c/
>  
> +I3C·DRIVER·FOR·SYNOPSYS·DESIGNWARE
> +M:	Vitor·Soares·<soares@synopsys.com>

Please do not use the '·' character
between your names and the email address

Please use a standard ascii space instead.


