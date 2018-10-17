Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA95ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD7821486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD7821486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJRCk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:40:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45491 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeJRCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:40:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id u22so27199808ota.12;
        Wed, 17 Oct 2018 11:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fEdKiaalyLRsvukTA2HosQmD/Jwci5A4PjJMS15VXzE=;
        b=TxS1pK2jGNNYddNSvIV2CS+Nnu6KnIpDsYGLaFrgjkixccd447OZdjR8OQWx03eVlU
         8W3JK315bT/jzdyZNv5ZUvQjYK5ScbqSloBghN6hDc7eC2+HD+a4lu0yPSB54LV6SNlG
         Pz1xcKymViJPcwaxXRlcVa6YKznaHbg+MnkYQXE5T6haVd6kwVTN+ZvIhUoMokTz7HgG
         t3TM/EkqG/rA9GVChdxBMmb0qvS0YGBfAT0IRrTP0iHH6pnoFDGwZO/u+z610NblYmXx
         P12JwL5sJI347vNslGadxnFU/0YC5lXCJdv+yx3TwAQIwtZSy7ApSFvtRzkjB9ZklFx5
         5GZg==
X-Gm-Message-State: ABuFfojtMVxEHmBz+LVOla2+wcj1/YnhH0TMFrjxIqmrQnw48Ss86SJO
        CmfHKwLjgRLLhNJ4MplqlVYXpvE=
X-Google-Smtp-Source: ACcGV60ITbzQTz0KRySaUg5o+Xgkrk3vlLDaxxK+AqEp8Yerjx8pHIjyoHCy6J3B2pKjRG+Ru6PDRA==
X-Received: by 2002:a9d:7692:: with SMTP id j18mr9462561otl.217.1539801809002;
        Wed, 17 Oct 2018 11:43:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b49sm9334311otb.33.2018.10.17.11.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 11:43:28 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:43:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add OLPC vendor prefix
Message-ID: <20181017184327.GA7317@bogus>
References: <20181010163824.269277-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010163824.269277-1-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 06:38:24PM +0200, Lubomir Rintel wrote:
> One Laptop Per Child is a non-profit that produced the XO series of
> eductional laptops for children.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.
