Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF07C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B820652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93B820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeJDV7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:59:49 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:37459 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDV7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:59:49 -0400
Received: by mail-qk1-f174.google.com with SMTP id x8-v6so5936332qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xwSEDJR2Egw+s8PCruacdPqlKnjlSHp7X+lyynFTriI=;
        b=qBz+DZxf6KV8leE22W7hkA+sPJKsfyvS/i7YRLyWclAj2/kp1KwZ0eCSz8p0rnnlo1
         S9glrtdJ35wuJKHPmWQ60vpctcBxD29exHi6bkovd68GqrLrnJ4jz3keBWDyFyhFQRZy
         tCx3xN9ejwRxqJZvdbYSgoOQ8I93Hx1hZEUUqPKSa8Enf12KTp93kl9pG+UzvqlaW2Sd
         ewCV0K6+hCAezEpjcGC0nFo3wu5wfoNB+soI00a48GtFNupm2sTOYc6ieP6Fx+p+LKU7
         vzAm+XsYONo4tmmcWeiMTxeFlLdlMoabbKpKyNvEzAwE3hChNZYf4Q4x3iWbcmCLicYt
         jhmQ==
X-Gm-Message-State: ABuFfohh+WPA+zXbC7W7sQMQMF5PJ4Wijg87Zip/gA+Ttro79MAtO4Z0
        njUkxsM+mdMQwo++SrAER4yYcYofc7pbUhjdSPc=
X-Google-Smtp-Source: ACcGV62mR1q2AhfFwrOOYojpcSITN5Hr/iaXoG+oCLIHNoQt8yZlhAOa1rhbUOJtHpMd0oVJkEhVF5iVHb1h2X4TCsQ=
X-Received: by 2002:a37:2b12:: with SMTP id r18-v6mr5259914qkh.343.1538665567857;
 Thu, 04 Oct 2018 08:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181003134553.aqbogomrxqmpgpmo@M43218.corp.atmel.com>
In-Reply-To: <20181003134553.aqbogomrxqmpgpmo@M43218.corp.atmel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 17:05:50 +0200
Message-ID: <CAK8P3a08=FMJUKgSe10d5Nw+626=-pmP7Fy8G6f+_+OtU_VEcQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: at91: DT for 4.20 #2
To:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 3:45 PM Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> Arnd, Olof,
>
> Here are the second round of DT changes for 4.20. It consists in NAND
> description fixes (size and partitions).

Pulled into next/dt, thanks!

       Arnd
