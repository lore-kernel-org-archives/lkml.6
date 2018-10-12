Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535C1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2472A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2472A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeJLTI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:08:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32860 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbeJLTI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:08:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id q50so12093123otd.0;
        Fri, 12 Oct 2018 04:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbdjKPNfQ914C/TlCXlw5Tf83h/oZg5I4DVLcpULknI=;
        b=KMGwX/E89yOnY4oWWi5/bQyHw5L9uGB+T2ffThq4zRA+4cG6knSudq8YBc2kMinyva
         wmlavMekfZUIR5nfHTI7hnSBtc1i94km9lFt5CpZbSk1eemP4EUujAezctujMZ1XuDzS
         mDIf5xu6MktWnDUcDpTHF8YmwmZ9hGa6nN8xlBfXraT4y000QGh6vbHAiqwkSgOnmtXm
         d4ylcqiOPUFqn/LAUiNZEwycmKw4kXCHGei5KzR58XjpBf2tMcUhiknuqAFckuV5qB3y
         QSwzWNnkWpGq+sb5xww9pnl7X1guL2swHcNkzs7NWmhLknuxOcBRIoXpZL/eSpabzlwR
         mA8w==
X-Gm-Message-State: ABuFfog297j1hMKaHxzCCMj+20fB7ug1Vy5cya4sFovYMBRdqlGW0hyi
        H3D4uMc6e/DLoeFsUmPbTQ==
X-Google-Smtp-Source: ACcGV60MdI2FOv1tDrnEYA0g7aoeJWEI728anJFMcO4uzxBsrKGP0KMv1jyYzV8gyc7AEtO9BewhcA==
X-Received: by 2002:a9d:2be8:: with SMTP id u95mr3762969ota.106.1539344185606;
        Fri, 12 Oct 2018 04:36:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 14sm229797otk.49.2018.10.12.04.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:36:24 -0700 (PDT)
Date:   Fri, 12 Oct 2018 06:36:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: Add PNI to the vendor prefixes.
Message-ID: <20181012113624.GA22784@bogus>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-2-songqiang1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012073536.20339-2-songqiang1304521@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 15:35:34 +0800, Song Qiang wrote:
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
