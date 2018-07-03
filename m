Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC026C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7CA24791
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7CA24791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeGCVCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:02:43 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40325 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeGCVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:02:42 -0400
Received: by mail-yw0-f194.google.com with SMTP id p129-v6so1191065ywg.7;
        Tue, 03 Jul 2018 14:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+8rXZGIpX/10zuxWhU7tABwyqZaUaHvZ2kptj+UHXEQ=;
        b=N2RiOg7ht8+iTFa6RybBZspzOvk4e2LpRyS6Mn3RAN2F+RQ79ao/LiOw0MHSBy52CQ
         VCLkh2cP69X9mfLPd6UnN/ZIYaQtdbXOxoiTVvXw9TRC4zYklqhM5I+VwYRbJ/nZa43V
         zehKbOdz580i9b89CtR7xUtbHNiExa6h0AxlbIoisUCLpkuCYCZvc/7Zb5K2EnpD4KxU
         GEVaUTluwuKtc8K3aLHKkdrG9BEO24KkkMbYKWvFp4b1P0qizN6BHy0aaeS6okERIyi5
         8Sx+uzXU3dhF/mmJdpFMz+DZ3uVlp/yWBxRfr/mjO1lXzS5NUQA5rl5BSlpTqzbPdjPW
         6Y4A==
X-Gm-Message-State: APt69E3xs6T4KksxfmcZoT5+VF+RpFMi7mbJyoib56dWDML2uEKs2ulO
        nL1cErDXSUWwHYE1JJ3PPA==
X-Google-Smtp-Source: AAOMgpdTviDuUJMSeVGeMGZxzB+/spdVAjOEoJY4lHkQxsqaKjNuTda0zFT9oy7C8NaxBdNSYhLBSw==
X-Received: by 2002:a0d:d181:: with SMTP id t123-v6mr16196579ywd.227.1530651761442;
        Tue, 03 Jul 2018 14:02:41 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 204-v6sm361414yws.4.2018.07.03.14.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:02:40 -0700 (PDT)
Date:   Tue, 3 Jul 2018 15:02:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add DataImage, Inc. vendor prefix
Message-ID: <20180703210238.GA31190@rob-hp-laptop>
References: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 02:41:29PM +0200, Michal Vokáč wrote:
> DataImage is a Taiwan-based manufacturer of LCD panels.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>

