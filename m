Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293072084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293072084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJHUHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:07:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58703 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:07:17 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g9V4W-0001kP-Nv; Mon, 08 Oct 2018 14:55:40 +0200
Message-ID: <1539003340.11512.18.camel@pengutronix.de>
Subject: Re: [PATCH trivial] reset: Improve reset controller kernel docs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 14:55:40 +0200
In-Reply-To: <20181008111543.26128-1-geert+renesas@glider.be>
References: <20181008111543.26128-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, 2018-10-08 at 13:15 +0200, Geert Uytterhoeven wrote:
> Grammar and indentation fixes.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/reset.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 29af6d6b2f4b8103..d01ea059e2beee6e 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -138,7 +138,7 @@ __must_check reset_control_get_exclusive(struct device *dev, const char *id)
>   *
>   * Returns a struct reset_control or IS_ERR() condition containing errno.
>   * This function is intended for use with reset-controls which are shared
> - * between hardware-blocks.
> + * among hardware blocks.

To my ears "between" sounds better, because it evokes the idea that each
hardware block individually must take care not to disturb any of the
others (like sharing a bike between a few riders, instead of among
them). Also, in many cases the sharing occurs between just two hardware
blocks, which makes "among" sound weird.
Of course I'm not a native speaker, so maybe I'm completely wrong.

The other fixes I agree with.

regards
Philipp
