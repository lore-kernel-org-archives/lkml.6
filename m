Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FAD208C1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeLOAIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:08:32 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:6508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbeLOAIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:08:32 -0500
Received: from DGGEMA401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 15E3C8E461B9D;
        Sat, 15 Dec 2018 08:08:28 +0800 (CST)
Received: from DGGEMA523-MBX.china.huawei.com ([169.254.5.180]) by
 DGGEMA401-HUB.china.huawei.com ([10.3.20.42]) with mapi id 14.03.0415.000;
 Sat, 15 Dec 2018 08:08:25 +0800
From:   gengdongjiu <gengdongjiu@huawei.com>
To:     Peter Maydell <peter.maydell@linaro.org>,
        James Morse <james.morse@arm.com>
CC:     =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        kvm-devel <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?B?5pKk5ZueOiBbUkZDIFJFU0VORCBQQVRDSF0ga3ZtOiBhcm02NDogZXhwb3J0?=
 =?utf-8?Q?_memory_error_recovery_capability_to_user_space?=
Thread-Topic: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
Thread-Index: AdSUCkxNoTJkAAg6TOC88quIUt5hUw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Sat, 15 Dec 2018 00:08:25 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201FFC20A@dggema523-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.91.186]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Z2VuZ2RvbmdqaXUg5bCG5pKk5Zue6YKu5Lu24oCcW1JGQyBSRVNFTkQgUEFUQ0hdIGt2bTogYXJt
NjQ6IGV4cG9ydCBtZW1vcnkgZXJyb3IgcmVjb3ZlcnkgY2FwYWJpbGl0eSB0byB1c2VyIHNwYWNl
4oCd44CC
