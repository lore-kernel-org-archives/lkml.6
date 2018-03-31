Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48KRNUBw4kB407Z5sRjoTQDTBGu0QsDYKh47yu2Nd8LHHweDqx9yeodST/GnqOwGeJlO7OP
ARC-Seal: i=1; a=rsa-sha256; t=1522476566; cv=none;
        d=google.com; s=arc-20160816;
        b=WJoNXEcfbBCdF2uwFZuCuUgzcwQ76LYJMZpJWn09eY8PPEY8EqJgu6l/MVhNObLfI3
         c6JSV9K77gAD9JnvngiS0hLDOLw+vyn2Wo7pCQy3fYUQ5eHO5XjgWIBa7k+HWU1GygcX
         o6wCaz77I7P9fvzE1R+oZm0sdsH7HPOr+AEN96P6y7V68B6ySDAjlcjkIWHDt1Ae2dFP
         JGg92P/S0s6qROaJyyXYHXt/tqaXX61dBrz7UvhNqx9x+81ya3Z/vU1olKOoq/CVIk0o
         CWPUc5pUx4Lr8ZnkowS06h70ywQnkPA1HXu/THphmW8sN0CbZT811hm7+NlwxO9SpzJ4
         lktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=v1EIHrUMll+VlIDj3/HLCclN9cpQujUJ2+e21FNcLEM=;
        b=Ra93S7svw73isRYNp2TmzDkIou+E0NXeDTSQZWcBWFWuOLvFXsSoBUfQSROjj84bR+
         FntCtxuESVm6uPPt/F0lDOMZA0JMiDoz1dhZfshoqUqnlyfpvylbEkYQP2kB/+M3Kln1
         EXip/cTV9X4bl23fGYNSin7mNqgT/h+DXKouMETQPZd5p52IkN/I2XvVvTcoNho/9mxm
         m0pYmHppO+Tiwneo5EwHgD/K+j/2aaSkfq+einR2UwKZ/GavJYuy3XVg8pt9+BxTlUcr
         p6duEZvnp6y1O1OI4UsuzfeNGKd9nVcyTcy8Y4balNlTQonjR84J4q97d2Gwdco1R0ZC
         kR5w==
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
Subject: [PATCH v2 05/75] staging: ks7010: Remove trailing _t from 'struct hostif_data_request_t'.
Date: Fri, 30 Mar 2018 23:07:45 -0700
Message-Id: <20180331060855.9452-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:9a/E98v9wSk31AHf9iIaiqozawSpLQVzoxQRIFFBjs49htrmMhb
 4cZaL832sN8bIdB439usJ4npXG15/UOXqaMsFRmKVumOUifjOqGfQFEl1eecEb2SSMqmc8q
 oToxDCHAIwCHMrr/wtSJYsyMoFAup9dLepIgl0Cr+OGwfEnVqSLWnwiUXuNQdO3yqAGjQ9B
 Hp7paPTcyGM5xyNDUMMfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7xkJyqPiJCE=:K73ypv+zVJMJzNQd38JIhX
 rYaytdVISkEmuFP4yNMzjME7Ofu/xhQVQ5wQ3UvOxNHMh6PDAONmJ8goqOGdYLC9GcWmRfrul
 kFtkD6p77IuZV33IGfll+JEQnKlwpLsrB/DSOYZ9X466UmkgYihgk0LQPj+YE38NuHuWeNMIR
 35qwKMOzZSa7O3026ZzxeVbxhpSg5liDnNa1mgMtEqMWtlvsQgax41QB9lmFDnptgry93dilw
 y5Tx6aVd0xggTj/8vWUPCVpXbgCzk9Ar52ZKBDBxyYAXVPksDn1dNhp/5irb+WCt3zR4hJzGu
 2v5Z6f6n2YfKlJttqZPfwccB0tLwq33zkG+eMQAxhIXQieVKZcjxItDUoNna/xjBFEtYL3Ksc
 YuKEUJG5GxIf7goZdjGVeg4jE2mu2faINV67aiW4zsr1aul7f8yh+UHKpg/XvpiXUJsG4gOM/
 YMYhSWgm84OGQtiHkuNPADaecQBR7Bw+cbfG98kX52rS2lEMA9htKrfYO5Ck8UBAA0cjMW82M
 5lcquLpnWlT94wCm07MGD1HDeAZCfNmprtr4rq27CWafRd8MCJKn0cYFvSJQMdis2wqo3/cf2
 TuTNDx5vt0CWyjUsFm+F/QxLDPTLy6yNElpX9kCkWp5nMnJ1gINrbGYhfLcWhOtEmW2j/Ctp3
 Y8L824JJ/3AQLPH5p6EMTdzKKpeM9QTWRB2DVOku4hhm/f76I4ptmldFdm5d+m1SbfUf3rsMR
 UHEYfo2PRlDFeLh0BwVxrln9wUKzbxduP7QVbg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432388483862374?=
X-GMAIL-MSGID: =?utf-8?q?1596432388483862374?=
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
