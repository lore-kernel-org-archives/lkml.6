Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72658C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BD0218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfA3KPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:15:31 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42093 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfA3KPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:15:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id 68so13305737qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GDNlm//MFE5FP1XiS5FBswbHuWVO6m+yA1RhhQ+bHI=;
        b=jLx/yXpsDnPPB7NMPOP1PD3OWrmxzi38i5oQI+OM02aDakdwsdXLA6iCRGSZDrJ6y9
         XGLwihKzdOVBYsGqAM2WR0gtJ0TiwrENazo+d2jFPhBknoaOT9uEAChWnRpRiBROz574
         9IbMUpFSOxn5peC+AqYOxYPUkya0vspCWcyjcvLx+K+93vsyhuuGuadA3EgjyFFdlock
         Tzaq1sEZhtiDKNEu6ozMKzVZkLjUKFYNYJ/M1CpAyam1S7iQ65T7i5edrZ/AeCT7IdGE
         RGuoQCK0Z8nSn2UhoQ80ZUlPQVpSr+1PqBnpoqFZ+cOm/9hzrqzCITHoa5Mv2uFkhMMj
         HH2g==
X-Gm-Message-State: AJcUukdaEUgQ19wXUhp7yEppgnnAc4HuEc3uR85iDZe14oQHQGNKiDH4
        GfCwBBV/Tug/3aJhJjotgMmbMIgnS7C8NzBGzGBz6A==
X-Google-Smtp-Source: ALg8bN431VqAOdiSWckvYl30ifikO1buFSOFPjTCMwshf8TM11TtEGQuYwpPw+0Y1fhRnya5OmQYJEJiU5PI+8yyLWM=
X-Received: by 2002:a37:ad04:: with SMTP id f4mr22227158qkm.291.1548843330132;
 Wed, 30 Jan 2019 02:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20190118232250.22570-1-leoyang.li@nxp.com>
In-Reply-To: <20190118232250.22570-1-leoyang.li@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 11:15:13 +0100
Message-ID: <CAK8P3a3J_8tNLTs32Jq+MgwnDqSMAiRG0VVAThreWg-1tk8+Nw@mail.gmail.com>
Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v5.0
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 12:22 AM Li Yang <leoyang.li@nxp.com> wrote:
>
> ----------------------------------------------------------------
> soc/fsl fixes for v5.0
>
> - qbman: avoid missing interrupts by only clearing processed events
>
> ----------------------------------------------------------------
> Madalin Bucur (1):
>       soc: fsl: qbman: avoid race in clearing QMan interrupt

Pulled into arm/fixes, thanks!

    Arnd
