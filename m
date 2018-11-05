Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CABC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B608D20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B608D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbeKFFtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:49:12 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36438 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeKFFtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:49:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id r127-v6so8723041oie.3;
        Mon, 05 Nov 2018 12:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dwVwoXa1nLilTRsAqCXbVt56WbbEgnkkcw+An0l4VKk=;
        b=qG2TZGiAKRZKzCBei3FW5HRyhq8qUsrPpAEE52hX826JPi/bhEiA959M5FEZ+0Bk00
         IOhbATXmFH29NU6XH0DfNtU5R+tHCruab529idUm8rg7wYGoStYhyC0jaHzuOmZuNpBi
         aPAMjG0iHK6yf37/eWFt8MyXsotFQlHAYlyzag/WmsA8urU2U0r7KR4tF0XDkGp9oJbh
         7eptHVCpGZ7ZGJqviRO6AmCTH+D3wG1UyHfLxCuRLL+G9ZKta8BZL7iv/In1V+O8UY5L
         03gB9hf80sfrQPcwLqjdhagXtd1ilIfuxpwkuoQ7ipsCtURL2/VEPaHNNcjAdabs8GXE
         5Tsw==
X-Gm-Message-State: AGRZ1gIjfRLy9UUwRAhJLC/qP+TW0NAENsmPhZzMUkMriTAq4kYKAaYt
        II5OEpT25UUK4O4rd3VzeA==
X-Google-Smtp-Source: AJdET5cJetAFxzAaO0q5o6bFwQT8iBelOGkbAy6XPUhefDfkJItJ456gh52QcOZICukZOLA29ig57g==
X-Received: by 2002:aca:4742:: with SMTP id u63-v6mr13051416oia.212.1541449666688;
        Mon, 05 Nov 2018 12:27:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u128-v6sm964306oig.21.2018.11.05.12.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:27:45 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:27:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     oss@buserror.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Yuantian Tang <andy.tang@nxp.com>
Subject: Re: [PATCH 2/2 v3] clk: qoriq: add more compatibles strings
Message-ID: <20181105202745.GA21644@bogus>
References: <20181031065736.32719-1-andy.tang@nxp.com>
 <20181031065736.32719-2-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031065736.32719-2-andy.tang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 14:57:36 +0800, Yuantian Tang wrote:
> Add more SoC compatible strings to support more chips.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v3:
>   - undo deleting old bindings
>   - split the dts and driver to different patchset
> 
>  .../devicetree/bindings/clock/qoriq-clock.txt      |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
