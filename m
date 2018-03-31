Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/Rfl0Ce3HTI1tqIRC5fSxw06GFhcwHbXalHCHprGNEKDzkgT34WmVQe/FKuZLnY7tZBrGY
ARC-Seal: i=1; a=rsa-sha256; t=1522476619; cv=none;
        d=google.com; s=arc-20160816;
        b=NrcCGeiH7mGn6hCpwHmaF8Cfb4Ke6lmp8iYn5zXh8R2xl2N5A+UcRP7QQ703UYdRJG
         2PEbin0d9yQ3fQAtX93wJcUwV5hQqyejxDO68uhY7RZkoQmS617hEyRS6JJw/edgKs+0
         rosVc/z6UI5KLli2U9/Lpt0Hv5wNCRXFMrdS2x8M1Baiv0CagGCfu4mvrlYolAZ5kiDU
         4sTkFOP3C+a9Po62CoqaKGoX0gVoc84YdmKVYTFq4t14SKLANxe7GQh8KfB8aPs/VGoO
         aVeQE2bVygHgBnOy3+Wj453nCLacCoTQsTVqqt1Z7e3pZWETCscMVLQrkFCLPqrpw6aG
         F16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=EbHcxwmUt8J1UdifjuYNDAQ40kSUGH220+FF5w/Zs9w=;
        b=ULWO7mFXWfRRURhIssMJLkNzmz3O9/kjcRh9TBGwSt1MQFrCqKDASF6d58t7jqPHjL
         fWQsKCeHACdZs6dRCalX9DtFZRZjYuqjHe5h45683l8phSPH2OGRmGHpBDYkCcvVmoFz
         M+Gg1rXCNkrZ53YWldquTYtSR6npqD5McVJF9J63VcAonHl8tn4CvclZadoebX7dJX5T
         vmPpX9uLgyET2ZUB0UMHfdiaQAMFu5hg1ZRb/xgflqK1a2uCIh82s/N+P7cydHul3hIM
         cFHrqBoJ2DmYx6fqnm+udqIT4cj2dalu+lrzTpRcTebkP1NAAkVRuy3FlJhUkTRmNnK0
         570Q==
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
Subject: [PATCH v2 63/75] staging: ks7010: Remove trailing _t from 'struct wpa_status_t'.
Date: Fri, 30 Mar 2018 23:08:43 -0700
Message-Id: <20180331060855.9452-63-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:r97Y9edOSBXxqDXT1Oyr4SObSa2+ZzQOQcr4UoHb4+PlWeEsPRo
 Ze8uaOJ2rsJUawhEt8jmbdA3sKf/GtuhMtISc3Z8+371rMMNosvxi2TTVl7fy7lJ8y5IjuC
 WfOjfOsMs5m1+H56h1gqwByqIxmQ+Vi20rSYs+JBK66z+aWJihW63h+ETifNAfbEvXQWHkR
 /IiXcvkgqyFU2WgQQ+DAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eyBbCi4o6W8=:5KgwDPCzst1/PeSFFhxsAe
 BGS89IPuXTEbc98vSiFOh1hMEVxIpxKuZei0Jpjm2rAYfS/4QZd7HqHtNGckdDnsYODib0a0R
 u1z2JglBb9QmbV5Kxk6rXUyYigFncetF6L3s/4OyBMWDrbDXPclzJuSFDj4KO3LR7u1+Tl977
 bA3/R0QWWkRo5yivqSBKpZfDFqe6YvTmwn6kw3H8BoBACK8uB+Cg84hunlNqVyPLGd12R9loX
 i9d5cvQqObcEj7plQtUsoXRTf32O9832DagUvts97Dr9E2pkWpLqP2GdeXNink5OutYlmJfBU
 dQj11epEBXP6kFP936TFjhw/soHSxi+kxm6hVgVB92NoyCPOJnD+NN6AFZA2IpUNcb1fiyQwE
 zYoHKIy1G9sQsBEoNuIsap3yJtumweHOt213DDKz8F+DezsshVRNPUYGE/XfIUMvZpLP9nQtr
 posxHSF/MkhObxfqnjLw6q3oo4bUnq2zMadgKduJhhl22fcOVk2xiMESRxG5dpej7FgLVYJyL
 rkiZaMzTTsQg+X8GN2NGNLIJykLKVMrmUCcAV/SV1GlVTtbHSzkC2A5VrPPDuvHPkf3/mIA5i
 x8Q6GSz/yRdaz+Dh+z8JQS6F3s02/hfBhgJjDUZsAve6OQJH2S7FOGlkrUPWqwDc5Qv4XpeYj
 7YbLMJmO4fb4RF5oXxjHUD/Y4psBnCqWQcGcHiy1bV8dwmUsZPPWql6L5o9vKvWwTxs5RH3Ip
 kW0txSv4xT1tygVMBrje4g0dQMj1DOsJWtGAJ6ov/fQs5//2zw7P5ZQmyvf0VSzH5hmw0vVsN
 QQlBDR9v6poYOO3vv5mpKzOp1FWkGKvcbxHSlsNWBIZDsxX3QLyeuxtEL+QIe4tTjkpJLUWNg
 rmgBXhw+FsVjv9Nvd3nK7aNsmLlyUm6iNKYoXbSB5gS7S4ZGC7K2JKTb4u3M1S
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432443282239165?=
X-GMAIL-MSGID: =?utf-8?q?1596432443282239165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct wpa_status_t' with 'struct wpa_status'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index c3e61021a75a..851721182b05 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -364,7 +364,7 @@ struct mic_failure {
 	int stop;	/* stop flag */
 };
 
-struct wpa_status_t {
+struct wpa_status {
 	int wpa_enabled;
 	unsigned int rsn_enabled;
 	int version;
@@ -427,7 +427,7 @@ struct ks_wlan_private {
 	struct local_ap current_ap;
 	struct power_save_status psstatus;
 	struct sleep_status sleepstatus;
-	struct wpa_status_t wpa;
+	struct wpa_status wpa;
 	struct pmk_list_t pmklist;
 	/* wireless parameter */
 	struct ks_wlan_parameter reg;
-- 
2.16.3
