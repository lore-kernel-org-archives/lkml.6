Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CBAC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18B220879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfAURKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:10:18 -0500
Received: from foss.arm.com ([217.140.101.70]:39410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfAURKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:10:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A0DA15AB;
        Mon, 21 Jan 2019 09:10:18 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48113F614;
        Mon, 21 Jan 2019 09:10:17 -0800 (PST)
Subject: Re: [PATCH] EDAC: Add James Morse as a reviewer
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190121123941.28247-1-bp@alien8.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <37282e66-a00b-15bc-e27c-f438200fa768@arm.com>
Date:   Mon, 21 Jan 2019 17:10:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121123941.28247-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 21/01/2019 12:39, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> With the growing amount of ARM[,64] EDAC enablement happening, add James
> as a reviewer for the ARM bits.

Sure,


> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
