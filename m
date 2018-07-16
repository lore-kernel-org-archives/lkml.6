Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE81ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE2F208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE2F208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeGPQDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:03:00 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33740 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeGPQDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:03:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id l10-v6so28902504oii.0;
        Mon, 16 Jul 2018 08:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6yoIkBORykDgEqAMOYbiszR5qFcQQcvPYSVmQ3sYU+w=;
        b=FVv4/ElLid1C1W7JYOkMrSQ1wTbIdyS+xDcTGMSaDNOA2y7tOHSZNKqGPo7eMk+47w
         9IMhKQs6XK9yjVZU4ZTGPnLoTpeEP03zZwcHUIHdyHyCR3WEdRzHrEk6FO1oPLNWQ6Gf
         xiOgNWC58JhTwDsSKXbrnKLfCJSrAhe8EFLzRyVqan+8oj42g0eovU4km39n0/hjVwjU
         31WX1LoBYyNGqMrt+swetDeQuQZo9uxqBcBEfaH8nspcqLqrMJDAdQ8oqEZmPKIQtIpw
         G1StgSo2xJPfHXFVaYB9MRwZ9wM96D0EqCZwdXb6q094Ie/FWHWLYCO9yCmu1eclncsH
         rN/A==
X-Gm-Message-State: AOUpUlGabUACV9GsxzHrSSezgHE5PA/PVsR2Ydd7N+qIvORJcadPydGI
        AwDBvKTM/U42fIUZNsbsOw==
X-Google-Smtp-Source: AAOMgpex08nJ1HRBqtP3LiH8sw5HfUwOh0okGklgf1VottNb2s0otxSfk8OJAxKk/3VziFcqFFzEcQ==
X-Received: by 2002:aca:e504:: with SMTP id c4-v6mr20076017oih.246.1531755302797;
        Mon, 16 Jul 2018 08:35:02 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id c14-v6sm19904066oic.13.2018.07.16.08.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:35:02 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:35:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Araneda <luaraneda@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] dt-bindings: xilinx: zynq: Add missing boards
Message-ID: <20180716153501.GA15770@rob-hp-laptop>
References: <20180712041024.20583-1-luaraneda@gmail.com>
 <20180712041024.20583-7-luaraneda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712041024.20583-7-luaraneda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:10:24AM -0400, Luis Araneda wrote:
> The bindings were missing when the device-tree
> files were added
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  .../devicetree/bindings/arm/xilinx.txt          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
