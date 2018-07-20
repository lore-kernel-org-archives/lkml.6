Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03492ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12EA205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12EA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbeGTPFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:05:37 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38179 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbeGTPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:05:37 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so14769814itb.3;
        Fri, 20 Jul 2018 07:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8799CTuoXNwShJlanQ4QPdTgq0VhbnFwd/5OcJLsjoM=;
        b=kQkEuGSGfiXaHEt//qTk3PHKwoSp+miomr6QLSpLqAQ1reTUR2U91hEl6hywkQ9xeX
         02Qvc+n+4BkqAPKIiDIJFr8Xs5QyM7hqC3c1KF3kGVKKokJHO2F4RzNwTYen7D24aK08
         1oOJIthh85IUSRuYlrQh6O56e24hlfgWTN093b9yrKKs4gn7jG4H+Heww5BZ87/JduKD
         N+wnUnajxk5lw2rIKGeIK+DtezY99CB5u1LXm3I1i9JXaCD2Exi7YQYYcq5mx9xbh0Ta
         CaMw0jAG61wP5lQvtHzcQV8SC/TgIzEavPuhfSQxfnXFAolEQg02wsgKRffjJeDPMZby
         YJmw==
X-Gm-Message-State: AOUpUlFP0m40VhJDqecoCAazYJtOheqEXgfX5KLYI4bgGoYbZkzBXTom
        oQjdEls9i8hL5vRWzrL9iw==
X-Google-Smtp-Source: AAOMgpc8O3z/fPqMgMZ/eXnDEYEN96USeCldxQWcEfIjI1pLtoi5MnRPeLmrLzKHLc4e3rmVazn+uA==
X-Received: by 2002:a24:190c:: with SMTP id b12-v6mr2022081itb.79.1532096226929;
        Fri, 20 Jul 2018 07:17:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z195-v6sm1149945ioe.38.2018.07.20.07.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 07:17:06 -0700 (PDT)
Date:   Fri, 20 Jul 2018 08:17:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        kernel@collabora.com, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: dwc3: rockchip: Fix PHY documentation links.
Message-ID: <20180720141705.GA30482@rob-hp-laptop>
References: <20180710125848.15915-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710125848.15915-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:58:48PM +0200, Enric Balletbo i Serra wrote:
> Commit 34962fb8070c ("docs: Fix more broken references") replaced the
> broken reference to rockchip,dwc3-usb-phy.txt binding for the Qualcomm
> DWC3 binding (qcom-dwc3-usb-phy.txt). That's wrong, so replace that
> reference for the correct ones.
> 
> Fixes: 34962fb8070c ("docs: Fix more broken references")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied.

Rob
