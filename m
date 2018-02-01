Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2255742-1517450640-2-4941176030828890531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517450639; b=E48yJikRrEoir7aKc+O0uUkknU8pKIz4N8+mPuBFySlcKBJ
    dOL8ZzKd7CV4WW5yAxV5fI7MeKHwIuke5yGq4qT23PYATyJfNu1FLHnxHEzyE80a
    Ovd+hGu/HBP/RZOvG5dQ/99HQWuyPo3csJqYxvcx+sj7+DYDqk/A5CU6Ox2p4Pr7
    ZQlny1rfKNecHMfztxIzdgM25+C1T9kFmvryHInoVEzkNiDYlMatYzv6RYm7vkjF
    sZ2IcStWwBglcSWksL3IcEq4YVkB3Jj5lwTr6Xv6tWMMNbS0rY7Y68S/q1r2JgFH
    /VcJl/wuy8Bn0/j33s7bZGqYw4vjzpWmp4n/yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517450639; bh=4
    /J4EMB7FSsXYuf5auulNOF1E8yGJmWrV9qqVdUuBzc=; b=GTWHv5uh2PJNAg8k8
    tHCqHLzYrf3FASicOjbI6oCqBk1MQeu+T3fPn5g8y0zYhwieRbgZBSoJ0Zi4pSnw
    kfQEkp76kVBvwzBGdw16EmtBIWHSRm+SZ6Mdq7Cabt0kuTVudf0KT6Pcf0eCHqD2
    FMrF45qAKHE1oLhWlYMfHchXybxd5+gKAcN5bFs1mWdudrGQZOz+SwNj3aWH6tnR
    Zfvr5Jg100pXkz7REKKXIQV01GEfcVnDXj9e7bqgV5xQz8TDJmxQ9vLdRr8eXKU1
    7YkHVRYWlmgdvU+IZCt6k0I/Ylb0P5pJxSBJ3IfvAx0dVI2qr2Zo702Ic81bRKM/
    1JMuQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>
Subject: [PATCH resend 1/3] staging: android: ion: Remove unused declaration
 ion_buffer_fault_user_mappings
Date: Thu, 1 Feb 2018 09:54:20 +0800
Message-ID: <1517450062-16123-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
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
Cc: devel@driverdev.osuosl.org, xieyisheng1@huawei.com, sumit.semwal@linaro.org,
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

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index f5f9cd6..2160c35 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -201,15 +201,6 @@ struct ion_heap {
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
