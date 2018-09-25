Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213A20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D213A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIZBPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:15:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33932 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIZBPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:15:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12-v6so25641229otl.1;
        Tue, 25 Sep 2018 12:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=txU7+60QACCReBIFeeh0LFNQPQwIm/5Z1KLwZKmeH+0=;
        b=fHE7oJEsAPaLfBQZPVcrgGL/rgBS2rsR+uFK330agxjAMwnWu+mzaqHacTIMrB6yoF
         oRgE4wqPfJx9VMP8OX8EP2rPJl10SsRJHLK/tL9RuikZqL0LhA87uBgiKBcEor5j6HRo
         w4jADB46UQr12qhC7H1DhJF9ju2NLwzgfvgjb+cuhuS8m5qQqZR9R8JR7NcfaFYh0atB
         Mn1BDyAQvF0H4hHZ/sqDdpZ52H9jcH9HVYnpzz0CI8rOtX/wVqxUvoSPqnbj3s73coWZ
         Gm+utW1v1ttvfxetAYqVmc6MOG2pAWMmqwPR2IMilRAbohG3XTzIRsRQYhRHMRD0EEXi
         muyw==
X-Gm-Message-State: ABuFfojzdgtAwt8XrIdugUkCQwg/8yI6gK0nctJaNJ8TsrtG1rdTx/q7
        gRns06IEvyVjf30HnFU9Khh6pA9B4a9K
X-Google-Smtp-Source: ACcGV62HyeAhanxL077N9DxT6MbD0hoaPsdEXkP1Ok5zJ36RKQberYGROO7dv0FaeJ3FHQvM09EmUw==
X-Received: by 2002:a9d:3220:: with SMTP id t32-v6mr1635685otc.284.1537902415837;
        Tue, 25 Sep 2018 12:06:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f25-v6sm945711otl.61.2018.09.25.12.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:06:55 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:06:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 37/37] ARM: tegra: colibri_t20: add eval board device
 tree
Message-ID: <20180925190654.GA11832@bogus>
References: <20180902100906.25792-1-marcel@ziswiler.com>
 <20180902100906.25792-38-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902100906.25792-38-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 12:09:06PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add an evaluation board device tree more in-line with all our other
> device trees.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---

> +	panel: panel {
> +		/*
> +		 * edt,et057090dhu: EDT 5.7" LCD TFT
> +		 * edt,et070080dh6: EDT 7.0" LCD TFT
> +		 */
> +		compatible = "edt,et057090dhu", "simple-panel";

'simple-panel' is not valid.

> +		backlight = <&backlight>;
> +		power-supply = <&reg_3v3>;
> +	};
