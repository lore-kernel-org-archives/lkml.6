Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDXRWl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:22:41 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:41413 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:22:39 -0400
X-Google-Smtp-Source: AIpwx49V7alOvahuKdUTon+8l/ZHW/bwAOrJNCMrLmrHomS2ENc9elUFlMHA8R2yJPBtARFqk24tVTr0hE1rhvcEMdU=
MIME-Version: 1.0
In-Reply-To: <MW2PR07MB4139D11DC60825A8A6C04E068A880@MW2PR07MB4139.namprd07.prod.outlook.com>
References: <CAOTh5U2NwGU68cwzX2amhzPyj_=f0pm4CO4biR4m1DX49MJkUw@mail.gmail.com>
 <7747689b-6774-ca84-e0d5-ffd9b0d59e1b@gmail.com> <MW2PR07MB4139D11DC60825A8A6C04E068A880@MW2PR07MB4139.namprd07.prod.outlook.com>
From: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Date: Tue, 24 Apr 2018 11:22:37 -0600
Message-ID: <CAOTh5U0MViVUN1a59Q3ciebyiYCw==OgiTSeB5nuPJT+Y-Dm+g@mail.gmail.com>
Subject: Re: fix for bnx2x panic during ethtool reporting
To: "Kalluru, Sudarsana" <Sudarsana.Kalluru@cavium.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
Content-Type: multipart/mixed; boundary="94eb2c05dce4b295e6056a9b66f6"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--94eb2c05dce4b295e6056a9b66f6
Content-Type: text/plain; charset="UTF-8"

Here's an updated version of the patch that is checkpatch.pl clean (I
had forgotten to sign off...).

-- 
Sebastian Kuzminsky

--94eb2c05dce4b295e6056a9b66f6
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-bnx2x-make-fw-str-in-a-non-crazy-way.patch"
Content-Disposition: attachment;
	filename="0001-bnx2x-make-fw-str-in-a-non-crazy-way.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jgdxu2eo0

RnJvbSA0NWZlNmZiMWY2YTE4NzIzM2JkMTMwNGIwMzFiZWQyMGIzODE5ZDI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWJhc3RpYW4gS3V6bWluc2t5IDxzZWJAaGlnaGxhYi5jb20+
CkRhdGU6IE1vbiwgMTYgQXByIDIwMTggMjM6MjQ6MDcgKzAwMDAKU3ViamVjdDogW1BBVENIXSBi
bngyeDogbWFrZSBmdyBzdHIgaW4gYSBub24tY3Jhenkgd2F5CgpUaGlzIGZpeGVzIGFuIHVudGVy
bWluYXRlZCBzdHJpbmcgYnVnIHdoZW4gdGhlIGZpcndtYXJlIHZlcnNpb24KKGJwLT5md192ZXIp
IGlzIGxvbmdlciB0aGFuIHRoZSBwYXNzZWQtaW4gYnVmZmVyIChidWYvYnVmX2xlbikuCgpTaWdu
ZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gS3V6bWluc2t5IDxzZWJAaGlnaGxhYi5jb20+Ci0tLQogZHJp
dmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vYm54MngvYm54MnhfY21uLmMgfCA2ICsrKy0tLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9ibngyeC9ibngyeF9jbW4uYyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2JueDJ4L2JueDJ4X2Ntbi5jCmluZGV4IDY0NjU0
MTRkYWQ3NC4uZjAyM2VlMzY1YzYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9i
cm9hZGNvbS9ibngyeC9ibngyeF9jbW4uYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9h
ZGNvbS9ibngyeC9ibngyeF9jbW4uYwpAQCAtMTUwLDkgKzE1MCw5IEBAIHZvaWQgYm54MnhfZmls
bF9md19zdHIoc3RydWN0IGJueDJ4ICpicCwgY2hhciAqYnVmLCBzaXplX3QgYnVmX2xlbikKIAkJ
cGh5X2Z3X3ZlclswXSA9ICdcMCc7CiAJCWJueDJ4X2dldF9leHRfcGh5X2Z3X3ZlcnNpb24oJmJw
LT5saW5rX3BhcmFtcywKIAkJCQkJICAgICBwaHlfZndfdmVyLCBQSFlfRldfVkVSX0xFTik7Ci0J
CXN0cmxjcHkoYnVmLCBicC0+ZndfdmVyLCBidWZfbGVuKTsKLQkJc25wcmludGYoYnVmICsgc3Ry
bGVuKGJwLT5md192ZXIpLCAzMiAtIHN0cmxlbihicC0+ZndfdmVyKSwKLQkJCSAiYmMgJWQuJWQu
JWQlcyVzIiwKKwkJc25wcmludGYoYnVmLCBidWZfbGVuLAorCQkJICIlcyBiYyAlZC4lZC4lZCVz
JXMiLAorCQkJIGJwLT5md192ZXIsCiAJCQkgKGJwLT5jb21tb24uYmNfdmVyICYgMHhmZjAwMDAp
ID4+IDE2LAogCQkJIChicC0+Y29tbW9uLmJjX3ZlciAmIDB4ZmYwMCkgPj4gOCwKIAkJCSAoYnAt
PmNvbW1vbi5iY192ZXIgJiAweGZmKSwKLS0gCjIuMTEuMAoK
--94eb2c05dce4b295e6056a9b66f6--
