Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_DOUBLE_IP_LOOSE,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10699C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD06D218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfAXKRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:17:11 -0500
Received: from [182.148.157.197] ([182.148.157.197]:34974 "HELO eyou.net"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S1726025AbfAXKRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:17:10 -0500
X-EYOU-SPAMVALUE: 0
X-EMDG-ORIGINAL-FROM: <zhouyanjie@cduestc.edu.cn>
X-EMDG-ORIGINAL-TO: <linux-kernel@vger.kernel.org>
X-EMDG-ORIGINAL-IP: 125.71.5.39
X-EMDG-VER: 4.1.1
X-EMDG-ABROAD: no
Received: (eyou anti_spam gateway 4.1.0); Thu, 24 Jan 2019 18:17:41 +0800
X-EMDG-MID: <748325061.28195@eyou.net>
Received: from 125.71.5.39 by 182.148.157.197 with SMTP; Thu, 24 Jan 2019 18:17:41 +0800
Received: from localhost ([127.0.0.1]) 
        by cduestc.cn with sendmail id 3424c98d8beab29e2781ee3693d74600;
        Fri, 25 Jan 2019 02:22:15 +0800
Date:   Fri, 25 Jan 2019 02:22:15 +0800
From:   "Zhou Yanjie" <zhouyanjie@cduestc.edu.cn>
Subject: [PATCH] DTS: CI20: Fix bugs in ci20's device tree.
To:     "linux-mips" <linux-mips@vger.kernel.org>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, ralf@linux-mips.org, jhogan@kernel.org,
        mark.rutland@arm.com, malat@debian.org, ezequiel@collabora.co.uk,
        ulf.hansson@linaro.org, "syq" <syq@debian.org>,
        "jiaxun.yang" <jiaxun.yang@flygoat.com>
Message-Id: <190125022215331921004107@cduestc.edu.cn>
MIME-Version: 1.0
X-Mailer: eYou WebMail 8.13.6
X-Eyou-Client: 171.209.85.48
X-Eyou-Is-Onercpt: 0
Content-Type: text/plain;
 charset="UTF-8"
Content-Transfer-Encoding: base64
X-Eyou-Sender: <zhouyanjie@cduestc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWmhvdSBZYW5qaWUgPHpob3V5YW5qaWVAY2R1ZXN0Yy5lZHUuY24+CgpBY2Nv
cmRpbmcgdG8gdGhlIFNjaGVtYXRpYywgdGhlIGhhcmR3YXJlIG9mIGNpMjAgbGVhZHMg
dG8gdWFydDMsCmJ1dCBub3QgdG8gdWFydDIuIFVhcnQyIGlzIG1pc3dyaXR0ZW4gaW4g
dGhlIG9yaWdpbmFsIGNvZGUuCgpTaWduZWQtb2ZmLWJ5OiBaaG91IFlhbmppZSA8emhv
dXlhbmppZUBjZHVlc3RjLmVkdS5jbj4KLS0tCiBhcmNoL21pcHMvYm9vdC9kdHMvaW5n
ZW5pYy9jaTIwLmR0cyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2Jv
b3QvZHRzL2luZ2VuaWMvY2kyMC5kdHMgYi9hcmNoL21pcHMvYm9vdC9kdHMvaW5nZW5p
Yy9jaTIwLmR0cwppbmRleCA1MGNmZjNjLi40ZjdiMWZhIDEwMDY0NAotLS0gYS9hcmNo
L21pcHMvYm9vdC9kdHMvaW5nZW5pYy9jaTIwLmR0cworKysgYi9hcmNoL21pcHMvYm9v
dC9kdHMvaW5nZW5pYy9jaTIwLmR0cwpAQCAtNzYsNyArNzYsNyBAQAogCXN0YXR1cyA9
ICJva2F5IjsKIAogCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Ci0JcGluY3RybC0w
ID0gPCZwaW5zX3VhcnQyPjsKKwlwaW5jdHJsLTAgPSA8JnBpbnNfdWFydDM+OwogfTsK
IAogJnVhcnQ0IHsKQEAgLTE5Niw5ICsxOTYsOSBAQAogCQliaWFzLWRpc2FibGU7CiAJ
fTsKIAotCXBpbnNfdWFydDI6IHVhcnQyIHsKLQkJZnVuY3Rpb24gPSAidWFydDIiOwot
CQlncm91cHMgPSAidWFydDItZGF0YSIsICJ1YXJ0Mi1od2Zsb3ciOworCXBpbnNfdWFy
dDM6IHVhcnQzIHsKKwkJZnVuY3Rpb24gPSAidWFydDMiOworCQlncm91cHMgPSAidWFy
dDMtZGF0YSIsICJ1YXJ0My1od2Zsb3ciOwogCQliaWFzLWRpc2FibGU7CiAJfTsKIAot
LSAKMi43LjQK

