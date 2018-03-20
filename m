Return-Path: <amelie.delaunay@st.com>
X-Google-Smtp-Source: AG47ELuxaEoGmECG2HdTUcL4nZaNdxgvxCnBtbjhFPUVAe821QrCJv7UB+RurV+Ks5g3GB0YP70v
ARC-Seal: i=1; a=rsa-sha256; t=1521537052; cv=none;
        d=google.com; s=arc-20160816;
        b=ULLNzrQLbBDQ+8a9QUYK2Mo6bW0LvT5GM536tGwrln7p3IqK+sD0I62/3bRNgBhE5O
         hqNe9zKYBagwq8IhEJogQqmwcxYPFkQP3zhi+uS05VRMCpwfVrGOc7fi8VD+yXi0ToYR
         JS0tCx6Bvl84thIKW0IcECZc3RPZWvmvXKeYsqM1z0KPIxLkKHVTAswSbDUY8aUjf0Mh
         nlmq/+1S45gJOITQ77xQXkk9rklBZ1SAsbpFOv8tRouEqyxAPz+erSO72RcLGeXRC6Gk
         cVCeSZqV1s0YNSv8diLBYboaAQtIUquMv9itueg3UGSBJc4Pu3H/o3y0ubVe3pWz+XLY
         KMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:user-agent
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=NtwjvY/33gfROngkXrclcqlDBIfigwxje79thbNWfmA=;
        b=lXF5w8Dt52CzuoWIL4QBA4zsQg7Eme2k/is+XWD806udtm4lBBEMocLhaIAyPPDc1C
         FcCmdHz7275lefOXEAujugxP6fF8XUu1C5MzmChBfxSMQAY/2BetnZFv8S5QDb1yuxnf
         q2HypEtw9bMigEZ2PnJ9xzoaFWYR7XS7o5UnVDQmHgn9KWNkhktzavhDmB7VHEynrTPN
         DViSJpXENAJkSiug0hgyZJgEYCRWl6POnbyOwQFtDwfU09IOSCqM+hjf/flbWNh/0I9p
         Hkx/KfgmOPpy3/t1XD/odEvCmhW/cDBRwsECkIb/JE6zoFvnCWqwJiah0ImN/XlOomg1
         1A2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland
	<mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern
	<stern@rowland.harvard.edu>, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi
	<felipe.balbi@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: ehci: add optional external vbus
 supply property
Thread-Topic: [PATCH v4 1/2] dt-bindings: usb: ehci: add optional external
 vbus supply property
Thread-Index: AQHTsULphq1wm4Q97EiORpkn5P5TKaPCab6AgADMZYCAAAjPAIAVpGQA
Date: Tue, 20 Mar 2018 09:10:38 +0000
Message-ID: <e3370b8d-2398-b4c0-c57c-978abd75c0f2@st.com>
References: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
 <1519897899-8577-2-git-send-email-amelie.delaunay@st.com>
 <20180306015743.uazy4e5quil2ijy2@rob-hp-laptop>
 <ae4c741e-d5aa-4a8c-4029-1dff6bef2cdd@arm.com>
 <CAL_Jsq+iPZN-RV61+AFcRg-eKORQDQ9-4s4-vaFOrCqWBK8PDg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+iPZN-RV61+AFcRg-eKORQDQ9-4s4-vaFOrCqWBK8PDg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <78844BF5406B594585633567020A4221@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_03:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593728540425341885?=
X-GMAIL-MSGID: =?utf-8?q?1595447235973512134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDAzLzA2LzIwMTggMDM6NDAgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUs
IE1hciA2LCAyMDE4IGF0IDg6MDkgQU0sIFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5j
b20+IHdyb3RlOg0KPj4gT24gMDYvMDMvMTggMDE6NTcsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+
DQo+Pj4gT24gVGh1LCBNYXIgMDEsIDIwMTggYXQgMTA6NTE6MzhBTSArMDEwMCwgQW1lbGllIERl
bGF1bmF5IHdyb3RlOg0KPj4+Pg0KPj4+PiBPbiBzb21lIGJvYXJkcywgZXNwZWNpYWxseSB3aGVu
IHZidXMgc3VwcGx5IHJlcXVpcmVzIGxhcmdlIGN1cnJlbnQsDQo+Pj4+IGFuZCB0aGUgY2hhcmdl
IHB1bXAgb24gdGhlIFBIWSBpc24ndCBlbm91Z2gsIGFuIGV4dGVybmFsIHZidXMgcG93ZXINCj4+
Pj4gc3dpdGNoDQo+Pj4+IHBlciBwb3J0IG1heSBiZSB1c2VkLg0KPj4+PiBBZGQgcG9ydE5fdmJ1
cy1zdXBwbHkgcHJvcGVydHkgdG8gdXNiLWVoY2kgYmluZGluZ3MuIEFzIHRoZSBudW1iZXIgb2YN
Cj4+Pj4gcG9ydHMNCj4+Pj4gZGVwZW5kcyBvbiB0aGUgZWhjaSBjb250cm9sbGVyLCBhbmQgdGhl
IHBvcnQgb24gd2hpY2ggYW4gZXh0ZXJuYWwgdmJ1cw0KPj4+PiBzdXBwbHkgZGVwZW5kcyBvbiB0
aGUgcGxhdGZvcm0sIDxwb3J0Tj4gaXMgdXNlZCB0byBtYWtlIGl0IGdlbmVyaWMuDQo+Pj4+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IEFtZWxpZSBEZWxhdW5heSA8YW1lbGllLmRlbGF1bmF5QHN0LmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvdXNiLWVoY2kudHh0IHwgMSArDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi91c2ItZWhjaS50eHQNCj4+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvdXNiL3VzYi1laGNpLnR4dA0KPj4+PiBpbmRleCAzZWZkZTEyLi5jZDU3NmRiIDEw
MDY0NA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3Vz
Yi1laGNpLnR4dA0KPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL3VzYi1laGNpLnR4dA0KPj4+PiBAQCAtMTksNiArMTksNyBAQCBPcHRpb25hbCBwcm9wZXJ0
aWVzOg0KPj4+PiAgICAgLSBwaHlzIDogcGhhbmRsZSArIHBoeSBzcGVjaWZpZXIgcGFpcg0KPj4+
PiAgICAgLSBwaHktbmFtZXMgOiAidXNiIg0KPj4+PiAgICAgLSByZXNldHMgOiBwaGFuZGxlICsg
cmVzZXQgc3BlY2lmaWVyIHBhaXINCj4+Pj4gKyAtIHBvcnROX3ZidXMtc3VwcGx5IDogcGhhbmRs
ZSBvZiByZWd1bGF0b3Igc3VwcGx5aW5nIHZidXMgZm9yIHBvcnQgTg0KPj4+DQo+Pj4NCj4+PiBK
dXN0IG1ha2UgdGhpcyBhbiBhcnJheSB3aXRoIHRoZSBpbmRleCBiZWluZyB0aGUgcG9ydCAoYW5k
IGRyb3ANCj4+PiAicG9ydE5fIikuDQo+Pg0KPj4NCj4+IERvZXMgdGhhdCBzdGlsbCB3b3JrIGlm
IHRoZXJlIGlzIGFuIGV4dGVybmFsIHN1cHBseSBmb3IgcG9ydCAxIGJ1dCBub25lIGZvcg0KPj4g
cG9ydCAwPyBJIGJlbGlldmUgdGhhdCB3YXMgYnJvdWdodCB1cCBhcyBhIHBvc3NpYmlsaXR5IGJl
Zm9yZS4NCj4gDQo+IFllcywgaWYgeW91IHVzZSAwIG9yIC0xIHRvIHNraXAgb3ZlciBhbiBpbmRl
eC4NCj4gDQo+IFJlYWxseSwgdGhpcyBzaG91bGQgZ28gaW4gdGhlIGNvbm5lY3RvciBub2RlIGlu
c3RlYWQgYmVjYXVzZSBWYnVzIGlzDQo+IHN1cHBsaWVkIHRvIHRoZSBjb25uZWN0b3IsIG5vdCB0
aGUgaG9zdCBjb250cm9sbGVyLiBUaGUgY29ubmVjdG9yDQo+IGJpbmRpbmcgaXMgb24gaXRzIHdh
eSBpbnRvIG1haW5saW5lLg0KPiANCj4gUm9iDQo+IA0KDQpOb3Qgc3VyZSB0byBjYXRjaCB3aGF0
IHlvdSBtZWFuIGJ5ICJtYWtlIHRoaXMgYW4gYXJyYXkiIGJlY2F1c2UgDQpyZWd1bGF0b3IgZnJh
bWV3b3JrIGltcG9zZXMgPG5hbWU+LXN1cHBseTogcGhhbmRsZSB0byB0aGUgcmVndWxhdG9yIG5v
ZGUuDQoNCkkgbWF5IGhhdmUgbWlzc2VkIHNvbWV0aGluZyBhcm91bmQgcmVndWxhdG9yIGNvbnN1
bWVycyBtYW5hZ2VtZW50ID8NCg0KRG8geW91IG1lYW50IHNvbWV0aGluZyBsaWtlDQp2YnVzLXN1
cHBseSA9IDwmcmVnX3BvcnQwICZyZWdfcG9ydDE+Ow0Kb3IgaW4gY2FzZSB0aGVyZSBpcyBhbiBl
eHRlcm5hbCBzdXBwbHkgZm9yIHBvcnQgMSBidXQgbm9uZSBmb3IgcG9ydCAwDQp2YnVzLXN1cHBs
eSA9IDwtMSAmcmVnX3BvcnQxPjsNCj8NCklmIHllcywgYSBuZXcgQVBJIGlzIG5lZWRlZCBpbiBy
ZWd1bGF0b3IgZnJhbWV3b3JrIHRvIGdldCBhbiBhcnJheSBvZiANCnJlZ3VsYXRvcnMgPw0KDQoN
ClJlZ2FyZHMsDQpBbWVsaWU=
