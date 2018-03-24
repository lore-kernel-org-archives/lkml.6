Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3118605-1521873671-2-7380870943623910976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521873670; b=sq2pTSgDnpIZ5vT+xgYZ3fAwrrrnQmrJ9JOqr7E3S9d/v6Y
    cZhx4CdRYqTgvQ5ItyWeFMMuNsTb4ft1/C8m4RWI6dQ1ZLbXS9ldRqsof/QIialM
    3ZPCJ7YFvuVbfpepZZ55ODXTXjtwQnsg+G+sxDookrs/XLGqmCqtqt+Bw8IvB0l2
    U2mYBsKcYA/Ib8L42I4+fYy2qtLFcNM4qjGnzKX7ltDm5DKIC9/DcxLzN/Js8x9D
    unc9hhJQc6bFwi8IKmR+2WPQ2nSHXcyGOsy7W1Q5wr/fiVHTYFVMmLEARhSLpF+G
    DvTuYM+oqdtGgznR/nPzmjgm0+M6jCzSvWTNJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521873670; bh=E
    5kwUisPlJKGQx1NXOztOtI81pQyNDU9Oy9Enjw/g7w=; b=bhktaNsfaKxVskS7j
    4fRwOyYHlfW7hNsW1BKJxi7mfPBGQUxX2Qsh7EPJRlBo+81SL2T4RdWDhFRjCndf
    eWS2qAssrsOrZqZx2K7Y5bnhFAfujVii/IHGfuj2OA5QQ34JucgeH/wVnrh/4rTe
    kq+bewqrlIp0g6c6tC8Ym3L24ky3GFZuwrsjQBh3ArRCSVFruMUSyrBOFeM4UQFZ
    /qpwv+HhHvTu8LXJKUapMflsfmh9ko6XXCVJLkMv0IbgmAXSCxGrReGdfV7rfxm3
    Fq5YFjrLyD839ZUTAcjS+6G3plRdXuC+hp2+aYIQIe0FhrgZpdmAQz3lvtkrVI9N
    GTsRw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 2/2] staging: ks7010: Fix spelling mistakes.
Date: Fri, 23 Mar 2018 23:40:43 -0700
Message-Id: <20180324064043.17020-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324064043.17020-1-quytelda@tamalin.org>
References: <20180323145807.GA28429@kroah.com>
 <20180324064043.17020-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:s0i4lBjMQ9INaafz8v5HA9+bfZfzySeVMGEouQnYk8oX1i7IMAh
 NIkMYhva+9TPiQOLKEma0iGtzq6Jl6Zr3tuEhxPu5ylwi469yUn7r3d85g2qGkMmdThImjv
 D/bLbe7UhMUZhAJ7m+jRhPj0d5Jc+gBmTxoaG7dA3QGTxJsisNw0/cD7XmdYruvY9NLTq0W
 fZhQWa0CVGtJh+Wm/3T9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RAewucNmzPg=:1H/O1ElGsiglFeWt3zx2DM
 qTrxSqKXL6XqCLkX7pn5TJwleM+b65KQQ8mp9FJgr30PgHQzPGe3G4Zk0t9GnipQxL9VQ06OE
 1BHRe8YOW7J2azIMxbyS9lPYJHPC0+ESPbyqbBYyBAro7nsoA+xRfO/obEzv5UaZqmQKh4TUv
 fpvxoDylQyDBIbsWYWipTWF0wpwp1uS/TCfxAtLgsTovGbfdxPlSD5A3FnXWEzU8ED1inZmZW
 7MyS5I27J1YyWmgyWJJd5BQm20mdfItRbJBoyb4HztzkVd2upEzGGmFNMY22viRDeo0VCIpno
 0NVx5X+0HSmYMh4OOu2IogPxYhIBx6uksKVG0zoC753/eY4w85jtbQaiaC3fhBP06l2d5jjjI
 fVldQwPJ+Cnbhs21Qx0Zadyqa+DziusZWP6eGJ8au1/0HUSiiHxB4X8uETuDD9ke5p3+usbWt
 1kWt0SNYLvzvhw+6fu7MxEvCD6eMEB0qVqL3LP5dOwXHX5JQxOV3WFK/H57IlbaoHr2DW5obW
 HRBcsmN41YKyIJb6EOgFBPAp8r5pNjVapbTWY2jmlai8/fPXddnUn2fKpogbAKrn5MeolfWbg
 Kx0YWBas9yCpaRuGN/dHLvWM/ufHIC2vm8FICq2ZPcC1ZcIZGGO/HxfOO+9GcLnOzhKJjxqXZ
 nJqU4IeTRRrsLfjbukNkZB0sNvNvwu+IonkvAuyeK5NlXwSObXRLDq5Ui2iUuwUeS7mXeYvIG
 OI2lab8RNi47SstI6rzKGYl2jHG27LbM9lxQ2g==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix two spelling mistakes in comments.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 drivers/staging/ks7010/ks_wlan.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 7f6647f3b337..f42a5921528f 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -59,7 +59,7 @@
 
 /*
  * HOST-MAC I/F data structure
- * Byte alignmet Little Endian
+ * Byte alignment Little Endian
  */
 
 struct hostif_hdr {
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index c94a88028710..a76c5bef5605 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -54,7 +54,7 @@ struct ks_wlan_parameter {
 #define BEACON_LOST_COUNT_MAX 65535
 	u32 beacon_lost_count;	/*  Beacon Lost Count */
 	u32 rts;	/*  RTS Threashold */
-	u32 fragment;	/*  Fragmentation Threashold */
+	u32 fragment;	/*  Fragmentation Threshold */
 	u32 privacy_invoked;
 	u32 wep_index;
 	struct {
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
