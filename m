Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1DEC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4172824A0D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hqeILGgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4172824A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934199AbeFVXyp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:54:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933816AbeFVXyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2D2TLqN0Q445KwBV1qzjAehjhWiNlreQ0eo9BUu0EAk=; b=hqeILGgj56pzZetrYUiYMtnSu
        cTWLwsgCdHugYpm1ObVM9fo/YbonRbPTNOwvkEVSDcj8YcFp19ID9wJ2UPRG3zlYAcd386/SmnmZN
        SLjrnz5KPKpnZz+WgLR51gdinscndEAXAZNqAQcmNQZHTGtzVTiWjYlmwRozEqiZ+jS7Iuao6+ARm
        B/er65O35IjXVeMJIlz8RtNOJ+s8VPnEiBrYpId4JJ0U6RlzjltEDOuV+1PbWV9YgVik0/BIDXR3x
        c99z+NdET31DF15A7fPPmuKt3Nl+R+V/CUXCMyg/jdo68rjELp4QABJDapTyaMUmQOKQkdk2EYNxT
        4LYGRBIkw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWVt5-0005GY-UD; Fri, 22 Jun 2018 23:54:43 +0000
Date:   Fri, 22 Jun 2018 16:54:42 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-smbios-base: Support systems without
 tokens
Message-ID: <20180622235442.GE27466@fury>
References: <1529082771-21309-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529082771-21309-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:12:51PM -0500, Mario Limonciello wrote:
> Some Dell servers can use dell-smbios but they don't support the
> token interface.  Make it optional.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks Mario, queued.

-- 
Darren Hart
VMware Open Source Technology Center
