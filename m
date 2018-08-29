Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE2DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C162087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C162087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeH2E3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:29:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41954 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2E3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:29:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so6156691oiw.8;
        Tue, 28 Aug 2018 17:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhg2WP21YLuuHIPxt6T0/Oj5Xhtn0nKeAI8W3esco6A=;
        b=F7ntJ5M3X8mK2U5/9wnoc81hYBryaL5AiC8/3f7+f+Dq7zLHtrUXjWQ1nlX39MrFEY
         +0HdfX/YXs1Nj1/mTyJjU0Dr3w+0ZG8nd1IGX3DR6kZzstb1g2TInYFDkIzV+vs/vZlj
         S1/yhXSU/10geEZMOO7/ubPnqnbbT5hQq8jQfN7DtKrOcHTQACmAR0c+ZME23dCR0IuY
         V8wrZiQze2K0pP62jjpiBDENVPrcsNBUNOJpfOZsp5ZfkV58G5DdXwQqw++oq0SIaaQE
         3aTRDrecCtsq0R0R0CT/vVES/1aaH5Viu+pvwgAiapGMHF5qOqiQxX5uYy6HYeStG/FM
         9Qxg==
X-Gm-Message-State: APzg51D51/EU2Rf8O8QrWRK7tAFSrsIY+xWAHvRHh4CokGp3cOvTbiYG
        ZZU9yJjOKAU9bjwgYLmnEQ==
X-Google-Smtp-Source: ANB0Vdbv9SrGbj1vdcYCucd/lVRIZzMXTWh18u4oHbexhdE9++N3KtnFEAsWWP4azrI+6Pbgjhhw1Q==
X-Received: by 2002:aca:f0d4:: with SMTP id o203-v6mr453627oih.21.1535502912034;
        Tue, 28 Aug 2018 17:35:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n84-v6sm1352005oif.23.2018.08.28.17.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:35:11 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:35:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        stefan.wahren@i2se.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/2] dt-bindings: arm: add missing compatible for i.MX
 boards
Message-ID: <20180829003510.GA22335@bogus>
References: <1535013674-21356-1-git-send-email-Anson.Huang@nxp.com>
 <1535013674-21356-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535013674-21356-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 16:41:14 +0800, Anson Huang wrote:
> This patch adds missing compatible for i.MX boards.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
