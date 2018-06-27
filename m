Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053DAC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B113625B4D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B113625B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966186AbeF0RVr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:21:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41596 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965022AbeF0RVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:21:44 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so1359593ply.8;
        Wed, 27 Jun 2018 10:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T0V2m34btyA98qBBGSgC8qcn2lTBTolGF9Zyrqf3oBc=;
        b=IDSe8acxo93rm1spgTHTMDo4+0QUykL0fRUPRxMFJJf/2Yn2MjiHjt1XZleKz8C9Ni
         VTvz2kJd10QwNLloiNUX5TYcFKlLOpNsQKDCm6cM0tFG1W2BNpL7W62kjH+ynIpODNuv
         i/rDag+ti3WJnAOkjt1E8OK7jSMDV0hdQ1hyjgcwxN4MbQ0X8uA9QB6tv9+aStYUy/u8
         Mftj7G6CasGyBhpEwBcH/xCiFHTPqUgJouwYHw6y/aZvcxApVE6XOT3ekfz5RgZDl0WV
         kzHroVIo1xYZNY99acacuFyFTWg12Y9iShK5+QCfGTSphBA1NlQ5p2/zog1pmFnkBrLm
         ZE6g==
X-Gm-Message-State: APt69E0XrI+s7jlC2KNl4OpDcndNTFhpD8vJKdb8SqhFFY/Od6Fz/3VB
        Jr8k1XdHAORAFysL1YWetg==
X-Google-Smtp-Source: ADUXVKL3psbVJQeGL+ioV7nkr1ijyOdq3c1QyStopcPxCX3Wy8L6tFAIAZjsmB70ooyg9J61RPhKog==
X-Received: by 2002:a17:902:301:: with SMTP id 1-v6mr6987140pld.127.1530120103955;
        Wed, 27 Jun 2018 10:21:43 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id y22-v6sm14832530pfi.166.2018.06.27.10.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 10:21:43 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:21:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH 5/7] dt-bindings: samsung: Document bindings for Samsung
 aries boards
Message-ID: <20180627172142.GA14919@rob-hp-laptop>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529608199-5583-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:09:57PM +0200, Paweł Chmiel wrote:
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

