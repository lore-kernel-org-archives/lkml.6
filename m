Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+Wuheg8Q1Pp5y4O5qZtWjWzp3rJYCjntEozze1wH+GNq2wWGq5NH6/79CaNTYGH8h/yR7A
ARC-Seal: i=1; a=rsa-sha256; t=1522476624; cv=none;
        d=google.com; s=arc-20160816;
        b=oDY0G89Udjl0QlTWgi1O19SHUr2ey+95iPEE91iexrfibvuX9rRMYRhLF9yvziz4j7
         2W/QFV/JeYGyuLKeHThaqsp2SOmOwgAvRH3F3bSS+3TK8JMwHLzYdkMC/PXxDSU1CLep
         Ava+4oDah4bvXXeBq3VuLwZEVYTXxuea5b+528ztwoIj/B+u/hA65I+RhIIodOcJObwV
         oc//CjNvr1SMvJ/SqZxlAqD5OCf/5KDRH2hl1td6oCs299/6Cs3sig2aenl2Xk4A/vGu
         kQKq2B1zX5ynxqRDHECFB2bFURdfmgUVCEHuyeZiiZdIrncYxvJCvMO/adjSedPg4t2F
         /ViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=k49uariY4JIa99BMvQ4I5AHjS5vuBHdmUYzp7oZP7E0=;
        b=h0ldFF0G0rkiYQkma3QID9XW+s8fbX190W3/AFL3yh4uXr44TdDOtJIptenXINZrlx
         obtMwyT1KfPnA6NuTMBG2LJ0W32yElup3hyx0V/nUczfnU/JwbyqOEaC37kLkEvkbHun
         eAIzQgER9MnOSvvzHjYgrONdLkgK3dW9Tew7v2sSLG1Fs8YwScth5hBouq5TRL0nnKi1
         Bodxw6oAatwtohe1TxfW5mG0ox19vOPNjsjvkyqfSjywj8OtnzKKqrchsoiD/Hx3ORiJ
         EWav571u6nmRmWYSv5XgD5iaUGqdqD6xNwUzDSviit/bunv6NDIB/bXx/4tWaGc7kTyE
         7Vgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 69/75] staging: ks7010: Remove extra blank line between functions.
Date: Fri, 30 Mar 2018 23:08:49 -0700
Message-Id: <20180331060855.9452-69-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:q6C5G0Pr3UZHt8HgUmlyUzsb+lUrZ019/znPGWlTOOErLd0vxTk
 oAmCcCULnNRGlOuVt6xM3cLgMvFuP0Eyr6Chq2J8EBVp/y3zV6yfSihpTRepOKxs6rmxApe
 RfC+OdgwLdI8liZ4+NzsqIIJDv9Lw9XtgsgXgBFmGciwXBMYXhX+uO6FRbXpfOGkUYzjQn2
 2/Dy2S2tAdNNFeMbMsI2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FJOVS5fAQ+E=:pZLrfxtG+GBHonq4zE72aU
 kczIYWa3DtmRKXhkQCM9d0+6SfyM5CM+kv6SzL2NN+kk1IpCEDEt3D0iZn5Z8+CiBgGpdjIUO
 rbvb1Og5wTyYqmwYemulGHYFIl13moKg04IVS9XtCXGXmTp/nkUqRfiFXoDAMcFACkFJMbI3/
 GDgaDV/z50Cb0EJNArNoVZa0yWSeB2oYVPhm9HDBqlWiBPrqXXhcQ5TohrJIuZG2RwLiPy6DY
 /IIlFkuhWeWGfz/GNWv88HKIZg2ocTnFIKpG9aCZVAAHbnR7o68zE+tVDW3Az9VvRleF0Kbwo
 EPUHYKLCmfQjKSSE+npTpS6EnappQKI5s5co35LMj3HQmDN62WO9jfYfrwSiJYsJxAZl+Uv/7
 MHHg63g+bZktWQ93MgYHfiGY0ATn/CCamRQB5t0y1cEcRq5jtA0R38Jgk6+lKnpg/9R/97s74
 /CSv7XCk18g/82JBVybKTgEeULQmN4s3l9GziMN6czbkWKa9CmOtqYQ+r3GfEj0ygRVPeS89l
 tqwh7dP77xY87aydX8T96b95ex/F5j+iN7GI/vyNqbVXykDygsS611wniE2lm6clkX5Ef4Q8N
 5yB6nd1Qiz8obVECJLcGz27aoVIydvHSUCGkUOuF9BH5V4vZLRaHQbhjH6XqrEEDlggd6id3G
 ZdU00xDH2W7c7q6AfjytiTaTcEXW88QUX98PfSatEUrPNuepfafjyiy2ZwN7pQsAGEFWYQGJG
 eqFcKIzJl0pQnQ4LiewFdFKfTny5Ks+KAwX7zg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432449330778051?=
X-GMAIL-MSGID: =?utf-8?q?1596432449330778051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove an extra blank line indicated by checkpatch.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 3 ++-
 drivers/staging/ks7010/ks_hostif.c   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index d083bf8d238e..930d1f7d7dbf 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -305,7 +305,8 @@ static void tx_device_task(struct ks_wlan_private *priv)
 	if (priv->dev_state >= DEVICE_STATE_BOOT) {
 		ret = write_to_device(priv, sp->sendp, sp->size);
 		if (ret) {
-			netdev_err(priv->net_dev, "write_to_device error !!(%d)\n", ret);
+			netdev_err(priv->net_dev,
+				   "write_to_device() error (%d)!\n", ret);
 			queue_delayed_work(priv->wq, &priv->rw_dwork, 1);
 			return;
 		}
diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 23c637ef147d..d816a06939aa 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -221,7 +221,6 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
 	return size;
 }
 
-
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info *ap_info,
 		       struct local_ap *ap)
-- 
2.16.3
