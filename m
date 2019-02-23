Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3FD20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfBWUXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:23:30 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:55498 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 15:23:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 52CC84A94;
        Sat, 23 Feb 2019 21:23:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HKOyZQY-gKhd; Sat, 23 Feb 2019 21:23:28 +0100 (CET)
Received: from function (dhcp-97-171.dsi-ext.ens-lyon.fr [140.77.97.171])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id AB5644A8B;
        Sat, 23 Feb 2019 21:23:28 +0100 (CET)
Received: from samy by function with local (Exim 4.92-RC6)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gxdpY-00069W-0a; Sat, 23 Feb 2019 21:23:28 +0100
Date:   Sat, 23 Feb 2019 21:23:27 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging : speakup: replace ---help--- with help in
 Kconfig
Message-ID: <20190223202327.vnhjibwbnrz76kro@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Bharath Vedartham <linux.bhar@gmail.com>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190223202117.GA6455@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223202117.GA6455@bharath12345-Inspiron-5559>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, and thanks for your patch,

Bharath Vedartham, le dim. 24 févr. 2019 01:51:17 +0530, a ecrit:
> @@ -148,7 +148,7 @@ config SPEAKUP_SYNTH_KEYPC
>  
>  config SPEAKUP_SYNTH_LTLK
>  	tristate "DoubleTalk LT/LiteTalk synthesizer support"
> ----help---
> +help

I'd say while at it, align it with tristate?

Samuel
