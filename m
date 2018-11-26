Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8265FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E240204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E240204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeK0Gxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:53:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37730 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeK0Gxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:53:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so17061690oia.4;
        Mon, 26 Nov 2018 11:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UqD6qLKr/HNRfNiXPlQ19UiGN6DmHE91LkDOhS6U5W8=;
        b=XMvgh5VjbciVzU0z2mnOY1RyKRFpxiC3hpgSXWxNRlRBgW5gz5f2dM9CXLK2I4HY/I
         7GNpJng+sm4eZkEq5KSPPwOKCACrfz6wxQ/jrCDHrLofhls0zwCygxOGyxlXT8phv31u
         lu9B7u3FqB5wfAZE1sCOUdySw7CenTaNLrUW5mjcoL89ygMappjkca/76wSIg1eN7pMA
         5uj7c0KpbEZJP9Iw7CNS8ihUl7TuqoKiJN8CDg5w4Tax8RueNhXiX3S/WDTsmpyaxVju
         OdYFa2jlYxUlN3H/P3/dgkID97Dqs6eOTIku0R9vvPaoeI/l++Dz9pS3ZCMFfYUkmliC
         c2GQ==
X-Gm-Message-State: AGRZ1gJveO1uFNvnZGLh5UlHpSKe2IKfiIl5dvUNWxUYjcg4dC1S65x+
        MC/yDP3Lrifv+XZZbX6NCw==
X-Google-Smtp-Source: AJdET5cGl6oqdnU5oVpxxVVq3ww/SJl1w8rtCYkB1owmngg8Fu85go3zo8+pLfNygpPWRvAt1EWfSQ==
X-Received: by 2002:aca:c715:: with SMTP id x21mr15283306oif.139.1543262319711;
        Mon, 26 Nov 2018 11:58:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e42sm1073762oth.36.2018.11.26.11.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:58:39 -0800 (PST)
Date:   Mon, 26 Nov 2018 13:58:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH linux-next 09/10] dt-bindings: net: ti: deprecate
 cpsw-phy-sel bindings
Message-ID: <20181126195838.GA19167@bogus>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
 <20181126001531.12974-10-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126001531.12974-10-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 06:15:30PM -0600, Grygorii Strashko wrote:
> The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
> deprecate cpsw-phy-sel bindings.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  Documentation/devicetree/bindings/net/cpsw-phy-sel.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please add acks/reviewed-bys when posting new versions.

Rob
