Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79BA2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbeLTNyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:54:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46201 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbeLTNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:54:45 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBKDpOp9013907;
        Thu, 20 Dec 2018 14:54:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcqy9mj71-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 20 Dec 2018 14:54:23 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1448F31;
        Thu, 20 Dec 2018 13:54:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DFCD62CB4;
        Thu, 20 Dec 2018 13:54:20 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 20 Dec
 2018 14:54:20 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Thu, 20 Dec 2018 14:54:20 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] STi SoC update for v4.21 round 1
Thread-Topic: [GIT PULL] STi SoC update for v4.21 round 1
Thread-Index: AQHUmGuBWkmEGCRrPkOR3xez7m4ltw==
Date:   Thu, 20 Dec 2018 13:54:20 +0000
Message-ID: <9459cb9d-aafe-b712-9c95-30b2ff979d34@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC9504401D5D864A8B4750135923E785@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwgT2xvZiwgS2V2aW4NCg0KUGxlYXNlIGZpbmQgU1RpIFNvQyB1cGRhdGUgZm9yIHY0
LjIxIHJvdW5kIDE6DQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNjUxMDIy
MzgyYzdmOGRhNDZjYjQ4NzJhNTQ1ZWUxZGE2ZDA5N2QyYToNCg0KICBMaW51eCA0LjIwLXJjMSAo
MjAxOC0xMS0wNCAxNTozNzo1MiAtMDgwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgZ2l0IHJl
cG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3BjaG90YXJkL3N0aS5naXQNCnRhZ3Mvc3RpLXNvYy1mb3ItdjQuMjEtcm91bmQxDQoN
CmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA3MDRjZmQ3ZjVmNzFjNmJjNmNkZmFhNjNh
MTZlZDBmNzI4ODJiMWExOg0KDQogIEFSTTogc3RpOiByZW1vdmUgcGVuX3JlbGVhc2UgYW5kIGJv
b3RfbG9jayAoMjAxOC0xMi0yMCAxNDozMjoxNSArMDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpIaWdobGln
aHRzOg0KLS0tLS0tLS0tLS0NCi0gRm9sbG93aW5nIHBlbl9yZWxlYXNlIGFuZCBib290X2xvY2sg
Y2xlYW51cCBpbml0aWF0ZWQgYnkNCiAgUnVzc2VsbCBLaW5nLCAuc21wX3ByZXBhcmVfY3B1cyBh
bmQgLnNtcF9ib290X3NlY29uZGFyeSBTVGkgY2FsbGJhY2tzDQogIG11c3QgYmUgcmV3b3JrZWQg
dG8ga2VlcCBzZWNvbmRhcnkgQ1BVJ3MgYnJpbmd1cC4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUGF0cmljZSBDaG90
YXJkICgxKToNCiAgICAgIEFSTTogc3RpOiByZW1vdmUgcGVuX3JlbGVhc2UgYW5kIGJvb3RfbG9j
aw0KDQogYXJjaC9hcm0vbWFjaC1zdGkvTWFrZWZpbGUgIHwgIDIgKy0NCiBhcmNoL2FybS9tYWNo
LXN0aS9oZWFkc21wLlMgfCA0MyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogYXJjaC9hcm0vbWFj
aC1zdGkvcGxhdHNtcC5jIHwgODgNCisrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTE4IGRlbGV0
aW9ucygtKQ0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLXN0aS9oZWFkc21wLlM=
