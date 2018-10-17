Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3B2ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD2520658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD2520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeJQXFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:05:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46709 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeJQXFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:05:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so21326173oia.13;
        Wed, 17 Oct 2018 08:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D2IIiHJAQ75M4sUEA9PE/cRsr8V/lGkeukwtxM+loNw=;
        b=TnSr9vgEkyu09z3cJjhNVXXtSPVT7RG/3vep9WCrhpKwqoCv2IEHIaV558nrvA8lar
         sQlUGxidMrBM//d4QEx9J3H1rL3HARwdkxSE1jYxdcpfXJ2EECkUDkh91XegqTEJsOiN
         b2MJCC3bav0OD16lkXaGpQuKHRaZ3gnQ7XCYWtTPR7KgDD/po4iKvwEDBB/z0Py+Ruft
         Yj9qkz91ZXK9hZCMn5gCFAN/bp0hec6oYycRM689giB9pRJsxpkKcrGnyzVWGgkU1Ekt
         Y9tNIxKqBbDF5qvvZurkjKIPuCF7NBNNDGUMtKEDKlGvNdjx98T1PrZyQtZ65mrbQAAd
         GgWA==
X-Gm-Message-State: ABuFfohKVdjpMvTvMlWUh484Bj2GQxmflvKB9VvgiQ+2uq6l9iDtjgjz
        L2DeUah6uSvxNECzfO2GSTXrJn0=
X-Google-Smtp-Source: ACcGV62Hu6u4NpVPeU5tyiTe9eEoBRTW4EKGyyrCal0VU10kheAhNIGWLJiZXM/bTmnRoY/qXHlKsw==
X-Received: by 2002:aca:bbc5:: with SMTP id l188-v6mr10272445oif.340.1539788972574;
        Wed, 17 Oct 2018 08:09:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h29sm1582258otg.34.2018.10.17.08.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:09:32 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:09:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Update SERDES_MAX to be SERDES_MAX
 + 1
Message-ID: <20181017150931.GA385@bogus>
References: <cover.1539036280.git.gustavo@embeddedor.com>
 <3a1a95a4832af33dcd1842b0298d257bbcf1f5ab.1539036280.git.gustavo@embeddedor.com>
 <20181009072723.mshyvplpo2xmkyfl@qschulz>
 <dab86dfb-d56b-b7c3-8e2a-6955803a2842@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab86dfb-d56b-b7c3-8e2a-6955803a2842@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:44:52AM +0200, Gustavo A. R. Silva wrote:
> Hi,
> 
> On 10/9/18 9:27 AM, Quentin Schulz wrote:
> > Hi Gustavo,
> > 
> > On Tue, Oct 09, 2018 at 12:21:36AM +0200, Gustavo A. R. Silva wrote:
> >> SERDES_MAX is a valid value to index ctrl->phys in
> >> drivers/phy/mscc/phy-ocelot-serdes.c. But, currently,
> >> there is an out-of-bounds bug in the mentioned driver
> >> when reading from ctrl->phys, because the size of
> >> array ctrl->phys is SERDES_MAX.
> >>
> >> Partially fix this by updating SERDES_MAX to be SERDES6G_MAX + 1.
> >>
> >> Notice that this is the first part of the solution to
> >> the out-of-bounds bug mentioned above. Although this
> >> change is not dependent on any other one.
> >>
> > 
> > Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > 
> 
> Friendly ping. Who can you take this?

Applied. No need (nor benefit) to ping me. You can check the status of 
DT patches on patchwork[1]. If it is there and in the "New" state, it is 
in my queue.

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
