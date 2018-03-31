Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476690-2-17276292235836795108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476689; b=iihwLOnXwFJpdXaY9iQi7yNGTVPVjPU/hIDhnTE/RAjEM2BqoO
    KYHlxbEXaH4dLYeTCg1DZwhrqKgiBsPWQKU3NNY3LcqmzWBlfqC0R62dQZF8+yjk
    UnrvORdoHTs602dHJc75NucYBdR6Y77MP0UqE//QKzxtjakrrQar1vgPwLHOt+gO
    s/CtFMwLUD9rjbT9jwV0JB7nJmcUWRNj2dLLI5iQGRC0f+FSWw9ddevlz/1/D+bC
    CHFTunHA0Q4nhzCcPed5lqv+4dX5aUzhHipQdGuqlczOx5IewCaZy6L/fEGA3j/y
    gMH8tlctm2DsCqYZaWL81aZk0FnSQmNjFHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476689; bh=fMks/
    oB3ugEJFhYnwoDwcFsl3417I+PV9sBqOJjfhTQ=; b=FNANw45WdCMNWApfFniAx
    dwIWZnF9rMiLieRbXQmRM1qK68Bng5ADAfM9LV0o9PSMUpUtuQW+xUuU6skkzHbu
    RS4wI8UXR4mvQS+PPCX6AFt5RrytL/WnFwwbAgcGh7AWnd0mn7fYhZV6mwvVfs5z
    H2e2/QX7GHQ+Jr4WL0iwLCUNZ1uKekSFcI84/YcrtB/T3Ama0cNlQPmMTPPhiEbo
    Dkp8MCYaR30JMAC/WYsYmh7gUYcZ4Hn2wnHrU2lclc7F9miWQSKbUUGHD4NE0C5o
    F8f+0cVcBf3+XP7hMnYAcIC/YS0zMh9us9BEvy9bMW6SC8atcdt0Lk6X/G+a0cNp
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNiO3t/wI43RsJAeW7d4C/k+k4W7c3J3ij/IlJ5OaAt+7XhBLG4riUYxlOLRGNU1D6tO0hMom5XV8280osK9Oj/H0IiK4w7WDlq6y4/eFq3PDyyBN65K
    T7gHnd2L1eDjkHnFvjUnP8WiqJvoLhilX61DZvZK5bFxyA32HAV1gMTJePZlOO3wSwo+i80KsCzTF0WdG9T6gEJMnCQZUNqoRZzSS3c6L6RjGh/zVp2P00Ho
    9huH3SncS7gGGs8BwLMxCQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=-q2jcc8F0pyjvDlAokAA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 50/75] staging: ks7010: Remove unused 'struct
 hostif_mic_failure_confirm_t'.
Date: Fri, 30 Mar 2018 23:08:30 -0700
Message-Id: <20180331060855.9452-50-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:UeNbhKcvMC+OPSYjtL2mQcPwJLilaFrcdCEI1JW8F+ukw5DU9kS
 d4ZZVyebngZjRqFo+PaKEwCjfwpv9jv/4KPiChYqR/pPxkNOgAdjbU//HNIY/Tgy2gNaPsV
 UxlKSgI+/FMCCNw0UAeSEhtpM0rqss27L0bdsK36qgbR1cPRWm3EywkkL/SzFtuUitNu9E/
 U9IGftUZI0F6idz4qR+GQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HhF3jqgNE+Q=:XaIhMaV0gG6RHMn4HnLqMC
 Ivy3QYJH3b5ywmSdmpa0ktqEpLzVBQIipFYEpX7h4qnbBuNjw59pMtLdtKfa/UixxAPmXLAOS
 am/afzq45LNQRqplgWcl87CMZnSnfy+/UQQtAAK1/9mRmGcPxS2sqJEv1ttwGNHtNW5K4O+s0
 hYV9/1gIHd5gDylpnzvOQfehjGtin7m7CtVa8+AP+eOK1Y564bXrIrmnTQ4ODnTf+OejDdpOh
 lfJ2JnCn43WGf7GyDGGCL46CbGslKMohv8QY3SWafiZTttAq96cupVr0xIqfxdExEvPCRLYK9
 v7ss4cX8SsGAa9pxy4CE8gIX517rI0/qfb+lyB0o7Smrv7kttO9/6WKjbJ/rb5MvhQbpbJ9zw
 cEUXWYe+mY3pnmnQDQ8W4sGyh+OqL7USZcG0YJVwFt8auQpDv8FD8djUNSvcZjU8k7smHEjwP
 ex/WzG9kwlEdfkqUdtlmWn9NuH1dVo/T0Q8PJw5JEbT3h5miJUM8elbMpnAfvE+RnHO0Ki7L4
 EQshIYscTZGHNb8JI8lFrEpta12ryoLZ3nFXEaUWy/9/2UvlgmWBhKwu6So9wcPUHNSfnRcTO
 FTw8pgR9HDyOc1MPeVlJ6REcTBdH+XtzKFrpyszJU02nxmxKzgPZwmNMj+7SBTGP3PgkGW3Fj
 VpNdsTuv9u68Vwg0/wkdNvW/uMDkKqjpTPKZsibANY7zx64l1nkKJ2fw43cab3sjJ6bARdtEn
 FMHumCSRKvcuA/7Cugz8usuQsJGpSdX1erI2N+qf/Gri1DCazZLUDJgr3PzZ2/KyVuZKS57DM
 9glJWVOwYgMgXZq7Lt2kdJFQfDiawYpwqnnEMwhu2SXBean85NZFqtVRff/7GfWADulrGB8wT
 E2veuwcb/yJKd0S3YglrJNaXPi3xx7r5VX9n3F/TcuPrgmLTn4sCYRjThfs4Zb
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

'struct hostif_mic_failure_confirm_t' is not used in this driver. Remove
'struct hostif_mic_failure_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index f6345779a039..c087484b1507 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -424,11 +424,6 @@ struct hostif_mic_failure_request {
 	__le16 timer;
 } __packed;
 
-struct hostif_mic_failure_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-} __packed;
-
 #define BASIC_RATE	0x80
 #define RATE_MASK	0x7F
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
