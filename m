Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1160787-1522476734-2-15977986612923604546
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476733; b=l33S33i8KnNLm9bVky3FMJvdtNc8ZEXtBTdYMjJbZF55FKGiGV
    GFTd4zrhyKE2z1aVvwG9D1IfDq9hZzVPgdTS+UGOrFNT2B/uDHIli6XsUH/HKsUl
    slaeE6FeWZxpkH603fWr41V8Sc3d3Bt2k4Kpp+K53/TU2CZEtmsjX1NVo26muFTv
    NU+0T+pHVnTyacp5ozJO0dmWuY3u4WuMnODeQI+ENDYaeGkSL4YodZYDFOgp3x3n
    Dm+cZoGnyDu3Br8VVGK/0fGz9F1JTV9PK8poUqK8Ana96r43DtZB08dmhrp6c4Wc
    cWqecYMBqYZTy/0C1j5qmcYrCZYbdJGaWBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476733; bh=9gq5P
    og1GAkVH5h0PySDA7Pb+izDlwHv/2fN4s2V5Uw=; b=E0g9aUxmzYJRXa7DfJ15f
    iOVDwbZLw9bF7yl0vTfQVxlrO8UI6VzkSNzn6kdRdz1TzqSvLJCGEkjLZtm0P84V
    G35CUn8CGpwUIwnHDAdxq9neDCr8UUUoOA0vPQdktcRuOo587kTFgCNG1jn6ut+b
    yYbZ+atg7Hx7lfDiCOY6KuUozVFlL2SX8yr6BfZCRqxZ5nW/pGRs8JXICxL3j7Es
    9bdMtNaWkU82Lk2oU2E8NDR/adHrreKGqYtXPfw7BeD0mWFrO9bkuNhSYPxM+mGz
    3PQALPJu4x8dED+VTD/rW9EQuAa6ZONKVIQvZS8v0hTLp2NFkH8tq+c6couSPVh8
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCfxTZyYRxl0Egxc+ksR/br2IdLeeaLPu8ZGrXu939Y01Cy1/iwkgXBqLCH6soH5mVdJ/thSYbpTVTnLVyIubDibEQWmMAn50EA1Jxu1RO7ebedITjcm
    W7EGPCKtmDOG+ZDt3rCv/IFMFYT5NwqRqEQi3JtrbuIO98SIu1UIFD2APiBpseqgYCDDjd67TJNZJdIReLMg0AimdwkipNjG/zVZcm790CJYC35Vl9ZvDz/j
    3sVLJX/iHnoQ5O3gdrjnAw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=MBXM6yTHWV4dAfAIpPMA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 66/75] staging: ks7010: Remove trailing _t from 'struct
 wps_status_t'.
Date: Fri, 30 Mar 2018 23:08:46 -0700
Message-Id: <20180331060855.9452-66-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:lGdnxzfiyIpfvfU+zNwhtOCNY9XBOBTKhqW25kXPTWpWAVM01HR
 oMpgSLoqDXG0GAXbIQCmi2/xtTxZHrGbKyWUqZqhbLBKncQqQ4+8997VktxjQN9xwxuBUNo
 dF1nXdSUduw8zAhiM9qplMsJTsjgtHn3GH9GPpx+xI7rvwfxQN9HQNWTp6O7PRGa6ZospYU
 GsflQyO88+vLoVANpdjiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A2bCeesR5/k=:qkjl/h0FnUinxzu60DYOYR
 Kkb4uaFaOgdaWGBIvqFCNvd1sMIYlZ1vY9clJIaDCYe4YFGlEnAz/5SCgED+B5LOM1F6XaecQ
 42DbscxyhXebH2NxXiE4ASe8x9RNmLWgx9Ody2RHT69KvlDbnZdglvLmACEab/2X9nLYJhQa1
 YvFbBOvoHfQiySABX2f0K3e6w0ELl9+ZPRPzb0hHHNOE78Ou3+03Pa60ka2tkpmYNBr+UEhJL
 lHUIRBidhpq1B+pUwDeoELQRICQ2fhSXdhHwND8drHUzPy2p892REbDKokHI8O/CRgKTM7k74
 iD0fshXYqgY3A4tfx5qc64oD7T9ZKorDJm0Yhpv+roj4z6dMy7GDjkaGZjeyw4BYcxIQ9mlop
 1Z+9BXMtfuvzrGlHOG0jwZTCG/eNzpxhzn3bd4okttRKPYOvsLTN1b7+HlHM/9ty5cgT3g3rN
 4Wv/WcbPs5ZRztuPURXsq7zvMtAjwPQS7In52ij8Dd1hNmW4ADQmbdvODekRIxFYHWkKELjkl
 82rv43kHH+K2xGi/EKdvAWsc2JxfEash3/w1V9gwkxp3LjVWhkkd7cxEWQTt33CIMomtpzweq
 q9YrJiphVumLm+p5itXo5W66VPLuyjY/wUh0eDh5/p3WnD4SjM0naREQnLdxp+vDnnZ2Te5cX
 kK52wwHVi2GnC4o+389+XrHoc8d5p5v1Au/25fTywxaiFzBNgqAJeaXIweLpdCnsWW6kuiTCn
 wcOqHtav0b748CvpR6vW3FcyvHhAtWG3xppQAAjR+ypOPC0hZgxHxRQzkB3jCkxsT1FQy9Mdy
 0MAKq/QgV0sorkCP860bu9111ey8k7dS9NEcVLqcbemt7oBod6qV8xeSAYD5vNPL/YtWh37rL
 EuX2/zomn3usWezrRftgWR6SrtuqhtKEKFzzs9xyxXjROIl2ZmT5HTW9r0JRk6
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
all occurences of 'struct wps_status_t' with 'struct wps_status'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 20b584524a77..eb0c14e78bd2 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -391,7 +391,7 @@ struct pmk_list {
 };
 
 #ifdef WPS
-struct wps_status_t {
+struct wps_status {
 	int wps_enabled;
 	int ielen;
 	u8 ie[255];
@@ -475,7 +475,7 @@ struct ks_wlan_private {
 #ifdef WPS
 	struct net_device *l2_dev;
 	int l2_fd;
-	struct wps_status_t wps;
+	struct wps_status wps;
 #endif /* WPS */
 	u8 sleep_mode;
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
