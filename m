Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2915802-1522393792-2-9675922541135851816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393792; b=wXcIFuTHV/tVi9DNtlQ5SENPoJQNm3lyoY1ttUBF5ts+h5XkZu
    gi5CZdCJOacme/kVK6zxj49Q5lyRq3Z77ziMtW83s3t8eZP65/FnqdMhhVzuKHbk
    HdACGaM7DuTOad04aJm6ABo3Md5GKvnQO4AuESzk0pIGzq/BUd9xCP2nCGb1RMKm
    tqBToYyYD6ponkRBsm1g6cr+gWg1F4oTR+FhGIzG7y0NaAy4Ku9gME/uDAAzzsAk
    /W8eq8G7N3RHLM61UQ66Z5VE421PfnyprdD7tEPAlA8EJBxMnQGGBET5Z73IjydT
    v0re1949SdqXRyuHW+Ox+MFcvdrKk4yppnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393792; bh=0Dd8Y
    8Xgith/ig3QCS2eBdg7Ez9oUXfr0OvwxSRNj3E=; b=dviJu/Raw4lefY/J3cj8O
    E7LtuKAVZkHCiakyoO+cvFaam1eYusUmVdTKKKW8+roOwNPwjUcAsGzoIPGkEgl8
    y1t1DtP5AsI59atq3LsckieY9GNCBNBLRRB4pU/Uq809fZBKwyOdLnzIa36f0pBV
    WwoDivJ+2ytvyMrH6dr0e1OXcEduhievaLweTbOaifdOXhidOGGIqtJgbOQGaQ8S
    CJog0OGNKxSjtInacoDPlG8kS021057aQzg6Lcr59lvVDitMv6wYvFxXF4ph8iWl
    Cg+E166jrzcizpt5EJc1mHDClaV/5hR12m+Q7FBiDA6traKzovWQLqMUHYxVYu2C
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB/hFMylPyqSTrasAX8JUzfwJivi6QJsmG+jYYDUjtyDfP4uGPWRJbw7wp3QRDIjRlF70mL307q8D/h8GgOXM2dkjYzzZnxuXg44/pVaXew6+ODZiJuL
    ZdanBnVX+Rvq9QvOMxpgWlZ4zkiCbZWu6nRoppW0VL0nsKtGsRvGhhqr8KJq2bKvW1MMgn4s67uWRQE1ahBZYat8hX/AoJnf/tmPXq+IaN7B1P5BQW6W3zfR
    4PjFS3mqXv+RtaWAqfGSBA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=V_zipIKupC2UuXeJSREA:9 a=n_TnnmT6Dx76rHwd:21 a=dqA6PPZ4Haj8iyah:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 08/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_mib_get_request_t'.
Date: Fri, 30 Mar 2018 00:07:31 -0700
Message-Id: <20180330070842.25224-8-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:nS2ghJPBRQcR037Yc6sQE7vjUteSucnDelhV/ys721E9CB8uTbz
 sbL9XKV7KwPD6MBEMNgc6M4gZqRl1Y6n0LDpO6kJgcUk9JmH0s8xSG4SNppHlZOiLSY1GgQ
 u69XtWwnprobVTtEp1a+6tOISonT3fh9Dkuy04FlvKUiK642TtovXOuLWmQxEkjwrngcyLd
 5sHnrDeFbqCny0SEXGBfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:42FxPOiNQvc=:O1B2nl9m1NIresq3hmA61W
 i4abpd76fNBxRDJF7tAhFyxHB29Oi42u9EuSdZQ49p3LaFR2mEMLg1UvP1/WbNiKnX2jg5EzK
 B77qX3ib9q7Ek5Jc3QEfksihasW1m5c3+JPti7HaGuWvHRYILQ2VpjuDXTkzpWptfBlV8GNSB
 8otyYCAS5XeUdVtpCE9xhc+yvH05NivrMFdttk7nXY4X91KBzGSyLJn+nnBkfT8tG0iiiiTIM
 YZsXfSxz6t3VrVda0ckE9m2fICUnkKbQKTWgf37njybU6Ll0/FrwP7WxOE1iZcG1iwmuX2odh
 J76/wtNukoWR0/559VP9mdRqypeKOtH0zHMnlke4GRZ9mQOA9i7zSlaSFI/tVOy4OOjACXGi5
 db9ercfcthAa9yNNnWlVXOCbUqiWeSIXwfKdd/c0h1c5Eep9dQIulYqDhTNXAlr+uJyZZY2X0
 +PVQ1sHbPLBfxBicEjim158roSpDHWNgYHtxJMPg4onztbtBRP0kHDWQ4N8yrxixCpn7aX2ee
 t2Fzs+0E3kcTTyhlOAQF1u8/jBvoi8ExrricqzeS/SiYcnSdIArM5ToTlSHV65wXmRENL5vuH
 0cVOR6np66RH55dFTyp4++4TBL+HQxzO50CN9tzSt5K1i8O0/n8gR1Ml6dLZN9N0j51x5CCBY
 oOy0Lqse1BpX7nlS6c0Oj4d35sGvFcNLWR+pDY0FV+AdRye0DaPjSEbC4mkAnNd3l/Ng6lAl+
 jwt1YXTOVC1WFHaEGuddF+XhbBFyEBnKVLrWzQ==
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
all occurences of 'struct hostif_mib_get_request_t' with 'struct
hostif_mib_get_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 9e69009e2911..cc1e5f441cf0 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1240,7 +1240,7 @@ static
 void hostif_mib_get_request(struct ks_wlan_private *priv,
 			    unsigned long mib_attribute)
 {
-	struct hostif_mib_get_request_t *pp;
+	struct hostif_mib_get_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_MIB_GET_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 7869c80572bf..6e39d80c6ee9 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -142,7 +142,7 @@ struct channel_list {
 #define LOCAL_GAIN                        0xF10D0100	/* Carrer sense threshold for demo ato show */
 #define LOCAL_EEPROM_SUM                  0xF10E0100	/* EEPROM checksum information */
 
-struct hostif_mib_get_request_t {
+struct hostif_mib_get_request {
 	struct hostif_hdr header;
 	__le32 mib_attribute;
 } __packed;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
