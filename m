Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48XTWOxDF1664xkLW9hJFe5Xa4jz9AcX8v2gbI9h/RL08EQNZ/W+KL9eiyfE43MtiSEb8HY
ARC-Seal: i=1; a=rsa-sha256; t=1522393786; cv=none;
        d=google.com; s=arc-20160816;
        b=YreWXclfpiEHCFTiMOvxkjDeHO4Ep1qR5P7uKv0tX32YjiblWg03khEzbsNBA0KTWn
         uYkcUkweAgK4pPBjm+CI/aVFm+j0oRLmFgF5hqYku7VNydctRvGlCnjjSZ0dbLCJoazZ
         /9EaOC930LTr0v6EdVsbgnBZEy0YOhLjFr4rusA8UR1ol6ZXe6zDkGiLiB4SMOS7NYQX
         kUoIgclPSxkkSqufcppl4v8ZoIaaUmPmRoZbo2ZbL6KzCpGB93d7UtYXWcaG3m97+Nxh
         mJM8OFHdUEy5gbJ2jGnuWzs3W/AsqXvs2jhmoNKGaj5J4rbLJh1JfI5mflBYAWQLOgxp
         fxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Jq3oZ0F6vDHUGeKSgbr9S4/svxNg7TNOFalan0VPrqM=;
        b=oQ2IWpSR2nhlUqfbjDQSpHiuFQH4EjO5SnFRzVoSFp9AF7a6cFm9OuD8KDPYPh5iDj
         zYKT+cUO1eSFQNZN9AqKxtbX5XqzetlFKQh6Cc1hqcDXS6LWcrfqUcq8IM4rRJ66aEwi
         WW9WRJCetTaiJEimjXiJypueDooUQqeDQd7dZkAwep6BPuzDa4mUsXZRhU9WHa1hM77T
         36I35mTcYBEumNjGLutZyRXIuK79ybyQjUvpNKI6Jx8jxtNFPMPd0Wyfs+KCnWvK3LR1
         Fy+L5afYr+/wEq/awfnlYReSgLanUKD4+P0oNBkk00xY4yalZdrJWefD9w3Rzov3avbW
         5Cwg==
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
Subject: [PATCH 56/76] staging: ks7010: Remove trailing _t from 'struct local_gain_t'.
Date: Fri, 30 Mar 2018 00:08:19 -0700
Message-Id: <20180330070842.25224-56-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0://AL1jwxqf8PXISGnx94qrlmJJnI4ukqzQxJ3NIPzLpPBuW80Gn
 0uBPHFNvapA6rZbxXaa5oeWdvOP2eMmh+ddEuFqCg0yPYnqkTAg4FvekTH1e9BLllQsWY85
 U8CYONfS7GQEMDP/43S2aytumzIWGnkekSeGALhvHLMYYosVDHsyuQh05n10hnEgsAa6RPn
 CgBQevIEU57RXk218m5mQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w5e78wq1Uz8=:OtX/MdYfBk/DCrR3UMRn3t
 XPiQ9qDnzjqnC0B2q9kmYJ0ScmZ/XpMU34/y8TruLvkW3cC4jNuhKdpgXlP52s49Kjga0x2er
 MpWqm9LmO0uf/mdUy9y+poyeBBegyvucQdb4iIS6DZE15m3MBHbJvf9sjk/r5duP3/x66IGzp
 DH08wXKwywmi48QRh5gGTLgEhiyiNynKb/F000dNvFeDoRnLIufAGqGgOeAZN83d/PJnnEQ4b
 6PeHbSevGjAH4+5mQ7LgAZJ17PDxZ2XmN0R9uGRIH/bqoeH1qRgnTJ+xeYweN2h8eQNylS0QM
 wkS9D5A6G7XwdHa9jU7nRa4FuA9vpDA6u7T7XwY0NxQ6r/57u8w6LEHafYfZ6bbRTuZXo0IEp
 ByklhG42PnGkPbTQeuGIFyAiuPDBvTFmpXdboJXahHSt+16pkzgDP2SsxEGwbfBnnH9J4gTth
 sVmq6Vhe0dhFrTjN+zMKb948WaIEpGJNegFLfesLLWzPRRD0wJjzENkHyNB0L3ha8sAKy7amM
 dTok7NWQnzAhJJdzLcnFQe8C/ivRyuK7WaWpBqadFP5Zz8UIGJF/iSl4e3MFlo1iC6lNm+7Mz
 uch0rnUKe64lLkICTVARJm5n6B8THoATGgeMpLDiMRLXPkNq6+Ux2ZOwWVoFyXbdB3ApoMVIx
 7fiNC9+P8xGgiWbMRL2SbilSvRC2na/o+nZ13fzUnww0F00Z3WCXfoD0kd7Jcj1UzNzhYWvrV
 U+Q3VPHyFx7WxKQtPUZmkspbb69Rc/zGi/Wp7QeuSxj7EDEcC4utfIl39D7gl38UfslkuBhJm
 CSE4IeVs4b0Xb/yTen/a3BKH8yuF7FSV+C8xIPQAKwedzl2YJ1AQFF73MNMBan4yZTQ4A+RMw
 2lNYmmh7gkRy+HeEri7o31rgivrA/3eM4c+VISbkX+wfZ7CGJkKiN0hd8bKS3a
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345587311059430?=
X-GMAIL-MSGID: =?utf-8?q?1596345587311059430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct local_gain_t' with 'struct local_gain'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 57b21d3a2435..e6c4a0fece54 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -249,7 +249,7 @@ struct local_aplist {
 	struct local_ap ap[LOCAL_APLIST_MAX + 1];
 };
 
-struct local_gain_t {
+struct local_gain {
 	u8 tx_mode;
 	u8 rx_mode;
 	u8 tx_gain;
@@ -471,7 +471,7 @@ struct ks_wlan_private {
 
 	u8 scan_ssid_len;
 	u8 scan_ssid[IW_ESSID_MAX_SIZE + 1];
-	struct local_gain_t gain;
+	struct local_gain gain;
 #ifdef WPS
 	struct net_device *l2_dev;
 	int l2_fd;
-- 
2.16.3
