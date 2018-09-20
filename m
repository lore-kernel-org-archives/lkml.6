Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0124FECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59E320880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59E320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeITPgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:36:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57379 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeITPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:36:19 -0400
X-Originating-IP: 209.85.216.179
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (Authenticated sender: aditya@kobol.io)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5405820004;
        Thu, 20 Sep 2018 09:53:38 +0000 (UTC)
Received: by mail-qt0-f179.google.com with SMTP id z8-v6so7860722qto.9;
        Thu, 20 Sep 2018 02:53:38 -0700 (PDT)
X-Gm-Message-State: APzg51ACUIEg2saR+Q2ckxCP2AVVSgd8QgbDdmANmpDfb638JA1glar7
        ylaV95jt6GjO2+sn+Rht3A4GP4uJZOexzh2a73U=
X-Google-Smtp-Source: ANB0VdYyQ3+0/f6F708ng4xPvBMpqFpxkXvO63sM1ISEpcvZ1KR6sEue3E6UTMYdbAEx3dEd02ivKtxy9FZt7F0Sm9g=
X-Received: by 2002:a0c:d8a4:: with SMTP id q33-v6mr27999474qvj.240.1537437217130;
 Thu, 20 Sep 2018 02:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-2-git-send-email-aditya@kobol.io> <20180919130104.GD26940@lunn.ch>
In-Reply-To: <20180919130104.GD26940@lunn.ch>
From:   Aditya Prayoga <aditya@kobol.io>
Date:   Thu, 20 Sep 2018 16:53:26 +0700
X-Gmail-Original-Message-ID: <CAFTRUBdcGqroAfiG__e0nwP2GqK3Xh9PVOGQsk9Jj_jkrcU9ag@mail.gmail.com>
Message-ID: <CAFTRUBdcGqroAfiG__e0nwP2GqK3Xh9PVOGQsk9Jj_jkrcU9ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] libata: add ledtrig support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-ide@vger.kernel.org, linux-leds@vger.kernel.org,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
        axboe@kernel.dk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thank you for your feedback. It seem i also need to resolve the issue
reported by kbuild test robot.

Aditya
