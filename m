Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16B6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB76E20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB76E20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeKHS2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:28:42 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:46844 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeKHS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:28:42 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 2A1ED2195B80;
        Thu,  8 Nov 2018 09:54:05 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 8 Nov 2018
 09:54:04 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Thu, 8 Nov 2018 09:54:04 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] dt-bindings: spi: Move the bindings for the FSL
 QSPI driver
Thread-Topic: [PATCH v4 02/10] dt-bindings: spi: Move the bindings for the FSL
 QSPI driver
Thread-Index: AQHUdqhhgC+cnRaaekW0XhWhgbBcnqVFfpeAgAAEhoA=
Date:   Thu, 8 Nov 2018 08:54:04 +0000
Message-ID: <6d722567-a768-c842-6cc6-5517eed77689@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-3-git-send-email-frieder.schrempf@kontron.de>
 <20181108093751.39f43e8d@bbrezillon>
In-Reply-To: <20181108093751.39f43e8d@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4249873CEFEA542AFA6F74EF3D5F9C5@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 2A1ED2195B80.AB4F1
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        fabio.estevam@nxp.com, frieder.schrempf@exceet.de, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, miquel.raynal@bootlin.com,
        prabhakar.kushwaha@nxp.com, richard@nod.at, robh+dt@kernel.org,
        shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMTEuMTggMDk6MzcsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gV2VkLCAgNyBO
b3YgMjAxOCAxNTo0MzoxOSArMDEwMA0KPiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJl
bXBmQGtvbnRyb24uZGU+IHdyb3RlOg0KPiANCj4+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZy
aWVkZXIuc2NocmVtcGZAZXhjZWV0LmRlPg0KPj4NCj4+IE1vdmUgdGhlIGRvY3VtZW50YXRpb24g
b2YgdGhlIG9sZCBTUEkgTk9SIGRyaXZlciB0byB0aGUgcGxhY2Ugb2YgdGhlIG5ldw0KPj4gU1BJ
IG1lbW9yeSBpbnRlcmZhY2UgYmFzZWQgZHJpdmVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZy
aWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAZXhjZWV0LmRlPg0KPj4gLS0tDQo+PiAg
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9mc2wtcXVhZHNwaS50eHQgICAgIHwgNjUgLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1m
c2wtcXNwaS50eHQgICAgfCA2NSArKysrKysrKysrKysrKysrKysrKw0KPiANCj4gRGlkIHlvdSB1
c2UgLU0gd2hlbiB5b3UgZ2VuZXJhdGVkIHBhdGNoZXMgd2l0aCBnaXQgZm9ybWF0LXBhdGNoPw0K
PiBOb3JtYWxseSwgd2hlbiB5b3UgbW92ZSBhIGZpbGUgd2l0aG91dCBjaGFuZ2luZyBhbnl0aGlu
ZywgdGhlIGRpZmYgaXMNCj4gc21hbGxlciB0aGFuIHRoYXQuDQoNCk5vLCBJIGRpZG4ndCB1c2Ug
LU0uIEkgdGhvdWdodCB0aGUgZGVmYXVsdCBzZXR0aW5ncyB3b3VsZCBiZSBvaywgYnV0IC1NIA0K
bWFrZXMgdGhpcyBtdWNoIHNob3J0ZXIgb2YgY291cnNlLg0KDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNjUgaW5zZXJ0aW9ucygrKSwgNjUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvZnNsLXF1YWRzcGkudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9mc2wtcXVhZHNwaS50eHQNCj4+
IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggNDgzZTljZi4uMDAwMDAwMA0KPj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9mc2wtcXVhZHNwaS50
eHQNCj4+ICsrKyAvZGV2L251bGwNCj4+IEBAIC0xLDY1ICswLDAgQEANCj4+IC0qIEZyZWVzY2Fs
ZSBRdWFkIFNlcmlhbCBQZXJpcGhlcmFsIEludGVyZmFjZShRdWFkU1BJKQ0KPj4gLQ0KPj4gLVJl
cXVpcmVkIHByb3BlcnRpZXM6DQo+PiAtICAtIGNvbXBhdGlibGUgOiBTaG91bGQgYmUgImZzbCx2
ZjYxMC1xc3BpIiwgImZzbCxpbXg2c3gtcXNwaSIsDQo+PiAtCQkgImZzbCxpbXg3ZC1xc3BpIiwg
ImZzbCxpbXg2dWwtcXNwaSIsDQo+PiAtCQkgImZzbCxsczEwMjFhLXFzcGkiDQo+PiAtCQkgb3IN
Cj4+IC0JCSAiZnNsLGxzMjA4MGEtcXNwaSIgZm9sbG93ZWQgYnkgImZzbCxsczEwMjFhLXFzcGki
LA0KPj4gLQkJICJmc2wsbHMxMDQzYS1xc3BpIiBmb2xsb3dlZCBieSAiZnNsLGxzMTAyMWEtcXNw
aSINCj4+IC0gIC0gcmVnIDogdGhlIGZpcnN0IGNvbnRhaW5zIHRoZSByZWdpc3RlciBsb2NhdGlv
biBhbmQgbGVuZ3RoLA0KPj4gLSAgICAgICAgICB0aGUgc2Vjb25kIGNvbnRhaW5zIHRoZSBtZW1v
cnkgbWFwcGluZyBhZGRyZXNzIGFuZCBsZW5ndGgNCj4+IC0gIC0gcmVnLW5hbWVzOiBTaG91bGQg
Y29udGFpbiB0aGUgcmVnIG5hbWVzICJRdWFkU1BJIiBhbmQgIlF1YWRTUEktbWVtb3J5Ig0KPj4g
LSAgLSBpbnRlcnJ1cHRzIDogU2hvdWxkIGNvbnRhaW4gdGhlIGludGVycnVwdCBmb3IgdGhlIGRl
dmljZQ0KPj4gLSAgLSBjbG9ja3MgOiBUaGUgY2xvY2tzIG5lZWRlZCBieSB0aGUgUXVhZFNQSSBj
b250cm9sbGVyDQo+PiAtICAtIGNsb2NrLW5hbWVzIDogU2hvdWxkIGNvbnRhaW4gdGhlIG5hbWUg
b2YgdGhlIGNsb2NrczogInFzcGlfZW4iIGFuZCAicXNwaSIuDQo+PiAtDQo+PiAtT3B0aW9uYWwg
cHJvcGVydGllczoNCj4+IC0gIC0gZnNsLHFzcGktaGFzLXNlY29uZC1jaGlwOiBUaGUgY29udHJv
bGxlciBoYXMgdHdvIGJ1c2VzLCBidXMgQSBhbmQgYnVzIEIuDQo+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRWFjaCBidXMgY2FuIGJlIGNvbm5lY3RlZCB3aXRoIHR3byBOT1IgZmxh
c2hlcy4NCj4+IC0JCQkgICAgICBNb3N0IG9mIHRoZSB0aW1lLCBlYWNoIGJ1cyBvbmx5IGhhcyBv
bmUgTk9SIGZsYXNoDQo+PiAtCQkJICAgICAgY29ubmVjdGVkLCB0aGlzIGlzIHRoZSBkZWZhdWx0
IGNhc2UuDQo+PiAtCQkJICAgICAgQnV0IGlmIHRoZXJlIGFyZSB0d28gTk9SIGZsYXNoZXMgY29u
bmVjdGVkIHRvIHRoZQ0KPj4gLQkJCSAgICAgIGJ1cywgeW91IHNob3VsZCBlbmFibGUgdGhpcyBw
cm9wZXJ0eS4NCj4+IC0JCQkgICAgICAoUGxlYXNlIGNoZWNrIHRoZSBib2FyZCdzIHNjaGVtYXRp
Yy4pDQo+PiAtICAtIGJpZy1lbmRpYW4gOiBUaGF0IG1lYW5zIHRoZSBJUCByZWdpc3RlciBpcyBi
aWcgZW5kaWFuDQo+PiAtDQo+PiAtRXhhbXBsZToNCj4+IC0NCj4+IC1xc3BpMDogcXVhZHNwaUA0
MDA0NDAwMCB7DQo+PiAtCWNvbXBhdGlibGUgPSAiZnNsLHZmNjEwLXFzcGkiOw0KPj4gLQlyZWcg
PSA8MHg0MDA0NDAwMCAweDEwMDA+LCA8MHgyMDAwMDAwMCAweDEwMDAwMDAwPjsNCj4+IC0JcmVn
LW5hbWVzID0gIlF1YWRTUEkiLCAiUXVhZFNQSS1tZW1vcnkiOw0KPj4gLQlpbnRlcnJ1cHRzID0g
PDAgMjQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+PiAtCWNsb2NrcyA9IDwmY2xrcyBWRjYxMF9D
TEtfUVNQSTBfRU4+LA0KPj4gLQkJPCZjbGtzIFZGNjEwX0NMS19RU1BJMD47DQo+PiAtCWNsb2Nr
LW5hbWVzID0gInFzcGlfZW4iLCAicXNwaSI7DQo+PiAtDQo+PiAtCWZsYXNoMDogczI1ZmwxMjhz
QDAgew0KPj4gLQkJLi4uLg0KPj4gLQl9Ow0KPj4gLX07DQo+PiAtDQo+PiAtRXhhbXBsZSBzaG93
aW5nIHRoZSB1c2FnZSBvZiB0d28gU1BJIE5PUiBkZXZpY2VzOg0KPj4gLQ0KPj4gLSZxc3BpMiB7
DQo+PiAtCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiAtCXBpbmN0cmwtMCA9IDwmcGlu
Y3RybF9xc3BpMj47DQo+PiAtCXN0YXR1cyA9ICJva2F5IjsNCj4+IC0NCj4+IC0JZmxhc2gwOiBu
MjVxMjU2YUAwIHsNCj4+IC0JCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gLQkJI3NpemUtY2Vs
bHMgPSA8MT47DQo+PiAtCQljb21wYXRpYmxlID0gIm1pY3JvbixuMjVxMjU2YSIsICJqZWRlYyxz
cGktbm9yIjsNCj4+IC0JCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDI5MDAwMDAwPjsNCj4+IC0JCXJl
ZyA9IDwwPjsNCj4+IC0JfTsNCj4+IC0NCj4+IC0JZmxhc2gxOiBuMjVxMjU2YUAxIHsNCj4+IC0J
CSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gLQkJI3NpemUtY2VsbHMgPSA8MT47DQo+PiAtCQlj
b21wYXRpYmxlID0gIm1pY3JvbixuMjVxMjU2YSIsICJqZWRlYyxzcGktbm9yIjsNCj4+IC0JCXNw
aS1tYXgtZnJlcXVlbmN5ID0gPDI5MDAwMDAwPjsNCj4+IC0JCXJlZyA9IDwxPjsNCj4+IC0JfTsN
Cj4+IC19Ow0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvc3BpLWZzbC1xc3BpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvc3BpLWZzbC1xc3BpLnR4dA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4
IDAwMDAwMDAuLjQ4M2U5Y2YNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWZzbC1xc3BpLnR4dA0KPj4gQEAgLTAsMCAr
MSw2NSBAQA0KPj4gKyogRnJlZXNjYWxlIFF1YWQgU2VyaWFsIFBlcmlwaGVyYWwgSW50ZXJmYWNl
KFF1YWRTUEkpDQo+PiArDQo+PiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICsgIC0gY29tcGF0
aWJsZSA6IFNob3VsZCBiZSAiZnNsLHZmNjEwLXFzcGkiLCAiZnNsLGlteDZzeC1xc3BpIiwNCj4+
ICsJCSAiZnNsLGlteDdkLXFzcGkiLCAiZnNsLGlteDZ1bC1xc3BpIiwNCj4+ICsJCSAiZnNsLGxz
MTAyMWEtcXNwaSINCj4+ICsJCSBvcg0KPj4gKwkJICJmc2wsbHMyMDgwYS1xc3BpIiBmb2xsb3dl
ZCBieSAiZnNsLGxzMTAyMWEtcXNwaSIsDQo+PiArCQkgImZzbCxsczEwNDNhLXFzcGkiIGZvbGxv
d2VkIGJ5ICJmc2wsbHMxMDIxYS1xc3BpIg0KPj4gKyAgLSByZWcgOiB0aGUgZmlyc3QgY29udGFp
bnMgdGhlIHJlZ2lzdGVyIGxvY2F0aW9uIGFuZCBsZW5ndGgsDQo+PiArICAgICAgICAgIHRoZSBz
ZWNvbmQgY29udGFpbnMgdGhlIG1lbW9yeSBtYXBwaW5nIGFkZHJlc3MgYW5kIGxlbmd0aA0KPj4g
KyAgLSByZWctbmFtZXM6IFNob3VsZCBjb250YWluIHRoZSByZWcgbmFtZXMgIlF1YWRTUEkiIGFu
ZCAiUXVhZFNQSS1tZW1vcnkiDQo+PiArICAtIGludGVycnVwdHMgOiBTaG91bGQgY29udGFpbiB0
aGUgaW50ZXJydXB0IGZvciB0aGUgZGV2aWNlDQo+PiArICAtIGNsb2NrcyA6IFRoZSBjbG9ja3Mg
bmVlZGVkIGJ5IHRoZSBRdWFkU1BJIGNvbnRyb2xsZXINCj4+ICsgIC0gY2xvY2stbmFtZXMgOiBT
aG91bGQgY29udGFpbiB0aGUgbmFtZSBvZiB0aGUgY2xvY2tzOiAicXNwaV9lbiIgYW5kICJxc3Bp
Ii4NCj4+ICsNCj4+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4gKyAgLSBmc2wscXNwaS1oYXMt
c2Vjb25kLWNoaXA6IFRoZSBjb250cm9sbGVyIGhhcyB0d28gYnVzZXMsIGJ1cyBBIGFuZCBidXMg
Qi4NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFYWNoIGJ1cyBjYW4gYmUgY29u
bmVjdGVkIHdpdGggdHdvIE5PUiBmbGFzaGVzLg0KPj4gKwkJCSAgICAgIE1vc3Qgb2YgdGhlIHRp
bWUsIGVhY2ggYnVzIG9ubHkgaGFzIG9uZSBOT1IgZmxhc2gNCj4+ICsJCQkgICAgICBjb25uZWN0
ZWQsIHRoaXMgaXMgdGhlIGRlZmF1bHQgY2FzZS4NCj4+ICsJCQkgICAgICBCdXQgaWYgdGhlcmUg
YXJlIHR3byBOT1IgZmxhc2hlcyBjb25uZWN0ZWQgdG8gdGhlDQo+PiArCQkJICAgICAgYnVzLCB5
b3Ugc2hvdWxkIGVuYWJsZSB0aGlzIHByb3BlcnR5Lg0KPj4gKwkJCSAgICAgIChQbGVhc2UgY2hl
Y2sgdGhlIGJvYXJkJ3Mgc2NoZW1hdGljLikNCj4+ICsgIC0gYmlnLWVuZGlhbiA6IFRoYXQgbWVh
bnMgdGhlIElQIHJlZ2lzdGVyIGlzIGJpZyBlbmRpYW4NCj4+ICsNCj4+ICtFeGFtcGxlOg0KPj4g
Kw0KPj4gK3FzcGkwOiBxdWFkc3BpQDQwMDQ0MDAwIHsNCj4+ICsJY29tcGF0aWJsZSA9ICJmc2ws
dmY2MTAtcXNwaSI7DQo+PiArCXJlZyA9IDwweDQwMDQ0MDAwIDB4MTAwMD4sIDwweDIwMDAwMDAw
IDB4MTAwMDAwMDA+Ow0KPj4gKwlyZWctbmFtZXMgPSAiUXVhZFNQSSIsICJRdWFkU1BJLW1lbW9y
eSI7DQo+PiArCWludGVycnVwdHMgPSA8MCAyNCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+ICsJ
Y2xvY2tzID0gPCZjbGtzIFZGNjEwX0NMS19RU1BJMF9FTj4sDQo+PiArCQk8JmNsa3MgVkY2MTBf
Q0xLX1FTUEkwPjsNCj4+ICsJY2xvY2stbmFtZXMgPSAicXNwaV9lbiIsICJxc3BpIjsNCj4+ICsN
Cj4+ICsJZmxhc2gwOiBzMjVmbDEyOHNAMCB7DQo+PiArCQkuLi4uDQo+PiArCX07DQo+PiArfTsN
Cj4+ICsNCj4+ICtFeGFtcGxlIHNob3dpbmcgdGhlIHVzYWdlIG9mIHR3byBTUEkgTk9SIGRldmlj
ZXM6DQo+PiArDQo+PiArJnFzcGkyIHsNCj4+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
Cj4+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX3FzcGkyPjsNCj4+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPj4gKw0KPj4gKwlmbGFzaDA6IG4yNXEyNTZhQDAgew0KPj4gKwkJI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+PiArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4+ICsJCWNvbXBhdGlibGUgPSAibWlj
cm9uLG4yNXEyNTZhIiwgImplZGVjLHNwaS1ub3IiOw0KPj4gKwkJc3BpLW1heC1mcmVxdWVuY3kg
PSA8MjkwMDAwMDA+Ow0KPj4gKwkJcmVnID0gPDA+Ow0KPj4gKwl9Ow0KPj4gKw0KPj4gKwlmbGFz
aDE6IG4yNXEyNTZhQDEgew0KPj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArCQkjc2l6
ZS1jZWxscyA9IDwxPjsNCj4+ICsJCWNvbXBhdGlibGUgPSAibWljcm9uLG4yNXEyNTZhIiwgImpl
ZGVjLHNwaS1ub3IiOw0KPj4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MjkwMDAwMDA+Ow0KPj4g
KwkJcmVnID0gPDE+Ow0KPj4gKwl9Ow0KPj4gK307DQo+IA==
