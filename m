Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeBFRGu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:06:50 -0500
Received: from sonic309-14.consmr.mail.bf2.yahoo.com ([74.6.129.124]:43050
        "EHLO sonic309-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752948AbeBFQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:51:15 -0500
X-YMail-OSG: .AWaMlgVM1kq5tR3cQS6RA11JCGk0QybktuPu4tUJWK6nlo9FQBdmp3Hrnknrd2
 82fzIlz9vVHbHvppOoFAAjnRgJpvvrsT0sBTq7Lb7hVhyrSMdIlM.g0ioGOfR1xcF45NwLf1mN5V
 uSpOr44Q1jC82udXGwZlzkXlYefohRl40QgHWBPj73tMzARFKln3kfHQwUR6XUMn91HbkUi3j1vl
 ZWYDa_.DwRlzX2GQD0jSNvcjI.eABsJxVsuYuNk5ko7tvtw8JrJ0UTDWSp6GELJgtFw7uGACAHHs
 T8EcR4i1PmRoL4jFkm0Kmt1WvWQkt_ouOF1rxEHeX8kQHxxLCUUComZboJOshqjb5lgjX7PEPxAx
 _z9QAKPyK.kVSelAuK4e3WzNS4cxLcrHFfwPEKlhZlek5rXGpd1XXzcAmb1w3c09GmnFnq2zMDmn
 acgu4z29S3JQiag1ixbybZ_Aaex1rVqs2uxhy7Ayr58AcwGU_8HVnwbQsb1eSXaA9LVKRV3sP3T7
 4kbCx
Date: Tue, 6 Feb 2018 16:50:42 +0000 (UTC)
From: Denis Du <dudenis2000@yahoo.ca>
To: David Miller <davem@davemloft.net>
Cc: khc@pm.waw.pl, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2005408285.4065183.1517935842178@mail.yahoo.com>
In-Reply-To: <20180206.102943.1688399898359622454.davem@davemloft.net>
References: <998451043.3408644.1516727290310@mail.yahoo.com> <m3r2qavz73.fsf@pm.waw.pl> <438911112.3985245.1517930128335@mail.yahoo.com> <20180206.102943.1688399898359622454.davem@davemloft.net>
Subject: Re: [PATCH] Carrier detect ok, don't turn off negotiation
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_Part_4065182_1320385182.1517935842178"
X-Mailer: WebService/1.1.11316 YMailNorrin Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4065182_1320385182.1517935842178
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Ok, I submit it=C2=A0 again.


In drivers/net/wan/hdlc_ppp.c, some noise on physical line can cause the ca=
rrier detect still ok, but the protocol will fail. So if carrier detect ok,=
 don't turn off protocol negotiation

This patch is against the kernel version Linux 4.15-rc8





On Tuesday, February 6, 2018, 10:29:53 AM EST, David Miller <davem@davemlof=
t.net> wrote:=20





From: Denis Du <dudenis2000@yahoo.ca>

Date: Tue, 6 Feb 2018 15:15:28 +0000 (UTC)

> How=C2=A0 do you think my patch?
>=20
> As you see, Krzysztof=C2=A0 think my patch is ok to be accepted.
> But if you have a better idea to fix it,I am glad to see it. Anyway, this=
 issue have to be fixed.


Please resubmit it and I'll think about it again, thank you.


------=_Part_4065182_1320385182.1517935842178
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="=?UTF-8?b?MDAwMS1uZXRkZXYtY2Fycmllci1kZXRlY3Qtb2stZG9uLXQtdHVybi1vZmYtbmVnb3RpYXRpb24ucGF0Y2g=?="
Content-ID: <cd0fa7b4-464d-3f3e-24ac-c03a8066d873@yahoo.com>

RnJvbSBiNTkwMmE0ZGZjNzA5YjYyYjcwNDk5N2FiNjRmMzFjOWVmNjlhNmRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBEdSA8ZHVkZW5pczIwMDBAeWFob28uY2E+CkRhdGU6
IE1vbiwgMTUgSmFuIDIwMTggMTc6MjY6MDYgLTA1MDAKU3ViamVjdDogW1BBVENIXSBuZXRkZXY6
IGNhcnJpZXIgZGV0ZWN0IG9rLCBkb24ndCB0dXJuIG9mZiBuZWdvdGlhdGlvbgoKU29tZXRpbWVz
IHdoZW4gcGh5c2ljYWwgbGluZXMgaGF2ZSBhIGp1c3QgZ29vZCBub2lzZSB0byBtYWtlIHRoZSBw
cm90b2NvbApoYW5kc2hha2luZyBmYWlsLCBidXQgdGhlIGNhcnJpZXIgZGV0ZWN0IHN0aWxsIGdv
b2QuIFRoZW4gYWZ0ZXIgcmVtb3ZlIG9mCnRoZSBub2lzZSwgbm9ib2R5IHdpbGwgdHJpZ2dlciB0
aGlzIHByb3RvY29sIHRvIGJlIHN0YXJ0IGFnYWluIHRvIGNhdXNlCnRoZSBsaW5rIHRvIG5ldmVy
IGNvbWUgYmFjay4gVGhlIGZpeCBpcyB3aGVuIHRoZSBjYXJyaWVyIGlzIHN0aWxsIG9uLCBub3QK
dGVybWluYXRlIHRoZSBwcm90b2NvbCBoYW5kc2hha2luZy4KClNpZ25lZC1vZmYtYnk6IERlbmlz
IER1IDxkdWRlbmlzMjAwMEB5YWhvby5jYT4KLS0tCiBkcml2ZXJzL25ldC93YW4vaGRsY19wcHAu
YyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93YW4vaGRsY19wcHAuYyBiL2RyaXZlcnMvbmV0
L3dhbi9oZGxjX3BwcC5jCmluZGV4IGFmZWNhNmIuLmFiOGIzY2IgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L3dhbi9oZGxjX3BwcC5jCisrKyBiL2RyaXZlcnMvbmV0L3dhbi9oZGxjX3BwcC5jCkBA
IC01NzQsNyArNTc0LDEwIEBAIHN0YXRpYyB2b2lkIHBwcF90aW1lcihzdHJ1Y3QgdGltZXJfbGlz
dCAqdCkKIAkJCXBwcF9jcF9ldmVudChwcm90by0+ZGV2LCBwcm90by0+cGlkLCBUT19HT09ELCAw
LCAwLAogCQkJCSAgICAgMCwgTlVMTCk7CiAJCQlwcm90by0+cmVzdGFydF9jb3VudGVyLS07Ci0J
CX0gZWxzZQorCQl9IGVsc2UgaWYgKG5ldGlmX2NhcnJpZXJfb2socHJvdG8tPmRldikpCisJCQlw
cHBfY3BfZXZlbnQocHJvdG8tPmRldiwgcHJvdG8tPnBpZCwgVE9fR09PRCwgMCwgMCwKKwkJCQkg
ICAgIDAsIE5VTEwpOworCQllbHNlCiAJCQlwcHBfY3BfZXZlbnQocHJvdG8tPmRldiwgcHJvdG8t
PnBpZCwgVE9fQkFELCAwLCAwLAogCQkJCSAgICAgMCwgTlVMTCk7CiAJCWJyZWFrOwotLSAKMi4x
LjQKCg==

------=_Part_4065182_1320385182.1517935842178--
