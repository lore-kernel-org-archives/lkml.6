Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF86C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5AE205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5AE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeH2COA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:14:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44324 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH2CN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:13:59 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so5698183oih.11;
        Tue, 28 Aug 2018 15:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtUm6YMg0SITnE8ae8MTeO73MAgGntzg3e2uWZ18rNs=;
        b=c9x5diBjeQu073juR97ej8eaTJsA8JJPo8EV3dVSptG3ynjEOyx1TyVlOeh2ovaMnB
         CMpwbXI3YtA9wHzdHl7o0YpfbmbLOmcKNFEUSj99Fmhv0jkjERZsUfVM818gf9GCoLEg
         XpY7w5a4DOn0smv7TmNQla9v3MiL8agH55GPS9fyk830iq39ZC8MiOI1juijzClUjMqI
         42tS2XGKwNmdbnHcTvoFIDH6oBxuVVDxyItAlBwfHqkBDsu3cjYRDSFTwUq4bdjcMvfo
         E5l2x9kLNfa++iXo/zrdd+PzBPhcrMLCEdfjSsdgOmDQESM/mEGfGDApQT5E0jPdycCw
         pxaQ==
X-Gm-Message-State: APzg51CufYeX5qlaVrNkC4NfBgwJHqmmplTGkAAfbz5+vMDjDVSnNJYo
        9FdiytjnnSwSPnQAPT9Gdw==
X-Google-Smtp-Source: ANB0VdYveK+EoqJW6X4AUK0vv/kuOf22YWQtTerIPd3EGbxTEfw8M/ummXW8EdwO5QL4EOP/874qCg==
X-Received: by 2002:aca:4c92:: with SMTP id z140-v6mr76899oia.318.1535494816411;
        Tue, 28 Aug 2018 15:20:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e205-v6sm2375191oia.9.2018.08.28.15.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:20:15 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:20:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/3] dt-bindings: input: Add document bindings for
 DA7280
Message-ID: <20180828222015.GA26211@bogus>
References: <cover.1535358095.git.Roy.Im@diasemi.com>
 <a0aba6fe0b63f5a685743c88e192701731e289ab.1535358095.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0aba6fe0b63f5a685743c88e192701731e289ab.1535358095.git.Roy.Im@diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 17:21:35 +0900, Roy Im wrote:
> 
> Add device tree binding information for DA7280 haptic driver.
> Example bindings for DA7280 are added.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 
> ---
> v5: Updated descriptions and fixed errors.
> v4: Fixed commit message, properties.
> v3: Fixed subject format.
> v2: No changes
> 
> 
>  .../devicetree/bindings/input/dlg,da7280.txt       |  105 ++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
