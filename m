Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C77C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFE722393
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFE722393
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeHJABU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:01:20 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45845 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeHJABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:01:20 -0400
Received: by mail-io0-f193.google.com with SMTP id k16-v6so5971484iom.12;
        Thu, 09 Aug 2018 14:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QLzAXiGpFjfJXTr9EEd13hdk3DSA2shlwg/DNTFK2q4=;
        b=ulR9Py4NLnrpFvv4BSz2TTYjUPVqqsbLIjjbEjx8kqLMp7MXBs6cvlq8EIZJeFQq/p
         DbI6Y8lhHRNZQVBTkhiLu4q1Wb29QeG1vUcWzCYvid0Q/LujtOWM/N8yLwdKzyJ0Allk
         mUlsh6oQR4udLLzY4G2wX1Z7/84WxoZB1Fp8sI87Qkf/znpK8BzJKQ+Uu1wqUkBf6LWW
         /yHFLw9qxFkFf+pX9RPbuVIFSjM1veTzoTGR//1axkOpf8JLQxMuafCsBxQ+SZlJzQoH
         FDt1W2VFMoA6fVMgA+HPvcKDnlvjN7jNSUR+GcJNma4zi9NOONQm8xaUY9KNSyjDWZ4E
         HltQ==
X-Gm-Message-State: AOUpUlFnrCvkChc924ORu5xR/K5uNTq+DiGVAIgD4VsDUgcHb0dhE1bc
        DVGOfiRzhI4cXDZJFzKRAA==
X-Google-Smtp-Source: AA+uWPwe1oCLmiSJLMdhpOhgM7YjC/EtcuxUPXcMpwHwCp5YaocXnESpWvpGszo35JSTXiSuq8d6Aw==
X-Received: by 2002:a6b:bd06:: with SMTP id n6-v6mr3151201iof.86.1533850476836;
        Thu, 09 Aug 2018 14:34:36 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v3-v6sm385559ita.6.2018.08.09.14.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:34:36 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:34:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, broonie@kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Message-ID: <20180809213435.GA20267@rob-hp-laptop>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
 <1533653540-24796-3-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533653540-24796-3-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 05:52:16PM +0300, Stefan Popa wrote:
> Add the device tree binding documentation for the ADXL372 3-axis digital
> accelerometer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adxl372.txt      | 22 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

Please add acks/reviewed-by's when posting new versions.
