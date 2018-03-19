Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965483AbeCSVIS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:08:18 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:37009 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933213AbeCSVIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:08:13 -0400
X-Google-Smtp-Source: AIpwx4/+KcvmxwT+f4qrOUbl9h/LQHf6JQs3chzzvgAU/x1MAIEZa8jApK07ey34iYFyFBIAZDWWuGQ7VwaF1DhdFbY=
MIME-Version: 1.0
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Mon, 19 Mar 2018 14:08:11 -0700
Message-ID: <CAMe9rOrR7xSJgUfiCoZLuqWUwymRxXPoGBW38+pN=9g+yKNhZw@mail.gmail.com>
Subject: [PATCH] x86-64: Verify alignment of LOAD segment
To: LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000010c6460567ca5b4b"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000010c6460567ca5b4b
Content-Type: text/plain; charset="UTF-8"

Since x86-64 kernel must be aligned to 2MB, refuse to boot kernel if
alignment of LOAD segment isn't multiple of 2MB.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

-- 
H.J.

--00000000000010c6460567ca5b4b
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-x86-64-Verify-alignment-of-LOAD-segment.patch"
Content-Disposition: attachment;
	filename="0001-x86-64-Verify-alignment-of-LOAD-segment.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jeyq1tpb0

RnJvbSAyNTAxNWNmMDI1MmQxYTRhMGM1MzJmMzkxYTMxNGUzNDNhNTAyMmRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFR1ZSwgMjcgRmViIDIwMTggMTE6NDE6MzUgLTA4MDAKU3ViamVjdDogW1BBVENIXSB4ODYtNjQ6
IFZlcmlmeSBhbGlnbm1lbnQgb2YgTE9BRCBzZWdtZW50CgpTaW5jZSB4ODYtNjQga2VybmVsIG11
c3QgYmUgYWxpZ25lZCB0byAyTUIsIHJlZnVzZSB0byBib290IGtlcm5lbCBpZgphbGlnbm1lbnQg
b2YgTE9BRCBzZWdtZW50IGlzbid0IG11bHRpcGxlIG9mIDJNQi4KClNpZ25lZC1vZmYtYnk6IEgu
Si4gTHUgPGhqbC50b29sc0BnbWFpbC5jb20+Ci0tLQogYXJjaC94ODYvYm9vdC9jb21wcmVzc2Vk
L21pc2MuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmMgYi9hcmNoL3g4Ni9ib290L2Nv
bXByZXNzZWQvbWlzYy5jCmluZGV4IDk4NzYxYTE1NzZjZS4uMjUyZmVlMzIwODE2IDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5jCisrKyBiL2FyY2gveDg2L2Jvb3Qv
Y29tcHJlc3NlZC9taXNjLmMKQEAgLTMwOSw2ICszMDksMTAgQEAgc3RhdGljIHZvaWQgcGFyc2Vf
ZWxmKHZvaWQgKm91dHB1dCkKIAogCQlzd2l0Y2ggKHBoZHItPnBfdHlwZSkgewogCQljYXNlIFBU
X0xPQUQ6CisjaWZkZWYgQ09ORklHX1g4Nl82NAorCQkJaWYgKChwaGRyLT5wX2FsaWduICUgMHgy
MDAwMDApICE9IDApCisJCQkJZXJyb3IoIkFsaWdubWVudCBvZiBMT0FEIHNlZ21lbnQgaXNuJ3Qg
bXVsdGlwbGUgb2YgMk1CIik7CisjZW5kaWYKICNpZmRlZiBDT05GSUdfUkVMT0NBVEFCTEUKIAkJ
CWRlc3QgPSBvdXRwdXQ7CiAJCQlkZXN0ICs9IChwaGRyLT5wX3BhZGRyIC0gTE9BRF9QSFlTSUNB
TF9BRERSKTsKLS0gCjIuMTQuMwoK
--00000000000010c6460567ca5b4b--
