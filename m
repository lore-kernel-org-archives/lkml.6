Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521483963-2-8194532550260672768
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
    t=1521483962; b=NhJlWcBy9yQnmeGeCY4/fkDsgVzmuKsJUPSfuiALcSJ1ouj
    T+P/PFqg0ihAhtxp7p1jOjFBj7UYo48ZIq16MTB+ijvbFv4xyFGry6r+Zui7NhZz
    IbzgzQxMx1Oe7VBRxTovptRUKWajzYFWXDHBNZunttJM2v/de/2+FeHZpXdIT1QR
    A5xokzwiXh1N88edPPwR6hPV8HFrMAHhPq+D+HmnvxX4u6e2JC9WOmaLyNhy7E1U
    g7EDzKTdcBWIyFnLHrP+QPfM+HNTZlliNw3tH7j+koPo3jUWHUf+FaL+mza5xZd0
    x/X3iH/0IyNQ3H3QzgtLpAYamUtMCBJLOG73ifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483962; bh=u4KqlKwOPy3QjUH9IIOY9EWkzG
    JDadvVRn9QKkFLOnM=; b=Svff8lZ5t0HEvr60qZ7IunrbQMdGUISrOkuzcFsLV2
    6UodmfJ0CkodCXb5vP1pAoMaGnKP4rOMHZBzSPt7hLxkBsImMP2+0k+U9RPUIqk3
    RDGO4JIdeBM5m1Sva48njUZLo7J1qmdYIbGqxZoVGrO0X7R1xDc5KzfSm0UrE5M6
    q0PQFoCjfZk3vTiR0e3mqLHw3YOkTdlbwS0xRQMfb932B6ywEJVUVuCAuqyvf/jH
    5e0d8hDUEJYRlRWCZBog9J17e8fgFPUml1jbGropF2m2wmrnh+Cr7izMK/nnX6Wn
    bZlCGAPnD4EBkjZcahE0b4ZnPNtunmQQNLlR0oeVX6OQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheegtdeinecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheegtdeinecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969828AbeCSSZ7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:25:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969822AbeCSSZ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:25:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Simon Que <sque@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 144/241] perf inject: Copy events when reordering events in pipe mode
Date: Mon, 19 Mar 2018 19:06:49 +0100
Message-Id: <20180319180757.148507572@linuxfoundation.org>
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

From: David Carrillo-Cisneros <davidcc@google.com>


[ Upstream commit 1e0d4f0200e4dbdfc38d818f329d8a0955f7c6f5 ]

__perf_session__process_pipe_events reuses the same memory buffer to
process all events in the pipe.

When reordering is needed (e.g. -b option), events are not immediately
flushed, but kept around until reordering is possible, causing
memory corruption.

The problem is usually observed by a "Unknown sample error" output. It
can easily be reproduced by:

  perf record -o - noploop | perf inject -b > output

Committer testing:

Before:

  $ perf record -o - stress -t 2 -c 2 | perf inject -b > /dev/null
  stress: info: [8297] dispatching hogs: 2 cpu, 0 io, 0 vm, 0 hdd
  stress: info: [8297] successful run completed in 2s
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  Warning:
  Found 1 unknown events!

  Is this an older tool processing a perf.data file generated by a more recent tool?

  If that is not the case, consider reporting to linux-kernel@vger.kernel.org.

  $

After:

  $ perf record -o - stress -t 2 -c 2 | perf inject -b > /dev/null
  stress: info: [9027] dispatching hogs: 2 cpu, 0 io, 0 vm, 0 hdd
  stress: info: [9027] successful run completed in 2s
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  no symbols found in /usr/bin/stress, maybe install a debug package?
  no symbols found in /usr/bin/stress, maybe install a debug package?
  $

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170410201432.24807-3-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/ordered-events.c |    3 ++-
 tools/perf/util/session.c        |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -79,7 +79,7 @@ static union perf_event *dup_event(struc
 
 static void free_dup_event(struct ordered_events *oe, union perf_event *event)
 {
-	if (oe->copy_on_queue) {
+	if (event && oe->copy_on_queue) {
 		oe->cur_alloc_size -= event->header.size;
 		free(event);
 	}
@@ -150,6 +150,7 @@ void ordered_events__delete(struct order
 	list_move(&event->list, &oe->cache);
 	oe->nr_events--;
 	free_dup_event(oe, event->event);
+	event->event = NULL;
 }
 
 int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1628,6 +1628,7 @@ static int __perf_session__process_pipe_
 	buf = malloc(cur_size);
 	if (!buf)
 		return -errno;
+	ordered_events__set_copy_on_queue(oe, true);
 more:
 	event = buf;
 	err = readn(fd, event, sizeof(struct perf_event_header));
