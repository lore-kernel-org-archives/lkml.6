Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B41C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72359217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72359217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHCXqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:46:00 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:37284 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeHCXqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:46:00 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174])
        by mwinf5d63 with ME
        id Jlns1y0023mLd2903lnssU; Fri, 03 Aug 2018 23:47:53 +0200
X-ME-Helo: mail-qt0-f174.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Fri, 03 Aug 2018 23:47:53 +0200
X-ME-IP: 209.85.216.174
Received: by mail-qt0-f174.google.com with SMTP id c15-v6so7824760qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:47:52 -0700 (PDT)
X-Gm-Message-State: AOUpUlHva6rKpiq/79TWc8YV3iHdsGNVSZcmgu+gF7KUXNRUG3tWV9gR
        J3lyuABwnKe3dam07PpMNu20INpQuYChaD99hS8=
X-Google-Smtp-Source: AAOMgpdwDJMTiLibTgNIreJljEN2NKM5aqmx6SYsckhXYA4pTPUuhPyuwOikf5WCMnRl5RBWJ1AYA9peqUe5fTIG5zM=
X-Received: by 2002:ac8:3351:: with SMTP id u17-v6mr5718821qta.126.1533332872012;
 Fri, 03 Aug 2018 14:47:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:278a:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 14:47:51 -0700 (PDT)
In-Reply-To: <CALecT5i1mnkvi4WuL701cA+UnRL9CKmj=CMqLEWN=fpbxfi7ZQ@mail.gmail.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-2-maxi.jourdan@wanadoo.fr> <CALecT5i1mnkvi4WuL701cA+UnRL9CKmj=CMqLEWN=fpbxfi7ZQ@mail.gmail.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Fri, 3 Aug 2018 23:47:51 +0200
X-Gmail-Original-Message-ID: <CAHStOZ5W+jJRox3=Nnem+Z1zopFOUenpmT-QkUzd5hrmKXfX5A@mail.gmail.com>
Message-ID: <CAHStOZ5W+jJRox3=Nnem+Z1zopFOUenpmT-QkUzd5hrmKXfX5A@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc: amlogic: add meson-canvas driver
To:     Yixun Lan <yixun.lan@gmail.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun, thanks for the review

2018-08-03 16:14 GMT+02:00 Yixun Lan <yixun.lan@gmail.com>:
>> +config MESON_CANVAS
>> +       bool "Amlogic Meson Canvas driver"
> shouldn't this a 'tristate'? since you'd make the driver a kernel module..

Yep it should!

I well noted your other feedback and v2 will have fixes for them :) .
