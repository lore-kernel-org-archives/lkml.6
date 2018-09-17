Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C49ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5292147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5292147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIQSV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:21:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:34371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeIQSV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:21:56 -0400
Received: from [192.168.178.201] ([79.193.244.88]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbgKD-1gIB0j3Pzp-00J3Tn; Mon, 17
 Sep 2018 14:54:36 +0200
From:   Philipp Klocke <Phil_K97@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Phil_K97@gmx.de; prefer-encrypt=mutual; keydata=
 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
 12TtBTzNsw==
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        arnd@arndb.de
Cc:     drbd-dev@lists.linbit.com, nicolas.dichtel@6wind.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [RESEND] drbd: avoid clang warning about pointless switch statement
Message-ID: <4ffc2255-2ae2-60d4-703e-151979efe7ab@gmx.de>
Date:   Mon, 17 Sep 2018 14:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-HK
X-Provags-ID: V03:K1:qYmDtTi5DJE6XbzhkqNW8PXZCWGjjRtxOTHnskdTsC8dEmkwBXh
 EvTjxIoZYC2GyTW0WMRfozv0MhYR0PxRd3MoBIOpM7pZxoOvyIXMW8pUrT5LSswmmkAPHrQ
 KThHC9+3vZPdf+MCUZ3KYiddt0ApTvioui0w6TaWGqOUI3gganInUSrxcubi2fBTXCYAwI7
 ymPpt0MLZ/PAuEeg8/IOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FQc3yBLA6P0=:A9hsGRlfGs1o/zjrckQkwI
 Oyf1MJN/TrGiU8aM6gr+SctnwUD9CxiwpKd0V9krYQhgbtT1toaV+aP1dP23g1vj4qPNkun/I
 VK54wGjScuaE1l8NjXvMXOmU7JS9JNmJWLc/1GvY/U94mglVrbTqIF5IJxWItQurTRpD113Ci
 F4AjRtDv6hN7K4SmCLtzfRe9fAMZvRjN6O7PAd7+EfCascfJY86OldJxw6vz8zDaskPvkZMKd
 5GxJaDAdLSaFoDabcy27zjLaMJqV0c2wSRbEAJKVSeL+xpE9K6eQao+eoOv9/5yBmj+9hqfwj
 8kHpmd+074f6asPWU0KeG9reG5Yo7VX0Ifr6OIIPjvZM/x24Jld4dsuHV+ac6jVgH55Dv771c
 RGL3chh1Esuykk4DSrN3wHTesIBYzF2uKX33zkMRJlx0qJBQhI8FslyTsKbJdtD74xOsTcZzv
 RbV5bZeXVATJrT2+onhp0sZs7bVp5CUW2wx1tyEpDPNas1Gx/3XdvNXn1ZH4Pzb7qCX6S4Qnn
 aeZ27XWrzBoY3r+GD6MIx/nKE2kGOMR451H6fmSWRiI33nIBNllb3sf8RV9wjV1Vb89G2Q4J6
 604KZXYdSmaZ9YsMlIdSXsczHJ/GmS+RTq3iaCQz5Yt1F8p6CP0BYHMNO0neHAASd29IrWRo5
 PmOaJQw6/70lw5m+ApZcTzrAS2OCPLh42E5UjvhMUiVFtsSDQQEFhZ8lq2KA97m0mT2tVxUIf
 y3mYvSE6ufMJGX4x+WzXDw5AHQblmsBLLhWzj2aNQBDNs9fYxdTxAVyCVkHEmbIq/dfpt/3f5
 SsY4EqFG2yEKNld0V5NlPFQlUWY/X5yMoFREtM3THBVAY52bwE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRyYmQgY29kZSBjYXVzZXMgd2FybmluZ3MgdGhhdCB3ZSBjYW5ub3QgZWFzaWx5IGRp
c2FibGUgd2hlbgpidWlsZGluZyB3aXRoIGNsYW5nOgoKSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX2RlYnVnZnMuYzoxMDoKSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX2ludC5oOjQ4OgpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gaW5jbHVkZS9saW51eC9kcmJkX2dlbmxfYXBpLmg6NTM6CkluIGZpbGUgaW5j
bHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L2dlbmxfbWFnaWNfc3RydWN0Lmg6MjM3OgppbmNs
dWRlL2xpbnV4L2RyYmRfZ2VubC5oOjMwMDoxOiB3YXJuaW5nOiBubyBjYXNlIG1hdGNoaW5n
IGNvbnN0YW50CnN3aXRjaCBjb25kaXRpb24gJzAnCgpUaGVyZSBpcyBub3RoaW5nIHdyb25n
IHdpdGggdGhlIGNvZGUsIGFuZCBhZGRpbmcgJ2RlZmF1bHQ6JyBsYWJlbHMKaW4gdGhlIHJp
Z2h0IHBsYWNlIGlzIGVub3VnaCB0byBsZXQgY2xhbmcgc2h1dCB1cCBhYm91dCB0aGUgd2Fy
bmluZy4KCkZpeGVzOiBlYzJjMzVhYzFlYTIgKCJkcmJkOiBwcmVwYXJlIHRoZSB0cmFuc2l0
aW9uIGZyb20gY29ubmVjdG9yIHRvCmdlbmV0bGluayIpClNpZ25lZC1vZmYtYnk6IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Ci0tCndhcyBzZW50IG9uIEZlYi4gMSwgMjAxNywg
NDo1NSBwLm0uIFVUQyBieSBBcm5kIEJlcmdtYW5uCndhcyBhY2tlZCBidXQgbm90IG1lcmdl
ZApyZXNlbmQKLS0tCsKgaW5jbHVkZS9saW51eC9nZW5sX21hZ2ljX3N0cnVjdC5oIHwgMyAr
KysKwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9nZW5sX21hZ2ljX3N0cnVjdC5oCmIvaW5jbHVkZS9saW51eC9nZW5sX21h
Z2ljX3N0cnVjdC5oCmluZGV4IDYyNzBhNTZlNWVkYy4uYzZmYmFmYjgzNGYxIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L2dlbmxfbWFnaWNfc3RydWN0LmgKKysrIGIvaW5jbHVkZS9s
aW51eC9nZW5sX21hZ2ljX3N0cnVjdC5oCkBAIC0xOTAsNiArMTkwLDcgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGN0X2Fzc2VydF91bmlxdWVfb3BlcmF0aW9ucyh2b2lkKQrCoHsKwqDCoMKg
wqAgc3dpdGNoICgwKSB7CsKgI2luY2x1ZGUgR0VOTF9NQUdJQ19JTkNMVURFX0ZJTEUKK8Kg
wqDCoCBkZWZhdWx0OgrCoMKgwqDCoCDCoMKgwqAgOwrCoMKgwqDCoCB9CsKgfQpAQCAtMjA4
LDYgKzIwOSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZApjdF9hc3NlcnRfdW5pcXVlX3RvcF9s
ZXZlbF9hdHRyaWJ1dGVzKHZvaWQpCsKgewrCoMKgwqDCoCBzd2l0Y2ggKDApIHsKwqAjaW5j
bHVkZSBHRU5MX01BR0lDX0lOQ0xVREVfRklMRQorwqDCoMKgIGRlZmF1bHQ6CsKgwqDCoMKg
IMKgwqDCoCA7CsKgwqDCoMKgIH0KwqB9CkBAIC0yMTgsNiArMjIwLDcgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGN0X2Fzc2VydF91bmlxdWVfICMjIHNfbmFtZSAjIwpfYXR0cmlidXRlcyh2
b2lkKcKgwqDCoCBcCsKge8KgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIFwKwqDCoMKgwqAgc3dpdGNoICgwKSB7wqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIFwKwqDCoMKgwqAg
wqDCoMKgIHNfZmllbGRzwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgXAorwqDCoMKgIMKgwqDCoCBkZWZhdWx0OsKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIFwKwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCA7wqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgXArCoMKgwqDCoCB9wqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBcCsKgfQoK
