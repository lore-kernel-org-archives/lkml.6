Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48LXLlzn9csL186ld5aoB8I71Vb+c8usXAtVAt/00GWCDIRw+eBwu6BKuAnrIMnRqKg8OAX
ARC-Seal: i=1; a=rsa-sha256; t=1522476565; cv=none;
        d=google.com; s=arc-20160816;
        b=CByHN2GiQQUSU/vaiwHyXJCnYTSw5qQfvNZF72GwbvTYjAanWPtfO6P7DuPVIsPOcs
         EZmK299JDifrODanFa3FZUo8H7muqFiLh78aM02JfIIxmJeKcYc/kWBgaIAF5juQIg+T
         JZxpNfSTI/dhIaGBI7U41qc9063EeJSAgJXrxUfuQ+qzQKvDZOBGmubtycai00Yb31pj
         fNRwHR84eP9c6+28c94h6INqTWzO1kQ1SNi1gOle/En2rmBCgXsu78vyTu86AWTX0Wg/
         nPzcmK8ciWsUcx1c1hHvYr68Z1p6STihR0aWdN7DbYhejmLzJjytV1gpVcSpT71nkCLi
         qZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8RdHgj/EYxA/zgNf5ZASvOARZrNpjg7BAXlDB1P00u0=;
        b=gUgHDn3oDkc9B14j8Qow7DG53Mh8ZT2upgneJa+oXXXnhuFGj2V+OGOBbJaOhKZm4Q
         VeFmYA5wiN+AuZ4IRsQv2UC2XHiRyE55nTv3A6MS3g/XkSafh5GiYflnzA7H3mxQP3v5
         0fx1+BWsENbdMTRO0AtBuUZrsWy/HUGiKO78WuMZv+Gai8tBVLrLUdFXUfkEH3VZ8QKp
         VZDZAhafQ+E8/NQij36n2YlHwg+UgVhJRNAsPav+8skkMy5poqKhgR2l4H5pRcv3uKuP
         hiEuF2idopNRY6sN8LVr0T+2tWRFEWpwiu3CMX+Wh/8CIpJ/fU9k/ocBRbvsvzRVuJuo
         S77Q==
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
Subject: [PATCH v2 02/75] staging: ks7010: Remove trailing _t from 'struct wpa_suite_t'.
Date: Fri, 30 Mar 2018 23:07:42 -0700
Message-Id: <20180331060855.9452-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:qas8M+7ZVjLbQ/X5kUBW20DxtEg/BT5FmhRuZMdXiGQTycd61F0
 I0PfLajraz4pHkvUQStUzoDCdvfoIDg/XCBZ7/XaYVDuSPAYJPsCWVGU7d+HPVc4oOtCHrz
 7r0HoS7MiX6OfDCG+xX8fZDwq2K+OIc+M6WM0BEwsuFV/evFYBwETT0NSsHbzsGKIOpb0ZO
 cg74+WzdK4B4V7MiNBfKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YEnCBRHj/Wo=:F5Wa+ErVEEgv1DZ2ParsFu
 Ay77M0UjqOag9cCgPV7tVz60a8VeWQeezGLPpTs9CgK1ZNs2+zgQQT7db7IvK2MDIf/IS2ODe
 vJriNBAhKdNIjhRlK4CW1nLyV28q71y4bSbHMDLXxEb8rMNNIRpYOeYGTNuIJV3YucxZI+ryE
 bTFghrQIylYX86RR6mXx94ydEryKcQ80pQYDVjbf/taU67VJmFcaXhZoOyNnnNVMl2HnXy6Ed
 tENfDxHkXlxGLAX9LkOvEh9nn0n+ffJO8BSry/IXRC3MosJkbDQaQY8Hb+Z7zGldJ7iMAY+oL
 51dXjXCajoLSht+/AZVFDUtDmF87sVpOgnAyzdPIQU1FEBD8/t1cxr5n4z5oWvyN26TntWIWI
 n92UaCvnhcJ5uqnF29yN8grv1oHE7rhPBA7NV5L5CPlzPqGLssp558dBU+2QT4dok3aT7rnBA
 xzazfTpNCTQgpEwyh3YRxQ+Pfn2NUyvY3xyi4NXz9Ngz4uLImm+AJw97M7gFmaPLIa9FkDn3+
 jrI1ZlDReTBYqa8wrKh43SkGT0dmSUK/33Qfc4RiwpcvnP+BCmhsCIpl7TRkkeFwQtqrqxMC3
 25DifpcjRw3X4hpamxOMFhj91VBD1ac7digKzlFqDEIdax7iiB85fkLjOplFrFmOxXaiF/Rmd
 pPdJU1R/Z15ZspDAoFDx1EnzHCdWiQ6Nxgq2xBpmdf8bClpn2890hfsR/hxa/nn5Mfxc5hEb2
 dz7QlVa356SA0QeC1x8jNG7u8kh8Mk+n7SeP0g==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432387231330445?=
X-GMAIL-MSGID: =?utf-8?q?1596432387231330445?=
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
