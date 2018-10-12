Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02215C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89812087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89812087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeJLTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:12:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33885 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbeJLTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:12:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id v2so4919795otk.1;
        Fri, 12 Oct 2018 04:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdM+svzuuq9DytLRTmKmZYQb4NHr2Ksv9hLZIolBGXI=;
        b=krF8p91QV2+nAlUGeqE/sjTcDqnwxQbfWxEU1NG6o3UpDT1VxSUhfGwcP6ybvnWeJI
         QVIK+ynDL7i/U7CQaICjeSRnXpTCHUl+0UaWeD58BwUCPxYcq4SOZdJwtP4Yjc0GL/KC
         LUvRW0ZZLEvUCuklsz2/8FgL1KpljNNS6djzBuWOZO4cUVS0Rho1G0t+fKpmgMXhu8nK
         ZuZc9llMXls5KRJluHpBq3BM20eprKZnCC807k1hpm47WueLjo9IetOPZ540rjvxqsIi
         pWgf+w187Lg7Vnhzu27mZXmguyC3fj97iG3fRdykGlxEBz5ENrG2ExmOYKutQu1BRuB8
         hr1A==
X-Gm-Message-State: ABuFfoiwdHL2U574uN7EqycJSrrxXVlZd7MWmmfBXdLPcXHehx6RMSLq
        4tEhwrHps12HF6TqpN68Uw==
X-Google-Smtp-Source: ACcGV63gfSv62Ck8zoxeTii7Av0rsGTBWe4sNPoPKcOkZ2tmxiyisZ4+TW2TCVG9wv9lOIgl2Zb4nw==
X-Received: by 2002:a9d:48b9:: with SMTP id d54mr3454213otf.144.1539344397372;
        Fri, 12 Oct 2018 04:39:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t11sm236028oti.21.2018.10.12.04.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:39:56 -0700 (PDT)
Date:   Fri, 12 Oct 2018 06:39:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] doc: devicetree: vendor-prefixes: new vendor -
 Emlid
Message-ID: <20181012113955.GA25152@bogus>
References: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-3-git-send-email-aleksandr.aleksandrov@emlid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539339841-22235-3-git-send-email-aleksandr.aleksandrov@emlid.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 01:23:59PM +0300, Aleksandr Aleksandrov wrote:

Commit message?

"dt-bindings: vendor-prefix: ..." is the preferred subject prefix.

> Signed-off-by: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

With that,

Acked-by: Rob Herring <robh@kernel.org>
