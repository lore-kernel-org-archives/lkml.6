Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1599AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7F921508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7F921508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391315AbeKLIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:31:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39400 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbeKLIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:31:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id g27so6354203oth.6;
        Sun, 11 Nov 2018 14:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=txgtFMgrsstA9zgdsXgnve7uzbysPWBN5/XJa9hkxqM=;
        b=Bi6bfzSag0XYpGzENcVyeVC8xZS0lh/y0xPI2JWRA+6AnJPVYisuarm6roEVhNlZbk
         hAmBU10xzNuXbfWK4ADcyTpfUtia/Ds5cgLyTO8pHTBaPc5xFWN6smjt2ZdTvv7iwW5/
         i8FxJI4rpIJUkh1h/qxyOhtBZbiliGyI+jRmRkGSngVTcKwujDmREXO+Tzmu05PY7Lu5
         QGeadpahOIlGrg8JV7Uzwzijjoiv1B55bt60ITfXcFF6LL30blNt7uWt+3uoVeL0XShQ
         OA6Ea0Kps9c7Xq/Fdev7dbL74jc9nxjFhLG8/untQvDUIgHsKNnbdsa0DxnqjNCKZSa8
         JxwQ==
X-Gm-Message-State: AGRZ1gIpxZLTY44+9qtmrlP8eZWwSXBi0HIS3BW0NveUbhYcDaypbmSg
        JgxMzOOR3EINvjJmJVGmJA==
X-Google-Smtp-Source: AJdET5eJqa3jZqGasag/YoS8XF3cwkt+Yma1G75uDz5qXPFK0lUORSWRs1vf1APcpH/a8zwx0QQlsw==
X-Received: by 2002:a9d:67:: with SMTP id 94mr11017269ota.57.1541976101641;
        Sun, 11 Nov 2018 14:41:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v40sm6065943oti.53.2018.11.11.14.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 14:41:41 -0800 (PST)
Date:   Sun, 11 Nov 2018 16:41:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     He Yangxuan <yangxuan8282@gmail.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, carlo@caione.org, khilman@baylibre.com,
        narmstrong@baylibre.com, He Yangxuan <yangxuan8282@gmail.com>
Subject: Re: [PATCH v5 3/3] dt-bindings: arm: amlogic: Add Phicomm N1
Message-ID: <20181111224140.GA5820@bogus>
References: <20181110033904.4207-1-yangxuan8282@gmail.com>
 <20181110033904.4207-4-yangxuan8282@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110033904.4207-4-yangxuan8282@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2018 11:39:04 +0800, He Yangxuan wrote:
> Add bindings documentation for the Phicomm N1.
> 
> Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
