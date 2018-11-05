Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C859C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE98020825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE98020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeKETVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:21:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKETVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:21:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55539EBD;
        Mon,  5 Nov 2018 02:02:06 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 462AE3F706;
        Mon,  5 Nov 2018 02:02:05 -0800 (PST)
Date:   Mon, 5 Nov 2018 10:02:02 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     torvalds@linux-foundation.org, will.deacon@arm.com,
        punitagrawal@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailmap: Update email for Punit Agrawal
Message-ID: <20181105100202.GA23421@arrakis.emea.arm.com>
References: <20181102165751.17948-1-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102165751.17948-1-punit.agrawal@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:57:52PM +0000, Punit Agrawal wrote:
> As I'll no longer be working with Arm, add a mailmap entry so any mail
> directed towards me reaches the appropriate mailbox.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

I'll pick this up for 4.20-rc2 (unless Linus applies it directly).

Good luck with your new job! ;)

-- 
Catalin
