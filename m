Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5889BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1629A21755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1629A21755
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbeHNBrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:47:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50579 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:47:41 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so15708834ite.0;
        Mon, 13 Aug 2018 16:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqeN31P0nsTaastM7DsU06aW+N0/MmjIj5sDDU225d8=;
        b=c20aqZDzj4JLJIizCQuGhTqtaisF8nSe3LFjU6UR67BJDMw50sI+5yG1MwYQOSKtTk
         ZEDvZcZmTwEhcu2ZLGHniSqyxfUWqKxammXaG9RQ5okYFTM6h/1JmKVfg+iiEvRPVsw7
         TMk947Wdum/FDDSxaIQTfH4relN0DRTe9Tp8Sl+Qd4uW7vnn6F+hf7s9DvKG/PMtoSf7
         w5Yg2tqcluIEx0/Br2+DOHJOCuwJ41jsuzU/qW/Krucs+YKp2BGaKzkT/rAZ70LrzPB3
         eaDAWN3viMpAwUuIe35yFIaVDB6OWI1gvYnepx2catq9YeyBODxq0sgHFBL7Vg8Surps
         jrVQ==
X-Gm-Message-State: AOUpUlEckqAzTKT93d70VtOLRXQgbbsx5YXaRfc7EeYkFI21meRKwYrv
        5T8oPxynRlgUOqrqOPztBQ==
X-Google-Smtp-Source: AA+uWPw+sTq2qgNQlqyc7iPNrXIJ7BV4iDNzHLJGGC/6XOAT+vR2zPXwHlvWLptZ4clCA63hZxOa+A==
X-Received: by 2002:a02:986d:: with SMTP id x42-v6mr17282846jaj.131.1534201400302;
        Mon, 13 Aug 2018 16:03:20 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id a6-v6sm7446624ioq.73.2018.08.13.16.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 16:03:19 -0700 (PDT)
Date:   Mon, 13 Aug 2018 17:03:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: Add CDTech S070WV95-CT16 panel bindings
Message-ID: <20180813230318.GA31242@rob-hp-laptop>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
 <20180730231117.5631-4-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730231117.5631-4-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:11:15AM +0200, Giulio Benetti wrote:
> Add documentation for S070WV95-CT16 panel
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../bindings/display/panel/cdtech,s070wv95-ct16.txt  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt

Reviewed-by: Rob Herring <robh@kernel.org>
