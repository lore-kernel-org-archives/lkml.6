Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E656C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B57622BC6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B57622BC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeGCTgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:36:04 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:43334 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeGCTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:36:02 -0400
Received: by mail-yb0-f193.google.com with SMTP id x10-v6so1177371ybl.10;
        Tue, 03 Jul 2018 12:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jnn10JDqz9gafp4lT5c223u4IrKBtyrkv37URo1Pu8I=;
        b=uCufi3gMixonKTrD68VaFfOzRSobNADB8MtRTTk/bN0Cb+eK4n2SO0Tp5jeCr0S7et
         9mBm9X2xfzRP1R7zKC3kGR2C1XY54+7o273BflQcpTrLScyl88Tdt5JFQCGQXXc0qzKR
         NBa+vTh35bFU5obOQz+Au7jevAWIrHbIqaZ3TgEaEvLlMLzD2W4zbTxodULNu30Iiwh7
         hlV3Ke8bm7aYDadD1hRYbpC3RtxuFsqhC4EPDnm1W0eT+E5hkCcB+tWHpd2rqOLMyLy7
         DRxutEwfaXqlICMN/9eMu5sSH5z3vOLAhnX5nt32+Pa1L1q6Uq1jtDQrVS6WxWgV9UW/
         3LAQ==
X-Gm-Message-State: APt69E3un/wY4Rz1MYhS/RvScYqfgF4RgfJjwml3/BA2XVh7NpO8aINc
        e7xGarhpwRMteKcAEE6djGKc+bU=
X-Google-Smtp-Source: ADUXVKIli0yfnMFR0vw33uTmj8Ofjc/4eMeC9PMWL68pdmsu85t8QISIOsOkDaEldQHq3ONDP6gAKQ==
X-Received: by 2002:a25:5f06:: with SMTP id t6-v6mr16518836ybb.326.1530646562213;
        Tue, 03 Jul 2018 12:36:02 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 200-v6sm677393ywo.54.2018.07.03.12.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:36:01 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:36:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 14/32] media: dt-bindings: media: qcom,camss: Fix
 whitespaces
Message-ID: <20180703193600.GA1692@rob-hp-laptop>
References: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
 <1529681621-9682-15-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529681621-9682-15-git-send-email-todor.tomov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 06:33:23PM +0300, Todor Tomov wrote:
> Use tabs.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,camss.txt       | 92 +++++++++++-----------
>  1 file changed, 46 insertions(+), 46 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
