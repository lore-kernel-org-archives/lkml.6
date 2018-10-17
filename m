Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906992150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906992150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeJQW7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:59:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47037 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJQW7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:59:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id o21so26461207otb.13;
        Wed, 17 Oct 2018 08:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sr0yHn/bIpPjIEWKVM9auosNVcWRDMK2rB2OzBv+BPk=;
        b=bQHRsnQpo8Q1oH185pm3XKSj8RvoYnHjsHUriCA8EK2G7JazDjHo1dVL2ipytfZuqd
         jq9vJtWFAMlbE6SdVXrVkUiME0qkAjafRIL+BRzeBQj+9xT5+clUDVUiS0ZbsDA9FDXj
         z6El91bo12KboAr/Y1DHzWPG+sTyLsQZH3R4N7ogzZ2FB4rpeiRxbUL3k3Yc+VMYokW0
         fU8uQxvh5qh+kc9gIYCEDvPnZ7C0D2EIEXuFZqrAf9CQwH3TRnkplq0pcJt541x7Y//K
         zrhr4arKWxXSpRs7Gkg6lPdV0TqeUZjyhUkZZKMo1GOgFUaE0/ruBd5VPZkvO8FXhKGr
         9h5Q==
X-Gm-Message-State: ABuFfoiQB/UijICzl3oWINXSaVAsinbMey1Xx5bkraNFfUmfd1nJB+BX
        XiuKXLDtRaml8JHj4hhGrw==
X-Google-Smtp-Source: ACcGV63Bda8hDrUIBOuzIXDdbBen29jaelXJsbLKtDBbd8zEjYkvK4xIlmzIEj4vwBpeNm9ON5JHww==
X-Received: by 2002:a9d:518c:: with SMTP id y12mr17523277otg.58.1539788574087;
        Wed, 17 Oct 2018 08:02:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f84-v6sm5271538oia.44.2018.10.17.08.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:02:53 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:02:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-media@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH 3/7] dt-bindings: pinctrl: ds90ux9xx: add description of
 TI DS90Ux9xx pinmux
Message-ID: <20181017150252.GA11075@bogus>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-4-vz@mleia.com>
 <CACRpkdZJMPYWHBUXohjxo12XZpLdz7OzcWRBrrkcB8YLLd5StA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZJMPYWHBUXohjxo12XZpLdz7OzcWRBrrkcB8YLLd5StA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:45:43AM +0200, Linus Walleij wrote:
> Hi Vladimir,
> 
> thanks for your patch!
> 
> Can we change the subject to something like "add DT bindings" rather than
> "add description" as it is more specific and makes it easier for me as
> maintainer.

To add to the nitpicking, The subject already says DT and bindings, so 
no need to repeat it. I'd just drop "description of" if anything.

Rob
