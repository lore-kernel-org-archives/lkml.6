Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB98B24526
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB98B24526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbeGCXA4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:00:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46916 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGCXAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:00:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so1679776pfl.13;
        Tue, 03 Jul 2018 16:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GpSSOQzO+UYDO89GsxJjH5b1BKMboJlYZeApqmU7e1I=;
        b=tdyZnn1Z8uY2slmeaH+5MEGZTSMKHVDjNbBXpkl9gx3Ce0ik9DxzzCWV5c3rOpPmrn
         G5+aNMRHbmjkl2TmRNJJmoe/Fqs5r1VaYP+DtsUmv0uAd5ECk3LQbNEpIcW22/GZ/toz
         uRRHJY9B5Mwsa+UsBt+6E39HlFcoJTGt7q+kiCXak+CGJaH+wYRkNW9Ejybkm1SAIEam
         GI6i5CjnEnDM6tutPfC34vjJNladGbCHd5WYtL1qNH1JRMSX9Mo/ysJpX/UfHun5u3Dr
         vpNnltY8kFnwU+51mRqW+hdtAWov9ItgK7n7/Dgr7hbQNvMedt340isDX4wEnUuKaWmd
         OMUA==
X-Gm-Message-State: APt69E0b/uaeqGc+X8eIerlaKHLQWXU+U3zrJU0xEfCgjgkujvjd1Wb+
        lAzHjYObKg+Yto5CwS26Tgwvg29RJA==
X-Google-Smtp-Source: AAOMgpeDbW7JD0ig+Er1mTi9hSEI2H9LzC5YlIDaYDX5drHscq6Cy0x3fegGZeuxgzs+09XPHhYg5g==
X-Received: by 2002:a63:c312:: with SMTP id c18-v6mr23667029pgd.449.1530658853864;
        Tue, 03 Jul 2018 16:00:53 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l67-v6sm4678472pfl.89.2018.07.03.16.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:00:52 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:00:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v2 07/10] dt-bindings: samsung: Document bindings for
 SGH-T959P board
Message-ID: <20180703230050.GA20272@rob-hp-laptop>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530119544-30023-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530119544-30023-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 07:12:21PM +0200, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document the binding for Samsung Galaxy S Fascinate 4G (SGH-T959P).
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> --
> 
> Changes from v1:
>   - Added missing commit msg.
> --
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
