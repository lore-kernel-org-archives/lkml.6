Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9ABC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDA120700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDA120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbeKFErm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:47:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37356 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKFErm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:47:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so8893886oth.4;
        Mon, 05 Nov 2018 11:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9UroB1xaGcllidP95o9VeAeXtUGFDqp9XDIsbvSMM8c=;
        b=eXxezTfkJ94Uase7RjyxWhGRt4eYbMOFClpGRiMQKomibzoNsCTydfmcNuhEcRZQtk
         yy1q02SpSjbfrdDNuV523mw/i09sX/wopRu8mWf2hGkzzLWfarStAaAD0uF8jrptGsB6
         1k+8khPbVsOSOPBlVzCrrnKO5a/qU93KcDoKuZtglhRXAhW8VhoPB+WB7V4hU7+T/Kda
         rlrNeRR6qgdG1SnX2bfs62ktquaHb9Sfgf61DaRbBg6U2PHIv+AfxaF69dbzvzJSHBD0
         9eLNuCLit5hLoKDiCnc4xFtT9oIHRfwmyfYXkML96CRon8I1Qn2jug9kdyUh9LSqYH5I
         HIYA==
X-Gm-Message-State: AGRZ1gIx5RwJYcVOwzzqcby8l6qzOf7WvP8g8bHJQoUB6GwpwxPy3r89
        ZeX1uoyHBsewbEwHCkOPWA==
X-Google-Smtp-Source: AJdET5damTzvCOsaeCdUX0zgJa7/jgU/uwsxTIPPuj780fZMevPvNVeLZ7iSz8nb+QF5PkR4g7XrJA==
X-Received: by 2002:a9d:1c97:: with SMTP id l23mr13061636ota.276.1541445991732;
        Mon, 05 Nov 2018 11:26:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l6-v6sm8043247oia.46.2018.11.05.11.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:26:31 -0800 (PST)
Date:   Mon, 5 Nov 2018 13:26:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: Add PNI to the vendor prefixes.
Message-ID: <20181105192630.GA8881@bogus>
References: <20181102074209.12620-1-songqiang1304521@gmail.com>
 <20181102074209.12620-2-songqiang1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102074209.12620-2-songqiang1304521@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Nov 2018 15:42:07 +0800, Song Qiang wrote:
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
