Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C17ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A0B2089E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="otYUaAeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A0B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeGOJBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeGOJBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:01:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5114E20870;
        Sun, 15 Jul 2018 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531643977;
        bh=duBM4hHC/gNI6w2TnV9Gl9YONLQ/+5z/IB7PjXA3+WQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=otYUaAeFxBVBQtDb8SNLD2pRdzEHp+Jb0v/dj2j01m2RD3CqQ1RrDSLTncc+H37fQ
         UsKfv6CtC49AmAy+ZA9MBGkAgCl5kWAMNeLtHUaurprPtjNkeDbvggalj66FvFJHkr
         KP4iB3vz1ch6mMV4UXV3BLlw8cIhi19Vl3nfmLdQ=
Date:   Sun, 15 Jul 2018 09:39:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: hx711: fix spurious unit-address in example
Message-ID: <20180715093931.67a4d6e1@archlinux>
In-Reply-To: <20180711135432.GA16230@rob-hp-laptop>
References: <20180710181937.GA5398@arbeit>
        <20180711135432.GA16230@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 07:54:32 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Jul 10, 2018 at 08:19:37PM +0200, Andreas Klinger wrote:
> > Device tree compiler (dtc) gives a warning if a device node has "@" with a
> > following number as it's name but no reg property.
> > 
> > Fix the example in the documentation of avia,hx711 to conform to dtc
> > behavior.
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied, thanks.

Jonathan

