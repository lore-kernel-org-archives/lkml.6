Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F93C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D4121473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D4121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeJDQq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:46:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52857 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:46:58 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g80Kw-0007sR-Q3; Thu, 04 Oct 2018 11:54:26 +0200
Message-ID: <1538646866.14153.5.camel@pengutronix.de>
Subject: Re: [PATCH trivial] reset: Grammar s/more then once/more than once/
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 11:54:26 +0200
In-Reply-To: <20180926132003.23341-1-geert+renesas@glider.be>
References: <20180926132003.23341-1-geert+renesas@glider.be>
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

On Wed, 2018-09-26 at 15:20 +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/reset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 09732c36f3515a1e..29af6d6b2f4b8103 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -116,7 +116,7 @@ static inline int device_reset_optional(struct device *dev)
>   * @id: reset line name
>   *
>   * Returns a struct reset_control or IS_ERR() condition containing errno.
> - * If this function is called more then once for the same reset_control it will
> + * If this function is called more than once for the same reset_control it will
>   * return -EBUSY.
>   *
>   * See reset_control_get_shared for details on shared references to

Thank you. Applied to reset/next, with a line of commit description
added.

regards
Philipp
