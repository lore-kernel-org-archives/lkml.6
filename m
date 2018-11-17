Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0057206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0057206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKRCrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:47:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37838 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:47:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id 40so24122163oth.4;
        Sat, 17 Nov 2018 08:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=opidqkVrP2wBbvNIXFeOFVg+5ED/fussnhMXZoPAxkA=;
        b=EJLxm85VvP/X6gsPVZ94IybWcxlK2JEc2tXFpzxj5n/6q9iUalOlExE7upxz86na2g
         wY7PtPJqUwR/OwFDY6USUGrU5VAfpu7H1CbgypZdVpsX7sExWqJPJhi1BKl9iUYMaUNU
         N6FGK6p3VI9Gdar1i7mPtEHDnVC8CIoBMkInk6xERRqt0FKvJlSYWEzFH798c5QMLps+
         mHTtMHPgVUjbSmhLKISzc8RM/cjVvNMxtQJz/SoiKPYkY1dnkJPmwG9mhTd5s3pjDuwB
         Vs9xtWXfV8vnOGlYwZWkoKqc0gwuBJfr9qkDFfvFDEXSoxE7H2QY1EHuBVxf9AAUnoDF
         NTsg==
X-Gm-Message-State: AGRZ1gJYm2+7uog+bpJnwgv87nwqlHgi80k1HaTqy7vaGeeKWVGzK7pq
        /PDBL9Ozo9L9/X9Bd85gOg==
X-Google-Smtp-Source: AJdET5fY+64hu1k4HTtbJP40K7I012xm+fj7efn2mPumIFH0IzNcv59FGNnL7C59DuSwP+RVesS7iA==
X-Received: by 2002:a9d:190c:: with SMTP id j12mr9462716ota.20.1542472228121;
        Sat, 17 Nov 2018 08:30:28 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id x127sm6702114oia.20.2018.11.17.08.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:30:27 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:30:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset
 description
Message-ID: <20181117163026.GA4924@bogus>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 10:42:06 +0900, Kunihiko Hayashi wrote:
> Add compatible strings for reset control of AHCI core implemented in
> UniPhier SoCs. The reset control belongs to AHCI glue layer.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
