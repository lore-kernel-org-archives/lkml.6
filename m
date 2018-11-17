Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4104C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7953620815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7953620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeKRCiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:38:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43573 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:38:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so3906585oie.10;
        Sat, 17 Nov 2018 08:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=unIG7LAFZfAWs/yvhmFUgBHX7b9UqQIMBueuCQuMrxA=;
        b=hlvvf8V9JDZNWv5xktuRZEvUpkXnSUMYwSxUCDcu5DOHwvpb5bQxrVY/LzjW+01dAO
         geOziZI6V9O2Hv8LSIlNYgNapZaPwXRd6wkCzMLWR9cPoa3pXARzJwW3X/QJKqu2lafn
         pBcwv7InO0tEo6PMqc/g3ijl9abErRjMtQj8ecJHZLmosk8tGpNDjseERhAJ3qPIavoQ
         0KhJyFqh4bce/rOWbnbCktJ8L7X369OHgXZuNNeNzXZasPnR2V6SkKnZ76x2fVFdGW7a
         aTFRPuM3keBY00bkcUIdQyYm0jtznQrVpbKHCVHvSmPwRwLpdpKk/FVi+lC9uWmgOBNg
         N2qw==
X-Gm-Message-State: AGRZ1gJmpILFWCzqbqILm9WeN37VZYiQkF8PgAquXFFc4gJtSho7DrwQ
        0/S1ZVEHgfRe9CMWgOb746N8JHo=
X-Google-Smtp-Source: AJdET5fuh59cauhT5Sn0svuE5qgLYTS8absvy8v87TSrm9yRuBFG0RMJA8/m0sz4ydUyF0LnVBSMwA==
X-Received: by 2002:aca:db05:: with SMTP id s5-v6mr3635694oig.173.1542471696136;
        Sat, 17 Nov 2018 08:21:36 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id i35sm1236403ote.69.2018.11.17.08.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:21:35 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:21:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] Documentation: bindings: Add missing Amlogic SCPI
 sensor bindings
Message-ID: <20181117162133.GA25151@bogus>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
 <20181108135352.8459-4-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108135352.8459-4-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 14:53:51 +0100, Jerome Brunet wrote:
> amlogic,meson-gxbb-scpi-sensors is both the driver and DT but is not
> documented. Just add it to amlogic's scpi documentation
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic,scpi.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
