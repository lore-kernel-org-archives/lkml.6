Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5933D2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551225208;
	bh=Q7Z2kpgI5J3dzq/cxlr1UOLrQnKf0YZDTvLKU0kEgus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QllhwOXwpy/tLcUsNhhtPr/mG1rSwmJgRruVEekygzmQRLOVy07qEmjMzrZAdIY4I
	 f3WCLtI0Lkw1m2NQVirFYnH41l067uJFEBGq+n5EmwQFQqM/iULzZrw+78QUOmij33
	 z4DrobFNvYWzzx6mmBFUgd1rARauBcvTe1TLU684=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfBZXx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:53:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46130 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfBZXx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:53:26 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6C078338;
        Tue, 26 Feb 2019 23:53:25 +0000 (UTC)
Date:   Tue, 26 Feb 2019 15:53:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V7 0/4] mm/kvm/vfio/ppc64: Migrate compound pages out of
 CMA region
Message-Id: <20190226155324.e99d5200cc6293138ac5c6fa@linux-foundation.org>
In-Reply-To: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/4]: OK.  I guess.  Was this worth consuming our last PF_ flag?
[patch 2/4]: unreviewed
[patch 3/4]: unreviewed, mpe still unhappy, I expect?
[patch 4/4]: unreviewed
