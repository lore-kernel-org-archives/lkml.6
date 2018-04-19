Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2833786-1524133561-2-5911409874613363278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524133560; b=Y3cW1EuMsnv24FQ81qm4D/N84KIBSmEfnYjni3vCvilZ1aRy5c
    nFoMV2AM5gfE9CSielHZrGz1fge315HyunHq2oKxuIVKcrG8yKuqtet1kr9RJITs
    LNvdxpt2TzIJS9k8GEMxX4fiQ1ZyiCwUjEe5WZITqBKJxwwgQb7Qka7vtJ/NeWBI
    NgPjvqigk+rXtXW2IA5+e5rRAoNFWEUacfGQWVVLIyymNuut61fVfTPT0rq+hmyb
    2b94QK3UnEv3oS9ljA8218cpd8FCou9DCshKww8RnFXZSUL3xUx+NdK5VzqcAUbM
    JbGMthkbJs3u8t8v1EdMZcBxG22CMQ6eF9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524133560; bh=XIYoI
    NmfSjPqxUjbBYUKggdo3R6Di0E03NdC08ACrAA=; b=TFnBjGLL8ZLYFZZLJJt8S
    OY7sv+9OSXuCgfpjXbn91Vw8mGBt7jNTTVzdcwYN5ZBaXC3wIxKN1i+6TdGVJQFp
    2zmC78ncnVTF2242k8oC2aYSGX0R06qfvdVQSBJUpfzDRKb9jR2hVOyQpCPKuZ1A
    xQEQXxNgEUTaRfJQNQSpZaBoXyMjVafkvWF1OEl9dQa3lAX5zu96+yRc2bVQaUg3
    VMlXsmysj1ZAo6xwT1KtMxsx+NMCiKCVUL8tGj0nv2/M0yZ37gqSeK18I+Pe1uTQ
    diHDBhf1iSDyqK6GJFzCO6FExOZNEpQSx4gPvJw560e3qKw9sexAgO0XHphKFHuu
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNgJumBpRYACY/aDwSittY0u9omnPqsEAjFLIxk6XEKXZ5RLJZSyYluF1uwrvlYb8n5UmgNQdGpcEqz87Ft0shzT+KdqtTb/9WbKJ1SF14wIha8gXolY
    sJ7s2VZY4fSUsTK4KIsHcHLzvHc/LHyVOR9gnyX/ZH1Hsrzkc0sTqwkR26jGlgGmXC5QI4/FMfY+9WbOQ+DvCoretM7b4KdCHT//6uH+7sns+4fkRxzi2HxF
    Q8jatdzZCB5veKx454uA6A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=xUXEEbovFiWBLQY28vQA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Date: Thu, 19 Apr 2018 12:25:30 +0200
Message-Id: <20180419102530.5927-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <4dba7594-2661-edd5-24ba-cffdf24021c5@smarthome-wolf.de>
References: <4dba7594-2661-edd5-24ba-cffdf24021c5@smarthome-wolf.de>
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH v2] staging: pi433: cleanup tx_fifo locking
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
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
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pi433_write requires locking due to multiple writers.  After acquiring
the lock check if enough free space is available in the kfifo to write
the whole message. This check should prevent partial writes to tx_fifo
so kfifo_reset is not needed anymore.

pi433_tx_thread is the only reader so it does not require locking
after kfifo_reset is removed.

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Reviewed-by: Marcus Wolf <marcus.wolf@wolf-entwicklungen.de>
---
v2: print a warning if partial fifo write happens

 drivers/staging/pi433/pi433_if.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d1e0ddbc79ce..2a05eff88469 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -87,7 +87,7 @@ struct pi433_device {
 
 	/* tx related values */
 	STRUCT_KFIFO_REC_1(MSG_FIFO_SIZE) tx_fifo;
-	struct mutex		tx_fifo_lock; // TODO: check, whether necessary or obsolete
+	struct mutex		tx_fifo_lock; /* serialize userspace writers */
 	struct task_struct	*tx_task_struct;
 	wait_queue_head_t	tx_wait_queue;
 	u8			free_in_fifo;
@@ -589,19 +589,15 @@ pi433_tx_thread(void *data)
 		 * - size of message
 		 * - message
 		 */
-		mutex_lock(&device->tx_fifo_lock);
-
 		retval = kfifo_out(&device->tx_fifo, &tx_cfg, sizeof(tx_cfg));
 		if (retval != sizeof(tx_cfg)) {
 			dev_dbg(device->dev, "reading tx_cfg from fifo failed: got %d byte(s), expected %d", retval, (unsigned int)sizeof(tx_cfg));
-			mutex_unlock(&device->tx_fifo_lock);
 			continue;
 		}
 
 		retval = kfifo_out(&device->tx_fifo, &size, sizeof(size_t));
 		if (retval != sizeof(size_t)) {
 			dev_dbg(device->dev, "reading msg size from fifo failed: got %d, expected %d", retval, (unsigned int)sizeof(size_t));
-			mutex_unlock(&device->tx_fifo_lock);
 			continue;
 		}
 
@@ -634,7 +630,6 @@ pi433_tx_thread(void *data)
 				   sizeof(device->buffer) - position);
 		dev_dbg(device->dev,
 			"read %d message byte(s) from fifo queue.", retval);
-		mutex_unlock(&device->tx_fifo_lock);
 
 		/* if rx is active, we need to interrupt the waiting for
 		 * incoming telegrams, to be able to send something.
@@ -818,7 +813,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
 	int                     retval;
-	unsigned int		copied;
+	unsigned int		required, available, copied;
 
 	instance = filp->private_data;
 	device = instance->device;
@@ -833,6 +828,16 @@ pi433_write(struct file *filp, const char __user *buf,
 	 * - message
 	 */
 	mutex_lock(&device->tx_fifo_lock);
+
+	required = sizeof(instance->tx_cfg) + sizeof(size_t) + count;
+	available = kfifo_avail(&device->tx_fifo);
+	if (required > available) {
+		dev_dbg(device->dev, "write to fifo failed: %d bytes required but %d available",
+			required, available);
+		mutex_unlock(&device->tx_fifo_lock);
+		return -EAGAIN;
+	}
+
 	retval = kfifo_in(&device->tx_fifo, &instance->tx_cfg,
 			  sizeof(instance->tx_cfg));
 	if (retval != sizeof(instance->tx_cfg))
@@ -855,8 +860,8 @@ pi433_write(struct file *filp, const char __user *buf,
 	return copied;
 
 abort:
-	dev_dbg(device->dev, "write to fifo failed: 0x%x", retval);
-	kfifo_reset(&device->tx_fifo); // TODO: maybe find a solution, not to discard already stored, valid entries
+	dev_warn(device->dev,
+		 "write to fifo failed, non recoverable: 0x%x", retval);
 	mutex_unlock(&device->tx_fifo_lock);
 	return -EAGAIN;
 }
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
