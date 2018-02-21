Return-Path: <prvs=15874C0AEB=shufan_lee@richtek.com>
X-Cyrus-Session-Id: sloti22d1t05-1717131-1519225604-2-13325666901010542968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='220.130.44.152', Host='mg.richtek.com', Country='TW', FromHeader='com',
  MailFrom='com', XOriginatingCountry='TW'
X-Spam-charsets: from='big5', cc='big5', subject='big5', plain='big5'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: prvs=15874C0AEB=shufan_lee@richtek.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519225604; b=kPRuAgd5D7wZzdmz40ogc7iZC36nMcr5X2KLM6UFWrXQ0Qu
    /yKN5jGa6flb5DgCzm16ZWG9Bup5P0xkHOr10unaA1tyaweg115pUqVHNKqVlAAS
    9mQU9kjKmA5Ac+BrxTjXzlpHeG0VppOqT9m7aolz77tgLWDpjRdxW2DdKAi5e6jH
    DeH0we1eu+CQre9mn7Ih+ktq203Moci9NsSPKMpFLnufPQ2S9uYsmgR9E8SVV5yb
    SVQx2pmrjoJEbQccjP8SgjKLkxZNB5CIOHFXWOnwztllQS9By7L5lOHfhx4KKg2J
    fNH3Zq+6y5GsY0LZRqTjCjT5S734P+oRxxglEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version; s=arctest; t=1519225604; bh=tKZEDNWb1+hI2ohxvDwK9
    YjtwzBLneYtyhqTpeH75G8=; b=gdyq8PdGSNhErSAFB/+rfLF4bz7sDW+05FjNT
    sLwIve1bZxeiJx1v34nSqAZ5D5ivP1+zkPvjCY8nGrt4DJ+oWIC9I1fHioUcNFEJ
    XEN5PeUWWYF07QiAQzQr7VNNXtLwqErDGwgi1yDSWtJpxoFFw2gMnqzl8qaP3ICh
    vBcUzyncbzg7LC6YS5qopVRtVyxyhSGKQ8pHuf7Jn9MkePjrgwzcZA1+FfQRasP5
    oeiZbagCTyjVt7kFZ8YoQhAI84PTcUomq4WsdZrhQ/UsB/KC8DlqeF1LHOr0t8B6
    Pgc6iQwaqSpJEefkugBi8E8K8gGdnS7H9JqhtawE1bADZwpFA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=richtek.com;
    iprev=pass policy.iprev=220.130.44.152 (mg.richtek.com);
    spf=pass smtp.mailfrom=prvs=15874C0AEB=shufan_lee@richtek.com smtp.helo=mg.richtek.com;
    x-aligned-from=domain_pass;
    x-ptr=pass x-ptr-helo=mg.richtek.com x-ptr-lookup=mg.richtek.com;
    x-return-mx=pass smtp.domain=richtek.com smtp.result=pass smtp_is_org_domain=yes header.domain=richtek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=richtek.com;
    iprev=pass policy.iprev=220.130.44.152 (mg.richtek.com);
    spf=pass smtp.mailfrom=prvs=15874C0AEB=shufan_lee@richtek.com smtp.helo=mg.richtek.com;
    x-aligned-from=domain_pass;
    x-ptr=pass x-ptr-helo=mg.richtek.com x-ptr-lookup=mg.richtek.com;
    x-return-mx=pass smtp.domain=richtek.com smtp.result=pass smtp_is_org_domain=yes header.domain=richtek.com header.result=pass header_is_org_domain=yes
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
	LIVER,40,3)
From: =?big5?B?c2h1ZmFuX2xlZSin9a7Rpnwp?= <shufan_lee@richtek.com>
To: Greg KH <greg@kroah.com>, ShuFanLee <leechu729@gmail.com>
CC: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	=?big5?B?Y3lfaHVhbmcotsCx0q3sKQ==?= <cy_huang@richtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: =?big5?B?pl7C0DogW1BBVENIIHYzXSBIYW5kbGUgdmVuZG9yIGRlZmluZWQgYmVoYXZpb3Ig?=
 =?big5?B?aW4gdGNwY2lfaW5pdCwgdGNwY2lfc2V0X3Zjb25uIGFuZCBleHBvcnQgdGNwY2lf?=
 =?big5?B?aXJxLiBNb3JlIG9wZXJhdGlvbnMgY2FuIGJlIGV4dGVuZGVkIGluIHRjcGNpX2Rh?=
 =?big5?B?dGEgaWYgbmVlZGVkLiBBY2NvcmRpbmcgdG8gVENQQ0kgc3BlY2lmaWNhdGlvbiwg?=
 =?big5?B?NC40LjUuMiBST0xFX0NPTlRST0wsIFRDUEMgc2hhbGwgbm90IHN0YXJ0IERSUCB0?=
 =?big5?Q?oggling_until_...?=
Thread-Topic: [PATCH v3] Handle vendor defined behavior in tcpci_init,
 tcpci_set_vconn and export tcpci_irq. More operations can be extended in
 tcpci_data if needed. According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
 TCPC shall not start DRP toggling until ...
Thread-Index: AQHTqyHAtLT/X0NWZEeKLKy7Yzn5JqOu89cL
Date: Wed, 21 Feb 2018 15:04:32 +0000
Message-ID: <1519225472658.24121@richtek.com>
References: <1519223434-7396-1-git-send-email-leechu729@gmail.com>,<20180221143909.GA29620@kroah.com>
In-Reply-To: <20180221143909.GA29620@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [114.32.235.24]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgR2VyZywNCg0KICBUaGFuayB5b3UhDQoNCiAgSSd2ZSBmaXhlZCBpdCBhbmQgc2VudCBhbm90
aGVyIGVtYWlsLg0KDQpCZXN0IFJlZ2FyZHMsDQoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKg0KU2h1LUZhbiBMZWUNClJpY2h0ZWsgVGVjaG5vbG9neSBDb3Jwb3JhdGlv
bg0KVEVMOiArODg2LTMtNTUyNjc4OSAjMjM1OQ0KRkFYOiArODg2LTMtNTUyNjYxMg0KKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KsUil86rMOiBHcmVnIEtIIDxncmVnQGtyb2FoLmNvbT4N
CrFIpfOk6bTBOiAyMDE4pn4ypOsyMaTpIKRVpMggMTA6MzkNCqaspfOqzDogU2h1RmFuTGVlDQqw
xqW7OiBoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tOyBsaW51eEByb2Vjay11cy5uZXQ7
IHNodWZhbl9sZWUop/Wu0aZ8KTsgY3lfaHVhbmcotsCx0q3sKTsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KpUSmrjogUmU6IFtQQVRDSCB2
M10gSGFuZGxlIHZlbmRvciBkZWZpbmVkIGJlaGF2aW9yIGluIHRjcGNpX2luaXQsIHRjcGNpX3Nl
dF92Y29ubiBhbmQgZXhwb3J0IHRjcGNpX2lycS4gTW9yZSBvcGVyYXRpb25zIGNhbiBiZSBleHRl
bmRlZCBpbiB0Y3BjaV9kYXRhIGlmIG5lZWRlZC4gQWNjb3JkaW5nIHRvIFRDUENJIHNwZWNpZmlj
YXRpb24sIDQuNC41LjIgUk9MRV9DT05UUk9MLCBUQ1BDIHNoYWxsIG5vdCBzdGFydCBEUlAgdG9n
Z2xpbmcgdW50aWwgLi4uDQoNCk9uIFdlZCwgRmViIDIxLCAyMDE4IGF0IDEwOjMwOjM0UE0gKzA4
MDAsIFNodUZhbkxlZSB3cm90ZToNCj4gRnJvbTogU2h1RmFuTGVlIDxzaHVmYW5fbGVlQHJpY2h0
ZWsuY29tPg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaHVGYW5MZWUgPHNodWZhbl9sZWVAcmljaHRl
ay5jb20+DQoNClNvbWV0aGluZyB3ZW50IHJlYWxseSB3cm9uZyB3aXRoIHlvdXIgc3ViamVjdCBs
aW5lIDooDQoNClBsZWFzZSBmaXggYW5kIHRyeSBhZ2Fpbi4NCg0KdGhhbmtzLA0KDQpncmVnIGst
aA0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioq
KioqKioqKioqDQoNClRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVz
c2FnZSAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJv
cHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90aGVyd2lzZSBleGVtcHQgZnJvbSBkaXNjbG9zdXJl
IHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUgY29udmV5ZWQgb25s
eSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24s
IGRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1t
YWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChz
KSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBtYXkgYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUg
bm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZSB0aGF0
IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRo
ZSBzZW5kZXIgaW1tZWRpYXRlbHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRl
IGFueSBhbmQgYWxsIGNvcGllcyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2ht
ZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudCBv
ZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo=
