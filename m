Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A591D21508
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A591D21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeIYWab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:30:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22526 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728776AbeIYWab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:30:31 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8PGE5vs021028;
        Tue, 25 Sep 2018 18:21:28 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mnb6xejt9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 18:21:28 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59CEA34;
        Tue, 25 Sep 2018 16:21:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31994558E;
        Tue, 25 Sep 2018 16:21:27 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 25 Sep
 2018 18:21:26 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 25 Sep 2018 18:21:26 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Patrice CHOTARD <patrice.chotard@st.com>
Subject: [GIT PULL] STi DT update for v4.20 round 1
Thread-Topic: [GIT PULL] STi DT update for v4.20 round 1
Thread-Index: AQHUVOvOH/mJVqLlKUq+4Yh+Mjo21w==
Date:   Tue, 25 Sep 2018 16:21:26 +0000
Message-ID: <7250e85d-374a-76e7-fa8a-4911ef7a12ae@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB097D9A8875B44BC64E3D2FD3D9445@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwgS2V2aW4sIE9sb2YNCg0KUExlYXNlIGNvbnNpZGVyIHRoaXMgZmlyc3Qgcm91bmQg
b2YgU1RpIGR0cyB1cGRhdGUgZm9yIHY0LjIwDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5j
ZSBjb21taXQgNWIzOTRiMmRkZjAzNDdiZWY1NmU1MGM2OWE1ODc3M2M5NDM0M2ZmMzoNCg0KICBM
aW51eCA0LjE5LXJjMSAoMjAxOC0wOC0yNiAxNDoxMTo1OSAtMDcwMCkNCg0KYXJlIGF2YWlsYWJs
ZSBpbiB0aGUgZ2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3BjaG90YXJkL3N0aS5naXQNCnRhZ3Mvc3RpLWR0LWZvci12
NC4yMC1yb3VuZDENCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGI1YjRjOGRkNWM0
NGVkYzExMmEzNjJmODdhOGQ4OTUzMzM2NTcxYmQ6DQoNCiAgQVJNOiBkdHM6IHN0aWg0MTA6IGNo
YW5nZSBzeW50YXggb2YgbXVsdGlwbGUgREFJICgyMDE4LTA5LTI1IDE3OjQxOjUxDQorMDIwMCkN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KU1RpIERUIHVwZGF0ZToNCiBfIENoYW5nZSBzeW50YXggb2YgbXVsdGlwbGUg
REFJIGxpbmtzDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNocmlzdG9waGUgUHJpb3V6ZWF1ICgxKToNCiAgICAgIEFS
TTogZHRzOiBzdGloNDEwOiBjaGFuZ2Ugc3ludGF4IG9mIG11bHRpcGxlIERBSQ0KDQogYXJjaC9h
cm0vYm9vdC9kdHMvc3RpaDQxMC1iMjI2MC5kdHMgIHwgIDUgKysrKy0NCiBhcmNoL2FybS9ib290
L2R0cy9zdGloeHh4LWIyMTIwLmR0c2kgfCAxMSArKysrKysrKy0tLQ0KIDIgZmlsZXMgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSk=
