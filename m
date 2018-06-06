Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="mvDEGkqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFD04606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeFFSTY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:19:24 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:56885 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeFFSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:19:21 -0400
X-IronPort-AV: E=Sophos;i="5.49,484,1520899200";
   d="scan'208";a="735741166"
Subject: Re: [less-CONFIG_NET 1/7] net: reorder filter code
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Network Development" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
 <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
 <CAF=yD-JCtvVpdxwrncFurc_-OO_VtELjkxBLh=1Gk3jTnOQmug@mail.gmail.com>
From: Norbert Manthey <nmanthey@amazon.de>
Openpgp: preference=signencrypt
Autocrypt: addr=nmanthey@amazon.de; prefer-encrypt=mutual; keydata=
 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
 pEddsOqYwOs=
Message-ID: <1755f5e6-a63e-3f83-30e6-2015aa2ee4d5@amazon.de>
Date: Wed, 6 Jun 2018 20:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-JCtvVpdxwrncFurc_-OO_VtELjkxBLh=1Gk3jTnOQmug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.43.160.173]
X-ClientProxiedBy: EX13D05UWC001.ant.amazon.com (10.43.162.82) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDYvMjAxOCAwNjozMyBQTSwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiBPbiBXZWQs
IEp1biA2LCAyMDE4IGF0IDk6NTMgQU0sIE5vcmJlcnQgTWFudGhleSA8bm1hbnRoZXlAYW1hem9u
LmRlPiB3cm90ZToKPj4gVGhpcyBjb21taXQgcmVvcmRlcnMgdGhlIGRlZmluaXRpb24gb2YgZnVu
Y3Rpb25zIGFuZCBzdHJ1Y3QgaW4gdGhlCj4+IGZpbGUgZmlsdGVyLmMsIHN1Y2ggdGhhdCBpbiB0
aGUgbmV4dCBzdGVwIHdlIGNhbiBlYXNpbHkgY3V0IHRoZSBmaWxlCj4+IGludG8gYSBjb21tb25s
eSB1c2VkIHBhcnQsIGFzIHdlbGwgYXMgYSBwYXJ0IHRoYXQgaXMgb25seSByZXF1aXJlZCBpbgo+
PiBjYXNlIENPTkZJR19ORVQgaXMgYWN0dWFsbHkgc2V0Lgo+Pgo+PiBUaGlzIGlzIHBhcnQgb2Yg
dGhlIGVmZm9ydCB0byBzcGxpdCBDT05GSUdfU0VDQ09NUF9GSUxURVIgYW5kCj4+IENPTkZJR19O
RVQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5vcmJlcnQgTWFudGhleSA8bm1hbnRoZXlAYW1hem9u
LmRlPgo+IFJlb3JkZXJpbmcgcGF0Y2hlcyBsaWtlIHRoaXMgYW5kIHRoZSBmbG93LWRpc3NlY3Rv
ciBwYXRjaCBpbiB0aGlzCj4gc2VyaWVzIG1ha2UgY2hlcnJ5LXBpY2tpbmcgZml4ZXMgYmFjayB0
byBzdGFibGUgYnJhbmNoZXMgYW5kCj4gYW5kIGZvbGxvd2luZyBjb2RlIGhpc3Rvcnkgd2l0aCBn
aXQgYmxhbWUgaGFyZGVyLgo+CkRlYXIgV2lsbGVtLAoKSSBhZ3JlZSB0aGF0IHRoaXMgY2hhbmdl
IG1ha2VzIGNoZXJyeSBwaWNraW5nIGhhcmRlci4gV2hlbiBrZWVwaW5nIHRoZQpvcmRlciBvZiB0
aGUgY29kZSwgdGhlIGZvbGxvd2luZyBjb21taXRzIGhhdmUgdG8gaW50cm9kdWNlIG1hbnkgcGFp
cnMKIiNpZmRlZiBDT05GSUdfTkVUIC0gI2VuZGlmIiBhbmQgIiNpZiBkZWZpbmVkKENPTkZJR19O
RVQpIHx8wqAKZGVmaW5lZChDT05GSUdfU0VDQ09NUF9GSUxURVIpICNlbmRpZiIKVGhpcyBpcyBo
b3cgSSBkZXZlbG9wZWQgdGhlIGNvbW1pdHMsIGJ1dCB0aGVuIHJlZmFjdG9yZWQgZm9yIGltcHJv
dmVkCnJlYWRhYmlsaXR5LgoKRnJvbSBteSBleHBlcmllbmNlLCBjaGVycnkgcGlja2luZyBjaGFu
Z2VzIGZyb20gdGhpcyB2YXJpYW50IGlzIGVxdWFsbHkKZGlmZmljdWx0LiBBIHRoaXJkIGFsdGVy
bmF0aXZlLCBzcGxpdHRpbmcgdGhlIGZpbGVzIGludG8gc2VwYXJhdGUgZmlsZXMsCndvdWxkIGZv
cmNlIG1lIHRvIG1ha2UgY3VycmVudCBzdGF0aWMgZGVmaW5pdGlvbnMgdmlzaWJsZS4KCkkgYW0g
aGFwcHkgdG8gZ28gYW5vdGhlciByb3V0ZSwgaWYgcGVvcGxlIGluc2lzdCB0aGF0IHRoaXMgaXMg
dGhlIGJldHRlcgp3YXkgZm9yd2FyZC4KCkJlc3QsCk5vcmJlcnQKCkFtYXpvbiBEZXZlbG9wbWVu
dCBDZW50ZXIgR2VybWFueSBHbWJICkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZp
Y2U6IEtyYXVzZW5zdHIuIDM4LCAxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBS
YWxmIEhlcmJyaWNoLCBDaHJpc3RpYW4gU2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWlu
Z2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==
