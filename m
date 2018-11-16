Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3F9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE3E2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG0rCJIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE3E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeKQGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbeKQGeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:34:50 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1152087A;
        Fri, 16 Nov 2018 20:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542399658;
        bh=e5aKcKJiYzwAqJmBU6zhCEamPzH+Fc39nDFVppA9Cs8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hG0rCJIguFI1+IbfcAA6miMLEeR12ji63BxVgyoMfG1TmyiS6Q5Naq9oJV1PxOs16
         Qe8+SG0uFqa+u5vN6f3AzdujQSpuvm7lz72kvoSBdXxQirvVUo82+LGpAA78WHHEuc
         viWq7UhhTirtwQ/byMUedpJj020c5Sbjn0EOM0tc=
Received: by mail-qk1-f175.google.com with SMTP id r71so39466890qkr.10;
        Fri, 16 Nov 2018 12:20:58 -0800 (PST)
X-Gm-Message-State: AGRZ1gIFjBbWZssss55v+rhi9XyEAwqcVwvKEq3WX/eiIq9eghhPxPDt
        pNUKv5i5AVn95nBjNdp4j/WmdE0TJBlCf2Txsg==
X-Google-Smtp-Source: AJdET5di8Tswb64LxDHZ5Gjfu1x2Y2/iHFxyCKJctIjSWZi0ui5GPLBmnZDtRbx+uKs0fETulX+lC+RNd0Ca2mA3N7o=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr12097246qvk.106.1542399657933;
 Fri, 16 Nov 2018 12:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20181018133105.3720-1-robh@kernel.org>
In-Reply-To: <20181018133105.3720-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Nov 2018 14:20:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJn2EOGJaM9saoYYnbZ+GrEMQWgp_1kSq6W9HX1GnGVWw@mail.gmail.com>
Message-ID: <CAL_JsqJn2EOGJaM9saoYYnbZ+GrEMQWgp_1kSq6W9HX1GnGVWw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Kishon as maintainer of PHY bindings
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 8:31 AM Rob Herring <robh@kernel.org> wrote:
>
> DT bindings normally go in via subsystem maintainers, so add PHY
> bindings under generic PHY framework.
>
> Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Ping? Kishon, any objection?

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ad052aeac39..b01e77ae79c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6132,6 +6132,7 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
>  S:     Supported
>  F:     drivers/phy/
>  F:     include/linux/phy/
> +F:     Documentation/devicetree/bindings/phy/
>
>  GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
>  M:     Wolfram Sang <wsa+renesas@sang-engineering.com>
> --
> 2.17.1
>
