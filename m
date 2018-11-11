Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207A2208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207A2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbeKLIZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:25:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33687 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387595AbeKLIZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so155834oib.0;
        Sun, 11 Nov 2018 14:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkPt9IOz7Je01VGAUlMhZtO9VWUeOwC6PMsArIWg7y8=;
        b=mZD+nKS6KzgXAulO8vVkHEmwwdrXwNdn71z4s7AYm8BrjPkLJlEW0RXbLYb2yDkKh2
         8DcMelVxLIZhE8kMAeaGJRjyPhDP/D+xT6UyP+8F5sL96ZYvmGkQ9mPeWSaWM4Ru6GcO
         eAkW+D3aFeha6O2NhMI7usmonPPdqXOAudc1Te39DnATtg9NNuKaK1dC5XcSTOt7ta5R
         1CNlLDkYsR4wj7JpgX9aihTsNpApkXj3r40N0ZP5inUAIppMFRgZdOTsO3g+WOP4fCbD
         IRSc5lL2sulWFqH5MnXx7gqiLbXYd06KxmRaP9F3sxlQzAw8NQiOeJu/aseqjQBF6fho
         dwJw==
X-Gm-Message-State: AGRZ1gLR6JnKLIkQIX9V9OhqBBK9z/sLfaIrj5Q+vkqkJFB0Ctnh5HbT
        8jA/qGZ9SezFhg2n9N3vitzWBu4=
X-Google-Smtp-Source: AJdET5dhCNTHAF4AKxUJBF9tmFvSO0j6yz3NGWUnR4z3himRfsAXnKMbhLc4L9sZUatcp/5TDPoaJA==
X-Received: by 2002:aca:48d4:: with SMTP id v203-v6mr10214122oia.69.1541975741697;
        Sun, 11 Nov 2018 14:35:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j3sm5906195ote.16.2018.11.11.14.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 14:35:40 -0800 (PST)
Date:   Sun, 11 Nov 2018 16:35:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable
 binding
Message-ID: <20181111223539.GA27390@bogus>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 20:03:45 +1300, Chris Packham wrote:
> Add documentation for the marvell,ecc-enable and marvell,ecc-disable
> properties which can be used to enable/disable ECC on the Marvell aurora
> cache.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v6:
>     - new (split binding doc from implementation).
> 
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
