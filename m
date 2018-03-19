Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482967-2-5259794600100033129
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
    t=1521482966; b=vbJx/vpq6c3Ij5doQVh8h+M8owUj6PeBHXvQ+7Lq3uqPrzd
    orN/kfmUG85Fbeq9angMyJaNTcAr9R/rW2CaHntTwOZwedwd3i8KkX1xSF1tz1yQ
    urDqhlvzy2VZ3/oRxC/mpeud3XE9I/V7E/hU89cRy/549VBSMeCya2LK3YyxkHhW
    CD3RzgA2utApbJuXq6bNOF5qPN0myIMSmBSzNkcdqL48Iu8DwH8mMFK+OJfwFPwT
    oHyh7J16h2Dc+ybYEIfCA1+Acy9pfLV6xmNwugnCYALw5VhBa/IOBgrqG51+Aia/
    9LepSl5fHyULfEw9O3wlYkjfIEuaPdbZGGl1Bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521482966; bh=zlJzth8yS2h7SwGaL11E7uHNaE
    /04w3Q5cWph0eheWM=; b=XDsSPE4KussBsjttcZofomnwFKNoP8CKCRKmNUojY4
    9u7SlKprto07/9+/KjnKY7gQS4lTB8YetHjuGLh9GG7UX+bGAe0MjEr7Az6vMjJj
    m+2lh3QgEcQN2Zo1kXY0mFiJfe6hcIAHBvXx4qgX2WHM8coqmAQ23STcnq2eKV/r
    i27QIx8LfB0k6RUUOax8nQzoZU7uRC+MZSD2ibtdw7L8C1qR6sLf06IagDF5OM/c
    jUX0mKuurK7bfKJr6+IGWnIh++tmZL3zDhXkDefkk7yV4byjpdAFhYf/3jipf6mL
    L1/0YLAb5rh7rVZzV8FgXI5QJIVWkovNkrmiF7gLjePQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvkeeiieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvkeeiieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968630AbeCSSJY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:09:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967162AbeCSSJT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:09:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Engraf <david.engraf@sysgo.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 16/68] timers, sched_clock: Update timeout for clock wrap
Date: Mon, 19 Mar 2018 19:05:54 +0100
Message-Id: <20180319171830.147593353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Engraf <david.engraf@sysgo.com>


[ Upstream commit 1b8955bc5ac575009835e371ae55e7f3af2197a9 ]

The scheduler clock framework may not use the correct timeout for the clock
wrap. This happens when a new clock driver calls sched_clock_register()
after the kernel called sched_clock_postinit(). In this case the clock wrap
timeout is too long thus sched_clock_poll() is called too late and the clock
already wrapped.

On my ARM system the scheduler was no longer scheduling any other task than
the idle task because the sched_clock() wrapped.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/sched_clock.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -146,6 +146,11 @@ void __init sched_clock_register(u64 (*r
 	cd.epoch_ns = ns;
 	raw_write_seqcount_end(&cd.seq);
 
+	if (sched_clock_timer.function != NULL) {
+		/* update timeout for clock wrap */
+		hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+	}
+
 	r = rate;
 	if (r >= 4000000) {
 		r /= 1000000;
