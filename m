Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393766-2-13488481613274087316
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393765; b=S4PWt5K8/uV+Adj7GCbFqofRXnDRF1O0/bijLlC6boontGZq+8
    xiNpdOHOqAmSh+Oz7GMze/T+B8XJfQN9A/gO7HU/pKv0Qo+8TgBlCBdb/fhyB08+
    QBkWRdJ2bQPlKJyPiij9cowKq7RNwDn22Rnl3HTwFCky4K49WIkbDmt3LVTcRJ0p
    mD+nJdsvkzBu1Nf3SEMnzd46n6oqssX2w8+5UWkxjQoVCcjyKYKZrd3Z+uLJ6pU9
    l4cEIqpfnX/EoXKr5MDoc7gmIYBq26S47NY1vb8RcANp3e07Xk8kWwvucauBQf9W
    7Yw8f7z+10H2OqDbqPn6PXaN3YlNrVainXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393765; bh=i1My/
    0XU9QEf+1frWy5uPJKbflcmAWJ4SQaJ9OLkAnQ=; b=TnCBZGYSb954Vd1higZH9
    XdPJ7s/OM0FdHm/yXrN1l57lUUxUG//ywisq+BCt86WdGrvEfeSk1mDEUm3MaYgp
    NhrBcqIYFrMTH01c422MDWlM7yW5buM8yIDuDsy60dGxpyQoeqyAKxRGxm7dZOfv
    SHkwPLEOosobtGxOPgyjFbJ2RlFQh0b03EFhglQGMvpkg4Wv0oDTgNmjXf9ODBTS
    bI/KH0gwoUbhih01HVHssLspA6GyPDEbEHSyyGa0Gi9eB9tnqdAjjLtcxVRRJHof
    qvdacEyTejmR8AdbF3GPl1VEp0zhPvlFQjXC3YVzNTDrcMtPzOxZvzcgokZVvmj2
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
X-CM-Envelope: MS4wfFgo66jSg5i4zy9ev1rBq0dzWLKaPXSIbEsSqOj/I8k1fobfijwXdeI9sRosfM5fmRWjEIvBYjZo7QN7lDOvG8cZ1WgtnPbxDmehN9BjBhIVO56uXvw7
    +fWiavYd41CZOIash01/XC4z1+7y0TDbYfrSzf+XgMjK56z5kuFrzFuYoVJTIZHjKNaSmQZ3gn63yyDQ6PI7B2b/TxA2ZkdXHg6CaLFd5EmswMf7Z5wnz1wV
    m997Th7jtjqLR+0gxtaiEg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=4pWhBJYePLsalNw6YyoA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 02/76] staging: ks7010: Remove trailing _t from 'struct
 wpa_suite_t'.
Date: Fri, 30 Mar 2018 00:07:25 -0700
Message-Id: <20180330070842.25224-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:60FRffpUhE3KR+4Jxxv9p2m9S/WRsltKi5MuGpvD/AzhnmwF2Dj
 Vh/HX+9E8QKia7uLGa20IgzXHox8VVdGz6UVXDeXyhg1+uAHrSjVV6p9YC3NtjikvTQrRRB
 9BmvQtN790iPu0B8TMNJ0uZ0t/eJ0IMYc0bRuTE73gwka++09ZBzGbtN14ftjr/om+eBwp0
 Iw32X9r0kyHfZD3rJhmxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J4BMuOKLGBM=:d0uJSX1TRS3vzsdXOAGGkb
 YB5vs4MF8KeX8Ww4w2zBVaPCrkzfybL0y+OmOjw6m3pudZsxJtwojKVmkIHpTRNTwPwwAPxbc
 cefQMNKatgLo7bklgwSzhpbAR5HVBO51L/g1njaEXvJzqcAlJdusGoCdvBRl5BErSNODojS75
 PeV2kuCe2QSCedj5fEp2M2yTdvQORsVFR8UcMxiSjdOSQ7oxsevXT4JpfglwgyEU0JYTPfmSr
 G8rjMHPRIlUf/7RB1s19cT9ZkZTtF0VTCBF9RI6UKkzvZ97LMciP8M654dNcayB8PJnU3QWXe
 uiwkV8ReFPX4AoB13JY3K5nzT0XSZeO/77veQHkTgsz9flthOReA2/KpLafC9vx2MU79Z4HlJ
 G/3ML4TXxR6yln7BhFEgv0WJ49XOj567C9aAlsr0bNbqc0+BihWepY0Y5o+VX8rDutsPYX/Ot
 BH7aTBXw7Qu29jGa39OsHyRvxSWiSPDlY/CitzhK38hp/8fv14ArxMvHwngKeLhiJl79OUzkU
 sl6OgfoaWVduPbcHfTb4bBFXLzSpPMWi2MK0/KVdD5jvQhZihRDsNjCUjwKhfb3MG924w3T8M
 5jgjkeHkbbhOfP1inPnIfP5Y3ydZyckSWLZWIHgK9jVkbuN7bU14CmK3ZOJ+M67x2EXQ0mTue
 2wZaVzANx/WpDcgEM1ljtQYFYEb+JggOnv7I9TfOus2uPGnp6GGN1aPMfpyAfbecMCsw/o8ad
 he7B8kVzXEN6tjEVJ/mfYFpU7lAGjvI3G1Nu8g==
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
all occurences of 'struct wpa_suite_t' with 'struct wpa_suite'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 676961cf4103..af1a5c123789 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1660,7 +1660,7 @@ void hostif_sme_set_wep(struct ks_wlan_private *priv, int type)
 	}
 }
 
-struct wpa_suite_t {
+struct wpa_suite {
 	__le16 size;
 	unsigned char suite[4][CIPHER_ID_LEN];
 } __packed;
@@ -1673,7 +1673,7 @@ struct rsn_mode_t {
 static
 void hostif_sme_set_rsn(struct ks_wlan_private *priv, int type)
 {
-	struct wpa_suite_t wpa_suite;
+	struct wpa_suite wpa_suite;
 	struct rsn_mode_t rsn_mode;
 	__le32 val;
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
