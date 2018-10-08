Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D5C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8C720645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8C720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJHOxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:53:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52205 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeJHOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:53:24 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g9QBv-0007uL-M9; Mon, 08 Oct 2018 09:42:59 +0200
Message-ID: <1538984579.11512.3.camel@pengutronix.de>
Subject: Re: [PATCH] reset: socfpga: add an early reset driver for SoCFPGA
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     marex@denx.de, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 09:42:59 +0200
In-Reply-To: <ce42c5f9-e189-ddcd-f1be-29e4b49af094@kernel.org>
References: <1537195830-25759-1-git-send-email-dinguyen@kernel.org>
         <1538646836.14153.4.camel@pengutronix.de>
         <04f701c1-8f1c-ee99-6797-cfbe769ebbc7@kernel.org>
         <1538753420.3545.39.camel@pengutronix.de>
         <ce42c5f9-e189-ddcd-f1be-29e4b49af094@kernel.org>
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

Hi Dinh,

On Fri, 2018-10-05 at 15:23 -0500, Dinh Nguyen wrote:
> Hi Philipp,
> 
> I apologize, but I just realized that I forgot to test this patch
> against the SoCFPGA ARM64 platform. I just tested against that platform
> and this patch is preventing that board from booting.
> 
> I need to redo this patch.
> 
> If its not too late, can you remove this patch from reset/next?

That's fine, I've dropped the patch from reset/next.

regards
Philipp
