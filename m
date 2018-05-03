Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2839629-1525367888-2-6687340935127376396
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525367887; b=XEyHSehyJHIrcPLGl7Ll5FkObvJQ8uRSkU5VLr/48zVb9OnhKI
    5x1FZeKGuuJ8eQtgYZ6seydcddaFvnXh96RYWS9ReFFThN+bP8iNbxq7+j8OVNXx
    rYs2lzcBgfQLCHeLq6OxENaFO04FW2qBzGlATGiwPF1+bDgH+SlOUSm9zaNj/VWW
    wmpThqIvBPxQcGgl88/SfPbV6TuqVxSKwfa5FC9elZVgvrmEuxV6lPTqC9qpFGvJ
    VIacVs//7+jNYujFWzvZ/K/q/AoRqifFVAEKinRWTuwF6GvEP3/ZZuqq0oQlnIye
    PsBLEbk45i8WO0TJ2X8ae27fppht9wnkjZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:references:message-id:date
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525367887; bh=bxMqH
    jEM8JkZD82jrsBDs2IqX4CW/WtWoGnbZq33OW4=; b=kmLDHCQhNTUvjIODj5U73
    zFWMahJoO3C6kF4rI0ynj5FLX/cdroySwy/K8nBrqA762QkNE+oEfvHf/wJ5uN23
    7L4yUM+NcidOuTPBZMC7RcPDYxv6aIMPT7EBrckcA/UP5Jd3pJR6nHrKF0VgEN4M
    Ww3Px2Dd6ZqNUhG6R+mA9MrG0Mcn3iT//jPyZdVXulnsABOHtjN+XnTvdFaBapvo
    UVZyAgpJ1lfpvGrOqJbo202JsVZ2ItterQKduEQo7kIzNatQJdqlKnhltHnYdsD9
    zaGxsecjEZzQFGqC8S+loWF/CCqpYqrx2OUEgMG9ZJIzEBGvMFqGqEYU23lRXaov
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Z3zFafA3
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Z3zFafA3
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfITbuE2/T6CujsSurLfhh6xnI3ADNQ426GqQctZBStVnkqYX25XSHAUBHr0czsEkiSkKAG/zHKBa9DyBz9XZjaL6HE7lnXnVW0j97z/HgpL5k2ul1GVr
    gnC2aBOJcF8M5uCV5dL2jmmRMXr1JajzX/w0QjG5COOsP6GgRVeVN1rNtMnzSgDL6VwoYB6KE29HQO1ZrBSbuHW9ZSOEttbi7IiNwM8/o5GYu+QEwFZtCt8B
    4fE4NFmZq+FkqbpLVdnT/g==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=e6hqSEod03VnqL-vwOcA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
From: Randy Dunlap <rdunlap@infradead.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20180501163818.GD1468@sasha-vm>
	<20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org> <877eol808s.fsf@intel.com>
	<1525357984.3225.12.camel@HansenPartnership.com>
	<20180503144850.GC23311@1wt.eu> <20180503150608.GM18390@sasha-vm>
	<1525361268.3225.17.camel@HansenPartnership.com>
	<20180503154342.GN18390@sasha-vm>
Message-ID: <80974b02-8037-b412-36f9-1b7656ec9d4e@infradead.org>
Date: Thu, 3 May 2018 10:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503154342.GN18390@sasha-vm>
Content-Language: en-US
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Ksummit-discuss]  bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMDUvMDMvMjAxOCAwODo0MyBBTSwgU2FzaGEgTGV2aW4gd3JvdGU6Cj4gT24gVGh1LCBNYXkg
MDMsIDIwMTggYXQgMDg6Mjc6NDhBTSAtMDcwMCwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+PiBP
biBUaHUsIDIwMTgtMDUtMDMgYXQgMTU6MDYgKzAwMDAsIFNhc2hhIExldmluIHZpYSBLc3VtbWl0
LWRpc2N1c3MKPj4gd3JvdGU6Cj4+PiBPbiBUaHUsIE1heSAwMywgMjAxOCBhdCAwNDo0ODo1MFBN
ICswMjAwLCBXaWxseSBUYXJyZWF1IHdyb3RlOgo+Pj4+IE9uIFRodSwgTWF5IDAzLCAyMDE4IGF0
IDA3OjMzOjA0QU0gLTA3MDAsIEphbWVzIEJvdHRvbWxleSB3cm90ZToKPj4+Pj4gVGhleSdyZSBk
ZWZpbml0ZWx5IGZvciBidWcgZml4ZXMsIGJ1dCB0aGVyZSdzIGEgc3BlY3RydW06IG9idmlvdXMK
Pj4+Pj4gYnVnIGZpeGVzIHdpdGggbm8gc2lkZSBlZmZlY3RzIGFyZSBlYXN5IHRvIGp1c3RpZnku
wqDCoE1vcmUgY29tcGxleAo+Pj4+PiBidWcgZml4ZXMgcnVuIHRoZSByaXNrIG9mIGhhdmluZyBz
aWRlIGVmZmVjdHMgd2hpY2ggaW50cm9kdWNlCj4+Pj4+IG90aGVyIGJ1Z3MsIHNvIGNvdWxkIHBv
dGVudGlhbGx5IGRlc3RhYmlsaXplIHRoZSAtcmMgcHJvY2Vzcy7CoMKgSW4KPj4+Pj4gU0NTSSB3
ZSB0ZW5kIHRvIGxvb2sgYXQgd2hhdCB0aGUgdXNlciB2aXNpYmxlIGVmZmVjdHMgb2YgdGhlIGJ1
Zwo+Pj4+PiBhcmUgaW4gdGhlIHBvc3QgLXJjNSByZWdpb24gYW5kIGlmIHRoZXkncmUgc2xpZ2h0
IG9yIHdvdWxkbid0IGJlCj4+Pj4+IHZpc2libGUgdG8gbW9zdCB1c2Vycywgd2UnbGwgaG9sZCB0
aGVtIG92ZXIuwqDCoElmIHRoZSBmaXggbG9va3MKPj4+Pj4gY29tcGxleCBhbmQgd2UncmUgbm90
IHN1cmUgd2UgY2F1Z2h0IHRoZSByYW1pZmljYXRpb25zLCB3ZSBvZnRlbgo+Pj4+PiBhZGQgaXQg
dG8gdGhlIG1lcmdlIHdpbmRvdyB0cmVlIHdpdGggYSBjYyB0byBzdGFibGUgYW5kIGEgbm90ZQo+
Pj4+PiBzYXlpbmcgdG8gd2FpdCBYIHdlZWtzIGJlZm9yZSBhY3R1YWxseSBhZGRpbmcgdG8gdGhl
Cj4+Pj4+IHN0YWJsZSB0cmVlIGp1c3QgdG8gbWFrZSBzdXJlIG5vIHNpZGUgZWZmZWN0cyBzaG93
IHVwIHdpdGggd2lkZXIKPj4+Pj4gdGVzdGluZy7CoMKgU28sIGFzIHdpdGggbW9zdCB0aGluZ3Ms
IGl0J3MgYSBqdWRnbWVudCBjYWxsIGZvciB0aGUKPj4+Pj4gbWFpbnRhaW5lci4KPj4+Pgo+Pj4+
IEZvciBtZSB0aGlzIGlzIHRoZSByaWdodCwgYW5kIHJlc3BvbnNpYmxlIHdheSB0byBkZWFsIHdp
dGggYnVnCj4+Pj4gZml4ZXMuIFNlbGYtY29udHJvbCBpcyBtdWNoIG1vcmUgZWZmaWNpZW50IHRo
YW4gcmFuZG9tIHJlamVjdGlvbgo+Pj4+IGFuZCBmYXZvcnMgYSBnb29kIGFuYWx5c2lzLgo+Pj4K
Pj4+IEkgdGhpbmsgdGhhdCB0aGUgaWRlYWwgb3V0Y29tZSBvZiB0aGlzIGRpc2N1c3Npb24sIGF0
IGxlYXN0IGZvciBtZSwKPj4+IGlzIGEgdG9vbCB0byBnbyB1bmRlciBzY3JpcHRzLyB0aGF0IHdv
dWxkIGFsbG93IG1haW50YWluZXJzIHRvIGdldAo+Pj4gc29tZSBzb3J0IG9mIChxdWFudGlmaWFi
bGUpIGRhdGEgdGhhdCB3aWxsIGluZGljYXRlIGhvdyB3ZWxsIHRoZQo+Pj4gcGF0Y2ggd2FzIHRl
c3RlZCB2aWEgdGhlIHJlZ3VsYXIgY2hhbm5lbHMuCj4+Pgo+Pj4gQXQgd2hpY2ggcG9pbnQgaXQn
cyB0aGUgbWFpbnRhaW5lcidzIGp1ZGdlbWVudCBjYWxsIG9uIHdoZXRoZXIgaGUKPj4+IHdhbnRz
IHRvIGdyYWIgdGhlIHBhdGNoIG9yIHdhaXQgZm9yIG1vcmUgdGVzdHMgb3IgcmV2aWV3cy4KPj4+
Cj4+PiBUaGlzIGlzIHZlcnkgc2ltaWxhciB0byB3aGF0IEphbWVzIGhhcyBkZXNjcmliZWQsIGl0
IGp1c3QgbmVlZHMgdG8KPj4+IGxlYXZlIGhpcyBicmFpbiBhbmQgdHVybiBpbnRvIGNvZGUgOikK
Pj4KPj4gSSBhcHByZWNpYXRlIHRoZSBzZW50aW1lbnQsIGJ1dCBpZiB3ZSBjb3VsZCBzY3JpcHQg
dGFzdGUsIHdlJ2QgaGF2ZQo+PiByZXBsYWNlZCBMaW51cyB3aXRoIHNvbWV0aGluZyBmYXIgbGVz
cyBjYW50YW5rZXJvdXMgYSBsb25nIHRpbWUgYWdvIC4uLgo+IAo+IExpbnVzLCBJTU8sIGlzIGdl
dHRpbmcgcmVwbGFjZWQuIExvb2sgYXQgaG93IG1hbnkgZnVuY3Rpb25zIGhlIHVzZWQgdG8KPiBk
byAxMCB5ZWFycyBhZ28gaGUncyBubyBsb25nZXIgcmVzcG9uc2libGUgZm9yLgoKQWdyZWUuCgo+
IE9uZSBvZiB0aGUgbW9zdCBvYnZpb3VzIGV4YW1wbGVzIGlzIC1uZXh0LCB3aGVyZSBtb3N0IGlu
dGVncmF0aW9uIGlzc3Vlcwo+IGFyZSByZXNvbHZlZCBiZWZvcmUgdGhleSBldmVuIHJlYWNoIHRv
IExpbnVzLgo+IAo+IFRoaXMgaXMgZ29vZCBmb3IgdGhlIGNvbW11bml0eSwgYXMgaXQgYWxsb3dz
IHVzIG1ha2UgdGhlIHByb2Nlc3MgYmV0dGVyCj4gYW5kIHNjYWxlIG91dC4gSXQgaXMgYWxzbyBn
b29kIGZvciBMaW51cywgYXMgSSdtIG5vdCBzdXJlIGhvdyBsb25nIGhlJ2QKPiBsYXN0IGlmIGhl
IHN0aWxsIGhhZCB0byBlZGl0IHBhdGNoZXMgYnkgaGFuZCB0b28gb2Z0ZW4uIEluc3RlYWQsIGhl
IGdldHMKPiB0byBwbGF5IHdpdGggdGhpbmdzIHRoYXQgaW50ZXJlc3QgaGltIG1vcmUgd2hlcmUg
aGlzIGlzIGlycmVwbGFjZWFibGUuCj4gCj4+IEl0J3MgYWxzbyBhIHNhZCBmYWN0IHRoYXQgYSBs
b3Qgb2YgdGhpbmdzIHdoaWNoIGxvb2sgbGlrZSBvYnZpb3VzIGZpeGVzCj4+IGFjdHVhbGx5IHR1
cm4gb3V0IG5vdCB0byBiZSBzbyB3aXRoIGxhdGVyIHRlc3RpbmcuICBUaGlzIGlzIHdoeSB0aGUK
Pj4gdXNlciB2aXNpYmlsaXR5IHRlc3QgaXMgcGFyYW1vdW50LiAgSWYgYSBidWcgZml4IGhhcyBu
byByZWFsIHVzZXIKPj4gdmlzaWJsZSBlZmZlY3RzLCBpdCdzIG9mdGVuIGJldHRlciB0byBkZWZl
ciBpdCBubyBtYXR0ZXIgaG93IG9idmlvdXMgaXQKPj4gbG9va3MsIHdoaWNoIGlzIHdoeSB0aGUg
c3RhdGljIGNvZGUgY2hlY2tlcnMgb2Z0ZW4gZ2V0IHNob3J0IHNocmlmdAo+PiBiZWZvcmUgYSBt
ZXJnZSB3aW5kb3cuCj4+Cj4+IEEgc2NyaXB0IG1lYXN1cmluZyB1c2VyIHZpc2liaWxpdHkgd291
bGQgYmUgbmljZSwgYnV0IGxvb2tzIGEgYml0Cj4+IGNvbXBsZXggLi4uCj4gCj4gSXQgaXMsIGJ1
dCBJIHRoaW5rIGl0J3Mgd29ydGh3aGlsZS4gV291bGQgc29tZXRoaW5nIHRoYXQnbGwgc2hvdyB5
b3UKPiB0aGluZ3MgbGlrZToKPiAKPiAgLSBIb3cgbG9uZyBhIHBhdGNoIGhhcyBiZWVuIGluIC1u
ZXh0Pwo+ICAtIEhvdyBtYW55IHJlcGxpZXMvcmV2aWV3cy9jb21tZW50cyBpdCBnb3Qgb24gYSBt
YWlsaW5nIGxpc3Q/Cj4gIC0gRGlkIHRoZSAwZGF5IGJvdCB0ZXN0IGl0Pwo+ICAtIERpZCBzeXpi
b3QgZnV6eiBpdD8gZm9yIGhvdyBsb25nPwo+ICAtIElmIGl0IHJlZmVyZW5jZXMgYSBidWd6aWxs
YSBvZiBzb21lIHNvcnQsIGhvdyBtYW55Cj4gICAgY29tbWVudHMvcmV2aWV3cy9ldGMgaXQgZ290
IHRoZXJlPwo+ICAtIElzIGl0IC1zdGFibGUgbWF0ZXJpYWwsIG9yIGRvZXMgaXQgZml4IGEgcmVn
cmVzc2lvbiBpbiB0aGUgY3VycmVudAo+ICAgIG1lcmdlIHdpbmRvdz8KPiAgLSBJZiBzdWJzeXN0
ZW0gaGFzIGN1c3RvbSB0ZXN0aW5nIHJpZywgcmVzdWx0cyBmcm9tIHRob3NlIHRlc3RzCj4gCj4g
YmUgYSBzdGVwIGluIHRoZSByaWdodCB3YXk/IGlzIGl0IHNvbWV0aGluZyB5b3UnZCB1c2UgdG8g
bWFrZSBkZWNpc2lvbnMKPiBvbiB3aGV0aGVyIHlvdSdkIHRha2UgYSBwYXRjaCBpbj8KPiAKClJl
bWluZHMgbWUgKHRvbyBtdWNoKSBvZiBjaGVja3BhdGNoLiAgU3VyZSBjaGVja3BhdGNoIGhhcyBp
dHMgdXNlcywKYXMgbG9uZyBhcyBpdHMgbm90IHNlZW4gYXMgdGhlIG9ubHkgdHJ1ZSB2b2ljZS4g
KHNvbWUgYmVnaW5uZXJzIGRvbid0Cmtub3cgYWJvdXQgdGhhdCB5ZXQpCgpTbyB3aXRoIHRoaXMg
bmV3IHNjcmlwdCwgaHVtYW4gZXZhbHVhdGlvbiB3b3VsZCBzdGlsbCBiZSBuZWVkZWQuCkl0J3Mg
anVzdCBhIHRvb2wuICBJIGNvdWxkIGJlIHVzZWQgb3IgbWlzdXNlZCBvciBhYnVzZWQuCiRtYWlu
dGFpbmVyIHN0aWxsIGhhcyBhIGpvYiB0byBkbywgYnV0IGhhdmluZyBhIHRvb2wgY291bGQgaGVs
cC4KCkJ1dCBiZSBjYXJlZnVsIHdoYXQgeW91IHdpc2ggZm9yLiAgSGF2aW5nIHN1Y2ggYSB0b29s
IGNvdWxkIGhlbHAgZ2V0CnBhdGNoZXMgbWVyZ2VkIGV2ZW4gcXVpY2tlci4KCi0tIAp+UmFuZHkK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KS3N1bW1pdC1k
aXNjdXNzIG1haWxpbmcgbGlzdApLc3VtbWl0LWRpc2N1c3NAbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9r
c3VtbWl0LWRpc2N1c3MK
