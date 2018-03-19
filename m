Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521483797-2-7385748284401112136
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483796; b=X3Bn5ehUFPFrq4DJHdQEC7hB9oFfZ7XyrLsqmAT97oLkFuR
    k6Ij+xYZpX6KhVyyEKgDnOrNZ3ZYrESnmgAX4542IGN+waGafzOlHBgU0cmMTCia
    13kqzcT7xVGPUYu7wBTSSfUKXzy0D6j2mK39eEr5/PaE2lVQYvBHaVl13uE8FIbP
    VP23KfbHBjgiRpGMq8KPQB878X3iqaUIjaHPqHKUhGdy66BUjP0/1CBoWvY6Y5FU
    c9+EboIKK0axdC+rnAL+b2d8nZeB7Y76z8saTAK7pgjk2JZ1UOBMQ0qWKGADWK45
    pvc7Log33RL2/sOzcj2H1JZIGJ56sj8qjD0OfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483796; bh=zfQ6+Rh1IJJ35n/fsJiEOevMPj
    ozhzSkWj7jsT+pRX4=; b=lQOU4rfnNSZfA+xNhGHstansbRx1QllS72oERW5GbH
    LJorQHCeoD5g3g+UTikT6quZbQwBR1HA0ZDp42pNlcNNOKgC+zZFSwDiOs1IMaat
    yvsFkgv5jJ+x2M6kV1AfgfqAV7sHWOwSizypzDQy7IhOvSA8sKPzCbPeWEH1vVSd
    3pHQTA0ia+WwC13IdIOtFY1CFDiarA0fQLLHHnaCCvupcNy+1vX2VshE66Nqk85P
    RedOTRs93VeANBjxhL4hS3CjIsjJykKGMxeCaOygHYIdnbeEdWlLjWOdoZSnZSNn
    s+O0QzcB6hrmxcu9jF3jme8+xHsKYvXzMx3x9se6JdOQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegtdehvdenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegtdehvdenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030959AbeCSSXL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:23:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031363AbeCSSXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:23:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nate Watterson <nwatters@codeaurora.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 117/241] iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range
Date: Mon, 19 Mar 2018 19:06:22 +0100
Message-Id: <20180319180756.045874894@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nate Watterson <nwatters@codeaurora.org>


[ Upstream commit 5016bdb796b3726eec043ca0ce3be981f712c756 ]

Normally, calling alloc_iova() using an iova_domain with insufficient
pfns remaining between start_pfn and dma_limit will fail and return a
NULL pointer. Unexpectedly, if such a "full" iova_domain contains an
iova with pfn_lo == 0, the alloc_iova() call will instead succeed and
return an iova containing invalid pfns.

This is caused by an underflow bug in __alloc_and_insert_iova_range()
that occurs after walking the "full" iova tree when the search ends
at the iova with pfn_lo == 0 and limit_pfn is then adjusted to be just
below that (-1). This (now huge) limit_pfn gives the impression that a
vast amount of space is available between it and start_pfn and thus
a new iova is allocated with the invalid pfn_hi value, 0xFFF.... .

To rememdy this, a check is introduced to ensure that adjustments to
limit_pfn will not underflow.

This issue has been observed in the wild, and is easily reproduced with
the following sample code.

	struct iova_domain *iovad = kzalloc(sizeof(*iovad), GFP_KERNEL);
	struct iova *rsvd_iova, *good_iova, *bad_iova;
	unsigned long limit_pfn = 3;
	unsigned long start_pfn = 1;
	unsigned long va_size = 2;

	init_iova_domain(iovad, SZ_4K, start_pfn, limit_pfn);
	rsvd_iova = reserve_iova(iovad, 0, 0);
	good_iova = alloc_iova(iovad, va_size, limit_pfn, true);
	bad_iova = alloc_iova(iovad, va_size, limit_pfn, true);

Prior to the patch, this yielded:
	*rsvd_iova == {0, 0}   /* Expected */
	*good_iova == {2, 3}   /* Expected */
	*bad_iova  == {-2, -1} /* Oh no... */

After the patch, bad_iova is NULL as expected since inadequate
space remains between limit_pfn and start_pfn after allocating
good_iova.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iova.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -138,7 +138,7 @@ static int __alloc_and_insert_iova_range
 				break;	/* found a free slot */
 		}
 adjust_limit_pfn:
-		limit_pfn = curr_iova->pfn_lo - 1;
+		limit_pfn = curr_iova->pfn_lo ? (curr_iova->pfn_lo - 1) : 0;
 move_left:
 		prev = curr;
 		curr = rb_prev(curr);
