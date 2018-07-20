Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376D5204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376D5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbeGTQAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:00:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43820 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732907AbeGTQAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:00:50 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so10201099ioa.10;
        Fri, 20 Jul 2018 08:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lx2g8ZaTaxYudurS0Up9JdpHC3FWF3gES3yb2N/8srE=;
        b=Th5vonWAwixBPb6fkYcq4iZzscIt3AZ7hRn4CHjbjCXMBWqexFSYYZazBzpDFbZ+l7
         ily0t8zvOioN25Ut+Qh5IliCjhNUoCZDX3lY4tMAPID15Ql1wGVv4xMTV3ACxnEmhHoa
         2HAASwfoB/12ORQ0wFOW3ys2F5F6ndkBCvfTy2SiWvY1NC4iElkvl2hQR7hAukSDg9Da
         IWIHnDCQ36AwpMmPpHns7V5UCfMLH2WdXfG7YUVJTiSRpb9kZZM5wYDLAlWTfNi/OhfV
         i2AEyc+seQCzbp3HZH06pTyMIPu/0GVCuOwEus/j8gnsPpagtNq/JEcPA5hXDcnCRlc2
         T6wQ==
X-Gm-Message-State: AOUpUlF0o5dHOhBjrWhY2S+SpunKTk2jdjdnEdidFhk00esCJ3HiPAkH
        4AZLBRmihyFMLFMOeATfsw==
X-Google-Smtp-Source: AAOMgpf36YK0lpwzrc2wSdgrLnrxC4zi/pKjuICxvab3jN/LIhTXYkxxDiBwGu9BFL/1zvs6nlxWWw==
X-Received: by 2002:a6b:fd01:: with SMTP id c1-v6mr1950901ioi.6.1532099526578;
        Fri, 20 Jul 2018 08:12:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1047088itc.22.2018.07.20.08.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:12:05 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:12:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: move berlin binding documentation
 to syna.txt
Message-ID: <20180720151205.GA25135@rob-hp-laptop>
References: <20180713171712.05f58a74@xhacker.debian>
 <20180713171859.6c4e5a35@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713171859.6c4e5a35@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 05:18:59PM +0800, Jisheng Zhang wrote:
> Move berlin binding documentation as part of transition from Marvell
> berlin to Synaptics SoC.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../bindings/arm/{marvell/marvell,berlin.txt => syna.txt}         | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (100%)

Acked-by: Rob Herring <robh@kernel.org>
