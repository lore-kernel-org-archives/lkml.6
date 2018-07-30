Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C454520870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C454520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbeGaAHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:07:47 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38874 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeGaAHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:07:46 -0400
Received: by mail-io0-f196.google.com with SMTP id v26-v6so11290489iog.5;
        Mon, 30 Jul 2018 15:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4OLCLqr0nvBZLay/R6Pxus0bJHBXz3oHOfYaMFVE4M=;
        b=ECTnCpgQImuhQ8RqvziXOrOMbdenqEt9ilFkD2whLjI702hDafNFIZISA1/RGTosNM
         /8c96UXATleqXPnn1GPTlvBMSZZ3P/GWOHJMqoxjqxo+KlJwKP3rDVyeC6YQ4sBoLh/N
         +m4S+Io5Orrwq4S7Hp59gsRO/gaHgi/oAs6j4A9WxV6AWoG4GCr28EV/Nu/hPMjiprkq
         nPG7TT23jV3xbmsTutkZjrW3aBq0SFFwkIC9srYOh7Vj2zshOBAacfFBE5o9OV9zBtlA
         HAYfiB3WnzCYNYstT9x3RLEzHf94Hybqy+TFywAoigbaRExxFbnEA+L1uL5Zz3EXlY1I
         3sTg==
X-Gm-Message-State: AOUpUlGGp8thukLxZz9fRwp3Efm8jFviX6NRJye3tQfUuZOKIsvAXDZD
        9uKB2VnuhCNy+GfH9Q/SVA==
X-Google-Smtp-Source: AAOMgpdh2JYy1fvviYNSGxjcmI6DyoBRkfZd4xCLscu9COtgb9tzhVmGqXkuvbR+f45Kj3IqIMVKyw==
X-Received: by 2002:a6b:4a09:: with SMTP id w9-v6mr15020120iob.125.1532989839620;
        Mon, 30 Jul 2018 15:30:39 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id j199-v6sm415898itb.43.2018.07.30.15.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 15:30:38 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:30:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        arnaud.pouliquen@st.com, andy.gross@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH V4 1/9] dt-bindings: soc: qcom: Add label for GLINK
 bindings
Message-ID: <20180730223037.GA17877@rob-hp-laptop>
References: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
 <1532693849-7037-2-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532693849-7037-2-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 05:47:21PM +0530, Arun Kumar Neelakantam wrote:
> From: Chris Lew <clew@codeaurora.org>
> 
> There are GLINK clients who open the same channel on multiple GLINK
> links. These clients need a way to distinguish which remoteproc they
> are communicating to. Add a label property to identify the edge this
> node represents.
> 
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
