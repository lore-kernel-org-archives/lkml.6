Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRB5EY5PKAKGQEJ35ON6A@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520094324; cv=pass;
        d=google.com; s=arc-20160816;
        b=OofJ5HIDhH66NpfXLh2gXUevPSVp/SXs93/l4O0ScPftaI5qjtYqied+HD/fpCtCtm
         ghV3ZS5oGsqD6MPCxJ0nSxvP9yPFoUokec4qjc7/8aWKbIbjStlAOW9kQZMBwuZMvgyP
         BhUnoTAjPZEqdg0xC+TEMDMxiUu1cVsQTDbjX16WhpeFk0yiICbA9UV0sSb5+kUdylVK
         KBWMA5g0EdVfH+r96xrIvINFsKF1BJwvOykQG3MAbwDjejYUW0qCgz4hWXron9oiSJxl
         6gFetANtMZJGsC5mENAHWP2gBqRUfUt2laO/3Hgt1bG2utO9DFNEfOXH9jAJgCKbImC2
         Exjg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=JmPGQOP2g3UVm8k5QrtCUpmUdjpJHzsD/PdqID5p0sg=;
        b=tqu36K5UEekaBCnDV0PFSDNNEPYXWD3djERK88S6zmcKx5Yt9kRtcCJr+kUAi77dW5
         1d+KHaj1DfLmQ7fJI4a1Gb05fkeOhUuPWosOeMi/efniq6l+iY0CdFvj8o/KnhwuXWJ5
         kCrWfc2iQ7dw9fREB/tMH3ugqXi5DHS/jRTcONYIFTUe/xYP2wCc947+0jw3S+bvVbp+
         dmgZcEWC7UVFbAkAxaa2eU1PXr7TWnJODeqFfpx14GHxGfV2WVohElvwEsiehUh4ih83
         fnQ4rpTagDdXvdzrJI43u2g5T58VnsiD8qMk6YhwI0H5wcAh7B6ewrCSVYCNepZWnrzR
         bYBQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=kIubnAV8;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QKcNgJK9;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrb5ey5pkakgqej35on6a@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRB5EY5PKAKGQEJ35ON6A@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=kIubnAV8;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QKcNgJK9;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrb5ey5pkakgqej35on6a@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRB5EY5PKAKGQEJ35ON6A@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1520094324; cv=pass;
        d=google.com; s=arc-20160816;
        b=BQi3dAAsQmALuAVpJf6fHFD6Dy3qzMHlEm3mbJOfyBF8YvA/HO19kvp/079Y40t+FY
         AkezycheCpP12JG8slUmusKkLn58GOircWe3MiMIbEpvXjslNYXiXmABUwgUQifHZ8Cv
         ZyZyU5Tttx50UxnAgnmffMkilf5J6OZKaqUZD9mRPQ7Zh3hbu+Mo/y3SVv2Kp/qxF4xz
         rh3pkxkieblCMnbg3+Hc/oXpgGMZofdNHbfNoyx/hsW0XntEyEHxYQNmjuEwjVgjbdIq
         GoCNg4nUxng4UNlyKh9U/25hLrMg6q54GXvD+U+wYFKBEzRcmGi+lDWwmWspDRLWZ864
         S2eA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=JmPGQOP2g3UVm8k5QrtCUpmUdjpJHzsD/PdqID5p0sg=;
        b=Of0wUGb58vqK0W4/DfDwjLCajEwVTfVA/iWeclucjvBq3+xn34fl92lc7HwAKA9oO1
         clYif/ieTuc0q0oy6xr+gDv5qCTZPGW9F0wIIbBAG+DIxbrGgqy9zQpixH7n5LA/1sKb
         gglPoRJgIenbbK91SoLhZ1f23UQgC69Kfnkg22ZqSQGYRGb3jup2w5MMWqqYyFCRqQA6
         oosWsPBJYM/cAlFzzNfU5C78J4Wv7BFRUEyP3HxuPBT0dMDwwpRoV0B4+YhIbNDvF3s4
         5mdZ+d+QQdCjCPFY2xPrpDJmtYW64R20cY4uOM0Fbwr5mt/nZ37sCKKaaDG27iLopkFO
         TPRg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HY1H7Ob/;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::241 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELsr2ubFZSO4KYFvyamwMNPbAekuhgedsFveIKawdC7iSp4z/3Fa37nq00/FIJA04UI7PjjQdQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520094324; cv=none;
        d=google.com; s=arc-20160816;
        b=YL7cWd7Py4HlYdKORM6VCmJ8faxZupVZk1p+9E9CYIjU02XMxNjETbuV46yrZoGn2y
         ox6E0oWo5mlpCY2bu5d4/8PKYcLkAoIojEzFt09gJ4Mr2Ept0mh2+mlwhVHiIYVC1rN+
         lKm3lrwWGdeq0dncdKHry0CFYHLiJimAZ/ogKcPTRzN1F4QsCwmTbXL5a0AtLHpbiNJ6
         t04N04fFHvkBlbOZu5i9/ZuS8GFlIyhltjY4gMYVXifZM0r8S82rCQHKbGYZEahz3HR3
         ck4VuLcMCAvh6ULUq0aidjw9q2VVuXiIJAnOAlSeSp/XAeZS1TcHS+1Sj96tF2db9i1j
         3FAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=jAoRDVk9MoJjPtavbOkBMRGgEROpWxXEBz5fKKpM5+I=;
        b=oiBtJ+QF2OrcMI8Aib0k2Q17AuxPc6UJWMWKB2HPu+OJMimDYcXzCGWUrT4MMc6t09
         vWWg7C63z3/Y/oPwhnYBeBCI1+QSL1GTfOM+Q3X+Jmw17PKx51TXeVnmKMA3ybdlY0r7
         wsI0H6kL6WLpR7Sy7lGd5TS2EXxBDcE/knVGVrwEv+VG6JVbcu1DTDUUjES+2QUZ7FRV
         JECRTn5siwSWMnT7LWUAVA8x4u025euBEo9Nt3d5iVNb+UF3pwy2xcMBl5Bw8ll7eiKx
         oCIGFL1AiJk7o9VOaek4ag03VowJqI686Ts0DS5jbOFLbNJGmjagDOHYROk7U6UcBgtY
         mZwA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HY1H7Ob/;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::241 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Sat, 3 Mar 2018 21:54:57 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dennis.dalessandro@intel.com
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] [PATCH v2] infiniband: hw: Drop unnecessary continue
Message-ID: <20180303162457.GA21730@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=HY1H7Ob/;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c05::241 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593934427022927872?=
X-GMAIL-MSGID: =?utf-8?q?1593934427022927872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Continue at the bottom of a loop are removed.
Issue found using drop_continue.cocci Coccinelle script.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
Changes in v2:
- Braces is dropped from if with single statement.

 drivers/infiniband/hw/qib/qib_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 3990f38..6c68f8a 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -678,11 +678,9 @@ int qib_init(struct qib_devdata *dd, int reinit)
 		lastfail = qib_create_rcvhdrq(dd, rcd);
 		if (!lastfail)
 			lastfail = qib_setup_eagerbufs(rcd);
-		if (lastfail) {
+		if (lastfail)
 			qib_dev_err(dd,
 				"failed to allocate kernel ctxt's rcvhdrq and/or egr bufs\n");
-			continue;
-		}
 	}
 
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303162457.GA21730%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
