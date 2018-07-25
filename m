Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B75C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D520893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1D520893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbeGYROB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:14:01 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41827 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGYROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:14:00 -0400
Received: by mail-io0-f196.google.com with SMTP id q9-v6so6758384ioj.8;
        Wed, 25 Jul 2018 09:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CVccyxm3ufCLihqPKFdWmoVniE869YuOdL2Yw2dTdS8=;
        b=oc/hWJqYcVNUXrc8omuCmZtGlrgGi9JIS3S4rD6A2x5oBWTaF2KQIe720dtF/K0kc6
         DqWyUl2RqPZGT/J9cuvzH3ENkQAp8V+tFgFh+FvQSh0kjFBAfKvoAixmVsYy1nhZyjZY
         LekGfGNwO9isZzP854axovBmHlpu1qHxaJfqmlKLdT8Pa0dqOXxfSD3o9/NDS27YHIcD
         YXqudLAxjrcfLFqLVmyY9n/Ud+lyD67g/QB1LfIHZHbAHo7KhMLUr6sEwYgxQqg8PQao
         zvMMaEoalQmUUfo1FZvBH1uvAWDbZMQkDnWzGBOeDy0LdZW6+uv7LBYOs67tf+BHxUCR
         DtZg==
X-Gm-Message-State: AOUpUlE8cRQxSS8b89ATgfsDUw67HXf2wFMa+46EzMJQegPxGm/PCDg4
        FWBGGH18qKvzTP9XoNSTCQ==
X-Google-Smtp-Source: AAOMgpexdWmLUh/syoXh9gzOPkTP8wrYlkO4v0USQVKnVBQgzp2IrSr5tEt1gV2Vx/DN2e5WubXBrw==
X-Received: by 2002:a6b:1bd5:: with SMTP id b204-v6mr18069917iob.240.1532534501772;
        Wed, 25 Jul 2018 09:01:41 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 200-v6sm2859013itk.12.2018.07.25.09.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 09:01:41 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:01:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     jic23@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 4/7] dt-bindings: trivial: remove tsl2772
Message-ID: <20180725160140.GA19051@rob-hp-laptop>
References: <20180717084158.23532-1-masneyb@onstation.org>
 <20180717084158.23532-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717084158.23532-5-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:41:55AM -0400, Brian Masney wrote:
> Remove the tsl2772 driver from trivial-devices.txt. A separate
> patch added the binding information to the file
> Documentation/devicetree/bindings/iio/light/tsl2772.txt.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
