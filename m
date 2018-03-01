Return-Path: <outreachy-kernel+bncBC4O7JFQXQFRB5MA37KAKGQEZ4YZQMY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519894646; cv=pass;
        d=google.com; s=arc-20160816;
        b=Tj2q7687rViVKfzGMhxGdNxlO1MaJHN2MTngZcBT2n4YW01kLGZQOHAWLycoWk6og/
         HtBmVDNb2tv399xizUIfBaosSVpRs/vkG9iI3sIwDZGV9spL2NJX9lygFZt2k5JeqxN7
         0J/VLPXn3eGaVzdCeqaiVLbXWXVsGETCPVy/Ia0Ssh5OgVs6f352v2/+2XVmh+cqzl2N
         jTUGGqcHRo5TN/3+B56YrPookHyLHiusnAo0A27HnOeNrzdVopDkp8D6cUBahDOe1G60
         kkPJ6+674JFzoO3rrwAXsO5NQAbtFZEPpbgY045Pc/7alqvd0ifleYVSpfr8pxdycg7C
         bYLg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=63AYGJLHdrgjTO8rCQVjw3zqjDAq0mi785LNk7sbhtE=;
        b=d7vgFdWfDNdsckKcQTiic2zkXJcpYvJk5CIWulHESO+xUFcn+Y0UfnZomAHNW/k5vx
         hcPJ7+ImbpZOzdPEJp86KLqomEz2zAz0b8VJ3zhO4ZkL/o26Br4enL91Pv4IyMvBUsF0
         52IdfrMB17AJln9Al8+tcTPE0PZUu8yUayQZRY02f87+EOFbF9WapqMKb5Akp7S0zjoV
         MG5ph9z++Bz5vEWvFpEQfEBBnc+iSdzXF14g9EadE92tL+nSxn91bfv9Q1US9Sh/pk7g
         RCwp6d1xx27JRvvVQA4Pbtdd73NQlHv1fzj5VdBfe4IZt/nnvwpj5NlSZ+rHN3Abdfko
         0LNQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=R7dgBGTF;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QYXHMOqn;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbc4o7jfqxqfrb5ma37kakgqez4yzqmy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBC4O7JFQXQFRB5MA37KAKGQEZ4YZQMY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=R7dgBGTF;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QYXHMOqn;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbc4o7jfqxqfrb5ma37kakgqez4yzqmy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBC4O7JFQXQFRB5MA37KAKGQEZ4YZQMY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1519894646; cv=pass;
        d=google.com; s=arc-20160816;
        b=NLJPBT5yVqUQga+XEETns4fJUVgHvZML1o8WGQFAXHG5Y61LRfCi0j4ueSek9ZK4/K
         px4VUIHks0MMa6wf0fmp0fyasEu/15EJKmLG6FwpXKS6L2yRTaClBAPI0jCmQatk8FVm
         dSOgEQeYQeyvjwAhKyFf8ACBM0rgFPOa7RY59KaCua7+2UrXuFPHouGv+/Enf7rqt2GU
         tm2a5ETrV+mht9pn7Z9XcPDbFyczhfLCOYVO8o7AFSSv2zn5xx0b4nBj5M+xUkjNACgs
         hZppnj569b2faymEhO2tRhnZum9XeXtFl6oqdX2din2djFPkfz+cPJKvFH0nCr0E9dAA
         fY3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=63AYGJLHdrgjTO8rCQVjw3zqjDAq0mi785LNk7sbhtE=;
        b=lQJvzfw0su1bDeMRfxkzW55OesO1ViHTi9XnMOp+6bDnS+2c5WHFs+cpbGhL0IQ3ZV
         y5zdgkeIdxP1A2zicxx53VY2VCM7dWDxU4Pf75un3VAy9JLp50/04oi/F9CIQun50xN8
         ixPX30erahuWvnDlXDSxNOktKHFYusw0bqtjLAkZnDuj1UOB7lhdEmyLSRD0hbLJtHV0
         1oTPTlB3Zd7ClZuk3RelxQhWqFDPr12OVRti+EOUkgMhMhDfDMdKbTIMLoJwZfcjsd1p
         lGk4cLOZmeBoaoYo2fI8w0BWFtNIzKXzpLalREDIrS60XtA2RAYkhFLURGKx2AclSSd5
         4VjQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QB4Y9cJU;
       spf=pass (google.com: domain of dafna3@gmail.com designates 2a00:1450:400c:c09::22c as permitted sender) smtp.mailfrom=dafna3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELva7ttP/lus+VGAm2f6vwpCZd6T/CN4y8JYX2JiPr7QrhDKXw7h/7RV1GaveMtRO0z+5tQ3HA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519894645; cv=none;
        d=google.com; s=arc-20160816;
        b=BGUVNYNfD/v0T10DipKAArVwt5JlJsT+VQyeAabSGlnWthW5esmGeTR83OuxT8Nkn7
         nRjiJSrNfSPCmrmsWg2H1zkBGSDzwluvpRghg3zqsPqqhRnskGhbdnslS+EFArRZdzfL
         qbh/wTItnkME7Vno6TvvZ5rR5M/9XFKyPu6BLz+kuzDcP3Q8MuIbbAAOkU0wiRhp1bpN
         Xz2OLfCc46kr5quMXJSB2i6nH07cVZOa/cfxfUrEqy4q76ODYQPa1ZLeypPSYzSRhAK9
         ldtpSmXS6ovaI2FygRnW/Yw+RyUI5F7ccVwaK1wZVlujaWw3TQtZ+h2aMvCL3HN22gHB
         Ky9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=SD+fg8HBJsn6GE9PdO4Qs0QUv/WL5Hd4jfnxAOv3AWE=;
        b=cPLGMSRxPe8A6Bb6j5fBX6Z1DwOjRItv/BcKx6FHX1+635gW+7cv+Y9LVARH5bzcLl
         4ZbE4mlot1lnqfOktC7tQLolE6EhjgKPFDkstA4Zaskxq/yFX36HrGZq8uRqhR4WhGdR
         c8umLmCHODEcm8KoxyW/IQYiMfv/rRFOm1oePH04ljEGuY1LHGRQpv4+G5/O+0WJgL7h
         rNEtySnY2afOdjWj/OQC55UEJ5Mvttmq45tV+tZ/tj4S4duHQ7NTc1kSNfUCuhAyZ6YN
         3YsHVe8OUVJYvUZBi5LDRLI0+sp1vsrv77iauwItsq40W/VxIejNr/2GF2lWsOe/YAd2
         7+hA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QB4Y9cJU;
       spf=pass (google.com: domain of dafna3@gmail.com designates 2a00:1450:400c:c09::22c as permitted sender) smtp.mailfrom=dafna3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Thu, 1 Mar 2018 10:57:21 +0200
From: Dafna Hirschfeld <dafna3@gmail.com>
To: Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
	michal.lkml@markovi.net, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] [PATCH] Coccinelle: memdup: Fix typo in warning messages
Message-ID: <20180301085717.GA4508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: dafna3@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=QB4Y9cJU;       spf=pass
 (google.com: domain of dafna3@gmail.com designates 2a00:1450:400c:c09::22c as
 permitted sender) smtp.mailfrom=dafna3@gmail.com;       dmarc=pass (p=NONE
 sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593725048662035735?=
X-GMAIL-MSGID: =?utf-8?q?1593725048662035735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace 'kmemdep' with 'kmemdup' in warning messages.

Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 scripts/coccinelle/api/memdup.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup.cocci b/scripts/coccinelle/api/memdup.cocci
index 1249b72..8fd6437 100644
--- a/scripts/coccinelle/api/memdup.cocci
+++ b/scripts/coccinelle/api/memdup.cocci
@@ -56,10 +56,10 @@ statement S;
 p << r.p;
 @@
 
-coccilib.org.print_todo(p[0], "WARNING opportunity for kmemdep")
+coccilib.org.print_todo(p[0], "WARNING opportunity for kmemdup")
 
 @script:python depends on report@
 p << r.p;
 @@
 
-coccilib.report.print_report(p[0], "WARNING opportunity for kmemdep")
+coccilib.report.print_report(p[0], "WARNING opportunity for kmemdup")
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180301085717.GA4508%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
