Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C1020020
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C1020020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933259AbeGFOvm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:51:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeGFOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:51:39 -0400
Received: from localhost (unknown [37.170.89.196])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25A9ACFF;
        Fri,  6 Jul 2018 14:51:37 +0000 (UTC)
Date:   Fri, 6 Jul 2018 16:51:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Daniel Mack <daniel@zonque.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, robert.jarzmik@free.fr
Subject: Re: [PATCH v4 3/5] w1: core: match sub-nodes of bus masters in
 devicetree
Message-ID: <20180706145133.GA8930@kroah.com>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-4-daniel@zonque.org>
 <20180706135205.dkcrhbmaak2iteyw@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706135205.dkcrhbmaak2iteyw@earth.universe>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:52:05PM +0200, Sebastian Reichel wrote:
> Hi Greg & Evgeniy,
> 
> I suggest, that I take this patch and the DT bindings together
> with the power-supply changes, once the bindings have been
> reviewed by Rob (Herring). I will prepare an immutable branch,
> that can be pulled into w1 as needed. Are you fine with this?

You can take it, no need to mess with me :)

greg k-h
