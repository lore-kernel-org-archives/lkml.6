Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35FD2152A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35FD2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeHPBLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:11:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46823 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeHPBLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:11:12 -0400
Received: by mail-io0-f194.google.com with SMTP id x5-v6so2262281iop.13;
        Wed, 15 Aug 2018 15:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4bGd+0qkZ/+YkySLkJaR88W7urjDSDFNTIrr4/9GhRE=;
        b=ab5VIcW6J0d1KA6l/Zp9kEA8ygNrrxnFRjrMLU7Yr80bcFUX7Yb+wLVxcnJkVZvXUG
         A54mQUMJttevJllUY24EbCIj6rOxx9rgKA7tT7v51pmew96RGMkFg2M5iUsXbYWEGLxJ
         wTO+99dQ7ayGTPc66Pgb9JSyXrdQ3IK4YH1jk3KtlzL03I/qQE4J6+I1IC0R6Hq3gi89
         BdtR6BIUVF049wXkl08WXe3vDNKexAurpad4HWNMizB3d4mvZkjgvASuMP9htOd21l+a
         04li+Ptrf4nLFJQV0IMESURyioiKER6wbAFyJQuEYDoG/vwV79X2uH8DasQM2984eqIg
         JsDw==
X-Gm-Message-State: AOUpUlHn9H/L8/ADenII7kW966lW6lFNMN9KbuO/ika3ny0K8icCQg8v
        TP/slk6oPfJdQWuxzjPRjA==
X-Google-Smtp-Source: AA+uWPwJqfCzQhiYI66iuzHL/uza7AsrcpuBON3mdZ2kkznlr7eTlLnXHKhWLAenNKXjE5U3S7G/wA==
X-Received: by 2002:a6b:ef0b:: with SMTP id k11-v6mr17219458ioh.12.1534371426822;
        Wed, 15 Aug 2018 15:17:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v3-v6sm1644712ita.6.2018.08.15.15.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 15:17:06 -0700 (PDT)
Date:   Wed, 15 Aug 2018 16:17:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH 5/5] dt-bindings: arm: mediatek: add support for bananapi
 BPI-R64 board
Message-ID: <20180815221705.GA7962@rob-hp-laptop>
References: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
 <93e3763cee209d7610307565a3ac02a0792417ae.1534130854.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e3763cee209d7610307565a3ac02a0792417ae.1534130854.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 13:18:17 +0800, Ryder Lee wrote:
> Update binding document for bananapi BPI-R64 board being supported.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
