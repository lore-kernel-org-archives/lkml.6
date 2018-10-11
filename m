Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66F4C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7794220841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7794220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJLFjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:39:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39791 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeJLFjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:39:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id l58so10516868otd.6;
        Thu, 11 Oct 2018 15:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqYyWfFW8ggQQZYeX+85vGoz1Uy6K3zfO9tCtgv0vVI=;
        b=jmONv6+J0pOHCBKh99FDtwa//fuRx5sL/RAkckg01+jHLjIYYPZRnUq8ge/Zn9v63v
         01hVpFWdncGyIfvqIAN4j5d8Ft0HLy0C968qVahrndgGI+YmePYkAORZOwVHMwWxFpY9
         mKARKS7xLtJRDdeW40KozukFOA9UJTNTfxUz54U3qUKzSynzsN/adx7+8r24dlv79NLM
         h5jF4o0fgxhMhqg/1rrjI9mHew2gagVfYttSvSgF4gFR1mdqr4/UWG4OF/SBrTRZvGqJ
         XFp1P3qVkinS2kf6oZoJx8D2/DktXfRd9XIKVXWQw4v9a8eP8X1eLnhOoENjURNadrWS
         3QBA==
X-Gm-Message-State: ABuFfohHH2M4iDvPgQtOmylw/y6m8SyADwHKtPSf+4SPREyzL4axAWn3
        /o9mtfwNxTYxmwECDghFcw==
X-Google-Smtp-Source: ACcGV61bSd6HGu5zt+fsEPWynUPJY0Pt51jvBjR7NT0CdzLSBRVclRXCjIIsZpb39RXiu/0SuTbsvQ==
X-Received: by 2002:a9d:41e9:: with SMTP id v38mr2411040oti.16.1539295824762;
        Thu, 11 Oct 2018 15:10:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c186-v6sm9587527oih.28.2018.10.11.15.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:10:24 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:10:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 1/3] [media] imx214: device tree binding
Message-ID: <20181011221023.GA29071@bogus>
References: <20181005225011.3269-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005225011.3269-1-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Oct 2018 00:50:11 +0200, Ricardo Ribalda Delgado wrote:
> Document bindings for imx214 camera sensor
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> Changelog from v10:
> 
> Sakari Ailus:
> -Re-introduce clock-frequency property
> 
>  .../bindings/media/i2c/sony,imx214.txt        | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
