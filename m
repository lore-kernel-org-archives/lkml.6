Return-Path: <laurentiu.tudor@nxp.com>
X-Google-Smtp-Source: AG47ELtkg+4Yn7orbLwG/BC5TPNFcIyMsZXMsO9iucnDwzh2fEJmnXPt+xhIc8/tg8oDAo2cWhOr
ARC-Seal: i=1; a=rsa-sha256; t=1521197977; cv=none;
        d=google.com; s=arc-20160816;
        b=BqFYz4VztDR6E21DTTl7Cq4lI38JKpv0wpZXHIrhT0g0BWAz47Pt3Xr4oUl/ld0gbo
         eG0h1CArk4tCZoHoh4UgkVISY+lCZoJdH7xxCKjKeUQDthuMtwtdMcM2bH5wCY54KExF
         XkCe4DTy1UkOmZ8OoHSXGsxXwIfI6rJkeFBMi0w2Q+XS3nsmb0mcY37ENtRxOyV1wV0L
         Z3ohixUA+qYAupsdXVGeCPQIVCFq2QC/xj94LK9SiIpJVZ4MGN9oCwKhFFKHBXlkv/X5
         51jwh25on5OW6vnB5Qv1WxDw/6TN7tKUFixF5j7GF9uh4HtwuI/z1JEYqHJ8+xLEoJf1
         oHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xqUVIs+8PCDHta9lEja/doZ9WX9ISbmz/3xgV9pFEQ8=;
        b=gq2aV+BZUyprrigHuyhLb/fRH0rCm45NboHB9JYO1IKpdbY2m+dHk7WQNJimmm2VgU
         y0iG6kbISW8Hs5gkjMx+lY81uR8ByPEfMnUV5lxjAiks8vkFxUvBHJuzh2G099zFsJiG
         8uA7Ec8boOsE3fSo49rTeVDUIaDMI3BI18NOZvzaxiVLzYTQdvjVYxrT568MKEGSqpB8
         sXR55ZBInplwe27Prraw6Uvk+T6KZzchnxdeBBnxjafYcZzd2eRjANFho0+WJGxUTsTh
         OjYnO8mHsydTvFFYqd6TwrmUIYjwehry9TgahxAe5uJrVkBoNorN7MZAi/pZ71alTxFI
         2jUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=FCMolQJq;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 104.47.0.61 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=FCMolQJq;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 104.47.0.61 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Andrew Lunn <andrew@lunn.ch>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>
CC: Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Alexandru Marginean
	<alexandru.marginean@nxp.com>, Alexander Graf <agraf@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Thread-Topic: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Thread-Index: AQHTu6z8lnlnwqKYl0uNTzrTWSDMQaPQZXiAgAC7yACAAZMegA==
Date: Fri, 16 Mar 2018 10:59:32 +0000
Message-ID: <5AABA393.5010102@nxp.com>
References: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
 <20180314234437.GD16379@lunn.ch> <20180315105642.szn2zhrsgwsv35yf@mwanda>
In-Reply-To: <20180315105642.szn2zhrsgwsv35yf@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB2461;7:k0CSFdKC2TUbKMBu3SukqqZLPuaZkVCMxI/qumoz9BIcOL/Cld19Yk+4gleTnLsmnHKHTVmJSvKejy5RlvxJAE23Q2e/glHn/MIeKinomxa1pV6podjUbIGryHoZoz9UmUCk+dDOmWTw2VgvIXaASgbXKJtx7hyAhj4ip+1141Wvu1IZ1ylKGqD8tV7h4gjtHfeTZV9SWBNkU8emam7+JzufkCOtpK3Yb4m9k6S5njaAI/2hdWgzIPDzFIzLPL43
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ead7a5c5-9aca-4e44-8014-08d58b2cffd2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2461;
x-ms-traffictypediagnostic: VI1PR0401MB2461:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR0401MB24617F8FCE6F3435B7375267ECD70@VI1PR0401MB2461.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0401MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2461;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(189003)(199004)(6512007)(6116002)(3846002)(65816011)(229853002)(106356001)(76176011)(36756003)(478600001)(6486002)(3280700002)(26005)(2950100002)(33656002)(3660700001)(2906002)(6246003)(53936002)(305945005)(7736002)(86362001)(2501003)(6436002)(68736007)(5660300001)(5250100002)(99286004)(8936002)(25786009)(110136005)(8676002)(54906003)(186003)(4326008)(59896002)(39060400002)(14454004)(105586002)(80316001)(97736004)(87266011)(81166006)(81156014)(6506007)(2900100001)(53546011)(316002)(102836004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2461;H:VI1PR0401MB1856.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: zrhjRmTmgx295BZeY1u2BKLg5qZ6nwJMvhxT2MRZJo0jdltF/Mz0Gjdwd6eiRYMRdXCWE/SdC7j6RGWcniiwyWNyUuBrSrXy05mtQOdXNr2K6nruuw0ACzBHSqpRck60pdWn8lv4mzHQ02VfbuEgmdLdQlZf8kcKnHjw6yt5gk+LOb4dxF6b2d1yaNRR52oVZhypaVAjOU8h+NSnoqSaXFTr4FQDqN2POO0C1Wbwq0jSjj9b/gHtuxJsLQEvOWxExQrTQtCJ5REfFD5t5kbc/apmAqOetrY6bJaJsZtUEGcRQXXOMZyVhnIxbwmiwg2PsHKcux+CyVySo5qN56w/4A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A3D6A751B4285A4784AE81B8159CEE61@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead7a5c5-9aca-4e44-8014-08d58b2cffd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 10:59:32.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2461
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594929162997388326?=
X-GMAIL-MSGID: =?utf-8?q?1595091689936279354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dan,

On 03/15/2018 12:56 PM, Dan Carpenter wrote:
> On Thu, Mar 15, 2018 at 12:44:37AM +0100, Andrew Lunn wrote:
>> On Wed, Mar 14, 2018 at 10:55:52AM -0500, Razvan Stefanescu wrote:
>>> This patchset introduces the Ethernet Switch Driver for Freescale/NXP S=
oCs
>>> with DPAA2 (DataPath Acceleration Architecture v2). The driver manages
>>> switch objects discovered on the fsl-mc bus. A description of the drive=
r
>>> can be found in the associated README file.
>>
>> Hi Greg
>>
>> This code has much better quality than the usual stuff in staging. I
>> see no reason not to merge it.
>
> Yeah.  It seems pretty decent.  Stuart, Laurentiu, care to comment?

Not sure on what you want us to comment ...

> Meanwhile, netdev and DaveM aren't even on the CC list and they're the
> ones to ultimately decide.

I think we'll post to netdev when we'll be done with the TODOs
and start moving the driver out of staging.

---
Best Regards, Laurentiu=
