Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393786-5-2384379042288800866
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
    1522393785; b=IFMsRSFjbCe5g8OyIM1zlArNjxEOpBiVevx9eRDWh+EsSwstzx
    u+NATWUddltLIYBQkUHJQel/SaKgodOvaN1x/XTyomKpyLXaW0H//dBw4B39751J
    7hS2GpjNwVXj9/v32M400I1qpdHCF5VZo1fIKsZv39iKCNqN02CicZhUJIWnK6aZ
    ciO77Mkx47AF+t8cUUydPBxhiIttKNq8BAG1ocfwgQxA/UrbaO8u8pFHSNB2fsj9
    7BQeNul0xfj78gJZeDxUKPTo1bQM6bhKh8K/e9z2tzMn06vvye7UUytJvksJNoAK
    8M3y/Np61CXJLrHcxUMmngI4My+9C5mLohvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393785; bh=CgYUz
    ZVpcwhIQhASohMxX9MI/MjGAvSVaGg6LnX9jyU=; b=gWL5J0s2QAsR7ZgQPoikW
    ZoYh64nkbo+G1iz0zJc/k/KM1fAXydsywS5kQtKKXrilr1g9OK9Rgshklo+1NNHI
    wkt8MVbXYwk835R+Cn3UljTLYiyfw4sei1zlBhbT9mM8l3xOVwFZaU79BIQbLzz4
    y10p0ozlLGXGaNDItnKKalThCBPUhxS3rPsolcri7Zt02N4xaRIwPhBdyx9TbHj/
    XWYDzxk44jvk+klwqwLmHV8NDforBoq4XGQ5l03cZb4EbVBFglk1A3g4kzNNLIIO
    sT/u9497tZULaA+k//jlHIaf1W/a636iu84d9qyEoeDn5fx0HOmmyaOznxqntgVb
    Q==
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
X-CM-Envelope: MS4wfGDxYA26F5p3HOUrv7BYaO9sz87rhmoV8n0PLUiscKllvawgQk4iNBlLsHGE1Awxk4Fmz627rFek6eSSAzDTNXI92AHgzDfwN1oKh/Z7YENDF/WP2Q9m
    Cvwc+iZRkPPU5iZpcr97pzwcZKVPG0IZB6nlD3gCyOTORl/AKloXPh/0NCcktGCpJ9nCWUOHVN92P9fzMGMW5XNiaBu8BUzxiLq9NqLDMNexMP8PyMInfSyF
    zvnIbD44B80zRLxqrSHQ3g==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=gpGHsg53_5QM18PxnzIA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 12/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_mib_set_confirm_t'.
Date: Fri, 30 Mar 2018 00:07:35 -0700
Message-Id: <20180330070842.25224-12-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:gladxBE2aUoAm+pClkG9yIK/5YUbWzqxqGLhZ3MWfi2Y2kXd9Fx
 +/KR0uJSWbfWrRlDPFGyxPJ2iTK4//Gvo8t+CAy9+/Nv/IUe9mptKZMHXm3ifLuz9Jm91ov
 lLvJ4sTgB9IV9Pw4W6Zh4OF69YGFYAbOxqgk9gmHXx27eGK5ZNHMz62glu0VwZ4EczVEsXX
 DYztYlYgBoqOn0WcF11tQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C5fwGeBdU5A=:ZJjjT7zjjUTiNZkChVqSuT
 5Ybqn22wvXeyuaiZSGbCsgxf3ax3TlJsQj8cwCq2b2OMrHyVvWEVmUOcundWK4ZobPqvww6gh
 HH3lSvYhvYozFhprEtfw3hSnnEx4r9POxnfB8g1leXesWBosxMycJ4fbBl7Fcs6djB96t0ELS
 4I1pXpnwjYSt0oeL1XZyCPlgqLWphfT0uN/kCaJom1A0cRMgU6X3m4+h2CtmlXLoXeBVEfsmW
 elDgQN22LfczzsVmCyU3gSLThDVyJrAZh0iwA8HwoTzkKV+WB+gHeEZvxupDTZPfTVCA474kf
 Ox3aRmMF6LeQZHy9Af6k9K6c+RfTXRP4Cquidkx/I/qTbHICKgK4VqrCRNSu9aC3qdo1GYgSb
 KwI5JePsbk0NISFLPIIMu5tz3BgG5sB0xXDZcT7nC5A5QXz3Zv32BwVGPxTCflL34vrKb/ovL
 y39oBNsAGbpsV7jPaIq3hin3q0pnSpL74QGRC8ucL0U8MklcKP6i0mCEdog7RVIr5OLkoAtFi
 uyeprdvlncwsY9jK/9j8aXITZ874CZsfwoGQlpfa9nWO183Xn9GnZqyINjVPUcNC+6u0pdPGx
 fTfquKu8l6qlypSdaXLcW5psCarGUvsysgWig0xbOlkRuvad0L3JRdozqba5ySGTvxr1fkJZd
 BOERg8r9cw6SE3qK6yQYRf3NqmQHvsij//YHthJ19ofIcFb92X8gMdMk57ZyEEQJZybHKmAQx
 fRouVx1xICfCd2s3dHwQKd1XEHGUpU/XcJ8LnQ==
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
all occurences of 'struct hostif_mib_set_confirm_t' with 'struct
hostif_mib_set_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 5261810fbc76..7a0e0c610c50 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -175,7 +175,7 @@ struct hostif_mib_set_request {
 	struct hostif_mib_value mib_value;
 } __packed;
 
-struct hostif_mib_set_confirm_t {
+struct hostif_mib_set_confirm {
 	struct hostif_hdr header;
 	__le32 mib_status;
 	__le32 mib_attribute;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
