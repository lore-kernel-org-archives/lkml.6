Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476704-5-5988597769240431409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476704; b=b8AHoh+nT2rZuyyH5Y1VHnQRVJS7r9emJ3HB7jmWEawW3TjMsr
    gxlPUZ1bYLwXmLZg902GhdOyaHuV2nhOG1cLgMkc4CfKSxMUpmgw3PFa6sJWvhVt
    THC2U1Rgj5GewRQNI310dmQFhKUoVS6YrAEC0SF+G/o7uaaDX7yGAS8ElLwImyje
    Z5Emr2j8A6Gz9xBGUUz/VeksYNKwVonG8SqaR/2IN050upet3hbJSZPG3ntmTrLJ
    oRk/dWk+8HCydoKGjcPH4pLITBxw5Ecs5V56YAG+krPlbdJNCIBZ7p+jy3CbCxTr
    waO5VhRV57YhGCPPXs3HrfJC9wHDKcwObJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476704; bh=gMEQw
    /RerUJo6bre8tpvBU2qUDf/DtcmZMdB+Y6Pp7Q=; b=eB2XxXSdOUOUZPW5eRugH
    jiSYniIwfkms/+RCvis4AqB5xYzec5BVZ5i00jSaEpoUGUK0F5JX22Dk8TIlYKED
    8KZRLVhagIo9XnmJlpnMr98UG30ZrdERK6u4xB9Zn1FKMtm7uPfkfOt4jNRvRHn7
    HDmu17zZ9AfYquwQWI6wv3elVTEZ9W8w53WGUd3O0+0ecUdPabNhOPfJ+eC322i6
    59LEu4gya8iHPv2sZGZQvgApdHsm0g8i7bwCHsRxzCtTAUKjUlVLwtZ1nqdT+qUj
    Yfh2FpWwKdHErD0HfhEeg+y+w8pVAcLvGyMr1XbAUy+dqfATFwVAT6daySvjWoeL
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBSnz0G8Z2yen+bezp+e4sbTSWy31zUicrRHK2SWHOoaWf2IPMoYpi4mgnsjGfb1YYiVnXiWl9gKC1Aa8vg9l3fDIp/wtgKiwAHZB/v6gG1Sz8WQW57L
    Btorhmf5xK6+INpF7SLCWVhVxnq6PCJOZ+LumuI/bPr8FLBP+KigXYToeONlmzS9LjMZe3ZK55gKbBgKJTsXQQEjWT6gtVhEG1ENe3BIdsX6Rxmw+HXz6nK2
    xiQUZNGC4poweY6Jbr1jOg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=drr2OVim0_CWulORZkkA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 48/75] staging: ks7010: Remove unused 'struct
 hostif_sleep_confirm_t'.
Date: Fri, 30 Mar 2018 23:08:28 -0700
Message-Id: <20180331060855.9452-48-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:tucsjpI6C/Eyk4co2xMZkYe7Ja1SWG3Fgytmm73fP0ReulG7Kjx
 tn4URx41zhBibsYipjE4w7+GRiLEf7AitbLOZVQM8tZN6ik6uyVcbKB4h5iZ53JIqHJg346
 ibNbayxsIhC7x9vXdHZT1N33S3j1YmxLGOT9SEFdNaeM7mfFgLbP6rSWalCUjymR0szfKsj
 ndW46pm0nSXgpNRdNTFjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9KAI7Xz4B5I=:tOl2eJ2uZcvrriyrCutBtM
 76GnemR8WHoF/N+K3sP+0Z4heiwSHKaZBJSukhe0rm6IQswNpsbJRUI+lgchLyQQQ3uh44hSa
 16dWTLPU5PxVKy8EbEvTWzVAvWJVwLa3Vpbz1vZkVIR/vh53SgmZEpaJyJtcZwahXL7Zp0/TH
 /hy/96d+Lai8/BA46gQHYnJC7Xqh+l/pkWq72aYYvEYct11vNvIA/VOvMc1f4zABzx2sVOa5Z
 OiBfrmgtixs/sPRyVrzFpgFtI8WHLcMgJt56SD95S/ackgVjWkZGMss//QZF/4+Qh/gGnnBPm
 4gS11PYuWuSjuyR6d5uOZVps2uA8U2idTGYjERyNCWP5tVuSvSQk+Ga4OPqFXUeTIbw5DLuse
 uBXw+OkuS4F+d/Z51puf7nsOj//73ONHKxDA2zN9tA/g7CM5DqF4YA+yIZPVNzRaD+Ir/2NtP
 LjPEYKl1e9wlKOzjJ6B1b688dSmP3rsZMTKQyAucn/2bnft5V5k3vN07G9x0CZqTKooFXUV0i
 ryD6JM8YO+xjleriEV+BzmTqfYTgdmu6TYPygL17UkMEEUVo0UgNLHm6zbg+Y7anOWsn+kBx8
 QATAMQYuqRgxEWJOnjSkZ/MlrCusKhkYoKo5+Eq/ClpBoyqnzrKSCOiCPgCFuOpJFD37nnJEN
 2vTmiTeu5pZ/KAE9dtDqcVyqZXU9DTf1ETrF2KwCNlLTox/sg9t/a9Cw79yrslSRICh9dSnp5
 UKPn4zyv0eLI4YNAhNWlFenlWwo3nO1X+VF4gTAoq9qrlYFidO4900g9kwh9rajrbaNt33O6N
 uHIBXHsfUJp4YAe7mub8YcQabGD1/zZlREn/yqSPu/BxaUmnrPpc0SIA/fVrZXjETHee9NpwD
 XA/ZnOKYVr7A5/hJiZBvterXfD6vLjAjq6GVlLuj/CmAbfkL6epqlT2Fg6vPtZ
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

'struct hostif_sleep_confirm_t' is not used in this driver. Remove 'struct
hostif_sleep_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index ca0b89cd99a1..16ee997c37ad 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -418,11 +418,6 @@ struct hostif_sleep_request {
 	struct hostif_hdr header;
 } __packed;
 
-struct hostif_sleep_confirm_t {
-	struct hostif_hdr header;
-	__le16 result_code;
-} __packed;
-
 struct hostif_mic_failure_request_t {
 	struct hostif_hdr header;
 	__le16 failure_count;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
