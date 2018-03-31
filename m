Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/QJbSaATknfNT1qDCfj/pt6U8eq7xG8rHaOYL2sXaSY60pKgeN+kYR2AMD+AVFHf36hcRV
ARC-Seal: i=1; a=rsa-sha256; t=1522476580; cv=none;
        d=google.com; s=arc-20160816;
        b=p2kvlFsjSjxOXeb5fw0fP0y/De+KqRJ1nVE72D320zC+LiGQ05vHNl5vzJVL8K6Gxh
         An+qqqy7eCT4BuydD80AzkW0kuQwjLl+Vhc0Vq1l4T11fDCpfem+g9s2ijmUwGPprfVu
         RlcW39w16NEpomkOglwmj14qcZcwUlnFxYXS7sjVd/NMtGbWLkNYcVimOyWbdf/mF8Rm
         f/JrHkiiIu6nlGnGZv7hhCZe4dJiFN8f4GQFl89LZyoFSqZJG2DcynVYSkdKROfFswtT
         pWRlm97rJ5QXgSDGsDK2qiYe8aJ6OsKpzszQe3qQ+kL3/rQbbtPf0ROy8h+oHzWM27Xc
         zSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=04vx/hLNexdoSzLxNZwQEZomB5a7VTJzPcBJLpsbYkI=;
        b=uyhGd1cu4AeFDtVQn22qcYC6PfuLNsIr3egvb++67HYn9VqX4prG5L1z5K498DRd9G
         mH79GeEuwnszLB2T2CckibwWQ//L9RU0L+VRkQhdr/J0/V+FItMsSWgW33d25nY5JBgp
         RXYIUrXCnPu96UsJptCAUOs8WluhP0Byt1/nTHiEg7bGWccejmKMYd+AOXUNrpBJ4LyI
         qEz/f+dXgQECzOwysp2dmr0OiQIAJ6DjPKXqJyVnFv4/yGQNlFYlNJUWzcnaWc/HaGg4
         kYq/qyYvJFvhE9l9Yej2N16UXfgcLU6JOpYZbyUmQN8SLqJv87N4U+7HkAeNBs0rr8RG
         4haQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 20/75] staging: ks7010: Remove trailing _t from 'struct ds_parms_t'.
Date: Fri, 30 Mar 2018 23:08:00 -0700
Message-Id: <20180331060855.9452-20-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:UEZuUmfZvsjb32n0IOkWhQANp2lQWoIi/coyJPg5WnX6DgK4pC1
 QTvGoEtS/40fJEFxDrMJBecwAWH3OZ04VTlil95+PVHdYPVr6aAgkUhoCqAY2DX06mDnllz
 lSnTLsKpB5pIDbK5yoXYVdA0iyGgazOx2Cj8UpPQ1rGuQN2Ee/pVJ2cbYORRj71aeBCVv0E
 DR5ouEn2w8gcCP5DatxJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zccO/Pvk6rE=:fV/eXEIedoXAo1DkaMv2KB
 s6uH16jDfAZ9eRl+UfM6IwsWhqBBrCkUyat/tjWg2lPuHJCcsG+9aVn9KQLmshe+qc3cR7nwJ
 gUtmxXevFT1FNVbnRIpKUi1j+PibHjT/F0JP/ofmv/vZA3A15terimimA1VzZ2Ka1ZPUHTKbL
 R+V2xmS7QTkgYxzU0S8TXvIdWrlWNQq8WWCVBgSjciMBCpZFQCftV/yC6OlYgdl7uzAlXd5zG
 n3qzCsruAK8BqGDZ8QFWhlNPAxc3UjIDhsZxQFf0HuZwSHIjOZnoe3tZQ8TL4aXMyHMEljBSS
 yOorYiRPKlJ+KwayA11jTDx9Ps2t+z+LnmHw4HmtzfLQ9Ilgv0GXtE7evaO+ZZ8Et9kjRiJPE
 +cXB2gf1poviFwu0VAgM5p8ZPLkQAvE6/mz4vSSIEe7p+PwOwvkvKCGRqyGY4Va5pEYIraTLp
 fHe8V0RaMMmmYAWy8TjmfZiahUz2+9RI4PT0x7LTaufuG+Q6A28WWqDenVStDbyPG04MobiTJ
 ffEJPg8DaaCnHyLoTjQVnDYzAhJCTz6sajI6GxMqPa3bdylkswfnM/uDpWMM3fA7i4Iobjogg
 51K8SCtpVn5PQayELn9ySiRsTbN6/wq6OZkQAh/+h9mP5A+3pSA7/N3rzcuExo3jIEmUBPZks
 Q23XlWzgL3RATqKQRhBzYnvbxxLT3C6tPTbzKZLLshDMKPs47YVRJ4OQyoq+qqnQpc87zj3r3
 MWXPyE07oB/CdpbchqQ5PlQUjOqQxUhCVjbAsg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432403143253386?=
X-GMAIL-MSGID: =?utf-8?q?1596432403143253386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct ds_parms_t' with 'struct ds_parms'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 384292588afe..c48730b7527c 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -216,7 +216,7 @@ struct fh_parms {
 	u8 hop_index;
 } __packed;
 
-struct ds_parms_t {
+struct ds_parms {
 	u8 channel;
 } __packed;
 
@@ -272,7 +272,7 @@ struct link_ap_info_t {
 	__le16 capability;	/* +12 */
 	struct rate_set8 rate_set;	/* +14 */
 	struct fh_parms fh_parameter;	/* +24 */
-	struct ds_parms_t ds_parameter;	/* +29 */
+	struct ds_parms ds_parameter;	/* +29 */
 	struct cf_parms_t cf_parameter;	/* +30 */
 	struct ibss_parms_t ibss_parameter;	/* +36 */
 	struct erp_params_t erp_parameter;	/* +38 */
-- 
2.16.3
