Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2614EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A0B21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A0B21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbeKNA1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:27:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37907 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeKNA1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:27:16 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gMZgO-0002ze-GM; Tue, 13 Nov 2018 15:28:48 +0100
Message-ID: <1542119328.4774.16.camel@pengutronix.de>
Subject: Re: [PATCH trivial] reset: Improve reset controller kernel docs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 13 Nov 2018 15:28:48 +0100
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

For now I have applied this patch without the s/between/among/, which I
am not sure about.

regards
Philipp
