Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4175019-1526053211-2-4764684692416449826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526053210; b=HQ5YQNkiHp5nun7qhVq2t/dMA1KJKiNhbwE/jUHyI1/CdbpMMe
    TfgCX5I4TwcIGrtbNqznbBmwe5qZTWFQldAP/mz1rPk5rdm3lNyY/aEWHte1JAWi
    +nHQS0rCVe2ZLmyxK7aM+0yM2AsAMvUai7J3Whh0atV7xBYpyKxf0XLK8MN9DFZ0
    nixhOTKU0apWeCftc++hGRXq7aobJLx2vYgb6c/VrQOHTDTscfOb9SYx0sDGsZC1
    s9ipS9UgII0XQgV+kTW+J0nA+ADIUPvhHTBUJtQWCFo0F1sUi5AVoPI/OxdZzWeD
    0w/Z4POHtBsSvhDCHfG64iE//in+Tbw6m/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526053210; bh=h0NuoORhQ4iw1OKDb+Uji+4Njt54T3
    fzovJ5WmxmcI8=; b=NwJ9ANCOTNqUd90fOeAxyINqkwDGxy6s2JsIWGpUFs9rRq
    4v6cepzEpUoxp+DScFWoBTjefhAquqBjnBBwdw74tTKMiCBOjZTz7ZQaQG9CmHip
    qWhBFgZC69ybicpTCM/+/UK/acdexW/l2FYW18bPMCqkKNXF7P74A/hrBXO+WNQI
    bkvNuDJ5hCn0r06dGJR+iDFunoSKIomsFtz3J+tfE1Odl/hMQ15AZELKX5NWoYyS
    TIde+ZuiVTkwhaROBeCnriZdmLENZiedm5OTFP2fzzJ4NnwF4oUWeSg1cJ3xklxl
    pXyhBBwzoaVk6PQTENSDmTB2YMich98jcieIOsng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM0AHUv+rLI06PiX1ctwWXmufNS8PKK/EygHHxbR1q6q5KKnKfuNA88Hix+21vUT2hfmfwjAylvqTyUC52t1URz9qA5oI4Y+CbMlb7p4A7hIuAePYBZD
    HQ4tpI7TNeNzjpFL8h0F83mnfWiszF86t1wqGmkMNH9PVaoPxIGpjB3MTb43ZweXFCaCE/LJZCqOUXHixruArQYsXUFzB8FXdgYQI8fdB+2et1lcniWoULTs
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=Z3TViDYMNVcoLodJPusA:9
    a=xwFVHlgjZqdO3xLz:21 a=I0xmZmH6WzsuNfxn:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeEKPkA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 11:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeEKPj5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 11:39:57 -0400
Date: Fri, 11 May 2018 11:39:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: [GIT PULL] tracing: Fix regex_match_front() to not over compare the
 test string
Message-ID: <20180511113955.2a789dee@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Linus,

Working on some new updates to trace filtering, I noticed that the
regex_match_front() test was updated to be limited to the size
of the pattern instead of the full test string. But as the test string
is not guaranteed to be nul terminated, it still needs to consider
the size of the test string.


Please pull the latest trace-v4.17-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.17-rc4

Tag SHA1: cb82e07247fa5f1a91940a2928fb260256727a14
Head SHA1: dc432c3d7f9bceb3de6f5b44fb9c657c9810ed6d


Steven Rostedt (VMware) (1):
      tracing: Fix regex_match_front() to not over compare the test string

----
 kernel/trace/trace_events_filter.c | 3 +++
 1 file changed, 3 insertions(+)
---------------------------
commit dc432c3d7f9bceb3de6f5b44fb9c657c9810ed6d
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed May 9 11:59:32 2018 -0400

    tracing: Fix regex_match_front() to not over compare the test string
    
    The regex match function regex_match_front() in the tracing filter logic,
    was fixed to test just the pattern length from testing the entire test
    string. That is, it went from strncmp(str, r->pattern, len) to
    strcmp(str, r->pattern, r->len).
    
    The issue is that str is not guaranteed to be nul terminated, and if r->len
    is greater than the length of str, it can access more memory than is
    allocated.
    
    The solution is to add a simple test if (len < r->len) return 0.
    
    Cc: stable@vger.kernel.org
    Fixes: 285caad415f45 ("tracing/filters: Fix MATCH_FRONT_ONLY filter matching")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1f951b3df60c..7d306b74230f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -762,6 +762,9 @@ static int regex_match_full(char *str, struct regex *r, int len)
 
 static int regex_match_front(char *str, struct regex *r, int len)
 {
+	if (len < r->len)
+		return 0;
+
 	if (strncmp(str, r->pattern, r->len) == 0)
 		return 1;
 	return 0;
