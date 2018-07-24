Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186A5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B1A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B1A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbeGXNG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:06:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbeGXNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:06:59 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 057AACB4;
        Tue, 24 Jul 2018 12:00:49 +0000 (UTC)
Date:   Tue, 24 Jul 2018 14:00:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurence Rochfort <laurence.rochfort@gmail.com>
Cc:     Christian Gromm <christian.gromm@microchip.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: most: Use NULL pointer not plain integer
Message-ID: <20180724120047.GA23154@kroah.com>
References: <20180723105429.GA7428@minipc.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723105429.GA7428@minipc.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:54:29AM +0100, Laurence Rochfort wrote:
> Fix sparse warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Laurence Rochfort <laurence.rochfort@gmail.com>
> ---
>  drivers/staging/most/dim2/dim2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch does not apply to my tree at all :(
