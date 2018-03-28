Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBBGR57KQKGQE52LFIMI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1522264196; cv=pass;
        d=google.com; s=arc-20160816;
        b=md9ovpaMMoC0YKUHnxFx/K8OpKbro1UrfwH4WAJJ5yChAubupJdcJMnoTJCm5g9ABQ
         3k3ZzV1y5csXNyt3AcdbRGTe+l/MEpEIx+mrJfZAZ+JCXFhxFRyD13PYIbsggWPUmiib
         D5e0pxzcUYhpYrresJOfseREhpGkgqCCdM6mxe9dKfoUjm/nDl5kxCyAt9r/ufsPhCoN
         rKA7vIwKp40JbIZTEJ+KxZj1bAjCHYfx8Dshx9qmEQsDSD9B6L5rDkX+YxMfJQjVz1Kt
         Qu4DTfSpIbnvxqOOMrBrwrGsMVDMc8N6v3oYRHrOPxhytC/nwkXeJs1McNMQhOf4ar6n
         hdDg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=zcfJHOeU+xS0y2YPJHIB/xJO2wt/Vg0/TJKoaqU/FjQ=;
        b=UJbLIeY2gMt/YrMLTkDvKUlYWsD3O+I/o76XN5IqPPmXoKBMcceGJg7ULNYWzHzADq
         cqOr2kALmlf9rR4eqN6dn6diswDPh3mvCXA2+xKXuu+zqBA2AFPICJrqwA1ICRW5BBJO
         3PFIZUE7ADbINDYXXhnyL/n8zRpQrUxAEVmG3eYCzd7KV6sH4O4vR917m5cYaAxDzZZm
         d5nD+y8CseWgVf15wMJsFMUjVZAHUFDozXxaPTo/KFEJswSYs1fmlbDtE4FnPC7wh0+B
         WOnbB7YDdkIMXTY+xaD3gM6izmIHLzbeevvElAc51TS0IOp0ktKr38LcpDeyhu6gi/Ka
         F+/w==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Jg0OtR1T;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VviJ5xd9;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbbgr57kqkgqe52lfimi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBBGR57KQKGQE52LFIMI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Jg0OtR1T;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VviJ5xd9;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbbgr57kqkgqe52lfimi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBBGR57KQKGQE52LFIMI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1522264196; cv=pass;
        d=google.com; s=arc-20160816;
        b=qNR0Mj7NF1FFcRxkCbRxCf56Tbw/1Icew9lwcI5E2FFxTImfJjm/GAgL9ZpU1ghqIH
         YkZaWwYkxEv1agk0IQv9Gf/YrqEH5mCBRqlqMICwEUKTn+2kCzaLMaWaJqfrhJiJgbkl
         t2JCle+n6Oq/4XI9pTD6U48L3N2IY58NCmOJSgnFfbgp4dW793exkvsLNdjGuomL33XK
         YW7P8HmRVKt0VAhjSo8/Ey5fbzGuKri4SsD8KyFUtfNndTN3W77d58S3rm3qdBKpqRpZ
         J6qgDrvYUTFBlQzsIqQDWr4hzZhrZ1x878NtfxSGxzrUjTCt+4J9avLygeT9NuGJyBqq
         /3Hw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=zcfJHOeU+xS0y2YPJHIB/xJO2wt/Vg0/TJKoaqU/FjQ=;
        b=HhAR9t395Pao+K2j3x6KffZ8QA551b2ae03pfFHjVhYeI99EgBtJDEfxw/pMNZvpNM
         XP98nmNqRfnllZpsIJl10trw29i76dTGRWfP3wcZcMnNYpw6lpZi4z0JVF3MZzqspt0f
         yZFwSeTQl/nWmJan/XCgb0vQRbbsclGVNx+070K2WvCmr/abK3kxgOikFNkQfcytsMMl
         4fDxUsLga/S1HzV0dnU9TCi3TYoVn9vHkZxDVY04csI+rrQKiJ3ctS/AYCmotdkKAoVM
         Y2rbJVrviGW3Nb4qXzXKKFTdNOi+baopClWnVKPqUDbZUNToG82EaYgqoePCreZL6zCL
         DHRQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kVio7JQY;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELuYFzay1Z+7tvgNgbeugGjUc++vFLXZl7eTpmZwUD3hF/FkJJOrLWUqhpbCRp3AvLtS4dZ9hw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1522264196; cv=none;
        d=google.com; s=arc-20160816;
        b=uZ8jdplyBfgMO7vS4h1YAOPIEwaj1gtYoTUl7kmyfIFEdW7p7Xpl7aoW3ZDyuTAGWe
         7xrc2ENGlQRk0shrEXzR5zDBPBBpR5YottzcwRpGMGb0LyaLH+paOVKNBZZYiVTFV63w
         xzmp+j7uQDRm7Ew0aXlwwj4u/aimTO9XesDjl+TOwbs95G+kpkbR7xeCRttnLS4zDIDX
         EaEq950ldQJphQao8Je7GVHa8sXUVK1S2Vb74SEN5UXbiAJRB64vEBW+OhKv76zxz5/6
         YH1MON3Q9dBYWHPJt3+J5yY9786FviFJ4IKrLE/iicX/4kvfSCxz4y1C8tuaCLnELUV+
         EPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=aHD3PfvJXOfeSAhofrvTdBjPzvzwlA7MxUo0KMdRzao=;
        b=I8lxxOi9Ubd3oyZo8zftQSDGIZypTk04vPp8rJuNuuqHfr/dYc+wCpNbQ49wh30HFo
         qmWQHtKi3CXERZi21vamRXTtMkxH5AraObsCXxPU2rwELYV1f3tA9qOPzEFpC6n8/sOs
         qvRS4uuH8JfJaPYf2vcfWHpF+hL2kD4SkqaIS1e6kZgD3m0ESkgNCO1o/6BfgiNw0DdW
         /PeAbcgTrmiceEtPzKPzjwdiPXv0UC35rvq6EJh97o3AYpi34WT/vgDwFVtQDhfi+sJD
         ryV0cOZreJdtX3LBuy8+BYZg4V5kHHzg4jA60/ZcTWeftQAes89XOwVP6SKo5+fgMT0n
         2FDg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kVio7JQY;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Thu, 29 Mar 2018 00:39:50 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: pablo@netfilter.org
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Outreachy kernel] [PATCH] net: netfilter: Merge assignment with return
Message-ID: <20180328190950.GA3151@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=kVio7JQY;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c05::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1596209702586221835?=
X-GMAIL-MSGID: =?utf-8?q?1596209702586221835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Merge assignment with return statement to directly return the value.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 net/netfilter/nf_conntrack_netlink.c | 5 ++---
 net/netfilter/xt_hashlimit.c         | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index dd177eb..bfa8b7f 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1497,9 +1497,8 @@ ctnetlink_setup_nat(struct nf_conn *ct, const struct nlattr * const cda[])
 	if (ret < 0)
 		return ret;
 
-	ret = ctnetlink_parse_nat_setup(ct, NF_NAT_MANIP_SRC,
-					cda[CTA_NAT_SRC]);
-	return ret;
+	return ctnetlink_parse_nat_setup(ct, NF_NAT_MANIP_SRC,
+					 cda[CTA_NAT_SRC]);
 #else
 	if (!cda[CTA_NAT_DST] && !cda[CTA_NAT_SRC])
 		return 0;
diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 66f5aca..9e8ba2e 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -534,8 +534,7 @@ static u64 user2rate_bytes(u32 user)
 	u64 r;
 
 	r = user ? U32_MAX / user : U32_MAX;
-	r = (r - 1) << XT_HASHLIMIT_BYTE_SHIFT;
-	return r;
+	return (r - 1) << XT_HASHLIMIT_BYTE_SHIFT;
 }
 
 static void rateinfo_recalc(struct dsthash_ent *dh, unsigned long now,
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180328190950.GA3151%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
