Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2927865-1522393796-2-4217814963503219398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393796; b=YSeIUjPfyOkslUJA51t7TGhq/U74cndwjzpIdHCXlP8FpXx29e
    +ICZ2tE95XzhN2Mn21NeSTei6hDwQLQrwJo7S7X5wimw3Ogu59TZLbaibQMl5Lqf
    AS9827Vh76C2JqxCfroBINvk62Ld4I9ACctSOkssegCGYOOO/WvATN95RlTXaS4z
    VrrjRM3Pic2KbQTIzYjNiasXSAJyj3gEu7o569ci9AsJHSEcwItyGEyIBmDo2Rbx
    Jrq6dEOGxFsWCxs0QjyjLQN36icr4O+SjRVcm9S71k3Oh0D1uqXnwpm7VV7fhZb+
    LC58+iqwf2XvxDTSwvMUT4BhmjfAHSohLdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393796; bh=oSo4B
    XOojuK5f/bjLZeFa5ZxjP06wBnDbcg8tfkKtRo=; b=fbEt4z94HLeOIjXQ4f4og
    D1QNFw8WzqS2h5mc+hQHLbth+KCDcMMOGB7R0ZIVgHcQQbvNwWx6fTSK9RdIlA99
    BHlbb8Mhqoq3pwM9vvhUjmWbj5KlA/25MRfnUnvh9OiPTFi+FpU6Akv23Xapj1jO
    5YBDg/Rl9h21sLw2KkKT4zMV3qBUCPyi0dEkFdlCLyXpKAF3tiWVAMxWWpSo1ye+
    frcWIzlkl9ymDnUmmBp3ZSqMX60AlVh2oinff9ptDK6OM5hM2yurmJMHIn25xAcL
    ljf0UcvtYHZC3jYtAj8YVB+yzkCDGzypAEsPSWq7hNQL1UPHNC0zO3vuSC7lSBOz
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAKONdNvunf2PxkMu6TKqpPhXu1EB+iwdNR1I06Pz0Y/vU0gDh82oa76S/mqDN49Z2WNtxh5/fFfX7JA0ohHHpUeZeAb55VVZtGzyl6nMEzriMSkwbCq
    idB6co9tbqteJOOqoDlDKj9gT2KPVJj1M4Qdgl26po2f7XPdV5T6xfLRwkvyDQA0piGpI4I7eHJo34Boq6NHn4KVINN1q/+raRzmB6RWoIFtfsgF0z215dkP
    1LcMCdQHO4/X4WtcnqH4KQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=VWgisWAj3vx_v9YcBVEA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 19/76] staging: ks7010: Remove trailing _t from 'struct
 fh_parms_t'.
Date: Fri, 30 Mar 2018 00:07:42 -0700
Message-Id: <20180330070842.25224-19-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:j3waek/Q+3FkvKzjVhF248BY9OJw7g6INPHCo/FY4jw5Kg1fDeQ
 4cWqM6M+w40Isnqvrx5XsEWAhw+pcf9TfcA4TJgakZLlnsg+TTDJ58Xf7pDNZ5jn9sGP3cV
 9SceziJ2BHhDp+l/tI/hMG892BaBYq/MpXOoFOLl8Mc/+2XdOD9BDgeMX9IUS3qTTPR86+j
 4WJOFUt/xNshTvg4WXU+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RXt/7+YHgMw=:SdumeXkak9OCFU1yjHc3yi
 MLrTDUgqZnhM8bj/Gh9vt+5t09AsQfohT8gkTputFLA1wLpPt58ruZhDJfgdJ/tFOZo+p91Kg
 6YBDB+E4gvIZ9GeNhUwZvyOtLu94G2M7N5OO8+e8TYyiNj89LKsixbsCbbCCaJNs2mBYbrecq
 jKUX6KpyTkOzG2ZeSqFJoZlJsXcZuIQgFLGCN8jvqxtvsBENy3rW/c4Q2MuYA6RKiT3VBbH1G
 rSfJ7n/CcNRwyA9tAqPsFA18kpZKzTvssWr4g8Sl1NyMlD6PdZzgRaYh045cl7SMsFjAF6FAd
 UuEGZGn/EJAWxA5BtA6JztWazVkXYXns1ViuX5tiQEf6hdVRpcGg22PSj5Nx/R9PwlABuJ6/I
 7uwjxIfg7ePSrp24sY0hEuDneweYrTjChnto591af6GRn4+vJml4VLlROYE7zzmo7t/+4v5Fy
 lWZxgbKVnN/gZIf4PztG05xYWnPfugyZiCjMG8e0XcDQ5jWx7BlbUkMUk3eHk2OLREsSoPfcD
 6jhv7dRUJG1nA7ck4xW/h6kCtYvQmKoOCvsnV+z7YhAxV7dwBuTUI0pd7CSBSXGA4dg1+5z71
 RcTELm0uYBhrtOjhFetuYM9RlOPeCS59TwP9oOS2kiwPo0X9gpkycpNB8/fpzfFP29JMvzjTH
 yX4FMAHhxr0AP/ALDp+Dk01Mtc5cW6NKoH9ixu5hgM+Dbg/XbFXnAUD+0bxkeFpkG3OVozsB+
 LDILlby1zvagLK2K9WtrOqreM6dNha7G3vQ1zw==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct fh_parms_t' with 'struct fh_parms'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index aa1f5fefa818..697cd52292f9 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -238,7 +238,7 @@ struct rate_set8 {
 	u8 rate_pad;
 } __packed;
 
-struct fh_parms_t {
+struct fh_parms {
 	__le16 dwell_time;
 	u8 hop_set;
 	u8 hop_pattern;
@@ -300,7 +300,7 @@ struct link_ap_info_t {
 	__le16 beacon_period;	/* +10 */
 	__le16 capability;	/* +12 */
 	struct rate_set8 rate_set;	/* +14 */
-	struct fh_parms_t fh_parameter;	/* +24 */
+	struct fh_parms fh_parameter;	/* +24 */
 	struct ds_parms_t ds_parameter;	/* +29 */
 	struct cf_parms_t cf_parameter;	/* +30 */
 	struct ibss_parms_t ibss_parameter;	/* +36 */
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
