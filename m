Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELvIyUTzNJE0uWo69Dylj7Xk9yP+3ET+QF6FAdqkBnMOwFfdwqRRU55j7Z83oISc/x1+prvi
ARC-Seal: i=1; a=rsa-sha256; t=1521711892; cv=none;
        d=google.com; s=arc-20160816;
        b=z6aO+gDkuikowYLvFZRDUJFPaUe5GDoplsT6XJ5sbWt3CPRsb6Ii15V4VdnXft0dbM
         ikWG0j5TRqa5GXk1SaGI6COJaoj2gkHFidRbdKoJGArJbL2jPNVdFBwhN691nB1v6vgV
         O34r0P9vU6vKtK9wqmI7Razh465AtLwRQpPlSnhAroRByOmKVHlrTPMzQKUEmekz4IuT
         K2Px0DE2OQATh0KZXt1Ns97g2o3bWrheEWP4RDG5rwM7NbrGIvd6OYgzvG5VbUasfnJp
         e1sQ5tgIc8HxRPoAVJLeWg7mhPzL+uEQM29xVdwXF8W6/pv2zjjsht/uUjfzBVdGieRL
         JixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=fVL28JI8go8f3KRc4eGw6X1d16+oSWMlO0xAYzFTirY=;
        b=mGHefPNP4x8u5jr5T/ioCNXdF8xoysGuqT+1GpvHMi+O4nfnMwKOwYx8tgpClJj0//
         QkKSbfgKp5R3zCaEiwcq8AKW7xBi0OXp4P0G/uTtF/GFPpK/ZIefgO2h698T72qU5nPC
         z54rf3PIMxl82RSsa+Z21UgxofR22zZnGHmgsvo6nme3pFUcqJstrTPPdjj9PJrc1ahl
         H9FGtuVy3odeWO1b1HUMwuOR6FgAICRpqDjJfrZBd1dCy/mxm31WmD3NBrd6lOY24zbJ
         9ZsQxBsB+AcHiHiwvjrfjzeWN6PenSz4iP4NXaMSZFQ+o3Rx+mdxy6mgtGSu0kPIupYn
         6upw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.107 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.107 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRWlGSWpSXmKPExsUSt3Opsa5w9eY
  ogxOnzCyaF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjN2d31gL3ihXX
  Lh9gLmBcYNyFyMXh5DAUkaJvWuuM3cxcnKwCVhITD7xgA0kISKwjEni3rtnYA6zwGtGie3tvx
  lBqoQFvCVe33oCZHMAVflIvPhjARIWEbCSeHn1LRuIzSKgKrHv3QtWEJtXIEBix8O5TBDbbjF
  K9BzoZwFJcAo4SDxYcgRsJqOArMSXxtVgVzALiEvcejKfCcSWEBCQWLLnPDOELSrx8vE/Vghb
  XmL7t9/sELa9xOt771ggbH2JR48fMULYhhKrph2AiptL9G/ewQxyM7OApsT6XfoQqxQlpnQ/Z
  Ie4U1Di5MwnLBMYxWchuWIWQscsJB2zkHQsYGRZxahRnFpUllqka2Sil1SUmZ5RkpuYmaNraG
  Cml5taXJyYnpqTmFSsl5yfu4kRGOUMQLCDcd/HyEOMkhxMSqK8n15sihLiS8pPqcxILM6ILyr
  NSS0+xCjDwaEkwfu6cnOUkGBRanpqRVpmDjDdwKQlOHiURHi1qoDSvMUFibnFmekQqVOMxhw3
  XrxuY+bYsuxNG7MQS15+XqqUOO8HkEkCIKUZpXlwg2Bp8BKjrJQwLyPQaUI8BalFuZklqPKvG
  MU5GJWEeVlAFvJk5pXA7XsFdAoT0CnZMzeAnFKSiJCSamAMnJb4MvrPAa9VSufcAn6eOc43U+
  Wy4TceH8721WJ/tmqumjV9zc41i29EW1q+lcq5E7hQbgPHQv4HkvcDSss/2C+p1WzdtvuFxtX
  tVj+cXSeXJR6bLxR+qd9H8UzHKmURyX97UiPnJHDnqEYcuSI3J+O4wcH5Dy1ucn/f6hrKIB6W
  rJgSy7NEiaU4I9FQi7moOBEA4s1v7X4DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-6.tower-193.messagelabs.com!1521711891!104815657!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "Hans de
 Goede" <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Support
 Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v5 1/5] typec: tcpm: Add core support for sink side PPS
Thread-Topic: [PATCH v5 1/5] typec: tcpm: Add core support for sink side PPS
Thread-Index: AQHTwFhylI6b9sIdmU+M4F+svuOjhaPbpKcAgABfZTA=
Date: Thu, 22 Mar 2018 09:44:49 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E2864@SW-EX-MBX01.diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <dc50ec940a1e18059a87bca3c96e2dd539f9efa7.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <a6d1b2f9-e750-5914-4807-79fc89d26bb5@roeck-us.net>
In-Reply-To: <a6d1b2f9-e750-5914-4807-79fc89d26bb5@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 22/03/2018 04:27:00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595467549835107459?=
X-GMAIL-MSGID: =?utf-8?q?1595630569614318558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMjIgTWFyY2ggMjAxOCAwNDowMywgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+ICAgc3Rh
dGljIGVudW0gcGRvX2VyciB0Y3BtX2NhcHNfZXJyKHN0cnVjdCB0Y3BtX3BvcnQgKnBvcnQsIGNv
bnN0IHUzMiAqcGRvLA0KPiA+IEBAIC0xMzA4LDYgKzEzNDcsMjYgQEAgc3RhdGljIGVudW0gcGRv
X2VyciB0Y3BtX2NhcHNfZXJyKHN0cnVjdCB0Y3BtX3BvcnQNCj4gKnBvcnQsIGNvbnN0IHUzMiAq
cGRvLA0KPiA+ICAgCQkJCQkgIHBkb19taW5fdm9sdGFnZShwZG9baSAtIDFdKSkpDQo+ID4gICAJ
CQkJCXJldHVybiBQRE9fRVJSX0RVUEVfUERPOw0KPiA+ICAgCQkJCWJyZWFrOw0KPiA+ICsJCQkv
Kg0KPiA+ICsJCQkgKiBUaGUgUHJvZ3JhbW1hYmxlIFBvd2VyIFN1cHBseSBBUERPcywgaWYgcHJl
c2VudCwNCj4gPiArCQkJICogc2hhbGwgYmUgc2VudCBpbiBNYXhpbXVtIFZvbHRhZ2Ugb3JkZXI7
DQo+ID4gKwkJCSAqIGxvd2VzdCB0byBoaWdoZXN0Lg0KPiA+ICsJCQkgKi8NCj4gPiArCQkJY2Fz
ZSBQRE9fVFlQRV9BUERPOg0KPiA+ICsJCQkJaWYgKHBkb19hcGRvX3R5cGUocGRvW2ldKSAhPSBB
UERPX1RZUEVfUFBTKQ0KPiA+ICsJCQkJCWJyZWFrOw0KPiA+ICsNCj4gPiArCQkJCWlmIChwZG9f
cHBzX2FwZG9fbWF4X2N1cnJlbnQocGRvW2ldKSA8DQo+ID4gKwkJCQkgICAgcGRvX3Bwc19hcGRv
X21heF9jdXJyZW50KHBkb1tpIC0gMV0pKQ0KPiA+ICsJCQkJCXJldHVybg0KPiBQRE9fRVJSX1BQ
U19BUERPX05PVF9TT1JURUQ7DQo+ID4gKwkJCQllbHNlIGlmICgocGRvX3Bwc19hcGRvX21pbl92
b2x0YWdlKHBkb1tpXSkgPT0NCj4gPiArCQkJCQkgIHBkb19wcHNfYXBkb19taW5fdm9sdGFnZShw
ZG9baSAtIDFdKSkNCj4gJiYNCj4gPiArCQkJCQkgKHBkb19wcHNfYXBkb19tYXhfdm9sdGFnZShw
ZG9baV0pID09DQo+ID4gKwkJCQkJICBwZG9fcHBzX2FwZG9fbWF4X3ZvbHRhZ2UocGRvW2kgLSAx
XSkpDQo+ICYmDQo+ID4gKwkJCQkJIChwZG9fcHBzX2FwZG9fbWF4X2N1cnJlbnQocGRvW2ldKSA9
PQ0KPiA+ICsJCQkJCSAgcGRvX3Bwc19hcGRvX21heF9jdXJyZW50KHBkb1tpIC0gMV0pKSkNCj4N
Cj4gVW5uZWNlc3NhcnkgKCApDQoNCkkgaGF2ZSB0byBzYXkgSSB0aGluayBpdCdzIG5lYXRlci9j
bGVhcmVyIHdpdGggdGhhbiB3aXRob3V0IGJ1dCBpZiB0aGF0J3MNCnNvbWV0aGluZyB5b3UgcmVh
bGx5IGRvbid0IGxpa2UgdGhlbiBJJ2xsIHJlbW92ZSB0aGVtLg0KDQoNCj4gPiArc3RhdGljIGlu
dCB0Y3BtX3Bwc19zZXRfb3BfY3VycihzdHJ1Y3QgdGNwbV9wb3J0ICpwb3J0LCB1MTYgb3BfY3Vy
cikNCj4gPiArew0KPiA+ICsJdW5zaWduZWQgaW50IHRhcmdldF9tdzsNCj4gPiArCWludCByZXQg
PSAwOw0KPiA+ICsNCj4NCj4gVW5uZWNlc3NhcnkgaW5pdGlhbGl6YXRpb24uDQoNCk9rLCB3aWxs
IHJlbW92ZS4NCg0KDQo+ID4gK3N0YXRpYyBpbnQgdGNwbV9wcHNfc2V0X291dF92b2x0KHN0cnVj
dCB0Y3BtX3BvcnQgKnBvcnQsIHUxNiBvdXRfdm9sdCkNCj4gPiArew0KPiA+ICsJdW5zaWduZWQg
aW50IHRhcmdldF9tdzsNCj4gPiArCWludCByZXQgPSAwOw0KPiA+ICsNCj4gVW5uZWNlc3Nhcnkg
aW5pdGlhbGl6YXRpb24uDQoNCkRpdHRvDQoNCj4gPiArCW11dGV4X2xvY2soJnBvcnQtPnN3YXBf
bG9jayk7DQo+ID4gKwltdXRleF9sb2NrKCZwb3J0LT5sb2NrKTsNCj4gPiArDQo+ID4gKwlpZiAo
IXBvcnQtPnBwc19kYXRhLmFjdGl2ZSkgew0KPiA+ICsJCXJldCA9IC1FT1BOT1RTVVBQOw0KPiA+
ICsJCWdvdG8gcG9ydF91bmxvY2s7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHBvcnQtPnN0
YXRlICE9IFNOS19SRUFEWSkgew0KPiA+ICsJCXJldCA9IC1FQUdBSU47DQo+ID4gKwkJZ290byBw
b3J0X3VubG9jazsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoKG91dF92b2x0IDwgcG9ydC0+
cHBzX2RhdGEubWluX3ZvbHQpIHx8DQo+ID4gKwkgICAgKG91dF92b2x0ID4gcG9ydC0+cHBzX2Rh
dGEubWF4X3ZvbHQpKSB7DQo+DQo+IFVubmVjZXNzYXJ5ICggKQ0KDQpPay4NCg0KPiA+ICsJCXJl
dCA9IC1FSU5WQUw7DQo+ID4gKwkJZ290byBwb3J0X3VubG9jazsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwl0YXJnZXRfbXcgPSAocG9ydC0+cHBzX2RhdGEub3BfY3VyciAqIG91dF92b2x0KSAvIDEw
MDA7DQo+ID4gKwlpZiAodGFyZ2V0X213IDwgcG9ydC0+b3BlcmF0aW5nX3Nua19tdykgew0KPiA+
ICsJCXJldCA9IC1FSU5WQUw7DQo+ID4gKwkJZ290byBwb3J0X3VubG9jazsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwlyZWluaXRfY29tcGxldGlvbigmcG9ydC0+cHBzX2NvbXBsZXRlKTsNCj4gPiAr
CXBvcnQtPnBwc19kYXRhLm91dF92b2x0ID0gb3V0X3ZvbHQ7DQo+ID4gKwlwb3J0LT5wcHNfc3Rh
dHVzID0gMDsNCj4gPiArCXBvcnQtPnBwc19wZW5kaW5nID0gdHJ1ZTsNCj4gPiArCXRjcG1fc2V0
X3N0YXRlKHBvcnQsIFNOS19ORUdPVElBVEVfUFBTX0NBUEFCSUxJVElFUywgMCk7DQo+ID4gKwlt
dXRleF91bmxvY2soJnBvcnQtPmxvY2spOw0KPiA+ICsNCj4gPiArCWlmICghd2FpdF9mb3JfY29t
cGxldGlvbl90aW1lb3V0KCZwb3J0LT5wcHNfY29tcGxldGUsDQo+ID4gKwkJCQltc2Vjc190b19q
aWZmaWVzKFBEX1NUQVRFX01BQ0hJTkVfVElNRU9VVCkpKQ0KPiA+ICsJCXJldCA9IC1FVElNRURP
VVQ7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmV0ID0gcG9ydC0+cHBzX3N0YXR1czsNCj4gPiArDQo+
ID4gKwlnb3RvIHN3YXBfdW5sb2NrOw0KPiA+ICsNCj4gPiArcG9ydF91bmxvY2s6DQo+ID4gKwlt
dXRleF91bmxvY2soJnBvcnQtPmxvY2spOw0KPiA+ICtzd2FwX3VubG9jazoNCj4gPiArCW11dGV4
X3VubG9jaygmcG9ydC0+c3dhcF9sb2NrKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHRjcG1fcHBzX2FjdGl2YXRlKHN0cnVjdCB0Y3Bt
X3BvcnQgKnBvcnQsIGJvb2wgYWN0aXZhdGUpDQo+ID4gK3sNCj4gPiArCWludCByZXQgPSAwOw0K
PiA+ICsNCj4gPiArCW11dGV4X2xvY2soJnBvcnQtPnN3YXBfbG9jayk7DQo+ID4gKwltdXRleF9s
b2NrKCZwb3J0LT5sb2NrKTsNCj4gPiArDQo+ID4gKwlpZiAoIXBvcnQtPnBwc19kYXRhLnN1cHBv
cnRlZCkgew0KPiA+ICsJCXJldCA9IC1FT1BOT1RTVVBQOw0KPiA+ICsJCWdvdG8gcG9ydF91bmxv
Y2s7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogVHJ5aW5nIHRvIGRlYWN0aXZhdGUgUFBTIHdo
ZW4gYWxyZWFkeSBkZWFjdGl2YXRlZCBzbyBqdXN0IGJhaWwgKi8NCj4gPiArCWlmICgoIXBvcnQt
PnBwc19kYXRhLmFjdGl2ZSkgJiYgKCFhY3RpdmF0ZSkpDQo+DQo+IFVubmVjZXNzYXJ5ICggKQ0K
DQpBY3R1YWxseSBhZ3JlZSBvbiB0aGlzIG9uZSA6KQ0K
