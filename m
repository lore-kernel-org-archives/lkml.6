Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD4DC7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B3F205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B3F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJORTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:19:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6459 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbeJORTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:19:49 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 7C7FBAA1EFFF5;
        Mon, 15 Oct 2018 17:35:17 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.186]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0399.000;
 Mon, 15 Oct 2018 17:35:14 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Can we just remove the sw_lpm_support from current xhci driver?
Thread-Topic: Can we just remove the sw_lpm_support from current xhci driver?
Thread-Index: AdRkaV8K+ciMdjt1RRm6ul2Nx4Vbyg==
Date:   Mon, 15 Oct 2018 09:35:14 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED1F18C855@dggemm526-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGk6DQoNCkkgYW0gcmVjZW50bHkgcmVhZGluZyB0aGUgTFBNIHJlbGF0ZWQgY29kZSBpbiB4aGNp
IGRyaXZlciwgYW5kIEkgZmluZCANCnRoYXQgdGhlIHhoY2ktPnN3X2xwbV9zdXBwb3J0IGlzIG5v
dCByZWFsbHkgdXNlZCwgYnV0IEkgYW0gbm90IHN1cmUNCiB3aGV0aGVyIHdlIHNob3VsZCByZW1v
dmUgaXQgb3Igbm90PyANCg0KQW55IGlkZWFzLCBUaGFua3MuDQoNClJlZ2FyZHMNClplbmd0YW8g
DQo=
