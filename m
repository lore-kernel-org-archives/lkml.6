Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4618DC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 01:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF97120657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 01:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="bxQIiGoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF97120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeKBKbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 06:31:23 -0400
Received: from proxy22674.mail.163.com ([113.108.226.74]:58879 "EHLO
        proxy22674.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeKBKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 06:31:23 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2018 06:31:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=PGanl
        P5ghWPSpHSXnIzcILb6HF/cAmmIB7RjLGuEN3o=; b=bxQIiGoj6/ZRCnrsTTFke
        7IT5E/0IUorcWwVW3hY+foX6p0kLLUFcl8/nxvwuEFayU0XsYPytf1TBJQ3DfNLD
        jKShTFUi0lqGgj/nqXKRXPqOa5qxfyZ9k1m7GsU/YxpDZ749fZZsO5Wkw5KeNWAV
        zUC0LOc6grPyd1AJKYMiHg=
Received: from lshua312$163.com ( [221.4.213.95] ) by ajax-webmail-wmsvr65
 (Coremail) ; Fri, 2 Nov 2018 09:08:15 +0800 (CST)
X-Originating-IP: [221.4.213.95]
Date:   Fri, 2 Nov 2018 09:08:15 +0800 (CST)
From:   lshua312 <lshua312@163.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8996: fix small typo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <284f0219.46f3.166d1f6abb3.Coremail.lshua312@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QcGowADX35OAo9tbuC+YAA--.32575W
X-CM-SenderInfo: 5ovk3tqtrsqiywtou0bp/1tbiORXualXlhxSFmQACsV
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSBlOWI5MjM2OTA2NzVjYThmYTg4M2ZkMjVkY2VhZDViNDU3ODU2NzM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBsaXVzaCA8bGl1c2hAYWxsd2lubmVydGVjaC5jb20+CkRhdGU6
IEZyaSwgMiBOb3YgMjAxOCAwODo1NzowMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFTb0M6IHdt
ODk5NjogZml4IHNtYWxsIHR5cG8KCmF0bGVhc3QgLT4gYXQgbGVhc3QKCkNoYW5nZS1JZDogSWNj
OTcwYjQzODE2NmRhZWYxMzUxOGI3ZDFhNjJiMTNlYjg3NTJmNWYKU2lnbmVkLW9mZi1ieTogbGl1
c2ggPGxpdXNoQGFsbHdpbm5lcnRlY2guY29tPgotLS0KIHNvdW5kL3NvYy9jb2RlY3Mvd204OTk2
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3dtODk5Ni5jIGIvc291bmQvc29jL2NvZGVj
cy93bTg5OTYuYwppbmRleCA4YWZmYTQ5Li5kMDM5ODM1IDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mv
Y29kZWNzL3dtODk5Ni5jCisrKyBiL3NvdW5kL3NvYy9jb2RlY3Mvd204OTk2LmMKQEAgLTIxMDks
NyArMjEwOSw3IEBAIHN0YXRpYyBpbnQgd204OTk2X3NldF9mbGwoc3RydWN0IHNuZF9zb2NfY29k
ZWMgKmNvZGVjLCBpbnQgZmxsX2lkLCBpbnQgc291cmNlLAogCWlmIChpMmMtPmlycSkKIAkJdGlt
ZW91dCAqPSAxMDsKIAllbHNlCi0JCS8qIGVuc3VyZSB0aW1lb3V0IG9mIGF0bGVhc3QgMSBqaWZm
aWVzICovCisJCS8qIGVuc3VyZSB0aW1lb3V0IG9mIGF0IGxlYXN0IDEgamlmZmllcyAqLwogCQl0
aW1lb3V0ID0gdGltZW91dC8yID8gOiAxOwogCiAJZm9yIChyZXRyeSA9IDA7IHJldHJ5IDwgMTA7
IHJldHJ5KyspIHsKLS0gCjEuOS4x
