Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501A2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B692086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqENdK/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B692086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbeFQCPa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:15:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933716AbeFQCPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/dmGycHkrNePUpcfXnb6jNk3QKdEtKDpi3dqa/B/7lk=; b=gqENdK/+wiqaicybfcfohB6Pfr
        6tROvRuPWaktFwHcyEbZ+I9anyRni4bmJMfTn6kTCOWhjEB+FZxoiAGd6lL9um7ryNIDCLxoSGOir
        5HVLJPjzLq/mrCoTUzwBvAt1b0DaxFt079r798bwKWtlNxqRnUi7lEC8ulcQGWZIhntG3ZlyajxLG
        xFtfBCppyX+24YMG4VJi00aRYLB2sNgFvOAatt8IA++xSe1DBCGkDQG29FYSpySGs/80WEJt2FWe5
        k+g2sU6WqIfxfYk2hL6dQaK8Aibk1tjoR07Gr7xY434TVFcJwlVPHwqRC6waFsURfIOokV20MR/CI
        IAykYg8g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUNDu-0007dk-M8; Sun, 17 Jun 2018 02:15:22 +0000
Date:   Sat, 16 Jun 2018 19:15:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: XArray -next inclusion request
Message-ID: <20180617021521.GA18455@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

Please add

git://git.infradead.org/users/willy/linux-dax.git xarray

to linux-next.  It is based on -rc1.  You will find some conflicts
against Dan's current patches to DAX; these are all resolved correctly
in the xarray-20180615 branch which is based on next-20180615.

In a masterstroke of timing, I'm going to be on a plane to Tokyo on
Monday.  If this causes any problems, please just ignore the request
for now and we'll resolve it when I'm available to fix problems.

