Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728ADC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F9320874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F9320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeFTUVi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:21:38 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:37116 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933136AbeFTUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:21:37 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d20 with ME
        id 18MW1y00K41oiFu038MWxi; Wed, 20 Jun 2018 22:21:34 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 20 Jun 2018 22:21:34 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Philipp Zabel <philipp.zabel@gmail.com>
Cc:     Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: pxa: hx4700: fix the usb client
References: <20180526093834.21277-1-robert.jarzmik@free.fr>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 20 Jun 2018 22:21:30 +0200
In-Reply-To: <20180526093834.21277-1-robert.jarzmik@free.fr> (Robert Jarzmik's
        message of "Sat, 26 May 2018 11:38:34 +0200")
Message-ID: <87d0wlp5th.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The usb client of the hx4700 is not working because no platform data is
> declared. Fix it by adding the missing call.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Queued to pxa/for-next.

--
Robert
