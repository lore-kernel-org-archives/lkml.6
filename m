Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234113-2-17468374428857496552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234112; b=spKDxlAIiZGx1rw0BVCdkrIA7yWASxkxYfu7R+tFrGF5Ortpwz
    2TeIqrtrdLoWuO4I7rzFJXfa9H83pjLcp92c1Ww3ZUo/5RXaav4J/llo3042a1Na
    nnq+gJ1LL45a+d9mXcL/CNvgldmuiZ6dc+1OjXRokdqwSsYFrqxW7WyOjfg/jIwU
    bm8bM803rvXKF12NSuQGzc04qcJimJGkiJ7bOGMVOLKgTD+H2zi9vuIzXhM3SXna
    BH2FHcs81XSiDEzZVbaOC+Pb1hsKB6axWMj+jblWED5D1HbDOToQwYb7Q/AO6xiy
    jPL+/8zD1RXJtRRZAx6QnDaxYOuNyfOCF4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=fm2; t=1523234112; bh=+iVShSVtU7nxky8dR4pEzFxiWt04rP
    ze7sTp8aBw5aA=; b=YqcxdxM1bDdg9w7/BWk7GeiSVWrkCOYa/IK42gaaDTEGw3
    tJB+Y2rLWQjOCNzJBylip5GUO0W5fMlqrkMKfQuITnMHDKqAUemV81vO4ESlrt/7
    eDquKBKh3j07GHweiNTTbeKZG6JRHtX8XBWV9lzsl89S6Jsq/YCSadFxN5PTRhUl
    vSZ4qnotpLUfqtCAXOhOXC0oPCKdNfV2TCe6v+lFXt6Ay/a2D+/GfuwAs+wRrMjX
    kcmBjO+zkcjhfUrFyB0OFQX6dYFCeYG61wpMtkHIT6dkimNWfnrbfUXKIp5NkSnq
    3jDFWfJ6TGZqiEqRODMKshIZhDtPg7+Mi1Efr4Dg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IvRd9z/v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IvRd9z/v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO/ywDNziokzKNKw1JcAbx2YyfBcXpJfT7n2kJUyGrl8w+O+9l+4wb7Y0TAy69KagXgBoXTC/ZNjPNlOuLt2mvf8gIn42rk66+Z0+y9Rzte468BHfwmU
    6BQAP/qUdmRzw54MmWqewul4y1lUm7rNOi4HPrxdC8zAw/i6C5Zap4m12Lg2ENFIVhCDAV+eiXkwMM4fFh3iGRpG7BVHmHRFsKnJWUZf4lM11F9ZsRGL6Ex2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=2UbAlGgPxPRGm69PWGQA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeDIAfD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:03 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755749AbeDIAez (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 001/162] ALSA: timer: Wrap with spinlock for
 queue access
Thread-Topic: [PATCH AUTOSEL for 4.4 001/162] ALSA: timer: Wrap with spinlock
 for queue access
Thread-Index: AQHTz5mTWhlpLGoIg0G4qmZNvCIZig==
Date: Mon, 9 Apr 2018 00:27:43 +0000
Message-ID: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:jsG54npP6x4EprVyboGt7sLBnaoFim05JQ8rkhEbNvLB6jpHyZy1hwpisD86LP6N/7b52s1ARYgg6uBlixW9L56fIF1qEc6vRva8gzakqlxtrhVJwcVfaoVcn1Cou0TjGKOr2Bx3Lbk8Tuq1zojzaukbsMxyLgnBNe/WcE9v8hr6zhlIP3We5oXp5kRfDalX7HLauyYRv0CXlqB0+4Tb5yegReW6YRIhv4SjWvf8bTsNnt+EM5y5pm7wVlTv3Lrq;20:GWM48EPDFgrPvmWztxT9+XE/1D32uCcGlX+UyYuX+XbQbgmaW+z21MVCrcARzcjcAtE0xokJPUxDMQiYxW5myaDyHmmCrqHEqV+JiPQez7K/1AMgWOTFFsTD+1k5GGx2Sv+hs3LxO9+GlUnLOHOouSfXvromNvwDse0Zw+3LBU4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57023c30-f5a2-4821-abe1-08d59db1b418
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806C5CA20002BF330322DDBFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(575784001)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1lerAedPutPyPauqXF2sJhhkZq21WVhqKjNeJ7E8puaCTC3FHfVPnLdBafjn6q3Re6hlp2OrQmtDy4cy4dcrJ4CawvEesz6MQj7ndFlkC6qryMel8Y70o46/6guvtozBFxfSito8HBTiYDnYKgzBYDNAgzRpn6koEsMJdPwGAlmQdHQn7CMuBN7acm5OxtImcTShcoJAWBeTtbC8acvhnrBr45ON8SP3n5c0as5fGtncHU6ybeQnNJpQGwDEYYJ4n4nOdTzmGgnUPDdqoRhwJov7jzLnyLrCrPOXOVvMQft7V5HLC7jIkw33RwjmxKlcB8luciUzZHKE2BEoGaTekH1OH0BlT0QPJ+60BDR3th4z4YnSeK+/HjCTdkltg2r71BBM9EAYErcHEMVeJ/htXkha+X9vuB45M7zA4QPv64U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57023c30-f5a2-4821-abe1-08d59db1b418
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:43.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d7f910bfedd863d13ea320030fe98e42d0938ed5 ]

For accessing the snd_timer_user queue indices, we take tu->qlock.
But it's forgotten in a couple of places.

The one in snd_timer_user_params() should be safe without the
spinlock as the timer is already stopped.  But it's better for
consistency.

The one in poll is just a read-out, so it's not inevitably needed, but
it'd be good to make the result consistent, too.

Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/core/timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 48eaccba82a3..fd622aa0bb93 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1771,6 +1771,7 @@ static int snd_timer_user_params(struct file *file,
 			}
 		}
 	}
+	spin_lock_irq(&tu->qlock);
 	tu->qhead =3D tu->qtail =3D tu->qused =3D 0;
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
 		if (tu->tread) {
@@ -1791,6 +1792,7 @@ static int snd_timer_user_params(struct file *file,
 	}
 	tu->filter =3D params.filter;
 	tu->ticks =3D params.ticks;
+	spin_unlock_irq(&tu->qlock);
 	err =3D 0;
  _end:
 	if (copy_to_user(_params, &params, sizeof(params)))
@@ -2029,10 +2031,12 @@ static unsigned int snd_timer_user_poll(struct file=
 *file, poll_table * wait)
         poll_wait(file, &tu->qchange_sleep, wait);
=20
 	mask =3D 0;
+	spin_lock_irq(&tu->qlock);
 	if (tu->qused)
 		mask |=3D POLLIN | POLLRDNORM;
 	if (tu->disconnected)
 		mask |=3D POLLERR;
+	spin_unlock_irq(&tu->qlock);
=20
 	return mask;
 }
--=20
2.15.1
