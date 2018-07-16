Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A62ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D1F208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D1F208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbeGPJB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:01:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbeGPJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:01:27 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2A68ED25;
        Mon, 16 Jul 2018 08:35:10 +0000 (UTC)
Date:   Mon, 16 Jul 2018 10:35:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver =?iso-8859-1?Q?H=FCbers?= <oliver.huebers@web.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de,
        Vanessa Borgmann <nessa.x@web.de>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] staging: mt7621: Add braces around macro argument
Message-ID: <20180716083507.GB7903@kroah.com>
References: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
 <1531489266-20410-3-git-send-email-oliver.huebers@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531489266-20410-3-git-send-email-oliver.huebers@web.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 03:41:05PM +0200, Oliver Hübers wrote:
> Add braces around macro argument to avoid precedence problems.

That is not what this patch does :(

