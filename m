Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE06C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446AA223C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446AA223C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbeGGItt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:49:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46504 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeGGItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:49:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id r17-v6so10262337edo.13;
        Sat, 07 Jul 2018 01:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bmIzJUm6tv9bBzUerV6gfuBdKbyeLvNr90wJK/Qxm7k=;
        b=ESm7+HMkac45jdxFikHjQJYXaqjoxArlSlsCiSpkFRYr3xSBem6dD8tL3h3I9Dzyqk
         62CUkC+6Jtdz9oPfbRhj88Q6xpHZQ7UCQK2VufF8FWUnhY4DMfkw/hyrE/3Ot10ks3j3
         QRyzafYBo0RWrOZmnMyrimCE1Gi/rVB0uFO0+RM3uBukdj7RQ6Zur1nLAAp4x5TGWoRg
         NNtYu9gueru/Wp09sdBy1Mx3bT1f9ZO1zWA3e5f2ZR7Hr45qnqivzV1jE2dZ0EX3zgUY
         iORLOi/YbGDvaKHT0DqloiFQWxCHE8DgWbP6RSg6RZFpilULUr2DjamciL8jtuq6g3d9
         w1ZQ==
X-Gm-Message-State: APt69E0KPgYJK5I7RYmdOsPRX8lDY1wfwInJn5Z3DIUUHcU8JOCRJ/ky
        ubwW07S15ezFEukd0ASmf2I=
X-Google-Smtp-Source: AAOMgpfBWCXhuwhZQ5iZQaPA/7560GhDyq5yrOuyd6qVd9LFjoDvvDMuTNIs57p7ji9SbyTuZWeh3w==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr14261656eda.154.1530953385597;
        Sat, 07 Jul 2018 01:49:45 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id n10-v6sm2080629edr.59.2018.07.07.01.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 01:49:44 -0700 (PDT)
Date:   Sat, 7 Jul 2018 10:49:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v3 8/9] ARM: s5pv210_defconfig: Enable drivers for
 Samsung Aries based phones
Message-ID: <20180707084943.omc3efkrxbqxaofx@kozik-lap>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530901970-14972-9-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530901970-14972-9-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:32:49PM +0200, Paweł Chmiel wrote:
> Enable config options required for Samsung Aries based phones.
> ARM_APPENDED_DTB is also needed, because stock bootloader
> does not support loading dtb files.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

