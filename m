Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F92EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA991206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218248;
	bh=GV/EfVMz+OLbZVHH+e5T7afCCfG0tjSoTIZZK0r4pXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mh69St8C/tkBcjCgtySYwkcrKEfkfrqXI7ak9wb+YDofpzGnxrTccImOSt7sZOWP/
	 VTxddQaoVASlIU5FWjIV9QlL+XSyJ7DlHPAbKgUKQSS9Eqnq8vb37Bygt1gTEARZDk
	 oNKSh+UEZmYzsLrSfmcGI8vvCVpTKCV0DfOYn4lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbfAKOur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:50:47 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41400 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391149AbfAKOkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so12337323oii.8;
        Fri, 11 Jan 2019 06:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5AgKfumJTmCJZDmWpituxPz/5EgWlc5vUnvJmAPLvks=;
        b=d9m71Ir50nB0gQA/89GuGD0kZyKm7ehJDsISZR2uYorsdC/TvAf+WZ56L4W/2Uhd3J
         Acqs9LgQ8F5ztZzf0nnsv61r80bKN246CBQb6z94IFG8b564GsROpczKfT8r7Gjs/D5X
         Y4sxdBgfw6RoxHW6ZTzhQKZPQ+UZPG5mPBG99NMLnoTzM2bBPXQWZyENJ5ZFom9u9sRs
         4iIwWF3x4ik//WFKw76xUGtr8wL9XcEMtMlvjm/sPFlFdJnTI0xefwiSYYBkiO5PbOcV
         n7YTNHUoKvkXhUsKgEXbvci37STVebX2cBOvt2fJMQcCBcJwl/k+MRL2RQVabfGxZRme
         2x2g==
X-Gm-Message-State: AJcUukfQZWUojMZLWfWt171UhtoaUw8NINAL/U+Yrtaaq5lukzS7fVub
        Ox/6lzDnesKXQRUUcJ7v3bbxAQU=
X-Google-Smtp-Source: ALg8bN4bJFgaKoQ7VYgBSgmYkRY3W7YKzzvZdns3BLB2bWN6DX1G1CMUvo4gxJZJ3WjHk8MKSlD0Tg==
X-Received: by 2002:aca:5205:: with SMTP id g5mr9644565oib.149.1547217602122;
        Fri, 11 Jan 2019 06:40:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k130sm36530903oia.47.2019.01.11.06.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:40:01 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:40:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: Add vendor prefix for "GlobalTop
 Technology, Inc."
Message-ID: <20190111144001.GA28255@bogus>
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
 <1545994235-8309-2-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545994235-8309-2-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:50:32AM +0100, Loys Ollivier wrote:
> Add globaltop vendor definition.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8fcc16..a9214767afa8 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -153,6 +153,7 @@ goodix	Shenzhen Huiding Technology Co., Ltd.
>  google	Google, Inc.
>  grinn	Grinn
>  grmn	Garmin Limited
> +globaltop	GlobalTop Technology, Inc.

Alphabetical order please.

>  gumstix	Gumstix, Inc.
>  gw	Gateworks Corporation
>  hannstar	HannStar Display Corporation
> -- 
> 2.7.4
> 
