Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB637C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C6D21905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545337552;
	bh=h+3oDrJOBB/WcdDe2RZEcg+wxZveu7eOnxP5rBgW/xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hXBwQW24kL/Qvpq6OcKLXBPGFO4+eUU/OdVumMB/NtLJfVde2jn6mX+biHVpUfzhZ
	 I8FjjpUcH+HqvU0iYnxgjGZiH+wZdCrJPIJy/3wEAlDc8TnkhjPC5NeaolpmNwoxwy
	 o1BfR6joeWadYGtqlxOMcTmOGubbSBZxdmur2Mcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbeLTUZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:25:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34432 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388492AbeLTUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:25:46 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so14008371itd.1;
        Thu, 20 Dec 2018 12:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjX9t4T1lJAbQ0hk4NPBFWPEgP6nltraSD8TxqpkGQY=;
        b=qaJ+Ff2s68DPwRqaeafbLthrQhT6dOD3pQomc/OgIg79NPZXRhl53kHVmO1yEnsaux
         J6GoXfKl8E6pOoHKVkFtwxlD9QKv6XJY48du+T6nglkVBjLitZlYiWq4QzHN1xNw60Ds
         M+1CPxAmt2bmooNolnufwTL7TBmceCkQ9H0DFCjMW7jbj61+9iRsm0q4Wt/bzoPu+OcH
         aEHFtckP31JDoRwEjDV2ivQwx/60/npy4AyR6Sk/+L4ZXhMzbYZTl1hqkC+WlQ0M/ujy
         DR2Bp7mnBUNsdVXFzczzRXLBa2NPH353wFA6s1nB8nDlA79uP4t3cvnLkvGVr8l4Y5aV
         2wcQ==
X-Gm-Message-State: AA+aEWa3bFwzeJ9IGhMGOKPw46eA+57uul65za721H4ykWVXzeAWqARV
        d0T+SsM3vlfjE/x4G3TWCA==
X-Google-Smtp-Source: ALg8bN4bjRBkIevWSskJvYEcq417q8QfhzI9PWAnhZ0C31g0vSk+LJG1fRiyFar77zEPw7PUnbfcMw==
X-Received: by 2002:a24:2208:: with SMTP id o8mr99945ito.23.1545337545116;
        Thu, 20 Dec 2018 12:25:45 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id b25sm5272327itd.37.2018.12.20.12.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:25:44 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:25:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dianlong Li <long17.cool@163.com>
Cc:     robh@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dianlong Li <long17.cool@163.com>
Subject: Re: [PATCH 1/3] dt-bindings: define vendor prefix for whwave, Inc.
Message-ID: <20181220202542.GA2826@bogus>
References: <1544696030-17159-1-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544696030-17159-1-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 18:13:48 +0800, Dianlong Li wrote:
> Introduce vendor prefix for whwave, Inc.
> for SD3078 rtc device.
> 
> Signed-off-by: Dianlong Li <long17.cool@163.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
