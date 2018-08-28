Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4D920847
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4D920847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeH2CKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:10:16 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33876 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2CKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:10:16 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so5748121ois.1;
        Tue, 28 Aug 2018 15:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1OXQWolOWH2Yojp5NTcp+ar6fPwUgKomXzIX21d+D64=;
        b=ZkPCZ0oxqD5sH0Wme7axkOLIpmQuaLx1kLrU2t59Ilgrjyu4WTw/wlZLU5J1tqjvCz
         mKmpNXX0JwSnIU0q7cUy+Bxf/gpzpvELOWVFaFM+E6frMJyuLWxuXQPhk/xomBCa1H6R
         SCN8TfBrroRMOaDRJkW6bo5n5V1dTk0UOywn0gDmF5ysiTFcWlZkLL7BtN28IkTw+CUZ
         WVnK2OS37I1+p3lZTEcUMsvFQubEm2YJCeb/WSOIx8oZajwlIQe0ajLiwJEZUjjt2T8o
         J741FYVcgSpgcC2AjH0jOcjCqbTsdRpKLiLEDn4mMSR0i/O1UCUdc+/6e5DxF857t5R/
         wM1Q==
X-Gm-Message-State: APzg51CCGqA0+Lmd8lZsqF5gQf4lgzmFfflFhSJxPIH4t/ozuH83h6dm
        SgDuTCDfATd72i6UNYzUnEAiWTY=
X-Google-Smtp-Source: ANB0VdZLlV3eFhB5hyDtPD9CuDkQJzJqQc+6itpuszS6HM/n6p5/ufhHfRBT8UfcKlOi2OSTpucaHA==
X-Received: by 2002:aca:a8c1:: with SMTP id r184-v6mr39158oie.215.1535494593693;
        Tue, 28 Aug 2018 15:16:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x5-v6sm2092635oix.3.2018.08.28.15.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:16:33 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:16:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jan Tuerk <jan.tuerk@emtrion.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "GitAuthor: Jan Tuerk" <jan.tuerk@emtrion.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/4] dt-bindings: arm: Document emtrion emCON-MX6
 bindings
Message-ID: <20180828221632.GA1345@bogus>
References: <20180822155137.10018-1-jan.tuerk@emtrion.com>
 <20180824132617.43975-1-jan.tuerk@emtrion.com>
 <20180824132617.43975-2-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824132617.43975-2-jan.tuerk@emtrion.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 15:26:12 +0200, Jan Tuerk wrote:
> Document the compatible strings for emtrion emCON-MX6 SoM's.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  Documentation/devicetree/bindings/arm/emtrion.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
