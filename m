Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65885C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E112083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E112083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJYXud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:50:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbeJYXud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:50:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF41CA78;
        Thu, 25 Oct 2018 08:17:19 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7623E3F5D3;
        Thu, 25 Oct 2018 08:17:18 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:17:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH AUTOSEL 4.9 91/98] tty: serial: pl011: add ttyAMA for
 matching pl011 console
Message-ID: <20181025151715.GB32027@e107155-lin>
References: <20181025141423.213774-1-sashal@kernel.org>
 <20181025141423.213774-91-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025141423.213774-91-sashal@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Thu, Oct 25, 2018 at 10:14:16AM -0400, Sasha Levin wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> [ Upstream commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b ]
> 

This commit was later reverted with commit b767ad726c2a ("Revert "tty: serial:
pl011: add ttyAMA for matching pl011 console"") as it caused regression else
where. So I assume you can drop this. Unfortunately the revert doesn't
carry fixes tag hence I thought of mentioning to you.

The original issue still exists.

--
Regards,
Sudeep
