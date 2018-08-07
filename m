Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AADC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E5021707
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E5021707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbeHGU03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:26:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43902 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388523AbeHGU03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:26:29 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so14750229ioa.10;
        Tue, 07 Aug 2018 11:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yp1gy4GCRF5OJCB9BA5EvvOLh4m9xYCHO20CU2Zet2E=;
        b=UU1AZq2WzZYRDFBRh7dbnSdH/RRpaM64DjYehF9sLtzhs9UNVZ2jqIfZp/ulcxqXSV
         00IGUcj7euzlk6Yn8oYx7XJk4agj7QEhIT5c2ugynGgCYBOEYf5bWZ/S1ZLkw6Q1J1Qk
         qULhB5OgMqmqkTj3GF3DnF0ZSE/OwFX0dWjLFcHN7lkzsGesVMv0Lb2OTLePEdf5OMbE
         mKVm4Vu5fxhP1Ril9VwgSAlZq02rjfuqx5Sn1zv28hTb43XXGkdsHJ7L/dnvZ+BAQ5pK
         uM4HEzCx9lmAC9IaZD8WKTcyjgKl6IvFNvPq3MkFjlP6FQFTmaI/kyHGY5vp9pSNaAm+
         8RYw==
X-Gm-Message-State: AOUpUlEEKyo61WtXgFc23pG5xRi1P6CEYjC8QnCgUGW4AChN1YeXvKvg
        mPUmjQdcgDgAPibbkXYKUg==
X-Google-Smtp-Source: AA+uWPx4aUFepNmWABlmjuxRajKsMl8r5JLIlYrRVzDhLnUFq33pIotpJrHac8ZUKh9A2uMA8rHdRQ==
X-Received: by 2002:a5e:c249:: with SMTP id w9-v6mr10732231iop.302.1533665456036;
        Tue, 07 Aug 2018 11:10:56 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id a14-v6sm549195ioh.70.2018.08.07.11.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:10:55 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:10:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] dt-bindings: Add Y Soft Corporation vendor prefix
Message-ID: <20180807181054.GA18919@rob-hp-laptop>
References: <1532693715-5234-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532693715-5234-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:15:15PM +0200, Michal Vokáč wrote:
> Y Soft is headquartered in the Czech Republic and it is a worldwide
> provider of enterprise office solutions for print management.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> I work towards upstreaming support for our custom i.MX6 based SBCs.
> Those boards are used in our various products. This vendor prefix will
> come handy later when the DTS files are ready for submission.
> 
> Thanks, Michal. 
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Rob
