Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AAEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5475B20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5475B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbeGKPgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:36:47 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39594 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeGKPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:36:46 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so49977607oib.6;
        Wed, 11 Jul 2018 08:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rjfJFR3VQzI/4Zx4zpwXoPmnQ8SGh2glGNhAKls2JJk=;
        b=mAamGk6gJ0uMC4R4ntdgxKyk5nt0YppvdjG23K1po7yfG0M9VUq2XRJnFZ1vTP7ELu
         HjpU5rbJloUPf2Pv+5RFxip4JFKDJsMeMcJXIOVuVR5PZW5wtgSyGvLuB7b/ZfBFsSgJ
         KURQq8zmqUGqscmYOc7ZGojFTZc4/xJbzVhTzkoqIouQiGbER/+PObpV8gxJk5t0ubwZ
         JWibNd3Hlf77EMCYS+dW9FQj3Pe9s1foqWWmOwmUyMEVlahKm7txRIbMeIco22pGUw0E
         H8JHmmyJb7k6id/dQrtT8lAPcdGvIOdoMLaREoCD0F7tvGM0uSDcxVPMrWkYucMdb1rs
         m0kA==
X-Gm-Message-State: APt69E3+fDHjdjU/qpGctZDkDQNG8yhI8yZ7HyHN5IqsdJiTko3sZ4p8
        4YDxXNE8uXTqWDRWasc2KQ==
X-Google-Smtp-Source: AAOMgpe+tIcq+Lwz/eQzp1TbXcYuJNv+4XdktsUB6fltbujYHtxRvfCVuT6RjBTXtoOQB384GBblpg==
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr34869056oie.233.1531323114465;
        Wed, 11 Jul 2018 08:31:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r188-v6sm7191164oie.28.2018.07.11.08.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:31:53 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:31:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] ASoC: dt-bindings: Update dt binding name for
 apq8096
Message-ID: <20180711153152.GA24360@rob-hp-laptop>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-5-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530870195-13576-5-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:13:14PM +0530, Rohit kumar wrote:
> Remove qcom prefix from machine driver dt bindings of
> apq8096 SoC.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,apq8096.txt | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
