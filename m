Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/QTmojqjPJk7LQDemBM5jAU1yN/UWeJK6QzffNvoH2VhXKQtWuhyxrfxe7J2Xuw+SKf9O6
ARC-Seal: i=1; a=rsa-sha256; t=1522393779; cv=none;
        d=google.com; s=arc-20160816;
        b=wN/xhgFRAx1VfqN/MNpf5ZjNG/LwtZawDZ2BgIdtg5pMxP6T8yYOXa8NkOPAxdDgZA
         qirWNJ6Vrr+1VbPWdXTnTAfqCS9bNd8/j3cSe12TXgSwzb1kM3i7jZ/Yd/dMz9oVgnnO
         Gz7wDtb7GmjNBcYL82ivL/ibKFHz0/QVvSKN6zGU107wNux14cqUcc4foQ3xR822BaTj
         5TKrVgYZXhpg0AfbgBXHQnCDvaQQrpelU1wJq3RAgtg7gN1C1jD+yM03rhgtEONKfOkl
         8uLFTip7oloh0oS4UEay6RLiFQ+/9W1WvOlrAaCtZ7zPSj2Joe2aS8jmGgrBWLUFuF6W
         XsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qNWlNvHUHu4foND/4OH3fSlvD3vJR8YNz5TQiQOocto=;
        b=o0Qiy7Mjx8Kou5TkqrG0BKCfU2a+oTh2eZ9A9Tor5eJJMHkIRV2WJ3+d+EgxbsxbRF
         A7c/poUb2sGFma/MafWr0hcVnUR5lAp9sM0AmcUkFQzmoEKlArLksaCtiobdubf2mBD8
         8YdfCfOEguY7plq1QEbBNdHoJB8ZqloZsT893YaZyJFcgyRq3qwQKg/+0DBGSr2I5bZE
         dL7GtOiqWLogLMcJTh4RZ43RpWYZucxza8AucOmSkAm6jYctpNR0c1zslQOR/d/rbxzj
         sG/UT/O3Rx/Gizy3eL1KAAfGsbn7JOwDJ9KyZCytANXgbJlXq0uv57eXO3a0JQtdFqIV
         V+tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 48/76] staging: ks7010: Remove trailing _t from 'struct hostif_sleep_confirm_t'.
Date: Fri, 30 Mar 2018 00:08:11 -0700
Message-Id: <20180330070842.25224-48-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:cU+gdAAdt+Ntx5mG0IlWGPD8SpuFE4DilmhWriliixAuhAzekxM
 IAchDJ0N4zCPLMa1tJ8DGAbmKTLT2v3+mXPBtKnZvOJZlb1j33KPuYqpI9llT114FM0cAOF
 JIW/R3HTe1oUT+fsea2V4bhO2M5XQHk27kxKL5cAlEkDy0ags/E0Ho6nWfq+Kl1RwvkP5Sx
 T/BGQ/v1YcM1sk4NpJL6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ZPdPLr+z1c=:X6Yhmt0QBJ4YLhg88TJ1/L
 HlNjiJNMRHMU8OaDZ+47NrpOVK8vuUAteA+JJbV6yPA/Jz/mhagvxtCUxPjdKz2C1dTH/ZkxG
 u4X5olKo/AcPi8OJHXn06W6V5XRDqASwSP5U25eJgIG3g8ovBvUPMSTKmTeQJqCnl+YX4yBE0
 sZlmjd8j/8bpEIZe/8UPlr/5zeTIfpQjib5O6G46DJvPoQ1fuY1Aqsg4pZfE2u3XwCh2FFoU1
 4EoqW5xQZlULmwMn2ZKy/D1AopLR0k8P7ol8xxZo7fkbONrEVCX0RfXkUYv+tknvFYCeyctwJ
 7DoJM6BDZHvyRT6GCbj1pe41mOvXwjskDeWSqWKCmO+wy439cSAXNlrSCy/FEqGga3fpE9gT1
 kjE5JFPc7TkijUlynBPjHWeAcnLjmwjfJLO8oCaci5N+Pdc2XwMkIXWX3xtWiHdUl08xKZcGH
 58foFMhaxVBip9vTam/CqXkScw/b5AjpOTsJszxx9Vm24cC+XXaYvCOYpXcBbBWiWmun0NnUl
 QbxZzPjdaCbzgpT4cqtlh/O+kqBYoyktqKqtA71WSzN29/bfZrasX1XhbOQK5EGNMFua3W1hc
 DEAosLInV5M6MpMF6DRHJDudQjKZABWav2ixL4OQrCFvauuwvHLg+tWffvK/81+Ub1Dofc5uU
 kTFGqEvKgdh628x6eP6atmW+F/fOXdz9IIdXWZIQJoYg1Zofce8HDUcT9Y4nbdRZ7ENhvFuxz
 vvP7P/RJcAmjoW4PeGleOTOh4GMMIvzrVaQGoSrTxyZcAGKsPlQGQkV+lsHFQ9aL19XFGQdz+
 Dq00a3bsTf28Ytvrp8QiitK8QTQsOeZhFZaZprtuz0pNRQHU4G7JES1nRrVSlX//EBFyL9Js1
 fZOBKYLIY2dZB+W0eL/HsoEebE1o8NP7Ajoy2VxXZ+kbWAix6FFl8YpNRe+t0q
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345580160371670?=
X-GMAIL-MSGID: =?utf-8?q?1596345580160371670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_sleep_confirm_t' with 'struct
hostif_sleep_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index f570c6d84970..c34bcc7d9a0b 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -507,7 +507,7 @@ struct hostif_sleep_request {
 	struct hostif_hdr header;
 } __packed;
 
-struct hostif_sleep_confirm_t {
+struct hostif_sleep_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
-- 
2.16.3
