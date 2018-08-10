Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279BEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E6622404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E6622404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHKBtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:49:52 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:54863 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726774AbeHKBtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:49:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id EA7AC180A8137;
        Fri, 10 Aug 2018 23:17:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: robin81_aa4db9231610
X-Filterd-Recvd-Size: 1328
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Aug 2018 23:17:53 +0000 (UTC)
Message-ID: <42cacb3730ec63505dd4cf0854f192deb8149e72.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: DT bindings should be a separate patch
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Fri, 10 Aug 2018 16:17:51 -0700
In-Reply-To: <20180810225049.20452-1-robh@kernel.org>
References: <20180810225049.20452-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 16:50 -0600, Rob Herring wrote:
> Devicetree bindings should be their own patch as documented in
> Documentation/devicetree/bindings/submitting-patches.txt section I.1.
> This is because bindings are logically independent from a driver
> implementation, they have a different maintainer (even though they often
> are applied via the same tree), and it makes for a cleaner history in
> the DT only tree created with git-filter-branch.

Thanks Rob.
Acked-by: Joe Perches <joe@perches.com>

