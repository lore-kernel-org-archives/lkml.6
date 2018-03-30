Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393773-2-11840793294853990845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393772; b=dBuY5ZD55z9nEBsh+jg0bMtYztyb99UG2BAfoidHQOOoxL/ZTP
    04oG0w2KyAWMRwlPo0jaz3psDpXP1aWaJHv/8F3rThyn8R0pzYhq9WMcV/Az9A/s
    0WpdIKYVMx8WeVV1DMct+wJ0mDHXzp9cQco8NRVFp86JgNZD9ExAsNjU43iVcycP
    5fyIpDG/R8448MlnCWhA1QiOyj7RL+vime/KylEDiqgi6WscupoThMxLwfn9JK7g
    LXadayyzv+sACvRAb5yD2xuWpfzXNRKnS6LN5KeCpn+fKuoDr6y3BLs4dkt4qNFQ
    0TKU1teBQPWZFZpNsmkltOBHdZBsUGPDSxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393772; bh=crsTQ
    mwpzv7bfksp0mUyXjGl8xn2usm6vJGRJqVjB/s=; b=Kye/zvOr1F1DLvBPVut1G
    Sc964tUy75e25Y+4U/M/q6dy0XA7aDNSwb2fQzEOi5xzdGA9sl0EtWxAT+Kr6y5W
    9lRawoNfxrUNaJgH1bh9sh7RWEtDR5X2tsAqT5skyJ01UI6QzTPT27VyhAvAPuvG
    1+sriFZAh2ssjMfyUg4gdm+WkKPCjXHwNipKI1dh87Y+cbTzGN1znuXVZFyXcxBe
    Q5KhTyxA1Ycs+FTloAnFPdkuufDpdSoIIJsmHei0AZVsr4Zlw24533hE44WZbvhP
    KzA83DNmkbtPX5JkhVCnWv2yJKEBuUYKBKrmMEfADbxvQzczrJzP7mmkibRjxd3a
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNHeKY1rOCSas/mO2a6CKO3UhZtXXdJMQ6gojnYMN7Tk9/rncxCjXcxz8+XgSpGaTh1da3NoTr4lx0+8VmQs2PEspg9JFgLm8bK5Yt+nhDoDkfn9yTGg
    Qjl4fripCu3rHdgEvOX8nIQO8xMYFzEAnLY0xmCK4mWFVykyYuqJ02e6DI5TExgKIuG5/bxyobW72L914T83agyXq9fTq8DLUkY9IvpTFtgprmYFdP/va5TO
    ZoQ3aZ1Y/5et37Qttebfqg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=V_zipIKupC2UuXeJSREA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 05/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_data_request_t'.
Date: Fri, 30 Mar 2018 00:07:28 -0700
Message-Id: <20180330070842.25224-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:rOcm5/NVUBbCE0HiEq9jUDF63H0iBQVoa3RwEXMtNajqps1lWtE
 GB4rszO6ZviPCJ5qfz/6T4tAZR+SOfb9pZqr8lcx61nPVwIfwJgrDv4NPLDSa7KU7HEURDA
 YhbOPGJj7oFwnuRkvbrnOa1mvdpaLNfESaZue7bcwVvjEy2JmaL+XB29C6qjrNsj2OH9Fdu
 pGyl7AoCDOVNWU/Dr4ztQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6+ZjzCTCOdE=:yCIgu0v8NTOeO5FrmuZnVC
 2P2wRkGFwTs5nC+vfqrHyQlCLiL3AwqdCQKIz+Q2ypaz4VL/OtkIm4O1nWf7xPT8NB01ZtSr0
 6AFUFOvppgcxCqFFcPkilVL62MMK5VWicL1lbCaN30z36KD/U5mwIuO6xa0T7wFeRrf72dsl3
 Kobe7uTB5tTmA/ZUmaQiLuvhpEevAgPMTdBZskrfZo9FfxvQFhTHr/nGLe8BPqmPGrtRWYmCB
 QOLiaP/O5sX2+YShPhbrzaAm8C1VFNZ5Zap74qgoo2mV4c+VL4jdn7CWesF9k6fRkrW71S/2U
 5v0l4bWL0+mcBklzHbiMyXwC5tuzAEZX82/0+Wysbudel/F9yYeWDnFXFKByswL7IKZybfGIY
 LhNlrUX7NtdQ7ed5HGmu+ShYZfq0y2CojG8kC8q7YtohwoQhLWT8omZPzqyioQfuviMiCt4Ve
 pSJsDIT+/9BRJUpaNWZq22ixKov4TKbGpItBaGu+cchgRMTloWtWGj85qFHGRW/USfn0ILIsT
 vABMeKc8Vu+wSoenrZVu/YzDvI8DszWLVvh9eN/7uYIVnkaLM+rn3l7TZ0qG45VbyneZbNJy1
 ECnwgwHTnX++8D1aKbxKIQAAMhnWxjf7oNaDlpoy/dLHizXkmo8dtcEDbYM8ZYgscCOpjSZN7
 I1TY0S7UNzegMmilu1CArlhrG5GHMnJm5Nyz5tB+QkU6fmg2J9sMD6j0U1pfH1RVYUPxRGeBM
 Lx4YSqvyLXIodBc0biLmxTDdMEyVt6hQitTYmA==
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_data_request_t' with 'struct
hostif_data_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index b8a9d242e95b..9e69009e2911 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1060,7 +1060,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 
 	unsigned char *buffer = NULL;
 	unsigned int length = 0;
-	struct hostif_data_request_t *pp;
+	struct hostif_data_request *pp;
 	unsigned char *p;
 	int result = 0;
 	unsigned short eth_proto;
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 2f918b11b337..036758687b7f 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -67,7 +67,7 @@ struct hostif_hdr {
 	__le16 event;
 } __packed;
 
-struct hostif_data_request_t {
+struct hostif_data_request {
 	struct hostif_hdr header;
 	__le16 auth_type;
 #define TYPE_DATA 0x0000
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
