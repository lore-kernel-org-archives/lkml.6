Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2323979-1523448316-2-1101132338528829382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523448316; b=uNS4oH4Rrpb5wD4NBIo3lM6PZVu7BUr4lpn8g5wDvPUW/7UuMH
    nA6Z5QyBYHn9AXcNzsk1ss1+yk0KuALvlnBAyS1WxGqobluetgOBMN2QfuPPYpdq
    HUKLVHxtvtQH4i1xaXe4RtV2oOLBTJE7MyHHQ/7YVtcpQHHRZFHoZXEPqDwsOkcC
    qFetu2Zyc+BTc670ieG951zZZoJKnj4EuVFF8dZblIdv5Zp4e7PzPDd3W8ZY8lWd
    axY4dfbUkyYbE5NnhE9Gzy+vfhi3FDDgL2hLQy+s0QnH8tjHFUSxBjKadNXH2mBY
    EUhRATNc0NN37wZM469v14BbXqnUWuU1zCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523448316; bh=VAPcb/QDAZJbRJChyXtAcPVnIW+KXW
    +wqQbPFzblf/E=; b=neTDMsdreW3sC+EVtgQmswg/+rRWbe48iqA3YbeF/ey0bg
    nwvzu1UWvS3ykyYG0pEX2oNMm4Jtdew5zbU4HtFnSqIra/iunurkJXsyVcRmuTRL
    JZQQmAyEz4lgUTFL1DC3xmp6WmCD+J7BApewp4XYzqZaIFkHqKOuRy/+lAPdHW+4
    IbUYv2vpbzm+7ObfOKCVowJnclQqInxcFjg6uAbsC926+Rme4TfrfR+KRLoSRa/8
    IR+e4CuNaAP4+Bjh5YrJkft/8H9DxH5RcDl1RJBXooMGkzJNChvKVmxuKuHRX4mn
    9gTIOdogPeuvpVV/8H++K+6TrTpkFQU6eLkLIKtQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TDcMxW/v;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TDcMxW/v;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFKYbKEmLQWc5ojrfhnWxlHnyiQtzdP1Ro53p/8ADFsMmcAaF/8bMXl2d2vvM0W6rZVeCK4FdUZQl1m/3iEpDONYUfbMMzVo90ImmI7DCO3TQ8HUyeBH
    Vd4YytR6a03E1ub7RbscJrSa91llDN3qBCFhjGtb1eKpS9hXPaRsnFv/9dgBWEZj1uMzNWrmHsAjlkcuEuOmSWYz0pRnURKi50yaMNM/0XuPZ3YjoN1TTd3i
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=iox4zFpeAAAA:8
    a=Ikd4Dj_1AAAA:8 a=Sg8HuZxHAAAA:8 a=VwQbUJbxAAAA:8 a=PA4w4cHJ8sEsxPLxBqUA:9
    a=clCsiY32ME67_s2E:21 a=XvOnIK02oOAl-c3Y:21 a=x8gzFH9gYPwA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=JFlNBosjgyz61O-hmi61:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeDKMFC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 08:05:02 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35257 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753093AbeDKMFB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 08:05:01 -0400
X-Google-Smtp-Source: AIpwx480PWZpGGR9DasgJ8qgN91SI06LNunU25cneiLmr9xvkt0dkBwCQYGQzLDyvad5qmQi9wNnLg==
From: mhocko@kernel.org
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mmap.2: document new MAP_FIXED_NOREPLACE flag
Date: Wed, 11 Apr 2018 14:04:52 +0200
Message-Id: <20180411120452.1736-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michal Hocko <mhocko@suse.com>

4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows the caller to
atomicaly probe for a given address range.

[wording heavily updated by John Hubbard <jhubbard@nvidia.com>]
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
Hi,
Andrew's sent the MAP_FIXED_NOREPLACE to Linus for the upcoming merge
window. So here we go with the man page update.

 man2/mmap.2 | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/man2/mmap.2 b/man2/mmap.2
index ea64eb8f0dcc..f702f3e4eba2 100644
--- a/man2/mmap.2
+++ b/man2/mmap.2
@@ -261,6 +261,27 @@ Examples include
 and the PAM libraries
 .UR http://www.linux-pam.org
 .UE .
+Newer kernels
+(Linux 4.17 and later) have a
+.B MAP_FIXED_NOREPLACE
+option that avoids the corruption problem; if available, MAP_FIXED_NOREPLACE
+should be preferred over MAP_FIXED.
+.TP
+.BR MAP_FIXED_NOREPLACE " (since Linux 4.17)"
+Similar to MAP_FIXED with respect to the
+.I
+addr
+enforcement, but different in that MAP_FIXED_NOREPLACE never clobbers a pre-existing
+mapped range. If the requested range would collide with an existing
+mapping, then this call fails with
+.B EEXIST.
+This flag can therefore be used as a way to atomically (with respect to other
+threads) attempt to map an address range: one thread will succeed; all others
+will report failure. Please note that older kernels which do not recognize this
+flag will typically (upon detecting a collision with a pre-existing mapping)
+fall back to a "non-MAP_FIXED" type of behavior: they will return an address that
+is different than the requested one. Therefore, backward-compatible software
+should check the returned address against the requested address.
 .TP
 .B MAP_GROWSDOWN
 This flag is used for stacks.
@@ -487,6 +508,12 @@ is not a valid file descriptor (and
 .B MAP_ANONYMOUS
 was not set).
 .TP
+.B EEXIST
+range covered by
+.IR addr ,
+.IR length
+is clashing with an existing mapping.
+.TP
 .B EINVAL
 We don't like
 .IR addr ,
-- 
2.16.3

