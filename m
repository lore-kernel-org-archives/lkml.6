Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C299205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C299205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeJARjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:39:14 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:33036 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbeJARjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:39:13 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 3B2432008C7;
        Mon,  1 Oct 2018 10:55:54 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 31A6820885; Mon,  1 Oct 2018 11:46:47 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:46:47 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia: Implement CLKRUN protocol disabling for Ricoh
 bridges
Message-ID: <20181001094647.GD7482@light.dominikbrodowski.net>
References: <86f282b4-5f86-2b3d-845f-80d34318ea98@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f282b4-5f86-2b3d-845f-80d34318ea98@maciej.szmigiero.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 01:21:06AM +0200, Maciej S. Szmigiero wrote:
> Currently, "disable_clkrun" yenta_socket module parameter is only
> implemented for TI CardBus bridges.
> Add also an implementation for Ricoh bridges that have the necessary
> setting documented in publicly available datasheets.
> 
> Tested on a RL5C476II with a Sunrich C-160 CardBus NIC that doesn't work
> correctly unless the CLKRUN protocol is disabled.
> 
> Let's also make it clear in its description that the "disable_clkrun"
> module parameter only works on these two previously mentioned brands of
> CardBus bridges.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Applied to pcmcia-next. Thanks!

	Dominik
