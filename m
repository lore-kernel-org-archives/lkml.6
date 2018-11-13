Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A58C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A01216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A01216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeKNFtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:49:41 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37214 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:49:41 -0500
Received: by mail-ed1-f52.google.com with SMTP id h15so6794206edb.4;
        Tue, 13 Nov 2018 11:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2rWYMfx31rj0NaVGL3Q8IfRCz4Su4se9kdxyT90gJ8=;
        b=B+c8ZNcG1uzgMdOjY/P/mggRsKF5s2y6r8ncxkAAMc1MsdP+xBpH3Yxri2NIWQv3Xv
         5xviDevIalhWQ5tH4UzXJ8/Ug43jxOhpJQwvPJRFcIzYdiXe03gZmhEzbJkQ/bPh9ic8
         Xb/hhtuBQ6VcP9oAqU/OQthXDO24oMmvCiQQwHL4ahNp64bsdG3m3mkPo1kENBwLGzI+
         3aSrsfos2xZQGvch/ycWjeGKBm/KSb3WDwqPOlRzB/07GxTYZMX2JYSA1G8JhdAJ1vd0
         uH/m+EtMY+X42tYwWuPdVxshIgvUEGpxvxBKFN+vISwYXNa/yQS+oh/UUgEYsFputtOz
         AIIw==
X-Gm-Message-State: AGRZ1gJy8d9qwWVKgBKRoOssS35D0Q5DDf9d34OpGrowYm/yCDP0TB8o
        WybA3pAi51ATY01N3Y5EenY=
X-Google-Smtp-Source: AJdET5eKAsgsl2wJm1sAsPtpJ5gwO0hIwvxbwFj3DDIrUJi2v1elGl9HYfb1AKRVQJViAYLmQBiIgQ==
X-Received: by 2002:a17:906:6181:: with SMTP id q1-v6mr13529237ejk.219.1542138602223;
        Tue, 13 Nov 2018 11:50:02 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id w25-v6sm5949877edd.78.2018.11.13.11.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:50:01 -0800 (PST)
Date:   Tue, 13 Nov 2018 20:49:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCHv5 5/6] ARM: dts: exynos: update maximum frequency for
 emmc to 200MHz
Message-ID: <20181113194958.GE2418@kozik-lap>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-6-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927140738.1006-6-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:07:37PM +0000, Anand Moon wrote:
> Set the max-frequency to 200MHz for optimal performace of eMMC.
> 

Thanks, applied.

Best regards,
Krzysztof

