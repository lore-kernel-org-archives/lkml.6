Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969147AbeCSVLe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:11:34 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:39370 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968048AbeCSVLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:11:20 -0400
X-Google-Smtp-Source: AIpwx4/xEN8+I7U5LOA57UNUDG0YjLycmw6/wcHu8b2TYF3vlt3rIwIpcFScrSToQwAV8HHiA8CAZJOsxxs1ZtdFulA=
MIME-Version: 1.0
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Mon, 19 Mar 2018 14:11:18 -0700
Message-ID: <CAMe9rOoa81MC=oFW3coLuxha0pp6qdZowYR_o_my=n7ZXjVu=g@mail.gmail.com>
Subject: [PATCH] x86: Don't build vDSO with $(RETPOLINE_CFLAGS) -DRETPOLINE
To: LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000034b08f0567ca6697"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000034b08f0567ca6697
Content-Type: text/plain; charset="UTF-8"

vDSO code runs in userspace.  Don't compile it with retpoline.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>


-- 
H.J.

--00000000000034b08f0567ca6697
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-x86-Don-t-build-vDSO-with-RETPOLINE_CFLAGS-DRETPOLIN.patch"
Content-Disposition: attachment;
	filename="0001-x86-Don-t-build-vDSO-with-RETPOLINE_CFLAGS-DRETPOLIN.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jeyq5ka20

RnJvbSA3MTE5MjY0MDllNDI4NjJkZTA4NjMzZWMwNTc4OTIxOTVmZGNlNGUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IEZyaSwgMTYgTWFyIDIwMTggMTQ6NTg6MjkgLTA3MDAKU3ViamVjdDogW1BBVENIXSB4ODY6IERv
bid0IGJ1aWxkIHZEU08gd2l0aCAkKFJFVFBPTElORV9DRkxBR1MpIC1EUkVUUE9MSU5FCgp2RFNP
IGNvZGUgcnVucyBpbiB1c2Vyc3BhY2UuICBEb24ndCBjb21waWxlIGl0IHdpdGggcmV0cG9saW5l
LgoKU2lnbmVkLW9mZi1ieTogSC5KLiBMdSA8aGpsLnRvb2xzQGdtYWlsLmNvbT4KLS0tCiBhcmNo
L3g4Ni9lbnRyeS92ZHNvL01ha2VmaWxlIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS92ZHNv
L01ha2VmaWxlIGIvYXJjaC94ODYvZW50cnkvdmRzby9NYWtlZmlsZQppbmRleCAxYjhlMDQxZDQ5
NzkuLmVlYmNjM2JlZGJmMCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvdmRzby9NYWtlZmls
ZQorKysgYi9hcmNoL3g4Ni9lbnRyeS92ZHNvL01ha2VmaWxlCkBAIC03Niw3ICs3Niw3IEBAIENG
TCA6PSAkKFBST0ZJTElORykgLW1jbW9kZWw9c21hbGwgLWZQSUMgLU8yIC1mYXN5bmNocm9ub3Vz
LXVud2luZC10YWJsZXMgLW02NCBcCiAgICAgICAgLWZuby1vbWl0LWZyYW1lLXBvaW50ZXIgLWZv
cHRpbWl6ZS1zaWJsaW5nLWNhbGxzIFwKICAgICAgICAtRERJU0FCTEVfQlJBTkNIX1BST0ZJTElO
RyAtREJVSUxEX1ZEU08KIAotJCh2b2Jqcyk6IEtCVUlMRF9DRkxBR1MgOj0gJChmaWx0ZXItb3V0
ICQoR0NDX1BMVUdJTlNfQ0ZMQUdTKSwkKEtCVUlMRF9DRkxBR1MpKSAkKENGTCkKKyQodm9ianMp
OiBLQlVJTERfQ0ZMQUdTIDo9ICQoZmlsdGVyLW91dCAkKEdDQ19QTFVHSU5TX0NGTEFHUykgJChS
RVRQT0xJTkVfQ0ZMQUdTKSAtRFJFVFBPTElORSwkKEtCVUlMRF9DRkxBR1MpKSAkKENGTCkKIAog
IwogIyB2RFNPIGNvZGUgcnVucyBpbiB1c2Vyc3BhY2UgYW5kIC1wZyBkb2Vzbid0IGhlbHAgd2l0
aCBwcm9maWxpbmcgYW55d2F5LgpAQCAtMTc3LDYgKzE3Nyw3IEBAIEtCVUlMRF9DRkxBR1NfMzIg
Oj0gJChmaWx0ZXItb3V0IC1tY21vZGVsPWtlcm5lbCwkKEtCVUlMRF9DRkxBR1NfMzIpKQogS0JV
SUxEX0NGTEFHU18zMiA6PSAkKGZpbHRlci1vdXQgLWZuby1waWMsJChLQlVJTERfQ0ZMQUdTXzMy
KSkKIEtCVUlMRF9DRkxBR1NfMzIgOj0gJChmaWx0ZXItb3V0IC1tZmVudHJ5LCQoS0JVSUxEX0NG
TEFHU18zMikpCiBLQlVJTERfQ0ZMQUdTXzMyIDo9ICQoZmlsdGVyLW91dCAkKEdDQ19QTFVHSU5T
X0NGTEFHUyksJChLQlVJTERfQ0ZMQUdTXzMyKSkKK0tCVUlMRF9DRkxBR1NfMzIgOj0gJChmaWx0
ZXItb3V0ICQoUkVUUE9MSU5FX0NGTEFHUykgLURSRVRQT0xJTkUsJChLQlVJTERfQ0ZMQUdTXzMy
KSkKIEtCVUlMRF9DRkxBR1NfMzIgKz0gLW0zMiAtbXNvZnQtZmxvYXQgLW1yZWdwYXJtPTAgLWZw
aWMKIEtCVUlMRF9DRkxBR1NfMzIgKz0gJChjYWxsIGNjLW9wdGlvbiwgLWZuby1zdGFjay1wcm90
ZWN0b3IpCiBLQlVJTERfQ0ZMQUdTXzMyICs9ICQoY2FsbCBjYy1vcHRpb24sIC1mb3B0aW1pemUt
c2libGluZy1jYWxscykKLS0gCjIuMTQuMwoK
--00000000000034b08f0567ca6697--
