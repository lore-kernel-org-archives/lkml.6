Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1142589-1521145310-2-3434120576460506941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521145309; b=rRS0ZiErbca5w2KOm5KkZeVPP29+DbBk482xmfEL+n/9sgG
    28MudOkdbQR2IUaG4+nD+uIo8ytqn4tQRJtILIaJQ4GU57iqeq44hVzZ3emFZ9e1
    +TKW98qvcWVBBiP1YVAae1mIjh+5HDuJIVk9IyHSQs+fCIXOMWpBpWGWn72DEpgO
    GscwCEf8Yuv0xZJ1drTIwsjHz65A7n3i2dOkY5JwVFzzNHIoFtOYDF5Y4tUVI7UA
    XtQCCmmn1ThM1PM8MCgPhy5xlv8a+YRQOv5qnjyh0S7lJRbOqnxn/tzfPb9oUeY3
    atpFYFj7BUMSGCCpbqL5WWTYcpQlLEDu4kRIlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521145309; bh=KrLHGL3fLFCTC3/WYAkyipJdaZyhhcaZZ9eiasZA5OA=; b=j
    pT5EcmzwX6gMPV2nY5V0yWOYcK+2YU5N5O6bFWC1X107RBauBD1sLT3na5JeKfVU
    OOnvvHPGZ0v8OqsOyYRN1x8/Y/ElQ4Kcw6Munqt+HQDkgEZC8WbEIHXiLkRh51uH
    aots/GXYuTjtWf+iju8iZtN3lk3sYwEzr5ITFzejXVDYUWku+0LtFxEMBIbPg5WJ
    o6XfYmqPqi5f4jpoy2MOtMtOWlCBlsrIqQQkE7T6LgL6noqt9EYl/iqzVu+ipsPq
    Ey0MKVUfknrudkLWQH5a+VNLIk2Wk1ZoslUHS/pvMA2f/b+lXXqVEa9kvXbeu+d8
    pobtlwevW1D+UcAbaUtnw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=phrozen.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=phrozen.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=phrozen.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=phrozen.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
To: NeilBrown <neil@brown.name>
References: <152105892255.22262.1902152685410223215.stgit@noble>
 <20180315104853.bthffdd4hzklzo6d@mwanda>
 <be0d1e2d-67c5-bac1-63d4-72568dbf9d23@phrozen.org>
 <87muz9ayjz.fsf@notabene.neil.brown.name>
From: John Crispin <john@phrozen.org>
Message-ID: <9e8e07b4-1a4d-3434-402f-920c19c65122@phrozen.org>
Date: Thu, 15 Mar 2018 21:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87muz9ayjz.fsf@notabene.neil.brown.name>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CgpPbiAxNS8wMy8xOCAyMToxMiwgTmVpbEJyb3duIHdyb3RlOgo+IE9uIFRodSwgTWFyIDE1IDIw
MTgsIEpvaG4gQ3Jpc3BpbiB3cm90ZToKPgo+PiBPbiAxNS8wMy8xOCAxMTo0OCwgRGFuIENhcnBl
bnRlciB3cm90ZToKPj4+IFRoaXMgYWxsIHNlZW1zIGZpbmUuICBHZW5lcmFsbHkgdGhlIHJlcXVp
cmVtZW50cyBmb3Igc3RhZ2luZyBhcmUgdGhhdCBpdAo+Pj4gaGFzIGEgVE9ETywgc29tZW9uZSB0
byB3b3JrIG9uIGl0LCBhbmQgaXQgZG9lc24ndCBicmVhayB0aGUgYnVpbGQuICBCdXQKPj4+IHNv
bWUgb2YgdGhlIHBhdGNoZXMgZG9uJ3QgaGF2ZSBjb21taXQgbWVzc2FnZSBhbmQgdGhvc2UgYXJl
IHJlcXVpcmVkIGFuZAo+Pj4gc29tZSBvZiB0aGUgY29tbWl0IG1lc3NhZ2VzIGFyZSBqdXN0IHRo
ZSBjaGFuZ2VzIHlvdSBoYXZlIG1hZGUgbm90IGRvbid0Cj4+PiBkZXNjcmliZSB0aGUgYWN0dWFs
IGNvZGUuLi4KPj4+Cj4+PiBKb2huIENyaXNwaW4ncyBlbWFpbCBpcyBqb2huQHBocm96ZW4ub3Jn
Lgo+Pj4KPj4+IHJlZ2FyZHMsCj4+PiBkYW4gY2FycGVudGVyCj4+Pgo+PiBIaSBBbGwsCj4+Cj4+
IGxvb2tzIGxpa2UgaSB3YXMgQ0MnZWQgb24gdGhlIG9wZW53cnQgYWRkciwgd2hpY2ggbm8gbG9u
Z2VyIGV4aXN0cy4gVGhpcwo+PiBzZXJpZXMgbWFrZXMgbm8gc2Vuc2UuIE5vbmUgb2YgdGhlIHN0
dWZmIHBvc3RlZCBpcyBhbnl3aGVyZSBuZWFyIHJlYWR5Cj4+IHRvIGJlIHVwc3RyZWFtZWQuCj4+
Cj4+ICogd2UgZG9udCBuZWVkIGEgZGVkaWNhdGVkIHBpbmN0cmwgZHJpdmVyLCBwaW5jdHJsLXNp
bmdsZSB3aWxsIHdvcmsgZmluZQo+PiBvbiB0aGVzZSBTb0NzCj4+ICogdGhlIERNQS9zZGhjaSBk
cml2ZXIgaXMgYSBoYWNrZWQgdXAgdmVyc2lvbiBvZiB0aGUgU0RLIGRyaXZlci4KPj4gKiBkcml2
ZXJzL25ldC9ldGhlcm5ldC9tZWRpYXRlay8qIHdvcmtzIG9uIG10NzYyMyBhbmQgaXMgZWFzaWx5
IHBvcnRhYmxlCj4+IHRvIG10NzYyMSwgc2FtZSBnb2VzIGZvciB0aGUgZ3N3IGRyaXZlci4KPiBI
aSBKb2huLAo+ICAgSSB0aGluayBpdCBtYWtlcyBzZW5zZSBpbiB0aGF0LCB3aXRoIHRoZSBwYXRj
aGVzLCB0aGUgaGFyZHdhcmUgd29ya3MsIGFuZAo+ICAgd2l0aG91dCB0aGUgcGF0Y2hlcyAoYXQg
bGVhc3QgdGhlIGZpcnN0KSB5b3UgY2Fubm90IGV2ZW4gYnVpbGQgd2l0aAo+ICAgQ09ORklHX1NP
Q19NVDc2MjE9eSBhcyBwY2liaW9zX21hcF9pcnEoKSBpcyB1bmRlZmluZWQuICBIYXZpbmcKPiAg
IHdvcmtpbmcgY29kZSBpcyBhIGdyZWF0IHN0YXJ0aW5nIHBvaW50IGZvciBmdXJ0aGVyIGRldmVs
b3BtZW50Lgo+ICAgSXQgY2VydGFpbmx5IGlzbid0IHJlYWR5IGZvciB1cHN0cmVhbSwgd2hpY2gg
aXMgd2h5IGl0IGlzIGhlYWRpbmcgZm9yCj4gICBkcml2ZXJzL3N0YWdpbmcuICBUaGlzIGlzIGV4
cGxpY2l0bHkgZm9yIGNvZGUgdGhhdCBpc24ndCB5ZXQgcmVhZHkuCj4gICBCeSBwdXR0aW5nIHRo
ZSBjb2RlIHRoZXJlIGl0IHNob3VsZCBiZSBzYWZlIGZyb20gYml0LXJvdCwgYW5kIGNhbiBiZQo+
ICAgd29ya2VkIG9uIGJ5IG11bHRpcGxlIHBlb3BsZS4gIEl0IGdldHMgaW5jcmVhc2VkIHZpc2li
aWxpdHkgc28gcGVvcGxlCj4gICBjYW4gc2F5IGhvdyBiYWQgaXQgaXMgKGFzIHlvdSBoYXZlIGRv
bmUgLSB0aGFua3MpLiAgVGhpcyBmZWVkIGJhY2sgaXMgYQo+ICAgdmFsdWFibGUgcGFydCBvZiBp
bXByb3ZpbmcgdGhlIGNvZGUgYW5kIGdldHRpbmcgaXQgb3V0IG9mIHN0YWdpbmcuCj4KPiAgIEkn
bGwgYWRkIG5vdGVzIHRvIHZhcmlvdXMgVE9ETyBmaWxlcyBiYXNlZCBvbiB5b3VyIGNvbW1lbnRz
LiAgSWYgeW91Cj4gICBoYXZlIGFueXRoaW5nIGVsc2UgdG8gYWRkLCBpdCB3b3VsZCBiZSBtb3N0
IHdlbGNvbWUuICBUaGFuayB5b3UgZm9yCj4gICBtYWtpbmcgdGhlc2UgcGF0Y2hlcyBhdmFpbGFi
bGUgaW4gdGhlIGZpcnN0IHBsYWNlLCBzbyB0aGF0IG15IGhhcmR3YXJlCj4gICBjYW4gd29yayEK
Pgo+IFRoYW5rcywKPiBOZWlsQnJvd24KCkhpIE5laWwsCgpJIHVuZGVyc3RhbmQgeW91ciByZWFz
b25pbmcsIGhvd2V2ZXIgLi4uCm9ubHkgdGhlIHBjaWUgZHJpdmVyIGlzIHdvcnRoIG1lcmdpbmcu
IGFsbCBvdGhlciBkcml2ZXJzIGFyZSBhbHJlYWR5IAppbnNpZGUgdGhlIGtlcm5lbCBmb3IgbXQ3
NjIzIGFuZCBjYW4gYmUgZWFzaWx5IGFkYXB0ZWQgdG8gd29yayBvbiAKbXQ3NjIxLiBoYXZpbmcg
ZHVwbGljYXRlIGRyaXZlcnMgaXMgYSBjZXJ0YWluIG5vLWdvLgpjbGVhbmluZyB1cCB0aGUgcGNp
IGRyaXZlciBpcyBhIG1hdHRlciBvZiBhIGZldyBkYXlzIHdvcmsuIG1lcmdpbmcgYSAKc2hpdHR5
IHBjaSBkcml2ZXIganVzdCB0byBwb3N0cG9uZSBkb2luZyB0aGUgMy01IGRheXMgd29yayBpbnZv
bHZlZCB0byAKcG9saXNoIGl0IHNlZW1zIGEgcmFsbHkgYmFkIHRyYWRlLW9mZi4KaSBzdHJvbmds
eSBvcHBvc2UgaGF2aW5nIGFueSBvZiB0aGlzIGNvZGUgbWVyZ2VkIGludG8gdGhlIGtlcm5lbCwg
ZXZlbiAKaWYgaXQgaXMgb25seSB0aGUgc3RhZ2luZyBhcmVhLgoKIMKgwqDCoCBKb2huCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRldmVsIG1haWxpbmcg
bGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnCmh0dHA6Ly9kcml2ZXJkZXYubGludXhk
cml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaXZlcmRldi1kZXZlbAo=
