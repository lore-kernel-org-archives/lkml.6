Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48d/6gpYUIE/86RB7wE1BROpQ0KfEowBA8sXhnl542OgZ4zqulQWfoDxIs0lFSx+WLyvvFq
ARC-Seal: i=1; a=rsa-sha256; t=1522476584; cv=none;
        d=google.com; s=arc-20160816;
        b=kTPdqZsS4efwsWDsszsg+o0UmzzpApxHb8aEuRZESfzSS/Wf+kr8N6k+wZF8NQuM4w
         j0CBdHF5B7hX0kpObgzVztDymAB9OkoMnjLpJG/Rr8ATYakyCz/m0qvcnbNtTFtYk8DI
         A54LBUfsrcI+Qj4eY4dogle5FjW4poco+Bmk1Ix6IKwVWyqUBC05mN+gM9bB+l0Nm9Id
         kjOHgLpzQS3qYWT5bOhnXtlHbfBDpxjW4Q183xaxJLm/6nRrrFMbFyDFE50nr5gnYg/i
         cXQzjGfyg0IG9K8XePxQosOyn3RqiKQ5U1zYsgL2Fhh1RaqteDPRBNyvj5r47vehXKkh
         PPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QN8GD3s7cZzdFlTI+oWXNOkItTm6n6+us1RXRz3pf9c=;
        b=KNioOtpF3gr8H8L6pFVR2j4IHpc12jC+sO0FG63Rd6VTV3HabTi8I8Tmmdpz0reIyM
         Ap2zzgEWvCz9J4pdCGFGk2GNYIDWWtYXLtwG+hOzZnjJ8228KeYDH4OEb9xIdTrSysDc
         LGkoLxG0IC4kTvus38w9iMjpLj5mzhncdJinuw9VnzRVP+AZbea7O/orTj4CpX3QLHhB
         qsjhrqXO8r4L7stRWn+ZFUDy3SRWunhurrH0YFShorJXJDA/wnJSFasrqAvJdD6GJFmH
         KxpiZh0OZMIfTejBn/XWuy2FN2FK9LYzwcIi/zrXFNk4pEGpzm/3UOhH3N9GlP2ytZmW
         H+1Q==
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
Subject: [PATCH v2 24/75] staging: ks7010: Remove trailing _t from 'struct erp_params_t'.
Date: Fri, 30 Mar 2018 23:08:04 -0700
Message-Id: <20180331060855.9452-24-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:DyUKbJ2QyPwEdnxFM3c2n8MN8qS+WFB5wna5cdENakOBqcpXf6p
 43+9F3L4ZcNK5ujiemiA8H2+yRT22B8sV7Vrs8jszOK2X3hiX2vpEBqAnsDNKFlt7AWV2q+
 U5RX7+QPMWJsNAsVdZfESNcjBmVzL/RC61n56+j/PH+C95vVU4J9mDe4s/22mLc0/zqZYT+
 qigNEdYm5f/bj5+b0c7wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:98M0vxc9ySo=:EfttOGKMwJ8mbNv7gb7J/k
 T96d45O6A11CLQuRgNqUZcliMfiY/jAWf1FUb1skq0EIWcYkW1SDlmeY2+RkKW828/yFaZW17
 F9jAJcayJkuXQEjNiiJQZTzXDtvzg/dFfoDq/CsnTa+ys0GbW2X1d8SifjX7zPGi5iVYLBIau
 2JwHttxZql6Zb2FMh8/E8SyBy80S/hfZOYdQpdKWIJ+2IVDXS9wvguoitqD9TWN/cqbYNfW1h
 x097sJAakthQ90EChBzGggeiJFwoO+Nf95p21HCoBBBCVj9CZfF3JTGaT298OTP7b0eWFPG7f
 A51XseTrS2XfZtjTtZKRxdTq/9v/T/HwNfbbxRHG6qXtO6tWcGX1/bEONcVMtEtRRTKn5ZQ/r
 9zAibULdxIx9tWWl/yirUJUpTZltFFv/pTk9NJ1JM0l9E1ZR5JO1G79i4zU/TBjvJisCCCrEC
 nsh3i7kFVreKrFOesgvrWAvXu3lqH2zdlBuIQS1auKrnjJx3byK3q+DkzYWbDRaOCdjyPYHZZ
 k5sZvOKhjfOuCEwLeWCHHjEHp0T4u8QbUXdh9BlJuRWGEzgWoG/WTY59uTGgiaRdE8JD8VbiW
 3kA5a3WrY7Z/CFJbH5i6VrGve5ySbt3ikvhA8UlUTLAuEsORIDWbNDRgDrn6qY1+vzLEyIAWV
 K8B8eoSd9xoTHFmArg6rs2u/LS/UxmyaL3759Q0dAvGZCAjX7k+d2lHpQolPwViZLOyXfUOkN
 /ZoyWykZQyLx14hvG9vD8tCpvcHuJoBY3sOw7w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432406682198581?=
X-GMAIL-MSGID: =?utf-8?q?1596432406682198581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct erp_params_t' with 'struct erp_params'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 091bc82a99c4..4dd11307e4c5 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -233,7 +233,7 @@ struct ibss_parms {
 
 #define RSN_BODY_SIZE 64
 
-struct erp_params_t {
+struct erp_params {
 	u8 erp_info;
 } __packed;
 
@@ -271,7 +271,7 @@ struct link_ap_info_t {
 	struct ds_parms ds_parameter;	/* +29 */
 	struct cf_parms cf_parameter;	/* +30 */
 	struct ibss_parms ibss_parameter;	/* +36 */
-	struct erp_params_t erp_parameter;	/* +38 */
+	struct erp_params erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
 	struct rate_set8 ext_rate_set;	/* +40 */
 	u8 DTIM_period;	/* +50 */
-- 
2.16.3
