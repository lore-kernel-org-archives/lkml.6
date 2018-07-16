Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC6AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09206208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09206208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeGPQXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:23:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46281 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeGPQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:23:43 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so75722804oie.13;
        Mon, 16 Jul 2018 08:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D6nZrNDbjZwh0VQMGH0GekgO5CGaxwS6RoTwcy80KAs=;
        b=fLzLRKB44VmuVF6H93/cxeVdbjeV2sV9iFVGssVraJOfqteytcrpgvManrCfgj+qop
         sAEJVZf8JnYmCz8/HA2PuxwzPyoNKu36YeURelcH1syIHDuiz2NzzbWlaWnuDqYbHemx
         ZT2p5aWhKufa/zJ3Y1R/8Ieqbw11dlWdNedyIa7AHgJw2DUBDAeKm8hfPpBVVnjfILUe
         nXJHzoNyzuKIOZwpONMD8Zq6FJMtQk5+7C1sLQWQivBwHFJlqVPu+z+RduiRyTFhEBFl
         ZEab5aRdx64hVQmeKuCj7Mr6jLKdvK75C9WjoR3tx89mLtXeThKvXoKsC/ddu8tGBXTE
         Z9SA==
X-Gm-Message-State: AOUpUlG0j/qvmOQ2b3IV4fywQpRRV02ICHF/9weqXkGVxm6gtx/blXid
        KSMZ2hlU0sMSJE8fivNG0g==
X-Google-Smtp-Source: AAOMgpeq1A10acSUQ5KPEShUaRtePI1eRwo5OXqGJgm2QF5DLQJBmm4RdSLuctrcisKhD5kIu0MZmQ==
X-Received: by 2002:aca:d986:: with SMTP id q128-v6mr17637213oig.349.1531756541407;
        Mon, 16 Jul 2018 08:55:41 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id o10-v6sm22214095oif.42.2018.07.16.08.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:55:40 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:55:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, tj@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io
Subject: Re: [PATCH v3 5/9] dt-bindings: ata: ahci-platform: fix indentation
 of target-supply
Message-ID: <20180716155539.GA5354@rob-hp-laptop>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-6-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531479786-4911-6-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:03:02AM +0000, Corentin Labbe wrote:
> This patch fix the indentation of target-supply's ':'.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This one should come before the others. Fixes/restructuring before 
features.

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index a5281d7557e3..47652521a6ed 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -50,7 +50,7 @@ Sub-nodes required properties:
>  - reg		    : the port number
>  And at least one of the following properties:
>  - phys		    : reference to the SATA PHY node
> -- target-supply    : regulator for SATA target power
> +- target-supply     : regulator for SATA target power
>  
>  Examples:
>          sata@ffe08000 {
> -- 
> 2.16.4
> 
