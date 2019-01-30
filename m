Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DDDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB2E20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfA3XIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:08:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38751 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfA3XIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:08:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so1542978qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4QSQHS/7KbHXRwMS6F8HUmkqqog+j45BTi17g0JHiM=;
        b=l1miXglxfhPeuaE21+f/ZZBFfwPRJOKVVXmpjk5L1a1ZxPb55TpFrS0BhOqqp/dy7j
         sW1Ff4uUZKbjIqey3vQ/OjB3falUHgDV26zlST+f8lxA5/V6eiGs0nd9CZqykkn/Q77k
         d3cvE4ZQ2i9IJazdZcGqd2RkKmQKtcPo1AUSPaUH0+owqugjy0ox5703Hahq560ql6Kv
         hVBfykBz8efDzVkSv6if/43BIyFJPramLLJ+yjNpQ/sgeYGx18MtUcfA7d0A7j55k+PR
         hMHxodu7qiwCBcZRGrIhZIPhJo7XdLDzvsNGxC8+MszrSigXNjr4GhIdeHyFiIbH3Mw2
         OV5w==
X-Gm-Message-State: AJcUukcAHkS1zH3AC8YB/eS3HXrsmgUGHws+Za4JAuhyiQbd7oZ5KdWu
        a0qCKxJy4z7wt/24Qc8ERE9SbuUNF5gunec6uBgxzA==
X-Google-Smtp-Source: ALg8bN4uail99A6Ivb/kXsSlqjKSPalXtjqS8W7tCIfny3mqqlHGNDZbjwmbdQMBR2n1vi5hSsdrp31hw2e4mRpiBZk=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr32276785qta.152.1548885918833;
 Wed, 30 Jan 2019 14:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20190111225600.16160-1-leoyang.li@nxp.com>
In-Reply-To: <20190111225600.16160-1-leoyang.li@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 23:05:01 +0100
Message-ID: <CAK8P3a2H_DFj_yUtBqKVQv0UONN6Njkk613+SW_zeYsg20f0hw@mail.gmail.com>
Subject: Re: [GIT PULL v2] updates to soc/fsl drivers for v5.1
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

On Fri, Jan 11, 2019 at 11:56 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Hi arm-soc maintainers,
>
> This is an updated pull request to replace one problematic patch
> regarding to guts driver.  Please ignore the last pull request.
>

Pulled this version now, thanks for the update!

       Arnd
