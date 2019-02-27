Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E50C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A90213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfB0UOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:14:35 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:56746 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfB0UOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:14:34 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7BD4B8042C;
        Wed, 27 Feb 2019 21:14:31 +0100 (CET)
Date:   Wed, 27 Feb 2019 21:14:30 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: drop AVR and platform_data
 support
Message-ID: <20190227201430.GA27395@ravnborg.org>
References: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=P-IC7800AAAA:8 a=7gkXJVJtAAAA:8
        a=17Lo_IAAPqJK1KymrdkA:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre.

Nice patch, good to clean out unused code.
On Mon, Feb 25, 2019 at 10:25:33PM +0100, Alexandre Belloni wrote:
> Make the driver OF only as since AVR32 has been removed from the kernel,
> there are only OF enabled platform using it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

