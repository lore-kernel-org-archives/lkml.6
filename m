Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421C8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1C320852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1C320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933604AbeFRQMk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:12:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56565 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752765AbeFRQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:12:38 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5IG9KuB028840;
        Mon, 18 Jun 2018 18:12:23 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jpap2sf6g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Jun 2018 18:12:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 393DF38;
        Mon, 18 Jun 2018 16:12:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C7D2114C;
        Mon, 18 Jun 2018 16:12:23 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 18:12:22 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 18 Jun 2018 18:12:22 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Vincent ABRIOU" <vincent.abriou@st.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1 7/7] drm: sti: remove the last call to debugfs
Thread-Topic: [PATCH v1 7/7] drm: sti: remove the last call to debugfs
Thread-Index: AQHUBw9vjmYf/SFzyESoN9N9v+0OiKRmDqAA
Date:   Mon, 18 Jun 2018 16:12:22 +0000
Message-ID: <e8c3a9c2-1ad0-ef65-f233-4e7dad86395e@st.com>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
 <20180605135407.20214-8-benjamin.gaignard@linaro.org>
In-Reply-To: <20180605135407.20214-8-benjamin.gaignard@linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AB1DA8F2767AA49A946898BC7145B15@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQoNCk9uIDA2LzA1LzIwMTggMDM6NTQgUE0sIEJlbmphbWluIEdhaWduYXJk
IHdyb3RlOg0KPiBUaGFua3MgdG8gYWxsIHRoZSBob29rcyBpbiBkcm0gc3RydWN0dXJlLCBjdXN0
b20gZGVidWdmcyBjb3VsZCBiZQ0KPiByZW1vdmVkIG9mIHN0aSBkcml2ZXIuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0aS9zdGlfZHJ2LmMgfCA1MCAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDUwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zdGkv
c3RpX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL3N0aS9zdGlfZHJ2LmMNCj4gaW5kZXggOTBjNDZi
NDljOTMxLi45NWIwYWM0ZDgxOWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zdGkv
c3RpX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdGkvc3RpX2Rydi5jDQo+IEBAIC03
LDcgKzcsNiBAQA0KPiAgICNpbmNsdWRlIDxkcm0vZHJtUC5oPg0KPiAgIA0KPiAgICNpbmNsdWRl
IDxsaW51eC9jb21wb25lbnQuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+ICAg
I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
Cj4gICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gQEAgLTcyLDUzICs3MSw2IEBA
IHN0YXRpYyBpbnQgc3RpX2RybV9mcHNfc2V0KHZvaWQgKmRhdGEsIHU2NCB2YWwpDQo+ICAgREVG
SU5FX1NJTVBMRV9BVFRSSUJVVEUoc3RpX2RybV9mcHNfZm9wcywNCj4gICAJCQlzdGlfZHJtX2Zw
c19nZXQsIHN0aV9kcm1fZnBzX3NldCwgIiVsbHVcbiIpOw0KPiAgIA0KPiAtc3RhdGljIGludCBz
dGlfZHJtX2Zwc19kYmdfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKmRhdGEpDQo+IC17
DQo+IC0Jc3RydWN0IGRybV9pbmZvX25vZGUgKm5vZGUgPSBzLT5wcml2YXRlOw0KPiAtCXN0cnVj
dCBkcm1fZGV2aWNlICpkZXYgPSBub2RlLT5taW5vci0+ZGV2Ow0KPiAtCXN0cnVjdCBkcm1fcGxh
bmUgKnA7DQo+IC0NCj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHAsICZkZXYtPm1vZGVfY29uZmln
LnBsYW5lX2xpc3QsIGhlYWQpIHsNCj4gLQkJc3RydWN0IHN0aV9wbGFuZSAqcGxhbmUgPSB0b19z
dGlfcGxhbmUocCk7DQo+IC0NCj4gLQkJc2VxX3ByaW50ZihzLCAiJXMlc1xuIiwNCj4gLQkJCSAg
IHBsYW5lLT5mcHNfaW5mby5mcHNfc3RyLA0KPiAtCQkJICAgcGxhbmUtPmZwc19pbmZvLmZpcHNf
c3RyKTsNCj4gLQl9DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIHN0
cnVjdCBkcm1faW5mb19saXN0IHN0aV9kcm1fZGJnX2xpc3RbXSA9IHsNCj4gLQl7ImZwc19nZXQi
LCBzdGlfZHJtX2Zwc19kYmdfc2hvdywgMH0sDQo+IC19Ow0KPiAtDQo+IC1zdGF0aWMgaW50IHN0
aV9kcm1fZGJnX2luaXQoc3RydWN0IGRybV9taW5vciAqbWlub3IpDQo+IC17DQo+IC0Jc3RydWN0
IGRlbnRyeSAqZGVudHJ5Ow0KPiAtCWludCByZXQ7DQo+IC0NCj4gLQlyZXQgPSBkcm1fZGVidWdm
c19jcmVhdGVfZmlsZXMoc3RpX2RybV9kYmdfbGlzdCwNCj4gLQkJCQkgICAgICAgQVJSQVlfU0la
RShzdGlfZHJtX2RiZ19saXN0KSwNCj4gLQkJCQkgICAgICAgbWlub3ItPmRlYnVnZnNfcm9vdCwg
bWlub3IpOw0KPiAtCWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyOw0KPiAtDQo+IC0JZGVudHJ5ID0g
ZGVidWdmc19jcmVhdGVfZmlsZSgiZnBzX3Nob3ciLCBTX0lSVUdPIHwgU19JV1VTUiwNCj4gLQkJ
CQkgICAgIG1pbm9yLT5kZWJ1Z2ZzX3Jvb3QsIG1pbm9yLT5kZXYsDQo+IC0JCQkJICAgICAmc3Rp
X2RybV9mcHNfZm9wcyk7DQo+IC0JaWYgKCFkZW50cnkpIHsNCj4gLQkJcmV0ID0gLUVOT01FTTsN
Cj4gLQkJZ290byBlcnI7DQo+IC0JfQ0KPiAtDQo+IC0JRFJNX0lORk8oIiVzOiBkZWJ1Z2ZzIGlu
c3RhbGxlZFxuIiwgRFJJVkVSX05BTUUpOw0KPiAtCXJldHVybiAwOw0KPiAtZXJyOg0KPiAtCURS
TV9FUlJPUigiJXM6IGNhbm5vdCBpbnN0YWxsIGRlYnVnZnNcbiIsIERSSVZFUl9OQU1FKTsNCj4g
LQlyZXR1cm4gcmV0Ow0KPiAtfQ0KPiAtDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1fbW9k
ZV9jb25maWdfZnVuY3Mgc3RpX21vZGVfY29uZmlnX2Z1bmNzID0gew0KPiAgIAkuZmJfY3JlYXRl
ID0gZHJtX2dlbV9mYl9jcmVhdGUsDQo+ICAgCS5vdXRwdXRfcG9sbF9jaGFuZ2VkID0gZHJtX2Zi
X2hlbHBlcl9vdXRwdXRfcG9sbF9jaGFuZ2VkLA0KPiBAQCAtMTY3LDggKzExOSw2IEBAIHN0YXRp
YyBzdHJ1Y3QgZHJtX2RyaXZlciBzdGlfZHJpdmVyID0gew0KPiAgIAkuZ2VtX3ByaW1lX3Z1bm1h
cCA9IGRybV9nZW1fY21hX3ByaW1lX3Z1bm1hcCwNCj4gICAJLmdlbV9wcmltZV9tbWFwID0gZHJt
X2dlbV9jbWFfcHJpbWVfbW1hcCwNCj4gICANCj4gLQkuZGVidWdmc19pbml0ID0gc3RpX2RybV9k
YmdfaW5pdCwNCj4gLQ0KPiAgIAkubmFtZSA9IERSSVZFUl9OQU1FLA0KPiAgIAkuZGVzYyA9IERS
SVZFUl9ERVNDLA0KPiAgIAkuZGF0ZSA9IERSSVZFUl9EQVRFLA0KPiANCg0KR3JlYXQsDQpSZXZp
ZXdlZC1ieTogUGhpbGlwcGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCk1hbnkgdGhh
bmtzDQpQaGlsaXBwZSA6LSk=
