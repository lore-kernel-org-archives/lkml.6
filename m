Return-Path: <prvs=564c18bbf=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AH8x226dcJHObFwIA61mEbDtOrEATpMbZdPGebjrr8eZiA/EWylFn9qI9LpEEeDekPEXnixeIapN
ARC-Seal: i=1; a=rsa-sha256; t=1517531154; cv=none;
        d=google.com; s=arc-20160816;
        b=zQuFsODFU3jT92K4oFN0r4LphSoVOoxx0v+2PKsREVpXzCzUjlI3EpJqY7GEXEQbra
         DfBMS5dRyvXdlLqidZHAd3GERtVbDkzHLgUmeVfNHlimBaCpRhf6YO6Itf6QbtPy7yAR
         sIP4zCeLvgalEbwdhHjtYgNXE7AabnBjEeta32JMr0f0XfNiDvZcX5xBPdt2eH20LrY1
         AU9CQm8yXcqWXb1203a9l5h0Djbo2zJg+MydXKnzoWIqanqKcSZux+ogFc8EKbgdw9ut
         YVvpWnuiWlSv1KiXWkBi3cB0MQvfzdgfvkFcNkWqf5+UshcgfQi1WPLeD4wh7j0nJVRK
         rD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=048vUofLEnSjKDOpVkaWI0T5gSWXgj5zNDD64bTJBv0=;
        b=KKptDdwBcf4e6zOfm9oUSdgK78fP9jzek3fdO4dESBxqrj6qFpUaGs3fx/aQOQs0ma
         9mlHhhxQyqlpRoEev3IbPGxkFHDz4MR0clRDCq5DyIM62rQteu1Z2774fzbha3psdoaY
         vRK/hGmq4/VCxWxPg8xUMSSPCB8iHH+tkBvzb91Jclgr+zuGLidoaHO2hKDjVQ9Srnve
         N0VKvJsjmmzhm0W/IVadILpw0wiSyOCGlSs4sxnqKz+2B2U3K9fzJgPLFeHHde9VjB0C
         gbYRHeLkf8quU6HOuE0hJxFeVM9CKij5+bqDVWQZ6RJEjggRQlc9Bj+heKDWkKHiJlgZ
         4YiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=XigVPjcd;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=DedKSk+p;
       spf=pass (google.com: domain of prvs=564c18bbf=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=564c18bbf=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=XigVPjcd;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=DedKSk+p;
       spf=pass (google.com: domain of prvs=564c18bbf=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=564c18bbf=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,444,1511798400";
   d="scan'208";a="70956543"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: Re: [PATCH v4 02/10] ufs: sysfs: device descriptor
Thread-Topic: [PATCH v4 02/10] ufs: sysfs: device descriptor
Thread-Index: AQHTm3hGoRqnZ3BUQkShg0Hz0gO6oqOQQcqA
Date: Fri, 2 Feb 2018 00:25:46 +0000
Message-ID: <1517531145.2746.26.camel@wdc.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
	 <1517501746-19075-3-git-send-email-stanislav.nijnikov@wdc.com>
In-Reply-To: <1517501746-19075-3-git-send-email-stanislav.nijnikov@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1257;7:tomviwtyRDhm1jbGyheIR8OOGwjJ8bBucE4hhjjZIypNB/5yirRR9mftorn5hWzcqdTsAsttNSkuQYmib55M3PyWc/AR3ccWEK7ctoPNbh6OS1cw6HdKHHRozPcWBpWWSFZLgPlzOyXppVQoGNlOqcvFMLu44w4bZuED+ypxjgW4nTOxjOSW0M26kUfE9WhrdiVLDZKtFh+WiiG22JOetkoyWWUY8UIpq6lSmKApdLzmV3b5n3QV/jtWEIpKSvQ0;20:cTWWHKzHTsma2PTfhNGh48D5Bb0o1cEM6LVzMpUbTO71OFGRHwlia9rD0ZiRHu30aghr98iKpo4is2385ClblgQs9Mq0ryCF2NunkGNoeh24kMqmt9XFCoZqY526I++qAtaDZEZt4m5B1dAmT+F3HgPdqEyns+pzEYMlsBFfHoU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 463803df-52ad-4710-090f-08d569d3813b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1257;
x-ms-traffictypediagnostic: CY1PR0401MB1257:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB125701BDE97056E83E6A34B398F90@CY1PR0401MB1257.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR0401MB1257;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1257;
x-forefront-prvs: 05715BE7FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39850400004)(396003)(366004)(376002)(346002)(189003)(199004)(377424004)(53936002)(6512007)(3280700002)(99286004)(478600001)(86362001)(68736007)(8936002)(81166006)(8676002)(81156014)(561944003)(4326008)(2201001)(3660700001)(76176011)(6636002)(102836004)(6506007)(6486002)(2900100001)(229853002)(14454004)(66066001)(186003)(6436002)(316002)(7520500002)(110136005)(2501003)(72206003)(77096007)(305945005)(5660300001)(7736002)(3846002)(2950100002)(6116002)(2906002)(6246003)(105586002)(26005)(106356001)(25786009)(97736004)(103116003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1257;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: gFeVwTlYECFEb0g50sutoCTl9HT6PDSM4zUERYmBGkJ9j072MyOR0xWDJUWeiKiiQWznQkueeyRGM7mqg8NMnA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <67E4BC070E473D478B86D8507DD95102@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463803df-52ad-4710-090f-08d569d3813b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2018 00:25:46.8376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1257
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215920431432185?=
X-GMAIL-MSGID: =?utf-8?q?1591246748028972034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTAxIGF0IDE4OjE1ICswMjAwLCBTdGFuaXNsYXYgTmlqbmlrb3Ygd3Jv
dGU6DQo+ICtlbnVtIHVmc19kZXNjX3BhcmFtX3NpemUgew0KPiArCVVGU19QQVJBTV9CWVRFX1NJ
WkUJPSAxLA0KPiArCVVGU19QQVJBTV9XT1JEX1NJWkUJPSAyLA0KPiArCVVGU19QQVJBTV9EV09S
RF9TSVpFCT0gNCwNCj4gKwlVRlNfUEFSQU1fUVdPUkRfU0laRQk9IDgsDQo+ICt9Ow0KDQpQbGVh
c2UgZG8gbm90IGNvcHkgYmFkIG5hbWluZyBjaG9pY2VzIGZyb20gdGhlIFdpbmRvd3Mga2VybmVs
IGludG8gdGhlIExpbnV4DQprZXJuZWwuIFVzaW5nIG5hbWVzIGxpa2UgV09SRCAvIERXT1JEIC8g
UVdPUkQgaXMgbXVjaCBsZXNzIHJlYWRhYmxlIHRoYW4gdXNpbmcNCnRoZSBudW1lcmljIGNvbnN0
YW50cyAyLCA0LCA4LiBIZW5jZSBteSBwcm9wb3NhbCB0byBsZWF2ZSBvdXQgdGhlIGFib3ZlIGVu
dW0NCmNvbXBsZXRlbHkuDQoNClRoYW5rcywNCg0KQmFydC4=
