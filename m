Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1066285-1518432765-9-6594119470195430157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518432764; b=OrZq28J3nnwLny937WDrY4Wfpq5QHpY9enFyMx73+mDhbRD
    TzTvsbHV5HhDzAtOpgWyimfyRHmHFqBS1ykzjVTeswilagtrjsSJ7lVrHUYlDtGb
    RGev4dNZf+Vub/LI4BwSAtFG1YT4ysgBcFgDVPhlfka5DqzJ/UsODr8nkOr5T10h
    2HzY3MJ2d6qUJdhopuh0rdQMi0q7sD/a5P0YZjXDsT19S2AH8/VJcgw8aKt80hoo
    ry0cnMnbaQRYADfG1bTwBjwtuWwkBLB63LC4fyPVFsJyiAm5qsHB8x2K/sccvvcT
    miqH2hZ7pZRcMUMteWGCCuwxqFaKbe8rKkW1E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518432764; bh=H
    lpFP/sAq+7oSJZu8vQKQI3l2O0U/+vjtOKgH41TM3c=; b=DWB01+KLbNE/cPwNH
    vtvXblTZD9jPKn3xDHgPgb2Cbfr81CI7jE78AcoZhNpTbrQnRCLTwa3eYL1y5bN7
    SV5gly14HsefwTm3Y6ZhPCeuAMO7+kUyiVM3IS7D1IJgvAqkNxIzAj7adwXET6b7
    H7bq8LYLIeupwjYH44Di5eTxF+cIOQVvNfHJ38kGj2b6nZzCDqheR5oYH83hfyYB
    S6l4JiluJznl+0PcOP2nbK4x+j4K3ibMkOveUoPU0yIYcHl/Fk6vOYzOesEYZrxY
    4KRzGAYQ2J4O9Su4LpxpoOtO3VNgwfytOKr1KSHwsByWKY+mzZ0axF1/qnM+UJLE
    yhn3Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>,
 <sumit.semwal@linaro.org>
Subject: [PATCH v2 1/9] staging: android: ion: Remove unused declaration
 ion_buffer_fault_user_mappings
Date: Mon, 12 Feb 2018 18:43:06 +0800
Message-ID: <1518432194-41536-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
References: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, Yisheng Xie <xieyisheng1@huawei.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ion_buffer_fault_user_mappings's definition has been removed and not be
used anymore, just remove its useless declaration.

Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index a238f23..1bc443f 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -193,15 +193,6 @@ struct ion_heap {
 bool ion_buffer_cached(struct ion_buffer *buffer);
 
 /**
- * ion_buffer_fault_user_mappings - fault in user mappings of this buffer
- * @buffer:		buffer
- *
- * indicates whether userspace mappings of this buffer will be faulted
- * in, this can affect how buffers are allocated from the heap.
- */
-bool ion_buffer_fault_user_mappings(struct ion_buffer *buffer);
-
-/**
  * ion_device_add_heap - adds a heap to the ion device
  * @heap:		the heap to add
  */
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
