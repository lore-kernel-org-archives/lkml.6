Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83B0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B68620827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B68620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbeKFH3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:29:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34882 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:29:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id v198-v6so8992027oif.2;
        Mon, 05 Nov 2018 14:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RAhX0eg35cuYU8QoN5ztKhGO+dYMMXQjLvDHbMjcd3Y=;
        b=XGUpAJtbfJF797OFeAG3ZFAdhmx0RqK6NNJT9hLAsCvsbZc32X4Ee52aHctujl2ecp
         XBMx87LiBucxtxprLA43mmLcogst8jKdTGWY9O4C9znRBg8fVT6ACr5WdUUfpQ47GJrv
         K39poAlqclNII16U55Tts2P/nqilKKmHRZd2NTey8oecQ0GaDN+VIt0gs7HiFt7FStxL
         qBGViJorqddsqjYWG2t5k6aSbePZKL88veKx14qWAGsr5t6Vzl+9hmPfN1mOHh43bDMX
         ygseUQpkY2J3A8a0tM6RoyHNv/Gg5hgANTXYtAc16yySRoHH6VSZTyhxzvdLhYNkU3Dg
         4aaA==
X-Gm-Message-State: AGRZ1gI7kdtVbJKcBpDPRn/qaJOlMqfrzx4mf7lAcG/4ynGPB0/9Zg5W
        o2zKSqMMIqrzYHtWMZMg6w==
X-Google-Smtp-Source: AJdET5eWSBeIyXhSRQ8VnreoI7hhpv3NC5yxenq2LMEvg/2l8xbn21Q1Y024aUf3VmdAwBieIt5Q7g==
X-Received: by 2002:aca:1a08:: with SMTP id a8-v6mr3854624oia.110.1541455684013;
        Mon, 05 Nov 2018 14:08:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p126-v6sm783635oia.0.2018.11.05.14.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:08:03 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:08:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 3/7] dt-bindings: Add vendor prefix for LeMaker
Message-ID: <20181105220802.GA21348@bogus>
References: <20181101200045.6078-1-contact@paulk.fr>
 <20181101200045.6078-4-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101200045.6078-4-contact@paulk.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 09:00:41PM +0100, Paul Kocialkowski wrote:
> This introduces a new device-tree binding vendor prefix for Shenzhen
> LeMaker Technology Co., Ltd.

Would be nice to say this is already in use, but wasn't documented.

> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

In any case,

Reviewed-by: Rob Hering <robh@kernel.org>
