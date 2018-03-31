Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48MfC103ZWufiWsnfDY+pfKXmH8Rmg7lHPO0PgplSADyt8h28FsB2T6mW4I5+s5mV5TNAS4
ARC-Seal: i=1; a=rsa-sha256; t=1522476614; cv=none;
        d=google.com; s=arc-20160816;
        b=zGBLjHHSD36DpDdmrIPGxgjTyd2djQBVpi/6WlfhSuwJmfYdxpQStP6/XhMHOw25VB
         NIWRpfko+Q2IUXKbqp6icetEAZQr1PIlSwq1Okm5Bv++7nag5sasFA2kE99JC9mReJH5
         COg0AjcKLoA5nD2RWwPA3I++Hxk0ysdg43XOOVqYSxOLSrtlZPw3XaIzFxjXn1ZcaJ0v
         +mhanl1flCN3WPc5tfnJANEybgDkISmR5YrMKaB7a5wzcXCEhHYO5fmLRHNoTUzlmVNi
         XPAppQEq7JGeIMi4vuKeBqJAsPlLw0K+uGNKACuq3aqsRQaBxUnUuou/6/L64vBJgPTm
         I2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QZ7XwPZEOVOrul14J6wRLIdqMVG4JRDOwR5HVP6/MW8=;
        b=PxcMacrsQcgUThXEGD2moSjkBvqibCffZlNMpqKzQmBvXjMLZxUaYXKIL0D5W25dhx
         Dq3T6cQrYfZfQwtnIjmXt8uploA+xBz+Cg3YoQm7SOgwT21k+FpiJtzeawz/dOEZG3ko
         j3yezDwQdSLFy98/fq6eKFbImMnTuX9FTwE2bJDrvroQr+nwWBFg8fJbc+DkTepu1BJB
         RY4UXDVFLjoBSpAUzxnaSiB7nkWlJM01xojxZ97rYHzIuYlj9BDZ9+gLXxWaH9sIF3r+
         qvyBoCrj+fFPj2gekxXCrodZXavIKppx2dTxhs2osiFwAnfCgwFNciVRITRYFo9ZqPlt
         tNtA==
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
Subject: [PATCH v2 58/75] staging: ks7010: Remove trailing _t from 'struct power_save_status_t'.
Date: Fri, 30 Mar 2018 23:08:38 -0700
Message-Id: <20180331060855.9452-58-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:PcYW4yhKBJgwNnj0rLYnjNzv49c+7ruP5iH85ygS+A7Hz5Qv56p
 lBnUYy/sPoA/6eIUiiqdEcdfbNxVNgf0psAKhzdfF/9+4su240DfKglaA9vIPAWsek+GSzf
 M8AONaUJHQQK+UOLxaRwwLQcPomhGgQY8YwL7sFQAwC+aIzm2VmOdKLfMWmVWy//WXr69QZ
 4Y4l+FwKz7hX8nwFMcsoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wXWJRJS2u4I=:6ytT8pYuywf8wnPOyjjEkP
 fqJZN9p/Bq4NNX2a5FYTWWp5Csdx5N55eIzOC/v2Su2AJgOlaGE6rTrrn8JP0ZECk5dDK3b6Q
 yBN35X+IwyPpmBPSdxBkBE9mlZlzzkA8Bhai/Zh/AmUoiov7x8RZTOf394nbw99FCz1lS/qt+
 UCZF6hnuV8RDrZo4N2UfODkfOxNGhNdDC+CMAxZuFe1RBoXsLVdrssBuYsCi1XlLxf2TS1k+f
 lQycv23YaSImXWn1Oi0uzJbXiEsi61BmPg3gxRuvzM6KjQMjBjRQSF7/uZQUfv1cEvvl6JSUH
 V3CK53AcIkSv/ZLTPXgwTYRwoDGwmuPAZIlpBxFWd9RVSsb+B7KfNtPn/qD7KpOropMJNUilp
 LI+v+3tPrLhQgBQQR1R61rho1mFGVKJ2B9xbk51gBbDAhiNR6bJQ4NiSKM/n9h4xfcwXVPiAS
 6lkEIvVUtuSYG8t6jca8nda8MkhcAlrUYQ6Xv5s1h4oXJfr5jAGbSJSA5noBkimM/1guxndwb
 PK5YJpMaIMh1TNSWYYxQYVeCzS/AMUsjDVYD8HLDThD4phs8jz2cP4kqjX0Ky19gaJM/jD3JE
 k/785J53d66QQmue8G/+9DuzU82fuqER/DJakzlrOhF63VIQYy7pr+LFsmi/xg0pv7G6ByOVi
 mLN4yeuiPq0tvzR5Sq9RCQ/wOm5KvAL+5e/8VDqJhT0+nreyYvcC1+GsyYHWv9ZcWxONRAF21
 JfqB211u9J1GtmZK426CrqUjFwIP/hC6K9V8VYQDSNZmpXLhQSHXa3MK/Aj38vEtuOQhMNmHb
 j3yv9fHoIVKWIxqrQbfshlZyMXOAa0TCbzJYGaRyMobUSAh9O07JpqVo3T2bgYozSHk1fgs53
 ROWXDuaDZjlsQtX4qYbY0mQyRGH2jW+usGRnFRKm1SyAsAwiyspnGeRyrXQlu7
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432438959467428?=
X-GMAIL-MSGID: =?utf-8?q?1596432438959467428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct power_save_status_t' with 'struct
power_save_status'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index f99b00344d39..edd13060c24c 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -278,7 +278,7 @@ enum {
 	PS_WAKEUP
 };
 
-struct power_save_status_t {
+struct power_save_status {
 	atomic_t status;	/* initialvalue 0 */
 	struct completion wakeup_wait;
 	atomic_t confirm_wait;
@@ -425,7 +425,7 @@ struct ks_wlan_private {
 
 	struct local_aplist aplist;
 	struct local_ap current_ap;
-	struct power_save_status_t psstatus;
+	struct power_save_status psstatus;
 	struct sleep_status_t sleepstatus;
 	struct wpa_status_t wpa;
 	struct pmk_list_t pmklist;
-- 
2.16.3
