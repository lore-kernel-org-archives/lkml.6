Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2104823C49
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2104823C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeGCWcv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:32:51 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35397 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGCWct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:32:49 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so1347867ybm.2;
        Tue, 03 Jul 2018 15:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4TXSPHqQCUuCjCe3pq0kmNvZ3VwpHh0Bf6eo1KziD7Y=;
        b=l7zVDCVLdd9ZQuNX9fBCx0ALmcQES1A0sDrkFSDd0T14K6O1iJ0WImSevE0iWkJPIe
         r0dVFxDfVM8W+MGVgvGHPgdQpG4AfiEIv9NpaO7oHgN1iE/+3zeYMsgfSQ3NqzfNmYUy
         QKVWh8/Qs37o4L/gyc+Kkw80qb3NuWTRKw+gix4E0cD0BqKNUDnWIVVFoLXyD5lfD910
         t6DPx5NlGM9GCXpaCg8Iw3dfBdvVLE/rKfGzFchX2RKzj3U6qkie+RYHQe0eSQEMlPxz
         LEvabNKTzbFBeIr4Ni+ibmqhYIR/ZPQc+O8qlc8BKR/EkVo6pKjca3yQs7jP9ZfCN5LU
         JjtA==
X-Gm-Message-State: APt69E0GF3lJtdmwswI262wl3+cvNbpUiIrrDiASfDUgwKOdIdLXYBzj
        28yEXvE6wroPa5uKLEbdZYyhisMV0A==
X-Google-Smtp-Source: ADUXVKKfQ1FsBaSsAzus0tocSiqNMKd+aU5Uj9RDvnPSihh//hj99+L8Mu/Piehg1pYQ4BcvVJ+0Ww==
X-Received: by 2002:a25:6c8a:: with SMTP id h132-v6mr16950954ybc.437.1530657169181;
        Tue, 03 Jul 2018 15:32:49 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id s125-v6sm943703yws.49.2018.07.03.15.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:32:48 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:32:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     srinivas.kandagatla@linaro.org, mark.rutland@arm.com,
        Linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: nvmem: imx-ocotp: add compatible string
 for imx6sll
Message-ID: <20180703223247.GA31692@rob-hp-laptop>
References: <1530070130-3004-1-git-send-email-Anson.Huang@nxp.com>
 <1530070130-3004-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530070130-3004-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:28:50AM +0800, Anson Huang wrote:
> Add new compatible string for i.MX6SLL SOC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

