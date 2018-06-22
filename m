Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F56EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEB92472E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEB92472E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934119AbeFVS1N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:27:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33071 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbeFVS1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:27:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id q21-v6so1735099eds.0;
        Fri, 22 Jun 2018 11:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Z3WmfflDUKu2E5/aNPifecm97kDg6a0E8R/qwHLugc=;
        b=oNF+x+aJ5KFDFP/lvfCOVZslDKe28JNUtRfQGbxH3DsMw6Ot26qkMPg5UP9OkrDElj
         N756R+Rjvyz7jZjZUzIzCzS3j+VB30Qz/JEWO+/AiaSPPqlu+F6vdSsu/PD8wXGGXwOS
         //iUSAM3qFQ5pyVuWkFLFxqivWqt+h+jO6mL+qGeY3u923M0qiU/vlNkQIg0aF2/dYxY
         Xn4qDq3HZYf53rkr61T2Q2JCFSset1AJ0cm/dbwg6yB6/HiWKC+32W3HglXRWCzQPiPL
         ByCwxtjRINQyWPSQp5whE1LWjmXFoQnnhr+TCmDxXxRk1hd5i6VKG+bR8jDuSinywgxP
         rwXg==
X-Gm-Message-State: APt69E2uRSya7KuqPsZT0chKBE7exhtQkLieKYL/5ApaKzrMbdSM/oNo
        skE6luUaqeWKxMkgdcl99QI=
X-Google-Smtp-Source: ADUXVKKqMrRmlCzhniPcdk0yhtPLcGeeIY7KOqD6fLOHM/TMRUUHvNRFMn/Ryo4PobRw8ZQPt6QV0g==
X-Received: by 2002:aa7:c808:: with SMTP id a8-v6mr2663406edt.124.1529692029771;
        Fri, 22 Jun 2018 11:27:09 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id f11-v6sm4254440edb.54.2018.06.22.11.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:27:08 -0700 (PDT)
Date:   Fri, 22 Jun 2018 20:27:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
Message-ID: <20180622182707.i52l3z4yq2ozmqkw@kozik-lap>
References: <CGME20180621103531eucas1p15ccaf3a2069fe5a188daaeb8e2a29a93@eucas1p1.samsung.com>
 <8551504.8D13YNfR1X@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8551504.8D13YNfR1X@amdc3058>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:35:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Remove no longer needed samsung thermal properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - rebased against current -next kernel
> 
>  arch/arm/boot/dts/exynos3250.dtsi                 |    2 +-
>  arch/arm/boot/dts/exynos4.dtsi                    |    2 +-
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi |   20 --------------------
>  arch/arm/boot/dts/exynos5250.dtsi                 |    2 +-
>  arch/arm/boot/dts/exynos5410.dtsi                 |    8 ++++----
>  arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi |   21 ---------------------
>  arch/arm/boot/dts/exynos5420.dtsi                 |   10 +++++-----
>  7 files changed, 12 insertions(+), 53 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

