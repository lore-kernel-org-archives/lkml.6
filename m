Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/ULZOwqRHyeP50ph1arBMDUvLoKJnV/o2hiuGvlPR4cwax1O2MsYm63NP3cxh4BFcqOD/A
ARC-Seal: i=1; a=rsa-sha256; t=1522476578; cv=none;
        d=google.com; s=arc-20160816;
        b=QSPy1lV1ViTLdwHV78514MS0M7nhAokeimMBATT36sWn+EeJPbXv+C552rpOyt/m2B
         sFKy+VpM8I1U+hV+EPir1ajeZ8n/igiZ3r+GnRo8ih0wyRneJfDob6NVomFiQ3YxySk+
         eesJ+ojNwR86DDNkoBMYcYtNdI58ndSC5ON8M6aLvLuU4RKRbAKasTzoelIqiD5Wr/Ju
         9CHn3id2JZVmrPV/lLanUvXFKZ/z436iTXYiVApZBkw4D3j/IOYIGXgGQN1hAaKJFpof
         D5SWOICOcTzE7KbWlyGnBNrpGCUKSR6GEdbGavzJgOCMgJVoxV+yRJrpY9Rm7rNLv4iD
         WPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=n9RODlmCjgcAvT+9OZOHIqNKV69NQb8F3FHI87YoJXI=;
        b=t7toS6kGE7km8STJ00Mmy7teOMpTOVRl4eacYB9OoYTOzDt67N2LdxDlWYpbxJV836
         tHi/wfVlOEDZMuFwEpqhKvUgPs8hExo8SonJPMbYDvvkGH2ghHReCii8rokILFQZbKHG
         iae/fkEyEMl79y/2VGyk1zbsR9pNvFiab+STknu9TvQrXdPIt8qRfLl0NBEi9SjsNEdN
         xJT9pqxTk2E1Ln51QYnQQOYazZsMBjI5AswOBbyWxX1af31t12Dyw5RFgp6F+x6WYWnw
         a97BivnleXAqLAj40r4Co0c6CjvglE2o8vGmrj80bSClehzHtmu/YlyVxW1MURbFP1UM
         6tdw==
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
Subject: [PATCH v2 18/75] staging: ks7010: Remove trailing _t from 'struct rate_set8_t'.
Date: Fri, 30 Mar 2018 23:07:58 -0700
Message-Id: <20180331060855.9452-18-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:CRwOt2GeUbs8WA3MiKvzqRkB6HhZD5yDxrfGnFUOmyNc6gLR4oS
 Ye2PEpQElFEF4fXrbCzPowwW7KhU/6olGJJk2++Qp0AGl+m8W3B/+JoF9G3UtrLTIW2klml
 PokFGF7aHx/65mM7cQXhyryUycXf4niEDiAe14wtQLBIZiKVxU40Rx3W+fOdMYjE6xH35Yb
 tknPwqrnFQYU4tyf36pQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QCT7CebcdWg=:09lehaGeDNuXdMFh/LMf6O
 FFct5P4oA4fAKnqtFBKsJzlUa6tg+OSAo+PkQ5rd5nn3no7qqaiYRXmMYr9DZDIF7svAuMd2K
 znMBwG87wOfNsBPVNFie21PZoFpf39bYUld44YXCkCNVMFWalourxs/fZNGWdzUFd4i89eGAf
 yBb3ybDudTG1ClvfrKN5jlkvwvvmiqrzDpS4WVDYv5CJzBrWHQAnk2tOAbF7PiQDK/q0vrEnZ
 n4qL6abmZh2InICRBmFNV6YIe84fgwJuk8l8ve1mnbe/mxMmQtOmQrnEQbnhcfgIG2tn18A9e
 thrMqKexMgJpuN/e0NADpM7plkayc8u50BalrsXNuhbJLyf5L/NEmHormhCrFmieAnIrIeCQ4
 8A1qao4UHv5trhVQ/+7TMFJ9/tdQf08VQY+cjnN7hluz4FRbuqQYF9ycq9ICuF2fB7NfvNlnp
 XQgr+3wgNbYyHaisNPyp0KhMaiHKXPx1V9iEqnJ+v8fRldSCJOJZdGf7Xb3e2H78VuPX3twu4
 01dEEoHTy1Zjrdyn5Hi8tZf+7Ad2uK5CPa430SxiWYewEN6jGngAYllfKP0aq26opyMcj/GHK
 7JC/jq6+NkqSNiT4SCFZfxE4oCi2hr/TSgs6Dxu5jCHMPQpD4meA9j0jhtblkMRii46zy3b8A
 GvxSPP6JUXiPA8ibnnp051tdmOamYdeImyrQyFFRlRW22lA0LrWhmtl9jnOaTaegb82HAQYWm
 yfdcpqiXJf+zqmY+ctf5U0laOBZAiRDt0hzaHw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432400617834211?=
X-GMAIL-MSGID: =?utf-8?q?1596432400617834211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct rate_set8_t' with 'struct rate_set8'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 5abbbb46a804..6ce5d32718b8 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -203,7 +203,7 @@ struct ssid {
 } __packed;
 
 #define RATE_SET_MAX_SIZE 16
-struct rate_set8_t {
+struct rate_set8 {
 	u8 size;
 	u8 body[8];
 	u8 rate_pad;
@@ -270,14 +270,14 @@ struct link_ap_info_t {
 	u8 pad0;	/* +09 */
 	__le16 beacon_period;	/* +10 */
 	__le16 capability;	/* +12 */
-	struct rate_set8_t rate_set;	/* +14 */
+	struct rate_set8 rate_set;	/* +14 */
 	struct fh_parms_t fh_parameter;	/* +24 */
 	struct ds_parms_t ds_parameter;	/* +29 */
 	struct cf_parms_t cf_parameter;	/* +30 */
 	struct ibss_parms_t ibss_parameter;	/* +36 */
 	struct erp_params_t erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
-	struct rate_set8_t ext_rate_set;	/* +40 */
+	struct rate_set8 ext_rate_set;	/* +40 */
 	u8 DTIM_period;	/* +50 */
 	u8 rsn_mode;	/* +51 */
 #define RSN_MODE_NONE	0
-- 
2.16.3
