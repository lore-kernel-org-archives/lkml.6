Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796EAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515DE206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515DE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeHOXPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:15:10 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32891 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbeHOXPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:15:10 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so18329695itj.0;
        Wed, 15 Aug 2018 13:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+b6r4SppKBZg7JKOF/nN8XvwcDHx1WeARxigSwHbxLQ=;
        b=MSAgBEwWu9YV7HnJowaTUMMqbNVZvAYYK7a8X+KcVjGrb+R4qFnqquu/yE5iPufWH7
         3/XfD4k/L540JGsiRP2Fbf38u+oe1GntG6GCHznuttNCS3hsx4WSG/bE7mgN3MisGr+B
         Em7rKmaPvWJ8hba4d5bnmOb1tDWoGkqkTw3mD29l+TypjDz5gr0KHeqgJPzRdHJhKt38
         lNRZNk8UUlkKljLN0qs08fiKDbPLqBlkqLGrp9n4Lw6ygBTQt+cAOdUxso5bZW9Dgpo/
         Co00yJbNz3e2ERslzjNWpAlRtOVise1Bzxv9kjF7UyDz8feHh/BFyoSV/bU3j7lvrI9N
         u3rw==
X-Gm-Message-State: AOUpUlGCd1F87mt95X4ofnw2DnpVRu3xZ6mGUiwb06Do3KF9vgobfK0n
        Lef6ATgIWhn/LN2XbtUmSQ==
X-Google-Smtp-Source: AA+uWPyXMD8wKl7LiyCaNOt5phpweEmgdVRb9ORXbKbNt4ZoXYenIr1qxTiyhCwyfIr7cpfip22y7w==
X-Received: by 2002:a02:1a89:: with SMTP id 131-v6mr23985394jai.58.1534364489926;
        Wed, 15 Aug 2018 13:21:29 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 80-v6sm2168576itk.14.2018.08.15.13.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:21:29 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:21:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a774a1
 support
Message-ID: <20180815202128.GA11673@rob-hp-laptop>
References: <1534250028-15770-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534250028-15770-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:33:48 +0100, Fabrizio Castro wrote:
> RZ/G2M (R8A774A1) watchdog implementation is compatible with R-Car
> Gen3, therefore add relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
