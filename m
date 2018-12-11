Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD5AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB4D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544508284;
	bh=FJaLwOpg3WQl/9SgKpRhq7EpHs2GQsSGPsFgiN7R4Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mrf1Qx3HLq9U/zPrPBNn1RAipU7mTb+92GIyS8lse2yFQ64Kpa/OmWGE4dcyPWRtz
	 8Iam7poLAQ7j/jiSfH4ujfTAgeuW6bU6PEdfw/WN7beNz9M/7wNv+4rKQe+xs+W3PQ
	 TlF8iI6iWW5a+hn8IvIGYrKR1y80ZHeFv6JZJWL0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB4D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeLKGEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:04:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbeLKGEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:04:43 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC8A20672;
        Tue, 11 Dec 2018 06:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544508282;
        bh=FJaLwOpg3WQl/9SgKpRhq7EpHs2GQsSGPsFgiN7R4Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ER2O9uTH9D+wNLhDUDP2odWJrtKJRwFvmrK9ZpzSSeMhvPIHvDh7DC8JZlzuXGgo6
         Sh5tCcQuDWti/+9oYoUJcd1UdO7GxN0T+pXI69KHpevMxFu/ahnH7i1RX36jqFYluP
         9i+W402EtVcH+EKYliIHnc1KsbwYzkBoC02VSIbE=
Date:   Tue, 11 Dec 2018 14:03:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     TheSven73@googlemail.com, Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: bus: imx-weim: document multiple
 address ranges per child node
Message-ID: <20181211060348.GW3987@dragon>
References: <20181206192633.25319-1-TheSven73@googlemail.com>
 <20181206192633.25319-3-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206192633.25319-3-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:26:32PM -0500, Sven Van Asbroeck wrote:
> The imx-weim driver was patched to allow correct WEIM configuration
> when multiple address ranges are used in a child node.
> Update the dt-bindings to reflect this.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>

The bindings patch should go first in the series.

Shawn
