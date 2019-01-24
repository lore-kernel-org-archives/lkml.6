Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D022EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D8421855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfAXKq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:46:57 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62610 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfAXKq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:46:56 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id cace0df839facdb8; Thu, 24 Jan 2019 11:46:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2] PM / EM: Expose the Energy Model in debugfs
Date:   Thu, 24 Jan 2019 11:45:56 +0100
Message-ID: <3845915.x0TneKyrcv@aspire.rjw.lan>
In-Reply-To: <20190123092834.hj5v6lup4422wrmf@queper01-lin>
References: <20190122164247.19439-1-quentin.perret@arm.com> <20190122184136.GD31777@kroah.com> <20190123092834.hj5v6lup4422wrmf@queper01-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkbmVzZGF5LCBKYW51YXJ5IDIzLCAyMDE5IDEwOjI4OjM2IEFNIENFVCBRdWVudGluIFBl
cnJldCB3cm90ZToKPiBPbiBUdWVzZGF5IDIyIEphbiAyMDE5IGF0IDE5OjQxOjM2ICgrMDEwMCks
IEdyZWcgS0ggd3JvdGU6Cj4gPiBPbiBUdWUsIEphbiAyMiwgMjAxOSBhdCAwNDo0Mjo0N1BNICsw
MDAwLCBRdWVudGluIFBlcnJldCB3cm90ZToKPiA+ID4gVGhlIHJlY2VudGx5IGludHJvZHVjZWQg
RW5lcmd5IE1vZGVsIChFTSkgZnJhbWV3b3JrIG1hbmFnZXMgcG93ZXIgY29zdAo+ID4gPiB0YWJs
ZXMgb2YgQ1BVcy4gVGhlc2UgdGFibGVzIGFyZSBjdXJyZW50bHkgb25seSB2aXNpYmxlIGZyb20g
a2VybmVsCj4gPiA+IHNwYWNlLiBIb3dldmVyLCBpbiBvcmRlciB0byBkZWJ1ZyB0aGUgYmVoYXZp
b3VyIG9mIHN1YnN5c3RlbXMgdGhhdCB1c2UKPiA+ID4gdGhlIEVNIChFQVMgZm9yIGV4YW1wbGUp
LCBpdCBpcyBvZnRlbiByZXF1aXJlZCB0byBrbm93IHdoYXQgdGhlIHBvd2VyCj4gPiA+IGNvc3Rz
IGFyZSBmcm9tIHVzZXJzcGFjZS4KPiA+ID4gCj4gPiA+IEZvciB0aGlzIHJlYXNvbiwgaW50cm9k
dWNlIHVuZGVyIC9zeXMva2VybmVsL2RlYnVnL2VuZXJneV9tb2RlbCBhIHNldCBvZgo+ID4gPiBk
aXJlY3RvcmllcyByZXByZXNlbnRpbmcgdGhlIHBlcmZvcm1hbmNlIGRvbWFpbnMgb2YgdGhlIHN5
c3RlbS4gRWFjaAo+ID4gPiBwZXJmb3JtYW5jZSBkb21haW4gY29udGFpbnMgYSBzZXQgb2Ygc3Vi
LWRpcmVjdG9yaWVzIHJlcHJlc2VudGluZyB0aGUKPiA+ID4gZGlmZmVyZW50IGNhcGFjaXR5IHN0
YXRlcyAoY3MpIGFuZCB0aGVpciBhdHRyaWJ1dGVzLCBhcyB3ZWxsIGFzIGEgZmlsZQo+ID4gPiBl
eHBvc2luZyB0aGUgcmVsYXRlZCBDUFVzLgo+ID4gPiAKPiA+ID4gVGhlIHJlc3VsdGluZyBoaWVy
YXJjaHkgaXMgYXMgZm9sbG93cyBvbiBBcm0ganVubyByMCBmb3IgZXhhbXBsZToKPiA+ID4gCj4g
PiA+ICAgICAvc3lzL2tlcm5lbC9kZWJ1Zy9lbmVyZ3lfbW9kZWwKPiA+ID4gICAgIOKUnOKUgOKU
gCBwZDAKPiA+ID4gICAgIOKUgiAgIOKUnOKUgOKUgCBjcHVzCj4gPiA+ICAgICDilIIgICDilJzi
lIDilIAgY3M6NDUwMDAwCj4gPiA+ICAgICDilIIgICDilIIgICDilJzilIDilIAgY29zdAo+ID4g
PiAgICAg4pSCICAg4pSCICAg4pSc4pSA4pSAIGZyZXF1ZW5jeQo+ID4gPiAgICAg4pSCICAg4pSC
ICAg4pSU4pSA4pSAIHBvd2VyCj4gPiA+ICAgICDilIIgICDilJzilIDilIAgY3M6NTc1MDAwCj4g
PiA+ICAgICDilIIgICDilIIgICDilJzilIDilIAgY29zdAo+ID4gPiAgICAg4pSCICAg4pSCICAg
4pSc4pSA4pSAIGZyZXF1ZW5jeQo+ID4gPiAgICAg4pSCICAg4pSCICAg4pSU4pSA4pSAIHBvd2Vy
Cj4gPiA+ICAgICDilIIgICDilJzilIDilIAgY3M6NzAwMDAwCj4gPiA+ICAgICDilIIgICDilIIg
ICDilJzilIDilIAgY29zdAo+ID4gPiAgICAg4pSCICAg4pSCICAg4pSc4pSA4pSAIGZyZXF1ZW5j
eQo+ID4gPiAgICAg4pSCICAg4pSCICAg4pSU4pSA4pSAIHBvd2VyCj4gPiA+ICAgICDilIIgICDi
lJzilIDilIAgY3M6Nzc1MDAwCj4gPiA+ICAgICDilIIgICDilIIgICDilJzilIDilIAgY29zdAo+
ID4gPiAgICAg4pSCICAg4pSCICAg4pSc4pSA4pSAIGZyZXF1ZW5jeQo+ID4gPiAgICAg4pSCICAg
4pSCICAg4pSU4pSA4pSAIHBvd2VyCj4gPiA+ICAgICDilIIgICDilJTilIDilIAgY3M6ODUwMDAw
Cj4gPiA+ICAgICDilIIgICAgICAg4pSc4pSA4pSAIGNvc3QKPiA+ID4gICAgIOKUgiAgICAgICDi
lJzilIDilIAgZnJlcXVlbmN5Cj4gPiA+ICAgICDilIIgICAgICAg4pSU4pSA4pSAIHBvd2VyCj4g
PiA+ICAgICDilJTilIDilIAgcGQxCj4gPiA+ICAgICAgICAg4pSc4pSA4pSAIGNwdXMKPiA+ID4g
ICAgICAgICDilJzilIDilIAgY3M6MTEwMDAwMAo+ID4gPiAgICAgICAgIOKUgiAgIOKUnOKUgOKU
gCBjb3N0Cj4gPiA+ICAgICAgICAg4pSCICAg4pSc4pSA4pSAIGZyZXF1ZW5jeQo+ID4gPiAgICAg
ICAgIOKUgiAgIOKUlOKUgOKUgCBwb3dlcgo+ID4gPiAgICAgICAgIOKUnOKUgOKUgCBjczo0NTAw
MDAKPiA+ID4gICAgICAgICDilIIgICDilJzilIDilIAgY29zdAo+ID4gPiAgICAgICAgIOKUgiAg
IOKUnOKUgOKUgCBmcmVxdWVuY3kKPiA+ID4gICAgICAgICDilIIgICDilJTilIDilIAgcG93ZXIK
PiA+ID4gICAgICAgICDilJzilIDilIAgY3M6NjI1MDAwCj4gPiA+ICAgICAgICAg4pSCICAg4pSc
4pSA4pSAIGNvc3QKPiA+ID4gICAgICAgICDilIIgICDilJzilIDilIAgZnJlcXVlbmN5Cj4gPiA+
ICAgICAgICAg4pSCICAg4pSU4pSA4pSAIHBvd2VyCj4gPiA+ICAgICAgICAg4pSc4pSA4pSAIGNz
OjgwMDAwMAo+ID4gPiAgICAgICAgIOKUgiAgIOKUnOKUgOKUgCBjb3N0Cj4gPiA+ICAgICAgICAg
4pSCICAg4pSc4pSA4pSAIGZyZXF1ZW5jeQo+ID4gPiAgICAgICAgIOKUgiAgIOKUlOKUgOKUgCBw
b3dlcgo+ID4gPiAgICAgICAgIOKUlOKUgOKUgCBjczo5NTAwMDAKPiA+ID4gICAgICAgICAgICAg
4pSc4pSA4pSAIGNvc3QKPiA+ID4gICAgICAgICAgICAg4pSc4pSA4pSAIGZyZXF1ZW5jeQo+ID4g
PiAgICAgICAgICAgICDilJTilIDilIAgcG93ZXIKPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFF1ZW50aW4gUGVycmV0IDxxdWVudGluLnBlcnJldEBhcm0uY29tPgo+ID4gPiAKPiA+ID4gLS0t
Cj4gPiA+IAo+ID4gPiBWMjogcmVtb3ZlZCBjaGVjayBvbiByZXR1cm4gdmFsdWUgb2YgZGVidWdm
c19jcmVhdGVfKiAoR3JlZyBLSCkKPiA+ID4gLS0tCj4gPiA+ICBrZXJuZWwvcG93ZXIvZW5lcmd5
X21vZGVsLmMgfCA1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBSZXZpZXdlZC1ieTog
R3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KCkFwcGxpZWQs
IHRoYW5rcyEK


