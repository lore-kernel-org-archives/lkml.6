Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F0EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEB5214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEB5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJJJBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:01:36 -0400
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:58520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbeJJJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:01:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B1D0D181D341A;
        Wed, 10 Oct 2018 01:41:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rule79_66b859d827d2d
X-Filterd-Recvd-Size: 2193
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Oct 2018 01:41:45 +0000 (UTC)
Message-ID: <fb2ffc4c5dc18825b508fd29c4dd44d260c9c193.camel@perches.com>
Subject: Re: [PATCH 15/36] dt-bindings: arm: Convert Actions Semi bindings
 to jsonschema
From:   Joe Perches <joe@perches.com>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Tue, 09 Oct 2018 18:41:44 -0700
In-Reply-To: <c4909f78-bfa1-9253-e436-1159392b45a9@suse.de>
References: <20181005165848.3474-1-robh@kernel.org>
         <20181005165848.3474-16-robh@kernel.org>
         <c4909f78-bfa1-9253-e436-1159392b45a9@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-06 at 12:40 +0200, Andreas Färber wrote:
> > +++ b/Documentation/devicetree/bindings/arm/actions.yaml
[]
> > +
> > +title: Actions Semi platforms device tree bindings
> > +
> > +maintainers:
> > +  - Andreas Färber <afaerber@suse.de>
> 
> Mani is now officially reviewer and the closest I have to a
> co-maintainer. I suggest we add him here in some form. I assume this is
> independent of MAINTAINERS patterns though, or will get_maintainers.pl
> parse this, too?

It _could_, if using the get_maintainers --file-emails option.
Ideally, it would be added to the MAINTAINERS somewhere.


