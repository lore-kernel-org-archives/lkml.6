Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A090FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E24F20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbeLTQWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:22:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37760 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbeLTQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:22:30 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so2430944qtt.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Je/zcHkj51uQFU+ORMoEj/p288M5ZoBEY9tScoaFYds=;
        b=eIWWjMUZ3PBBtka4uqqnx4A0caEFUu9nwEn+GTJPYypFYWlxvCulFxPtDfvbmF6lXD
         OwVl692SWUcADozp2IvMyunW0kdRRpSe9xMDHCF3/drH7Fzxb10Bbm5SH/yCY2DhEH1G
         0TvI43JPwKYl+taUOymPVD9xkXXEL+X+3a3YbV48+AcF/PD8NZDL8lY9P44bHDiaYvJG
         iyZP/aQu7d4O5dlpqczvucay13HQgfxGZ1v2/Gwi6urcJ+Po4cqJVVfauXnC4OcQsY5f
         Wf+NmInEBtQ3AVBKDfOTyVSSA3KeAjptipgvzkNG9ja4abwI2MbPb1MomtnORvjJL8+z
         PxJw==
X-Gm-Message-State: AA+aEWaVE93P1PJBVMnnuUXXT6op3PkoLy9CLMnjF8GZV8TpDSeK6Bwu
        CHCkx4Je5l12N67sUy8jGziSfBlRsL9urTN/toviqSbA
X-Google-Smtp-Source: AFSGD/V5lgJT/jKMxT4WmMoV1sr8FgJPL88ftRPhTvZKxdlreizLKRBD1IWF0f414IAO1pp4qBBdB+Xhf3Mph69sE28=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr16682934qtm.96.1545322949727;
 Thu, 20 Dec 2018 08:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20181220111626.17140-1-shc_work@mail.ru>
In-Reply-To: <20181220111626.17140-1-shc_work@mail.ru>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Dec 2018 17:22:12 +0100
Message-ID: <CAK8P3a34Fh5a2DQHDpUG3QOViQYHpRxjXDngXs7Vb+5Y22-x6A@mail.gmail.com>
Subject: Re: [PATCH] clocksource: clps711x: Remove board support
To:     Alexander Shiyan <shc_work@mail.ru>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 12:16 PM Alexander Shiyan <shc_work@mail.ru> wrote:
>
> Since board support for the CLPS711X platform was removed,
> remove the board support from the clps711x-timer driver.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Acked-by: Arnd Bergmann <arnd@arndb.de>
