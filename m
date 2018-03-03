Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBFOW5LKAKGQE3LUW5TA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520085781; cv=pass;
        d=google.com; s=arc-20160816;
        b=KADAW/PZWRtu/gZKWlYjQLRgZryaX4zE0Yx9IhdRW+tR/5IQGM/r40vmCYdN/XhFNO
         eBRywVovkaal882JlnuYLOnf8duaU+WjCKqq5eLq/6ow1YYzN5oclQOL+F96Qj1uMQCt
         29M7lKDc7vYUsjvmuxZ6FHu8jdhk80wK76YFogiGg00tRIBW+VMFaW90tObEgA81WE8R
         OV1hPgrrZM04fGX6nrZDcrNitDx2h58CYt8H9IMYXIcu5LOc6/gM8tzJLxuURCVgjtgK
         1GOkLjHXNkArQkH6lZHqLLUdPA0lZLGMkZ7BS8rasEITHrOC6pR+JCiyrsuM5V9CgExy
         43KQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=HD7+5F8K/fiG6Xx6TxMjNkWTzr3/g9VvEny8fMFAgcM=;
        b=JKiNHysm5eoLyefvQURly/9dMf9bOU88JW7s+vvHwZFmD6tEMDEWtG89zJJ/DrRdp3
         vIB5lN5A4rGeNa6YSWy+zA+N8qE9H6KPK4awd05sFHJLBDOCXjycG0uiMLMECwdau9mM
         KEYFOPk9w19aUeot7732QqZivZMaX35CSFC9sy2BdIUPLKfnqa3wJzBJlCCcRnaJic56
         4oDU+HwlrQcgdJJ2OzaWlUPLljL7dUVt6DtryNialS4eh9KaF2aXk8C4TsxiHw3VVQRU
         ZAD1K05jdayqq0omrh74lWz65JgZDymtDF8xGIATSAX21V4ebKucULTvAuZfvcUAuH2U
         pRBg==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=brsnESaq;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ef1FL8JB;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbfow5lkakgqe3luw5ta@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBFOW5LKAKGQE3LUW5TA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=brsnESaq;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ef1FL8JB;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbfow5lkakgqe3luw5ta@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBFOW5LKAKGQE3LUW5TA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1520085781; cv=pass;
        d=google.com; s=arc-20160816;
        b=VogfZhtjSUX2w+aO9hiI2UI5Syn5wCyZPpEuUEOHaGe18x1cdM2YaeAmc/JmWSYPmW
         KNL6sP35yhgmrPMHHiLzTQabFgukoitWR31fAxQK1Nf7+coOv8drWyIXNWME8dOzOYjj
         Kpxtz04aZ4DyfO2atJqezxVVGCF6yxEHRcz+REwICrfc9xj95VKff8TX+M2qVV+TXRTZ
         n1HzHaDQuQuDjPhVaP2eaUa3CGZNy/J4RbMUgpvJcp5qetr++fmIn0qN0U0VSPBTsGWN
         g3Sq2Whh7DStlVVIW8+CPVTYqBM2sRar+ACsolstc5WyiuyLRUGaG+6MZnOdC8PHyqAV
         vLng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=HD7+5F8K/fiG6Xx6TxMjNkWTzr3/g9VvEny8fMFAgcM=;
        b=uunjHQ83gDWF3cQNVgpuN+4EJhwC3QINiAn1pSL01VN4OCr9zygUtsXXXMB+FxdubS
         VI+bEVr/BaCr+Jf2awaAmUeU6YubeMx3chS+3AtZjSc5NDjXAgxJOuwXXayYnrkxe+v9
         DkU7b7d3qLofPu0E5FQNHqnsxK61PaiZShL4ScJ6o697iypvwKbw7O5MqBbWR+F7Ey8J
         SS+1MpMEXKvHJHeONyUcye9/mVcpZ/7nXE39IeyaYz/OUcTGU7G9K7H7tviaiT2g0XsW
         wx7v/wH+fpCDq/mN7ac71sA2SUgjTMhtWekeew/+5iJvyOk5lsrrCfSmxw8a4SXdV9Jm
         f0HQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ER9jmqXj;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c01::242 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELt/dIJDrgow/BH7NDssrG9JGVSCQESdjQ+Xp9sGrq1W95E66c+35wrxgQmI18XQQmTKD4m01A==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520085780; cv=none;
        d=google.com; s=arc-20160816;
        b=HUJmY73RWfCsBqcJR4TaQg062/H8ZaXTIw2NZo3Bl4Yre9ERha/JIxB0Orn13lsp9o
         zwxgEUp9Slb+p+VKSuIyUT9icbD5hkP0pc5qJacetTS0Lv9fL/oxJ+9dfVNcRGkyXtyA
         3nTKVlnhf91TF/EfBAXZzm4pbm+ribuoYR+FhrdoP5pIxMu68MHfBdXFk1obaUdMDEvB
         v7rbtlc1iMECxL4YrczQFjeyfKgY3jiE9CLNfyQh5MvLiniFUc+6i5Cs7iFlSxlccksp
         Lkz5laH8TZsnS4yyeGohCVaYLq/YUIy1RjwXrAQHrJOMtv5zKnBdpNTHXzNCabd+nuoe
         vIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=IJh65k/VwyEPUk/YIa+GbIL5NJYiFGUgwl6s4o/vvSA=;
        b=mSUpfrzUVLjHaX5cM1DNZlTQwv4wI3E52UcKm9Awy/pSz1XFszcaG6Z+lp9hBTRr8U
         8miky67oC72Pv00S9KO7xtwM6BhBzPsL4Vp16LYVaACUCa6x4P2mCGSFpQ8Bxa0KY3Z+
         YxIZjLL4YDMcgbyrZ/LV27cb3qfJenXEjgbLIYF8XHF7PUBnZtsanpd3wWxGMaQQT52v
         yPT/NI11BJkXXc33ZGpxIIq+F+jDrlA2DJbD6h7CzohdLTfN/wIEb06ftj6JpXkZD0zw
         cv9WkMpPP0eWPVJm9b5/KsmoH5QuFP3AViMs7QgYl66tNgqpWaebLHLValWxNfmQvq1N
         IvPA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ER9jmqXj;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c01::242 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Sat, 3 Mar 2018 19:32:33 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: boris.brezillon@free-electrons.com
Cc: Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] [PATCH] mtd: nand: Added spaces around ('=' and '<')
Message-ID: <20180303140233.GA9634@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=ER9jmqXj;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c01::242 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1593925468888777014?=
X-GMAIL-MSGID: =?utf-8?q?1593925468888777014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add spaces around ('=' and '<'),  to conform to the Linux
kernel coding style. Issue found using checkpatch.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/nand/ams-delta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index d60ada4..9de6572 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -94,7 +94,7 @@ static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 {
 	int i;
 
-	for (i=0; i<len; i++)
+	for (i = 0; i < len; i++)
 		ams_delta_write_byte(mtd, buf[i]);
 }
 
@@ -102,7 +102,7 @@ static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
+	for (i = 0; i < len; i++)
 		buf[i] = ams_delta_read_byte(mtd);
 }
 
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303140233.GA9634%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
