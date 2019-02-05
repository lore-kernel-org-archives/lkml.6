Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7031C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCD92080A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfBEJy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:54:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfBEJy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:54:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46170EBD;
        Tue,  5 Feb 2019 01:54:56 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58D803F71E;
        Tue,  5 Feb 2019 01:54:55 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Add James Morse to the list of APEI
 reviewers
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>
References: <20190205083836.21641-1-bp@alien8.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <3d8f90ca-c86b-361b-a883-8bb1fc50b6c6@arm.com>
Date:   Tue, 5 Feb 2019 09:54:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205083836.21641-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 05/02/2019 08:38, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Add James to the list of reviewers of the firmware-assisted RAS glue.

Fine by me,

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
