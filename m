Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0519C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843DD214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843DD214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbeKLIa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:30:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43622 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbeKLIa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:30:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id j202-v6so5707724oih.10;
        Sun, 11 Nov 2018 14:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FaC2JHKbVRWWV9iOtczP1FDmiDQ/g7GqBStnKvhxKws=;
        b=P2V4ZHB4oa7jZh+KFaOhYRtUVWYcY0NrG4sK4yyRS8KKGJXr1aCUzyYqzktJ0w3An2
         Xlz0bxFntIL3CAPMkQzyReZyiIylPza9unDqMHlXY/2IUqyTIDU6KZ13Fo88Vz7nmVkQ
         cOHGNx4uLMITHiUqXYUyaUv3NECpX0Nlpk3Q3I2HgCnI/4P2mlVFpFCaVkmRVe1XngUi
         Xd6VdehIrxza+GnF45sqadG86EhFYohM23/6LAekQTN2ZD0O3xgzLgaZ/FFfjWUJJ8s4
         C+SM82hY59crc4utekG4IhmhQYonFjBBpJsWiCkF0d+OH6N5U+FruoOy0h9mYea7/pc+
         nJvw==
X-Gm-Message-State: AGRZ1gKUlpw4q8RXiUhlZLLSHwPpVT/kqsyzeP5yVwV0MjJqZXZWrqw7
        IcjXn6kFkwT/fUs0kDovlXN7rYo=
X-Google-Smtp-Source: AJdET5fVOhA/TnINJmApX5bgktbsh+fxciqJpUcX3u3KT8E+XNDAABrHfl9NyIQVVqSILdVjNo7Ybg==
X-Received: by 2002:aca:32c6:: with SMTP id y189-v6mr4789538oiy.153.1541976056103;
        Sun, 11 Nov 2018 14:40:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d7sm6156358otj.21.2018.11.11.14.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 14:40:55 -0800 (PST)
Date:   Sun, 11 Nov 2018 16:40:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     He Yangxuan <yangxuan8282@gmail.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, carlo@caione.org, khilman@baylibre.com,
        narmstrong@baylibre.com, He Yangxuan <yangxuan8282@gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: Add vendor prefix for PHICOMM Co.,
 Ltd.
Message-ID: <20181111224054.GA3950@bogus>
References: <20181110033904.4207-1-yangxuan8282@gmail.com>
 <20181110033904.4207-3-yangxuan8282@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110033904.4207-3-yangxuan8282@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2018 11:39:03 +0800, He Yangxuan wrote:
> PHICOMM Co., Ltd. is a hardware provider headquartered in Shanghai, it's
> product includes router and smart devices.
> 
> Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
