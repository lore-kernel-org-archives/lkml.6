Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395E7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0726C20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0726C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeKRCVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:21:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45430 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeKRCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:21:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so23517965ota.12;
        Sat, 17 Nov 2018 08:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ne1NpEO1FeMywkyS1z2UVjdJ6nBTpDUoaCGtR2zt0p0=;
        b=rNfb50jp/Q56LCOeUtj2OTpxb2p55KQezS/DNG9llkDbayalGeohpicJ8RFGp4+BPN
         L4uo9AAOdROTa5dv7LyIGihQ8JcpMGjsNHWQ+wGbmXjja3iT9a3cU9wQPRviqy/+WlkK
         227wKTCZiDO/R0raijAst61Vcmhj7Y2AC5Yr+qTCWvXCeN95XzGbXCpVesAfNQ23hmRI
         GqtFyHNKC5tAb+gZyj1ACxynOeNS41FzjCl7SEOWWy+c1G4SMJUw4+uoMK/1XTsvJLT4
         sczMxji8tYk3CVly4zUNgjaeO+QWea3GHdtallJuix0CZsDhlQssSDruUgOv5zR7PzmD
         FSTQ==
X-Gm-Message-State: AGRZ1gJ1jNFiGDEU+1bZIAwN2dWZsmVN2co47L8w3SRmj9FAcWusC04s
        qYIgWbHJ5udEW6nH87JNNA==
X-Google-Smtp-Source: AJdET5egj6ZIjyBoQ1RFEHWm70At/HdA+pZAzT7R/lS1FqBreSngjlBYwkCzurPSw8whCaPLv2LJ4g==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr9514081otg.139.1542470685670;
        Sat, 17 Nov 2018 08:04:45 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id a52sm13702206otc.51.2018.11.17.08.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:04:45 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:04:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: pinctrl: update bindings for MT7629
 SoC
Message-ID: <20181117160443.GA1462@bogus>
References: <5d63d26156d2972b7e9f55c9743b66d7c6dac2ec.1541986223.git.ryder.lee@mediatek.com>
 <46ee25bb5ac7a7aa0245e2b02e9a0e870ff09551.1541986223.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ee25bb5ac7a7aa0245e2b02e9a0e870ff09551.1541986223.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 09:45:06 +0800, Ryder Lee wrote:
> This updates bindings for MT7629 pinctrl driver.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Changes since v1:
> -add new function for wifi.
> -add more descriptions.
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt | 131 +++++++++++++++++++++
>  1 file changed, 131 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
