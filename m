Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521483693-2-16850870785817956721
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
    t=1521483693; b=Qx4siA17WL4NwNkXPFgUhgOws6rW1xA7pwsfhXiZTq10sGX
    wXx1aNr/3s3kG0gDpzr58GwDmR7WUh+QqCMgKK4AOppuYpwRTR32x8CYZnFJW7NM
    5QBVtMlAheMIycVWUG8PqVNuWmyl9hFT1NzgGhW3N/44ZcJLfQtbMZ7EiLYOeWMS
    t2EgYru4brxqdrYqK87wGZLPvPSmixod6kuEJKrzkurhgvEfhvATdjbB8rQrBYM1
    mb1wyOu90gOvXpR9gBeUaI9WOU+raHEcNoh4GdcX5OUnH93b/j6k19Kn9sL/+v/B
    I9nB8dfA6fHW1UgYt6Qb/2u1o3MDBDNDe1r4yeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483693; bh=GtgNd+4slKMTPKoT9FJZWRtLno
    APYWFmuwBe3ouSFM0=; b=KqT9IfBdiQmUhC1zvFLcuNrlndv4v6RuMhGje7abnu
    iiXe6UJOUlI0ugCOUBYzw/15N2aKtXBTKornImqVK+kcP1UnX26K3ZgmY0pXhXIt
    9MXGuKked4SIixydfJqUkT6l+mZbS4PfarspRrbV6qC97iJ6h+oi/RGrqhNAsj6u
    iCUAy/XykUQaUBtpY5rGc1Wl0pR9yhqlpRrL5GZpGF2AhC4QDLQyrWodP/ymvY5u
    YeXgEujM/j8ukLfuLHHAbDFYc9lq2B/MJQybCyb31BKV1/dd0RHFuANW58TsO5uK
    bAgTRIPpnsohVK0PZDjWYyGDUvkAG4Nf+hJSWIYS5NfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefheekleenucevlhhushhtvghrufhiiigvpeeiie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefheekleenucevlhhushhtvghrufhiiigvpeeiie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031110AbeCSSVW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:21:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031100AbeCSSVU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:21:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 078/241] blk-throttle: make sure expire time isnt too big
Date: Mon, 19 Mar 2018 19:05:43 +0100
Message-Id: <20180319180754.432758367@linuxfoundation.org>
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

From: Shaohua Li <shli@fb.com>


[ Upstream commit 06cceedcca67a93ac7f7aa93bbd9980c7496d14e ]

cgroup could be throttled to a limit but when all cgroups cross high
limit, queue enters a higher state and so the group should be throttled
to a higher limit. It's possible the cgroup is sleeping because of
throttle and other cgroups don't dispatch IO any more. In this case,
nobody can trigger current downgrade/upgrade logic. To fix this issue,
we could either set up a timer to wakeup the cgroup if other cgroups are
idle or make sure this cgroup doesn't sleep too long. Setting up a timer
means we must change the timer very frequently. This patch chooses the
latter. Making cgroup sleep time not too big wouldn't change cgroup
bps/iops, but could make it wakeup more frequently, which isn't a big
issue because throtl_slice * 8 is already quite big.

Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-throttle.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -499,6 +499,17 @@ static void throtl_dequeue_tg(struct thr
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
+	unsigned long max_expire = jiffies + 8 * throtl_slice;
+
+	/*
+	 * Since we are adjusting the throttle limit dynamically, the sleep
+	 * time calculated according to previous limit might be invalid. It's
+	 * possible the cgroup sleep time is very long and no other cgroups
+	 * have IO running so notify the limit changes. Make sure the cgroup
+	 * doesn't sleep too long to avoid the missed notification.
+	 */
+	if (time_after(expires, max_expire))
+		expires = max_expire;
 	mod_timer(&sq->pending_timer, expires);
 	throtl_log(sq, "schedule timer. delay=%lu jiffies=%lu",
 		   expires - jiffies, jiffies);
