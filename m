Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD8CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5029820661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5029820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeHaQYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:24:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40396 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeHaQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:24:55 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so14230631qtj.7;
        Fri, 31 Aug 2018 05:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EyXLS/Rpsh0mUd6C45rCziFH3sSp6YahcQ3CFWv7i68=;
        b=oDYqywqKh+2tUbNp/TRg10QHDoZf+jO3UlucOWW/v2K3gexPSW2H4SCyGsiAmxKXE2
         qc1uDTyjaxG+1CqQw1BW0OSPFTfO+v+R0wG3+1EkV6SrTwdKS7+z5EdEliUMAUszoBq5
         rWGjgCOgdiokx+j9x4pHL3kJeQHJ5SMjvte+ypYvQTcVLVktj4HKS+WaKOFPVfUR4wyE
         1/qc8R0F1lecc36h9V4p08umhwhwB0MUqv1tDigMHpJdB2q5CEBtGExOCEDx12/8OYgR
         TCV9Z9wz96Hc0x8pqlG1/Qgiyu09iOTk8UTerBVNzfUP7uAYMMh5dArHyQt1EZxua91H
         LIGA==
X-Gm-Message-State: APzg51B63iD5bW7WnwNvxu/vzy7eBeZNhE1ZjeW9PgRTvEl5+bSDKMXT
        ql2RW6YRvRJoogw18kZ/+g==
X-Google-Smtp-Source: ANB0VdbyoXM3YK4TMLXvwROqmId/e+as3P9PJQntwryW7dvB9Z0H8QN0lYYQM5q8FjRPi3WRmm2vcg==
X-Received: by 2002:a0c:e083:: with SMTP id l3-v6mr15262671qvk.1.1535717861941;
        Fri, 31 Aug 2018 05:17:41 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id v72-v6sm5648467qkb.84.2018.08.31.05.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:17:41 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:17:40 -0400
From:   Rob Herring <robh@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH 2/3] dt-bindings: usb: fusb302: Use usb-connector
 bindings for  configuration
Message-ID: <20180831121740.GA21868@bogus>
References: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
 <6472fd66d20df31165f9645eb49f4f30a0a51468.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6472fd66d20df31165f9645eb49f4f30a0a51468.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 13:28:22 +0100, Adam Thomson wrote:
> There are now generic usb-connector bindings which can be used
> to define a port controllers configuration for USB-PD, so device
> specific bindings are no longer necessary.
> 
> This update deprecates 'fcs,operating-sink-microwatt', and references
> the 'usb-connector' bindings instead to achieve the required port
> config.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  .../devicetree/bindings/usb/fcs,fusb302.txt        | 32 +++++++++++++++++-----
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
