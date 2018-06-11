Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4fxjKVsWHlsxeQAAmS7hNA
	; Mon, 11 Jun 2018 06:29:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0D1EF60791; Mon, 11 Jun 2018 06:29:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3128C605A5;
	Mon, 11 Jun 2018 06:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3128C605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeFKG3K (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:29:10 -0400
Received: from muru.com ([72.249.23.125]:46568 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753913AbeFKG3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:29:08 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9B8EC80B6;
        Mon, 11 Jun 2018 06:31:41 +0000 (UTC)
Date: Sun, 10 Jun 2018 23:29:04 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com,
        t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Message-ID: <20180611062904.GO5738@atomide.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180611 06:28]:
> Great. I thought I completely misunderstood you. But I don't see what
> adding another function will accomplish. A QUIRK flag used in the same
> function would work well enough.

Fine with me as long as the function stays simple for both
syss and sysc reset.

Regards,

Tony
