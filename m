Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608381-1526631454-2-5395887730900621614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-asciifr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526631454; b=Aoc2yDFS4cPXGp1/1XgIq6xq7AenZs3Wj+HEplApXnng5apSA/
    bJdIF35pu4MqKdXx/VkIWeSRaB+QSS5DyFfrUWE6XfGS2+8oUS4n9MUB9Mb68TG1
    TKlAdRACfAP94Q+oMxHGmLSpoFatyxgmhQKrAoxsUeWQ3BZgVMmgeTwDdxq30Ko+
    HV8pwl+d4Y379/SosVpVeCL0lGRHxVk4wRXckYSVyVSR9yPZVgaR5giyIp+h6NTX
    qQQjRtQhVytuqxRS4n73N0dfUTNst2XUMV7O2VaUphbzxmVmbNCYctXbdN9G6BlN
    MKuVWXbQqWZzXEFWJozEsb91GB9sfO+mJSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526631454; bh=LoTW4X0n5A2VAPDmcvCq6zZ6q+ltu+
    oFAtwjA/qWqTU=; b=RCLQzg0+yGR/P6PJk50HSubtV/nuTr2/8VzVKRZ6cR7G6H
    k4HitUpFUggOfl2MVP27o/VuzFN7ePw2fTLVnK5ZcG4has+B3bc+UYipaYt/10KW
    n6usRMGOrA7WOHxa5Fhpv/JI57BWqUVB9cbHq0+z4heGvMcNrXZ+BLk3aVHQ33Rs
    lYkVrbwzIlac20l0Le9K/93wDoQwxzdS2IJubYDir+ymTebYZosHF2sA/rNm1PjB
    /Mtivcmk0HkcsynVS5KHq8ZN+/aagkf3vesoMDfS/aVIpW/VgzfCAYLCIkbzhohV
    W3Hbjdhixe2QWqXQvE6ioKHWfuhkuMT6LWzC6m0Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FnmxoxPM x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FnmxoxPM x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHH6Soq9NQprwA6kNkt5mReCnZdj58DOEiBqZ6MgHgu5To432q5J0huN3Q8jBwTduArBNtiOnUwmlzTzStQMg8mHBYNc5odhbXd6yN8AMlRY/c3nWxGp
    2I7RMw6vchTJQEqUj0j0MR4Lfwfe6hPguxgNzxXPS1FIFanSq2Cs3bC9Kg40XiEBjpofKdbgbgPbagZUB4YGIi7y0SSS/e6812n3G6VWKxYKA211l8opW71J
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=2jGULyhPSjjowrF_JfMA:9
    a=mNOxpiC4zmwkzkjb:21 a=79x0wBomllWRMlcT:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeERIR2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752564AbeERIRX (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:17:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 14/55] net_sched: fq: take care of throttled flows before reuse
Date: Fri, 18 May 2018 10:15:10 +0200
Message-Id: <20180518081458.172616328@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7df40c2673a1307c3260aab6f9d4b9bf97ca8fd7 ]

Normally, a socket can not be freed/reused unless all its TX packets
left qdisc and were TX-completed. However connect(AF_UNSPEC) allows
this to happen.

With commit fc59d5bdf1e3 ("pkt_sched: fq: clear time_next_packet for
reused flows") we cleared f->time_next_packet but took no special
action if the flow was still in the throttled rb-tree.

Since f->time_next_packet is the key used in the rb-tree searches,
blindly clearing it might break rb-tree integrity. We need to make
sure the flow is no longer in the rb-tree to avoid this problem.

Fixes: fc59d5bdf1e3 ("pkt_sched: fq: clear time_next_packet for reused flows")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_fq.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -128,6 +128,28 @@ static bool fq_flow_is_detached(const st
 	return f->next == &detached;
 }
 
+static bool fq_flow_is_throttled(const struct fq_flow *f)
+{
+	return f->next == &throttled;
+}
+
+static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *flow)
+{
+	if (head->first)
+		head->last->next = flow;
+	else
+		head->first = flow;
+	head->last = flow;
+	flow->next = NULL;
+}
+
+static void fq_flow_unset_throttled(struct fq_sched_data *q, struct fq_flow *f)
+{
+	rb_erase(&f->rate_node, &q->delayed);
+	q->throttled_flows--;
+	fq_flow_add_tail(&q->old_flows, f);
+}
+
 static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow *f)
 {
 	struct rb_node **p = &q->delayed.rb_node, *parent = NULL;
@@ -155,15 +177,6 @@ static void fq_flow_set_throttled(struct
 
 static struct kmem_cache *fq_flow_cachep __read_mostly;
 
-static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *flow)
-{
-	if (head->first)
-		head->last->next = flow;
-	else
-		head->first = flow;
-	head->last = flow;
-	flow->next = NULL;
-}
 
 /* limit number of collected flows per round */
 #define FQ_GC_MAX 8
@@ -267,6 +280,8 @@ static struct fq_flow *fq_classify(struc
 				     f->socket_hash != sk->sk_hash)) {
 				f->credit = q->initial_quantum;
 				f->socket_hash = sk->sk_hash;
+				if (fq_flow_is_throttled(f))
+					fq_flow_unset_throttled(q, f);
 				f->time_next_packet = 0ULL;
 			}
 			return f;
@@ -438,9 +453,7 @@ static void fq_check_throttled(struct fq
 			q->time_next_delayed_flow = f->time_next_packet;
 			break;
 		}
-		rb_erase(p, &q->delayed);
-		q->throttled_flows--;
-		fq_flow_add_tail(&q->old_flows, f);
+		fq_flow_unset_throttled(q, f);
 	}
 }
 
