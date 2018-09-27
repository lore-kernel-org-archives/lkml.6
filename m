Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C077C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5236021708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5236021708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeI1AnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:43:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35706 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1AnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:43:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id m11-v6so3055622oic.2;
        Thu, 27 Sep 2018 11:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uFZO9q7h7TNjl4uHXJIxwUERVkqQ03UJsqmLPvOF3dk=;
        b=EWSwKhCLBLY5FIqbdXKR0USA4+9zdsPt15GxDah0+JA+GCJLAwhxLxKbNvOUGAEgr9
         K6tnryuKt5zORKItlr+b1K2x+87skA6NJJ0IuIQLt29eQX6kUXkTtkMqbFLJR8OjcaUs
         TH1UpNwioferB8iaaAuWFrb27qqLvbvmPqWKUnNvXmCNHhkmMNlWEq5gtjWPfVgM3yea
         y5BDQo+i3oxFGe6eoXhLukO2Ld0HSAzdzE02ogyu6Dz70RBmgRihsGSFIfO6mfCGZ3i0
         EuHi1m/OFN52HelvnwXCZe9R4XFknheOHxfll0hvcPbknoxkcP3UdMYivqJ36yqdwDnn
         fUHA==
X-Gm-Message-State: ABuFfogwQldoQewtsTvJ/SCjrOC3xGFZ7Sf+726vute91D3xJsZOUJ4o
        ZMkgn4vF6mev7ZKWXx5YfQ==
X-Google-Smtp-Source: ACcGV63UmX3S57XWCZkrNVMJ5EiAocxsu/tOgK2u4xYo8Q6hlacarfB2CFmLohV3aNab1nAhHsBDXA==
X-Received: by 2002:aca:dec6:: with SMTP id v189-v6mr3924487oig.98.1538072619804;
        Thu, 27 Sep 2018 11:23:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o75-v6sm1160251ota.27.2018.09.27.11.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:23:39 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:23:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 7/7] [media] ad5820: DT new compatible devices
Message-ID: <20180927182338.GA1094@bogus>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
 <20180920204751.29117-7-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920204751.29117-7-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 22:47:51 +0200, Ricardo Ribalda Delgado wrote:
> Document new compatible devices.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
