Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162885-2-14645102518361823815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162884; b=MK7AY2Ac7xdJ0CkjwVp0DJeYJeYXtMYc+o05rqXk28EAfU88j5
    vyywD+INbEAIYVuu8mBwEDmmJBj/DkdAQUV88u+T48Q0GzDjzgZRCuB2KfM9N5CJ
    5bV2WW5z2BTHwK10hYDoLBILS8RaXMcOuj+2tEDFcHYImvg2jupeL+INmoaviP4q
    o1g0lck2VkS31ONsNi3ZTXmFSlG/8BPT9rxX4jAoDHXBetg5f5oDzFtLj0z134vp
    g/JNdmohKjxtOZ/sKC3urF6a7B7J1LcTxOHGqPwI+TsT2/5NZBuW1v/iUS6xfM2l
    1SR85Gk63j0xVUQOp+HlrwZoy+tDSOgDNdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162884; bh=YKAIRIgSvCHo6vQsBrZbIPMDAgvmzH
    RfEtc48nADraY=; b=JKmkIM6osrYFt2XvUYQ+U4v1qBF9boLUca3pIst8fAutNh
    8iQnIeBc+mXB3jtUKr4LH9UQsE9j0+3GEMHsJmXcDhKsqoTMPNHjEOXZLiDgtXx6
    SHiOOnUgVA3d8C+4RzwfaWxDVy8JjYKqykJB6y2LmgVQwdbmyYNhtQtjyrHy6ACP
    6VkwuvVIlJl+2dwdOoXDKD9ywqh0jDMzDg69BpIOPzrVtsMH+RUmR/h9+BHvFgee
    3ImhOn74RdhAcua+gMbdh0Q+bg47E4by9RIseWHOTmeRmW+ELzTh9Zk9JyrM1kBS
    3aIk58dBEdcByiwhoJGwRx2wVXJ5xfYRSgBwNppw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1hlUX+AH x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1hlUX+AH x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdfxfHlZMNAgu9fC47VAc7RWgRajtpUGLRoJGqk9p28WYEvbeVGVxnA5KB8Ss2pZdGqktdrFMaRetX8aRYkEADhhgoLw6oAowVSuqFqswA90bluOORs
    GM+ZX3bkozRorgQsjCGbE8Ikju4Gurz7zeun8bw84OUbayaMgkxfLOZG5RQ+OWaY5OD931EtnDoWfnMzzPFgOV+es4505gDz7kCkWXuTRYnlXpqcE3VKvOvL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ufHFDILaAAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=Z4Rwk6OoAAAA:8
    a=ag1SF4gXAAAA:8 a=0b4zmqLCo3EYSYeUVQgA:9 a=uRHH206AopR-r5Jb:21
    a=D-ciIsrcjdA_RX7d:21 a=QEXdDO2ut3YA:10 a=ZmIg1sZ3JBWsdXgziEIF:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966118AbeEXJqR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966482AbeEXJqN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 48/92] proc: meminfo: estimate available memory more conservatively
Date: Thu, 24 May 2018 11:38:25 +0200
Message-Id: <20180524093204.135765542@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Weiner <hannes@cmpxchg.org>

commit 84ad5802a33a4964a49b8f7d24d80a214a096b19 upstream.

The MemAvailable item in /proc/meminfo is to give users a hint of how
much memory is allocatable without causing swapping, so it excludes the
zones' low watermarks as unavailable to userspace.

However, for a userspace allocation, kswapd will actually reclaim until
the free pages hit a combination of the high watermark and the page
allocator's lowmem protection that keeps a certain amount of DMA and
DMA32 memory from userspace as well.

Subtract the full amount we know to be unavailable to userspace from the
number of free pages when calculating MemAvailable.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/meminfo.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -57,11 +57,8 @@ static int meminfo_proc_show(struct seq_
 	/*
 	 * Estimate the amount of memory available for userspace allocations,
 	 * without causing swapping.
-	 *
-	 * Free memory cannot be taken below the low watermark, before the
-	 * system starts swapping.
 	 */
-	available = i.freeram - wmark_low;
+	available = i.freeram - totalreserve_pages;
 
 	/*
 	 * Not all the page cache can be freed, otherwise the system will
