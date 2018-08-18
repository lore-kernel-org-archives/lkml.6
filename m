Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B59B21746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIhP0zP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B59B21746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeHRUOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 16:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeHRUOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 16:14:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C76D2124D;
        Sat, 18 Aug 2018 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534611985;
        bh=RRxffDE07ERyIve+YR4Wmktwgjj4HYlzemMP+ewunFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BIhP0zP88iY0R5G+S2UXEjR53Bby8rQDejpwUyMeYM6tbmCYNLNN5QAWZ68kzbuQl
         KA4sAUv81jaFjxx4icULXhBrLL+HdPTtBa4OPcSTxEpnobPnJIrXxSvlOZNC0Vy6jl
         +S4mZHQGpK5w9pLM1k6LEFA6S9gMxPYlRPlXueJ4=
Date:   Sat, 18 Aug 2018 18:06:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 8/9] dt-bindings: iio: tsl2772: add binding for
 avago,apds9930
Message-ID: <20180818180619.6beca3f7@archlinux>
In-Reply-To: <20180807172101.GA12095@rob-hp-laptop>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-9-masneyb@onstation.org>
        <20180807172101.GA12095@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018 11:21:01 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, Aug 02, 2018 at 08:18:59PM -0400, Brian Masney wrote:
> > This patch adds avago,apds9930 to the tsl2772 bindings.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> >  Documentation/devicetree/bindings/iio/light/tsl2772.txt | 1 +
> >  1 file changed, 1 insertion(+)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.  Thanks
