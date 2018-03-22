Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELt7yogakO/LOBeQHYlfEr+ueRSri6E4oALn3aVatyKJUfAyZJiWPGuuUgBd5T2Qo6SJs52j
ARC-Seal: i=1; a=rsa-sha256; t=1521711466; cv=none;
        d=google.com; s=arc-20160816;
        b=xFEs0xmLKZxalr9gAB4tNcjHi8fJRl1CQ2Ffn55TznrYVF/2MbQQfkHsNycUEOU9ZB
         ML8PC0y3hXEgztQqY2DDZRDHugW3AFnzk6UBXX9ZmdAXQayQXJu5whqI/BmFXFQ4XRDH
         8mFtG8Km7PoPQ+m1aAi/YL65WptpJkJawtyB4YZ0Y3YqjF8VnPoXOc6tSgFhdHFMkOMQ
         61niBNhunKyI0kxrR3OgdDr8+JZQkya9ZAjkNo9tmCm2k36GaTVaPgKjvq20PsCWDOVb
         OaFpTLRvHsvvplftJfrR5MAqCdlLZ5T+CiXIfbGMrd+pT7qOtsvYjh/TChEysVGX/jqM
         8SiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=sduVi8p6TiumXtnTipm25OXX25I/nnlz2JCXFjg4kD8=;
        b=a+oOW7N69WJM9Iqn7erno/3rWAx+qS0seHq9r3uncBZ2k4R5SO1RcHEzMWCkCOtnx0
         CQHok4rVgRU4W7sPmOsoChnOZSgKHBsKawITHE5+1ueQv06Uxgn9QUSysZJRG74JkAeT
         32ue/vcaFlTIIfeZFTFMsVsMd9NbUmz+3zz2LSfWCrtv3q55xbkutCKkWa+00IhWDOdX
         aEQCEDoo1SHAyqfK/J1Ur25/h3ZK8qrWrT/wHgKPJ6ajZzheiOOJFfDDF3Fw04F0TJfj
         T67gF12UDbewjUuhn5Bg2AXMUrN7wVEIBT8FZLwEgklOyI+sgejTno5oxrOdD9YeqbvW
         pcuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.109 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.109 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRWlGSWpSXmKPExsUSt3OpsW5m5eY
  og/frrSyaF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjNkPG5gLDvJV3
  Hv8kbWBcQVfFyMXh5DAUkaJuS3TmbsYOTnYBCwkJp94wAaSEBFYxiRx790zMIdZ4DWjxPb234
  wgVcICwRKTTn4Bs0UEQiSO3HvICmFbSRzcsZgFxGYRUJXYuasRqIaDg1cgQOLTjwKIbbcYJc7
  +uARWzyngIHFtwi0wm1FAVuJL42qwK5gFxCVuPZnPBGJLCAhILNlznhnCFpV4+fgfK4QtL7H9
  2292CNte4vW9dywguyQE9CX6GoshwoYSq6YdYIGwzSX6N+9gBilhFtCUWL9LH2KTosSU7odgU
  3gFBCVOznzCMoFRfBaSI2YhdMxC0jELSccCRpZVjBrFqUVlqUW6xoZ6SUWZ6RkluYmZObqGBm
  Z6uanFxYnpqTmJScV6yfm5mxiBMc4ABDsYmxYFHmKU5GBSEuX99GJTlBBfUn5KZUZicUZ8UWl
  OavEhRhkODiUJ3vqKzVFCgkWp6akVaZk5wGQDk5bg4FES4fUGSfMWFyTmFmemQ6ROMVpy3Hjx
  uo2ZY8uyN0CyYdOqbmYhlrz8vFQpcd4wkAYBkIaM0jy4cbCEeIlRVkqYlxHoQCGegtSi3MwSV
  PlXjOIcjErCvLNBpvBk5pXAbX0FdBAT0EHZMzeAHFSSiJCSamD02/IlxnL1vO8byk9Whi6QeX
  v705uiELHaM1NWPTsuujXXSJfBNav/uo5HRpZKhuX73quCJrtsHnybmOf7IHyXiL3NrtqL73q
  e/GA8rcs4/3vsmrINofI9kkqSvukLk8+s1EracuPjiXnr71vceh57QDFZPtP14w+T7at/XD6u
  bLVOOb6C6T+HEktxRqKhFnNRcSIAWelapIMDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-193.messagelabs.com!1521711465!104509777!1
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
Subject: RE: [PATCH v5 5/5] typec: tcpm: Add support for sink PPS related
 messages
Thread-Topic: [PATCH v5 5/5] typec: tcpm: Add support for sink PPS related
 messages
Thread-Index: AQHTwFh1BQwyqpUqhkORImEqlXX9kKPboc6AgABgNoA=
Date: Thu, 22 Mar 2018 09:37:44 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E284C@SW-EX-MBX01.diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <cb45050153fa8304584441a7a7401a138514ddc1.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <58c2a5eb-4811-eb14-d977-674b06524d71@roeck-us.net>
In-Reply-To: <58c2a5eb-4811-eb14-d977-674b06524d71@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 22/03/2018 04:27:00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595467557273032285?=
X-GMAIL-MSGID: =?utf-8?q?1595630123114144591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMjIgTWFyY2ggMjAxOCAwMzo1MywgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+ICtzdGF0
aWMgdm9pZCB0Y3BtX3BkX2V4dF9tc2dfcmVxdWVzdChzdHJ1Y3QgdGNwbV9wb3J0ICpwb3J0LA0K
PiA+ICsJCQkJICAgIGNvbnN0IHN0cnVjdCBwZF9tZXNzYWdlICptc2cpDQo+ID4gK3sNCj4gPiAr
CWVudW0gcGRfZXh0X21zZ190eXBlIHR5cGUgPSBwZF9oZWFkZXJfdHlwZV9sZShtc2ctPmhlYWRl
cik7DQo+ID4gKwl1bnNpZ25lZCBpbnQgZGF0YV9zaXplID0gcGRfZXh0X2hlYWRlcl9kYXRhX3Np
emVfbGUobXNnLQ0KPiA+ZXh0X21zZy5oZWFkZXIpOw0KPiA+ICsJdTggKmRhdGE7DQo+ID4gKw0K
PiA+ICsJaWYgKCEobXNnLT5leHRfbXNnLmhlYWRlciAmJiBQRF9FWFRfSERSX0NIVU5LRUQpKSB7
DQo+ID4gKwkJdGNwbV9sb2cocG9ydCwgIlVuY2h1bmtlZCBleHRlbmRlZCBtZXNzYWdlcyB1bnN1
cHBvcnRlZCIpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoZGF0
YV9zaXplID4gKFBEX0VYVF9NQVhfQ0hVTktfREFUQSkpIHsNCj4gPiArCQl0Y3BtX2xvZyhwb3J0
LCAiQ2h1bmsgaGFuZGxpbmcgbm90IHlldCBzdXBwb3J0ZWQiKTsNCj4gPiArCQlyZXR1cm47DQo+
ID4gKwl9DQo+ID4gKw0KPiA+ICsJZGF0YSA9IGt6YWxsb2MoZGF0YV9zaXplLCBHRlBfS0VSTkVM
KTsNCj4gPiArCWlmICghZGF0YSkgew0KPiA+ICsJCXRjcG1fbG9nKHBvcnQsICJGYWlsZWQgdG8g
YWxsb2NhdGUgbWVtb3J5IGZvciBleHQgbXNnIGRhdGEiKTsNCj4gPiArCQlyZXR1cm47DQo+ID4g
Kwl9DQo+ID4gKwltZW1jcHkoZGF0YSwgbXNnLT5leHRfbXNnLmRhdGEsIGRhdGFfc2l6ZSk7DQo+
ID4gKw0KPiA+ICsJc3dpdGNoICh0eXBlKSB7DQo+ID4gKwljYXNlIFBEX0VYVF9TVEFUVVM6DQo+
ID4gKwkJLyoNCj4gPiArCQkgKiBJZiBQUFMgcmVsYXRlZCBldmVudHMgcmFpc2VkIHRoZW4gZ2V0
IFBQUyBzdGF0dXMgdG8gY2xlYXINCj4gPiArCQkgKiAoc2VlIFVTQiBQRCAzLjAgU3BlYywgNi41
LjIuNCkNCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoZGF0YVtVU0JfUERfRVhUX1NEQl9FVkVOVF9G
TEFHU10gJg0KPiBVU0JfUERfRVhUX1NEQl9QUFNfRVZFTlRTKQ0KPg0KPiBUaGlzIHNlZW1zIHRv
IGJlIHRoZSBvbmx5IHVzZSBvZiAnZGF0YScuIENhbiB5b3UgZXhwbGFpbiB3aHkgaXQgaXMgbmVl
ZGVkDQo+IGluIHRoZSBmaXJzdCBwbGFjZSA/IEFtIEkgbWlzc2luZyBzb21ldGhpbmcgPw0KDQpB
Y3R1YWxseSBpdCdzIGEgZmFpciBwb2ludC4gUmlnaHQgbm93IGl0J3Mgbm90IG5lZWRlZCBzbyB3
aWxsIHJlbW92ZSBpdCBhbmQNCmRpcmVjdGx5IHJlZmVyZW5jZSB0aGUgZXh0X21zZy5kYXRhIGFy
cmF5Lg0K
