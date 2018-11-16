Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6B120883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6B120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeKQIp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:45:26 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44177 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQIp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:45:26 -0500
Received: by mail-oi1-f170.google.com with SMTP id p82-v6so20908993oih.11;
        Fri, 16 Nov 2018 14:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UZI8eg6j2GsUF69iZIyAH2PfRPJNFrlf5gaVNKXo3LQ=;
        b=GH2GtNzb59nf4CsWAE5Oiz6/x8Fej5iGAnez9vm+6PDRWk2v2ZkiqqFdwIoJM9f4eI
         uJt8umVzCiN5ckKVf4gHtdV3kzJgag6/XqaYzuT+BvmzLeXdlt+zbkdbfmuN5p0eZxKD
         hcmicO22efn+of3XGBR6uoKzmWQO8jroBLZwyaHF9H8lR49a9Wri0teVR081RsN6Vw3o
         6c27ZSWEcA03fiy+JRptwcyZxIaP03alt8rRwqQPGDxkPi/V5QoDfZrVKDWO2ljO5WWY
         aq5oixehtm65jGtz19DliOhhoXB/tfcFhNwfPVQima4yQSDveaYcc+CSJ82XOQ5SemXD
         GzUA==
X-Gm-Message-State: AGRZ1gL5ZvX/rhjGIRf8TYKnDcKjaAy/Kty1xFM/bLlOIaBZgWJQo+k+
        qe+URRRNZDcutxlxf/8NNQ==
X-Google-Smtp-Source: AJdET5cm28rBS9+rZi4Jli+whgNgCB4OT2zr/hotKwaC9wO+gQdeGSMoiel/d1RU2KZWzKEFztl9Xw==
X-Received: by 2002:aca:f3d4:: with SMTP id r203-v6mr2095466oih.95.1542407472964;
        Fri, 16 Nov 2018 14:31:12 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id c4-v6sm2053070oia.55.2018.11.16.14.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 14:31:12 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:31:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-crypto@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: rng: update bindings for MT7629 SoC
Message-ID: <20181116223110.GA19271@bogus>
References: <0f5fe0d5b6a9c81b3f4395a1007ed0ba2239ae45.1541574485.git.ryder.lee@mediatek.com>
 <20181116061854.ahs6jz7bmztoi3w7@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116061854.ahs6jz7bmztoi3w7@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 02:18:54PM +0800, Herbert Xu wrote:
> On Wed, Nov 07, 2018 at 03:10:16PM +0800, Ryder Lee wrote:
> > This updates bindings for MT7629 RNG driver.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> Who is meant to take this patch?

I've applied it.

Rob
