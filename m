Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D4C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1064213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBJU57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:57:59 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:39063 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfBJU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:57:58 -0500
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 63661100008;
        Sun, 10 Feb 2019 20:57:56 +0000 (UTC)
Date:   Sun, 10 Feb 2019 21:57:56 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Oliver.Rohe@wago.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: rs5c372: Fix reading from rtc when the
 oscillator got interrupted.
Message-ID: <20190210205755.GG23062@piout.net>
References: <1549632034-9195-1-git-send-email-oliver.rohe@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549632034-9195-1-git-send-email-oliver.rohe@wago.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2019 13:20:44+0000, Oliver.Rohe@wago.com wrote:
> When the oscillator of the rtc gets interrupted,
> e.g. due to an empty battery, reading from the rtc will now return an error
> and the oscillator bit will be cleared, once the rtc is successfully reset.
> 
> Signed-off-by: Oliver Rohe <oliver.rohe@wago.com>
> ---
>  drivers/rtc/rtc-rs5c372.c | 54 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 7 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
