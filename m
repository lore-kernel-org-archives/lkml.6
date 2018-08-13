Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DCEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FDF2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FDF2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeHNBrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:47:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33895 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:47:17 -0400
Received: by mail-it0-f65.google.com with SMTP id d70-v6so12935303ith.1;
        Mon, 13 Aug 2018 16:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9UYriEUC38w8JqnQPaLc9hr0UJXVTfFOxnXfRY0oDI=;
        b=UBxuweSgQuyMowEyRhEe6CYGYsga16PycsJcff4u25dKO2Z0WPO2pLNE33ervLRrWF
         u5jyR5m5yjoDPSIVSLaZkA2+h49T6Gm1JVnMB+mgmCwLNNDkHs/J5laYAPCqa+1CzNy0
         tytoPM1O00RPFRVCv5VY8xAMwTZ4GCqbLit1LtizsEHJYL7uXd5HfswZ2qs9/jx1UZJ3
         /jIXg2GtD3p6cHI0H4I1Ys/RFQ4qFDodt0jWbatI0INAhxd2SZ1MDLsWKiT+8SEZW3k8
         LahFNfQ64Vt8asH0AEpEmxsPUNoWmqYUX2wZrH/TkbiXzSrSpRDMMI6MspvATLmhO+Fc
         Xbgw==
X-Gm-Message-State: AOUpUlGA+mmd287E/+osjZOsWHbpNWs5eMyrbTw48tFfFaMP/auh1ubA
        w+ws/2RKHlYEZG8ccq4uFw==
X-Google-Smtp-Source: AA+uWPy66WP8zZ3B3DxQusgUwxA2u0MQmvR8zZyNKAIEAUKX3LOsyQF5vDaOKPe72IbNMKD3k32bhw==
X-Received: by 2002:a24:f68c:: with SMTP id u134-v6mr13195907ith.85.1534201376452;
        Mon, 13 Aug 2018 16:02:56 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id y15-v6sm14706148ioy.18.2018.08.13.16.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 16:02:55 -0700 (PDT)
Date:   Mon, 13 Aug 2018 17:02:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: Add vendor prefix for CDTech(H.K.)
 Electronics Limited
Message-ID: <20180813230254.GA29510@rob-hp-laptop>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
 <20180730231117.5631-2-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730231117.5631-2-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:11:13AM +0200, Giulio Benetti wrote:
> This adds a vendor prefix "cdtech" for CDTech(H.K.) Electronics Limited
> 
> Website: www.cdtech-lcd.com
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
